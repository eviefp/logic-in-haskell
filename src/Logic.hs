{-# LANGUAGE InstanceSigs          #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes            #-}
{-# LANGUAGE ScopedTypeVariables   #-}

module Logic where

import           Control.Applicative (liftA2)
import           Control.Monad       ((<=<))
import           Data.Void           (Void, absurd)

class Iso a b where
    to :: a -> b
    from :: b -> a

newtype Lem m =
    Lem
        (  forall a
        .  m (Either a (a -> m Void))
        )

newtype Peirce m =
    Peirce
        (  forall a b
        .  ((a -> m b) -> m a)
        -> m a
        )

newtype DoubleNegation m =
    DoubleNegation
        (  forall a
        .  ((a -> m Void) -> m Void)
        -> m a
        )

newtype DeMorgan m =
    DeMorgan
        (  forall a b
        .  ((a -> m Void, b -> m Void) -> m Void)
        -> m (Either a b)
        )

newtype ImpliesToOr m =
    ImpliesToOr
        (  forall a b
        .  (a -> m b)
        -> m (Either b (a -> m Void))
        )

instance Monad m => Iso (Lem m) (Peirce m) where
    to :: Lem m -> Peirce m
    to (Lem lem) = Peirce proof

      where
        proof
            :: ((a -> m b) -> m a)
            -> m a
        proof abort = lem >>= either pure (go abort)

        go
            :: ((a -> m b) -> m a)
            -> (a -> m Void)
            -> m a
        go abort not_a = abort $ fmap absurd . not_a

    from :: Peirce m -> Lem m
    from (Peirce p) = Lem $ p go

      where
        go
            :: (Either a (a -> m Void) -> m Void)
            -> m (Either a (a -> m Void))
        go not_lem = pure . Right $ not_lem . Left

instance Monad m => Iso (Lem m) (DoubleNegation m) where
    to :: Lem m -> DoubleNegation m
    to (Lem lem) = DoubleNegation proof

      where
        proof
            :: ((a -> m Void) -> m Void)
            -> m a
        proof notNot = lem >>= either pure (go notNot)

        go
            :: ((a -> m Void) -> m Void)
            -> (a -> m Void)
            -> m a
        go notNot notA = fmap absurd $ notNot notA

    from :: DoubleNegation m -> Lem m
    from (DoubleNegation dne) = Lem $ dne not_exists_dist

instance Monad m => Iso (Lem m) (DeMorgan m) where
    to :: Lem m -> DeMorgan m
    to (Lem lem) = DeMorgan proof

      where
        proof
            :: ((a -> m Void, b -> m Void) -> m Void)
            -> m (Either a b)
        proof notNotANotB = lem >>= either pure (go notNotANotB)

        go
            :: ((a -> m Void, b -> m Void) -> m Void)
            -> (Either a b -> m Void)
            -> m (Either a b)
        go notNotANotB =
            fmap absurd
            . notNotANotB
            . liftA2 (,) (. Left) (. Right)

    from :: DeMorgan m -> Lem m
    from (DeMorgan dm) = Lem $ dm go

      where
        go
            :: (a -> m Void, (a -> m Void) -> m Void)
            -> m Void
        go (notA, notNotA) = notNotA notA

instance Monad m => Iso (Lem m) (ImpliesToOr m) where
    to :: Lem m -> ImpliesToOr m
    to (Lem lem) = ImpliesToOr proof

      where
        proof
            :: (a -> m b)
            -> m (Either b (a -> m Void))
        proof fab = either Left (go fab) <$> lem

        go
            :: (a -> m b)
            -> (b -> m Void)
            -> Either b (a -> m Void)
        go fab notB = Right $ notB <=< fab

    from :: ImpliesToOr m -> Lem m
    from (ImpliesToOr im) = Lem $ im pure

not_exists_dist
    :: forall a m
    .  Monad m
    => (Either a (a -> m Void) -> m Void) -> m Void
not_exists_dist notLem = notLem . Right $ notLem . Left
