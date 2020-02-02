# claps_button

A new Flutter package project.

## Getting Started

For use claps_button widget in your project:
1. Add dependency in the pubspec.yaml file
    dependencies:
        flutter:
            sdk: flutter
        claps_button:
            git:
                url: git@github.com:shekunsky/FLUTTER-claps_button.git

2. Import widget in the dart file:
    import 'package:claps_button/claps_button.dart';
    import 'package:claps_button/claps_state.dart';

3. Make an instance of the widget:
    for 'unlike' state - ClapsButton(state: ClapsState.unLike)
    for 'like' state - ClapsButton(state: ClapsState.like)