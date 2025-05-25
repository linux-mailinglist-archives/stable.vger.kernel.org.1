Return-Path: <stable+bounces-146305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16774AC349F
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 14:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939DF1892057
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 12:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A121E1DF254;
	Sun, 25 May 2025 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xohIoSca"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205B723741
	for <stable@vger.kernel.org>; Sun, 25 May 2025 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748176569; cv=none; b=WZ2R2SP+OmjeCQKdPjna4ryui+ePl3I30KYVLQyFJzCXQ8K1MYL/UYAzsMDBiJa54a/iJ4U5mXzVEMOcRvkz+TMjeCyqbAdinMajGdvPjvbZq/7E5IJhW+ZHfQet0gfoCAeHMJsdB+czAakP5QEl9FiwmD4wb7N9irWkPcsgR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748176569; c=relaxed/simple;
	bh=/lWOTGntgK5qHpYkNR+Qc16fJm6kwIBO/NIcBAaOGao=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IbJO+udMSfZ00iE2je0rznr1+fcX0/mOkS95Js2wXaY/cuZUlBje7EisWG/OdyCS5YZf88rbK1a2sGsSOn75BPnJJthqWIdY3VAyo2oPm/FqtkR9lDLnI8UJlDZYJDt/pdmJdNvck/Gv50seZOXx16GntoDbTOmGF2onVA8Ply8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xohIoSca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BF9C4CEEA;
	Sun, 25 May 2025 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748176568;
	bh=/lWOTGntgK5qHpYkNR+Qc16fJm6kwIBO/NIcBAaOGao=;
	h=Subject:To:Cc:From:Date:From;
	b=xohIoScaHBwldv9ofQVo+Kb0JtCzmogsThfzNWh1ZCLBxmqdLJSbsX8sNHfMcGFXH
	 JU/Yd9zlgYWoUC/1rEJrhIZ36CU+4jKmCj7FGrvlS1FyB+sOjApw2H3hpJlLgIThz9
	 mC4HpQzz4CG8WlKH/OAWtJ5/WN3QSSHYrK/WHF4s=
Subject: FAILED: patch "[PATCH] mmc: sdhci-of-dwcmshc: add PD workaround on RK3576" failed to apply to 6.12-stable tree
To: nicolas.frattaroli@collabora.com,adrian.hunter@intel.com,shawn.lin@rock-chips.com,stable@vger.kernel.org,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 25 May 2025 14:34:15 +0200
Message-ID: <2025052515-headdress-overcome-c741@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 08f959759e1e6e9c4b898c51a7d387ac3480630b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052515-headdress-overcome-c741@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


