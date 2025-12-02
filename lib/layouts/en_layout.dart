import 'package:flutter/material.dart';
import '../main.dart';

final enLayout = <List<KeyData>>[
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
