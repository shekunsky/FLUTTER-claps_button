import 'package:flutter_test/flutter_test.dart';
import 'package:claps_button/claps_button.dart';
import 'package:claps_button/claps_state.dart';

void main() {
  testWidgets('Widget changed his state on tap and callback is executed',
      (WidgetTester tester) async {
    int _tapCounter = 0;
    ClapsState _currentState = ClapsState.unLike;

    // Create the widget by telling the tester to build it.
    ClapsButton _button = ClapsButton(
        state: _currentState,
        onTapClapsed: (state) {
          _tapCounter++;
          _currentState = state;
        });

    // Build the widget.
    await tester.pumpWidget(_button);

    // Tap the button while current state is 'unLike'.
    await tester.tap(find.byType(ClapsButton));

    // Rebuild the widget after the state has changed.
    await tester.pump();

    // Expect to state changed to 'Like' and callback executed
    expect(_currentState, ClapsState.like);
    expect(_tapCounter, 1);

    // Tap the button while current state is 'like'.
    await tester.tap(find.byType(ClapsButton));

    // Rebuild the widget after the state has changed.
    await tester.pump();

    // Expect to state changed to 'unLike' and callback executed
    expect(_currentState, ClapsState.unLike);
    expect(_tapCounter, 2);
  });
}
