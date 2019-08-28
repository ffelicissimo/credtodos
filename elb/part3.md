A ideia e montar uma arquitetura da seguinte maneira automatizando o provisionamento da infra via terraform V0.12.6 . No caso sera necessario alterar no arquivo "main.tf" os campos "acess_key","secret_key e alterar o campo "key_name" para o nome da chave de seu ambiente no meu caso esta como "fernando".

Criar um Launch Configuration
Vincular nosso Launch Configuration em um Auto Scaling Group
Colocar nosso Scaling de instâncias em Multi-AZ
Criar um Load Balancer escutando a porta 80
Vincular nosso Auto Scaling Group ao Load Balancer
Criar uma Policy para Scale UP das máquinas
Criar uma Policy para Scale Down das máquinas
Vamos criar 2 security groups, um para as nossas instâncias diretamentamente chamado websg e outro para o nosso ELB chamado elbsg, onde vamos liberar somente a porta 80. Vamos criar uma regra para liberar o acesso SSH também.

Launch Configuration vai se chamar webcluster, onde vamos utilizar nossa AMI do Amazon Linux, anexar nosso Security Group e apontar nosso user-data, onde ditamos o script inicial de inicilização das nossas máquinas.

No nosso Auto Scaling Group que vamos chamar de scalegroup, vamos fazer referência ao nosso Launch Configuration e definir as availability zones como us-east-1a, us-east-1b e us-east-1c. Desta forma podemos ter alguns níves de alta disponibilidade caso alguma zona específica da Virginia venha a apresentar algum problema.

Vamos definir nossas métricas de Scale Up e Scale Down da seguinte forma:

Sempre que a média de processamento do nosso Auto Scaling Group ficar acima de 60% durante 2 checagens com intervalo de 2 minutos entre elas, vamos subir uma nova instância.
Sempre que a média de processamento do nosso Auto Scaling Group ficar abaixo de 10% durante 2 checagens com intervalos de 2 minutos entre elas, vamos matar uma instância.

Para subir o ambiente acesse a pasta "elb":
1 - terraform init
2 - terraform plan
3 - terraform apply -auto-approve

Desprovisionando o ambiente:
$terraform destroy -force -auto-approve

Testando ELB e aplicacao:
curl -H "Authorization: Token" http://terraform-elb-1690236603.us-east-1.elb.amazonaws.com
devops test server flying!!

obs:Essa descricao foi feitada com base na imagem terraform_elb-asg_arquitetura.png