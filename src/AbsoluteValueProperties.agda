
-- Properties of the absolute value.

module AbsoluteValueProperties where

open import AbsoluteValueDefinition
open import EqReasoning
open import EqProperties
open import LogicDefinitions
open import OrderedFieldProperties
open import RealNumbersAxioms

abs-0 : abs r₀ ≡ r₀
abs-0 with x<0∨x≥0 r₀
abs-0 | inj₁ 0<0 = ⊥-elim (<-irrefl 0<0)
abs-0 | inj₂ h = refl r₀

x>0→absx=x : (x : ℝ) → x > r₀ → abs x ≡ x
x>0→absx=x x x>0 with x<0∨x≥0 x
... | inj₁ p = ⊥-elim (≥→≮ (inj₁ x>0) p)
... | inj₂ _ = refl x

x<0→absx=-x : (x : ℝ) → x < r₀ → abs x ≡ - x
x<0→absx=-x x x<0 with x<0∨x≥0 x
... | inj₁ _ = refl (- x)
... | inj₂ p = ⊥-elim (≥→≮ p x<0)

abs-minus : (x : ℝ) → abs (- x) ≡ abs x
abs-minus x with x<0∨x≥0 (- x)
... | inj₁ p = ≡-sym (p-helper p)

  where
  p-helper : - x < r₀ → abs x ≡ - (- x)
  p-helper -x<0 =
    abs x   ≡⟨ x>0→absx=x x (-x<0→x>0 x -x<0) ⟩
    x       ≡⟨ ≡-sym mul--x ⟩
    - (- x) ∎

... | inj₂ p = case prf₁ prf₂ p

  where
  prf₁ : - x > r₀ → - x ≡ abs x
  prf₁ -x>0 = ≡-sym (x<0→absx=-x x (-x>0→x<0 -x>0))

  prf₂ : - x ≡ r₀ → - x ≡ abs x
  prf₂ -x=0 =
    - x       ≡⟨ -x=0 ⟩
    r₀        ≡⟨ ≡-sym abs-0 ⟩
    abs r₀    ≡⟨ subst (λ w → abs r₀ ≡ abs w) (≡-sym (-x=0→x=0 x -x=0))
                       (refl (abs r₀))
              ⟩
    abs x     ∎

abs≥x : (x : ℝ) → abs x ≥ x
abs≥x x with x<0∨x≥0 x
... | inj₁ p = inj₁ (>-+-cancel-r  (p₁-helper (>-*-cancel-l (>-inve-r₀
                      (>-trans 2>1 1>0)) (p₂-helper (p₃-helper p)))))

  where
  p₁-helper : r₀ > (ℕ2ℝ 2 * x) → - x + x > x + x
  p₁-helper 0>2 = subst₂ (λ t₁ t₂ → t₁ > t₂) (≡-sym p₁₁-helper) 2x=x+x 0>2

    where
    p₁₁-helper : - x + x ≡ r₀
    p₁₁-helper =
      - x + x ≡⟨ +-comm (- x) x ⟩
      x - x  ≡⟨ +-inve x ⟩
      r₀     ∎

  p₂-helper : r₀ > (ℕ2ℝ 2 ⁻¹ * ℕ2ℝ 2) * x → ℕ2ℝ 2 ⁻¹ * r₀ > ℕ2ℝ 2 ⁻¹ * (ℕ2ℝ 2 * x)
  p₂-helper h = subst₂ (λ t₁ t₂ → t₁ > t₂) (≡-sym p₂₂-helper)
                       (*-asso (ℕ2ℝ 2 ⁻¹) (ℕ2ℝ 2) x) h

     where
     p₂₂-helper : ℕ2ℝ 2 ⁻¹ * r₀ ≡ r₀
     p₂₂-helper =
       ℕ2ℝ 2 ⁻¹ * r₀ ≡⟨ *-comm (ℕ2ℝ 2 ⁻¹) r₀ ⟩
       r₀ * ℕ2ℝ 2 ⁻¹ ≡⟨ *-left-zero ⟩
       r₀             ∎

  p₃-helper : r₀ > x → r₀ > (ℕ2ℝ 2 ⁻¹ * ℕ2ℝ 2) * x
  p₃-helper 0>x = subst₂ (λ t₁ t₂ → t₁ > t₂) (refl r₀) (≡-sym p₃₃-helper) 0>x

     where
     p₃₃-helper : ℕ2ℝ 2 ⁻¹ * ℕ2ℝ 2 * x ≡ x
     p₃₃-helper =
       (ℕ2ℝ 2 ⁻¹ * ℕ2ℝ 2) * x ≡⟨ subst (λ w → (ℕ2ℝ 2 ⁻¹ * ℕ2ℝ 2) * x ≡ w * x)
                                       (*-comm (ℕ2ℝ 2 ⁻¹)
                                       (ℕ2ℝ 2)) (refl ((ℕ2ℝ 2 ⁻¹ * ℕ2ℝ 2) * x))
                              ⟩
       (ℕ2ℝ 2 * ℕ2ℝ 2 ⁻¹) * x ≡⟨ subst (λ w → (ℕ2ℝ 2 * ℕ2ℝ 2 ⁻¹) * x ≡ w * x)
                                       (*-inve (ℕ2ℝ 2) 2≢0)
                                       (refl ((ℕ2ℝ 2 * ℕ2ℝ 2 ⁻¹) * x))
                              ⟩
       r₁ * x ≡⟨ *-comm r₁ x ⟩
       x * r₁ ≡⟨ *-neut x ⟩
       x             ∎

