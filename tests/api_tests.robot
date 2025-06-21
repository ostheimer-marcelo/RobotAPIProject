*** Settings ***
Documentation       Testes para a API de Posts do JSONPlaceholder.
Resource            ../resources/api_keywords.robot
# Vamos renomear a sessão para refletir a API que estamos usando
Suite Setup         Create Session    placeholder    https://jsonplaceholder.typicode.com    verify=${False}

*** Test Cases ***
Criar novo post com sucesso
    [Documentation]    Cria um post via POST e valida a resposta de sucesso.
    [Tags]             API    Posts    POST    Smoke
    ${payload}=    Criar payload para post    Meu Título    Meu incrível post.
    ${resposta_da_api}=    Criar um novo post via API    ${payload}
    Verificar se o post foi criado com sucesso    ${resposta_da_api}    ${payload}

Atualizar um post com sucesso
    [Documentation]    Atualiza um post existente (ID 1) e valida a resposta.
    [Tags]             API    Posts    PUT    Regression

    # ETAPA 1 - PREPARAÇÃO: Montar os dados atualizados.
    ${payload_atualizado}=    Criar payload para post    Título Atualizado    Corpo Atualizado

    # ETAPA 2 - AÇÃO: Atualizar o post que já existe (ID=1).
    ${resposta_update}=    Atualizar um post existente    1    ${payload_atualizado}

    # ETAPA 3 - VERIFICAÇÃO: Validar se a resposta da atualização foi bem-sucedida.
    Verificar se o post foi atualizado com sucesso    ${resposta_update}    ${payload_atualizado}

Deletar um post com sucesso
    [Documentation]    Deleta um post existente (ID 1) e valida a resposta.
    [Tags]             API    Posts    DELETE    Regression

    # AÇÃO: Deletar diretamente o post que sabemos que existe.
    ${resposta_delete}=    Deletar um post existente    1

    # VERIFICAÇÃO: Validar se a remoção foi bem-sucedida.
    Verificar se o post foi deletado com sucesso    ${resposta_delete}