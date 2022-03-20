// ignore_for_file: prefer_const_constructors

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();

  static final onNotifications = BehaviorSubject<String?>();
  static final icon = "mipmap/ic_launcher";
  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        icon: icon,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  // static Future init({bool initScheduled = false}) async {
  //   final android = AndroidInitializationSettings(icon);
  //   final Ios = IOSInitializationSettings();
  //   final initializationSettings =
  //       InitializationSettings(android: android, iOS: Ios);

  //   await _notification.initialize(
  //     initializationSettings,
  //     onSelectNotification: ((payload) async {
  //       onNotifications.add(payload);
  //     }),
  //   );
  // }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notification.show(id, title, body, await _notificationDetails(),
          payload: payload);
}
