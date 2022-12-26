import 'package:staging_network_configuration/core/constants/colors.dart';

enum ConnectionStatus {
  inactive,
  connected,
  error,
}

extension ConnectionStatusExt on ConnectionStatus {
  getDisplayName() {
    switch (this) {
      case ConnectionStatus.inactive:
        return "Inactive";
      case ConnectionStatus.connected:
        return "Connected";
      case ConnectionStatus.error:
        return "Error";
    }
  }

  getColor() {
    switch (this) {
      case ConnectionStatus.inactive:
        return lightGray;
      case ConnectionStatus.connected:
        return online;
      case ConnectionStatus.error:
        return error;
    }
  }
}
