import 'package:flutter/material.dart';

class FlutterRoundedButtonAction extends StatelessWidget {
  final String textButtonNegative;
  final String textButtonPositive;
  final String textActionButton;
  final VoidCallback onTapButtonNegative; // Default is "Cancel" button.
  final VoidCallback onTapButtonPositive; // Default is "OK" button.
  final VoidCallback onTapButtonAction; // Default is "Action" button which will be on the left.
  final TextStyle textStyleButtonAction;
  final TextStyle textStyleButtonPositive;
  final TextStyle textStyleButtonNegative;
  final TextStyle textStyleButtonSubmit;
  final MaterialLocalizations localizations;
  final double borderRadius;
  final EdgeInsets paddingActionBar;
  final Color background;
  final Color submitButtonBackground;

  const FlutterRoundedButtonAction(
      {Key key, @required this.localizations, this.textButtonNegative, this.textButtonPositive, this.textActionButton, this.onTapButtonAction, this.onTapButtonPositive, this.onTapButtonNegative, this.textStyleButtonPositive, this.textStyleButtonNegative, this.textStyleButtonAction, this.textStyleButtonSubmit, this.borderRadius, this.paddingActionBar, this.background, this.submitButtonBackground})
      : super(key: key);

  List<Widget> _buildActionsButton(bool isActionButton) {
    final Widget leftButton = isActionButton
        ? FlatButton(
            child: Text(textActionButton, style: textStyleButtonAction),
            onPressed: onTapButtonAction,
          )
        : null;

    final Widget negativeButton = FlatButton(
      child: Text(
        textButtonNegative ?? localizations.cancelButtonLabel,
        style: textStyleButtonNegative,
      ),
      onPressed: onTapButtonNegative,
    );

    final Widget positiveButton = FlatButton(
      child: Text(
        textButtonPositive ?? localizations.okButtonLabel,
        style: textStyleButtonPositive,
      ),
      onPressed: onTapButtonPositive,
    );

    final Widget submitButton = GestureDetector(
      onTap: onTapButtonPositive,
      child: Container(
        child: Center(
          child: Text(
            'Select',
            style: textStyleButtonSubmit,
          ),
        ),
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: submitButtonBackground,
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
      ),
    );

    if (isActionButton) {
      return [
        leftButton,
        Row(children: <Widget>[negativeButton, positiveButton])
      ];
    }

    // return [negativeButton, positiveButton];
    return [submitButton];
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      // height: 200,
      padding: paddingActionBar,
      decoration: BoxDecoration(
          color: background,
          // color: Colors.red,
          borderRadius: orientation == Orientation.landscape ? BorderRadius.only(bottomRight: Radius.circular(borderRadius)) : BorderRadius.vertical(bottom: Radius.circular(borderRadius))),
      child: ButtonBar(
        alignment: textActionButton != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
        children: _buildActionsButton(textActionButton != null),
      ),
      // child: Center(
      //   child: Expanded(
      //     child: Container(
      //       color: Colors.pink,
      //     ),
      //   ),
      // ),
    );
  }
}
