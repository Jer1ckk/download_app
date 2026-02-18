import 'package:flutter/material.dart';

final ColorController controller = ColorController();

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType {
  red(Colors.red),
  blue(Colors.blue),
  yellow(Colors.yellow),
  green(Colors.green);

  final Color color;
  const CardType(this.color);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? ColorTapsScreen() : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: ListenableBuilder(
        listenable: controller,
        builder: (BuildContext context, Widget? child) {
          return Column(
            children:
            [Text("${controller.total}"),
            ...CardType.values.map((type) {
              return ColorTap(
                type: type,
                tapCount: controller.getCount(type),
                onTap: () => controller.increment(type),
              );
            })]
          );
        },
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;
  final int tapCount;
  final VoidCallback onTap;

  const ColorTap({
    super.key,
    required this.type,
    required this.tapCount,
    required this.onTap,
  });

  Color get backgroundColor => type.color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: ListenableBuilder(
          listenable: controller,
          builder: (BuildContext context, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: CardType.values.map((type) {
                return Text(
                  'Number of ${type.name} = ${controller.allCount[type]}',
                  style: const TextStyle(fontSize: 24),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class ColorController extends ChangeNotifier {
  final Map<CardType, int> _tapCounts = {
    for (var type in CardType.values) type: 0,
  };

  int getCount(CardType type) => _tapCounts[type]!;

  Map<CardType, int> get allCount => Map.unmodifiable(_tapCounts);

  void increment(CardType type) {
    _tapCounts[type] = _tapCounts[type]! + 1;
    notifyListeners();
  }

  int get total => _tapCounts.values.fold(0, (sum, value) => sum + value);

}