... | inj₂ _ = inj₂ (refl x)

abs-minus≤x : (x : ℝ) → - (abs x) ≤ x
abs-minus≤x x with x<0∨x≥0 x
... | inj₁ _ = inj₂ mul--x
... | inj₂ p = case prf₁ prf₂ p

  where
  prf₁ : x > r₀ → x > - x ∨ - x ≡ x
  prf₁ x>0 = inj₁ (<-to->
                    (minus-to-< (p₁-helper (p₂-helper (p₃-helper (p₄-helper
                      (p₅-helper (p₆-helper (p₇-helper x>0)))))))))

    where
    p₁-helper : x + x > r₀ → x - - x > r₀
    p₁-helper h₁ = subst₂ (λ t₁ t₂ → t₁ > t₂ )
                          (subst (λ w → x + x ≡ x + w)
                                 (≡-sym mul--x) (refl (x + x)))
                          (refl r₀)
                          h₁

    p₂-helper : (ℕ2ℝ 2 * x) > r₀ → x + x > r₀
    p₂-helper 2x>0 = subst₂ (λ t₁ t₂ → t₁ > t₂) 2x=x+x (refl r₀) 2x>0

    p₃-helper : ℕ2ℝ 2 ⁻¹ * (ℕ2ℝ 2 * x) > ℕ2ℝ 2 ⁻¹ * r₀ → (ℕ2ℝ 2 * x) > r₀
    p₃-helper h₂ = >-*-cancel-l (>-inve-r₀ (>-trans 2>1 1>0)) h₂

    p₄-helper : (ℕ2ℝ 2 ⁻¹ * ℕ2ℝ 2) * x > r₀ → ℕ2ℝ 2 ⁻¹ * (ℕ2ℝ 2 * x) > ℕ2ℝ 2 ⁻¹ * r₀
    p₄-helper h₃ = subst₂ (λ t₁ t₂ → t₁ > t₂)
                          (*-asso (ℕ2ℝ 2 ⁻¹)
                          (ℕ2ℝ 2) x)
                          (≡-sym *-right-zero)
                          h₃

    p₅-helper : (ℕ2ℝ 2 * ℕ2ℝ 2 ⁻¹) * x > r₀ → (ℕ2ℝ 2 ⁻¹ * ℕ2ℝ 2) * x > r₀
    p₅-helper h₄ = subst₂ (λ t₁ t₂ → t₁ > t₂)
                          (subst (λ w → (ℕ2ℝ 2 * ℕ2ℝ 2 ⁻¹) * x ≡ w * x)
                                 (*-comm (ℕ2ℝ 2)
                                 (ℕ2ℝ 2 ⁻¹))
                          (refl ((ℕ2ℝ 2 * ℕ2ℝ 2 ⁻¹) * x)))
                          (refl r₀)
                          h₄

    p₆-helper : r₁ * x > r₀ → (ℕ2ℝ 2 * ℕ2ℝ 2 ⁻¹) * x > r₀
    p₆-helper 1*x>0 = subst₂ (λ t₁ t₂ → t₁ > t₂)
                             (subst (λ w → r₁ * x ≡ w * x)
                                    (≡-sym (*-inve (ℕ2ℝ 2)
                                    (>→≢ (>-trans 2>1 1>0))))
                             (refl (r₁ * x)))
                             (refl r₀)
                             1*x>0

    p₇-helper : x > r₀ → r₁ * x > r₀
    p₇-helper x>0 = subst₂ (λ t₁ t₂ → t₁ > t₂) p₇₁-helper (refl r₀) x>0

       where
       p₇₁-helper : x ≡ r₁ * x
       p₇₁-helper =
         x      ≡⟨ ≡-sym (*-neut x) ⟩
         x * r₁ ≡⟨ *-comm x r₁ ⟩
         r₁ * x  ∎

  prf₂ : x ≡ r₀ → x > - x ∨ - x ≡ x
  prf₂ x=0 = inj₂ helper

    where
    helper : - x ≡ x
    helper =
      - x        ≡⟨ *-negation ⟩
      (- r₁) * x ≡⟨ subst (λ w → (- r₁) * x ≡ (- r₁) * w) x=0 (refl ((- r₁) * x)) ⟩
      - r₁ * r₀  ≡⟨ *-right-zero ⟩
      r₀         ≡⟨ ≡-sym x=0 ⟩
      x          ∎

