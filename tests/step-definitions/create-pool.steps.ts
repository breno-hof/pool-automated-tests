import 'dotenv/config'
import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { PoolCreateRequest, PoolCreateResponse } from "../models/pool-create-request";

let poolCreateRequest: PoolCreateRequest;
const url = process.env.URL_POOL_API + "/dev/pools";
let response: PoolCreateResponse;
let status: number

// Função genérica para requisições HTTP com fetch
async function fetchData<TRequest, TResponse>(method: string, url: string, data?: TRequest): Promise<TResponse> {
    const fetchResponse = await fetch(url, {
        method: method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data) || null,
    });

    if (![201, 204, 400].includes(fetchResponse.status)) {
		const body = await fetchResponse.json();
        throw new Error(`Erro in API: ${fetchResponse.status} - ${fetchResponse.statusText} - ${JSON.stringify(body)}`);
    }

	status = fetchResponse.status;
    return method != "DELETE" ? fetchResponse.json() as Promise<TResponse> : {} as Promise<TResponse>;
}

Given("a request with {string}, {string}, {float}, {string}, {string} and {string}", function (
	name: string,
	location: string,
	volume: number,
	material: string,
	heating_type: string,
	maintenance_frequency: string
) {
	poolCreateRequest = new PoolCreateRequest(name, location, volume, material, heating_type, maintenance_frequency);
});

When("making a POST HTTP request for Pool API", async function () {
	response = await fetchData<PoolCreateRequest, PoolCreateResponse>("POST", url, poolCreateRequest);
});

Then("should create a new Pool", function () {
	const { name, location, volume, material, heating_type, maintenance_frequency } = response.data;
	assert.equal(name, poolCreateRequest.name);
	assert.equal(location, poolCreateRequest.location);
	assert.equal(volume, poolCreateRequest.volume);
	assert.equal(material, poolCreateRequest.material);
	assert.equal(heating_type, poolCreateRequest.heating_type);
	assert.equal(maintenance_frequency, poolCreateRequest.maintenance_frequency);
});

Then("should delete this new Pool", async function () {
	const { pool_id } = response.data;

	await fetchData<PoolCreateRequest, any>("DELETE", url + "/" + pool_id);
});

Then("shouldn't create a new Pool", function () {
	assert.ok(response.data === undefined);
	assert.ok(response.errors !== undefined);
});

Then("should return {string}, {string} and status {int}", function (fieldError: string, messageError: string, code: number) {
	const { field, message } = response.errors[0];

	assert.equal(code, status);
	assert.equal(fieldError, field);
	assert.equal(messageError, message);
});