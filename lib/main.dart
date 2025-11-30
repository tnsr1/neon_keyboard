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
            isCapsPressed = !isCapsPressed; // ← ДОБАВЛЕНО
            break;
        }
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
    print('Раскладка: $currentLayout');
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
        KeyData(label: 'Q', keyCode: 81, borderColor: KeyboardColors.green, shiftLabel: 'q'),
        KeyData(label: 'W', keyCode: 87, borderColor: KeyboardColors.green, shiftLabel: 'w'),
        KeyData(label: 'E', keyCode: 69, borderColor: KeyboardColors.green, shiftLabel: 'e'),
        KeyData(label: 'R', keyCode: 82, borderColor: KeyboardColors.green, shiftLabel: 'r'),
        KeyData(label: 'T', keyCode: 84, borderColor: KeyboardColors.green, shiftLabel: 't'),
        KeyData(label: 'Y', keyCode: 89, borderColor: KeyboardColors.green, shiftLabel: 'y'),
        KeyData(label: 'U', keyCode: 85, borderColor: KeyboardColors.green, shiftLabel: 'u'),
        KeyData(label: 'I', keyCode: 73, borderColor: KeyboardColors.green, shiftLabel: 'i'),
        KeyData(label: 'O', keyCode: 79, borderColor: KeyboardColors.green, shiftLabel: 'o'),
        KeyData(label: 'P', keyCode: 80, borderColor: KeyboardColors.green, shiftLabel: 'p'),
        KeyData(label: '[', keyCode: 219, borderColor: KeyboardColors.green, shiftLabel: '{'),
        KeyData(label: ']', keyCode: 221, borderColor: KeyboardColors.green, shiftLabel: '}'),
        KeyData(label: '\\', keyCode: 220, borderColor: KeyboardColors.green, shiftLabel: '|'),
      ],
      [
        KeyData(label: 'Caps', keyCode: KeyCodes.capsLock, borderColor: KeyboardColors.pink, flex: 2, isModifier: true),
        KeyData(label: 'A', keyCode: 65, borderColor: KeyboardColors.blue, shiftLabel: 'a'),
        KeyData(label: 'S', keyCode: 83, borderColor: KeyboardColors.blue, shiftLabel: 's'),
        KeyData(label: 'D', keyCode: 68, borderColor: KeyboardColors.blue, shiftLabel: 'd'),
        KeyData(label: 'F', keyCode: 70, borderColor: KeyboardColors.blue, shiftLabel: 'f'),
        KeyData(label: 'G', keyCode: 71, borderColor: KeyboardColors.blue, shiftLabel: 'g'),
        KeyData(label: 'H', keyCode: 72, borderColor: KeyboardColors.blue, shiftLabel: 'h'),
        KeyData(label: 'J', keyCode: 74, borderColor: KeyboardColors.blue, shiftLabel: 'j'),
        KeyData(label: 'K', keyCode: 75, borderColor: KeyboardColors.blue, shiftLabel: 'k'),
        KeyData(label: 'L', keyCode: 76, borderColor: KeyboardColors.blue, shiftLabel: 'l'),
        KeyData(label: ';', keyCode: 186, borderColor: KeyboardColors.blue, shiftLabel: ':'),
        KeyData(label: '\'', keyCode: 222, borderColor: KeyboardColors.blue, shiftLabel: '"'),
        KeyData(label: 'Enter', keyCode: KeyCodes.enter, borderColor: KeyboardColors.pink, flex: 2),
      ],
      [
        KeyData(label: 'Shift', keyCode: KeyCodes.shift, borderColor: KeyboardColors.green, flex: 2, isModifier: true),
        KeyData(label: 'Z', keyCode: 90, borderColor: KeyboardColors.pink, shiftLabel: 'z'),
        KeyData(label: 'X', keyCode: 88, borderColor: KeyboardColors.pink, shiftLabel: 'x'),
        KeyData(label: 'C', keyCode: 67, borderColor: KeyboardColors.pink, shiftLabel: 'c'),
        KeyData(label: 'V', keyCode: 86, borderColor: KeyboardColors.pink, shiftLabel: 'v'),
        KeyData(label: 'B', keyCode: 66, borderColor: KeyboardColors.pink, shiftLabel: 'b'),
        KeyData(label: 'N', keyCode: 78, borderColor: KeyboardColors.pink, shiftLabel: 'n'),
        KeyData(label: 'M', keyCode: 77, borderColor: KeyboardColors.pink, shiftLabel: 'm'),
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
        KeyData(label: 'Й', keyCode: 81, borderColor: KeyboardColors.green, shiftLabel: 'й'),
        KeyData(label: 'Ц', keyCode: 87, borderColor: KeyboardColors.green, shiftLabel: 'ц'),
        KeyData(label: 'У', keyCode: 69, borderColor: KeyboardColors.green, shiftLabel: 'у'),
        KeyData(label: 'К', keyCode: 82, borderColor: KeyboardColors.green, shiftLabel: 'к'),
        KeyData(label: 'Е', keyCode: 84, borderColor: KeyboardColors.green, shiftLabel: 'е'),
        KeyData(label: 'Н', keyCode: 89, borderColor: KeyboardColors.green, shiftLabel: 'н'),
        KeyData(label: 'Г', keyCode: 85, borderColor: KeyboardColors.green, shiftLabel: 'г'),
        KeyData(label: 'Ш', keyCode: 73, borderColor: KeyboardColors.green, shiftLabel: 'ш'),
        KeyData(label: 'Щ', keyCode: 79, borderColor: KeyboardColors.green, shiftLabel: 'щ'),
        KeyData(label: 'З', keyCode: 80, borderColor: KeyboardColors.green, shiftLabel: 'з'),
        KeyData(label: 'Х', keyCode: 219, borderColor: KeyboardColors.green, shiftLabel: 'х'),
        KeyData(label: 'Ъ', keyCode: 221, borderColor: KeyboardColors.green, shiftLabel: 'ъ'),
        KeyData(label: '\\', keyCode: 220, borderColor: KeyboardColors.green, shiftLabel: '/'),
      ],
      [
        KeyData(label: 'Caps', keyCode: KeyCodes.capsLock, borderColor: KeyboardColors.pink, flex: 2, isModifier: true),
        KeyData(label: 'Ф', keyCode: 65, borderColor: KeyboardColors.blue, shiftLabel: 'ф'),
        KeyData(label: 'Ы', keyCode: 83, borderColor: KeyboardColors.blue, shiftLabel: 'ы'),
        KeyData(label: 'В', keyCode: 68, borderColor: KeyboardColors.blue, shiftLabel: 'в'),
        KeyData(label: 'А', keyCode: 70, borderColor: KeyboardColors.blue, shiftLabel: 'а'),
        KeyData(label: 'П', keyCode: 71, borderColor: KeyboardColors.blue, shiftLabel: 'п'),
        KeyData(label: 'Р', keyCode: 72, borderColor: KeyboardColors.blue, shiftLabel: 'р'),
        KeyData(label: 'О', keyCode: 74, borderColor: KeyboardColors.blue, shiftLabel: 'о'),
        KeyData(label: 'Л', keyCode: 75, borderColor: KeyboardColors.blue, shiftLabel: 'л'),
        KeyData(label: 'Д', keyCode: 76, borderColor: KeyboardColors.blue, shiftLabel: 'д'),
        KeyData(label: 'Ж', keyCode: 186, borderColor: KeyboardColors.blue, shiftLabel: 'ж'),
        KeyData(label: 'Э', keyCode: 222, borderColor: KeyboardColors.blue, shiftLabel: 'э'),
        KeyData(label: 'Enter', keyCode: KeyCodes.enter, borderColor: KeyboardColors.pink, flex: 2),
      ],
      [
        KeyData(label: 'Shift', keyCode: KeyCodes.shift, borderColor: KeyboardColors.green, flex: 2, isModifier: true),
        KeyData(label: 'Я', keyCode: 90, borderColor: KeyboardColors.pink, shiftLabel: 'я'),
        KeyData(label: 'Ч', keyCode: 88, borderColor: KeyboardColors.pink, shiftLabel: 'ч'),
        KeyData(label: 'С', keyCode: 67, borderColor: KeyboardColors.pink, shiftLabel: 'с'),
        KeyData(label: 'М', keyCode: 86, borderColor: KeyboardColors.pink, shiftLabel: 'м'),
        KeyData(label: 'И', keyCode: 66, borderColor: KeyboardColors.pink, shiftLabel: 'и'),
        KeyData(label: 'Т', keyCode: 78, borderColor: KeyboardColors.pink, shiftLabel: 'т'),
        KeyData(label: 'Ь', keyCode: 77, borderColor: KeyboardColors.pink, shiftLabel: 'ь'),
        KeyData(label: 'Б', keyCode: 188, borderColor: KeyboardColors.pink, shiftLabel: 'б'),
        KeyData(label: 'Ю', keyCode: 190, borderColor: KeyboardColors.pink, shiftLabel: 'ю'),
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