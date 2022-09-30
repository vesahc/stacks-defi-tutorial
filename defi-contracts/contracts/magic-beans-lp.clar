;; contracts/magic-beans-lp.clar
(define-fungible-token magic-beans-lp)

(define-constant err-minter-only (err u300))
(define-constant err-amount-zero (err u301))

(define-data-var allowed-minter principal tx-sender)

(define-read-only (get-total-supply)
    (ft-get-supply magic-beans-lp)
)

;; Change the minter to any other principal, can only be called the current minter
(define-public (set-minter (who principal))
    begin
        (asserts! (is-eq tx-sender (var-get allowed-minter)) err-minter-only)
        ;; who is unchecked, we allow the minter to make whoever they like the new minter)
