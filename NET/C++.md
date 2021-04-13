# C++

- C++引用(&)和指针的区别
- 深拷贝和浅拷贝的区别
- 函数指针的作用
  - 类的静态成员函数
  - 可以指向类的非静态成员函数吗
    - 类成员函数指针
  - 函数指针有几种
- `const` 修饰符的作用
  - `const int *` 和 `int * const` 的区别
  - 可以修饰的地方
  - 放在函数声明最后的作用
  - 放在返回值前的作用
    - 在什么情况下会用到
- 函数调用机制

  ```cpp
    class A {
    public :
      void Print1() { std::cout << "1"; }
      static void Print2() { std::cout << "2"; }
      virtual void Print3() { std::cout << "3"; }
    };

    int main()
    {
      // 下面哪些运行时会报错，为什么
      A *a = NULL;
      a->Print1();
      a->Print2();
      a->Print3();
    }

  ```

- 虚函数可以为 `static` 吗
- 虚函数表的作用
  - 虚函数表的结构
  - 多重继承有几个虚表指针
- c++ 类实例在内存中的结构
  - 虚表指针的位置
- 了解 C++/CLI 吗
