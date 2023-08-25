import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isFullSun = true;
  bool isDayMood = true;
  Duration duration = const Duration(seconds: 2);
  @override
  Widget build(BuildContext context) {
    List<Color> lightBgColors = [
      const Color(0xFF8C2480),
      const Color(0xFFCE587D),
      const Color(0xFFFF9485),
      if (isFullSun) const Color(0xFFFF9D80),
    ];
    var darkBgColors = const [
      Color(0xFF0D1441),
      Color(0xFF283584),
      Color(0xFF376AB2),
    ];
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Future<void> changeMode(int value) async {
      if (value == 0) {
        setState(() {
          isDayMood = true;
        });
        await Future.delayed(
          const Duration(seconds: 2),
        );
        setState(() {
          isFullSun = true;
        });
      } else {
        setState(() {
          isDayMood = false;
        });
        await Future.delayed(const Duration(seconds: 2));
        setState(() {
          isFullSun = false;
        });
      }
    }

    return Scaffold(
      body: AnimatedContainer(
        duration: duration,
        curve: Curves.bounceInOut,
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isFullSun ? lightBgColors : darkBgColors,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              bottom: !isFullSun ? -110 : 220,
              right: 20,
              left: 30,
              duration: duration,
              child: SvgPicture.asset('assets/ Sun.svg'),
            ),
            Positioned(
              bottom: -70,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/${isFullSun ? 'tree_and_area.png' : 'land_tree_dark.png'}',
                height: height * 0.55,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              top: 120,
              left: 50,
              child: Container(
                width: width * 0.80,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DefaultTabController(
                  length: 2,
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onTap: ((value) async {
                      await changeMode(value);
                    }),
                    labelStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.black,
                    tabs: const [
                      Tab(text: 'Morning Login'),
                      Tab(text: 'Night Login'),
                    ],
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
