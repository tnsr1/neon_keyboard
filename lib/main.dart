import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neon Keyboard',
      theme: ThemeData.dark(),
      home: const NeonKeyboard(),
    );
  }
}

// === КОНСТАНТЫ ===

class KeyCodes {
  static const shift = 16;
  static const ctrl = 17;
  static const alt = 18;
  static const win = 91;
  static const esc = 27;
  static const backspace = 8;
  static const tab = 9;
  static const capsLock = 20;
  static const enter = 13;
  static const space = 32;
}

class KeyboardColors {
  static const pink = Colors.pink;
  static const blue = Colors.blue;
  static const green = Colors.green;
  static const cyan = Colors.cyan;
  static const purple = Colors.purple;
  static const orange = Colors.orange;
}

// === DATA ===

class KeyData {
  final String label;
  final int keyCode;
  final Color borderColor;
  final int flex;
  final bool isModifier;
  final String? shiftLabel;

  const KeyData({
    required this.label,
    required this.keyCode,
    required this.borderColor,
    this.flex = 1,
    this.isModifier = false,
    this.shiftLabel,
  });
}

// === MAIN SCREEN ===

class NeonKeyboard extends StatefulWidget {
  const NeonKeyboard({super.key});

  @override
  State<NeonKeyboard> createState() => _NeonKeyboardState();
}

class _NeonKeyboardState extends State<NeonKeyboard> {
  String lastKeyCode = '';
  bool isShiftPressed = false;
  bool isCtrlPressed = false;
  bool isAltPressed = false;
  bool isWinPressed = false;
  bool isCapsPressed = false; // ← ДОБАВЛЕНО
  String currentLayout = 'EN';

  void sendKeyToHarbour(int keyCode, {bool isModifier = false}) {
    setState(() {
      lastKeyCode = 'KeyCode: $keyCode';

      if (isModifier) {
        // Обработка переключения модификаторов
        switch (keyCode) {
          case KeyCodes.shift:
            isShiftPressed = !isShiftPressed;
            break;
          case KeyCodes.ctrl:
            isCtrlPressed = !isCtrlPressed;
            break;
          case KeyCodes.alt:
            isAltPressed = !isAltPressed;
            break;
          case KeyCodes.win:
            isWinPressed = !isWinPressed;
            break;
          case KeyCodes.capsLock:
            isCapsPressed = !isCapsPressed;
            break;
        }
      } else {
        // Сброс модификаторов (кроме CapsLock) при нажатии обычной клавиши
        isShiftPressed = false;
        isCtrlPressed = false;
        isAltPressed = false;
        isWinPressed = false;
      }
    });

    // 🔜 ВЫЗОВ HARBOR:
    // MyHarbourBridge.handleKeyPress(
    //   keyCode,
    //   shift: isShiftPressed,
    //   ctrl: isCtrlPressed,
    //   alt: isAltPressed,
    //   win: isWinPressed,
    //   caps: isCapsPressed,
    //   layout: currentLayout,
    // );

    print('Нажата клавиша с кодом: $keyCode');
    print('Модификаторы — Shift: $isShiftPressed, Ctrl: $isCtrlPressed, Alt: $isAltPressed, Win: $isWinPressed, Caps: $isCapsPressed');
  }

  void toggleLayout() {
    setState(() {
      currentLayout = currentLayout == 'EN' ? 'RU' : 'EN';
    });
  }

