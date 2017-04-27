-- Properties of distance

module DistancePropertiesATP where

open import AbsoluteValueProperties
open import DistanceDefinition
open import LogicDefinitions
open import OrderedFieldProperties
open import RealNumbersAxioms

postulate d-refl : (x y : ℝ) → (dist x y ≡ r₀) ↔ (x ≡ y)
{-# ATP prove d-refl abs-0 x>0→absx=x x<0→absx=-x #-}

postulate dis-des : (x y z w : ℝ) → dist (x + z) (y + w) ≤ dist x y + dist z w
{-# ATP prove dis-des abs-tri #-}
