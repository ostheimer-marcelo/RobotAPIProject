# Projeto de Automação de Testes de API com Robot Framework 🚀

![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow)
![Framework](https://img.shields.io/badge/framework-Robot%20Framework-blue)
![Linguagem](https://img.shields.io/badge/linguagem-Python-brightgreen)
![Biblioteca](https://img.shields.io/badge/biblioteca-RequestsLibrary-orange)

## 📖 Sobre o Projeto

Este projeto demonstra a automação de testes para uma API REST, focando na validação da lógica de negócio, integridade de dados e contratos de serviço, sem a necessidade de uma interface de usuário.

A API alvo é a **[jsonplaceholder.typicode.com](jsonplaceholder.typicode.com)**, um serviço público criado especificamente para praticar e testar requisições e respostas de API.

## ✨ Escopo e Cenários de Teste

A suíte de testes foi planejada para cobrir todas as operações CRUD (Create, Read, Update, Delete) essenciais, validando os principais verbos HTTP.

## ✨ Escopo e Cenários de Teste

A suíte de testes foi planejada para cobrir todas as operações CRUD (Create, Read, Update, Delete) essenciais, validando os principais verbos HTTP.

### ✔️ **GET (Leitura de Dados)**
- [x] Listar múltiplos usuários e validar a estrutura da resposta (Status 200).
- [x] Validar os dados de um usuário específico na lista.


### ✔️ **POST (Criação de Dados)**
- [x] Criar um novo usuário (post) e validar a resposta 201.
- [x] Verificar se os dados enviados foram retornados no corpo da resposta.

### ✔️ **PUT (Atualização de Dados)**
- [x] Atualizar um usuário (post) existente e validar a resposta 200.
- [x] Verificar se os dados atualizados foram retornados no corpo da resposta.

### ✔️ **DELETE (Remoção de Dados)**
- [x] Deletar um usuário (post) existente e validar a resposta 204.

## 🚀 Tecnologias e Padrões Utilizados

* **Framework:** Robot Framework
* **Linguagem:** Python
* **Bibliotecas:** RequestsLibrary, Collections
* **Padrões:**
    * Arquitetura modular com separação de Testes e Recursos.
    * Keywords reutilizáveis para ações de API.
    * Validação de Status Codes, Headers e Response Body (JSON).
* **Ferramentas:** Git, GitHub, Ambientes Virtuais (venv).

## 🔧 Instalação e Configuração

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/ostheimer-marcelo/RobotAPIProject.git](https://github.com/ostheimer-marcelo/RobotAPIProject.git)
    ```
2.  **Navegue até o diretório:**
    ```bash
    cd RobotAPIProject
    ```
3.  **Crie e ative um ambiente virtual:**
    ```bash
    python -m venv .venv
    # No Windows (cmd.exe)
    .venv\Scripts\activate
    ```
4.  **Instale as dependências:**
    ```bash
    pip install -r requirements.txt
    ```

## ▶️ Executando os Testes

Com o ambiente virtual ativo, use o comando abaixo a partir da raiz do projeto:
```bash
  python -m robot -d results tests/
```

## 👨‍💻 Autor

**Marcelo Ostheimer**
* LinkedIn: https://www.linkedin.com/in/marceloostheimer/
* GitHub: https://github.com/ostheimer-marcelo


