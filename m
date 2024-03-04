Return-Path: <stable+bounces-25835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4787386FA90
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 08:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFE11F2110A
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 07:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F18012E73;
	Mon,  4 Mar 2024 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Da6zBkhd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1178A53A6
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536513; cv=none; b=Pe/F8BX4ZsIw1qfARFnBmW++ThJEtPFeZIfeOHhPU2dWmo6zRZeOj2rhy8Typky7ZlNQp2FpYjTBm6Dmpy672uDC4v6xQm2Yw8dyQNMV44Dqhox8zOlId9K63HtGXMJBEmODYgbt/GJbE+8LhT9UDs2L/9exffZq2T92VwjY540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536513; c=relaxed/simple;
	bh=uk2OgCGlahI9DRHckn0qjtl/U1jX+Z9HKaYgNK9rWNo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W1J1f+hYtT9S/72GawW9LxOuZb9ULYuM9as4Ye8ZoucJeas68zDKNVG5a/KB0D7/u0DUAd1JE6Ax0JhywTvgC4jwPwf9aJqQYDkWa4MXYfqjHNY4kKZhT8EdTtbCO5JqlYUNq3JhCbRPnHGZ8vr1x78g1ZmCivvEdDDO2SYm6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Da6zBkhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D745C433F1;
	Mon,  4 Mar 2024 07:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709536512;
	bh=uk2OgCGlahI9DRHckn0qjtl/U1jX+Z9HKaYgNK9rWNo=;
	h=Subject:To:Cc:From:Date:From;
	b=Da6zBkhd400OsVnzkGTXkrbNOTAQ6zlI2NOwC5Oyly77vhszaf5Thvm3XbRx4JGzC
	 uO9hrw9thQ+GGSz5HbQPnHoOTD2s6AcjtWy1Ixf2a3TdizBH/BA/GJx5vTyFyD83yq
	 mup9Fhw53yqtPoyvof0CjbnZBZuO1aWi2/N27maA=
Subject: FAILED: patch "[PATCH] mmc: sdhci-xenon: fix PHY init clock stability" failed to apply to 4.19-stable tree
To: enachman@marvell.com,adrian.hunter@intel.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 08:15:01 +0100
Message-ID: <2024030401-cushy-sterility-1d74@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 8e9f25a290ae0016353c9ea13314c95fb3207812
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030401-cushy-sterility-1d74@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


