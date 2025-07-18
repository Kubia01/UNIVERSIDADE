# Universidade Interlub - Sistema LMS

Sistema de Learning Management System (LMS) para treinamentos internos da empresa com 80 colaboradores.

## 🚀 Funcionalidades

- **Autenticação de usuários** com Supabase Auth
- **Dashboard** com lista de cursos disponíveis
- **Reprodução de vídeos** de treinamento
- **Controle de progresso** individual por usuário
- **Painel administrativo** para gerenciar cursos e usuários
- **Pesquisa e filtros** por categoria e nível
- **Design responsivo** e moderno

## 🛠️ Tecnologias Utilizadas

- **Next.js 14** - Framework React
- **TypeScript** - Tipagem estática
- **Tailwind CSS** - Estilização
- **Supabase** - Backend as a Service (Auth + Database)
- **Lucide React** - Ícones

## 📋 Pré-requisitos

- Node.js 18+ instalado
- Conta no Supabase
- Conta no Vercel (para deploy)

## 🔧 Configuração Local

### 1. Instalar dependências

```bash
npm install
```

### 2. Configurar Supabase

1. Acesse [Supabase](https://app.supabase.com)
2. Vá para seu projeto existente
3. Clique em "SQL Editor" no menu lateral
4. Cole e execute o código do arquivo `supabase-setup.sql`

### 3. Configurar variáveis de ambiente

O arquivo `.env.local` já está configurado com suas credenciais:

```env
NEXT_PUBLIC_SUPABASE_URL=https://syhslssfqzbthppprkau.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN5aHNsc3NmcXpidGhwcHBya2F1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE2NTQ1MzYsImV4cCI6MjA2NzIzMDUzNn0.KDoKpFB4dbJnD47NR_HF_aftqPdvaf5VwLJztu9DurM
```

### 4. Executar localmente

```bash
npm run dev
```

Acesse [http://localhost:3000](http://localhost:3000)

## 🌐 Deploy na Nuvem

### Opção 1: Vercel (Recomendado)

1. **Conectar ao GitHub**
   - Faça push do código para um repositório GitHub
   - Acesse [Vercel](https://vercel.com)
   - Importe o repositório

2. **Configurar variáveis de ambiente**
   - No painel do Vercel, vá em Settings > Environment Variables
   - Adicione as variáveis:
     - `NEXT_PUBLIC_SUPABASE_URL`
     - `NEXT_PUBLIC_SUPABASE_ANON_KEY`

3. **Deploy automático**
   - O Vercel fará o deploy automaticamente
   - Você receberá uma URL como: `https://seu-projeto.vercel.app`

### Opção 2: Netlify

1. **Conectar ao GitHub**
   - Faça push do código para um repositório GitHub
   - Acesse [Netlify](https://netlify.com)
   - Importe o repositório

2. **Configurar build settings**
   - Build command: `npm run build`
   - Publish directory: `.next`

3. **Configurar variáveis de ambiente**
   - No painel do Netlify, vá em Site settings > Environment variables
   - Adicione as mesmas variáveis do Supabase

### Opção 3: Railway

1. **Conectar ao GitHub**
   - Acesse [Railway](https://railway.app)
   - Conecte seu repositório GitHub

2. **Configurar variáveis de ambiente**
   - No painel do Railway, adicione as variáveis do Supabase

## 👥 Configuração de Usuários

### Criar Usuário Administrador

1. **No Supabase Dashboard:**
   - Vá para Authentication > Users
   - Clique em "Add user"
   - Preencha email e senha
   - Confirme o email

2. **Definir como Admin:**
   - Vá para Table Editor > profiles
   - Encontre o usuário criado
   - Altere o campo `role` para `admin`

### Adicionar Usuários da Empresa

**Opção 1: Convite por Email (Recomendado)**
```sql
-- Execute no SQL Editor do Supabase
INSERT INTO auth.users (email, encrypted_password, email_confirmed_at, created_at, updated_at)
VALUES 
  ('funcionario1@empresa.com', crypt('senha123', gen_salt('bf')), now(), now(), now()),
  ('funcionario2@empresa.com', crypt('senha123', gen_salt('bf')), now(), now(), now());
```

**Opção 2: Cadastro Manual**
- Cada funcionário acessa o sistema
- Clica em "Solicitar acesso ao administrador"
- Admin aprova no painel administrativo

## 📚 Adicionando Cursos

### Via Interface Admin

1. Faça login como administrador
2. Clique em "Admin" no header
3. Vá para "Cursos" > "Adicionar Curso"
4. Preencha as informações:
   - Título
   - Descrição
   - Categoria
   - Nível (Iniciante/Intermediário/Avançado)
   - Duração estimada

### Adicionando Vídeos

1. No painel admin, entre no curso
2. Clique em "Adicionar Vídeo"
3. Preencha:
   - Título do vídeo
   - Descrição
   - URL do vídeo (YouTube, Vimeo, etc.)
   - Duração
   - Ordem de exibição

## 🔒 Segurança

- **Row Level Security (RLS)** habilitado em todas as tabelas
- **Autenticação JWT** via Supabase
- **Políticas de acesso** baseadas em roles
- **Dados sensíveis** protegidos por variáveis de ambiente

## 📊 Monitoramento

### Métricas Disponíveis

- Total de usuários ativos
- Cursos mais assistidos
- Progresso médio por curso
- Tempo total de treinamento

### Acessar Métricas

1. **Supabase Dashboard:**
   - Analytics > Overview
   - Logs > Query logs

2. **Vercel Analytics:**
   - Ative o Vercel Analytics no projeto
   - Veja métricas de performance e uso

## 🔧 Manutenção

### Backup do Banco

```sql
-- Execute no SQL Editor do Supabase
-- Backup das tabelas principais
SELECT * FROM profiles;
SELECT * FROM courses;
SELECT * FROM videos;
SELECT * FROM user_progress;
```

### Atualizar Dependências

```bash
npm update
npm audit fix
```

### Logs de Erro

- **Vercel:** Function logs no painel
- **Supabase:** Logs no painel do projeto

## 🆘 Suporte

### Problemas Comuns

1. **Erro de autenticação:**
   - Verificar variáveis de ambiente
   - Confirmar configuração RLS no Supabase

2. **Vídeos não carregam:**
   - Verificar URLs dos vídeos
   - Confirmar domínios permitidos no next.config.js

3. **Deploy falha:**
   - Verificar logs de build
   - Confirmar todas as variáveis de ambiente

### Contato

Para suporte técnico, entre em contato com o administrador do sistema.

---

## 📱 Acesso dos Usuários

Após o deploy, compartilhe a URL do sistema com os 80 colaboradores:

**URL de Produção:** `https://seu-projeto.vercel.app`

**Instruções para os usuários:**
1. Acesse a URL fornecida
2. Faça login com email e senha fornecidos
3. Explore os cursos disponíveis
4. Clique em "Iniciar Curso" para começar
5. Seu progresso será salvo automaticamente

**Funcionalidades para usuários:**
- ✅ Login seguro
- ✅ Dashboard com todos os cursos
- ✅ Pesquisa e filtros
- ✅ Reprodução de vídeos
- ✅ Controle de progresso
- ✅ Interface responsiva (mobile/desktop)

O sistema está pronto para uso imediato pelos 80 colaboradores da empresa!