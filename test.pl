:- use_module(library(by_unix)).
:- initialization main.

meminfo(Key, Value) :-
    Ls @@ cat(/proc/meminfo),
    member(L, Ls),
    split_string(L, ":", "", [Key,T|_]),
    split_string(T, " ", "", Ws),
    member(TextValue, Ws),
    number_string(Value, TextValue).

main :-
    meminfo("MemTotal", MemTotal),
    meminfo("MemFree",  MemFree),
    format("Free: ~d / Total: ~d\n", [MemFree, MemTotal]),
    halt.
