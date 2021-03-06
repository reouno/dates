module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Element exposing (Element, column, text)
import Html exposing (Html)
import Url


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "TMT", body = elements model }


elements : Model -> List (Html Msg)
elements model =
    [ Element.layout [] (mainView model) ]


mainView : Model -> Element Msg
mainView _ =
    column []
        [ helloMessage
        ]


helloMessage : Element Msg
helloMessage =
    text "Hello, world."


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url, Cmd.none )


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
