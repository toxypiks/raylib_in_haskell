{-# LANGUAGE CApiFFI #-}

import Data.Function
import Foreign.C.Types
import Foreign.C.String

foreign import capi "raylib.h InitWindow" initWindow :: CInt -> CInt -> CString -> IO ()
--foreign import capi "raylib.h WindowShouldClose" windowShouldClose :: IO CBool

{--main :: IO ()
main = do
  title <- newCstring "Hello from Suskell"
  initWindow 800 600 title--}
