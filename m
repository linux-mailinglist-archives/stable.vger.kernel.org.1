Return-Path: <stable+bounces-25834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179EC86FA8F
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 08:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A18283BF4
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 07:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4457612E73;
	Mon,  4 Mar 2024 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kzi1EgVR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609A53A6
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536504; cv=none; b=QjNMpuRFD9yXVjei6VTyZkt1+yqTY+b6vB6IyVIcd6+dfHgmfAeLczSufUt8hzU16u9bcGRgaZQrvS2tsNfCwYmn7LEJ1yTtYMX4jccPBB8W5jc/HzBQDb+13LFDRqkBX4lijbyqgZPbkzHf6+agK+zBo+jruL6iKe3AZWU0eT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536504; c=relaxed/simple;
	bh=O6W/yVcjp/YRV9u8khvm1ZwWoqQezxsW/rLvv0RSBvA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MTr+YAWuBbALeuRPF32GEAHjmqh/DHgKnuZ1ug1ywO2WzjgrryWg0p0XmmvHowyFOeNRRxEKUchFL12pSgY3lqYwjKdPNlzgBwa61BQ6qMAcXNiDFAA4ooduDPlcud5WZNDoLLDOvFyJT/olN+VRRkpqnzTm5VTcFlWDgblOvNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kzi1EgVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2400CC433F1;
	Mon,  4 Mar 2024 07:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709536503;
	bh=O6W/yVcjp/YRV9u8khvm1ZwWoqQezxsW/rLvv0RSBvA=;
	h=Subject:To:Cc:From:Date:From;
	b=kzi1EgVRzv5j7YDQJ22Gkzvh027Rqtkp6W2IavqrCGRsaMiPeQ92zLaf6kmeRMbgM
	 ejTFzpmGPnos91JWNM1V/Oa9sei7BwP9B0tZnD3zB5b1QVNbexUGm1Mk7Q+2C8+Hv7
	 cBlyaooZ7TON9v7HmXZMLUSAc+FDQyirVa5QSTYA=
Subject: FAILED: patch "[PATCH] mmc: sdhci-xenon: fix PHY init clock stability" failed to apply to 5.4-stable tree
To: enachman@marvell.com,adrian.hunter@intel.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 08:15:00 +0100
Message-ID: <2024030400-debate-conclude-99e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8e9f25a290ae0016353c9ea13314c95fb3207812
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030400-debate-conclude-99e5@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

8e9f25a290ae ("mmc: sdhci-xenon: fix PHY init clock stability")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e9f25a290ae0016353c9ea13314c95fb3207812 Mon Sep 17 00:00:00 2001
From: Elad Nachman <enachman@marvell.com>
Date: Thu, 22 Feb 2024 22:09:30 +0200
Subject: [PATCH] mmc: sdhci-xenon: fix PHY init clock stability

Each time SD/mmc phy is initialized, at times, in some of
the attempts, phy fails to completes its initialization
which results into timeout error. Per the HW spec, it is
a pre-requisite to ensure a stable SD clock before a phy
initialization is attempted.

Fixes: 06c8b667ff5b ("mmc: sdhci-xenon: Add support to PHYs of Marvell Xenon SDHC")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Elad Nachman <enachman@marvell.com>
Link: https://lore.kernel.org/r/20240222200930.1277665-1-enachman@marvell.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index 8cf3a375de65..c3096230a969 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
+#include <linux/iopoll.h>
 #include <linux/of_address.h>
 
 #include "sdhci-pltfm.h"
@@ -216,6 +217,19 @@ static int xenon_alloc_emmc_phy(struct sdhci_host *host)
 	return 0;
 }
 
+static int xenon_check_stability_internal_clk(struct sdhci_host *host)
+{
+	u32 reg;
+	int err;
+
+	err = read_poll_timeout(sdhci_readw, reg, reg & SDHCI_CLOCK_INT_STABLE,
+				1100, 20000, false, host, SDHCI_CLOCK_CONTROL);
+	if (err)
+		dev_err(mmc_dev(host->mmc), "phy_init: Internal clock never stabilized.\n");
+
+	return err;
+}
+
 /*
  * eMMC 5.0/5.1 PHY init/re-init.
  * eMMC PHY init should be executed after:
@@ -232,6 +246,11 @@ static int xenon_emmc_phy_init(struct sdhci_host *host)
 	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	struct xenon_emmc_phy_regs *phy_regs = priv->emmc_phy_regs;
 
+	int ret = xenon_check_stability_internal_clk(host);
+
+	if (ret)
+		return ret;
+
 	reg = sdhci_readl(host, phy_regs->timing_adj);
 	reg |= XENON_PHY_INITIALIZAION;
 	sdhci_writel(host, reg, phy_regs->timing_adj);


