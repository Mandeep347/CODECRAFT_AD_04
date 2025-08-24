class GameModel{
  String winner = "";
  String currentPlayer = "X";
  List<String> board = List.filled(9, "");
  List<int> patternWon = [];

  bool checkWinner(String player){
    // winning positions
    List<List<int>> winPatterns = [
      [0,1,2], [3,4,5], [6,7,8], //rows
      [0,3,6], [1,4,7], [2,5,8], //columns
      [0,4,8], [2,4,6] //diagonals
    ];

    for(var pattern in winPatterns){
      if(
        board[pattern[0]] == player &&
          board[pattern[1]] == player &&
          board[pattern[2]] == player
      ){
        patternWon = pattern;
        return true;
      }
    }
    return false;
  }
}