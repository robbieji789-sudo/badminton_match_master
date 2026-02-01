import 'package:flutter/material.dart';

void main() => runApp(const BadmintonApp());

class BadmintonApp extends StatelessWidget {
  const BadmintonApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(debugShowCheckedModeBanner: false, home: ScorePage());
}

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  int scoreA = 0;
  int scoreB = 0;
  String serverTeam = 'A';

  // 计算发球区：偶数右(1.0)，奇数左(-1.0)
  double get serverX => (serverTeam == 'A' ? scoreA : scoreB) % 2 == 0 ? 0.5 : -0.5;

  void _incrementScore(String team) {
    setState(() {
      team == 'A' ? scoreA++ : scoreB++;
      serverTeam = team;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("阶段 3 - 视觉化球场"), backgroundColor: Colors.green),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // 羽毛球场俯视图
          AspectRatio(
            aspectRatio: 0.8,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.green[700], border: Border.all(color: Colors.white, width: 4)),
              child: Stack(
                children: [
                  // 中网线
                  Center(child: Container(height: 2, color: Colors.white)),
                  // 球员 A (上方)
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 300),
                    alignment: Alignment(serverTeam == 'A' ? serverX : -serverX, -0.6),
                    child: _playerBox("球员 A", Colors.blue),
                  ),
                  // 球员 B (下方)
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 300),
                    alignment: Alignment(serverTeam == 'B' ? serverX : -serverX, 0.6),
                    child: _playerBox("球员 B", Colors.red),
                  ),
                ],
              ),
            ),
          ),
          // 计分按钮区域 [cite: 118]
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _scoreBtn('A', scoreA, Colors.blue),
                _scoreBtn('B', scoreB, Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _playerBox(String name, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8), boxShadow: [const BoxShadow(blurRadius: 4)]),
      child: Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget _scoreBtn(String team, int score, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(score.toString(), style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: color)),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color, // 设置按钮背景颜色
            foregroundColor: Colors.white, // 设置按钮文字颜色
          ),
          onPressed: () => _incrementScore(team),
          child: Text("$team 队得分", style: const TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}