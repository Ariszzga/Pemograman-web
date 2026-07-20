<?php
/**
 * backend/api/faq.php
 * GET /backend/api/faq.php
 */
declare(strict_types=1);

require_once __DIR__ . '/../config/data.php';

json_response([
    'status' => 'success',
    'data'   => get_faqs(),
]);
