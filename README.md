# AI-Powered Purchase Order Automation with n8n

An end-to-end automation concept for turning Purchase Order (PO) documents into structured, validated, auditable data using **n8n + an LLM + PostgreSQL + webhooks**.

> Portfolio project — designed as a realistic enterprise automation pattern. No production credentials or company data are included.

## Problem

Purchase Orders often arrive as PDFs or semi-structured messages. Manual re-entry creates delays and increases the chance of errors in supplier names, quantities, prices, totals, and approval routing.

## Solution

```text
PO / Webhook
     |
     v
   n8n
     |
     v
LLM extraction
     |
     v
Validation + risk checks
     |
   +-----+------+
   |            |
   v            v
PostgreSQL   Approval
   |            |
   +-----+------+
         |
         v
     Audit Log
```

The workflow is intentionally modular so an organization can replace the LLM provider, database, notification channel, or approval UI without redesigning the whole automation.

## Features

- Structured PO extraction into JSON
- AI-assisted normalization of supplier and line-item data
- Validation rules for quantities, prices, totals, and required fields
- Approval routing based on configurable thresholds
- PostgreSQL-ready data model
- Webhook-first integration pattern
- Audit-log concept for traceability
- Sample input/output for demonstrations
- Importable n8n workflow template

## Repository

```text
n8n-ai-po-automation/
├── README.md
├── LICENSE
├── .gitignore
├── workflows/
│   └── po-ai-automation.json
├── prompts/
│   └── po-extraction.md
├── database/
│   └── schema.sql
├── examples/
│   ├── sample-po.json
│   └── sample-output.json
└── docs/
    ├── architecture.md
    └── linkedin-post.md
```

## Quick start

1. Install or open an n8n instance.
2. Import `workflows/po-ai-automation.json`.
3. Configure your LLM/API credentials in the HTTP Request node according to your environment.
4. Set the PostgreSQL connection details if you extend the template with a database node.
5. Send the example payload from `examples/sample-po.json` to the webhook.
6. Review the normalized output and validation result.

### Environment variables

The template avoids hard-coded secrets. A typical deployment can provide:

```bash
OPENAI_API_KEY=replace_me
```

Use your organization's approved secret-management mechanism in production; do not commit API keys to Git.

## Example output

```json
{
  "po_number": "PO-2026-001",
  "supplier": "PT ABC Indonesia",
  "currency": "IDR",
  "total_amount": 125000000,
  "requires_approval": true,
  "risk_flags": ["AMOUNT_ABOVE_APPROVAL_THRESHOLD"],
  "items": [
    {"description": "Besi Hollow 20x40x2 mm", "quantity": 100, "uom": "pcs"}
  ]
}
```

## Production hardening ideas

- Add authentication and signature validation to the webhook.
- Store raw documents in controlled object storage and retain only required metadata in the database.
- Add idempotency using PO number + supplier + document hash.
- Validate LLM output against a strict JSON schema before database writes.
- Add human review for high-value or low-confidence documents.
- Keep prompts, model versions, workflow versions, and audit events traceable.
- Apply least-privilege credentials and rotate secrets regularly.

## Why this project matters

This is not just an AI chatbot. It demonstrates an **automation architecture** where AI is one component inside a deterministic workflow: intake → extraction → validation → decision → persistence → audit.

## License

MIT — see `LICENSE`.
