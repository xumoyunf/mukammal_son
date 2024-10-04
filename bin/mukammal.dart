import 'dart:convert';
import 'dart:io' as fileio;
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

List<int> messageIds = [];

Future<void> main(List<String> arguments) async {
  var file = await fileio.File('env.json').readAsString();
  var env = jsonDecode(file);
  final username = (await Telegram(fileio.Platform.environment['token']!).getMe()).username;
  final teledart = TeleDart(fileio.Platform.environment['token']!, Event(username!));
  var webhookUrl =
      'https://vercel.com/alis-projects-bf517144/api/webhook';
  await teledart.setWebhook(
    webhookUrl,
    ipAddress: '0.0.0.0',
  );
  teledart.start();

  teledart.onCommand('start').listen((msg) async {
    await teledart.sendMessage(
      msg.chat.id,
      '''
Assalomu alaykum, ${msg.from?.firstName}!

Men matematik yordamchingizman! Men siz kiritgan sonlarni tahlil qilib, uning quyidagi xususiyatlarini tekshiraman:
- Juft yoki toqligini
- Tub yoki murakkabligini
- Mukammal yoki mukammal emasligini

Siz sonni kiritishingiz mumkin
    ''',
    );
  });

  teledart.onCommand('clear').listen((msg) async {
    for (var messageId in messageIds) {
      try {
        await teledart.deleteMessage(msg.chat.id, messageId);
      } catch (e) {
        print('Xatolik yuz berdi: $e');
        print(msg.text);
      }
    }
    await teledart.deleteMessage(msg.chat.id, msg.messageId);

    messageIds.clear();
  });

  teledart.onCommand('about').listen((msg) async {
    teledart
        .sendMessage(msg.chat.id,
            "Loyihani <a href='${env['project_source']}'>github</a>dan topishingiz mumkin.\n\nDasturchi bilan quyidagi havolalar orqali bo'glanishingiz mumkin",
            parseMode: 'html',
            replyMarkup: InlineKeyboardMarkup(inlineKeyboard: [
              [InlineKeyboardButton(text: 'Github', url: env['github'])],
              [InlineKeyboardButton(text: 'Telegram', url: env['telegram'])],
              [
                InlineKeyboardButton(
                    text: 'Buy me a coffee', url: env['buymeacoffee'])
              ],
            ]))
        .then((msg) => messageIds.add(msg.messageId));
  });

  teledart.onMessage().listen((msg) {
    messageIds.add(msg.messageId);
    checkNumber(teledart, msg);
  });
}

checkNumber(TeleDart teledart, TeleDartMessage msg) async {
  if (int.tryParse(msg.text!).runtimeType == int) {
    String even = checkEven(int.parse(msg.text!));
    String prime = checkPrime(int.parse(msg.text!));
    String perfect = checkPerfectNumber(int.parse(msg.text!));
    await msg
        .reply("$even\n$prime\n$perfect")
        .then((msg) => messageIds.add(msg.messageId));
    // stdout.write("*******************************************************");
  } else {
    await msg
        .reply("Xatolik: Butun son kiriting")
        .then((msg) => messageIds.add(msg.messageId));
    // stdout.write("*******************************************************");
  }
}

checkEven(int number) {
  if (number % 2 == 0) {
    return 'Juft son';
  }
  return 'Toq son';
}

String checkPrime(int number) {
  if (number <= 1) {
    return '1, 0 va manfiy sonlar tub va murakkab sonlar qatoriga kirmaydi!!!';
  } else {
    List<int> multipliers = [];
    for (int i = 2; i < number; i++) {
      if (number % i == 0) {
        multipliers.add(i);
      } else {
        continue;
      }
    }
    return multipliers.isEmpty ? 'Tub son' : 'Murakkab son';
  }
}

String checkPerfectNumber(int number) {
  if (number <= 0) {
    return '0 va manfiy sonlar mukammal son bo\'la olmaydi!!!';
  } else {
    int sum = 0;
    for (int i = 1; i < number; i++) {
      if (number % i == 0) {
        sum += i;
      }
    }
    if (sum == number) {
      return 'Mukammal son';
    } else {
      return 'Mukammal bo\'lmagan son';
    }
  }
}
