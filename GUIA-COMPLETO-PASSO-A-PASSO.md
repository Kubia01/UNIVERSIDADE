# 🎓 GUIA COMPLETO PASSO A PASSO - Sistema Universidade Interlub

## 📋 ANTES DE COMEÇAR

**Tempo estimado**: 30-45 minutos
**Nível**: Iniciante (sem conhecimento técnico necessário)
**Custo**: Gratuito (planos gratuitos)

### O que você vai precisar:
- [ ] Computador com internet
- [ ] Email válido
- [ ] Conta no Supabase (já tem)
- [ ] Conta no GitHub (vamos criar se não tiver)
- [ ] Conta no Vercel (vamos criar)

---

## 🔧 PASSO 1: PREPARAR O CÓDIGO (5 minutos)

### 1.1 Criar conta no GitHub (se não tiver)
1. Acesse: https://github.com
2. Clique em **"Sign up"** (no canto superior direito)
3. Preencha:
   - **Username**: escolha um nome (ex: `seunome-interlub`)
   - **Email**: seu email
   - **Password**: uma senha forte
4. Clique em **"Create account"**
5. Verifique seu email e confirme a conta

### 1.2 Criar repositório no GitHub
1. Após fazer login no GitHub, clique no **"+"** no canto superior direito
2. Selecione **"New repository"**
3. Preencha:
   - **Repository name**: `universidade-interlub-lms`
   - **Description**: `Sistema LMS para treinamentos internos`
   - Marque **"Public"** 
   - Marque **"Add a README file"**
4. Clique em **"Create repository"**

### 1.3 Subir o código para o GitHub
1. Na página do seu repositório, clique em **"uploading an existing file"**
2. **Arraste TODOS os arquivos** da pasta do projeto para a área de upload
   - Certifique-se de incluir TODOS os arquivos e pastas
   - Incluindo arquivos ocultos como `.env.local`
3. Na parte inferior, escreva:
   - **Commit message**: `Sistema LMS Universidade Interlub completo`
4. Clique em **"Commit changes"**

---

## 🗄️ PASSO 2: CONFIGURAR BANCO DE DADOS (10 minutos)

### 2.1 Acessar o Supabase
1. Acesse: https://app.supabase.com
2. Faça login com sua conta
3. Clique no seu projeto existente (deve aparecer na lista)

### 2.2 Executar script do banco
1. No painel do Supabase, procure no menu lateral esquerdo por **"SQL Editor"**
2. Clique em **"SQL Editor"**
3. Clique em **"New query"** (botão verde)
4. **COPIE TODO O CÓDIGO** do arquivo `supabase-setup.sql` e cole na área de texto
5. Clique em **"Run"** (botão azul no canto inferior direito)
6. **AGUARDE** - pode demorar 30-60 segundos
7. Se aparecer **"Success. No rows returned"**, está correto!

### 2.3 Criar usuário administrador
1. No menu lateral esquerdo, clique em **"Authentication"**
2. Clique em **"Users"**
3. Clique em **"Add user"** (botão verde)
4. Preencha:
   - **Email**: `admin@interlub.com` (ou seu email preferido)
   - **Password**: `admin123` (ou senha de sua preferência)
   - **Marque a caixa** "Email confirmed"
5. Clique em **"Create user"**

### 2.4 Definir usuário como administrador
1. No menu lateral esquerdo, clique em **"Table Editor"**
2. Clique na tabela **"profiles"**
3. Encontre a linha com o email do administrador que você criou
4. Na coluna **"role"**, clique e altere de `user` para `admin`
5. Pressione **Enter** para salvar

---

## 🚀 PASSO 3: FAZER DEPLOY NO VERCEL (10 minutos)

### 3.1 Criar conta no Vercel
1. Acesse: https://vercel.com
2. Clique em **"Sign Up"**
3. Clique em **"Continue with GitHub"**
4. Autorize o Vercel a acessar sua conta GitHub
5. Preencha as informações solicitadas

### 3.2 Conectar repositório
1. No painel do Vercel, clique em **"New Project"**
2. Procure pelo repositório `universidade-interlub-lms`
3. Clique em **"Import"** ao lado do repositório

### 3.3 Configurar o projeto
1. Na tela de configuração:
   - **Project Name**: deixe como está
   - **Framework Preset**: deve detectar automaticamente "Next.js"
   - **Root Directory**: deixe como está
   - **Build Command**: deixe como está
   - **Output Directory**: deixe como está

