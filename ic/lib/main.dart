
import 'package:flutter/material.dart';

void main() {
  runApp(const HanoiApp());
}

class HanoiApp extends StatelessWidget {
  const HanoiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tower of Hanoi',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HanoiGame(),
    );
  }
}

class HanoiGame extends StatefulWidget {
  const HanoiGame({super.key});

  @override
  State<HanoiGame> createState() => _HanoiGameState();
}

class _HanoiGameState extends State<HanoiGame> {
  List<List<int>> towers = [
    [3, 2, 1],
    [],
    [],
  ];

  int? selectedTower;
  int moves = 0;
  bool won = false;

  void resetGame() {
    setState(() {
      towers = [
        [3, 2, 1],
        [],
        [],
      ];
      selectedTower = null;
      moves = 0;
      won = false;
    });
  }

  void tapTower(int index) {
    if (won) return;

    setState(() {
      if (selectedTower == null) {
        if (towers[index].isNotEmpty) {
          selectedTower = index;
        }
        return;
      }

      if (selectedTower == index) {
        selectedTower = null;
        return;
      }

      final from = selectedTower!;
      final disk = towers[from].last;

      if (towers[index].isEmpty ||
          towers[index].last > disk) {
        towers[index].add(towers[from].removeLast());
        moves++;
        selectedTower = null;

        if (towers[2].length == 3) {
          won = true;
        }
      } else {
        selectedTower = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0FF),
      appBar: AppBar(
        title: const Text(
          'Tower of Hanoi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              '🗼 ย้ายหอคอยพิชิตด่าน',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'ย้ายแผ่นดิสก์ทั้งหมดไปยังเสาที่ 3',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 18),
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'จำนวนครั้ง',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '$moves ครั้ง',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(3, (index) {
                  final selected = selectedTower == index;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => tapTower(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? Colors.deepPurple
                                  .withAlpha(35)
                              : Colors.white,
                          borderRadius:
                              BorderRadius.circular(16),
                          border: Border.all(
                            color: selected
                                ? Colors.deepPurple
                                : Colors.black12,
                            width: selected ? 3 : 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              'เสา ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                alignment:
                                    Alignment.bottomCenter,
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: 8,
                                      height: 190,
                                      decoration:
                                          BoxDecoration(
                                        color: Colors.brown
                                            .shade300,
                                        borderRadius:
                                            BorderRadius
                                                .circular(8),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.end,
                                    children: [
                                      ...towers[index]
                                          .reversed
                                          .map((disk) {
                                        return Container(
                                          height: 30,
                                          width: 48.0 +
                                              disk * 23,
                                          margin:
                                              const EdgeInsets
                                                  .only(
                                            bottom: 3,
                                          ),
                                          decoration:
                                              BoxDecoration(
                                            color: [
                                              Colors.redAccent,
                                              Colors.orange,
                                              Colors
                                                  .lightBlue,
                                            ][disk - 1],
                                            borderRadius:
                                                BorderRadius
                                                    .circular(
                                                        10),
                                            border: Border.all(
                                              color: Colors
                                                  .black12,
                                            ),
                                          ),
                                          alignment:
                                              Alignment.center,
                                          child: Text(
                                            '$disk',
                                            style:
                                                const TextStyle(
                                              color: Colors
                                                  .white,
                                              fontWeight:
                                                  FontWeight
                                                      .bold,
                                            ),
                                          ),
                                        );
                                      }),
                                      Container(
                                        width: 100,
                                        height: 12,
                                        decoration:
                                            BoxDecoration(
                                          color: Colors.brown,
                                          borderRadius:
                                              BorderRadius
                                                  .circular(8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            if (won)
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  '🎉 ยินดีด้วย! คุณชนะแล้ว',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'แตะเสาที่มีแผ่น แล้วแตะเสาปลายทาง',
                  textAlign: TextAlign.center,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
                left: 20,
                right: 20,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: resetGame,
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    'เริ่มเกมใหม่',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}