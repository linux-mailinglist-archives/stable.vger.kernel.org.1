Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEA37E24A0
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjKFNXh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjKFNXh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:23:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C310D8
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:23:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C112C433CA;
        Mon,  6 Nov 2023 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277013;
        bh=aNAy/F+ZxYmig91GpxTuetkI7lr006hPGWR0IK5i9xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yc68wDnYlUZ3qT9E+mjP0FK78i0h+v37879B9xAfL4Y9JxsaEetbdVlr40eyNhur8
         eJ+Iwct31Npj1WX3Nt8DAtwreS4LEGPE1+0Y0Uo9uGUjV6+1WTaxFxc5fP9Ow28K9W
         xTLbrO1J0H9mAuokPwri096NZZVXQYoP1z8f3Fd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15 001/128] ASoC: codecs: wcd938x: fix resource leaks on bind errors
Date:   Mon,  6 Nov 2023 14:02:41 +0100
Message-ID: <20231106130309.178568788@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4411,7 +4411,8 @@ static int wcd938x_bind(struct device *d
 	wcd938x->rxdev = wcd938x_sdw_device_get(wcd938x->rxnode);
 	if (!wcd938x->rxdev) {
 		dev_err(dev, "could not find slave with matching of node\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_unbind;
 	}
 	wcd938x->sdw_priv[AIF1_PB] = dev_get_drvdata(wcd938x->rxdev);
 	wcd938x->sdw_priv[AIF1_PB]->wcd938x = wcd938x;
@@ -4419,7 +4420,8 @@ static int wcd938x_bind(struct device *d
 	wcd938x->txdev = wcd938x_sdw_device_get(wcd938x->txnode);
 	if (!wcd938x->txdev) {
 		dev_err(dev, "could not find txslave with matching of node\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_put_rxdev;
 	}
 	wcd938x->sdw_priv[AIF1_CAP] = dev_get_drvdata(wcd938x->txdev);
 	wcd938x->sdw_priv[AIF1_CAP]->wcd938x = wcd938x;
@@ -4430,31 +4432,35 @@ static int wcd938x_bind(struct device *d
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
 
 	wcd938x->regmap = devm_regmap_init_sdw(wcd938x->tx_sdw_dev, &wcd938x_regmap_config);
 	if (IS_ERR(wcd938x->regmap)) {
 		dev_err(dev, "%s: tx csr regmap not found\n", __func__);
-		return PTR_ERR(wcd938x->regmap);
+		ret = PTR_ERR(wcd938x->regmap);
+		goto err_remove_rx_link;
 	}
 
 	ret = wcd938x_irq_init(wcd938x, dev);
 	if (ret) {
 		dev_err(dev, "%s: IRQ init failed: %d\n", __func__, ret);
-		return ret;
+		goto err_remove_rx_link;
 	}
 
 	wcd938x->sdw_priv[AIF1_PB]->slave_irq = wcd938x->virq;
@@ -4463,17 +4469,33 @@ static int wcd938x_bind(struct device *d
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
@@ -4484,6 +4506,8 @@ static void wcd938x_unbind(struct device
 	device_link_remove(dev, wcd938x->txdev);
 	device_link_remove(dev, wcd938x->rxdev);
 	device_link_remove(wcd938x->rxdev, wcd938x->txdev);
+	put_device(wcd938x->txdev);
+	put_device(wcd938x->rxdev);
 	component_unbind_all(dev, wcd938x);
 }
 