### 3.4 Configurar variáveis de ambiente
1. Clique em **"Environment Variables"**
2. Adicione a primeira variável:
   - **Name**: `NEXT_PUBLIC_SUPABASE_URL`
   - **Value**: `https://syhslssfqzbthppprkau.supabase.co`
   - Clique em **"Add"**
3. Adicione a segunda variável:
   - **Name**: `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - **Value**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN5aHNsc3NmcXpidGhwcHBya2F1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE2NTQ1MzYsImV4cCI6MjA2NzIzMDUzNn0.KDoKpFB4dbJnD47NR_HF_aftqPdvaf5VwLJztu9DurM`
   - Clique em **"Add"**

### 3.5 Fazer deploy
1. Clique em **"Deploy"**
2. **AGUARDE** - pode demorar 2-5 minutos
3. Quando aparecer **"Congratulations!"**, clique em **"Visit"**
4. **ANOTE A URL** que aparece (ex: `https://universidade-interlub-lms.vercel.app`)

---

## ✅ PASSO 4: TESTAR O SISTEMA (5 minutos)

### 4.1 Primeiro teste
1. Acesse a URL do seu sistema
2. Você deve ver uma tela de login
3. Faça login com:
   - **Email**: `admin@interlub.com` (ou o que você criou)
   - **Senha**: `admin123` (ou a que você criou)
4. Se entrar no dashboard, **PARABÉNS!** Está funcionando!

### 4.2 Adicionar dados de exemplo (opcional)
1. Volte ao Supabase: https://app.supabase.com
2. Vá em **"SQL Editor"**
3. Clique em **"New query"**
4. Copie o código do arquivo `dados-exemplo.sql`
5. **IMPORTANTE**: Substitua `UUID_DO_ADMIN` pelo ID real do admin:
   - Vá em **"Authentication"** > **"Users"**
   - Copie o **ID** do usuário admin
   - Cole no lugar de `UUID_DO_ADMIN` no código
6. Execute o código clicando em **"Run"**

---

## 👥 PASSO 5: ADICIONAR OS 80 COLABORADORES (15 minutos)

### 5.1 Método Rápido - Criar usuários em lote
1. No Supabase, vá em **"SQL Editor"**
2. Clique em **"New query"**
3. Use este código como exemplo (substitua pelos emails reais):

```sql
INSERT INTO auth.users (
  instance_id, id, aud, role, email, encrypted_password, 
  email_confirmed_at, created_at, updated_at, raw_app_meta_data, 
  raw_user_meta_data, is_super_admin, confirmation_token, 
  email_change, email_change_token_new, recovery_token
) VALUES 
(
  '00000000-0000-0000-0000-000000000000',
  gen_random_uuid(),
  'authenticated',
  'authenticated',
  'funcionario1@empresa.com',
  crypt('senha123', gen_salt('bf')),
  NOW(), NOW(), NOW(),
  '{"provider":"email","providers":["email"]}',
  '{"full_name":"Nome do Funcionário 1"}',
  FALSE, '', '', '', ''
),
(
  '00000000-0000-0000-0000-000000000000',
  gen_random_uuid(),
  'authenticated',
  'authenticated',
  'funcionario2@empresa.com',
  crypt('senha123', gen_salt('bf')),
  NOW(), NOW(), NOW(),
  '{"provider":"email","providers":["email"]}',
  '{"full_name":"Nome do Funcionário 2"}',
  FALSE, '', '', '', ''
);
-- Adicione mais usuários copiando o bloco acima
```

4. **Substitua**:
   - `funcionario1@empresa.com` pelos emails reais
   - `Nome do Funcionário 1` pelos nomes reais
   - Repita para os 80 funcionários
5. Execute o código

### 5.2 Método Manual - Um por vez
1. No Supabase, vá em **"Authentication"** > **"Users"**
2. Para cada funcionário:
   - Clique em **"Add user"**
   - Email: email do funcionário
   - Password: `senha123` (ou outra padrão)
   - Marque **"Email confirmed"**
   - Clique em **"Create user"**
3. Repita para os 80 funcionários

---

## 📚 PASSO 6: ADICIONAR CURSOS (10 minutos)

### 6.1 Via interface administrativa
1. Acesse seu sistema como admin
2. Clique em **"Admin"** no header
3. Clique em **"Cursos"**
4. Clique em **"Adicionar Curso"**
5. Preencha:
   - **Título**: "Introdução à Segurança no Trabalho"
   - **Descrição**: "Curso básico sobre segurança"
   - **Categoria**: "Segurança"
   - **Nível**: "Iniciante"
   - **Duração**: 120 (minutos)
6. Marque **"Publicado"**
7. Clique em **"Salvar"**

