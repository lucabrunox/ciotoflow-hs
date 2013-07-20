module Utils where

maybeDo_ :: Monad m => Maybe a -> (a -> m ()) -> m ()
maybeDo_ m f = case m of
  Just x -> f x
  Nothing -> return ()

maybeDo :: Monad m => Maybe a -> m b -> (a -> m b) -> m b
maybeDo m b f = case m of
  Just x -> f x
  Nothing -> b

(#) :: a -> (a -> b) -> b
(#) x f = f x