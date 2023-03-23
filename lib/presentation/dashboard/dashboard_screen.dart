import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app_constants.dart';
import '../../classes/navigation_destination.dart';
import 'cubit/dashboard_cubit.dart';



class DashboardScreen extends StatefulWidget {
  final Widget child;
  final String location;
  const DashboardScreen({Key? key, required this.child, required this.location}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<NavigationDestinations> destinations = [
    NavigationDestinations(
        icon: const Icon(Icons.library_books_outlined),
        selectedIcon: const Icon(Icons.library_books_rounded),
        label: 'Home',
        route: RoutesName.home),
    NavigationDestinations(
        icon: const Icon(Icons.notifications_none),
        selectedIcon: const Icon(Icons.notifications),
        label: 'About',
        route: RoutesName.about),
    NavigationDestinations(
        icon: const Icon(Icons.archive_outlined),
        selectedIcon: const Icon(Icons.archive),
        label: 'Projects',
        route: RoutesName.contact),
    NavigationDestinations(
        icon: const Icon(CupertinoIcons.trash),
        selectedIcon: const Icon(CupertinoIcons.trash_fill),
        label: 'Contact',
        route: RoutesName.projects),
  ];

  int getCurrentIndex() {
    switch (widget.location) {
      case RoutesName.about:
        return 1;
      case RoutesName.contact:
        return 3;
      case RoutesName.projects:
        return 4;
      default:
        return 0;
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, dimens) {
              return Scaffold(
                backgroundColor: Colors.white,

                body: Row(
                  children: [
                    NavigationRail(
                        onDestinationSelected: (value) {
                          context
                              .read<DashboardCubit>()
                              .onDrawerItemSelected(value);

                          context.go(destinations[value].route);
                        },
                        extended: dimens.maxWidth >= 800,
                        destinations: destinations
                            .map((e) => NavigationRailDestination(
                            icon: e.icon,
                            selectedIcon: e.selectedIcon,
                            label: Text(
                              e.label,

                            )))
                            .toList(),
                        selectedIndex: getCurrentIndex()),
                    Expanded(
                      child: widget.child,
                    )
                    //Expanded(child: widget.child),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
