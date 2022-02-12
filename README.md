<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Floating Frosted Bottom Bar

A Flutter package that helps you to create a frosted floating bottom navigation bar that also reacts to scrolling events.

## Usage

Wrap any child widget with `FrostedBottomBar` to convert it into frosted bottom bar.
Basic example,

```dart
FrostedBottomBar(
        opacity: 0.6,
        sigmaX: 5,
        sigmaY: 5,
        child: Text(
              "Frosted Bottom Bar Example",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
        body: (context, controller) =>
              ListView.builder(
                  controller: controller,
                  itemBuilder: (context, index) {
                    return const Card(child: FittedBox(child: FlutterLogo()));
                  },
                ),
    )
```

# Detail Usage

Following are the optional properties that can be used inside `FrostedBottomBar`

### bottomBarColor

```dart
bottomBarColor: Colors.grey
```

Change the bottom bar color

### end

```dart
end: 0
```

The end position in `y-axis` of the SlideTransition of the `FrostedBottomBar`.

### start

```dart
start: 2
```

The start position in `y-axis` of the SlideTransition of the `FrostedBottomBar`.

### bottom

```dart
bottom: 10
```

The position of the Frosted bar from the bottom

### duration

```dart
bottom: 10
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
