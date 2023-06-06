import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class xoapp extends StatefulWidget {
  xoapp({super.key});

  static const String player1 = 'x';
  static const String player2 = 'o';
  static const String   winerplayer = 'w';
  @override
  State<xoapp> createState() => _xoappState();
}

class _xoappState extends State<xoapp> {
  late String currplayer;
  late bool gameEnd;
  late String winer;
  late List<List<String>> matrix;
  late int player1scor;
  late int player2scor;
  late String winerplayer;

  @override
  void initState() {
    matrix = List.generate(3, (_) => List.generate(3, (_) => ''));
    currplayer = 'x';
    gameEnd = false;
    winer = '';
    super.initState();
    player1scor = 0;
    player2scor = 0;
  }

  void restGame() {
    setState(() {
      matrix = List.generate(3, (_) => List.generate(3, (_) => ''));
    currplayer = 'x';
    gameEnd = false;
    winer = '';
    player1scor = 0;
    player2scor = 0;
    super.initState();
    });
  }

  restart() {
    setState(() {
      matrix = List.generate(3, (_) => List.generate(3, (_) => ''));
    });
  }

  void Changsscor() {
    if (winer == 'x') {
      player1scor++;
    } else if (winer == 'o') {
      player2scor++;
    }
  }

  void move(int row, int col) {
    if (gameEnd || matrix[row][col] != '') {
      return;
    }
    setState(() {
      matrix[row][col] = currplayer;
      if (matrix[0][col] == currplayer &&
          matrix[1][col] == currplayer &&
          matrix[2][col] == currplayer) {
        winer = currplayer;
        gameEnd = true;
      } else if (matrix[row][0] == currplayer &&
          matrix[row][1] == currplayer &&
          matrix[row][2] == currplayer) {
        winer = currplayer;
        gameEnd = true;
      } else if (matrix[0][0] == currplayer &&
          matrix[1][1] == currplayer &&
          matrix[2][2] == currplayer) {
        winer = currplayer;
        gameEnd = true;
      } else if (matrix[2][0] == currplayer &&
          matrix[1][1] == currplayer &&
          matrix[0][2] == currplayer) {
        winer = currplayer;
        gameEnd = true;
      }
       currplayer = currplayer == 'x' ? 'o' : 'x';

       if (!matrix.any((row) => row.any((cell) => cell == ''))) {
       gameEnd = true;
       winer = "it is a tie";
       }
      Changsscor();
      if (winer == 'x'){
         winerplayer = 'الوسيم';
      }else if(winer == 'x'){
         winerplayer = 'chrif';
      }
      if (winer != '' && winer == 'x') {showDialog(context: context, builder: (context)
          {
           return AlertDialog(
            title: Text('the winer is ${winerplayer}'),
            content: Column(
              children: [
                Image.asset('imags/abbach.profil.jpg'),
                Text(' اقعدو تلعبو خلو تشيرات  يفوتوكم',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:FontWeight.bold, 
                ),
                )
              ],
            ),
          );
        }
        
       );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              height: 260,
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 160,
                    child: Column(
                      children: [
                        Container(
                          height: 110,
                          width: 110,
                          color: Colors.white,
                          child: Image.network(
                              'imags/wa.jpg'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 40,
                          child: Text(
                            'الوسيم',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '$player1scor - $player2scor',
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 160,
                    child: Column(
                      children: [
                        Container(
                          height: 110,
                          width: 110,
                          color: Colors.white,
                          child: Image.asset('imags/chrif_profil.jpg'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 40,
                          child: Text(
                            'chrif',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.yellow,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    int col = index % 3;
                    int row = index ~/ 3;
                    
                    return GestureDetector(
                      onTap: () {
                        move(row, col);
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Text(
                          '${matrix[row][col]}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 90,
                              fontWeight: FontWeight.bold,
                              color: matrix[row][col] == "x"
                                  ? Colors.blue
                                  : Colors.green),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
                height: 150,
                color: Colors.blue,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                restart();
                              });
                            },
                            child: const Text(
                              'start',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 40),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25, right: 20),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                restGame();
                              });
                            },
                            icon: const Icon(
                              Icons.restart_alt,
                              size: 60,
                              color: Colors.greenAccent,
                            )),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
