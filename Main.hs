{-# LANGUAGE CApiFFI #-}

import Data.Function
import Control.Monad
import Foreign.C.Types
import Foreign.C.String
import Foreign.Storable

data Color = Color { r :: CUChar, g :: CUChar, b :: CUChar, a :: CUChar}

foreign import capi "raylib.h InitWindow" initWindow :: CInt -> CInt -> CString -> IO ()
foreign import capi "raylib.h WindowShouldClose" windowShouldClose :: IO CBool
foreign import capi "raylib.h CloseWindow" closeWindow :: IO ()
foreign import capi "raylib.h BeginDrawing" beginDrawing :: IO ()
foreign import capi "raylib.h EndDrawing" endDrawing :: IO ()
foreign import capi "raylib.h SetTargetFPS" setTargetFPS :: CInt -> IO ()
foreign import capi "raylib.h DrawRectangle" drawRectangle :: CInt -> CInt -> CInt -> CInt -> CUInt -> IO ()

while :: Monad f => f Bool -> f () -> f ()
while cond body = do
  x <- cond
  if x then return ()
  else do body
          while cond body

main :: IO ()
main = do
  title <- newCString "Hello from Suskell"
  initWindow 800 600 title
  setTargetFPS 60
  while ((/= 0) <$> windowShouldClose) $ do
    beginDrawing
    drawRectangle 0 0 100 100 0xFF1818FF
    endDrawing
  closeWindow
