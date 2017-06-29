module HttpUtil exposing (uriEncode)

import Native.HttpUtil

uriEncode : String -> String
uriEncode =
  Native.HttpUtil.uriEncode
