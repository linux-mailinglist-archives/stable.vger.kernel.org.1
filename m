Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C92713E5D
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjE1Te4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjE1Tex (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:34:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D982D9
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0126561DF6
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EB1C433EF;
        Sun, 28 May 2023 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302487;
        bh=8V+uoCTM32v783hLLdrYfx+1njT+Z4MUQugsmYODs2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSvRmZB5nS+XEU9W4rXLQyZ1p3aj8lx3cDG2LLRi4XqeAPDWiSRVe98eb43PNpIFM
         9RaklwHx1E9b3dB+8PpSnF5t6VJic+nkwrHxKihFzAk0FITwjITXSq9X1vUeaGLge0
         Z5tYQP8OXTb1O9/AJoQ5Wx/inD5VTXWniO2uH+5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.1 023/119] mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works
Date:   Sun, 28 May 2023 20:10:23 +0100
Message-Id: <20230528190836.121090211@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

commit 81dce1490e28439c3cd8a8650b862a712f3061ba upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1585,6 +1585,10 @@ sdhci_esdhc_imx_probe_dt(struct platform
 	if (ret)
 		return ret;
 
+	/* HS400/HS400ES require 8 bit bus */
+	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
+		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+
 	if (mmc_gpio_get_cd(host->mmc) >= 0)
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
@@ -1669,10 +1673,6 @@ static int sdhci_esdhc_imx_probe(struct
 		host->mmc_host_ops.execute_tuning = usdhc_execute_tuning;
 	}
 
-	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
-	if (err)
-		goto disable_ahb_clk;
-
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;
@@ -1680,15 +1680,13 @@ static int sdhci_esdhc_imx_probe(struct
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
@@ -1710,6 +1708,10 @@ static int sdhci_esdhc_imx_probe(struct
 			goto disable_ahb_clk;
 	}
 
+	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
+	if (err)
+		goto disable_ahb_clk;
+
 	sdhci_esdhc_imx_hwinit(host);
 
 	err = sdhci_add_host(host);


