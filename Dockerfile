# Use uma imagem base oficial do Python.
# python:3.10-slim é uma boa escolha por ser leve.
FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho.
# É feito separadamente para aproveitar o cache de camadas do Docker.
COPY requirements.txt .

# Instala as dependências do projeto.
# --no-cache-dir reduz o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta que a aplicação irá rodar.
EXPOSE 8000

# Comando para iniciar a aplicação quando o contêiner for executado.
# --host 0.0.0.0 é essencial para que a API seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]