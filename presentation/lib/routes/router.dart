import 'package:auto_route/auto_route.dart';

import '../screens/favorites/favorites.dart';
import '../screens/home/home.dart';
import '../screens/navigation/navigation.dart';
import '../screens/others/others.dart';
import '../screens/vouchers/vouchers.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NavigationRoute.page, path: '/', children: [
          AutoRoute(page: HomeRoute.page, path: ''),
          AutoRoute(page: FavoritesRoute.page),
          AutoRoute(page: VouchersRoute.page),
          AutoRoute(page: OthersRoute.page),
        ]),
      ];
}
