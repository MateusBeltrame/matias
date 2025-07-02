# Etapa 1: Escolha da imagem base

FROM python:3.13.5-alpine3.22

# Etapa 2: Definir o diretório de trabalho
# Isso garante que todos os comandos subsequentes sejam executados neste diretório.
WORKDIR /app

# Etapa 3: Copiar e instalar as dependências
# Copiamos o requirements.txt primeiro para aproveitar o cache de camadas do Docker.
# A camada de dependências só será reconstruída se o arquivo requirements.txt mudar.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 4: Copiar o código da aplicação
COPY . .

# Etapa 5: Expor a porta
# Informa ao Docker que o contêiner escuta na porta 8000.
EXPOSE 8000

# Etapa 6: Comando de execução
# Inicia o servidor Uvicorn. O host 0.0.0.0 é necessário para que a API
# seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000" "--reload"]
