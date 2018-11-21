
// sample.cc
#include <iostream>
#include <thread>

[[clang::xray_always_instrument]] void f() {
  std::cerr << '.';
}

[[clang::xray_always_instrument]] void g() {
  for (int i = 0; i < 1 << 10; ++i) {
    std::cerr << '-';
  }
}

int main(int argc, char* argv[]) {
  std::thread t1([] {
    for (int i = 0; i < 1 << 10; ++i)
      f();
  });
  std::thread t2([] {
    g();
  });
  t1.join();
  t2.join();
  std::cerr << '\n';
}
