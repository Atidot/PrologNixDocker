:- use_module(library(process)).
:- initialization main.

meminfo(Key, Value) :-
    setup_call_cleanup(
        process_create(path(cat), ["/proc/meminfo"], [stdout(pipe(Out))]),
        read_string(Out, _, Output),
        close(Out)),
    split_string(Output, "\n", "", Ls),
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
