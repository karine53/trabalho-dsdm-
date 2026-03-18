import 'dart:io';

// Classe principal do jogo
class BatalhaNaval {

  // Define o tamanho do tabuleiro (16x16)
  int tamanho = 16;

  // Tabuleiro onde ficam os navios
  List<List<String>> tabuleiroNavios = [];

  // Tabuleiro onde aparecem os tiros
  List<List<String>> tabuleiroTiros = [];

  // Construtor da classe
  BatalhaNaval() {

    // Cria o tabuleiro de navios com espaços vazios
    tabuleiroNavios =
        List.generate(tamanho, (_) => List.generate(tamanho, (_) => "[ ]"));

    // Cria o tabuleiro de tiros com espaços vazios
    tabuleiroTiros =
        List.generate(tamanho, (_) => List.generate(tamanho, (_) => "[ ]"));
  }

  // Função que mostra o mostra o tabuleiro de tiros na tela
  void exibirTabuleiroTiros() {

    print("\nTABULEIRO:");

    // Mostra os números das colunas
    stdout.write("   ");
    for (int j = 0; j < tamanho; j++) {
      stdout.write("$j ");
    }
    print("");

    // Mostra cada linha com seus valores
    for (int i = 0; i < tamanho; i++) {

      stdout.write("$i ");

      for (int j = 0; j < tamanho; j++) {
        stdout.write(tabuleiroTiros[i][j]);
      }

      print("");
    }
  }

  // Função para posicionar o navio no tabuleiro
  void posicionarNavio(int linha, int coluna, int tamanhoNavio) {

    // Coloca o navio na horizontal
    for (int i = 0; i < tamanhoNavio; i++) {
      tabuleiroNavios[linha][coluna + i] = "[S]";
    }

  }

  // Função para realizar um tiro
  bool atirar(int linha, int coluna) {

    // Se acertou um navio
    if (tabuleiroNavios[linha][coluna] == "[S]") {

      tabuleiroTiros[linha][coluna] = "[X]"; // Marca acerto
      return true;

    } else {

      tabuleiroTiros[linha][coluna] = "[~]"; // Marca água
      return false;

    }

  }
}

// Função para limpar a tela do terminal
void limparTela() {
  stdout.write("\x1B[2J\x1B[0;0H");
}

// Função para garantir que o usuário digite apenas números
int lerNumero(String mensagem) {
  while (true) {
    stdout.write(mensagem);
    String? entrada = stdin.readLineSync();

    try {
      return int.parse(entrada!); // tenta converter para número
    } catch (e) {
      print("⚠ Digite apenas números válidos!");
    }
  }
}

// Função para posicionar o navio do jogador
void posicionarNavioJogador(BatalhaNaval jogo, String jogador) {

  int tamanhoNavio;

  while (true) {

    print("\n$jogador escolha o tamanho do navio:");

    // Usa a função segura para ler número
    tamanhoNavio = lerNumero("Tamanho: ");

    int linha = lerNumero("Linha inicial: ");
    int coluna = lerNumero("Coluna inicial: ");

    // Verifica se o navio cabe no tabuleiro
    if (coluna + tamanhoNavio > jogo.tamanho) {

      print("⚠ O navio não cabe no tabuleiro. Tente novamente.");

    } else {

      jogo.posicionarNavio(linha, coluna, tamanhoNavio);
      break;

    }

  }

}

void main() {

  // Pede o nome dos jogadores
  stdout.write("Nome do Jogador 1: ");
  String jogador1 = stdin.readLineSync()!;

  stdout.write("Nome do Jogador 2: ");
  String jogador2 = stdin.readLineSync()!;

  // Cria dois jogos (um para cada jogador)
  BatalhaNaval jogo1 = BatalhaNaval();
  BatalhaNaval jogo2 = BatalhaNaval();

  // Jogador 1 posiciona seu navio
  posicionarNavioJogador(jogo1, jogador1);

  print("\nPasse o computador para $jogador2 e pressione ENTER");
  stdin.readLineSync();
  limparTela();

  // Jogador 2 posiciona seu navio
  posicionarNavioJogador(jogo2, jogador2);

  print("\nPressione ENTER para começar a batalha!");
  stdin.readLineSync();
  limparTela();

  bool venceu = false;

  // Loop principal do jogo
  while (!venceu) {

    // Turno do jogador 1
    print("\nTurno de $jogador1");
    jogo2.exibirTabuleiroTiros();

    int linha = lerNumero("Linha do tiro: ");
    int coluna = lerNumero("Coluna do tiro: ");

    bool acerto = jogo2.atirar(linha, coluna);

    jogo2.exibirTabuleiroTiros();

    if (acerto) {

      print("💥 ACERTOU O NAVIO!");
      print("🏆 $jogador1 venceu!");
      venceu = true;
      break;

    } else {

      print("🌊 Água!");

    }

    print("\nPasse o computador para $jogador2 e pressione ENTER");
    stdin.readLineSync();
    limparTela();

    // Turno do jogador 2
    print("\nTurno de $jogador2");
    jogo1.exibirTabuleiroTiros();

    int linha2 = lerNumero("Linha do tiro: ");
    int coluna2 = lerNumero("Coluna do tiro: ");

    bool acerto2 = jogo1.atirar(linha2, coluna2);

    jogo1.exibirTabuleiroTiros();

    if (acerto2) {

      print("💥 ACERTOU O NAVIO!");
      print("🏆 $jogador2 venceu!");
      venceu = true;

    } else {

      print("🌊 Água!");

    }

    print("\nPasse o computador para $jogador1 e pressione ENTER");
    stdin.readLineSync();
    limparTela();

  }

}
