-- name: CreatePayment :one
INSERT INTO payments (order_id, amount, status, provider)
VALUES ($1, $2, $3, $4)
    RETURNING *;

-- name: GetPaymentByOrderID :one
SELECT * FROM payments
WHERE order_id = $1
ORDER BY created_at DESC
    LIMIT 1;

-- name: UpdatePaymentStatus :one
UPDATE payments
SET status = $2
WHERE id = $1
    RETURNING *;