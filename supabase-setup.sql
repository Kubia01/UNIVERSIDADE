-- Configuração do banco de dados para o sistema LMS Universidade Interlub

-- 1. Criar tabela de perfis de usuário
CREATE TABLE profiles (
    id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    full_name TEXT,
    avatar_url TEXT,
    role TEXT DEFAULT 'user' CHECK (role IN ('admin', 'user')),
    department TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Criar tabela de cursos
CREATE TABLE courses (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    thumbnail_url TEXT,
    category TEXT,
    duration INTEGER, -- em minutos
    level TEXT DEFAULT 'beginner' CHECK (level IN ('beginner', 'intermediate', 'advanced')),
    is_published BOOLEAN DEFAULT false,
    created_by UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Criar tabela de vídeos
CREATE TABLE videos (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    video_url TEXT NOT NULL,
    duration INTEGER, -- em minutos
    order_index INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Criar tabela de progresso do usuário
CREATE TABLE user_progress (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    course_id UUID REFERENCES courses(id) ON DELETE CASCADE,
    video_id UUID REFERENCES videos(id) ON DELETE CASCADE,
    completed BOOLEAN DEFAULT false,
    progress_percentage INTEGER DEFAULT 0,
    last_watched_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, course_id, video_id)
);

-- 5. Criar função para atualizar updated_at automaticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 6. Criar triggers para atualizar updated_at
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_courses_updated_at BEFORE UPDATE ON courses
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_videos_updated_at BEFORE UPDATE ON videos
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_user_progress_updated_at BEFORE UPDATE ON user_progress
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- 7. Criar função para criar perfil automaticamente quando usuário se registra
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, email, full_name)
    VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data->>'full_name');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 8. Criar trigger para criar perfil automaticamente
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- 9. Configurar Row Level Security (RLS)
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE videos ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_progress ENABLE ROW LEVEL SECURITY;

-- 10. Criar políticas de segurança

-- Políticas para profiles
CREATE POLICY "Users can view their own profile" ON profiles
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile" ON profiles
    FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Admins can view all profiles" ON profiles
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM profiles 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Políticas para courses
CREATE POLICY "Published courses are viewable by all authenticated users" ON courses
    FOR SELECT USING (is_published = true AND auth.role() = 'authenticated');

CREATE POLICY "Admins can manage all courses" ON courses
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM profiles 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Políticas para videos
CREATE POLICY "Videos of published courses are viewable by all authenticated users" ON videos
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM courses 
            WHERE id = videos.course_id AND is_published = true
        ) AND auth.role() = 'authenticated'
    );

CREATE POLICY "Admins can manage all videos" ON videos
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM profiles 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- Políticas para user_progress
CREATE POLICY "Users can view their own progress" ON user_progress
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own progress" ON user_progress
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own progress" ON user_progress
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Admins can view all progress" ON user_progress
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM profiles 
            WHERE id = auth.uid() AND role = 'admin'
        )
    );

-- 11. Inserir dados de exemplo (opcional)
-- Primeiro, você precisa criar um usuário admin manualmente no Supabase Auth
-- Depois, você pode executar:

-- INSERT INTO courses (title, description, category, duration, level, is_published, created_by) VALUES
-- ('Introdução à Segurança no Trabalho', 'Curso básico sobre normas de segurança no ambiente de trabalho', 'Segurança', 120, 'beginner', true, 'UUID_DO_ADMIN'),
-- ('Gestão de Projetos', 'Metodologias ágeis e tradicionais de gestão de projetos', 'Gestão', 180, 'intermediate', true, 'UUID_DO_ADMIN'),
-- ('Comunicação Eficaz', 'Técnicas de comunicação interpessoal e apresentações', 'Soft Skills', 90, 'beginner', true, 'UUID_DO_ADMIN');

-- INSTRUÇÕES PARA CONFIGURAR NO SUPABASE:
-- 1. Acesse o painel do Supabase (https://app.supabase.com)
-- 2. Vá para seu projeto
-- 3. Clique em "SQL Editor" no menu lateral
-- 4. Cole este código SQL e execute
-- 5. Vá para "Authentication" > "Users" e crie um usuário admin
-- 6. Na tabela "profiles", atualize o role do usuário para 'admin'