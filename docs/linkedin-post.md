# LinkedIn Launch Draft

I built an AI-powered Purchase Order automation workflow using n8n.

The idea is simple: instead of manually reading PO documents and re-entering the data, the workflow can receive a PO, extract structured information with an LLM, validate the result, route high-value orders for approval, and persist an audit trail.

**Workflow:**
PO → n8n → AI extraction → validation → approval → PostgreSQL → audit log

What I focused on:
- AI as an extraction component, not the entire system
- deterministic business validation around the model
- human-in-the-loop approval for high-value transactions
- reusable webhook/API architecture
- auditability and secret-safe configuration

This project is available on GitHub as a portfolio reference for AI automation and agentic workflow design.

#n8n #AIAutomation #AIEngineering #Automation #WorkflowAutomation #PostgreSQL #LLM #AgenticAI #GitHub
