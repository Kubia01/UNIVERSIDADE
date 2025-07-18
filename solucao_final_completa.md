# Solução Definitiva: Erro "Unexpected token, expected ';' (18:14)" no Next.js

## Análise Completa do Problema

Após analisar múltiplos commits e tentativas, o erro persiste sempre na **linha 18, coluna 14** do arquivo `src/app/globals.css`. Isso indica um problema muito específico que não está sendo resolvido pelas correções normais.

## Possíveis Causas Raiz

1. **Caracteres invisíveis** (BOM, espaços não-quebráveis)
2. **Codificação incorreta** do arquivo
3. **Problema com o PostCSS/Tailwind v4**
4. **Cache persistente** do Vercel
5. **Configuração incorreta** do projeto

## Soluções Sequenciais (Execute na Ordem)

### Solução 1: Recriar o Arquivo Completamente

```bash
# 1. Remover o arquivo problemático
rm src/app/globals.css

# 2. Criar um novo arquivo com encoding correto
cat > src/app/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

# 3. Testar
npm run build
```

### Solução 2: Verificar Configurações do Tailwind

Verifique se existe `tailwind.config.js`:

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

Verifique se existe `postcss.config.js`:

```javascript
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
```

### Solução 3: Verificar package.json

Certifique-se de que as dependências estão corretas:

```json
{
  "dependencies": {
    "next": "14.2.30",
    "react": "^18",
    "react-dom": "^18"
  },
  "devDependencies": {
    "autoprefixer": "^10.4.14",
    "postcss": "^8.4.24",
    "tailwindcss": "^3.3.0"
  }
}
```

### Solução 4: Limpar Cache e Reinstalar

```bash
# Limpar tudo
rm -rf .next
rm -rf node_modules
rm package-lock.json

# Reinstalar
npm install

# Testar
npm run build
```

### Solução 5: Verificar Encoding do Arquivo

```bash
# Verificar encoding
file src/app/globals.css

# Verificar caracteres invisíveis
hexdump -C src/app/globals.css | head -10

# Se encontrar caracteres estranhos, recriar o arquivo
```

### Solução 6: Usar Editor Diferente

```bash
# Usar nano para recriar (evita problemas de encoding)
nano src/app/globals.css
```

Cole apenas:
```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

Salve com `Ctrl+X`, `Y`, `Enter`.

### Solução 7: Alternativa sem Tailwind

Se nada funcionar, temporariamente remova o Tailwind:

```css
/* src/app/globals.css */
* {
  box-sizing: border-box;
}

html,
body {
  padding: 0;
  margin: 0;
  font-family: system-ui, -apple-system, sans-serif;
}

a {
  color: inherit;
  text-decoration: none;
}
```

### Solução 8: Verificar layout.tsx

Certifique-se de que o arquivo `src/app/layout.tsx` está importando corretamente:

```typescript
import './globals.css'

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
```

### Solução 9: Comando de Emergência Final

```bash
# Script completo de limpeza e recriação
#!/bin/bash

echo "Limpando projeto..."
rm -rf .next
rm -rf node_modules
rm package-lock.json
rm src/app/globals.css

echo "Recriando globals.css..."
mkdir -p src/app
echo "@tailwind base;
@tailwind components;
@tailwind utilities;" > src/app/globals.css

echo "Reinstalando dependências..."
npm install

echo "Testando build..."
npm run build

echo "Se funcionou, fazendo commit..."
git add .
git commit -m "fix: recriar globals.css para resolver erro de sintaxe"
git push origin main
```

### Solução 10: Investigação Avançada

Se ainda não funcionar, investigue mais profundamente:

```bash
# Verificar se há outros arquivos CSS
find . -name "*.css" -type f

# Verificar configurações do Next.js
cat next.config.js

# Verificar se há conflitos de versão
npm ls tailwindcss
npm ls postcss
npm ls autoprefixer

# Verificar logs detalhados
npm run build 2>&1 | grep -A 10 -B 10 "Unexpected token"
```

## Solução Alternativa: Mudar para Tailwind v3

Se o problema persistir, pode ser incompatibilidade com Tailwind v4:

```bash
# Desinstalar Tailwind v4
npm uninstall tailwindcss

# Instalar Tailwind v3
npm install -D tailwindcss@^3.3.0 postcss autoprefixer

# Recriar configuração
npx tailwindcss init -p
```

## Comandos de Teste

Após cada solução, execute:

```bash
# Teste local
npm run build

# Se funcionar, fazer deploy
git add .
git commit -m "fix: resolver erro de sintaxe CSS"
git push origin main
```

## Observações Importantes

1. **O erro sempre na linha 18:14** sugere um problema muito específico
2. **Pode ser um bug** do Tailwind v4 ou Next.js 14.2.30
3. **A solução mais provável** é recriar o arquivo com encoding correto
4. **Se nada funcionar**, considere downgrade para Tailwind v3

## Última Opção: Contato com Suporte

Se todas as soluções falharem:

1. Abra uma issue no GitHub do Next.js
2. Abra uma issue no GitHub do Tailwind CSS
3. Considere usar um template limpo do Next.js

O erro é muito específico e pode ser um bug conhecido nas versões que você está usando.