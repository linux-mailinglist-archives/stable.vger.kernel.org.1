Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CE8712CFC
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 21:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbjEZTC5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 15:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjEZTC4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 15:02:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D52B194
        for <stable@vger.kernel.org>; Fri, 26 May 2023 12:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 904616529F
        for <stable@vger.kernel.org>; Fri, 26 May 2023 19:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7FDC433D2;
        Fri, 26 May 2023 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685127774;
        bh=ezrYthnjlH8D2zbilUyCy8n3EixmtBQ4F6G9cxLnl88=;
        h=Subject:To:Cc:From:Date:From;
        b=D1eQ7Yz3rz1t6/l8d9ZNExf9zqICMgsRyu9DyoBL0lOhD3DZbRL3harcMU/KESVak
         e5tYeBUQ8NnECww8A3Ip9vKHe00PDrTyf6+agXJ+QZkN8iynzOFGF1fNzsq8CxKVDe
         Q9R22YWdj8IXkvxPp22JHc8kj3e2yevnNUHW/E7Q=
Subject: FAILED: patch "[PATCH] mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works" failed to apply to 5.10-stable tree
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 26 May 2023 20:02:51 +0100
Message-ID: <2023052651-reporter-deuce-3950@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 81dce1490e28439c3cd8a8650b862a712f3061ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052651-reporter-deuce-3950@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

81dce1490e28 ("mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works")
f002f45a00ee ("mmc: sdhci-esdhc-imx: use the correct host caps for MMC_CAP_8_BIT_DATA")
1ed5c3b22fc7 ("mmc: sdhci-esdhc-imx: Propagate ESDHC_FLAG_HS400* only on 8bit bus")
2991ad76d253 ("mmc: sdhci-esdhc-imx: advertise HS400 mode through MMC caps")
854a22997ad5 ("mmc: sdhci-esdhc-imx: Convert the driver to DT-only")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 81dce1490e28439c3cd8a8650b862a712f3061ba Mon Sep 17 00:00:00 2001
From: Haibo Chen <haibo.chen@nxp.com>
Date: Thu, 4 May 2023 19:22:22 +0800
Subject: [PATCH] mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works

After commit 1ed5c3b22fc7 ("mmc: sdhci-esdhc-imx: Propagate
ESDHC_FLAG_HS400* only on 8bit bus"), the property "no-mmc-hs400"
from device tree file do not work any more.
This patch reorder the code, which can avoid the warning message
"drop HS400 support since no 8-bit bus" and also make the property
"no-mmc-hs400" from dts file works.

Fixes: 1ed5c3b22fc7 ("mmc: sdhci-esdhc-imx: Propagate ESDHC_FLAG_HS400* only on 8bit bus")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230504112222.3599602-1-haibo.chen@nxp.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d7c0c0b9e26c..eebf94604a7f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1634,6 +1634,10 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	/* HS400/HS400ES require 8 bit bus */
+	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
+		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+
 	if (mmc_gpio_get_cd(host->mmc) >= 0)
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
@@ -1724,10 +1728,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->mmc_host_ops.init_card = usdhc_init_card;
 	}
 
-	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
-	if (err)
-		goto disable_ahb_clk;
-
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;
@@ -1735,15 +1735,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
 		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
 
-	if (host->mmc->caps & MMC_CAP_8_BIT_DATA &&
-	    imx_data->socdata->flags & ESDHC_FLAG_HS400)
+	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
 		host->mmc->caps2 |= MMC_CAP2_HS400;
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_BROKEN_AUTO_CMD23)
 		host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;
 
-	if (host->mmc->caps & MMC_CAP_8_BIT_DATA &&
-	    imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
+	if (imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
 		host->mmc->caps2 |= MMC_CAP2_HS400_ES;
 		host->mmc_host_ops.hs400_enhanced_strobe =
 					esdhc_hs400_enhanced_strobe;
@@ -1765,6 +1763,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			goto disable_ahb_clk;
 	}
 
+	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
+	if (err)
+		goto disable_ahb_clk;
+
 	sdhci_esdhc_imx_hwinit(host);
 
 	err = sdhci_add_host(host);

