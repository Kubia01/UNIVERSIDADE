-- Dados de exemplo para testar o sistema Universidade Interlub LMS
-- Execute este código APÓS configurar o banco e criar o usuário admin

-- IMPORTANTE: Substitua 'UUID_DO_ADMIN' pelo UUID real do seu usuário admin
-- Para descobrir o UUID, vá no Supabase > Authentication > Users e copie o ID

-- 1. Inserir cursos de exemplo
INSERT INTO courses (title, description, category, duration, level, is_published, created_by) VALUES
(
  'Introdução à Segurança no Trabalho',
  'Curso fundamental sobre normas de segurança, prevenção de acidentes e uso correto de equipamentos de proteção individual (EPIs). Essencial para todos os colaboradores.',
  'Segurança',
  120,
  'beginner',
  true,
  'UUID_DO_ADMIN'
),
(
  'Gestão de Projetos Ágeis',
  'Metodologias ágeis como Scrum e Kanban aplicadas ao ambiente corporativo. Aprenda a gerenciar projetos de forma eficiente e colaborativa.',
  'Gestão',
  180,
  'intermediate',
  true,
  'UUID_DO_ADMIN'
),
(
  'Comunicação Eficaz no Ambiente Corporativo',
  'Técnicas de comunicação interpessoal, apresentações impactantes e reuniões produtivas. Desenvolva suas soft skills.',
  'Soft Skills',
  90,
  'beginner',
  true,
  'UUID_DO_ADMIN'
),
(
  'Uso e Manutenção de EPIs',
  'Treinamento específico sobre equipamentos de proteção individual: tipos, uso correto, manutenção e substituição.',
  'Segurança',
  60,
  'beginner',
  true,
  'UUID_DO_ADMIN'
),
(
  'Primeiros Socorros no Trabalho',
  'Procedimentos básicos de primeiros socorros, situações de emergência e como agir em acidentes de trabalho.',
  'Segurança',
  150,
  'intermediate',
  true,
  'UUID_DO_ADMIN'
),
(
  'Liderança e Motivação de Equipes',
  'Desenvolva habilidades de liderança, aprenda a motivar equipes e criar um ambiente de trabalho positivo.',
  'Gestão',
  200,
  'advanced',
  true,
  'UUID_DO_ADMIN'
),
(
  'Tecnologia e Inovação',
  'Tendências tecnológicas, transformação digital e como aplicar inovação no dia a dia corporativo.',
  'Tecnologia',
  160,
  'intermediate',
  true,
  'UUID_DO_ADMIN'
),
(
  'Atendimento ao Cliente Excelente',
  'Técnicas de atendimento, resolução de conflitos e como criar experiências positivas para os clientes.',
  'Atendimento',
  110,
  'beginner',
  true,
  'UUID_DO_ADMIN'
);

-- 2. Inserir vídeos de exemplo para alguns cursos
-- IMPORTANTE: Substitua os IDs dos cursos pelos IDs reais após a inserção

-- Vídeos para "Introdução à Segurança no Trabalho"
INSERT INTO videos (course_id, title, description, video_url, duration, order_index) VALUES
(
  (SELECT id FROM courses WHERE title = 'Introdução à Segurança no Trabalho' LIMIT 1),
  'Boas-vindas e Introdução',
  'Apresentação do curso e importância da segurança no trabalho',
  'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  15,
  1
),
(
  (SELECT id FROM courses WHERE title = 'Introdução à Segurança no Trabalho' LIMIT 1),
  'Normas Regulamentadoras (NRs)',
  'Principais normas de segurança e suas aplicações',
  'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  30,
  2
),
(
  (SELECT id FROM courses WHERE title = 'Introdução à Segurança no Trabalho' LIMIT 1),
  'Equipamentos de Proteção Individual',
  'Tipos de EPIs e como utilizá-los corretamente',
  'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  45,
  3
),
(
  (SELECT id FROM courses WHERE title = 'Introdução à Segurança no Trabalho' LIMIT 1),
  'Prevenção de Acidentes',
  'Como identificar e prevenir situações de risco',
  'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  30,
  4
);

-- Vídeos para "Comunicação Eficaz no Ambiente Corporativo"
INSERT INTO videos (course_id, title, description, video_url, duration, order_index) VALUES
(
  (SELECT id FROM courses WHERE title = 'Comunicação Eficaz no Ambiente Corporativo' LIMIT 1),
  'Fundamentos da Comunicação',
  'Princípios básicos da comunicação eficaz',
  'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  20,
  1
),
(
  (SELECT id FROM courses WHERE title = 'Comunicação Eficaz no Ambiente Corporativo' LIMIT 1),
  'Comunicação Verbal e Não-Verbal',
  'A importância da linguagem corporal e tom de voz',
  'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  25,
  2
),
(
  (SELECT id FROM courses WHERE title = 'Comunicação Eficaz no Ambiente Corporativo' LIMIT 1),
  'Apresentações Impactantes',
  'Como criar e apresentar slides de forma eficaz',
  'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  30,
  3
),
(
  (SELECT id FROM courses WHERE title = 'Comunicação Eficaz no Ambiente Corporativo' LIMIT 1),
  'Reuniões Produtivas',
  'Técnicas para conduzir reuniões eficientes',
  'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  15,
  4
);

