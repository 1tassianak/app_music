<h1 align="center">
<img width="32" height="32" src="https://img.icons8.com/color/48/flutter.png" alt="flutter"/> APP MUSIC 🎶
</h1>

<h4 align="center"> 
	🚧 Em construção... 🚧
</h4>

> [!NOTE]
>Este aplicativo está sendo desenvolvido para estudo e exemplificação de desenvolvimento com Flutter/Dart. Vale ressaltar que este app não é para ser utilizado para fins comerciais.

O front do aplicativo foi feito a partir de um mockup, escolhido na internet por sua beleza e disposição de elementos, sem se preocupar com sua temática.
O desafio é desenvolver um app fiel à prototipação e dar continuidade de acordo com seu escopo.
A ideia é mostrar e ensinar que qualquer pessoa é capaz de desenvolver a partir de qualquer design, o que nos limita é nosso conhecimento.

O escopo é uma aplicação para ouvir música, cujo mockup é de autoria do designer <a href="https://www.petermocanu.com/login-form-ui-design/"  target="_blank"> Peter Mocanu </a>:
<h1 align="center">
    <img alt="App Music" title="#AppMusic" src="/imgs/login-form-UI-mobile-concept-v2.jpg" />
</h1>

Para as telas das quais não estão contempladas no mockup, buscou-se utilizar os mesmos elementos e colorações, para manter o padrão do mockup.

Este app possui as seguintes funcionalidades a serem desenvolvidas:

## Tela Introdutória:
- Login;
- Cadastrar-se;
- Login rápido (por biometria).

## Tela de Login:
- Fazer login com e-mail e senha;
- Fazer login com a conta do Google
- Fazer login com a conta do Facebook;
- Cadastrar-se.

## Tela de Cadastro:
- Fazer cadastro utilizando dados pessoais;
- Tirar foto para o perfil com a câmera;
- Escolher foto da galeria para inserir no perfil;
- Remover foto do perfil.

## Tela Home:
- Listagem de músicas;
- Favoritar músicas;
- Ouvir músicas;

## Menu Drawer:
- Ver/ouvir músicas favoritas/curtidas;
- Ver/ouvir músicas de playlists criadas;

## Telas individuais de cada música:
- Ouvir a música;
- Pausar;
- Favoritar;

## :vibration_mode: Como executar/importar o projeto

- Certifique-se de que o Flutter esteja na versão 3.10.1 e o Dart na versão 3.0.1;
- Importe o projeto para sua IDE de preferência (eu estou utilizando o Android Studio Giraffe | 2022.3.1 Patch 1);
  - Certifique-se de que a IDE esteja com os plugins Flutter e Dart instalados nas versões citadas acima;
- Vá em `File > Settings > Languages & Frameworks > Flutter` e insira o caminho da pasta do SDK do Flutter em `Flutter SDK path`;
- Abra o arquivo `pubspec.yaml` e clique em `pub get` para que as dependências (pacotes) utilizadas no projeto sejam carregadas;
- Execute a aplicação.