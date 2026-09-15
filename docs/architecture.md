# Architecture

## Workflow stages

1. **Intake** — Webhook receives normalized PO content or a reference to a document.
2. **Extraction** — LLM converts semi-structured content into strict JSON.
3. **Validation** — deterministic checks verify required fields, numeric values, totals, and approval threshold.
4. **Decision** — high-value or low-confidence POs are routed for human approval.
5. **Persistence** — validated records are written to PostgreSQL.
6. **Audit** — every important state transition is recorded for traceability.
7. **Notification** — the downstream system can notify procurement/management through its approved channel.

## Design principles

- AI handles interpretation; deterministic code handles business rules.
- Secrets stay outside Git.
- Human approval remains available for material financial decisions.
- Idempotency should be added before production deployment.
- Raw documents and sensitive supplier data should follow the organization's retention and access policies.

## Suggested production components

- n8n for orchestration
- An approved LLM provider for extraction
- PostgreSQL for structured records and audit events
- Object storage for source documents
- SSO/API authentication for internal access
- Webhook or messaging integration for approvals
