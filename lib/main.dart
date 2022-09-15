import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'widgets/circular_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planet App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            bodyText2: TextStyle(color: Colors.white),
          )),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  var indicatorController = PageController(viewportFraction: 0.2);
  var planetsPageController = PageController(viewportFraction: 1);

  var images = List.generate(
      8,
      (_) => Padding(
            padding: const EdgeInsets.all(60),
            child: Transform.scale(
              scale: 1.5,
              child: Image.asset(
                'assets/images/earth.png',
              ),
            ),
          ));

  // var images = List.generate(
  //     8,
  //     (_) => Container(
  //           color: Colors.red,
  //           width: 100,
  //           height: 100,
  //         ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff030A23),
      body: SafeArea(
        child: Stack(
          children: [
            // Transform.translate(
            //   offset: const Offset(0, 100),
            //   child: Center(
            //     child: Container(
            //       height: 5,
            //       width: 5,
            //       decoration: const BoxDecoration(
            //         boxShadow: [
            //           BoxShadow(
            //             color: Color(0xff1C3C7D),
            //             spreadRadius: 175,
            //             blurRadius: 100,
            //           )
            //         ],
            //         shape: BoxShape.circle,
            //       ),
            //     ),
            //   ),
            // ),
            Transform.translate(
              offset: const Offset(0, -150),
              child: CircularPageView(
                  controller: indicatorController,
                  itemCount: images.length,
                  innerRadius: 0.3,
                  items: images.asMap().entries.map((entry) {
                    if (entry.key == currentIndex) {
                      return buildDot(true);
                    }
                    return buildDot(false);
                  }).toList()),
            ),
            Transform.translate(
              offset: const Offset(0, 160),
              child: Center(
                child: Column(
                  children: const [
                    Text(
                      'Mars',
                      style: TextStyle(fontSize: 45),
                    ),
                    SizedBox(height: 5),
                    Text('Neighbour'),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, 260),
              child: CircularPageView(
                controller: planetsPageController,
                itemCount: images.length,
                innerRadius: 1,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                  indicatorController.animateToPage(index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.fastOutSlowIn);
                },
                // scrollDirection: Axis.horizontal,
                items: images,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildDot(bool current) {
  return Container(
    height: 10,
    width: 10,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: current == true ? Colors.white : Colors.grey.withOpacity(0.5),
    ),
  );
}
