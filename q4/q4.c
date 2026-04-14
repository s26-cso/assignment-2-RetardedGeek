#include <stdio.h>
#include <dlfcn.h>
#include<string.h>

typedef int (*fptr)(int, int);   // you are equating types int and (*fptr)(int, int).
                                 // this means that fptr must be the type of a pointer to a
                                 // function with signature int, int -> int.

int main() {
    char s[7];
    int a,b;
    scanf("%s %d %d",s,&a,&b);
    char libname[20]="./lib";
    strcat(libname,s);
    char tmp[]=".so";
    strcat(libname,tmp);
    void* handle = dlopen(libname, RTLD_LAZY); // bring the library into memory. same shared library as in the previous example.
    fptr fun = dlsym(handle,s);                 // get a pointer to the add function
    int result = fun(a, b);
    printf("%d\n", result);
    return 0;
}