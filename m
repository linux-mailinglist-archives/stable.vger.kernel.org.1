Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620357D155C
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 20:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjJTSCh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 14:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjJTSCg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 14:02:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6C0D51
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 11:02:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0F2C433C8;
        Fri, 20 Oct 2023 18:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697824954;
        bh=RYBN2FkuNM7fPNUX+71DLcq0ctB4EKII/H+wHGREYfg=;
        h=Subject:To:Cc:From:Date:From;
        b=gdiQc6Uj5FAnc2tBggz8D36+ceTlI1Xav64ifvHuXSYyIEXogBUBrS4dpMg46/VhQ
         9C6LrImQFVWUbnKACAFUeW9AwUGQtUTDPwch65zKvhghfgwXvadGJQiRrmu9P9M/OQ
         5okI1/rr8L11BAJE79cQPQABFwYzYjII4zjzFWtc=
Subject: FAILED: patch "[PATCH] ASoC: codecs: wcd938x: fix regulator leaks on probe errors" failed to apply to 6.1-stable tree
To:     johan+linaro@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 20:02:32 +0200
Message-ID: <2023102031-dropper-froth-7dd6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 69a026a2357ee69983690d07976de44ef26ee38a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102031-dropper-froth-7dd6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 69a026a2357ee69983690d07976de44ef26ee38a Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Tue, 3 Oct 2023 17:55:55 +0200
Subject: [PATCH] ASoC: codecs: wcd938x: fix regulator leaks on probe errors

Make sure to disable and free the regulators on probe errors and on
driver unbind.

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231003155558.27079-5-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 7e0b07eeed77..679c627f7eaa 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3325,8 +3325,10 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 		return dev_err_probe(dev, ret, "Failed to get supplies\n");
 
 	ret = regulator_bulk_enable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
-	if (ret)
+	if (ret) {
+		regulator_bulk_free(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 		return dev_err_probe(dev, ret, "Failed to enable supplies\n");
+	}
 
 	wcd938x_dt_parse_micbias_info(dev, wcd938x);
 
@@ -3592,13 +3594,13 @@ static int wcd938x_probe(struct platform_device *pdev)
 
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
@@ -3608,11 +3610,21 @@ static int wcd938x_probe(struct platform_device *pdev)
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

