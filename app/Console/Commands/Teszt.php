<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Molitor\Cms\Models\Page;
use Molitor\Cms\Services\ContentHandler;

class Teszt extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:teszt';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        /** @var ContentHandler $ch */
        $ch = app(ContentHandler::class);

        $p = Page::find(1);
        if(!$p) {
            $p = new Page();
            $p->title = 'Teszt oldal';
            $p->slug = 'teszt';
            $p->save();
        }

        $ch->sevaContentElements($p->content, [
            [
                'type' => 'heading',
                'settings' => [
                    'level' => 1,
                    'text' => 'Ez itt a cím',
                ]
            ],
            [
                'type' => 'text',
                'settings' => [
                    'text' => 'Ez itt a szöveg',
                ]
            ],
            [
                'type' => 'image',
                'settings' => [
                    'src' => 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60',
                ]
            ],
            [
                'type' => 'text',
                'settings' => [
                    'text' => 'aaaaa',
                ]
            ],
        ]);
    }
}
