import 'dart:convert';
import 'dart:io';

import 'package:app_shortcuts/utils/ios_tutorial.dart';
import 'package:dia/dia.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AppShortcuts {
  static const MethodChannel _channel = MethodChannel('app_shortcuts');

  static Future<void> _openIOSShortcutGenerator(
    String link,
    String title,
    String imageUrl, {
    String? description,
    String? shareButtonDescription,
    String? addToHomescreenButtonDescription,
  }) async {
    final html = getIosTutorialHTML(link, title, description, imageUrl,
        shareButtonDescription: shareButtonDescription,
        addToHomescreenButtonDescription: addToHomescreenButtonDescription,);
    const address = 'localhost';
    final diaApp = App();
    // ignore: missing_return
    diaApp.use((ctx, next) async {
      final uri = Uri.dataFromString(html,
          mimeType: "text/html", base64: true, encoding: const Utf8Codec(),);
      ctx.response.redirect(uri);
      diaApp.close();
    });
    await diaApp
        .listen(address, 8080)
        .then((value) => print('Server started!'))
        .catchError(print);
    try {
      await launchUrl(Uri.parse('http://$address:8080/'));
    } catch (error) {
      print(error);
    }
  }

  static Future<void> _createAndroidShortcut(
      String id, String link, String title, String imageUrl,) async {
    return _channel.invokeMethod('createAndroidShortcut', {
      'title': title,
      'id': id,
      'link': link,
      'imageUrl': imageUrl,
    });
  }

  static Future<void> createShortcut({
    /// the name of the shortcut in the home screen
    required String title,

    /// the link for the shortcut to open, most likely a deep link
    required String link,

    /// a string identifier used to let android identify the shortcut
    required String id,

    /// an image url for the shortcut
    /// it will also be used in the tutorial page on iOS
    required String imageUrl,

    /// a description used for the tutorial page on iOS
    String? description,

    /// a description used to prompt the user to click the share button on safari
    String? shareButtonDescription,

    /// a description used to prompt the user to click on the 'Add to homescreen' button on safari
    String? addToHomescreenButtonDescription,
  }) {
    if (Platform.isAndroid) {
      return _createAndroidShortcut(id, link, title, imageUrl);
    } else if (Platform.isIOS) {
      return _openIOSShortcutGenerator(
        link,
        title,
        imageUrl,
        description: description,
        shareButtonDescription: shareButtonDescription,
        addToHomescreenButtonDescription: addToHomescreenButtonDescription,
      );
    } else {
      throw 'not-supported';
    }
  }
}
