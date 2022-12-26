class BaseUrlEntity {
  bool hasSSL;
  String ipAddress1;
  String ipAddress2;
  String ipAddress3;
  String ipAddress4;
  String portNumber;
  String? route;

  BaseUrlEntity({
    this.hasSSL = false,
    required this.ipAddress1,
    required this.ipAddress2,
    required this.ipAddress3,
    required this.ipAddress4,
    required this.portNumber,
    this.route = "/",
  });
}
