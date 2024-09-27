-module(cors_middleware).
-behavior(cowboy_middleware).

-export([execute/2]).

execute(Req, Env) ->
    Req2 = cowboy_req:set_resp_header(<<"access-control-allow-origin">>, <<"*">>, Req),
    Req3 = cowboy_req:set_resp_header(<<"access-control-allow-methods">>, <<"GET, POST, PUT, DELETE, OPTIONS">>, Req2),
    Req4 = cowboy_req:set_resp_header(<<"access-control-allow-headers">>, <<"content-type">>, Req3),
    {ok, Req4, Env}.
