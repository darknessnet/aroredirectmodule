<?php
/**
 * NOTICE OF LICENSE
 *
 * This file is licenced under the Software License Agreement.
 * With the purchase or the installation of the software in your application
 * you accept the licence agreement. 
 *
 * You must not modify, adapt or create derivative works of this source code
 *
 *  @author    Aroshiya (www.aroshiya.com)
 *  @copyright 2021-2035 Aroshiya Inc
 *  @license   LICENSE.txt
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

class aroredirectmodule extends Module
{
    public function __construct()
    {
        $this->name = 'aroredirectmodule';
        $this->tab = 'administration';
        $this->version = '1.0.0';
        $this->author = 'Aroshiya';
        $this->need_instance = 1;
        $this->module_key = 'a46be66d05ab0423a1ef10eab211d0dc';

        parent::__construct();

        $this->displayName = $this->l('Redirect URL 301, 302 and 404');
        $this->description = $this->l('Redirect URL module in PrestaShop is a tool that allows administrators to redirect specific URLs to another URL. This can be useful in a variety of situations, such as when a product has been discontinued and a similar product is available.');
        $this->bootstrap=false;
        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
    }

    public function install()
    {
        if (!parent::install() || !$this->registerHook('displayHeader')) {
            return false;
        }
        return true;
    }

    public function uninstall()
    {
        Configuration::deleteByName('aro_save_configuration');
        include(dirname(__FILE__).'/sql/uninstall.php');
        return parent::uninstall();
    }
    
    public function getContent()
    {
        $result = null;
        if (Tools::isSubmit('delete_attr')) {
            
            $data = json_decode(Configuration::get('aro_save_configuration'), true);;
            $delete_attr = Tools::getValue('delete_attr')-1;
            
            $mapping_url = array_search($data["mapping_url"][$delete_attr], $data["mapping_url"]);
            if (false !== $mapping_url) {
                unset($data["mapping_url"][$mapping_url]);
            }

            $redirect_url = array_search($data["redirect_url"][$delete_attr], $data["redirect_url"]);
            if (false !== $redirect_url){
                unset($data["redirect_url"][$redirect_url]);
            }

            $i = 0;
            $save_data = array();
            foreach($data["mapping_url"] as $key => $val){
                $save_data["mapping_url"][$i] = $val;
                $i++;
            }

            $i = 0;
            foreach($data["redirect_url"] as $key => $val){
                $save_data["redirect_url"][$i] = $val;
                $i++;
            }

            $result = "Deleted attribute successfully!"; 
            Configuration::updateValue("aro_save_configuration", json_encode($save_data));

        } elseif (Tools::isSubmit('save_configuration')) {

            $data = Tools::getAllValues();
            $save_data["mapping_url"] = (array_filter($data["mapping_url"], fn($value) => !is_null($value) && $value !== '')); 
            $save_data["redirect_url"] = (array_filter($data["redirect_url"], fn($value) => !is_null($value) && $value !== ''));
            
            $result = "Saved configuration successfully!"; 
            Configuration::updateValue("aro_save_configuration", json_encode($save_data));
            
        }

        $this->bootstrap=false;
        $this->context->smarty->assign(array(
            'configuration' => json_decode(Configuration::get('aro_save_configuration'), true),
            'token' => Tools::getAdminTokenLite('AdminModules'),
            'success' => $result
        ));
        return $this->context->smarty->fetch($this->local_path.'views/templates/admin/configure.tpl');
        
    }

    public function hookDisplayHeader()
    {
        $redirect_url = json_decode(Configuration::get('aro_save_configuration'), true);
        $actual_link = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
        $current_link = str_replace("?".$_SERVER['QUERY_STRING'],"",$actual_link);
        $redirect = @$redirect_url["mapping_url"]?: null;
        
        foreach($redirect as $key => $val){ 
            if($val == $current_link){
                Tools::redirect($redirect_url["redirect_url"][$key]);
            }
        }
    }
    
}