  void resetModifiers() {
    setState(() {
      isShiftPressed = false;
      isCtrlPressed = false;
      isAltPressed = false;
      isWinPressed = false;
      isCapsPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: KeyboardColors.cyan, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        lastKeyCode.isEmpty ? 'Нажмите клавишу' : lastKeyCode,
                        style: const TextStyle(
                          color: KeyboardColors.cyan,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      _buildModifierIndicator('S', isShiftPressed, KeyboardColors.green),
                      const SizedBox(width: 4),
                      _buildModifierIndicator('C', isCtrlPressed, KeyboardColors.blue),
                      const SizedBox(width: 4),
                      _buildModifierIndicator('A', isAltPressed, KeyboardColors.blue),
                      const SizedBox(width: 4),
                      _buildModifierIndicator('W', isWinPressed, KeyboardColors.cyan),
                      const SizedBox(width: 4),
                      _buildModifierIndicator('⇪', isCapsPressed, KeyboardColors.orange), // Caps Lock
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: toggleLayout,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: KeyboardColors.purple.withOpacity(0.3),
                            border: Border.all(color: KeyboardColors.purple, width: 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            currentLayout,
                            style: const TextStyle(
                              color: KeyboardColors.purple,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                        icon: const Icon(Icons.refresh, size: 18),
                        onPressed: resetModifiers,
                        tooltip: 'Сбросить модификаторы',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 32),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: KeyboardLayout(
                onKeyPressed: sendKeyToHarbour,
                isShiftPressed: isShiftPressed,
                isCtrlPressed: isCtrlPressed,
                isAltPressed: isAltPressed,
                isWinPressed: isWinPressed,
                isCapsPressed: isCapsPressed, // ← ПЕРЕДАЁМ
                currentLayout: currentLayout,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModifierIndicator(String label, bool isActive, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? color.withOpacity(0.3) : Colors.transparent,
        border: Border.all(
          color: isActive ? color : Colors.grey.shade700,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? color : Colors.grey.shade600,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// === KEYBOARD LAYOUT ===

class KeyboardLayout extends StatelessWidget {
  final void Function(int, {bool isModifier}) onKeyPressed;
  final bool isShiftPressed;
  final bool isCtrlPressed;
  final bool isAltPressed;
  final bool isWinPressed;
  final bool isCapsPressed; // ← ДОБАВЛЕНО
  final String currentLayout;

  const KeyboardLayout({
    super.key,
    required this.onKeyPressed,
    required this.isShiftPressed,
    required this.isCtrlPressed,
    required this.isAltPressed,
    required this.isWinPressed,
    required this.isCapsPressed, // ← ДОБАВЛЕНО
    required this.currentLayout,
  });

  @override
  Widget build(BuildContext context) {
    final rows = currentLayout == 'EN'
        ? _getEnglishLayout()
        : _getRussianLayout();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Column(
        children: [
          for (final row in rows)
            Expanded(child: _buildRow(row)),
        ],
      ),
    );
  }

  List<List<KeyData>> _getEnglishLayout() {
    return [
      [
        KeyData(label: 'Esc', keyCode: KeyCodes.esc, borderColor: KeyboardColors.pink),
        ...List.generate(4, (i) => KeyData(label: 'F${i + 1}', keyCode: 112 + i, borderColor: KeyboardColors.blue)),
        ...List.generate(4, (i) => KeyData(label: 'F${i + 5}', keyCode: 116 + i, borderColor: KeyboardColors.green)),
        ...List.generate(4, (i) => KeyData(label: 'F${i + 9}', keyCode: 120 + i, borderColor: KeyboardColors.pink)),
      ],
      [
        KeyData(label: '`', keyCode: 192, borderColor: KeyboardColors.cyan, shiftLabel: '~'),
        KeyData(label: '1', keyCode: 49, borderColor: KeyboardColors.cyan, shiftLabel: '!'),
        KeyData(label: '2', keyCode: 50, borderColor: KeyboardColors.cyan, shiftLabel: '@'),
        KeyData(label: '3', keyCode: 51, borderColor: KeyboardColors.cyan, shiftLabel: '#'),
        KeyData(label: '4', keyCode: 52, borderColor: KeyboardColors.cyan, shiftLabel: '\$'),
        KeyData(label: '5', keyCode: 53, borderColor: KeyboardColors.cyan, shiftLabel: '%'),
        KeyData(label: '6', keyCode: 54, borderColor: KeyboardColors.cyan, shiftLabel: '^'),
        KeyData(label: '7', keyCode: 55, borderColor: KeyboardColors.cyan, shiftLabel: '&'),
        KeyData(label: '8', keyCode: 56, borderColor: KeyboardColors.cyan, shiftLabel: '*'),
        KeyData(label: '9', keyCode: 57, borderColor: KeyboardColors.cyan, shiftLabel: '('),
        KeyData(label: '0', keyCode: 48, borderColor: KeyboardColors.cyan, shiftLabel: ')'),
        KeyData(label: '-', keyCode: 189, borderColor: KeyboardColors.cyan, shiftLabel: '_'),
        KeyData(label: '=', keyCode: 187, borderColor: KeyboardColors.cyan, shiftLabel: '+'),
        KeyData(label: '⌫', keyCode: KeyCodes.backspace, borderColor: KeyboardColors.pink, flex: 2),
      ],
      [
        KeyData(label: 'Tab', keyCode: KeyCodes.tab, borderColor: KeyboardColors.blue, flex: 2),
        KeyData(label: 'q', keyCode: 81, borderColor: KeyboardColors.green, shiftLabel: 'Q'), // было 'Q', shiftLabel: 'q'
        KeyData(label: 'w', keyCode: 87, borderColor: KeyboardColors.green, shiftLabel: 'W'), // было 'W', shiftLabel: 'w'
        KeyData(label: 'e', keyCode: 69, borderColor: KeyboardColors.green, shiftLabel: 'E'), // было 'E', shiftLabel: 'e'
        KeyData(label: 'r', keyCode: 82, borderColor: KeyboardColors.green, shiftLabel: 'R'), // было 'R', shiftLabel: 'r'
        KeyData(label: 't', keyCode: 84, borderColor: KeyboardColors.green, shiftLabel: 'T'), // было 'T', shiftLabel: 't'
        KeyData(label: 'y', keyCode: 89, borderColor: KeyboardColors.green, shiftLabel: 'Y'), // было 'Y', shiftLabel: 'y'
        KeyData(label: 'u', keyCode: 85, borderColor: KeyboardColors.green, shiftLabel: 'U'), // было 'U', shiftLabel: 'u'
        KeyData(label: 'i', keyCode: 73, borderColor: KeyboardColors.green, shiftLabel: 'I'), // было 'I', shiftLabel: 'i'
        KeyData(label: 'o', keyCode: 79, borderColor: KeyboardColors.green, shiftLabel: 'O'), // было 'O', shiftLabel: 'o'
        KeyData(label: 'p', keyCode: 80, borderColor: KeyboardColors.green, shiftLabel: 'P'), // было 'P', shiftLabel: 'p'
        KeyData(label: '[', keyCode: 219, borderColor: KeyboardColors.green, shiftLabel: '{'),
        KeyData(label: ']', keyCode: 221, borderColor: KeyboardColors.green, shiftLabel: '}'),
        KeyData(label: '\\', keyCode: 220, borderColor: KeyboardColors.green, shiftLabel: '|'),
      ],
      [
        KeyData(label: 'Caps', keyCode: KeyCodes.capsLock, borderColor: KeyboardColors.pink, flex: 2, isModifier: true),
        KeyData(label: 'q', keyCode: 81, borderColor: KeyboardColors.green, shiftLabel: 'Q'), // было 'Q', shiftLabel: 'q'
        KeyData(label: 'w', keyCode: 87, borderColor: KeyboardColors.green, shiftLabel: 'W'), // было 'W', shiftLabel: 'w'
        KeyData(label: 'e', keyCode: 69, borderColor: KeyboardColors.green, shiftLabel: 'E'), // было 'E', shiftLabel: 'e'
        KeyData(label: 'r', keyCode: 82, borderColor: KeyboardColors.green, shiftLabel: 'R'), // было 'R', shiftLabel: 'r'
        KeyData(label: 't', keyCode: 84, borderColor: KeyboardColors.green, shiftLabel: 'T'), // было 'T', shiftLabel: 't'
        KeyData(label: 'y', keyCode: 89, borderColor: KeyboardColors.green, shiftLabel: 'Y'), // было 'Y', shiftLabel: 'y'
        KeyData(label: 'u', keyCode: 85, borderColor: KeyboardColors.green, shiftLabel: 'U'), // было 'U', shiftLabel: 'u'
        KeyData(label: 'i', keyCode: 73, borderColor: KeyboardColors.green, shiftLabel: 'I'), // было 'I', shiftLabel: 'i'
        KeyData(label: 'o', keyCode: 79, borderColor: KeyboardColors.green, shiftLabel: 'O'), // было 'O', shiftLabel: 'o'
        KeyData(label: 'p', keyCode: 80, borderColor: KeyboardColors.green, shiftLabel: 'P'), // было 'P', shiftLabel: 'p'
        KeyData(label: ';', keyCode: 186, borderColor: KeyboardColors.blue, shiftLabel: ':'),
        KeyData(label: '\'', keyCode: 222, borderColor: KeyboardColors.blue, shiftLabel: '"'),
        KeyData(label: 'Enter', keyCode: KeyCodes.enter, borderColor: KeyboardColors.pink, flex: 2),
      ],
      [
        KeyData(label: 'Shift', keyCode: KeyCodes.shift, borderColor: KeyboardColors.green, flex: 2, isModifier: true),
        KeyData(label: 'z', keyCode: 90, borderColor: KeyboardColors.pink, shiftLabel: 'Z'), // было 'Z', shiftLabel: 'z'
        KeyData(label: 'x', keyCode: 88, borderColor: KeyboardColors.pink, shiftLabel: 'X'), // было 'X', shiftLabel: 'x'
        KeyData(label: 'c', keyCode: 67, borderColor: KeyboardColors.pink, shiftLabel: 'C'), // было 'C', shiftLabel: 'c'
        KeyData(label: 'v', keyCode: 86, borderColor: KeyboardColors.pink, shiftLabel: 'V'), // было 'V', shiftLabel: 'v'
        KeyData(label: 'b', keyCode: 66, borderColor: KeyboardColors.pink, shiftLabel: 'B'), // было 'B', shiftLabel: 'b'
        KeyData(label: 'n', keyCode: 78, borderColor: KeyboardColors.pink, shiftLabel: 'N'), // было 'N', shiftLabel: 'n'
        KeyData(label: 'm', keyCode: 77, borderColor: KeyboardColors.pink, shiftLabel: 'M'), // было 'M', shiftLabel: 'm'
        KeyData(label: ',', keyCode: 188, borderColor: KeyboardColors.pink, shiftLabel: '<'),
        KeyData(label: '.', keyCode: 190, borderColor: KeyboardColors.pink, shiftLabel: '>'),
        KeyData(label: '/', keyCode: 191, borderColor: KeyboardColors.pink, shiftLabel: '?'),
        KeyData(label: 'Shift', keyCode: KeyCodes.shift, borderColor: KeyboardColors.green, flex: 2, isModifier: true),
      ],
      [
        KeyData(label: 'Ctrl', keyCode: KeyCodes.ctrl, borderColor: KeyboardColors.blue, flex: 2, isModifier: true),
        KeyData(label: 'Win', keyCode: KeyCodes.win, borderColor: KeyboardColors.cyan, flex: 1, isModifier: true),
        KeyData(label: 'Alt', keyCode: KeyCodes.alt, borderColor: KeyboardColors.blue, flex: 2, isModifier: true),
        KeyData(label: 'Space', keyCode: KeyCodes.space, borderColor: KeyboardColors.green, flex: 6),
        KeyData(label: 'Alt', keyCode: KeyCodes.alt, borderColor: KeyboardColors.blue, flex: 2, isModifier: true),
        KeyData(label: 'Ctrl', keyCode: KeyCodes.ctrl, borderColor: KeyboardColors.blue, flex: 2, isModifier: true),
        KeyData(label: '←', keyCode: 37, borderColor: KeyboardColors.pink),
        KeyData(label: '↑', keyCode: 38, borderColor: KeyboardColors.pink),
        KeyData(label: '↓', keyCode: 40, borderColor: KeyboardColors.pink),
        KeyData(label: '→', keyCode: 39, borderColor: KeyboardColors.pink),
      ],
    ];
  }

  List<List<KeyData>> _getRussianLayout() {
    return [
      [
        KeyData(label: 'Esc', keyCode: KeyCodes.esc, borderColor: KeyboardColors.pink),
        ...List.generate(4, (i) => KeyData(label: 'F${i + 1}', keyCode: 112 + i, borderColor: KeyboardColors.blue)),
        ...List.generate(4, (i) => KeyData(label: 'F${i + 5}', keyCode: 116 + i, borderColor: KeyboardColors.green)),
        ...List.generate(4, (i) => KeyData(label: 'F${i + 9}', keyCode: 120 + i, borderColor: KeyboardColors.pink)),
      ],
      [
        KeyData(label: 'ё', keyCode: 192, borderColor: KeyboardColors.cyan, shiftLabel: 'Ё'),
        KeyData(label: '1', keyCode: 49, borderColor: KeyboardColors.cyan, shiftLabel: '!'),
        KeyData(label: '2', keyCode: 50, borderColor: KeyboardColors.cyan, shiftLabel: '"'),
        KeyData(label: '3', keyCode: 51, borderColor: KeyboardColors.cyan, shiftLabel: '№'),
        KeyData(label: '4', keyCode: 52, borderColor: KeyboardColors.cyan, shiftLabel: ';'),
        KeyData(label: '5', keyCode: 53, borderColor: KeyboardColors.cyan, shiftLabel: '%'),
        KeyData(label: '6', keyCode: 54, borderColor: KeyboardColors.cyan, shiftLabel: ':'),
        KeyData(label: '7', keyCode: 55, borderColor: KeyboardColors.cyan, shiftLabel: '?'),
        KeyData(label: '8', keyCode: 56, borderColor: KeyboardColors.cyan, shiftLabel: '*'),
        KeyData(label: '9', keyCode: 57, borderColor: KeyboardColors.cyan, shiftLabel: '('),
        KeyData(label: '0', keyCode: 48, borderColor: KeyboardColors.cyan, shiftLabel: ')'),
        KeyData(label: '-', keyCode: 189, borderColor: KeyboardColors.cyan, shiftLabel: '_'),
        KeyData(label: '=', keyCode: 187, borderColor: KeyboardColors.cyan, shiftLabel: '+'),
        KeyData(label: '⌫', keyCode: KeyCodes.backspace, borderColor: KeyboardColors.pink, flex: 2),
      ],
      [
        KeyData(label: 'Tab', keyCode: KeyCodes.tab, borderColor: KeyboardColors.blue, flex: 2),
        KeyData(label: 'й', keyCode: 81, borderColor: KeyboardColors.green, shiftLabel: 'Й'), // было 'Й', shiftLabel: 'й'
        KeyData(label: 'ц', keyCode: 87, borderColor: KeyboardColors.green, shiftLabel: 'Ц'), // было 'Ц', shiftLabel: 'ц'
        KeyData(label: 'у', keyCode: 69, borderColor: KeyboardColors.green, shiftLabel: 'У'), // было 'У', shiftLabel: 'у'
        KeyData(label: 'к', keyCode: 82, borderColor: KeyboardColors.green, shiftLabel: 'К'), // было 'К', shiftLabel: 'к'
        KeyData(label: 'е', keyCode: 84, borderColor: KeyboardColors.green, shiftLabel: 'Е'), // было 'Е', shiftLabel: 'е'
        KeyData(label: 'н', keyCode: 89, borderColor: KeyboardColors.green, shiftLabel: 'Н'), // было 'Н', shiftLabel: 'н'
        KeyData(label: 'г', keyCode: 85, borderColor: KeyboardColors.green, shiftLabel: 'Г'), // было 'Г', shiftLabel: 'г'
        KeyData(label: 'ш', keyCode: 73, borderColor: KeyboardColors.green, shiftLabel: 'Ш'), // было 'Ш', shiftLabel: 'ш'
        KeyData(label: 'щ', keyCode: 79, borderColor: KeyboardColors.green, shiftLabel: 'Щ'), // было 'Щ', shiftLabel: 'щ'
        KeyData(label: 'з', keyCode: 80, borderColor: KeyboardColors.green, shiftLabel: 'З'), // было 'З', shiftLabel: 'з'
        KeyData(label: 'х', keyCode: 219, borderColor: KeyboardColors.green, shiftLabel: 'Х'),
        KeyData(label: 'ъ', keyCode: 221, borderColor: KeyboardColors.green, shiftLabel: 'Ъ'),
        KeyData(label: '\\', keyCode: 220, borderColor: KeyboardColors.green, shiftLabel: '/'),
      ],
      [
        KeyData(label: 'Caps', keyCode: KeyCodes.capsLock, borderColor: KeyboardColors.pink, flex: 2, isModifier: true),
        KeyData(label: 'ф', keyCode: 65, borderColor: KeyboardColors.blue, shiftLabel: 'Ф'), // было 'Ф', shiftLabel: 'ф'
        KeyData(label: 'ы', keyCode: 83, borderColor: KeyboardColors.blue, shiftLabel: 'Ы'), // было 'Ы', shiftLabel: 'ы'
        KeyData(label: 'в', keyCode: 68, borderColor: KeyboardColors.blue, shiftLabel: 'В'), // было 'В', shiftLabel: 'в'
        KeyData(label: 'а', keyCode: 70, borderColor: KeyboardColors.blue, shiftLabel: 'А'), // было 'А', shiftLabel: 'а'
        KeyData(label: 'п', keyCode: 71, borderColor: KeyboardColors.blue, shiftLabel: 'П'), // было 'П', shiftLabel: 'п'
        KeyData(label: 'р', keyCode: 72, borderColor: KeyboardColors.blue, shiftLabel: 'Р'), // было 'Р', shiftLabel: 'р'
        KeyData(label: 'о', keyCode: 74, borderColor: KeyboardColors.blue, shiftLabel: 'О'), // было 'О', shiftLabel: 'о'
        KeyData(label: 'л', keyCode: 75, borderColor: KeyboardColors.blue, shiftLabel: 'Л'), // было 'Л', shiftLabel: 'л'
        KeyData(label: 'д', keyCode: 76, borderColor: KeyboardColors.blue, shiftLabel: 'Д'), // было 'Д', shiftLabel: 'д'
        KeyData(label: 'ж', keyCode: 186, borderColor: KeyboardColors.blue, shiftLabel: 'Ж'),
        KeyData(label: 'э', keyCode: 222, borderColor: KeyboardColors.blue, shiftLabel: 'Э'),
        KeyData(label: 'Enter', keyCode: KeyCodes.enter, borderColor: KeyboardColors.pink, flex: 2),
      ],
      [
        KeyData(label: 'Shift', keyCode: KeyCodes.shift, borderColor: KeyboardColors.green, flex: 2, isModifier: true),
        KeyData(label: 'я', keyCode: 90, borderColor: KeyboardColors.pink, shiftLabel: 'Я'), // было 'Я', shiftLabel: 'я'
        KeyData(label: 'ч', keyCode: 88, borderColor: KeyboardColors.pink, shiftLabel: 'Ч'), // было 'Ч', shiftLabel: 'ч'
        KeyData(label: 'с', keyCode: 67, borderColor: KeyboardColors.pink, shiftLabel: 'С'), // было 'С', shiftLabel: 'с'
        KeyData(label: 'м', keyCode: 86, borderColor: KeyboardColors.pink, shiftLabel: 'М'), // было 'М', shiftLabel: 'м'
        KeyData(label: 'и', keyCode: 66, borderColor: KeyboardColors.pink, shiftLabel: 'И'), // было 'И', shiftLabel: 'и'
        KeyData(label: 'т', keyCode: 78, borderColor: KeyboardColors.pink, shiftLabel: 'Т'), // было 'Т', shiftLabel: 'т'
        KeyData(label: 'ь', keyCode: 77, borderColor: KeyboardColors.pink, shiftLabel: 'Ь'), // было 'Ь', shiftLabel: 'ь'
        KeyData(label: 'б', keyCode: 188, borderColor: KeyboardColors.pink, shiftLabel: 'Б'),
        KeyData(label: 'ю', keyCode: 190, borderColor: KeyboardColors.pink, shiftLabel: 'Ю'),
        KeyData(label: '.', keyCode: 191, borderColor: KeyboardColors.pink, shiftLabel: ','),
        KeyData(label: 'Shift', keyCode: KeyCodes.shift, borderColor: KeyboardColors.green, flex: 2, isModifier: true),
      ],
      [
        KeyData(label: 'Ctrl', keyCode: KeyCodes.ctrl, borderColor: KeyboardColors.blue, flex: 2, isModifier: true),
        KeyData(label: 'Win', keyCode: KeyCodes.win, borderColor: KeyboardColors.cyan, flex: 1, isModifier: true),
        KeyData(label: 'Alt', keyCode: KeyCodes.alt, borderColor: KeyboardColors.blue, flex: 2, isModifier: true),
        KeyData(label: 'Space', keyCode: KeyCodes.space, borderColor: KeyboardColors.green, flex: 6),
        KeyData(label: 'Alt', keyCode: KeyCodes.alt, borderColor: KeyboardColors.blue, flex: 2, isModifier: true),
        KeyData(label: 'Ctrl', keyCode: KeyCodes.ctrl, borderColor: KeyboardColors.blue, flex: 2, isModifier: true),
        KeyData(label: '←', keyCode: 37, borderColor: KeyboardColors.pink),
        KeyData(label: '↑', keyCode: 38, borderColor: KeyboardColors.pink),
        KeyData(label: '↓', keyCode: 40, borderColor: KeyboardColors.pink),
        KeyData(label: '→', keyCode: 39, borderColor: KeyboardColors.pink),
      ],
    ];
  }

  Widget _buildRow(List<KeyData> keys) {
    return Row(
      children: keys.map((keyData) {
        bool isActive = false;
        if (keyData.isModifier) {
          if (keyData.keyCode == KeyCodes.shift) isActive = isShiftPressed;
          if (keyData.keyCode == KeyCodes.ctrl) isActive = isCtrlPressed;
          if (keyData.keyCode == KeyCodes.alt) isActive = isAltPressed;
          if (keyData.keyCode == KeyCodes.win) isActive = isWinPressed;
          if (keyData.keyCode == KeyCodes.capsLock) isActive = isCapsPressed;
        }

        return Expanded(
          flex: keyData.flex,
          child: KeyButton(
            keyData: keyData,
            onPressed: onKeyPressed,
            isActive: isActive,
            isShiftActive: isShiftPressed,
            isCapsActive: isCapsPressed,
          ),
        );
      }).toList(),
    );
  }
}

// === KEY BUTTON ===

class KeyButton extends StatefulWidget {
  final KeyData keyData;
  final void Function(int, {bool isModifier}) onPressed;
  final bool isActive;
  final bool isShiftActive;
  final bool isCapsActive;

  const KeyButton({
    super.key,
    required this.keyData,
    required this.onPressed,
    this.isActive = false,
    this.isShiftActive = false,
    this.isCapsActive = false,
  });

  @override
  State<KeyButton> createState() => _KeyButtonState();
}

class _KeyButtonState extends State<KeyButton> {
  bool isPressed = false;

  bool _isLetter(String char) {
    return RegExp(r'^[a-zA-Zа-яА-ЯёЁ]$').hasMatch(char);
  }

  String _getDisplayLabel() {
    final keyData = widget.keyData;

    if (keyData.shiftLabel == null || keyData.isModifier) {
      return keyData.label;
    }

    final base = keyData.label;
    final shifted = keyData.shiftLabel!;

    if (!_isLetter(base)) {
      return widget.isShiftActive ? shifted : base;
    }

    // Логика Caps Lock + Shift
    final caps = widget.isCapsActive;
    final shift = widget.isShiftActive;

    if (caps) {
      return shift ? base : shifted;
    } else {
      return shift ? shifted : base;
    }
  }

  double _getFontSize(String label) {
    if (label.length > 4 || label.contains(' ') || label == '⌫') {
      return 10;
    }

    if (_isLetter(label)) {
      // Если символ == своему верхнему регистру и != нижнему — это заглавная буква
      if (label == label.toUpperCase() && label != label.toLowerCase()) {
        return 16;
      } else {
        return 12;
      }
    }

    return 14;
  }

  @override
  Widget build(BuildContext context) {
    final isHighlighted = widget.isActive || isPressed;
    final displayLabel = _getDisplayLabel();
    final fontSize = _getFontSize(displayLabel);

    return Padding(
      padding: const EdgeInsets.all(1),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) {
          setState(() => isPressed = true);
          HapticFeedback.lightImpact();
          widget.onPressed(widget.keyData.keyCode, isModifier: widget.keyData.isModifier);
        },
        onTapUp: (_) => setState(() => isPressed = false),
        onTapCancel: () => setState(() => isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: isHighlighted
                ? widget.keyData.borderColor.withOpacity(0.3)
                : Colors.black,
            border: Border.all(
              color: widget.keyData.borderColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: widget.keyData.borderColor.withOpacity(isHighlighted ? 0.6 : 0.3),
                blurRadius: isHighlighted ? 8 : 4,
                spreadRadius: isHighlighted ? 1 : 0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              displayLabel,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isHighlighted ? widget.keyData.borderColor : Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}