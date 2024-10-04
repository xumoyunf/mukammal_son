import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

Response _webhookHandler(Request request) {
  // Bu yerda Telegram webhookini qabul qiluvchi logikani yozing.
  return Response.ok('Bot ishga tushdi');
}

void main() {
  var handler = const Pipeline().addMiddleware(logRequests()).addHandler(_webhookHandler);

  shelf_io.serve(handler, 'localhost', 8080).then((server) {
    print('Server ${server.address.host}:${server.port} da ishlamoqda');
  });
}
