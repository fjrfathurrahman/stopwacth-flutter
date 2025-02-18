import 'dart:async';

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
  // Variabel untuk menyimpan waktu (detik, menit, jam)
  int seconds = 0, minutes = 0, hours = 0;

  // Variabel untuk menampilkan waktu dalam format dua digit
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";

  // Timer yang digunakan untuk menjalankan stopwatch secara periodik
  Timer? timer;

  // Status apakah stopwatch sedang berjalan atau tidak
  bool started = false;

  // List untuk menyimpan catatan waktu (lap times)
  List laps = [];

  // * Function untuk menghentikan stopwatch
  void stop() {
    timer!.cancel(); // Membatalkan timer yang sedang berjalan
    setState(() {
      started = false; // Mengubah status menjadi berhenti
    });
  }

  // * Function untuk mereset stopwatch dan menghapus semua catatan waktu
  void reset() {
    timer?.cancel(); // Membatalkan timer jika sedang berjalan
    setState(() {
      // Mengatur ulang semua variabel waktu
      seconds = 0;
      minutes = 0;
      hours = 0;

      // Mengatur ulang tampilan waktu
      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false; // Mengatur ulang status stopwatch
      laps.clear(); // Menghapus semua catatan waktu
    });
  }

  // * Function untuk menambahkan waktu saat ini ke dalam daftar laps
  void addLaps() {
    String lap =
        "$digitHours:$digitMinutes:$digitSeconds"; // Membuat string waktu saat ini
    setState(() {
      laps.add(lap); // Menambahkan waktu ke dalam list laps
    });
  }

  // * Function untuk memulai stopwatch
  void start() {
    started = true; // Mengubah status menjadi berjalan
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Timer akan berjalan setiap 1 detik
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      // Logika untuk mengatur detik, menit, dan jam agar sesuai
      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours += 1;
          localMinutes = 0;
        } else {
          localMinutes += 1;
          localSeconds = 0;
        }
      }

      setState(() {
        // Memperbarui variabel waktu
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;

        // Mengatur tampilan waktu dalam format dua digit
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "$digitHours:$digitMinutes:$digitSeconds",
                  style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              SizedBox(height: 20.0),
              
              Container(
                constraints: BoxConstraints(maxHeight: 400.0),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 400.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: laps.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${index + 1}. ${laps[index]}",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.0),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: reset,
                      child: Text("Reset"),
                    ),
                  ),

                  IconButton(
                    icon: Icon(Icons.flag, color: Colors.white),
                    onPressed: addLaps,
                  ),
                  
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        (started) ? stop() : start();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[400],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text((!started) ? "Start" : "Pause"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
