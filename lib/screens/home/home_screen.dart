import 'package:flutter/material.dart';
import 'package:isango_app/screens/shared/placeholder_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showedSuccessMessage = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_showedSuccessMessage) {
      return;
    }

    final message = ModalRoute.of(context)?.settings.arguments as String?;
    if (message == null || message.isEmpty) {
      return;
    }

    _showedSuccessMessage = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const IsangoPlaceholderScreen(
      title: 'Isango Home',
      message: 'This will be implemented in our next recording',
      currentIndex: 0,
      showBottomNavigation: true,
    );
  }
}
