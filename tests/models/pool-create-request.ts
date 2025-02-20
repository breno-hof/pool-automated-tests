export class PoolCreateRequest {
    constructor(
        public name: string,
        public location: string, 
        public volume: number, 
        public material: string, 
        public heating_type: string, 
        public maintenance_frequency: string 
    ) { }
}

export type PoolCreateResponse = {
    data: {
        pool_id: string
        name: string
        location: string
        volume: number
        material: string
        heating_type: string
        maintenance_frequency: string
        notes: [string]
    },
    errors: [{
        field: string,
        message: string
    }]
}