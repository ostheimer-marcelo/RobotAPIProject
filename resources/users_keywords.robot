*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Keywords ***
Conectar a API ReqRes
    [Documentation]    Cria uma sessão com a URL base da API.
    # Adicionamos 'verify=${True}' para fazer uma conexão HTTPS segura e remover o warning.
    Create Session    reqres    https://reqres.in    verify=${True}

Listar usuarios da pagina 2
    [Documentation]    Faz uma requisição GET para o endpoint de usuários.
    ${response}=    GET On Session    reqres    url=/api/users?page=2
    # Sintaxe moderna para retornar um valor
    RETURN    ${response}

A resposta da API deve ser bem sucedida
    [Arguments]    ${response}
    [Documentation]    Verifica se o status da resposta é 200 e se o Content-Type é JSON.

    Status Should Be    200    ${response}

    # A FORMA CORRETA E VERIFICADA:
    # ${response.headers} é o dicionário de todos os cabeçalhos da resposta.
    # Esta keyword verifica se nesse dicionário existe um item com a chave 'Content-Type'
    # e o valor 'application/json; charset=utf-8'.
    Dictionary Should Contain Item    ${response.headers}    Content-Type    application/json; charset=utf-8

O email do primeiro usuario deve ser "michael.lawson@reqres.in"
    [Arguments]    ${response}
    [Documentation]    Verifica o email do primeiro usuário acessando a resposta JSON diretamente.

    # A FORMA MODERNA E CORRETA:
    # ${response.json()} converte a resposta para um objeto que o Robot entende.
    # A partir daí, usamos a sintaxe [chave] e [índice] para navegar na estrutura JSON.
    ${email}=    Set Variable    ${response.json()['data'][0]['email']}

    # Agora comparamos o valor extraído com o esperado.
    Should Be Equal As Strings    ${email}    michael.lawson@reqres.in