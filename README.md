# Stock Price App

Rails application for browsing stocks, viewing per-stock price history, and visualizing the latest 30 days of prices in a chart.

## What This App Does

- Lists all stocks (newest first)
- Shows full price history for a selected stock
- Renders a line chart for the selected stock’s recent 30-day window
- Exposes a JSON endpoint used by the chart for async updates

## Tech Stack

- Ruby `2.1.4`
- Rails `4.2.5`
- PostgreSQL
- Haml templates
- jQuery + Rails UJS
- Chart.js (via `chart-js-rails`)
- RSpec (models, controllers, routing)

## Quick Start

### 1) Prerequisites

- Ruby `2.1.4`
- Bundler compatible with this Ruby/Rails version
- PostgreSQL running locally

> Note: Ruby 2.1 and Rails 4.2 are end-of-life. If you are onboarding on a modern machine, use a Ruby version manager (for example `rbenv`/`rvm`) and pin the exact runtime for this repo.

### 2) Install dependencies

```bash
bundle install
```

### 3) Configure database

Default DB names are defined in `config/database.yml`:

- `stocks_development`
- `stocks_test`

Create and migrate:

```bash
bundle exec rake db:create db:migrate
```

### 4) Seed sample data

```bash
bundle exec rake db:seed
```

Seeds create 5 stocks with 60 days of random prices each.

### 5) Run the app

```bash
bundle exec rails server
```

Open: `http://localhost:3000`

## Main Pages

- `/` → Stock price history page with chart (`StocksController#price_history`)
- `/stocks` → Stock list
- `/stocks/:stock_id/prices` → Price table for a stock

## Architecture Diagram

```mermaid
flowchart LR
	A[Browser: Price History Page\n/ (stocks#price_history)] --> B[Haml View\napp/views/stocks/price_history.html.haml]
	B --> C[jQuery + Chart.js\napp/assets/javascripts/stocks.js]
	C --> D[GET /stocks/search_prices\nstock[id]=X]
	D --> E[StocksController#search_prices]
	E --> F[Stock + Price Models\nActiveRecord Query\n30-day date window]
	F --> G[JSON Response\nstock_name + dates + prices]
	G --> C
	C --> H[Chart Re-rendered in Canvas]

	I[Browser: Stocks Index\n/stocks] --> J[StocksController#index]
	J --> K[Stock Model\norder id desc]
	K --> L[Haml Table View\napp/views/stocks/index.html.haml]

	M[Browser: Stock Prices\n/stocks/:stock_id/prices] --> N[PricesController#index]
	N --> O[Price Model via stock.prices\norder date desc]
	O --> P[Haml Table View\napp/views/prices/index.html.haml]
```

Flow summary:

- The root page loads an empty Chart.js canvas, then auto-submits the stock selector form.
- `search_prices` returns JSON for the selected stock, and frontend JS updates the existing chart instance.
- Non-chart pages (`/stocks`, `/stocks/:stock_id/prices`) use standard Rails controller-to-view rendering.

## API Endpoint Used by the Chart

`GET /stocks/search_prices?stock[id]=:id`

Returns JSON:

```json
{
	"stock_name": "PG&E",
	"dates": ["2026-02-01", "2026-02-02"],
	"prices": [12.5, 12.75]
}
```

Behavior:

- Filters data to `30.days.ago..1.day.from_now`
- Sorts by date ascending
- Triggered automatically when stock selection changes

## Data Model

### `Stock`

- `name` (required)
- `has_many :prices`

### `Price`

- `stock_id` (required association)
- `date` (required)
- `price` (required, numeric, `>= 0`)
- `belongs_to :stock`

## Project Structure (High-Value Paths)

- `app/controllers/stocks_controller.rb`
- `app/controllers/prices_controller.rb`
- `app/models/stock.rb`
- `app/models/price.rb`
- `app/views/stocks/price_history.html.haml`
- `app/assets/javascripts/stocks.js`
- `config/routes.rb`
- `db/seeds.rb`
- `spec/`

## Testing

Run all specs:

```bash
bundle exec rspec
```

Run a subset:

```bash
bundle exec rspec spec/models
bundle exec rspec spec/controllers
```

## Contributing

### Workflow

1. Create a feature branch from `main`.
2. Keep changes scoped and atomic.
3. Add or update specs for behavior changes.
4. Run test suite locally.
5. Open a PR with clear description and test evidence.

### Engineering Guidelines

- Follow existing Rails 4 style and project conventions.
- Prefer small, composable controller/model changes.
- Do not commit secrets or machine-specific credentials.
- Update this README when setup, routes, or workflows change.

## Troubleshooting

### PostgreSQL connection issues

- Ensure Postgres is running.
- Verify DB names in `config/database.yml`.
- Re-run:

```bash
bundle exec rake db:create db:migrate db:seed
```

### Assets or JavaScript chart not updating

- Confirm requests to `/stocks/search_prices` return `200` JSON.
- Check browser console for JS errors.
- Ensure stocks and prices exist (`db:seed`).

## Notes for Maintainers

- The chart page is the application root route.
- Frontend chart logic lives in `app/assets/javascripts/stocks.js`.
- Current runtime is legacy; consider planning an upgrade path (Ruby/Rails/gem set) before major feature work.
