<?php
/**
 * NOTICE OF LICENSE
 *
 * This file is licenced under the Software License Agreement.
 * With the purchase or the installation of the software in your application
 * you accept the licence agreement. (https://aroshiya.github.io/aroshiya_license.pdf)
 *
 * You must not modify, adapt or create derivative works of this source code
 *
 *  @author    Aroshiya (www.aroshiya.com)
 *  @copyright 2021-2035 Aroshiya Inc
 *  @license   LICENSE.txt
 */

$sql = array();

foreach ($sql as $query) {
    if (Db::getInstance()->execute($query) == false) {
        return false;
    }
}
