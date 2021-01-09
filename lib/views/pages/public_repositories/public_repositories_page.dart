import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../services/network_service.dart';
import 'public_repositories_page_controller.dart';
import 'widgets/repository_card.dart';

class PublicRepositoriesPage extends StatelessWidget {
  final controller = Get.put(PublicRepositoriesPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repositórios Públicos'),
      ),
      body: Stack(
        children: [
          _buildContent(),
          _buildNetworkOffBottomWarning(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Obx(() {
      Widget reloadButton = FlatButton(
        onPressed: controller.fetchRepositories,
        child: Text(
          'Recarregar',
          style: TextStyle(color: Colors.white),
        ),
        color: Get.theme.primaryColor,
      );

      switch (controller.state) {
        case ControllerState.initial:
          return _buildMessage(
            icon: NetworkService.to.isOffline ? Icons.wifi_off : null,
            message: NetworkService.to.isOffline ? 'Sem conexão' : null,
            button: NetworkService.to.isOnline ? reloadButton : null,
          );

        case ControllerState.hasError:
          return _buildMessage(
            icon: Icons.error_outline,
            message: 'Ocorreu um erro inesperado',
            button: NetworkService.to.isOnline ? reloadButton : null,
          );

        case ControllerState.hasData:
          return controller.repositories.isEmpty
              ? Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: controller.refreshRepositories,
                      child: ListView(),
                    ),
                    _buildMessage(
                      icon: Icons.menu,
                      message: 'Nenhum item encontrado',
                    ),
                  ],
                )
              : RefreshIndicator(
                  onRefresh: controller.refreshRepositories,
                  child: ListView.separated(
                    padding: EdgeInsets.all(20),
                    itemCount: controller.repositories.length,
                    itemBuilder: (context, index) {
                      return RepositoryCard(controller.repositories[index]);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                  ),
                );

        default:
          return Center(
            child: SpinKitThreeBounce(
              size: 22,
              color: Get.theme.primaryColor,
            ),
          );
      }
    });
  }

  Widget _buildMessage({IconData icon, String message, Widget button}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 64,
            ),
          if (message != null) ...[
            if (icon != null) SizedBox(height: 20),
            Text(message),
            if (button != null) SizedBox(height: 20),
          ],
          if (button != null) button,
        ],
      ),
    );
  }

  Widget _buildNetworkOffBottomWarning() {
    final top = Get.height - kToolbarHeight - Get.mediaQuery.padding.top;

    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromLTRB(0, top, 0, 0),
        end: RelativeRect.fromLTRB(0, top - 45, 0, 0),
      ).animate(CurvedAnimation(
        parent: controller.networkMessageAnimController,
        curve: Curves.fastOutSlowIn,
      )),
      child: Material(
        elevation: 8,
        color: Get.theme.primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off,
                color: Colors.white,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  'Sem conexão',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
