Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E6F7D330D
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjJWL0M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjJWL0L (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:26:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017F0A4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:26:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ECBC433C7;
        Mon, 23 Oct 2023 11:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060368;
        bh=FUeFBnuTXi7JnBxyLnskcj2VOqlTAy5/Ozm1Is3RZCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K9I/+M1xomMbgFOrpCoOL3Y82EXCeKEHEyYHGl5zl2EwUwdrUiAcAtcUPKjqye5FP
         94+ENYP3+qDqQq/UdjYpkLzA7ZX45By7WebS32GCUWhFztnSawfD75cH8XLAwFZ++w
         qkh7XxCyXNeMz+UQXyLz+hZnl50zxB8jQTsH+/jY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stanislaw Kardach <skardach@google.com>,
        Sven van Ashbrook <svenva@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.1 149/196] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix SoCs can suspend
Date:   Mon, 23 Oct 2023 12:56:54 +0200
Message-ID: <20231023104832.689828317@linuxfoundation.org>
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

From: Sven van Ashbrook <svenva@chromium.org>

commit 1202d617e3d04c8d27a14ef30784a698c48170b3 upstream.

To improve the r/w performance of GL9763E, the current driver inhibits LPM
negotiation while the device is active.

This prevents a large number of SoCs from suspending, notably x86 systems
which commonly use S0ix as the suspend mechanism - for example, Intel
Alder Lake and Raptor Lake processors.

Failure description:
1. Userspace initiates s2idle suspend (e.g. via writing to
   /sys/power/state)
2. This switches the runtime_pm device state to active, which disables
   LPM negotiation, then calls the "regular" suspend callback
3. With LPM negotiation disabled, the bus cannot enter low-power state
4. On a large number of SoCs, if the bus not in a low-power state, S0ix
   cannot be entered, which in turn prevents the SoC from entering
   suspend.

Fix by re-enabling LPM negotiation in the device's suspend callback.

Suggested-by: Stanislaw Kardach <skardach@google.com>
Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
Cc: stable@vger.kernel.org
Signed-off-by: Sven van Ashbrook <svenva@chromium.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20230831160055.v3.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-pci-gli.c |  104 ++++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 38 deletions(-)

--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -756,42 +756,6 @@ static u32 sdhci_gl9750_readl(struct sdh
 	return value;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
-{
-	struct sdhci_pci_slot *slot = chip->slots[0];
-
-	pci_free_irq_vectors(slot->chip->pdev);
-	gli_pcie_enable_msi(slot);
-
-	return sdhci_pci_resume_host(chip);
-}
-
-static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
-{
-	struct sdhci_pci_slot *slot = chip->slots[0];
-	int ret;
-
-	ret = sdhci_pci_gli_resume(chip);
-	if (ret)
-		return ret;
-
-	return cqhci_resume(slot->host->mmc);
-}
-
-static int sdhci_cqhci_gli_suspend(struct sdhci_pci_chip *chip)
-{
-	struct sdhci_pci_slot *slot = chip->slots[0];
-	int ret;
-
-	ret = cqhci_suspend(slot->host->mmc);
-	if (ret)
-		return ret;
-
-	return sdhci_suspend_host(slot->host);
-}
-#endif
-
 static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
 					  struct mmc_ios *ios)
 {
@@ -1040,6 +1004,70 @@ static int gl9763e_runtime_resume(struct
 }
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+
+	pci_free_irq_vectors(slot->chip->pdev);
+	gli_pcie_enable_msi(slot);
+
+	return sdhci_pci_resume_host(chip);
+}
+
+static int gl9763e_resume(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+	int ret;
+
+	ret = sdhci_pci_gli_resume(chip);
+	if (ret)
+		return ret;
+
+	ret = cqhci_resume(slot->host->mmc);
+	if (ret)
+		return ret;
+
+	/*
+	 * Disable LPM negotiation to bring device back in sync
+	 * with its runtime_pm state.
+	 */
+	gl9763e_set_low_power_negotiation(slot, false);
+
+	return 0;
+}
+
+static int gl9763e_suspend(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+	int ret;
+
+	/*
+	 * Certain SoCs can suspend only with the bus in low-
+	 * power state, notably x86 SoCs when using S0ix.
+	 * Re-enable LPM negotiation to allow entering L1 state
+	 * and entering system suspend.
+	 */
+	gl9763e_set_low_power_negotiation(slot, true);
+
+	ret = cqhci_suspend(slot->host->mmc);
+	if (ret)
+		goto err_suspend;
+
+	ret = sdhci_suspend_host(slot->host);
+	if (ret)
+		goto err_suspend_host;
+
+	return 0;
+
+err_suspend_host:
+	cqhci_resume(slot->host->mmc);
+err_suspend:
+	gl9763e_set_low_power_negotiation(slot, false);
+	return ret;
+}
+#endif
+
 static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
@@ -1147,8 +1175,8 @@ const struct sdhci_pci_fixes sdhci_gl976
 	.probe_slot	= gli_probe_slot_gl9763e,
 	.ops            = &sdhci_gl9763e_ops,
 #ifdef CONFIG_PM_SLEEP
-	.resume		= sdhci_cqhci_gli_resume,
-	.suspend	= sdhci_cqhci_gli_suspend,
+	.resume		= gl9763e_resume,
+	.suspend	= gl9763e_suspend,
 #endif
 #ifdef CONFIG_PM
 	.runtime_suspend = gl9763e_runtime_suspend,


