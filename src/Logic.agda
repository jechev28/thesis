module Logic where

open import Nat

infixr 4 _,_
infix  3 ¬_
infixr 2 _∧_
infixr 1 _∨_
infixr 0 _↔_

-- The conjunction data type.

data _∧_ (A B : Set) : Set where
  _,_ : A → B → A ∧ B

∧-proj₁ : ∀ {A B} → A ∧ B → A
∧-proj₁ (a , _) = a

∧-proj₂ : ∀ {A B} → A ∧ B → B
∧-proj₂ (_ , b) = b

-- The disjunction data type.

data _∨_ (A B : Set) : Set where
  inj₁ : A → A ∨ B
  inj₂ : B → A ∨ B

case : ∀ {A B} → {C : Set} → (A → C) → (B → C) → A ∨ B → C
case f g (inj₁ a) = f a
case f g (inj₂ b) = g b

-- Biconditional.

_↔_ : Set → Set → Set
A ↔ B = (A → B) ∧ (B → A)

-- The empty type.

data ⊥ : Set where

⊥-elim : {A : Set} → ⊥ → A
⊥-elim ()

-- Negation.

¬_ : Set → Set
¬ A = A → ⊥

------------------------------------------------------------------------------
-- Some properties

∨-comm : {A B : Set} → A ∨ B → B ∨ A
∨-comm h = case inj₂ inj₁ h

∧-comm : {A B : Set} → A ∧ B → B ∧ A
∧-comm h = (∧-proj₂ h) , ∧-proj₁ h

postulate
  ∧-assoc₁ : {A B C : Set} → A ∧ (B ∧ C) → (A ∧ B) ∧ C

∧-assoc₂ : {A B C : Set} → (A ∧ B) ∧ C → A ∧ (B ∧ C)
∧-assoc₂ {A} {B} {C} h = ∧-proj₁ (∧-proj₁ h) , ∧-proj₁ (∧-comm (∧-proj₁ h)) , ∧-proj₂ h

-- Principle of non-contradiction
pnc : {P : Set} → P ∧ ¬ P → ⊥
pnc (p , ¬p) = ¬p p
