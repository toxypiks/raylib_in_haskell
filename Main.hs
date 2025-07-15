{-# LANGUAGE CApiFFI #-}

import Data.Function
import Data.IORef
import Control.Monad
import Foreign.C.Types
import Foreign.C.String
import Foreign.Storable

data Color = Color { r :: CUChar, g :: CUChar, b :: CUChar, a :: CUChar}

foreign import capi "raylib.h InitWindow" initWindow :: CInt -> CInt -> CString -> IO ()
foreign import capi "raylib.h WindowShouldClose" windowShouldClose :: IO CBool
foreign import capi "raylib.h CloseWindow" closeWindow :: IO ()
foreign import capi "raylib.h ClearBackground" clearBackground :: CUInt -> IO ()
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

data Game = Game { gamePosition :: (CInt, CInt) }

newGame :: Game
newGame = Game { gamePosition = (0, 0) }

updateGame :: Game -> Game
updateGame game = game'
  where game'   = Game { gamePosition = (x + speed, y + speed) }
        (x, y) =  gamePosition game
        speed = 10

renderGame :: Game -> IO ()
renderGame game = do
  let (x, y) = gamePosition game
  drawRectangle x y 100 100 0xFF1818FF

main :: IO ()
main = do
  title <- newCString "Hello from Haskell"
  initWindow 800 600 title
  setTargetFPS 60
  -- IORef is a mutable variable in the IO monad
  gameIORef <- newIORef newGame
  while ((/= 0) <$> windowShouldClose) $ do
    beginDrawing
    clearBackground 0xFF181818
    game <- readIORef gameIORef
    renderGame game
    writeIORef gameIORef $ updateGame game
    endDrawing
  closeWindow
