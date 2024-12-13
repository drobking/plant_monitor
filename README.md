# Plant Monitoring React Project

A **Plant Monitoring Application** built with **React**, featuring **Server-Side Rendering (SSR)**, **Prisma** as the ORM for database management, and containerized using **Docker**.

---

## Features

- **React 18**: Modern UI with reusable components.
- **Server-Side Rendering (SSR)**: Improved SEO and faster initial load times.
- **Prisma**: Simplified database management with a type-safe ORM.
- **Docker**: Easily deploy and run the application in a containerized environment.
- **Tailwind CSS**: For responsive and modern styling.
- **PostgreSQL**: As the database.

---

## Prerequisites

Before you begin, make sure you have the following installed:

- **Node.js**: [Download Node.js](https://nodejs.org/)
- **Docker**: [Download Docker](https://www.docker.com/)
- **PostgreSQL** (if not using Docker)

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-repo/plant-monitoring.git
cd plant-monitoring


This is a [Next.js](https://nextjs.org) project bootstrapped with [`create-next-app`](https://nextjs.org/docs/app/api-reference/cli/create-next-app).

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.tsx`. The page auto-updates as you edit the file.

This project uses [`next/font`](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) to automatically optimize and load [Geist](https://vercel.com/font), a new font family for Vercel.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/app/building-your-application/deploying) for more details.

# Database Schema

## User Table
Represents a user in the system.

### Properties:
- `id`: Unique identifier for the user (int, primary key).
- `role`: Role of the user (string).
- `listOfPlants`: Array of `Plant` objects associated with the user (relation).
- `name`: First name of the user (string).
- `surname`: Last name of the user (string).
- `phonenumber`: Contact number of the user (string).
- `email`: Email address of the user (string, unique).
- `password`: Encrypted password of the user (string).

## Plant Table
Represents a plant entity in the system.

### Properties:
- `id`: Unique identifier for the plant (int, primary key).
- `name`: Name of the plant (string).
- `listOfData`: Array of `PData` objects for this plant (relation).
- `notes`: Additional notes about the plant (string).

## PData Table
Stores periodic data for plants.

### Properties:
- `id`: Unique identifier for the PData record (int, primary key).
- `plantId`: Foreign key referencing the associated `Plant` (relation).
- `dirtH`: Dirt humidity level (float).
- `airH`: Air humidity level (float).
- `temp`: Temperature (float).

---

# Prisma Schema (Code)

```prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model User {
  id           Int      @id @default(autoincrement())
  role         String
  name         String
  surname      String
  phonenumber  String
  email        String   @unique
  password     String
  listOfPlants Plant[]  @relation("UserPlants")
}

model Plant {
  id          Int      @id @default(autoincrement())
  name        String
  notes       String?
  listOfData  PData[]  @relation("PlantData")
  userId      Int
  user        User     @relation(fields: [userId], references: [id])
}

model PData {
  id     Int     @id @default(autoincrement())
  plantId Int
  dirtH  Float
  airH   Float
  temp   Float
  plant  Plant   @relation(fields: [plantId], references: [id])
}


