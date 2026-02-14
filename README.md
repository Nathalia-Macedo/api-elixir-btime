

# KanbanApi | Infrastructure e Persistent Data Layer

Esta é a unidade de processamento e persistência do sistema KanbanPro. Desenvolvida em Elixir e utilizando o framework Phoenix, a API foi projetada para oferecer alta escalabilidade, concorrência segura e uma interface de dados robusta via GraphQL.

## Engenharia de Infraestrutura

### 1. Modelo de Concorrência (BEAM VM)
A API utiliza o modelo de atores da Erlang VM, permitindo que cada requisição ou tarefa de sistema (como migrações) seja processada de forma isolada e paralela, garantindo que falhas em um processo não comprometam a estabilidade global da aplicação.

### 2. Ciclo de Vida e Migrações Automáticas
Implementação de um sistema de auto-migração injetado na árvore de supervisão da aplicação. Ao iniciar o container em ambientes de nuvem (Render/Docker), a aplicação verifica a integridade do schema do banco de dados e executa scripts de migração de forma autônoma, eliminando a necessidade de intervenção manual no terminal.

### 3. Camada de Dados com Absinthe (GraphQL)
Em vez de endpoints fixos, a API expõe um Schema GraphQL tipado. Isso permite que o frontend solicite exatamente os campos necessários, reduzindo o payload de rede e oferecendo uma documentação viva da estrutura de dados.



### 4. Persistência de Dados e Ecto
Uso do Ecto para comunicação com PostgreSQL. A arquitetura separa claramente os Schemas (definição de dados) dos Contextos (regras de negócio), seguindo os princípios de Domain-Driven Design (DDD).

## Stack Tecnológica

* Elixir e Erlang/OTP: Linguagem funcional para sistemas distribuídos.
* Phoenix Framework: Infraestrutura para aplicações web de alto desempenho.
* PostgreSQL: Banco de dados relacional para persistência de missão crítica.
* Absinthe: Implementação de especificação GraphQL para Elixir.
* Docker: Containerização para consistência entre ambientes de produção.

## Estrutura do Endpoint GraphQL

A API suporta as seguintes operações principais:

* list_tasks: Recuperação de todas as entidades de tarefa.
* create_task: Inserção de novos registros com validação de prioridade (low, high, critical).
* update_task: Atualização atômica de status e metadados.
* delete_task: Remoção física de registros via ID.

## Procedimento de Deploy

A aplicação está configurada para deploy contínuo via Docker. O comando principal de execução é responsável por:
1. Inicializar a árvore de supervisão.
2. Executar migrações de banco de dados pendentes.
3. Iniciar o servidor Cowboy para escuta de requisições HTTP.
