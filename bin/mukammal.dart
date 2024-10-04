import 'dart:io';

void main(List<String> arguments) {
  bool repeat = true;
  while (repeat) {
    repeat = checkNumber();
  }
}

bool checkNumber() {
  stdout.write('\nSon kiriting: ');
  var num = stdin.readLineSync().toString();
  if (int.tryParse(num).runtimeType == int) {
    if (isEven(int.parse(num))) {
      print('Juft son');
    } else {
      print('Toq son');
    }
    checkPrime(int.parse(num));
    checkPerfectNumber(int.parse(num));
    stdout.write("*******************************************************");
    return true;
  } else {
    num != 'q' ? stdout.write("Xatolik: Butun son kiriting") : null;
    stdout.write("*******************************************************");
    return num == 'q' ? false : true;
  }
}

isEven(int num) {
  if (num % 2 == 0) {
    return true;
  }
  return false;
}

checkPrime(int num) {
  if (num <= 1) {
    print('1, 0 va manfiy sonlar tub va murakkab sonlar qatoriga kirmaydi!!!');
  } else {
    List<int> multipliers = [];
    for (int i = 2; i < num; i++) {
      if (num % i == 0) {
        multipliers.add(i);
      } else {
        continue;
      }
    }
    print(multipliers.isEmpty ? 'Tub son' : 'Murakkab son');
  }
}

checkPerfectNumber(int num) {
  if (num <= 0) {
    print('0 va manfiy sonlar mukammal son bo\'la olmaydi!!!');
  } else {
    int sum = 0;
    for (int i = 1; i < num; i++) {
      if (num % i == 0) {
        sum += i;
      }
    }
    if (sum == num) {
      print('Mukammal son');
    } else {
      print('Mukammal bo\'lmagan son');
    }
  }
}
