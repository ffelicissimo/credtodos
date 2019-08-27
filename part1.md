No caso toda a parte de infraestrutura(vpc,regras de acesso e ec2) dentro da AWS foi automatizada usando o terraform na versao 0.12.6, lembrando que sera necessario alterar no arquivo "infra.tf" os campos "acess_key","secret_key e alterar o campo "key_name" para o nome da chave de seu ambiente no meu caso esta como "fernando".
Com relacao a variaveis de ambientes existe algumas formas de se trabalhar em containers eu optei nesse caso por usar env.file(dev.env) onde as variaveis de ambientes utilizadas podem ser declaras e tambem coloquei a variavel "GERU_PASS" no build usando ARG no Dockerfile.
Criei um repositorio publico no dockerhub "ffelicissimo/credtodos" onde fiz a integracao do "github/dockerhub" onde ao fazer o commit ja inicia o processo de build para geracao da imagem.
E sempre uma boa pratica ter 02 repositorios de codigos onde um repositorio e para codigo e o segundo seria para provisionamento da infra estrutura e ai por dentro da criacao da infra trazemos o deploy do pacote da aplicao.

1 - terraform init
2 - terraform plan
3 - terraform apply -auto-approve

Acessando a API FLASK :

curl -H "Authorization: Token" http://ippublico/
devops test server flying!!

Para desprovisionar todo o ambiente basta executar o seguite comando:

$terraform destroy -force -auto-approve

Sempre pensando em melhoria continua seria possivel por exemplo usar o redis ou mesmo pensando em AWS sabendo que e uma aplicacao com estatica poderia ser publicada por exemplo num S3 bucket e melhorando a arquitetura poderia colocar um Elastic Load Balance ja com regras de auto-scale pensando no caso de lta utilizacao uma vez que nesse caso especifico NAO estamos usando um cluster containers(k8s).
