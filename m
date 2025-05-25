Return-Path: <stable+bounces-146306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B420AC34A0
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 14:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189287ACBC3
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 12:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1731B4F08;
	Sun, 25 May 2025 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uqvGxqB/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C696DDC1
	for <stable@vger.kernel.org>; Sun, 25 May 2025 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748176578; cv=none; b=oIALvhVGv6uHs32yg3ZqJOVskWwR3S4vLSTCC9+O/Uc2DXoXOoL1P6VF55++DzeRZi5TVSxXtSkHGzQu8lougRbQaFNqr279VtW7Y06k83XTxMs6wvE3GiiU0iHpABu3dYfIMA10vyiEihEeucbiWUdenmlEtYp6cFyl2Nz6iiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748176578; c=relaxed/simple;
	bh=pGgJHNlURj68Nf871LYJtmhvzZHpDyuhKS2sIiG3AH4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BZqzaANbTrDNqW4rx//lNIe783S/IcWfNSSqMK3ajIbuRezeWY5tBjEdvGXjctYkY8EkEZVf/xGt35rJGPpHZWsy862nBFXgkiy2yx7F4XLvEM+wbU2wU+FgRmuTS4BjPXdxjqiiZNeOvcXAi6Pe25Srm4zvKJ6Ba6guR+xOi10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uqvGxqB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37668C4CEEA;
	Sun, 25 May 2025 12:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748176577;
	bh=pGgJHNlURj68Nf871LYJtmhvzZHpDyuhKS2sIiG3AH4=;
	h=Subject:To:Cc:From:Date:From;
	b=uqvGxqB/LD01LAl5RYHxS/i2GRX+uYrNtt+M0KRiNx3LCtpL2P+qreXLA8sa/RKZN
	 x9KEO7NCtYzbzcePyVG2mUSTiXSZBZKWSzBEm3ZskK3i99Qh366Pua84275bK7uxG4
	 jmiZjt2Ncw3bXWgIEtc30nd8Af6mdM4hRO1uOdN8=
Subject: FAILED: patch "[PATCH] mmc: sdhci-of-dwcmshc: add PD workaround on RK3576" failed to apply to 6.14-stable tree
To: nicolas.frattaroli@collabora.com,adrian.hunter@intel.com,shawn.lin@rock-chips.com,stable@vger.kernel.org,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 25 May 2025 14:34:16 +0200
Message-ID: <2025052516-factsheet-coagulant-3fb0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x 08f959759e1e6e9c4b898c51a7d387ac3480630b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052516-factsheet-coagulant-3fb0@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 08f959759e1e6e9c4b898c51a7d387ac3480630b Mon Sep 17 00:00:00 2001
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 23 Apr 2025 09:53:32 +0200
Subject: [PATCH] mmc: sdhci-of-dwcmshc: add PD workaround on RK3576

RK3576's power domains have a peculiar design where the PD_NVM power
domain, of which the sdhci controller is a part, seemingly does not have
idempotent runtime disable/enable. The end effect is that if PD_NVM gets
turned off by the generic power domain logic because all the devices
depending on it are suspended, then the next time the sdhci device is
unsuspended, it'll hang the SoC as soon as it tries accessing the CQHCI
registers.

RK3576's UFS support needed a new dev_pm_genpd_rpm_always_on function
added to the generic power domains API to handle what appears to be a
similar hardware design.

Use this new function to ask for the same treatment in the sdhci
controller by giving rk3576 its own platform data with its own postinit
function. The benefit of doing this instead of marking the power domains
always on in the power domain core is that we only do this if we know
the platform we're running on actually uses the sdhci controller. For
others, keeping PD_NVM always on would be a waste, as they won't run
into this specific issue. The only other IP in PD_NVM that could be
affected is FSPI0. If it gets a mainline driver, it will probably want
to do the same thing.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Fixes: cfee1b507758 ("pmdomain: rockchip: Add support for RK3576 SoC")
Cc: <stable@vger.kernel.org> # v6.15+
Link: https://lore.kernel.org/r/20250423-rk3576-emmc-fix-v3-1-0bf80e29967f@collabora.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 09b9ab15e499..a20d03fdd6a9 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
@@ -745,6 +746,29 @@ static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv
 	}
 }
 
+static void dwcmshc_rk3576_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	int ret;
+
+	/*
+	 * This works around the design of the RK3576's power domains, which
+	 * makes the PD_NVM power domain, which the sdhci controller on the
+	 * RK3576 is in, never come back the same way once it's run-time
+	 * suspended once. This can happen during early kernel boot if no driver
+	 * is using either PD_NVM or its child power domain PD_SDGMAC for a
+	 * short moment, leading to it being turned off to save power. By
+	 * keeping it on, sdhci suspending won't lead to PD_NVM becoming a
+	 * candidate for getting turned off.
+	 */
+	ret = dev_pm_genpd_rpm_always_on(dev, true);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_warn(dev, "failed to set PD rpm always on, SoC may hang later: %pe\n",
+			 ERR_PTR(ret));
+
+	dwcmshc_rk35xx_postinit(host, dwc_priv);
+}
+
 static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1176,6 +1200,18 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
 	.postinit = dwcmshc_rk35xx_postinit,
 };
 
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
+	.pdata = {
+		.ops = &sdhci_dwcmshc_rk35xx_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+	},
+	.init = dwcmshc_rk35xx_init,
+	.postinit = dwcmshc_rk3576_postinit,
+};
+
 static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
 	.pdata = {
 		.ops = &sdhci_dwcmshc_th1520_ops,
@@ -1274,6 +1310,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 		.compatible = "rockchip,rk3588-dwcmshc",
 		.data = &sdhci_dwcmshc_rk35xx_pdata,
 	},
+	{
+		.compatible = "rockchip,rk3576-dwcmshc",
+		.data = &sdhci_dwcmshc_rk3576_pdata,
+	},
 	{
 		.compatible = "rockchip,rk3568-dwcmshc",
 		.data = &sdhci_dwcmshc_rk35xx_pdata,


