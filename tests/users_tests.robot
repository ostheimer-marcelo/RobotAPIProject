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