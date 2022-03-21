// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push/home.dart';
import 'notification.dart';

const channel = AndroidNotificationChannel(
  'high_imp_channel',
  'high imp channel',
  description: 'this channel is imp',
  importance: Importance.high,
  playSound: true,
);

final _notification = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('a bg message : ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await _notification
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
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
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (notification != null && androidNotification != null) {
        _notification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Colors.blue,
              playSound: true,
              icon: 'mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('new onmessageOpenedapp even was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (notification != null && androidNotification != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                  title: Text(notification.title!),
                  content: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  )));
            });
      }
    });
  }

  void showNotification() {
    setState(() {});
    _notification.show(
      0,
      'testing',
      'how you doin?',
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          color: Colors.blue,
              playSound: true,
              icon: 'mipmap/ic_launcher',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Push Notification',
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
                    showNotification();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const HomePage(),
                      // ),
                    // );
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
