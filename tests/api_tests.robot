*** Settings ***
Documentation       Testes para a API de Usuários do ReqRes.
Resource            ../resources/users_keywords.robot
Suite Setup         Conectar a API ReqRes

*** Test Cases ***
Listar usuarios com sucesso e validar o primeiro email
    [Documentation]    Faz uma requisição para a lista de usuários e
    ...                valida o status e um dado específico na resposta.
    [Tags]             API    Users    GET    Smoke

    ${resposta_da_api}=    Listar usuarios da pagina 2
    A resposta da API deve ser bem sucedida    ${resposta_da_api}
    O email do primeiro usuario deve ser "michael.lawson@reqres.in"    ${resposta_da_api}

# vv ADICIONE ESTE NOVO TESTE ABAIXO vv
Criar novo usuario com sucesso
    [Documentation]    Cria um usuário via POST e valida a resposta de sucesso.
    [Tags]             API    Users    POST    Smoke

    # ETAPA 1 - PREPARAÇÃO: Montar os dados do usuário a ser criado.
    ${payload}=    Criar payload para novo usuario    Marcelo    Engenheiro de Automação

    # ETAPA 2 - AÇÃO: Enviar a requisição para criar o usuário.
    ${resposta_da_api}=    Criar um novo usuario via API    ${payload}

    # ETAPA 3 - VERIFICAÇÃO: Validar se a resposta da API confirma a criação.
    Verificar se o usuario foi criado com sucesso    ${resposta_da_api}    ${payload}

Teste de Diagnostico com API Alternativa
    [Tags]    Debug
    Testar Post para JSONPlaceholder