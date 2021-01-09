import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import 'services/github_api.dart';
import 'services/network_service.dart';
import 'utils/color.dart';
import 'views/pages/public_repositories/public_repositories_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // por possuir somente serviços básicos cuja a inicialização é praticamente
  // insignificante nao tem problema iniciar aqui.
  // caso possa levar mais que alguns milissegundos utilizar alguma outro
  // método de inicialização como um splash screen.
  await _initApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        title: 'GitFirst100',
        theme: ThemeData(
          primarySwatch: hexToMaterialColor('#24292e'),
        ),
        home: PublicRepositoriesPage(),
      ),
    );
  }
}

/// Garante que os serviços essenciais para a aplicação estejam disponiveis e inicializados
Future<void> _initApp() async {
  Get.lazyPut<GithubApi>(() => GithubApi());
  Get.lazyPut<NetworkService>(() => NetworkService());
  await NetworkService.to.init();
}