### 6.2 Adicionar vídeos ao curso
1. Entre no curso criado
2. Clique em **"Adicionar Vídeo"**
3. Preencha:
   - **Título**: "Introdução ao curso"
   - **Descrição**: "Apresentação inicial"
   - **URL do vídeo**: Link do YouTube/Vimeo
   - **Duração**: 15 (minutos)
   - **Ordem**: 1
4. Clique em **"Salvar"**
5. Repita para mais vídeos

---

## 📱 PASSO 7: COMPARTILHAR COM OS COLABORADORES (5 minutos)

### 7.1 Preparar instruções
Envie esta mensagem para todos os funcionários:

---

🎓 **Bem-vindos à Universidade Interlub!**

Nosso novo sistema de treinamentos está no ar!

**🔗 Acesse:** [SUA_URL_AQUI]

**👤 Suas credenciais:**
- Email: [email-do-funcionario@empresa.com]
- Senha: senha123

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
Entre em contato com [SEU_CONTATO]

---

### 7.2 Teste com alguns usuários
1. Peça para 2-3 funcionários testarem primeiro
2. Verifique se conseguem fazer login
3. Confirme se os cursos aparecem
4. Ajuste qualquer problema antes de liberar para todos

---

## 🔍 PASSO 8: VERIFICAÇÕES FINAIS (5 minutos)

### 8.1 Checklist de funcionamento
- [ ] Sistema carrega na URL
- [ ] Login do admin funciona
- [ ] Dashboard mostra cursos
- [ ] Login de usuário comum funciona
- [ ] Vídeos carregam corretamente
- [ ] Progresso é salvo

### 8.2 Monitoramento
1. **Supabase Dashboard**: https://app.supabase.com
   - Monitore usuários ativos
   - Verifique logs de erro
2. **Vercel Dashboard**: https://vercel.com/dashboard
   - Monitore performance
   - Verifique logs de acesso

---

## 🆘 PROBLEMAS COMUNS E SOLUÇÕES

### ❌ Erro: "Site não carrega"
**Solução:**
1. Verifique se o deploy no Vercel terminou
2. Aguarde alguns minutos
3. Limpe o cache do navegador (Ctrl+F5)

### ❌ Erro: "Não consegue fazer login"
**Solução:**
1. Verifique se as variáveis de ambiente estão corretas no Vercel
2. Confirme se o usuário foi criado no Supabase
3. Verifique se marcou "Email confirmed"

### ❌ Erro: "Cursos não aparecem"
**Solução:**
1. Verifique se os cursos estão marcados como "publicados"
2. Confirme se o script do banco foi executado corretamente
3. Verifique as políticas RLS no Supabase

### ❌ Erro: "Vídeos não carregam"
**Solução:**
1. Verifique se as URLs dos vídeos estão corretas
2. Confirme se os vídeos são públicos
3. Teste com vídeos do YouTube primeiro

---

## 📊 INFORMAÇÕES IMPORTANTES

### 🔑 Credenciais importantes
- **Admin**: admin@interlub.com / admin123
- **Usuários**: [email] / senha123
- **Supabase**: https://app.supabase.com
- **Vercel**: https://vercel.com/dashboard
- **Sistema**: [SUA_URL_VERCEL]

### 💰 Custos
- **Atual**: $0/mês (planos gratuitos)
- **Limites gratuitos**:
  - Supabase: 50.000 usuários/mês, 500MB storage
  - Vercel: 100GB bandwidth/mês
- **Se precisar expandir**: ~$45/mês

### 📈 Capacidade
- **Usuários simultâneos**: 1000+
- **Cursos**: Ilimitados
- **Vídeos**: Ilimitados
- **Armazenamento**: 500MB inicial

---

## 🎉 PARABÉNS!

**Seu sistema está no ar!** 

Os 80 colaboradores agora podem acessar:
- ✅ Sistema profissional de treinamentos
- ✅ Interface moderna e responsiva
- ✅ Cursos organizados por categoria
- ✅ Progresso individual salvo
- ✅ Acesso via web (computador/mobile)

### 📞 Suporte
- **Logs de erro**: Supabase > Logs
- **Performance**: Vercel > Analytics
- **Backup**: Automático no Supabase
- **Atualizações**: Automáticas via GitHub

**Seu sistema de "Universidade" está funcionando!** 🚀

---

## 📝 PRÓXIMOS PASSOS (OPCIONAL)

1. **Adicionar mais cursos** conforme necessário
2. **Coletar feedback** dos usuários
3. **Monitorar uso** via dashboards
4. **Expandir funcionalidades** se necessário

**O sistema está pronto para transformar o treinamento na sua empresa!**