import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './layouts/en_layout.dart';
import './layouts/ru_layout.dart';

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
  bool isCapsPressed = false;
  String currentLayout = 'EN';
  double edgePadding = 25.0; // Отступы от краёв экрана

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
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(edgePadding),
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
                            _buildModifierIndicator('⇪', isCapsPressed, KeyboardColors.orange),
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
                      isCapsPressed: isCapsPressed,
                      currentLayout: currentLayout,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Контрол для регулировки отступов
          Positioned(
            right: 10 + edgePadding,
            bottom: 10 + edgePadding,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  edgePadding = (edgePadding - details.delta.dy).clamp(0.0, 100.0);
                });
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: KeyboardColors.cyan.withOpacity(0.3),
                  border: Border.all(
                    color: KeyboardColors.cyan,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: KeyboardColors.cyan.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.open_in_full,
                      size: 12,
                      color: KeyboardColors.cyan,
                    ),
                    Positioned(
                      bottom: -1,
                      child: Text(
                        '${edgePadding.round()}',
                        style: TextStyle(
                          color: KeyboardColors.cyan,
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
  final bool isCapsPressed;
  final String currentLayout;

  const KeyboardLayout({
    super.key,
    required this.onKeyPressed,
    required this.isShiftPressed,
    required this.isCtrlPressed,
    required this.isAltPressed,
    required this.isWinPressed,
    required this.isCapsPressed,
    required this.currentLayout,
  });

  @override
  Widget build(BuildContext context) {
    final rows = currentLayout == 'EN'
        ? enLayout
        : ruLayout;

    return Column(
      children: [
        for (final row in rows)
          Expanded(child: _buildRow(row)),
      ],
    );
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
        return 13;
      } else {
        return 15;
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