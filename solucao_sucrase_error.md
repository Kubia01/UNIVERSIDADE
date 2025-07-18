# Solução para Erro do Sucrase: "Unexpected token, expected ';' (18:14)"

## Problema Identificado

O erro está sendo causado pelo **Sucrase** (um transpilador JavaScript) que está tentando processar o arquivo `globals.css` como se fosse código JavaScript. O Sucrase não deveria processar arquivos CSS, mas por algum motivo está sendo invocado.

### Análise do Erro

```
SyntaxError: Unexpected token, expected ";" (18:14)
at unexpected (/vercel/path0/node_modules/sucrase/dist/parser/traverser/util.js:99:15)
```

O **Sucrase** está tentando fazer parsing de CSS como JavaScript, o que não deveria acontecer.

## Soluções Definitivas

### Solução 1: Verificar e Corrigir next.config.js

O problema pode estar na configuração do Next.js. Crie ou edite o arquivo `next.config.js`:

```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  // Garantir que CSS seja processado corretamente
  experimental: {
    // Remover qualquer configuração experimental que possa interferir
  }
}

module.exports = nextConfig
```

### Solução 2: Verificar/Criar tailwind.config.js

```javascript
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

### Solução 3: Verificar/Criar postcss.config.js

```javascript
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
```

### Solução 4: Verificar package.json

Certifique-se de que as dependências estão corretas:

```json
{
  "name": "universidade-interlub-lms",
  "version": "1.0.0",
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "next": "14.2.30",
    "react": "^18",
    "react-dom": "^18"
  },
  "devDependencies": {
    "@types/node": "^20",
    "@types/react": "^18",
    "@types/react-dom": "^18",
    "autoprefixer": "^10.4.14",
    "eslint": "^8",
    "eslint-config-next": "14.2.30",
    "postcss": "^8.4.24",
    "tailwindcss": "^3.3.0",
    "typescript": "^5"
  }
}
```

### Solução 5: Recriar o Arquivo globals.css com Encoding Correto

```bash
# Remover o arquivo atual
rm src/app/globals.css

# Recriar com encoding UTF-8
cat > src/app/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF
```

### Solução 6: Verificar tsconfig.json

```json
{
  "compilerOptions": {
    "target": "es5",
    "lib": ["dom", "dom.iterable", "es6"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
```

### Solução 7: Comandos de Limpeza Total

Execute estes comandos na ordem:

```bash
# 1. Parar qualquer servidor em execução
# Pressione Ctrl+C se houver algum servidor rodando

# 2. Limpar tudo
rm -rf .next
rm -rf node_modules
rm -rf package-lock.json
rm -rf yarn.lock

# 3. Recriar globals.css
rm src/app/globals.css
echo "@tailwind base;
@tailwind components;
@tailwind utilities;" > src/app/globals.css

# 4. Reinstalar dependências
npm install

# 5. Testar build
npm run build
```

### Solução 8: Verificar se há Conflitos de Configuração

Verifique se não há arquivos de configuração conflitantes:

```bash
# Verificar arquivos de configuração
ls -la | grep -E "(babel|webpack|sucrase|swc)"

# Se houver babel.config.js, remova (Next.js usa SWC por padrão)
rm babel.config.js

# Se houver .babelrc, remova
rm .babelrc
```

### Solução 9: Forçar Uso do SWC (Recomendado)

No `next.config.js`, force o uso do SWC:

```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  compiler: {
    // Garantir que o SWC seja usado em vez do Babel
    removeConsole: process.env.NODE_ENV === "production",
  },
}

module.exports = nextConfig
```

### Solução 10: Alternativa - Remover Tailwind Temporariamente

Se nada funcionar, remova temporariamente o Tailwind:

```css
/* src/app/globals.css */
* {
  box-sizing: border-box;
}

html,
body {
  padding: 0;
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
}

a {
  color: inherit;
  text-decoration: none;
}
```

## Script de Solução Automática

Crie um script `fix-build.sh`:

```bash
#!/bin/bash

echo "🔧 Iniciando correção do erro de build..."

# Parar processos
echo "⏹️  Parando processos..."
pkill -f "next"

# Limpar cache
echo "🧹 Limpando cache..."
rm -rf .next
rm -rf node_modules
rm -rf package-lock.json

# Recriar globals.css
echo "📝 Recriando globals.css..."
rm -f src/app/globals.css
mkdir -p src/app
cat > src/app/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

# Criar configurações necessárias
echo "⚙️  Criando configurações..."

# next.config.js
cat > next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
}

module.exports = nextConfig
EOF

# tailwind.config.js
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

# postcss.config.js
cat > postcss.config.js << 'EOF'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

# Reinstalar dependências
echo "📦 Reinstalando dependências..."
npm install

# Testar build
echo "🏗️  Testando build..."
npm run build

if [ $? -eq 0 ]; then
    echo "✅ Build bem-sucedido!"
    echo "🚀 Fazendo commit..."
    git add .
    git commit -m "fix: resolver erro de build do Sucrase"
    git push origin main
else
    echo "❌ Build falhou. Verifique os logs acima."
fi
```

Execute com:
```bash
chmod +x fix-build.sh
./fix-build.sh
```

## Resumo

O erro está sendo causado pelo **Sucrase tentando processar CSS como JavaScript**. As soluções focam em:

1. **Garantir configurações corretas** do Next.js
2. **Forçar o uso do SWC** em vez do Babel/Sucrase
3. **Recriar o arquivo CSS** com encoding correto
4. **Limpar cache** e dependências

A **Solução 7** (comandos de limpeza total) é a mais provável de resolver o problema.