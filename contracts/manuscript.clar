;; Scriptory Manuscript Contract
;; Clarity v2
;; Manages versioned NFTs representing authored long-form content on-chain

(define-constant ERR-NOT-AUTHORIZED u100)
(define-constant ERR-INVALID-URI u101)
(define-constant ERR-NOT-OWNER u102)
(define-constant ERR-NFT-EXISTS u103)
(define-constant ERR-NFT-NOT-FOUND u104)

(define-constant NFT-NAME "Scriptory Manuscript")

(define-data-var admin principal tx-sender)
(define-data-var token-id-counter uint u0)

(define-map token-owners uint principal)
(define-map token-uris uint (string-ascii 256))
(define-map token-versions uint uint) ;; token-id -> latest version
(define-map token-history (tuple (token-id uint) (version uint))) (string-ascii 256)

;; Private helper: is-admin
(define-private (is-admin (caller principal))
  (is-eq caller (var-get admin))
)

;; Check if caller is the owner of the token
(define-private (is-owner (caller principal) (token-id uint))
  (match (map-get? token-owners token-id)
    owner (is-eq owner caller)
    false
  )
)

;; Public: Transfer ownership
(define-public (transfer (token-id uint) (to principal))
  (begin
    (asserts! (is-owner tx-sender token-id) (err ERR-NOT-OWNER))
    (map-set token-owners token-id to)
    (ok true)
  )
)

;; Public: Mint new manuscript
(define-public (mint (uri (string-ascii 256)))
  (begin
    (asserts! (> (len uri) u5) (err ERR-INVALID-URI))
    (let ((new-id (+ (var-get token-id-counter) u1)))
      (map-set token-owners new-id tx-sender)
      (map-set token-uris new-id uri)
      (map-set token-versions new-id u1)
      (map-set token-history { token-id: new-id, version: u1 } uri)
      (var-set token-id-counter new-id)
      (ok new-id)
    )
  )
)

;; Public: Add new version
(define-public (update-version (token-id uint) (new-uri (string-ascii 256)))
  (begin
    (asserts! (is-owner tx-sender token-id) (err ERR-NOT-OWNER))
    (asserts! (> (len new-uri) u5) (err ERR-INVALID-URI))
    (let ((version (+ (default-to u0 (map-get? token-versions token-id)) u1)))
      (map-set token-uris token-id new-uri)
      (map-set token-versions token-id version)
      (map-set token-history { token-id: token-id, version: version } new-uri)
      (ok version)
    )
  )
)

;; Read-only: get owner
(define-read-only (get-owner (token-id uint))
  (match (map-get? token-owners token-id)
    owner (ok owner)
    (err ERR-NFT-NOT-FOUND)
  )
)

;; Read-only: get URI
(define-read-only (get-uri (token-id uint))
  (match (map-get? token-uris token-id)
    uri (ok uri)
    (err ERR-NFT-NOT-FOUND)
  )
)

;; Read-only: get latest version number
(define-read-only (get-version (token-id uint))
  (match (map-get? token-versions token-id)
    version (ok version)
    (err ERR-NFT-NOT-FOUND)
  )
)

;; Read-only: get historical URI
(define-read-only (get-version-uri (token-id uint) (version uint))
  (match (map-get? token-history { token-id: token-id, version: version })
    uri (ok uri)
    (err ERR-NFT-NOT-FOUND)
  )
)

;; Admin: Set new admin
(define-public (set-admin (new-admin principal))
  (begin
    (asserts! (is-admin tx-sender) (err ERR-NOT-AUTHORIZED))
    (var-set admin new-admin)
    (ok true)
  )
)

;; Read-only: get current admin
(define-read-only (get-admin)
  (ok (var-get admin))
)
