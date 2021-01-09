import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../views/components/custom_toast.dart';

abstract class Toasts {
  static void _showToast(Widget child) {
    showToastWidget(
      child,
      position: ToastPosition.bottom,
      dismissOtherToast: true,
      duration: Duration(seconds: 3),
      handleTouch: true,
    );
  }

  static void showErrorToast(String message) {
    _showToast(CustomToast(
      color: Colors.red,
      icon: Icon(Icons.highlight_off),
      message: message,
      title: 'Erro',
    ));
  }

  static void showSuccessToast(String message) {
    _showToast(CustomToast(
      color: Colors.green,
      icon: Icon(Icons.check_circle_outline),
      message: message,
      title: 'Sucesso',
    ));
  }

  static void showWarningToast(String message) {
    _showToast(CustomToast(
      color: Colors.yellow[900],
      icon: Icon(Icons.info_outline),
      message: message,
      title: 'Aviso',
    ));
  }
}
