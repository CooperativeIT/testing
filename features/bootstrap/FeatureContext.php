<?php

use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Drupal\DrupalExtension\Context\MinkContext;
//use Behat\MinkExtension\Context\MinkContext;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends MinkContext implements Context
//class FeatureContext implements Context
{
    /**
     * Initializes context.
     *
     * Every scenario gets its own context instance.
     * You can also pass arbitrary arguments to the
     * context constructor through behat.yml.
     */
    public function __construct()
    {
    }

private function assetChecker($assetType, $assetSource, $assetCode){
			
			
			$assetElements = $this->getSession()->getPage()->findAll('css',$assetType);
			foreach($assetElements as $asset){
			  $assetUrl = ($asset->getAttribute($assetSource));

				// need to remove mailto links
				if (!str_contains(strval($assetUrl), 'mailto')){
					$this->visit($assetUrl);
					print($assetUrl . "\n");
					$this->assertResponseStatusIsNot($assetCode);
					$this->visit($base_url);
				}
			}
		}

    /**
     * @Then the images should not return :arg1
     */
    public function theImagesShouldNotReturn($code)
    {
			$this->assetChecker('img', 'src', $code);
    }

    /**
     * @Then the links should not return :arg1
     */
    public function theLinksShouldNotReturn($code)
    {
			$this->assetChecker('a', 'href', $code);
  }
  /**
   * @Then I should see :arg2 :arg1 items
   */
  public function iShouldSeeItems($number, $area)
  {
		switch($area){
			case "news":
		   	$area_search = ".news";
				break;
			case "incident":
		   	$area_search = ".incident";
				break;
			case "video":
		   	$area_search = ".video-embed-field-provider-youtube";
				break;		
		}
		$nodes =  $this->getSession()->getPage()->findAll('css', $area_search);
		if ($number != count($nodes)){
			throw new Exception("The number of " . $area . " items is " . count($nodes) . " and should be " . $number . ".");
		}
  }
}
