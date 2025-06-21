*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Keywords ***
Conectar a API ReqRes
    [Documentation]    Cria uma sessão com a URL base da API.
    # Adicionamos 'verify=${True}' para fazer uma conexão HTTPS segura e remover o warning.
    Create Session    reqres    https://reqres.in    verify=${False}

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

Criar payload para novo usuario
    [Arguments]    ${nome}    ${cargo}
    [Documentation]    Cria um dicionário que será o corpo JSON da requisição.
    ${payload}=    Create Dictionary    name=${nome}    job=${cargo}
    RETURN    ${payload}

Criar um novo usuario via API
    [Arguments]    ${payload}
    [Documentation]    Envia uma requisição POST com o header Content-Type explícito.

    # Passo 1: Criamos um dicionário para os nossos cabeçalhos.
    ${headers}=    Create Dictionary    Content-Type=application/json

    # Passo 2: Passamos o payload (json=) E os cabeçalhos (headers=) para a requisição.
    ${response}=    POST On Session    reqres    /api/users    json=${payload}    headers=${headers}

    RETURN    ${response}

Verificar se o usuario foi criado com sucesso
    [Arguments]    ${response}    ${payload_enviado}
    [Documentation]    Valida a resposta de uma criação de usuário bem-sucedida.
    # O status code para "Criado com Sucesso" é 201.
    Status Should Be    201    ${response}
    ${corpo_da_resposta}=    Set Variable    ${response.json()}
    # Verifica se a resposta contém os mesmos dados que enviamos.
    Dictionary Should Contain Sub-dictionary    ${corpo_da_resposta}    ${payload_enviado}
    # Verifica também se a resposta contém uma chave 'id' e 'createdAt', geradas pelo servidor.
    Dictionary Should Contain Key    ${corpo_da_resposta}    id
    Dictionary Should Contain Key    ${corpo_da_resposta}    createdAt

Testar Post para JSONPlaceholder
    [Documentation]    Testa um POST para uma API alternativa para diagnóstico de rede.
    Create Session    placeholder    https://jsonplaceholder.typicode.com
    ${payload}=       Create Dictionary    title=foo    body=bar    userId=1
    ${headers}=       Create Dictionary    Content-Type=application/json; charset=UTF-8
    ${response}=      POST On Session    placeholder    /posts    json=${payload}    headers=${headers}
    Status Should Be    201    ${response}
    Log To Console    \n\nResposta do JSONPlaceholder: ${response.json()}\n\n