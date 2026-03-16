import 'dart:io';

class BatalhaNaval {

  int tamanho = 16;

  List<List<String>> tabuleiroNavios = [];
  List<List<String>> tabuleiroTiros = [];

  BatalhaNaval() {

    tabuleiroNavios =
        List.generate(tamanho, (_) => List.generate(tamanho, (_) => "[ ]"));

    tabuleiroTiros =
        List.generate(tamanho, (_) => List.generate(tamanho, (_) => "[ ]"));
  }

  void exibirTabuleiroTiros() {

    print("\nTABULEIRO:");

    stdout.write("   ");
    for (int j = 0; j < tamanho; j++) {
      stdout.write("$j ");
    }
    print("");

    for (int i = 0; i < tamanho; i++) {

      stdout.write("$i ");

      for (int j = 0; j < tamanho; j++) {
        stdout.write(tabuleiroTiros[i][j]);
      }

      print("");
    }
  }

  void posicionarNavio(int linha, int coluna, int tamanhoNavio) {

    for (int i = 0; i < tamanhoNavio; i++) {
      tabuleiroNavios[linha][coluna + i] = "[S]";
    }

  }

  bool atirar(int linha, int coluna) {

    if (tabuleiroNavios[linha][coluna] == "[S]") {

      tabuleiroTiros[linha][coluna] = "[X]";
      return true;

    } else {

      tabuleiroTiros[linha][coluna] = "[~]";
      return false;

    }

  }
}

void limparTela() {
  stdout.write("\x1B[2J\x1B[0;0H");
}

void posicionarNavioJogador(BatalhaNaval jogo, String jogador) {

  int tamanhoNavio;

  while (true) {

    print("\n$jogador escolha o tamanho do navio:");
    tamanhoNavio = int.parse(stdin.readLineSync()!);

    stdout.write("Linha inicial: ");
    int linha = int.parse(stdin.readLineSync()!);

    stdout.write("Coluna inicial: ");
    int coluna = int.parse(stdin.readLineSync()!);

    if (coluna + tamanhoNavio > jogo.tamanho) {

      print("⚠ O navio não cabe no tabuleiro. Tente novamente.");

    } else {

      jogo.posicionarNavio(linha, coluna, tamanhoNavio);
      break;

    }

  }

}

void main() {

  stdout.write("Nome do Jogador 1: ");
  String jogador1 = stdin.readLineSync()!;

  stdout.write("Nome do Jogador 2: ");
  String jogador2 = stdin.readLineSync()!;

  BatalhaNaval jogo1 = BatalhaNaval();
  BatalhaNaval jogo2 = BatalhaNaval();

  posicionarNavioJogador(jogo1, jogador1);

  print("\nPasse o computador para $jogador2 e pressione ENTER");
  stdin.readLineSync();
  limparTela();

  posicionarNavioJogador(jogo2, jogador2);

  print("\nPressione ENTER para começar a batalha!");
  stdin.readLineSync();
  limparTela();

  bool venceu = false;

  while (!venceu) {

    print("\nTurno de $jogador1");
    jogo2.exibirTabuleiroTiros();

    stdout.write("Linha do tiro: ");
    int linha = int.parse(stdin.readLineSync()!);

    stdout.write("Coluna do tiro: ");
    int coluna = int.parse(stdin.readLineSync()!);

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

    print("\nTurno de $jogador2");
    jogo1.exibirTabuleiroTiros();

    stdout.write("Linha do tiro: ");
    int linha2 = int.parse(stdin.readLineSync()!);

    stdout.write("Coluna do tiro: ");
    int coluna2 = int.parse(stdin.readLineSync()!);

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