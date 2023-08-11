Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE8F779314
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 17:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjHKP3Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 11:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjHKP3Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 11:29:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F4119A5
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 08:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6010367542
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 15:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CBDC433C8;
        Fri, 11 Aug 2023 15:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691767762;
        bh=iJPuWaVvv+0Y/7iG8gaygby0+a4kkALTIY35YXg1QeU=;
        h=Subject:To:Cc:From:Date:From;
        b=JtwV1seWJKxpunyWdfvS57dTFtLv8dn5AquUWNNO5HW1qIyn2iVvVasWnLamk/vP6
         9MyPOmebO/lBQeooPNsmCvrxIDGIkFbJdH6x7Jfc6xvk0/XE01jS25/cX3xWImA41w
         8VRv6NO0mR55ODSVzxBW+J1lsPbqyU/Ht65yY+NQ=
Subject: FAILED: patch "[PATCH] mmc: sdhci-f-sdh30: Replace with sdhci_pltfm" failed to apply to 6.1-stable tree
To:     hayashi.kunihiko@socionext.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 11 Aug 2023 17:29:20 +0200
Message-ID: <2023081119-coke-handoff-8964@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 5def5c1c15bf22934ee227af85c1716762f3829f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081119-coke-handoff-8964@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5def5c1c15bf ("mmc: sdhci-f-sdh30: Replace with sdhci_pltfm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5def5c1c15bf22934ee227af85c1716762f3829f Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Fri, 30 Jun 2023 09:45:33 +0900
Subject: [PATCH] mmc: sdhci-f-sdh30: Replace with sdhci_pltfm

Even if sdhci_pltfm_pmops is specified for PM, this driver doesn't apply
sdhci_pltfm, so the structure is not correctly referenced in PM functions.
This applies sdhci_pltfm to this driver to fix this issue.

- Call sdhci_pltfm_init() instead of sdhci_alloc_host() and
  other functions that covered by sdhci_pltfm.
- Move ops and quirks to sdhci_pltfm_data
- Replace sdhci_priv() with own private function sdhci_f_sdh30_priv().

Fixes: 87a507459f49 ("mmc: sdhci: host: add new f_sdh30")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230630004533.26644-1-hayashi.kunihiko@socionext.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index a202a69a4b08..b01ffb4d0973 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -29,9 +29,16 @@ struct f_sdhost_priv {
 	bool enable_cmd_dat_delay;
 };
 
+static void *sdhci_f_sdhost_priv(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return sdhci_pltfm_priv(pltfm_host);
+}
+
 static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
 {
-	struct f_sdhost_priv *priv = sdhci_priv(host);
+	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
 	u32 ctrl = 0;
 
 	usleep_range(2500, 3000);
@@ -64,7 +71,7 @@ static unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
 
 static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
 {
-	struct f_sdhost_priv *priv = sdhci_priv(host);
+	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
 	u32 ctl;
 
 	if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0)
@@ -95,30 +102,32 @@ static const struct sdhci_ops sdhci_f_sdh30_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
+static const struct sdhci_pltfm_data sdhci_f_sdh30_pltfm_data = {
+	.ops = &sdhci_f_sdh30_ops,
+	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
+		| SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
+	.quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE
+		|  SDHCI_QUIRK2_TUNING_WORK_AROUND,
+};
+
 static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct device *dev = &pdev->dev;
-	int irq, ctrl = 0, ret = 0;
+	int ctrl = 0, ret = 0;
 	struct f_sdhost_priv *priv;
+	struct sdhci_pltfm_host *pltfm_host;
 	u32 reg = 0;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
+	host = sdhci_pltfm_init(pdev, &sdhci_f_sdh30_pltfm_data,
+				sizeof(struct f_sdhost_priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
-	priv = sdhci_priv(host);
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
 	priv->dev = dev;
 
-	host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
-		       SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
-	host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
-			SDHCI_QUIRK2_TUNING_WORK_AROUND;
-
 	priv->enable_cmd_dat_delay = device_property_read_bool(dev,
 						"fujitsu,cmd-dat-delay-select");
 
@@ -126,18 +135,6 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	platform_set_drvdata(pdev, host);
-
-	host->hw_name = "f_sdh30";
-	host->ops = &sdhci_f_sdh30_ops;
-	host->irq = irq;
-
-	host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(host->ioaddr)) {
-		ret = PTR_ERR(host->ioaddr);
-		goto err;
-	}
-
 	if (dev_of_node(dev)) {
 		sdhci_get_of_property(pdev);
 
@@ -204,24 +201,21 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 err_clk:
 	clk_disable_unprepare(priv->clk_iface);
 err:
-	sdhci_free_host(host);
+	sdhci_pltfm_free(pdev);
+
 	return ret;
 }
 
 static int sdhci_f_sdh30_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct f_sdhost_priv *priv = sdhci_priv(host);
-
-	sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
-			  0xffffffff);
+	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
 
 	reset_control_assert(priv->rst);
 	clk_disable_unprepare(priv->clk);
 	clk_disable_unprepare(priv->clk_iface);
 
-	sdhci_free_host(host);
-	platform_set_drvdata(pdev, NULL);
+	sdhci_pltfm_unregister(pdev);
 
 	return 0;
 }

