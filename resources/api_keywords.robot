*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Keywords ***
Conectar a API ReqRes
    [Documentation]    Cria uma sessão com a URL base da API.
    Create Session    placeholder    https://jsonplaceholder.typicode.com    verify=${False}

Listar usuarios da pagina 2
    # ESTA KEYWORD NÃO SERÁ MAIS USADA, MAS PODE DEIXÁ-LA AQUI POR ENQUANTO
    [Documentation]    Faz uma requisição GET para o endpoint de usuários.
    ${response}=    GET On Session    reqres    url=/api/users?page=2
    RETURN    ${response}

# -- KEYWORDS PARA POSTS --

Criar payload para post
    [Arguments]    ${titulo}    ${corpo}
    [Documentation]    Cria um dicionário que será o corpo JSON para um post.
    ${payload}=    Create Dictionary    title=${titulo}    body=${corpo}    userId=1
    RETURN    ${payload}

Criar um novo post via API
    [Arguments]    ${payload}
    [Documentation]    Envia uma requisição POST para criar um novo post.
    ${headers}=    Create Dictionary    Content-Type=application/json; charset=UTF-8
    ${response}=    POST On Session    placeholder    /posts    json=${payload}    headers=${headers}
    RETURN    ${response}

Verificar se o post foi criado com sucesso
    [Arguments]    ${response}    ${payload_enviado}
    [Documentation]    Valida a resposta de uma criação de post bem-sucedida.
    Status Should Be    201    ${response}
    ${corpo_da_resposta}=    Set Variable    ${response.json()}
    Dictionary Should Contain Sub Dictionary    ${corpo_da_resposta}    ${payload_enviado}
    Dictionary Should Contain Key    ${corpo_da_resposta}    id

# -- NOVAS KEYWORDS PARA PUT --

Atualizar um post existente
    [Arguments]    ${id_do_post}    ${payload}
    [Documentation]    Envia uma requisição PUT para atualizar um post existente.
    ${headers}=    Create Dictionary    Content-Type=application/json; charset=UTF-8
    ${response}=    PUT On Session    placeholder    /posts/${id_do_post}    json=${payload}    headers=${headers}
    RETURN    ${response}

Verificar se o post foi atualizado com sucesso
    [Arguments]    ${response}    ${payload_enviado}
    [Documentation]    Valida a resposta de uma atualização de post bem-sucedida.
    Status Should Be    200    ${response}
    ${corpo_da_resposta}=    Set Variable    ${response.json()}
    Dictionary Should Contain Sub Dictionary    ${corpo_da_resposta}    ${payload_enviado}

# -- NOVAS KEYWORDS PARA DELETE --

Deletar um post existente
    [Arguments]    ${id_do_post}
    [Documentation]    Envia uma requisição DELETE para apagar um post.
    ${response}=    DELETE On Session    placeholder    /posts/${id_do_post}
    RETURN    ${response}

Verificar se o post foi deletado com sucesso
    [Arguments]    ${response}
    [Documentation]    Valida se a resposta de uma remoção foi um sucesso (status 200 ou 204).

    # Passo 1: Criamos a lista de status que consideramos 'sucesso'.
    @{status_aceitaveis}=    Create List    200    204

    # Passo 2: Pegamos o status code da resposta (que é um número).
    ${status_code_real}=    Set Variable    ${response.status_code}

    # Passo 3 (A CORREÇÃO): Convertemos o status code (número) para um texto.
    ${status_code_como_texto}=    Convert To String    ${status_code_real}

    # Passo 4: Agora sim, comparamos um TEXTO com uma lista de TEXTOS.
    List Should Contain Value    ${status_aceitaveis}    ${status_code_como_texto}