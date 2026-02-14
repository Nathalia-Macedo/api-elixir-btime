# KanbanApi | Infrastructure e Persistent Data Layer

Esta é a API que desenvolvi para o sistema KanbanPro, responsável por todo processamento e persistência dos dados. Escolhi Elixir com Phoenix para garantir alta escalabilidade, concorrência segura e uma interface GraphQL bem estruturada.

## Engenharia de Infraestrutura

### 1. Modelo de Concorrência (BEAM VM)
Aproveitei o modelo de atores da Erlang VM para que cada requisição ou processo do sistema rode de forma isolada e paralela. Isso garante que se algum processo falhar, o resto da aplicação continua funcionando normalmente.

### 2. Migrações Automáticas
Implementei um sistema que roda as migrações automaticamente quando a aplicação sobe. Coloquei isso direto na árvore de supervisão do Phoenix, então quando o container inicializa no Render ou Docker, ele já verifica o schema do banco e aplica as migrações pendentes - sem precisar de comando manual.

### 3. Camada GraphQL com Absinthe
Em vez de criar endpoints REST fixos, montei um Schema GraphQL bem tipado. Assim o frontend pode pedir exatamente os campos que precisa, o que diminui o tráfego de rede e ainda serve como documentação viva da API.

### 4. Persistência com Ecto
Uso o Ecto para me comunicar com o PostgreSQL. Separei bem os Schemas (que definem como os dados são estruturados) dos Contextos (onde fica a regra de negócio), seguindo uma abordagem mais próxima de Domain-Driven Design.

## Stack Tecnológica

- **Elixir e Erlang/OTP**: Escolhi a linguagem por ser funcional e excelente para sistemas distribuídos
- **Phoenix Framework**: Framework que dá toda a estrutura para a aplicação web
- **PostgreSQL**: Banco relacional que uso para dados críticos
- **Absinthe**: Implementação GraphQL para Elixir que achei muito completa
- **Docker**: Para garantir que o ambiente de produção fique idêntico ao de desenvolvimento

## Endpoints GraphQL

A API tem essas operações principais:

- **list_tasks**: Busca todas as tarefas cadastradas
- **create_task**: Cria nova tarefa com validação de prioridade (low, high, critical)
- **update_task**: Atualiza status e outros campos de forma atômica
- **delete_task**: Remove tarefa do banco pelo ID

## Como Faço o Deploy

Configurei a aplicação para deploy contínuo usando Docker. Quando o container sobe, ele:
1. Inicia a árvore de supervisão da aplicação
2. Roda automaticamente as migrações pendentes do banco
3. Sobe o servidor Cowboy para começar a atender as requisições
