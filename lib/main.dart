// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:push/home.dart';

import 'notification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  // void initState() {
  //   super.initState();
  //   NotificationApi.init();
  //   listenNotification();
  // }

  // void listenNotification() =>
  //     NotificationApi.onNotifications.stream.listen((event) {
  //       onClickNotification;
  //     });

  // void onClickNotification(String? payload) => Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => SecondPage(payload: payload),
  //       ),
  //     );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('push notifications'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 10.0),
              ElevatedButton(
                child: Text('simple notification'),
                onPressed: () => NotificationApi.showNotification(
                  title: 'Rohan Veer',
                  body: 'hey! your interview is about to start. All the best!!',
                  payload: 'rohan.veer',
                ),
              ),
              SizedBox(height: 10.0),
              Builder(
                builder: (context) => ElevatedButton(
                  child: Text('cloud notification'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.0),
              // ElevatedButton(
              //   child: Text('remove notifications'),
              //   onPressed: () => print('simple notification'),
              // ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
