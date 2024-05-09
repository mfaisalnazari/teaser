# TeaSub

### Versions
- Ruby: 3.2.2
- Rails: 7.1.3

## Project Description

The Tea Subscription Service API is a Rails-based backend system designed to facilitate tea subscription management for customers. With this API, users can subscribe to tea subscriptions, cancel existing subscriptions, and view their subscription list.


This api was built with by a developer as a take_home project for MOD 4 2311, from Turing School of Software and Design.

<details>
  <summary>Setup</summary>
  ```

  1. Fork and/or Clone this Repo from GitHub.
  2. In your terminal use `$ git clone <ssh or https path>`.
  3. Change into the cloned directory using `$ cd example`.
  4. Install the gem packages using `$ bundle install`.
  5. Database Migrations can be set up by running: 

  $ rails db:{drop,create,migrate,seed}

</details>


<details>
  <summary>Testing</summary>
```
  Test using the terminal utilizing RSpec:

  $ bundle exec rspec spec/<follow directory path to test specific files>
  

  or test the whole suite with `$ bundle exec rspec`
  
</details>



<details>
  <summary>Database Schema</summary>

  ```
ActiveRecord::Schema[7.1].define(version: 2024_05_04_062655) do
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "title"
    t.decimal "price"
    t.string "status", default: "active"
    t.string "frequency"
    t.bigint "customer_id", null: false
    t.bigint "tea_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_subscriptions_on_customer_id"
    t.index ["tea_id"], name: "index_subscriptions_on_tea_id"
  end

  create_table "teas", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "temperature"
    t.integer "brew_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "subscriptions", "customers"
  add_foreign_key "subscriptions", "teas"
end

```
</details>


# Endpoints
### User
<details>
<summary> Get All User Subscriptions</summary>


Request:

```http
GET /customers/:id/subscriptions
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
[
    {
        "id": 2,
        "title": "Subscription 2",
        "price": "14.99",
        "status": "cancelled",
        "frequency": "monthly",
        "customer_id": 2,
        "tea_id": 3,
        "created_at": "2024-05-04T07:19:34.020Z",
        "updated_at": "2024-05-04T07:19:34.020Z"
    }
]
```
</details>

<details>
<summary>Create a subscription</summary>

Request:

```http
POST /subscriptions
Content-Type: application/json
Accept: application/json
```

Body:

```json
{
  "subscription": {
    "title": "Subscription 3",
    "price": 9,
    "frequency": "monthly",
    "customer_id": 2,
    "tea_id": 2
  }
}
```

Response: `status: 200`

```json
{
    "id": 4,
    "title": "Subscription 3",
    "price": "9.0",
    "status": "active",
    "frequency": "monthly",
    "customer_id": 2,
    "tea_id": 2,
    "created_at": "2024-05-09T20:36:59.319Z",
    "updated_at": "2024-05-09T20:36:59.319Z"
}
```
</details>


<details>
<summary> Cancel a subscription </summary>
Request:

```http
DELETE /subscriptions/3
Content-Type: application/json
Accept: application/json
```

Response: `status: 204`
</details>
