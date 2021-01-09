import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
  final String destinationUrl;

  ConfirmationDialog(this.destinationUrl);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: Get.width * 0.8,
        height: 170,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Alerta de redirecionamento',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Deseja navegar para o link $destinationUrl ?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: () => Get.back(result: true),
                    child: Text(
                      'Continuar',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Get.theme.primaryColor,
                  ),
                  SizedBox(width: 10),
                  FlatButton(
                    onPressed: () => Get.back(result: false),
                    child: Text('Cancelar'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
