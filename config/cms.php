<?php

return [
    /*
    |--------------------------------------------------------------------------
    | Available Layouts
    |--------------------------------------------------------------------------
    |
    | Here you can define the available layouts for CMS pages.
    | The key is the layout identifier and the value is an array with:
    | - 'name': human-readable name
    | - 'template': path to the Blade template file (relative to resources/views)
    |
    */
    'layouts' => [
        'default' => [
            'name' => 'Default Layout',
            'template' => 'cms::layouts.default',
        ],
        'full-width' => [
            'name' => 'Full Width',
            'template' => 'cms::layouts.full-width',
        ],
        'sidebar-left' => [
            'name' => 'Sidebar Left',
            'template' => 'cms::layouts.sidebar-left',
        ],
        'sidebar-right' => [
            'name' => 'Sidebar Right',
            'template' => 'cms::layouts.sidebar-right',
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Default Layout
    |--------------------------------------------------------------------------
    |
    | This is the default layout that will be used when creating new pages.
    |
    */
    'default_layout' => 'default',
];

