import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:news_hmti/test/sign_in_screen.dart';

void main() {
  testWidgets('Validasi form login', (WidgetTester tester) async {
    // Render halaman login
    await tester.pumpWidget(const MaterialApp(home: SignInScreen()));

    // Coba tekan tombol login tanpa input apa pun
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Periksa apakah pesan error muncul
    expect(find.text('Email tidak boleh kosong'), findsOneWidget);
    expect(find.text('Password tidak boleh kosong'), findsOneWidget);

    // Isi email dengan format salah
    await tester.enterText(find.byType(TextFormField).at(0), 'invalid-email');
    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Periksa validasi email dan password
    expect(find.text('Format email tidak valid'), findsOneWidget);
    expect(find.text('Password harus lebih dari 6 karakter'), findsOneWidget);

    // Isi dengan data valid
    await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Periksa tidak ada pesan error
    expect(find.text('Email tidak boleh kosong'), findsNothing);
    expect(find.text('Format email tidak valid'), findsNothing);
    expect(find.text('Password tidak boleh kosong'), findsNothing);
    expect(find.text('Password harus lebih dari 6 karakter'), findsNothing);
  });
}
