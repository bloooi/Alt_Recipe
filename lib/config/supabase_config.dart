import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Supabase configuration loaded from environment variables
class SupabaseConfig {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';

  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  static String get googleWebClientId =>
      dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? '';

  static String get googleIosClientId =>
      dotenv.env['GOOGLE_IOS_CLIENT_ID'] ?? '';

  /// Validate that all required environment variables are set
  static void validate() {
    if (supabaseUrl.isEmpty) {
      throw Exception('SUPABASE_URL is not set in .env file');
    }
    if (supabaseAnonKey.isEmpty) {
      throw Exception('SUPABASE_ANON_KEY is not set in .env file');
    }
    if (googleWebClientId.isEmpty) {
      throw Exception('GOOGLE_WEB_CLIENT_ID is not set in .env file');
    }
    if (googleIosClientId.isEmpty) {
      throw Exception('GOOGLE_IOS_CLIENT_ID is not set in .env file');
    }
  }
}
