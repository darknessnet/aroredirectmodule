{*
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
  *
  *}

<link href="https://ui-kit.prestashop.com/backoffice/latest/css/bootstrap-prestashop-ui-kit.css" rel="stylesheet">
<script src="https://ui-kit.prestashop.com/backoffice/latest/js/prestashop-ui-kit.js"></script>

{if isset($success)}
<div class="alert alert-success" role="alert">
  <p class="alert-text">{$success}</p>
</div>
{/if}

<ul class="nav nav-pills" role="tablist">
  <li class="nav-item">
    <a
      class="nav-link active"
      id="pills-home-tab"
      data-toggle="pill"
      href="#pills-home"
      role="tab"
      aria-controls="pills-home"
      aria-expanded="true"
      >Dashboard</a
    >
  </li>
  <li class="nav-item">
    <a
      class="nav-link"
      id="pills-profile-tab"
      data-toggle="pill"
      href="#pills-profile"
      role="tab"
      aria-controls="pills-profile"
      aria-expanded="true"
      >Tutorial</a
    >
  </li>
</ul>
<div class="tab-content" id="pills-tabContent">
  <div
    class="tab-pane fade show active"
    id="pills-home"
    role="tabpanel"
    aria-labelledby="pills-home-tab"
  >
    <div class="container">
      <form method="post">
        <style>
            .aro_input {
                border: 1px solid !important; 
                border-color: #0867b2 !important; 
                width: 80% !important;
                padding: 10px !important;
                margin: 3% !important;
                border-radius: 4px !important;
                font-size: 15px !important;
            }
            .aro_button {
                padding: 10px !important; 
                font-size: 20px !important; 
                color: white !important; 
                background: #0b5ed7 !important; 
                border-radius: 4px !important; 
                border: none !important;
            }
        </style> 
            
            <table style="width:100%">
                <tr>
                  <td><h2>Enter Mapping URL : <i class="fab fa-info-circle" data-toggle="tooltip" title="Enter URL which you want to apply redirection on"></i></h2>
                  <p>Enter URL which you want to apply redirection on</p></td>
                  <td><h2>Enter Redirect URL : <i class="fab fa-info-circle" data-toggle="tooltip" title="Enter the URL that you want to redirect."></i></h2>
                  <p>Enter the URL that you want to redirect to.</p></td>
                </tr>
                {$a = 1}
                {if (is_array($configuration) && sizeof($configuration) > 0)}
                    {for $i=0 to sizeof($configuration["mapping_url"])-1}
                            <tr><td>
                            <input type="url" placeholder="https://example.com" class="aro_input" name="mapping_url[]" value="{$configuration["mapping_url"][{$i}]}" required/>
                            </td><td>
                            <input type="url" placeholder="https://example.com" class="aro_input" name="redirect_url[]" value="{$configuration["redirect_url"][{$i}]}" required/>
                            </td><td>
                            <button type="submit" name="delete_attr" value="{$a}" class="btn btn-outline-danger btn-lg">Delete</button>
                            </td></tr>
                        {$a = $a +1}
                    {/for}
                {/if}
                <tr>
                    <td><br><input type="url" placeholder="https://example.com" class="aro_input" name="mapping_url[]" /></td>
                    <td><br><input type="url" placeholder="https://example.com" class="aro_input" name="redirect_url[]" /></td>
                    <td><br>
                    <input type="button" name="add_attribute" value="+" onclick="add_custom_attribute();" class="aro_button" />&nbsp;
                    <input type="button" name="remove_attribute" value="-" onclick="remove_custom_attribute();" class="aro_button" />
                    </td>
                </tr>
                <tr id="custom_attribute"><td></td></tr>
                <tr>
                    <td colspan="3"><br>
                        <br><button type="submit" class="btn btn-primary btn-lg" id="save_configuration" name="save_configuration">Save</button>&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </form>
        <script>
            var countAttributes;
            function add_custom_attribute(){
                countAttributes += {$a};
                jQuery("<tr id='custom_row_" + countAttributes + "'><td>"+
                "<input type='url' id='mapping_url_" + countAttributes + "' name='mapping_url[]' placeholder='https://example.com' class='aro_input'/></td><td>"+
                "<input type='url' id='redirect_url_" + countAttributes + "' name='redirect_url[]' placeholder='https://example.com' class='aro_input'/></td><td>").insertBefore(jQuery("#custom_attribute"));
            }
            jQuery(document).ready(function(){
                countAttributes = 1;
            });

            function remove_custom_attribute(){
                jQuery("#custom_row_" + countAttributes).remove();
                countAttributes -= 1;
                if(countAttributes == 0)
                    countAttributes = 1;
            }
        </script>

    </div>
  </div>
  <div
    class="tab-pane fade"
    id="pills-profile"
    role="tabpanel"
    aria-labelledby="pills-profile-tab"
  >
    <div class="container">
      <h2>Guideline for Redirect URL Module in Prestashop</h2>
      <ul>
        <li>To apply a redirect, enter the URL in the <b>Mapping URL Field</b>.</li><br>
        <li>The URL you want to redirect should be entered in <b>Redirect URL Field</b>.</li>
        <img src="{__PS_BASE_URI__}/modules/aroredirectmodule/views/img/ps_redirect_module.png" alt="prestashop redirect module" width="90%" height="50%">
        <li>Now, when you visit the mapping url that you configured, you will be sent to the navigation url.</li>
      <ul>
    </div>
  </div>
</div>
