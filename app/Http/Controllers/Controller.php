<?php

namespace App\Http\Controllers;

use OpenApi\Attributes as OA;

#[OA\Info(title: "My API", version: "0.1")]
#[OA\SecurityScheme(
    securityScheme: "sanctum",
    type: "apiKey",
    name: "Authorization",
    in: "header",
    description: "Enter token in format (Bearer <token>)"
)]
abstract class Controller
{
    //
}
