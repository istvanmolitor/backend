<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Molitor\Cms\Database\Seeders\CmsSeeder;
use Molitor\Language\database\seeders\LanguageSeeder;
use Molitor\User\database\seeders\UserSeeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            UserSeeder::class,
            LanguageSeeder::class,
            CmsSeeder::class,
        ]);
    }
}
