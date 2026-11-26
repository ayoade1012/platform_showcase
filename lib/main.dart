import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const PlatformShowcaseApp());
}

/// Returns a human-readable name for the platform the app is running on.
///
/// [kIsWeb] is checked first because [defaultTargetPlatform] on the web
/// reflects the host OS of the browser, not the web target itself.
String currentPlatformName() {
  if (kIsWeb) return 'Web';
  return switch (defaultTargetPlatform) {
    TargetPlatform.android => 'Android',
    TargetPlatform.iOS => 'iOS',
    TargetPlatform.windows => 'Windows',
    TargetPlatform.macOS => 'macOS',
    TargetPlatform.linux => 'Linux',
    TargetPlatform.fuchsia => 'Fuchsia',
  };
}

class PlatformShowcaseApp extends StatelessWidget {
  const PlatformShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platform Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ShowcaseHomePage(),
    );
  }
}

class ShowcaseHomePage extends StatefulWidget {
  const ShowcaseHomePage({super.key});

  @override
  State<ShowcaseHomePage> createState() => _ShowcaseHomePageState();
}

class _ShowcaseHomePageState extends State<ShowcaseHomePage> {
  int _counter = 0;

  void _increment() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    final platform = currentPlatformName();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform Showcase'),
        backgroundColor: colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _iconFor(platform),
                  size: 72,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Running on $platform',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'One Dart codebase • six platform folders',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Taps this session',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '$_counter',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(color: colorScheme.primary),
                        ),
                        const SizedBox(height: 12),
                        FilledButton.icon(
                          onPressed: _increment,
                          icon: const Icon(Icons.add),
                          label: const Text('Increment'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: const [
                    Chip(label: Text('Android')),
                    Chip(label: Text('iOS')),
                    Chip(label: Text('Web')),
                    Chip(label: Text('Windows')),
                    Chip(label: Text('macOS')),
                    Chip(label: Text('Linux')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconFor(String platform) {
    return switch (platform) {
      'Android' => Icons.android,
      'iOS' => Icons.apple,
      'Web' => Icons.language,
      'Windows' => Icons.desktop_windows,
      'macOS' => Icons.laptop_mac,
      'Linux' => Icons.computer,
      _ => Icons.apps,
    };
  }
}
