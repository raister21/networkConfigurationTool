import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:staging_network_configuration/core/constants/colors.dart';
import 'package:staging_network_configuration/core/constants/configEnums.dart';
import 'package:staging_network_configuration/core/entities/base_url_entity.dart';
import 'package:staging_network_configuration/core/entities/terminal_message_entity.dart';
import 'package:staging_network_configuration/core/utils/url_helper.dart';
import 'package:staging_network_configuration/core/widgets/configInputBox.dart';

class ConfigurationScreen extends StatefulWidget {
  final String appName;
  final Function(String) completionCallback;
  final String? initialBaseurl;
  const ConfigurationScreen({
    Key? key,
    required this.completionCallback,
    required this.appName,
    this.initialBaseurl,
  }) : super(key: key);

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  final List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  UrlHelper urlHelper = UrlHelper();
  late BaseUrlEntity baseUrlEntity;
  List<String> terminalMessages = [];

  ConnectionStatus connectionStatus = ConnectionStatus.inactive;

  bool isProcessing = false;

  @override
  void initState() {
    if (widget.initialBaseurl != null) {
      baseUrlEntity = urlHelper.decodeInitalBaseUrl(widget.initialBaseurl!);
    } else {
      baseUrlEntity = BaseUrlEntity(
        ipAddress1: "192",
        ipAddress2: "168",
        ipAddress3: "1",
        ipAddress4: "70",
        portNumber: "3007",
      );
    }

    terminalMessages.add(
        "${widget.appName}: Initialized with ${baseUrlEntity.hasSSL ? 'https://' : 'http://'}${baseUrlEntity.ipAddress1}.${baseUrlEntity.ipAddress2}.${baseUrlEntity.ipAddress3}.${baseUrlEntity.ipAddress4}:${baseUrlEntity.portNumber}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        elevation: 0,
        titleSpacing: 18,
        backgroundColor: primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "FS Network Configuration tool",
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            InkWell(
              onTap: () {},
              child: const Text(
                "",
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildIpAddressSection(),
              buildPortNumberRouteSection(),
              buildConnectivityDetailsSection(
                currentUrl: urlHelper.getConnectionUrl(baseUrlEntity),
                baseUrl: urlHelper.getBaseUrl(baseUrlEntity),
              ),
              const Divider(
                color: lightGray,
              ),
              buildProceedButton(),
            ],
          ),
        ),
      ),
    );
  }

  buildIpAddressSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "IP Address",
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: black,
                  ),
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(
                        "SSL",
                        style: TextStyle(
                          fontSize: 10,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          baseUrlEntity.hasSSL = !baseUrlEntity.hasSSL;
                        });
                      },
                      child: Container(
                        height: 20,
                        width: 42,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            border: Border.all(color: lightGray),
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          alignment: baseUrlEntity.hasSSL
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: baseUrlEntity.hasSSL ? primary : lightGray,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ConfigInputBox(
                  hintText: baseUrlEntity.ipAddress1,
                  textEditingController: controllers[0],
                  focusNode: focusNodes[0],
                  completeFieldCallback: () {
                    focusNodes[1].requestFocus();
                  },
                  onChange: (value) {
                    if (value != null) {
                      setState(() {
                        baseUrlEntity.ipAddress1 = value;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ConfigInputBox(
                  hintText: baseUrlEntity.ipAddress2,
                  textEditingController: controllers[1],
                  focusNode: focusNodes[1],
                  completeFieldCallback: () {
                    focusNodes[2].requestFocus();
                  },
                  onChange: (value) {
                    if (value != null) {
                      setState(() {
                        baseUrlEntity.ipAddress2 = value;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ConfigInputBox(
                hintText: baseUrlEntity.ipAddress3,
                textEditingController: controllers[2],
                focusNode: focusNodes[2],
                completeFieldCallback: () {
                  focusNodes[3].requestFocus();
                },
                onChange: (value) {
                  if (value != null) {
                    setState(() {
                      baseUrlEntity.ipAddress3 = value;
                    });
                  }
                },
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ConfigInputBox(
                hintText: baseUrlEntity.ipAddress4,
                textEditingController: controllers[3],
                focusNode: focusNodes[3],
                completeFieldCallback: () {
                  focusNodes[4].requestFocus();
                },
                onChange: (value) {
                  if (value != null) {
                    setState(() {
                      baseUrlEntity.ipAddress4 = value;
                    });
                  }
                },
              )),
            ],
          )
        ],
      ),
    );
  }

  buildPortNumberRouteSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text(
              "Port number & Route",
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: black,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ConfigInputBox(
                  hintText: baseUrlEntity.portNumber,
                  textEditingController: controllers[4],
                  focusNode: focusNodes[4],
                  completeFieldCallback: () {
                    focusNodes[5].requestFocus();
                  },
                  onChange: (value) {
                    if (value != null) {
                      setState(() {
                        baseUrlEntity.portNumber = value;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConfigInputBox(
                      hintText: baseUrlEntity.route,
                      textEditingController: controllers[5],
                      focusNode: focusNodes[5],
                      completeFieldCallback: () {},
                      onChange: (value) {
                        if (value != null) {
                          setState(() {
                            baseUrlEntity.route = value;
                          });
                        }
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 6.0),
                      child: Text(
                        "Additional route (can be empty)",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: darkGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  buildConnectivityDetailsSection(
      {required String currentUrl, required String baseUrl}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text(
              "Connection Details",
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Connection URL: $currentUrl",
              style: const TextStyle(
                fontSize: 12,
                height: 1.5,
                fontWeight: FontWeight.w300,
                color: black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Base API URL: $baseUrl",
              style: const TextStyle(
                fontSize: 12,
                height: 1.5,
                fontWeight: FontWeight.w300,
                color: black,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "Status: ${connectionStatus.getDisplayName()}",
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  fontWeight: FontWeight.w300,
                  color: black,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 4),
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: connectionStatus.getColor(),
                ),
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 8),
            color: terminalBlack,
            padding: const EdgeInsets.all(4),
            child: ListView.builder(
                itemCount: terminalMessages.length,
                itemBuilder: (context, index) {
                  return Text(
                    terminalMessages[index],
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  );
                }),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () async {
                if (!isProcessing) {
                  setState(() {
                    isProcessing = true;
                  });
                  DateTime timeNow = DateTime.now();
                  try {
                    http.Response? response =
                        await http.get(Uri.parse(currentUrl));

                    if (response.statusCode == 200) {
                      terminalMessages.add(
                        urlHelper.getTerminalMessage(
                          TerminalMessageEntity(
                            response.statusCode,
                            timeNow.difference(DateTime.now()).inMilliseconds,
                            "SUCCESS",
                            baseUrlEntity,
                            widget.appName,
                          ),
                        ),
                      );
                      setState(() {
                        connectionStatus = ConnectionStatus.connected;
                      });
                    } else {
                      terminalMessages.add(
                        urlHelper.getTerminalMessage(
                          TerminalMessageEntity(
                            response.statusCode,
                            timeNow.difference(DateTime.now()).inMilliseconds,
                            "ERROR",
                            baseUrlEntity,
                            widget.appName,
                          ),
                        ),
                      );
                      setState(() {
                        connectionStatus = ConnectionStatus.error;
                      });
                    }
                  } catch (e) {
                    terminalMessages.add(
                      urlHelper.getTerminalMessage(
                        TerminalMessageEntity(
                          null,
                          timeNow.difference(DateTime.now()).inMilliseconds,
                          "ERROR",
                          baseUrlEntity,
                          widget.appName,
                        ),
                      ),
                    );
                    setState(() {
                      connectionStatus = ConnectionStatus.error;
                    });
                  }
                  setState(() {
                    isProcessing = false;
                  });
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: primary,
                ),
                child: isProcessing
                    ? const SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Connect",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildProceedButton() {
    return InkWell(
      onTap: () {
        if (connectionStatus == ConnectionStatus.connected) {
          widget.completionCallback(
            urlHelper.getBaseUrl(baseUrlEntity),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 36),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: (connectionStatus == ConnectionStatus.connected)
              ? primary
              : primary.withOpacity(0.5),
        ),
        child: const Center(
          child: Text(
            "Proceed",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
