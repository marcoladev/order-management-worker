# Order Management Worker

A standalone, event-driven background processing service built with .NET 8 following Clean Architecture principles. This worker is designed to consume messaging payloads asynchronously from RabbitMQ and persist telemetry metrics to a MySQL data store.

## Purpose

The Worker acts as a consumer companion to the `OrderManagement.Api`. It decouples heavy-lifting, asynchronous operations—such as processing events, constructing audit logs, and preparing state tracking records—keeping the public-facing HTTP API fast and lightweight.

## Architecture

The worker shares the solution-wide **Clean Architecture** patterns:

* **Worker**: Host initialization, Dependency Injection configuration, and RabbitMQ continuous background listeners (hosted services).
* **Application**: Event model declarations, processing logic, and persistence interfaces.
* **Domain**: Business rules, core invariants, and structural schemas like the `AuditLog` model.
* **Infrastructure**: Entity Framework Core persistence setup, concrete data repositories, and the physical broker connection fabrics.

## Event-Driven Workflow

### Order Creation

1. A client creates an order through the API.
2. The order is persisted in MySQL.
3. An `OrderCreatedEvent` is published to RabbitMQ.
4. The Worker consumes the event.
5. An audit log entry is created and stored in the database.

```text
API
 ↓
MySQL (Orders)
 ↓
RabbitMQ
 ↓
Worker
 ↓
MySQL (AuditLogs)
```

## Technologies

* .NET 8
* ASP.NET Core
* Entity Framework Core
* MySQL
* RabbitMQ
* FluentValidation
* Docker
* xUnit
* Swagger

## Running RabbitMQ

```bash
docker run -d \
  --name rabbitmq \
  -p 5672:5672 \
  -p 15672:15672 \
  rabbitmq:management
```

RabbitMQ Management UI:

http://localhost:15672

Default credentials:

* Username: guest
* Password: guest

## Future Improvements

* Notification Worker
* Email Notifications
* Retry Policies and Dead Letter Queues
* Integration Tests
* Unit Testing
* Docker Compose Setup