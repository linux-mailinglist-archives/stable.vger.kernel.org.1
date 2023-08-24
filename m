Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1F7787670
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbjHXRQW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240834AbjHXRP4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:15:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCB319B5
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35E8D60F19
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F32BC433C7;
        Thu, 24 Aug 2023 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897352;
        bh=d5dwJwqrJlGTbWBMJ34OuiTAqtm5kQ315v1IpPqwEQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iBWSfDzAOm5vk1QThb+s6GeSyvT1ZyZk1bua2AxLv/BfKXu890yhTU0kAZdIRORey
         lAOWWf+z3m+53TOevheFGCmilXyL/eaY9n+X3ccVi3g5eH0aCcDpQVeqSayBE8kjxe
         xFO2dg8PzU/XM9stYA465u5gaRTEh6e6FYzz/LEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 001/135] mmc: sdhci-f-sdh30: Replace with sdhci_pltfm
Date:   Thu, 24 Aug 2023 19:07:53 +0200
Message-ID: <20230824170617.154241965@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

[ Upstream commit 5def5c1c15bf22934ee227af85c1716762f3829f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 60 ++++++++++++++------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 6c4f43e112826..8876fd1c7eee0 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -26,9 +26,16 @@ struct f_sdhost_priv {
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
@@ -61,7 +68,7 @@ static unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
 
 static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
 {
-	struct f_sdhost_priv *priv = sdhci_priv(host);
+	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
 	u32 ctl;
 
 	if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0)
@@ -85,30 +92,32 @@ static const struct sdhci_ops sdhci_f_sdh30_ops = {
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
 
@@ -116,18 +125,6 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
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
 
@@ -182,23 +179,20 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
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
 
 	clk_disable_unprepare(priv->clk_iface);
 	clk_disable_unprepare(priv->clk);
 
-	sdhci_free_host(host);
-	platform_set_drvdata(pdev, NULL);
+	sdhci_pltfm_unregister(pdev);
 
 	return 0;
 }
-- 
2.40.1



