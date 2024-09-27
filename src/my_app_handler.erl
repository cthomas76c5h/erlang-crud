-module(my_app_handler).

-export([init/2]).

init(Req0, State) ->
    Method = cowboy_req:method(Req0),
    HasBody = cowboy_req:has_body(Req0),
    Req = handle_request(Method, HasBody, Req0),
    {ok, Req, State}.

handle_request(<<"OPTIONS">>, _, Req) ->
    cowboy_req:reply(200, #{
        <<"access-control-allow-origin">> => <<"*">>,
        <<"access-control-allow-methods">> => <<"GET, POST, PUT, DELETE, OPTIONS">>,
        <<"access-control-allow-headers">> => <<"content-type">>
    }, Req);

handle_request(<<"GET">>, _, Req) ->
    % Implement GET logic here
    cowboy_req:reply(200, #{<<"content-type">> => <<"application/json">>}, <<"{\"items\": []}">>, Req);

handle_request(<<"POST">>, true, Req0) ->
    % Implement POST logic here
    {ok, Body, Req} = cowboy_req:read_body(Req0),
    % Process Body...
    cowboy_req:reply(201, #{<<"content-type">> => <<"application/json">>}, <<"{\"status\": \"created\"}">>, Req);

handle_request(<<"PUT">>, true, Req0) ->
    % Implement PUT logic here
    {ok, Body, Req} = cowboy_req:read_body(Req0),
    % Process Body...
    cowboy_req:reply(200, #{<<"content-type">> => <<"application/json">>}, <<"{\"status\": \"updated\"}">>, Req);

handle_request(<<"DELETE">>, _, Req) ->
    % Implement DELETE logic here
    cowboy_req:reply(204, Req);

handle_request(_, _, Req) ->
    %% Method not allowed
    cowboy_req:reply(405, Req).
