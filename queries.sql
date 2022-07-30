CREATE DATABASE "drivenbank";


CREATE TABLE "customers"(
	"id" SERIAL PRIMARY KEY,
	"fullName" TEXT NOT NULL,
	"cpf" VARCHAR(11) NOT NULL UNIQUE,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL
);


CREATE TABLE "states"(
	"id" SERIAL PRIMARY KEY,
	"name" TEXT NOT NULL
);


CREATE TABLE "cities"(
	"id" SERIAL PRIMARY KEY,
	"name" TEXT NOT NULL,
	"stateId" INTEGER NOT NULL REFERENCES "states"("id")
);


CREATE TABLE "customerAdresses"(
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL UNIQUE REFERENCES "customers"("id"),
	"street" TEXT NOT NULL,
	"number" INTEGER NOT NULL,
	"complement" TEXT,
	"postalCode" TEXT NOT NULL,
	"cityId" INTEGER NOT NULL REFERENCES "cities"("id")
);


CREATE TYPE phone AS ENUM ('landline', 'mobile');


CREATE TABLE "customerPhones"(
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
	"number" TEXT NOT NULL,
	"type" phone NOT NULL
);


CREATE TABLE "bankAccount"(
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
	"accountNumber" TEXT NOT NULL UNIQUE,
	"agency" TEXT NOT NULL,
	"openDate" TIMESTAMP NOT NULL DEFAULT NOW(),
	"closeDate" TIMESTAMP DEFAULT NULL
);


CREATE TYPE transaction AS ENUM ('deposit', 'withdraw');


CREATE TABLE "transactions"(
	"id" SERIAL PRIMARY KEY,
	"backAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
	"amount" INTEGER NOT NULL,
	"type" transaction NOT NULL,
	"time" TIMESTAMP NOT NULL DEFAULT NOW(),
	"description" TEXT,
	"cancelled" BOOLEAN NOT NULL DEFAULT FALSE
);


CREATE TABLE "creditCards"(
	"id" SERIAL PRIMARY KEY,
	"backAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
	"name" TEXT NOT NULL,
	"number" TEXT UNIQUE NOT NULL,
	"securityCode" TEXT UNIQUE NOT NULL,
	"expirationMonth" TEXT NOT NULL,
	"expirationYear" TEXT NOT NULL,
	"password" TEXT NOT NULL,
	"limit" INTEGER NOT NULL DEFAULT 0
);

