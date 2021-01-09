import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../models/github_repository.dart';
import '../public_repositories_page_controller.dart';

class RepositoryCard extends StatefulWidget {
  final GithubRepository repository;

  RepositoryCard(this.repository);

  @override
  _RepositoryCardState createState() => _RepositoryCardState();
}

class _RepositoryCardState extends State<RepositoryCard>
    with SingleTickerProviderStateMixin {
  final pageController = PublicRepositoriesPageController.to;

  AnimationController expandController;
  Animation<double> animation;

  bool expanded = false;

  void toggleExpanded() {
    setState(() {
      expanded = !expanded;
    });

    if (expanded) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  GithubRepository get repository => widget.repository;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () => toggleExpanded(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Container(
                      height: _minCardHeight,
                      width: _minCardHeight,
                      child: CachedNetworkImage(
                        imageUrl: repository.owner.avatarUrl,
                        progressIndicatorBuilder: (context, url, progress) {
                          return SpinKitDualRing(color: Get.theme.primaryColor);
                        },
                        errorWidget: (context, url, error) {
                          return Center(
                            child: Icon(
                              Icons.error_outline,
                              size: 48,
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: _minCardHeight,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              repository.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            Text(
                              repository.owner.login,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.link),
                      onPressed: () =>
                          pageController.selectRepository(repository),
                    ),
                  ],
                ),
              ),
              SizeTransition(
                axisAlignment: 1.0,
                sizeFactor: animation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(repository.description ?? 'Sem descrição'),
                ),
              ),
              RotationTransition(
                turns: Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
                  parent: expandController,
                  curve: Curves.fastOutSlowIn,
                )),
                child: Icon(Icons.expand_more),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _minCardHeight = 80.0;
