import 'package:flutter/material.dart';
import 'package:staging_network_configuration/core/constants/colors.dart';

class ConfigInputBox extends StatefulWidget {
  final String? hintText;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final Function() completeFieldCallback;
  final Function(String?) onChange;
  final TextInputType? textInputType;
  const ConfigInputBox({
    Key? key,
    required this.focusNode,
    required this.textEditingController,
    this.hintText,
    required this.completeFieldCallback,
    this.textInputType = TextInputType.number,
    required this.onChange,
  }) : super(key: key);

  @override
  State<ConfigInputBox> createState() => _ConfigInputBoxState();
}

class _ConfigInputBoxState extends State<ConfigInputBox> {
  String? localHintText;
  @override
  initState() {
    localHintText = widget.hintText;
    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        setState(() {
          localHintText = null;
        });
      } else {
        setState(() {
          localHintText = widget.hintText;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        key: widget.key,
        focusNode: widget.focusNode,
        controller: widget.textEditingController,
        textAlign: TextAlign.center,
        onChanged: widget.onChange,
        onEditingComplete: widget.completeFieldCallback,
        keyboardType: widget.textInputType,
        style: const TextStyle(
          fontSize: 16,
          height: 1,
          color: black,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: "",
          isDense: false,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintStyle: const TextStyle(
            fontSize: 16,
            height: 1,
            color: black25,
            fontWeight: FontWeight.w600,
          ),
          hintText: localHintText,
        ),
      ),
    );
    ;
  }
}
