import 'package:flutter_dotenv/flutter_dotenv.dart';

class Configs {
  static String publicKey = dotenv.env['PUBLIC_KEY'] ?? '';
  static String privateKey = dotenv.env['PRIVATE_KEY'] ?? '';
}
