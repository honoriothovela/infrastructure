1. Estrutura do Repositório
O projeto foi organizado em um repositório Git para hospedar todo o código e scripts de automação.

2. Configuração do Ambiente e Ferramentas
Um pipeline de CI/CD foi configurado para automatizar o processo de provisionamento, configuração e implantação.

As ferramentas utilizadas incluem:


Terraform: Para provisionar a instância EC2.


Ansible: Para configurar a instância EC2.


Docker: Para conteinerizar a aplicação Go.


k3s: Uma distribuição leve do Kubernetes, para rodar os containers. * Atencao por favor ao ultimo ponto do Readme


Go: Para a aplicação backend.

3. Provisionamento da Infraestrutura com Terraform
Os scripts do Terraform foram usados para definir e lançar uma instância EC2 na AWS, utilizando o Free Tier.

O pipeline de CI/CD executa o Terraform para garantir que a infraestrutura seja provisionada de forma automatizada.

A configuração do Terraform inclui a criação de um grupo de segurança para permitir o tráfego necessário (SSH, HTTP, etc.).

4. Configuração da Instância EC2 com Ansible
O Ansible foi utilizado para a fase de gerenciamento de configuração.

Foi tentada a instalação do k3s na instância EC2 usando playbooks do Ansible, mas tive dificuldades, infelizmente nao tive sucesso, pensei em comunicar cedo, mas pensei que teria sucesso com o ansible.

No entanto, a instalação da máquina e do Docker foi concluída com sucesso usando Ansible, garantindo que a instância esteja pronta para hospedar cargas de trabalho em container.

5. Desenvolvimento, Conteinerização e Implantação da Aplicação
A aplicação Go foi desenvolvida para expor um endpoint RESTful que aceita uma frase e retorna o número de palavras, vogais e consoantes.

A API foi documentada usando a especificação OpenAPI (OAS).

Um Dockerfile foi criado para conteinerizar a aplicação Go.

A imagem Docker foi construída e enviada para um registro Docker.

A implantação do container no cluster k3s foi automatizada.

6. Validação da Implantação
A funcionalidade do serviço foi validada usando 

curl para invocar o endpoint.

7. Dificuldades Encontradas
A principal dificuldade encontrada foi a instalação do k3s na instância EC2 através do Ansible. Apesar de várias tentativas, a automação completa desta etapa não foi bem-sucedida.

No entanto, as outras etapas do processo – como o provisionamento da máquina e a instalação do Docker – foram realizadas com sucesso.

8. Próximos Passos
A investigação e correção da falha na automação do Ansible para o k3s é a próxima prioridade para garantir um fluxo de trabalho de ponta a ponta totalmente automatizado.

Para ganhar pontos extras, as próximas melhorias seriam:

Adicionar testes de unidade para a aplicação Go.

Adicionar monitoramento para o serviço.

Implementar autenticação/autorização na API.

Integrar o Sonarqube no pipeline de CI/CD para análise de código.