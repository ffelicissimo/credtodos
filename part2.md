No caso essa arquitetura mostrando o fluxo de acesso a aplicacao onde essa aplicacao tem um parte de conteudo estatico e esta sendo publicado no S3 bucket e sendo publicado com o recurso de Cloud Front que tem uma funcao de distribuicao de conteudo e tem algumas funcoes que ajuda e muito a experiencia do usuario como por exemplo se o conteudo ja estiver no ponto de presenca com a menor latencia e caso nao tenha o conteudo ai o acesso se faz atraves do S3 Bucket, o API GATEWAY como por exemplo o APIGEE ele tem uma funcao de criacao , publicacao , monitoria e protecao das API's um bom exemplo do uso de API e nao permitir o acesso direto ao banco de dados e pra terminar o O AWS Lambda permite que você execute funções em um ambiente sem servidor para processar eventos a LAMBDA usa varias trigers eu gosto de pensar grosseiramente no lambda como um orquestrador de funcoes e ai pra feichar o raciocinio e pensando em seguranca da informacao existe uma segmentacao de rede(VPC) especifica para o banco de dados onde somente o acesso e feito atraves do Lambda.

obs:Essa descricao foi feitada com base na imagem terraform_app_aws.png