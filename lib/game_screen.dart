import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/home_screen.dart';

class GameScreen extends StatefulWidget {
  String firstPlayer;
  String secondPlayer;

  GameScreen(
      {super.key, required this.firstPlayer, required this.secondPlayer});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_) => ''));
    _currentPlayer = 'X';
    _winner = '';
    _gameOver = false;
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => ''));
      _currentPlayer = 'X';
      _winner = '';
      _gameOver = false;
    });
  }

  void _makeMove(int row, int column) {
    if (_board[row][column] != '' || _gameOver) {
      return;
    }
    setState(() {
      _board[row][column] = _currentPlayer;

      if (_board[row][0] == _currentPlayer &&
          _board[row][1] == _currentPlayer &&
          _board[row][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][column] == _currentPlayer &&
          _board[1][column] == _currentPlayer &&
          _board[2][column] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][0] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][2] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][0] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      }

      //switch players
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';

      //check for tie
      if (!_board.any((row) => row.any((cell) => cell == ''))) {
        _gameOver = true;
        _winner = "It's a Tie";
      }

      if (_winner != '') {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            btnOkText: 'Play Again',
            title: _winner == 'X'
                ? '${widget.firstPlayer} Won!'
                : _winner == 'O'
                    ? '${widget.secondPlayer} Won!'
                    : "It's a Tie",
            btnOkOnPress: () {
              _resetGame();
            }).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323D5B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            SizedBox(
              height: 120,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Turn: ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _currentPlayer == 'X'
                            ? "${widget.firstPlayer} ($_currentPlayer)"
                            : "${widget.secondPlayer} ($_currentPlayer)",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: _currentPlayer == 'X'
                              ? const Color(0xFFE23041)
                              : const Color(0xFF1CBD9E),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 432,
              decoration: BoxDecoration(
                color: const Color(0xFF5F6B84),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(5),
              child: GridView.builder(
                  itemCount: 9,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    int row = index ~/ 3;
                    int column = index % 3;
                    return GestureDetector(
                      onTap: () => _makeMove(row, column),
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0E1E3A),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            _board[row][column],
                            style: TextStyle(
                              fontSize: 87,
                              fontWeight: FontWeight.bold,
                              color: _board[row][column] == 'X'
                                  ? const Color(0xFFE25041)
                                  : const Color(0xFF1CBD9E),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                    widget.firstPlayer = '';
                    widget.secondPlayer = '';
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                    child: const Text('Restart Game',style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),) ,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
