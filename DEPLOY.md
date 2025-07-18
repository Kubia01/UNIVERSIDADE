# 🚀 Guia Rápido de Deploy - Universidade Interlub LMS

## Passo a Passo para Colocar o Sistema no Ar

### 1. 📋 Configurar Banco de Dados (Supabase)

1. **Acesse o Supabase**: https://app.supabase.com
2. **Vá para seu projeto existente**
3. **Clique em "SQL Editor"** no menu lateral
4. **Cole e execute** todo o código do arquivo `supabase-setup.sql`
5. **Aguarde a execução** (pode demorar alguns segundos)

### 2. 👤 Criar Usuário Administrador

1. **No Supabase**, vá para **Authentication > Users**
2. **Clique em "Add user"**
3. **Preencha**:
   - Email: `admin@interlub.com` (ou seu email)
   - Password: `admin123` (ou senha segura)
4. **Marque "Email confirmed"**
5. **Clique em "Create user"**

6. **Definir como Admin**:
   - Vá para **Table Editor > profiles**
   - Encontre o usuário criado
   - **Altere o campo `role` para `admin`**
   - Clique em "Save"

### 3. 🌐 Deploy no Vercel (Recomendado)

#### Opção A: Deploy via GitHub (Mais Fácil)

1. **Subir para GitHub**:
   ```bash
   git init
   git add .
   git commit -m "Initial commit - Universidade Interlub LMS"
   git branch -M main
   git remote add origin https://github.com/SEU_USUARIO/universidade-interlub-lms.git
   git push -u origin main
   ```

2. **Deploy no Vercel**:
   - Acesse: https://vercel.com
   - Clique em "New Project"
   - Importe o repositório do GitHub
   - **Configure as variáveis de ambiente**:
     - `NEXT_PUBLIC_SUPABASE_URL`: `https://syhslssfqzbthppprkau.supabase.co`
     - `NEXT_PUBLIC_SUPABASE_ANON_KEY`: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN5aHNsc3NmcXpidGhwcHBya2F1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE2NTQ1MzYsImV4cCI6MjA2NzIzMDUzNn0.KDoKpFB4dbJnD47NR_HF_aftqPdvaf5VwLJztu9DurM`
   - Clique em "Deploy"

#### Opção B: Deploy via CLI do Vercel

1. **Instalar CLI do Vercel**:
   ```bash
   npm i -g vercel
   ```

2. **Fazer login**:
   ```bash
   vercel login
   ```

3. **Deploy**:
   ```bash
   vercel --prod
   ```

4. **Configurar variáveis de ambiente**:
   ```bash
   vercel env add NEXT_PUBLIC_SUPABASE_URL
   vercel env add NEXT_PUBLIC_SUPABASE_ANON_KEY
   ```

### 4. 📚 Adicionar Cursos de Exemplo

1. **Acesse o sistema** com o usuário admin
2. **Clique em "Admin"** no header
3. **Adicione alguns cursos**:
   - "Introdução à Segurança no Trabalho"
   - "Gestão de Projetos"
   - "Comunicação Eficaz"
   - "Uso de EPIs"
   - "Primeiros Socorros"

### 5. 👥 Criar Usuários dos Colaboradores

#### Opção A: Criação Manual (Recomendado para poucos usuários)

1. **No Supabase**, vá para **Authentication > Users**
2. **Para cada colaborador**, clique em "Add user"
3. **Preencha**:
   - Email: email do funcionário
   - Password: senha temporária
   - Marque "Email confirmed"
4. **Envie as credenciais** para cada funcionário

#### Opção B: Criação em Lote (Para muitos usuários)

1. **No Supabase**, vá para **SQL Editor**
2. **Execute este código** (ajuste os emails):

```sql
-- Criar usuários em lote
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
    'funcionario1@empresa.com',
    crypt('senha123', gen_salt('bf')),
    NOW(),
    NOW(),
    NOW(),
    '{"provider":"email","providers":["email"]}',
    '{}',
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
    'funcionario2@empresa.com',
    crypt('senha123', gen_salt('bf')),
    NOW(),
    NOW(),
    NOW(),
    '{"provider":"email","providers":["email"]}',
    '{}',
    FALSE,
    '',
    '',
    '',
    ''
  );
-- Adicione mais usuários conforme necessário
```

### 6. ✅ Teste Final

1. **Acesse a URL do sistema** (ex: https://seu-projeto.vercel.app)
2. **Teste o login** com o usuário admin
3. **Verifique se os cursos aparecem**
4. **Teste com um usuário comum**
5. **Compartilhe a URL** com os 80 colaboradores

### 7. 📱 Instruções para os Colaboradores

**Envie esta mensagem para todos os funcionários:**

---

🎓 **Bem-vindos à Universidade Interlub!**

Nosso novo sistema de treinamentos está no ar!

**🔗 Acesse:** https://seu-projeto.vercel.app

**👤 Suas credenciais:**
- Email: [seu-email@empresa.com]
- Senha: [senha-temporária]

**📋 Como usar:**
1. Acesse o link acima
2. Faça login com suas credenciais
3. Explore os cursos disponíveis
4. Clique em "Iniciar Curso" para começar
5. Seu progresso será salvo automaticamente

**📱 Funciona em:**
- Computador
- Tablet
- Celular

**❓ Dúvidas?**
Entre em contato com o administrador do sistema.

---

### 🎯 Resumo dos URLs Importantes

- **Sistema LMS**: https://seu-projeto.vercel.app
- **Supabase Dashboard**: https://app.supabase.com
- **Vercel Dashboard**: https://vercel.com/dashboard

### 🔧 Próximos Passos

1. **Adicionar mais cursos** conforme necessário
2. **Monitorar o uso** via dashboards
3. **Coletar feedback** dos usuários
4. **Expandir funcionalidades** se necessário

**🚀 Seu sistema está pronto para uso pelos 80 colaboradores!**