-module(my_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/api/items", my_app_handler, []}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(my_http_listener,
        [{port, 8080}],
        #{env => #{dispatch => Dispatch},
          middlewares => [cors_middleware, cowboy_router, cowboy_handler]}
    ),
    my_app_sup:start_link().

stop(_State) ->
    ok.
