##gitReady-to-use assignment content


# WEEK 8 DATABASE CAPSTONE PROJECT

## Project Title: Multi-Tenant E-Commerce Management System

### 1. Introduction
The Multi-Tenant E-Commerce Management System is designed to help multiple businesses manage their online stores using one centralized database. Each business can manage its own products, customers, orders, payments, and inventory securely.

### 2. Project Objectives
- Develop a centralized e-commerce database.
- Support multiple businesses.
- Manage products and inventory.
- Record customer orders and payments.
- Improve database performance.
- Protect sensitive business information.

### 3. Functional Requirements
1. Businesses can register and manage their stores.
2. Users can log in and manage business information.
3. Businesses can add, update, and delete products.
4. Customers can register and browse products.
5. Customers can place orders.
6. The system records order items and payments.
7. Administrators can monitor inventory.
8. Businesses can only access their own data.

### 4. Non-Functional Requirements
- Security: Implement access control and Row-Level Security.
- Performance: Use indexes to improve query execution.
- Reliability: Use PostgreSQL transactions and backups.
- Scalability: Support multiple businesses.
- Maintainability: Use Flyway database migrations.
- Availability: Provide reliable database access.

### 5. Technology Stack
- PostgreSQL: Main relational database.
- Redis: Shopping cart and caching.
- Flyway: Database migration management.
- SQL: Database queries and triggers.
- VS Code: Development environment.

### 6. Main Database Entities
1. Businesses
2. Users
3. Customers
4. Categories
5. Products
6. Orders
7. Order Items
8. Payments
9. Audit Logs

### 7. Expected Outcome
The final system will provide a secure, reliable, and efficient e-commerce database. It will support multiple businesses, protect their information, improve query performance, and provide backup and recovery capabilities.