x+y≤absx+absy : (x y : ℝ) → x + y ≤ abs x + abs y
x+y≤absx+absy x y = ≤-≤-+ (≥-to-≤ (abs≥x x)) (≥-to-≤ (abs≥x y))

-absx+-absy≤x+y : (x y : ℝ) → - (abs x) + ( - abs y) ≤ x + y
-absx+-absy≤x+y x y = ≤-≤-+ (abs-minus≤x x) (abs-minus≤x y)

abs-tri : (x y : ℝ) → abs (x + y) ≤ abs x + abs y
abs-tri x y with x<0∨x≥0 (x + y)
... | inj₁ p = helper

  where
  helper : - (x + y) ≤ abs x + abs y
  helper = p₁-helper (≤-to-≥ (p₂-helper (-absx+-absy≤x+y x y)))

    where
    p₁-helper : x + y ≥ - (abs x + abs y) → - (x + y) ≤ abs x + abs y
    p₁-helper h₁ = x≥-y→-x≤y (x + y) (abs x + abs y) h₁

    p₂-helper : - (abs x) + ( - abs y) ≤ x + y → - (abs x + abs y) ≤ x + y
    p₂-helper h₂ = subst₂ (λ t₁ t₂ → t₁ ≤ t₂) (≡-sym mul-x+y) (refl (x + y)) h₂

... | inj₂ _ = x+y≤absx+absy x y

abs-tri-minus : (x y : ℝ) → abs (x - y) ≤ abs x + abs y
abs-tri-minus x y = helper x y (abs-tri x (- y))

  where
  helper : (x y : ℝ) →
           abs (x + (- y)) ≤ abs x + abs ( - y) → abs (x - y) ≤ abs x + abs y
  helper x y h = subst₂ (λ t₁ t₂ → t₁ ≤ t₂)
                        (refl (abs (x + (- y))))
                        (subst (λ w → abs x + abs ( - y) ≡ abs x + w)
                               (abs-minus y)
                               (refl (abs x + abs ( - y))))
                         h
