# Big Data ANAC - Análise e Predição dos dados

<div align="center">

[![Apache Spark](https://img.shields.io/badge/Apache%20Spark-3.5.1-orange?style=for-the-badge&logo=apachespark)](https://spark.apache.org/)
[![Python](https://img.shields.io/badge/Python-3.x-blue?style=for-the-badge&logo=python)](https://www.python.org/)
[![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?style=for-the-badge&logo=docker)](https://www.docker.com/)
[![Jupyter](https://img.shields.io/badge/Jupyter%20Lab-Analytics-F37726?style=for-the-badge&logo=jupyter)](https://jupyter.org/)

Um projeto robusto de análise de Big Data dos dados da ANAC (Agência Nacional de Aviação Civil) utilizando Apache Spark, PySpark e Jupyter Lab em ambiente containerizado para prever o número de de passageiros pagos através dos dados da ANAC.

</div>

---

## 📋 Sobre o Projeto

Este projeto realiza análise e processamento de dados de aviação da ANAC usando tecnologias de Big Data. O objetivo é explorar, processar e modelar dados de voos brasileiros através de ferramentas modernas como **Apache Spark** para processamento distribuído e **Jupyter Lab** prever o número de de passageiros pagos através dos dados da ANAC, utilizando modelos de machine learning de Regressão, como Decision Tree, Linear Regression e Redes Neurais.

### ✨ Características Principais

- ✅ **Spark Distribuído**: Master e Worker configurados para processamento paralelo
- ✅ **Jupyter Lab**: Ambiente interativo para análise e experimentação
- ✅ **Docker Compose**: Orquestração completa de containers
- ✅ **PySpark**: Análise de dados em Python com poder de processamento distribuído
- ✅ **Dados Estruturados**: Suporte para CSV e Parquet

---

## Tecnologias Utilizadas

| Tecnologia | Versão | Propósito |
|-----------|--------|----------|
| Apache Spark | 3.5.1 | Processamento distribuído de dados |
| PySpark | 3.5.1 | API Python para Spark |
| Python | 3.x | Linguagem de programação principal |
| SQL | - | - |
| Jupyter Lab | Latest | Ambiente de notebooks interativos |
| Docker | - | Containerização |
| Docker Compose | - | Orquestração de containers |

---

## Pré-requisitos

Antes de começar, você precisará ter instalado em sua máquina:

- **Docker** ([Instalar](https://docs.docker.com/get-docker/))
- **Docker Compose** ([Instalar](https://docs.docker.com/compose/install/))
- **Git** (para clonar o repositório)

### Verificar Instalação

```bash
# Verificar Docker
docker --version

# Verificar Docker Compose
docker-compose --version
```

---


## Como Começar com Docker

### Passo 1: Clone o Repositório

```bash
git clone https://github.com/Junhit902/Big-Data.git
cd Big_Data_ANAC
```

## Baixe o dataset a ser utilizado

https://www.kaggle.com/datasets/sturarods/anac-national-civil-aviation-agency-2000-2025

![alt text](/imagens/image2.png)

<span style="color:blue"><b>Obs.: Baixe o zip e extraia o arquivo .csv e coloque na pasta raw que está dentro da pasta data. </b></span><br>

### Passo 2: Construir a Imagem Docker

```bash
sudo docker-compose up --build --scale spark-worker=2
```
**O número de worker pode ser deifnido de acordo com as suas necessidades e poder computacional. FIz com 2.**

Este comando vai:
- ✓ Baixar a imagem base do Apache Spark 3.5.1
- ✓ Instalar dependências do Python
- ✓ Instalar Jupyter Lab e bibliotecas de análise
- ✓ Configurar permissões e diretórios

### Passo 3: Iniciar os Containers

```bash
docker-compose up -d
```

Este comando inicia:
- **Spark Master** (porta 7077 e 8080)
![alt text](/imagens/Screenshot%20from%202026-05-02%2023-29-44.png)
- **Spark Worker** (conectado ao Master)
- **Jupyter Lab** (porta 8888)


### Passo 4: Acessar o Jupyter Lab

Abra seu navegador e acesse:

```
http://localhost:8888
```
![alt text](/imagens/image.png)

Pronto! O Jupyter Lab está rodando e conectado ao cluster Spark.

---

## Parar os Containers

Para parar todos os containers:

```bash
docker-compose down
```


---


## 📁 Estrutura do Projeto

```
Big_Data_ANAC/
├── 📄 README.md                    # Este arquivo
├── 📄 Dockerfile                   # Configuração da imagem Docker (Jupyter + Spark)
├── 📄 docker-compose.yml           # Orquestração dos containers
│
├── 📁 data/                        # Diretório de dados
│   ├── 📁 raw/                     # Dados brutos
│   │   └── 📊 anac_brazil.csv      # Dados originais da ANAC
│   └── 📁 processed/               # Dados processados
│       └── 📁 anac_parquet/        # Dados convertidos para Parquet
│
├── 📁 notebooks/                   # Jupyter Notebooks
│   └── 📓 ANAC_Regressão.ipynb    # Análise de regressão dos dados
│
└── 📁 scripts/                     # Scripts Python
```


---


### Monitorar Jobs do Spark

Enquanto houver processamento em andamento, você pode monitorar em:

```
http://localhost:4040
```
![alt text](/imagens/Screenshot%20from%202026-05-04%2012-05-10.png)

---

## Comandos Úteis Docker

```bash
# Ver status dos containers
docker-compose ps

# Ver logs do Jupyter
docker-compose logs -f jupyter

# Ver logs do Spark Master
docker-compose logs -f spark-master

# Acessar terminal do container Jupyter
docker-compose exec jupyter bash

# Reiniciar um serviço específico
docker-compose restart jupyter
```

---

## Acessar Interfaces Web

| Serviço | URL | Descrição |
|---------|-----|----------|
| Jupyter Lab | http://localhost:8888 | Ambiente de notebooks |
| Spark Master UI | http://localhost:8080 | Dashboard do Spark Master |
| Spark Worker UI | http://localhost:8081 | Dashboard do Worker (se exposto) |
| Spark Jobs | http://localhost:4040 | Monitoramento de jobs (durante execução) |

---

## Estrutura do docker-compose.yml

O projeto utiliza 3 serviços:

### 🔹 Spark Master
- Coordena o processamento distribuído
- Portas: 7077 (comunicação), 8080 (UI)

### 🔹 Spark Worker
- Executa tarefas do Spark
- Conecta-se automaticamente ao Master

### 🔹 Jupyter Lab
- Built a partir do Dockerfile customizado
- Conecta-se ao cluster Spark
- Portas: 8888 (UI), 4040 (Jobs monitoring)

---

## Troubleshooting

### Erro: "Cannot connect to Spark Master"
```bash
# Reinicie todos os serviços
docker-compose down
docker-compose up -d
```

### Erro: "Port already in use"
```bash
# Altere a porta no docker-compose.yml ou libere a porta
sudo lsof -ti:8888 | xargs kill -9  # Liberar porta 8888
```

### Jupyter não inicia
```bash
# Verificar logs
docker-compose logs jupyter

# Reconstruir imagem
docker-compose build --no-cache
```

---

## Recursos e Documentação

- [Apache Spark Documentation](https://spark.apache.org/docs/latest/)
- [PySpark API](https://spark.apache.org/docs/latest/api/python/)
- [Jupyter Lab Documentation](https://jupyterlab.readthedocs.io/)
- [Docker Documentation](https://docs.docker.com/)
- [ANAC - Agência Nacional de Aviação Civil](https://www.anac.gov.br/)

---
