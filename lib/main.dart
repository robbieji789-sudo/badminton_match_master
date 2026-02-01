import 'package:flutter/material.dart';

void main() {
  runApp(const BadmintonApp());
}

class BadmintonApp extends StatelessWidget {
  const BadmintonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScorePage(),
    );
  }
}

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  // 核心变量：存储 A 队和 B 队的比分
  int scoreA = 0;
  int scoreB = 0;

  // 加分函数：通过 setState 通知 Flutter 刷新界面
  void _incrementScore(String team) {
    setState(() {
      if (team == 'A') {
        scoreA++;
      } else {
        scoreB++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("羽毛球对局助手 - 基础版")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // A 队计分列
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("A 队", style: TextStyle(fontSize: 24)),
                Text("$scoreA", style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () => _incrementScore('A'),
                  child: const Text("A 队加分"),
                ),
              ],
            ),
            // B 队计分列
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("B 队", style: TextStyle(fontSize: 24)),
                Text("$scoreB", style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () => _incrementScore('B'),
                  child: const Text("B 队加分"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}