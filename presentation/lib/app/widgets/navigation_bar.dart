import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key, required this.onTabSelected, this.selectedIndex = 0});

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              NavigationButton(
                icon: 'assets/icons/home-outlined.svg',
                activeIcon: 'assets/icons/home-solid.svg',
                label: 'Home',
                isActive: selectedIndex == 0,
                onTap: () => onTabSelected(0),
              ),
              NavigationButton(
                icon: 'assets/icons/heart-outlined.svg',
                activeIcon: 'assets/icons/heart-solid.svg',
                label: 'Favorites',
                isActive: selectedIndex == 1,
                onTap: () => onTabSelected(1),
              ),
              NavigationButton(
                icon: 'assets/icons/tag-outlined.svg',
                activeIcon: 'assets/icons/tag-solid.svg',
                label: 'Vouchers',
                isActive: selectedIndex == 2,
                onTap: () => onTabSelected(2),
              ),
              NavigationButton(
                icon: 'assets/icons/horizontal-menu-circle-outlined.svg',
                activeIcon: 'assets/icons/horizontal-menu-circle-solid.svg',
                label: 'Others',
                isActive: selectedIndex == 3,
                onTap: () => onTabSelected(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationButton extends StatefulWidget {
  const NavigationButton({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  final String icon;
  final String activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> with SingleTickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 200);
  late final AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late SvgPicture icon;

  @override
  void initState() {
    super.initState();
    icon = SvgPicture.asset(
      widget.icon,
      width: 16,
      height: 16,
    );
    _controller = AnimationController(vsync: this, duration: duration)..addListener(() => setState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setColor();
  }

  @override
  void didUpdateWidget(covariant NavigationButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      setColor();
    }
  }

  void setColor() {
    if (widget.isActive) {
      icon = SvgPicture.asset(
        key: UniqueKey(),
        widget.activeIcon,
        width: 16,
        height: 16,
        colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
      );
      _controller.forward();
    } else {
      icon = SvgPicture.asset(
        key: UniqueKey(),
        widget.icon,
        width: 16,
        height: 16,
      );

      _controller.reverse();
    }
    final colorTween =
        ColorTween(begin: Theme.of(context).colorScheme.onBackground, end: Theme.of(context).colorScheme.primary);
    _colorAnimation = colorTween
        .animate(CurvedAnimation(parent: _controller, curve: widget.isActive ? Curves.easeInExpo : Curves.easeOutCirc));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: widget.onTap,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  AnimatedSwitcher(
                    duration: duration,
                    child: icon,
                  ),
                  Text(
                    widget.label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: _colorAnimation.value),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
