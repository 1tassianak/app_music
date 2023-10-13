class Usuario {
  final String nome;
  final String email;
  final String senha;
  final String? imageUrl; // URL da imagem de perfil (opcional)

  Usuario({
    required this.nome,
    required this.email,
    required this.senha,
    this.imageUrl,
  });
}
