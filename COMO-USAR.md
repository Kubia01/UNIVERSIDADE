# 🎓 Como Usar o Sistema Universidade Interlub

## ✅ Checklist Rápido

### 1. Configurar Banco de Dados
- [ ] Acessar [Supabase](https://app.supabase.com)
- [ ] Ir para SQL Editor
- [ ] Executar código do arquivo `supabase-setup.sql`

### 2. Criar Admin
- [ ] Authentication > Users > Add user
- [ ] Email: `admin@interlub.com`, Senha: `admin123`
- [ ] Table Editor > profiles > Alterar role para `admin`

### 3. Deploy
- [ ] Subir código para GitHub
- [ ] Conectar no [Vercel](https://vercel.com)
- [ ] Configurar variáveis de ambiente

### 4. Testar
- [ ] Acessar URL do sistema
- [ ] Fazer login como admin
- [ ] Adicionar cursos de teste

## 🚀 Deploy Rápido

```bash
# 1. Preparar código
git init
git add .
git commit -m "Sistema LMS Universidade Interlub"

# 2. Subir para GitHub
git remote add origin https://github.com/SEU_USUARIO/universidade-interlub-lms.git
git push -u origin main

# 3. Deploy no Vercel
# Acesse vercel.com, importe o repositório
# Configure as variáveis de ambiente
```

## 📋 Variáveis de Ambiente

```env
NEXT_PUBLIC_SUPABASE_URL=https://syhslssfqzbthppprkau.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN5aHNsc3NmcXpidGhwcHBya2F1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE2NTQ1MzYsImV4cCI6MjA2NzIzMDUzNn0.KDoKpFB4dbJnD47NR_HF_aftqPdvaf5VwLJztu9DurM
```

## 👥 Adicionar Usuários

### Método 1: Interface do Supabase
1. Authentication > Users > Add user
2. Preencher email e senha
3. Marcar "Email confirmed"

### Método 2: SQL em Lote
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
  'funcionario@empresa.com',
  crypt('senha123', gen_salt('bf')),
  NOW(), NOW(), NOW(),
  '{"provider":"email","providers":["email"]}',
  '{"full_name":"Nome do Funcionário"}',
  FALSE, '', '', '', ''
);
```

## 📚 Adicionar Cursos

### Via Interface (Recomendado)
1. Login como admin
2. Botão "Admin" no header
3. Criar cursos e adicionar vídeos

### Via SQL (Dados de Exemplo)
Use o arquivo `dados-exemplo.sql` para inserir cursos de teste.

## 🔧 Comandos Úteis

```bash
# Instalar dependências
npm install

# Executar localmente
npm run dev

# Build para produção
npm run build

# Executar em produção
npm start
```

## 📱 URLs Importantes

- **Supabase Dashboard**: https://app.supabase.com
- **Vercel Dashboard**: https://vercel.com/dashboard
- **Sistema LMS**: https://seu-projeto.vercel.app

## 🆘 Problemas Comuns

### Erro de Autenticação
- Verificar variáveis de ambiente
- Confirmar configuração do Supabase

### Cursos não aparecem
- Verificar se `is_published = true`
- Confirmar políticas RLS

### Deploy falha
- Verificar logs no Vercel
- Confirmar todas as variáveis de ambiente

## 📞 Suporte

Para dúvidas técnicas:
1. Verificar logs no Supabase e Vercel
2. Consultar documentação do Next.js
3. Revisar configurações de segurança

---

## 🎯 Resultado Final

Após seguir estes passos, você terá:

✅ Sistema LMS completo funcionando na nuvem
✅ 80 colaboradores podem acessar via web
✅ Cursos de vídeo com controle de progresso
✅ Painel administrativo para gestão
✅ Interface responsiva (mobile/desktop)
✅ Autenticação segura
✅ Banco de dados escalável

**O sistema está pronto para uso imediato!**