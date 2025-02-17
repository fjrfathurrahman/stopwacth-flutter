import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stop Watch App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Stop Watch App')),
        body: HomeApp(),
      ),
    );
  }
}

// Beranda App
class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16.0,
              children: [
                // Top Area
                Center(
                  child: Text(
                      'Lorem ipsum dolor amet, oh take me back to night we met'),
                ),

                // Box Area
                Container(
                  height: 400.0,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(199, 50, 63, 104),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),

                // Bottom Area
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: RawMaterialButton(
                            onPressed: () {},
                            shape: const StadiumBorder(
                              side: BorderSide(color: Colors.black),
                            ),
                            child: Text(
                              "Start",
                              style: TextStyle(color: Colors.black),
                            ))),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.flag),
                    ),
                    Expanded(
                        child: RawMaterialButton(
                            onPressed: () {},
                            fillColor: Colors.black,
                            shape: const StadiumBorder(),
                            child: Text(
                              "Stop",
                              style: TextStyle(color: Colors.black),
                            )))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
