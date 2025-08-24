import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Model/game_model.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GameModel gameState = GameModel();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text("Tic Tac Toe"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            gameState.winner.isEmpty ? "Turn: ${gameState.currentPlayer}" : gameState.winner,
            style: const TextStyle(fontSize: 28, color: Colors.white),
          ),

          const SizedBox(height: 20,),

          Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context,index) => GestureDetector(
                    onTap: ()=> _handleTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: gameState.patternWon.isEmpty
                          ? gameState.winner == "It's a draw" ? Colors.blueGrey[200] : Colors.blueGrey[800]
                          : gameState.patternWon.contains(index) ? Colors.green : Colors.blueGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          gameState.board[index],
                          style: TextStyle(
                            fontSize: 78,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                itemCount: 9,
              )
          ),
          ElevatedButton(onPressed: _restartGame, child: const Text("Restart")),
          const SizedBox(height: 50,),
        ],
      )
    );
  }

  void _restartGame(){
    setState(() {
      gameState.board = List.filled(9, "");
      gameState.currentPlayer = "X";
      gameState.winner = "";
      gameState.patternWon = [];
    });
  }

  void _handleTap(int index){

    if(gameState.board[index] != "" || gameState.winner != "") return;

    setState(() {
      gameState.board[index] = gameState.currentPlayer;
      if(gameState.checkWinner(gameState.currentPlayer)){
        gameState.winner = "${gameState.currentPlayer} wins !";
      }else if(!gameState.board.contains("")){
        gameState.winner = "It's a draw";
      }else{
        gameState.currentPlayer = gameState.currentPlayer == "X" ? "O" : "X";
      }

    });
  }
}