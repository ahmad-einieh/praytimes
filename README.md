
# Prayer Times

A Flutter prototype that fetches prayer timings from the AlAdhan API and displays them in a drawer-based interface.

## Current behavior

- Fetches timings for **Riyadh, Saudi Arabia**, using API calculation method `4`.
- Displays Imsak, Fajr, Sunrise, Dhuhr, Asr, Sunset, Maghrib, Isha, and Midnight.
- Shows the API's calculation-method name, loading state, and request errors.
- Converts time labels to 12-hour AM/PM format.

Location/preferences-related code exists, but the actual request in [`lib/helper.dart`](lib/helper.dart) is hardcoded to Riyadh. Saved coordinates do not change that request.

## Setup

Use a legacy Flutter/Dart 2 SDK satisfying `>=2.16.0-134.5.beta <3.0.0`, plus the native toolchain for your chosen target. Dart 3 is excluded by [`pubspec.yaml`](pubspec.yaml).

```bash
flutter pub get
flutter devices
flutter run -d <device-id>
```

Internet access is required. Main dependencies include `http`, `flutter_zoom_drawer`, `geolocator`, `permission_handler`, and `shared_preferences`; several are unconstrained, so current resolution may need compatibility work.

## Source guide

- [`lib/main.dart`](lib/main.dart): timing list and drawer integration.
- [`lib/helper.dart`](lib/helper.dart): API request, time conversion, and timing widgets.
- [`lib/Data.dart`](lib/Data.dart): API response wrapper.
- [`lib/menu_page.dart`](lib/menu_page.dart) and [`lib/picker_of_city.dart`](lib/picker_of_city.dart): menu/location UI experiments.

API availability, device behavior, and displayed prayer-time accuracy have not been independently verified. Confirm location, date, timezone, and calculation method against a trusted local timetable before relying on the results.
