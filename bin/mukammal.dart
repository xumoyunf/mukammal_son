import 'dart:io';

void main(List<String> arguments) {
  bool repeat = true;
  while (repeat) {
    repeat = checkNumber();
  }
}

bool checkNumber() {
  stdout.write('\nSon kiriting: ');
  var number = stdin.readLineSync().toString();
  if (int.tryParse(number).runtimeType == int) {
    if (isEven(int.parse(number))) {
      print('Juft son');
    } else {
      print('Toq son');
    }
    checkPrime(int.parse(number));
    checkPerfectNumber(int.parse(number));
    stdout.write("*******************************************************");
    return true;
  } else {
    number != 'q' ? stdout.write("Xatolik: Butun son kiriting\n") : null;
    stdout.write("*******************************************************");
    return number == 'q' ? false : true;
  }
}

isEven(int number) {
  if (number % 2 == 0) {
    return true;
  }
  return false;
}

checkPrime(int number) {
  if (number <= 1) {
    print('1, 0 va manfiy sonlar tub va murakkab sonlar qatoriga kirmaydi!!!');
  } else {
    List<int> multipliers = [];
    for (int i = 2; i < number; i++) {
      if (number % i == 0) {
        multipliers.add(i);
      } else {
        continue;
      }
    }
    print(multipliers.isEmpty ? 'Tub son' : 'Murakkab son');
  }
}

checkPerfectNumber(int number) {
  if (number <= 0) {
    print('0 va manfiy sonlar mukammal son bo\'la olmaydi!!!');
  } else {
    int sum = 0;
    for (int i = 1; i < number; i++) {
      if (number % i == 0) {
        sum += i;
      }
    }
    if (sum == number) {
      print('Mukammal son');
    } else {
      print('Mukammal bo\'lmagan son');
    }
  }
}