-- 3. Inserir alguns usuários de exemplo (opcional)
-- IMPORTANTE: Ajuste os emails para emails reais da sua empresa

-- Usuários de exemplo
INSERT INTO auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  created_at,
  updated_at,
  raw_app_meta_data,
  raw_user_meta_data,
  is_super_admin,
  confirmation_token,
  email_change,
  email_change_token_new,
  recovery_token
) VALUES 
(
  '00000000-0000-0000-0000-000000000000',
  gen_random_uuid(),
  'authenticated',
  'authenticated',
  'joao.silva@interlub.com',
  crypt('senha123', gen_salt('bf')),
  NOW(),
  NOW(),
  NOW(),
  '{"provider":"email","providers":["email"]}',
  '{"full_name":"João Silva"}',
  FALSE,
  '',
  '',
  '',
  ''
),
(
  '00000000-0000-0000-0000-000000000000',
  gen_random_uuid(),
  'authenticated',
  'authenticated',
  'maria.santos@interlub.com',
  crypt('senha123', gen_salt('bf')),
  NOW(),
  NOW(),
  NOW(),
  '{"provider":"email","providers":["email"]}',
  '{"full_name":"Maria Santos"}',
  FALSE,
  '',
  '',
  '',
  ''
),
(
  '00000000-0000-0000-0000-000000000000',
  gen_random_uuid(),
  'authenticated',
  'authenticated',
  'pedro.oliveira@interlub.com',
  crypt('senha123', gen_salt('bf')),
  NOW(),
  NOW(),
  NOW(),
  '{"provider":"email","providers":["email"]}',
  '{"full_name":"Pedro Oliveira"}',
  FALSE,
  '',
  '',
  '',
  ''
);

-- 4. Inserir alguns progressos de exemplo
-- Isso simulará que alguns usuários já começaram alguns cursos

-- Progresso do João Silva
INSERT INTO user_progress (user_id, course_id, video_id, completed, progress_percentage, last_watched_at) VALUES
(
  (SELECT id FROM auth.users WHERE email = 'joao.silva@interlub.com' LIMIT 1),
  (SELECT id FROM courses WHERE title = 'Introdução à Segurança no Trabalho' LIMIT 1),
  (SELECT id FROM videos WHERE title = 'Boas-vindas e Introdução' LIMIT 1),
  true,
  100,
  NOW() - INTERVAL '2 days'
),
(
  (SELECT id FROM auth.users WHERE email = 'joao.silva@interlub.com' LIMIT 1),
  (SELECT id FROM courses WHERE title = 'Introdução à Segurança no Trabalho' LIMIT 1),
  (SELECT id FROM videos WHERE title = 'Normas Regulamentadoras (NRs)' LIMIT 1),
  false,
  65,
  NOW() - INTERVAL '1 day'
);

-- Progresso da Maria Santos
INSERT INTO user_progress (user_id, course_id, video_id, completed, progress_percentage, last_watched_at) VALUES
(
  (SELECT id FROM auth.users WHERE email = 'maria.santos@interlub.com' LIMIT 1),
  (SELECT id FROM courses WHERE title = 'Comunicação Eficaz no Ambiente Corporativo' LIMIT 1),
  (SELECT id FROM videos WHERE title = 'Fundamentos da Comunicação' LIMIT 1),
  true,
  100,
  NOW() - INTERVAL '3 days'
),
(
  (SELECT id FROM auth.users WHERE email = 'maria.santos@interlub.com' LIMIT 1),
  (SELECT id FROM courses WHERE title = 'Comunicação Eficaz no Ambiente Corporativo' LIMIT 1),
  (SELECT id FROM videos WHERE title = 'Comunicação Verbal e Não-Verbal' LIMIT 1),
  true,
  100,
  NOW() - INTERVAL '2 days'
);

-- INSTRUÇÕES PARA USO:
-- 1. Execute primeiro o arquivo 'supabase-setup.sql'
-- 2. Crie o usuário admin no Supabase
-- 3. Substitua 'UUID_DO_ADMIN' pelo UUID real do admin
-- 4. Execute este arquivo no SQL Editor do Supabase
-- 5. Teste o sistema acessando com os usuários criados

-- CREDENCIAIS DE TESTE:
-- Admin: admin@interlub.com / admin123
-- Usuário 1: joao.silva@interlub.com / senha123
-- Usuário 2: maria.santos@interlub.com / senha123
-- Usuário 3: pedro.oliveira@interlub.com / senha123

-- NOTA: Os links de vídeo são exemplos. Substitua por URLs reais dos seus vídeos de treinamento.