import 'package:staging_network_configuration/core/entities/base_url_entity.dart';

class TerminalMessageEntity {
  final String appName;
  final int? statusCode;
  final int processTime;
  final String message;
  final BaseUrlEntity? baseUrlEntity;

  TerminalMessageEntity(
    this.statusCode,
    this.processTime,
    this.message,
    this.baseUrlEntity,
    this.appName,
  );
}
