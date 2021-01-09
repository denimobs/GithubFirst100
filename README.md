# GithubFirst100

# Sobre o projeto

Liste os 100 primeiros repositorios do github com um link para acessá-los

# Layout
![](screenshot/home_screen.gif)

# Como executar o projeto
## Linha de comando
```bash
 # na raiz do projeto executar
 flutter run
```

## Apk
utilizar o apk disponivel na raiz do projeto **AppDebug.apk**

# Arquitetura usada
## Getx
Getx foi utilizado para o state management, DI e roteamento do projeto

## organizaçao
* services: Arquivos globais contendo um conjunto de açoes relacionadas que podem ser utilizadas em qualquer lugar da aplicaçao

* models: DTOs utilizados para salvar os dados vindos da api

* views/components: widgets comuns que sao usados em diversas paginas da aplicaçao

* views/pages: widgets responsaveis por uma tela inteira, cada page possui um controller onde é armazenado funçoes e variaveis relacionadas somente a essa pagina como animaçoes e controles de TextField. como o app possue apenas uma tela a regra de negocio foi adicionada junto ao controller da tela por simplicidade.

# Autor

Denilson Amaral

https://www.linkedin.com/in/denilson-amaral-3a1333191/
