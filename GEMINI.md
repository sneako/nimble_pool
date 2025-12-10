# NimblePool

## Project Overview

`NimblePool` is a lightweight, low-overhead resource pooling library for Elixir. Unlike traditional process-based pools (like `poolboy`) where each pooled resource is wrapped in its own process, `NimblePool` manages resources directly within the pool manager process (or via simple references). This architecture significantly reduces the overhead associated with copying data between processes, making it ideal for managing resources like sockets (HTTP/1 connections) or ports.

**Key Features:**
*   **Low Overhead:** Avoids intermediate processes for resource management.
*   **Simple API:** implemented as a behaviour with callbacks for worker lifecycle.
*   **Flexible:** Supports synchronous and asynchronous worker initialization, lazy pooling, and idle resource cleanup.

## Building and Running

This project is built with Elixir and uses `mix` for dependency management and build tasks.

### Prerequisites
*   Elixir (~> 1.7)
*   Erlang/OTP

### Commands
*   **Install Dependencies:**
    ```bash
    mix deps.get
    ```
*   **Build Project:**
    ```bash
    mix compile
    ```
*   **Run Tests:**
    ```bash
    mix test
    ```
*   **Generate Documentation:**
    ```bash
    mix docs
    ```
*   **Run Test Coverage:**
    ```bash
    mix coveralls.html
    ```

## Development Conventions

### Architecture
*   **`NimblePool` Module:** The core `GenServer` that manages the pool state, queueing, and resource tracking.
*   **Callback Behaviour:** Users implement a module adopting the `NimblePool` behaviour.
    *   `init_worker(pool_state)`: Initializes a resource. Can be synchronous or asynchronous.
    *   `handle_checkout(command, from, worker_state, pool_state)`: Handles the checkout request, returning the client state (resource) and updating server state.
    *   `handle_checkin(client_state, from, worker_state, pool_state)`: Handles the return of a resource to the pool.
    *   `terminate_worker(reason, worker_state, pool_state)`: Cleans up a resource.
*   **State Management:** The pool maintains `pool_state` (global) and `worker_state` (per-resource).

### Testing
*   **Framework:** `ExUnit` is used for testing.
*   **Strategy:** Tests rely heavily on "mock" pool implementations (`StatelessPool` and `StatefulPool` in `test/nimble_pool_test.exs`) that use an Agent or message passing to verify that callbacks are invoked correctly and in the expected order.
*   **Conventions:**
    *   Tests should ensure resource cleanup (termination) even on failures.
    *   Verify both "eager" and "lazy" pool initialization modes.
    *   Test concurrency and race conditions during checkout/checkin.
