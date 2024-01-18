import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../routes/router.dart';
import 'widgets/navigation_bar.dart';

@RoutePage()
class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
        routes: const [
          HomeRoute(),
          FavoritesRoute(),
          VouchersRoute(),
          OthersRoute(),
        ],
        transitionBuilder: (context, child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            bottomNavigationBar: CustomNavigationBar(
              selectedIndex: tabsRouter.activeIndex,
              onTabSelected: (index) {
                tabsRouter.setActiveIndex(index);
              },
            ),
            body: child,
          );
        });
  }
}
