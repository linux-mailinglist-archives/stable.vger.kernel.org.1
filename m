Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D17A7D3102
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjJWLEc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjJWLE1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:04:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C76710E2
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:04:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973B1C433C8;
        Mon, 23 Oct 2023 11:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059065;
        bh=2EwQyq2uFVcoT8zad93IZqhEfLEM2axC8c7Ax0wmjrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ani5mRJCgAq/2mVWkor1EKBQS2cuh2dSPLNiNJpQd4pVPpBwey3Cn2ehmA1rSJUG/
         u8gXZozrUN/7ApG4wdlyjE94hihhlJZJ0IUlnxqPd2SYvRYR1trqgWN2XCk9EXEvHy
         p7x/jJshdV4PijdhqSs2B7Zu6bnIMqh/oBbZ+R2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.5 051/241] ASoC: codecs: wcd938x: fix regulator leaks on probe errors
Date:   Mon, 23 Oct 2023 12:53:57 +0200
Message-ID: <20231023104835.153773450@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit 69a026a2357ee69983690d07976de44ef26ee38a upstream.

Make sure to disable and free the regulators on probe errors and on
driver unbind.

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231003155558.27079-5-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wcd938x.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3325,8 +3325,10 @@ static int wcd938x_populate_dt_data(stru
 		return dev_err_probe(dev, ret, "Failed to get supplies\n");
 
 	ret = regulator_bulk_enable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
-	if (ret)
+	if (ret) {
+		regulator_bulk_free(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 		return dev_err_probe(dev, ret, "Failed to enable supplies\n");
+	}
 
 	wcd938x_dt_parse_micbias_info(dev, wcd938x);
 
@@ -3592,13 +3594,13 @@ static int wcd938x_probe(struct platform
 
 	ret = wcd938x_add_slave_components(wcd938x, dev, &match);
 	if (ret)
-		return ret;
+		goto err_disable_regulators;
 
 	wcd938x_reset(wcd938x);
 
 	ret = component_master_add_with_match(dev, &wcd938x_comp_ops, match);
 	if (ret)
-		return ret;
+		goto err_disable_regulators;
 
 	pm_runtime_set_autosuspend_delay(dev, 1000);
 	pm_runtime_use_autosuspend(dev);
@@ -3608,11 +3610,21 @@ static int wcd938x_probe(struct platform
 	pm_runtime_idle(dev);
 
 	return 0;
+
+err_disable_regulators:
+	regulator_bulk_disable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
+	regulator_bulk_free(WCD938X_MAX_SUPPLY, wcd938x->supplies);
+
+	return ret;
 }
 
 static void wcd938x_remove(struct platform_device *pdev)
 {
+	struct wcd938x_priv *wcd938x = dev_get_drvdata(&pdev->dev);
+
 	component_master_del(&pdev->dev, &wcd938x_comp_ops);
+	regulator_bulk_disable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
+	regulator_bulk_free(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 }
 
 #if defined(CONFIG_OF)


