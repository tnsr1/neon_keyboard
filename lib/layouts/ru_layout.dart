import 'package:flutter/material.dart';
import '../main.dart';

final ruLayout = <List<KeyData>>[
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
