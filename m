Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10C27D3286
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjJWLVG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjJWLVF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:21:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A14292
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:21:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F27C433C8;
        Mon, 23 Oct 2023 11:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060062;
        bh=EeXAqM553gZDENN2oO7kFYYBZ+xxNNomuO2U6fO98jM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HaOEkNvxSxyRYNGVsa8xnN62DSgL5j3XQIokxRefnLWwrH4Zi3U+UOLdd+ya/Ywd+
         q62Dd64hII39fN+bdougOI4Qh0/hbERzM+M+LiFoLjHaSIQr73fcIHyNwQesFpZien
         iUocHK510j+ba0+wddZh9Dgobe7pTVr87IHCOXII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 045/196] ASoC: codecs: wcd938x: fix resource leaks on bind errors
Date:   Mon, 23 Oct 2023 12:55:10 +0200
Message-ID: <20231023104829.787038389@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit da29b94ed3547cee9d510d02eca4009f2de476cf upstream.

Add the missing code to release resources on bind errors, including the
references taken by wcd938x_sdw_device_get() which also need to be
dropped on unbind().

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231003155558.27079-4-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wcd938x.c |   44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3441,7 +3441,8 @@ static int wcd938x_bind(struct device *d
 	wcd938x->rxdev = wcd938x_sdw_device_get(wcd938x->rxnode);
 	if (!wcd938x->rxdev) {
 		dev_err(dev, "could not find slave with matching of node\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_unbind;
 	}
 	wcd938x->sdw_priv[AIF1_PB] = dev_get_drvdata(wcd938x->rxdev);
 	wcd938x->sdw_priv[AIF1_PB]->wcd938x = wcd938x;
@@ -3449,7 +3450,8 @@ static int wcd938x_bind(struct device *d
 	wcd938x->txdev = wcd938x_sdw_device_get(wcd938x->txnode);
 	if (!wcd938x->txdev) {
 		dev_err(dev, "could not find txslave with matching of node\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_put_rxdev;
 	}
 	wcd938x->sdw_priv[AIF1_CAP] = dev_get_drvdata(wcd938x->txdev);
 	wcd938x->sdw_priv[AIF1_CAP]->wcd938x = wcd938x;
@@ -3460,31 +3462,35 @@ static int wcd938x_bind(struct device *d
 	if (!device_link_add(wcd938x->rxdev, wcd938x->txdev, DL_FLAG_STATELESS |
 			    DL_FLAG_PM_RUNTIME)) {
 		dev_err(dev, "could not devlink tx and rx\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_put_txdev;
 	}
 
 	if (!device_link_add(dev, wcd938x->txdev, DL_FLAG_STATELESS |
 					DL_FLAG_PM_RUNTIME)) {
 		dev_err(dev, "could not devlink wcd and tx\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_remove_rxtx_link;
 	}
 
 	if (!device_link_add(dev, wcd938x->rxdev, DL_FLAG_STATELESS |
 					DL_FLAG_PM_RUNTIME)) {
 		dev_err(dev, "could not devlink wcd and rx\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_remove_tx_link;
 	}
 
 	wcd938x->regmap = dev_get_regmap(&wcd938x->tx_sdw_dev->dev, NULL);
 	if (!wcd938x->regmap) {
 		dev_err(dev, "could not get TX device regmap\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_remove_rx_link;
 	}
 
 	ret = wcd938x_irq_init(wcd938x, dev);
 	if (ret) {
 		dev_err(dev, "%s: IRQ init failed: %d\n", __func__, ret);
-		return ret;
+		goto err_remove_rx_link;
 	}
 
 	wcd938x->sdw_priv[AIF1_PB]->slave_irq = wcd938x->virq;
@@ -3493,17 +3499,33 @@ static int wcd938x_bind(struct device *d
 	ret = wcd938x_set_micbias_data(wcd938x);
 	if (ret < 0) {
 		dev_err(dev, "%s: bad micbias pdata\n", __func__);
-		return ret;
+		goto err_remove_rx_link;
 	}
 
 	ret = snd_soc_register_component(dev, &soc_codec_dev_wcd938x,
 					 wcd938x_dais, ARRAY_SIZE(wcd938x_dais));
-	if (ret)
+	if (ret) {
 		dev_err(dev, "%s: Codec registration failed\n",
 				__func__);
+		goto err_remove_rx_link;
+	}
 
-	return ret;
+	return 0;
 
+err_remove_rx_link:
+	device_link_remove(dev, wcd938x->rxdev);
+err_remove_tx_link:
+	device_link_remove(dev, wcd938x->txdev);
+err_remove_rxtx_link:
+	device_link_remove(wcd938x->rxdev, wcd938x->txdev);
+err_put_txdev:
+	put_device(wcd938x->txdev);
+err_put_rxdev:
+	put_device(wcd938x->rxdev);
+err_unbind:
+	component_unbind_all(dev, wcd938x);
+
+	return ret;
 }
 
 static void wcd938x_unbind(struct device *dev)
@@ -3514,6 +3536,8 @@ static void wcd938x_unbind(struct device
 	device_link_remove(dev, wcd938x->txdev);
 	device_link_remove(dev, wcd938x->rxdev);
 	device_link_remove(wcd938x->rxdev, wcd938x->txdev);
+	put_device(wcd938x->txdev);
+	put_device(wcd938x->rxdev);
 	component_unbind_all(dev, wcd938x);
 }
 


