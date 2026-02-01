import 'package:flutter/material.dart';

void main() => runApp(const BadmintonApp());

class BadmintonApp extends StatelessWidget {
  const BadmintonApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(home: ScorePage());
}

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  int scoreA = 0;
  int scoreB = 0;
  String serverTeam = 'A'; // 当前发球方 [cite: 107]

  // 简易判断：偶数右区(Right)，奇数左区(Left)
  String get serverArea => (serverTeam == 'A' ? scoreA : scoreB) % 2 == 0 ? "右区" : "左区";

  void _incrementScore(String team) {
    setState(() {
      if (team == 'A') {
        scoreA++;
      } else {
        scoreB++;
      }
      serverTeam = team; // 得分方获得发球权 [cite: 65]
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("阶段 2 - 逻辑校验")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("当前发球方：$serverTeam 队", style: TextStyle(fontSize: 22, color: Colors.blue)),
            Text("发球区：$serverArea", style: TextStyle(fontSize: 22, color: Colors.red)),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _scoreButton('A', scoreA),
                _scoreButton('B', scoreB),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _scoreButton(String team, int score) {
    return Column(
      children: [
        Text("$team 队", style: const TextStyle(fontSize: 20)),
        Text("$score", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
        ElevatedButton(onPressed: () => _incrementScore(team), child: Text("$team 队得分")),
      ],
    );
  }
}