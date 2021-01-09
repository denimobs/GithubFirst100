import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

class NetworkService extends GetxController {
  static NetworkService get to => Get.find();

  StreamSubscription _subscription;

  final _rxIsOnline = false.obs;
  RxBool get rxIsOnline => _rxIsOnline;
  bool get isOnline => _rxIsOnline.value;
  bool get isOffline => !_rxIsOnline.value;

  /// Faz uma verificação inicial no status de conexão e adiciona um listener
  /// para salvar o status toda vez que houver alteração
  Future<void> init() async {
    final connectivity = Connectivity();
    final status = await connectivity.checkConnectivity();

    _rxIsOnline.value = status != ConnectivityResult.none;

    _subscription = connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) =>
          _rxIsOnline.value = result != ConnectivityResult.none,
    );
  }

  @override
  void onClose() {
    super.onClose();

    if (_subscription != null) _subscription.cancel();
  }
}
