import 'package:staging_network_configuration/core/entities/base_url_entity.dart';
import 'package:staging_network_configuration/core/entities/terminal_message_entity.dart';

class UrlHelper {
  getSSLString(bool hasSSL) {
    if (hasSSL) {
      return "https://";
    } else {
      return "http://";
    }
  }

  getBaseUrl(BaseUrlEntity baseUrlEntity) {
    return "${getSSLString(baseUrlEntity.hasSSL)}${baseUrlEntity.ipAddress1}.${baseUrlEntity.ipAddress2}.${baseUrlEntity.ipAddress3}.${baseUrlEntity.ipAddress4}:${baseUrlEntity.portNumber}${baseUrlEntity.route}";
  }

  getConnectionUrl(BaseUrlEntity baseUrlEntity) {
    return "${getSSLString(baseUrlEntity.hasSSL)}${baseUrlEntity.ipAddress1}.${baseUrlEntity.ipAddress2}.${baseUrlEntity.ipAddress3}.${baseUrlEntity.ipAddress4}:${baseUrlEntity.portNumber}";
  }

  decodeInitalBaseUrl(String baseUrl) {
    List<String> sslSplited = baseUrl.split("://");
    String urlWithoutSSL = sslSplited[1];

    bool hasSSl = sslSplited.first.length > 4;
    String ipAddress1 = urlWithoutSSL.split(".")[0];
    String ipAddress2 = urlWithoutSSL.split(".")[1];
    String ipAddress3 = urlWithoutSSL.split(".")[2];
    String ipAddress4 = urlWithoutSSL.split(".")[3].split(":").first;
    List<String> portRouteSplit = urlWithoutSSL.split(":")[1].split("/");
    String portNumber = portRouteSplit.first;
    String? route;
    if (portRouteSplit.length > 1) {
      if (portRouteSplit[1].isNotEmpty) {
        route = '/${portRouteSplit[1]}';
      }
    }

    return BaseUrlEntity(
      hasSSL: hasSSl,
      ipAddress1: ipAddress1,
      ipAddress2: ipAddress2,
      ipAddress3: ipAddress3,
      ipAddress4: ipAddress4,
      portNumber: portNumber,
      route: route,
    );
  }

  getTerminalMessage(TerminalMessageEntity terminalMessageEntity) {
    if (terminalMessageEntity.baseUrlEntity != null) {
      return "${terminalMessageEntity.appName}: ${terminalMessageEntity.message} ${getConnectionUrl(terminalMessageEntity.baseUrlEntity!)} --${terminalMessageEntity.processTime}ms --${terminalMessageEntity.statusCode}";
    } else {
      return "${terminalMessageEntity.appName}: ${terminalMessageEntity.message} --${terminalMessageEntity.processTime}ms --${terminalMessageEntity.statusCode ?? ''}";
    }
  }
}
