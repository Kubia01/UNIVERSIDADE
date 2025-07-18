# Instruções para Corrigir o Erro do globals.css - SOLUÇÃO FINAL

## Problema Identificado

O erro persiste na linha 18 do arquivo `src/app/globals.css`. Analisando o commit mais recente, o problema está na propriedade `font-family` que está quebrada em múltiplas linhas, causando um erro de parsing CSS.

## Solução Definitiva

### Opção 1: Versão Corrigida (Recomendada)

Substitua todo o conteúdo do arquivo `src/app/globals.css` por:

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Reset básico */
*,
*::before,
*::after {
  box-sizing: border-box;
}

html,
body {
  padding: 0;
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
  line-height: 1.6;
  font-size: 16px;
}

a {
  color: inherit;
  text-decoration: none;
}

img {
  max-width: 100%;
  height: auto;
}
```

### Opção 2: Versão Mínima (Mais Segura)

Se a Opção 1 não funcionar, use esta versão mínima:

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

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

## Passos para Implementar

### 1. Editar o Arquivo
```bash
# Abra o arquivo
nano src/app/globals.css

# Ou use seu editor preferido
code src/app/globals.css
```

### 2. Substituir o Conteúdo
1. Selecione todo o conteúdo (Ctrl+A)
2. Delete tudo
3. Cole uma das versões acima
4. Salve o arquivo (Ctrl+S)

### 3. Verificar Localmente
```bash
# Limpar cache
rm -rf .next

# Testar build
npm run build
```

### 4. Fazer Deploy
```bash
git add src/app/globals.css
git commit -m "fix: corrigir sintaxe CSS na propriedade font-family"
git push origin main
```

## Causa do Erro

O erro estava na propriedade `font-family` que estava quebrada em múltiplas linhas:

```css
/* ERRO - Quebra de linha problemática */
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
```

**Solução**: Colocar tudo em uma linha ou usar quebras de linha adequadas.

## Verificação de Funcionamento

Após implementar a correção:

1. **Teste local**: `npm run build` deve funcionar sem erros
2. **Deploy**: O build no Vercel deve ser bem-sucedido
3. **Aplicação**: O site deve carregar normalmente

## Se Ainda Não Funcionar

Execute estes comandos de emergência:

```bash
# Remover o arquivo problemático
rm src/app/globals.css

# Recriar com conteúdo mínimo
cat > src/app/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

* {
  box-sizing: border-box;
}

html, body {
  margin: 0;
  padding: 0;
  font-family: system-ui, sans-serif;
}
EOF

# Testar
npm run build

# Se funcionou, fazer commit
git add src/app/globals.css
git commit -m "fix: recriar globals.css com sintaxe correta"
git push origin main
```

## Observação Importante

O problema não estava no conteúdo CSS em si, mas na **formatação das quebras de linha** na propriedade `font-family`. O parser CSS do Next.js é sensível a certas formatações de quebra de linha em propriedades longas.