Return-Path: <stable+bounces-232685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v5cjIsCbzGntUQYAu9opvQ
	(envelope-from <stable+bounces-232685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 06:14:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A7737497C
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 06:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B17813029FF1
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 04:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20108363C7C;
	Wed,  1 Apr 2026 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="dQaI+ftg"
X-Original-To: Stable@vger.kernel.org
Received: from mail-m19731102.qiye.163.com (mail-m19731102.qiye.163.com [220.197.31.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C6518859B;
	Wed,  1 Apr 2026 04:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775016892; cv=none; b=qkzD8pgW7xVQsrzZCOPdnxTN4tFN8eHcmg6D0ktYmREF/ln/o62weUzacoHe7ZL9bMLaxvvvGxlznFSzzgppNBqE9Eaw3i5Yah/d44jr2cjRMuhnc9r5vnwZL3xqlybPwt2K1CR0verk1TUJcXNz2wNinuzG9CKzChsmtWP+yWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775016892; c=relaxed/simple;
	bh=YTfTTHtSG1X1IpecAI50O2D5rbXS9XkRphm9GjFATWY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=s55h52rDfBqozkMFy8awhxFZFzycobgjrwyh7EDuiHbRq7F67F5ywahGqs11OpY0mmmdA9ttmBMNM7j8pRnzY95MYeMvRmtVWovwTV2nZrhdFqPcV0MgGULwNFHINjPAsUvX4SA1R2c4pD3ksBhrydOITrH9kKh+w7xASLQkWqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=dQaI+ftg; arc=none smtp.client-ip=220.197.31.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 39161e4ac;
	Wed, 1 Apr 2026 11:39:19 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-of-dwcmshc: Disable clock before DLL configuration
Date: Wed,  1 Apr 2026 11:39:02 +0800
Message-Id: <1775014742-233407-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9d471fc9a809cckunm8e6c8db9f9ecc3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0ofH1YZTEsaSUhMSUtNGEpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dQaI+ftgg1eYWObfz6PRRtDPMhRS58iTrkgwWKukB4yolJqAwd/RKQgiayyTKD8G2ukxfJfDlAsp7zfNDAavmwok8+XvckCKcKNnIzsb8F8roKKhaMJM12pUWmacpyWXYWg6b6OVt3tSLyhghlqk04wpec0mqbwG1FPE+oRtnfY=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=6QJPJMz3AqhAVdrPV8Pt/icupjEt5XdhBpOtcqOFyFg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232685-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2A7737497C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to the ASIC design recommendations, the clock must be
disabled before operating the DLL to prevent glitches that could
affect the internal digital logic. In extreme cases, failing to
do so may cause the controller to malfunction completely.

Adds a step to disable the clock before DLL configuration and
re-enables it at the end.

Fixes: 08f3dff799d4 ("mmc: sdhci-of-dwcmshc: add rockchip platform support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
This is bascially a code sync with the downstream vendor kernel which was been
done this way and tested for some years to confirm it could fix the issues in
all corner cases.

 drivers/mmc/host/sdhci-of-dwcmshc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 6139516..e3ae334 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -783,12 +783,15 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 	extra |= BIT(4);
 	sdhci_writel(host, extra, reg);
 
+	/* Disable clock while config DLL */
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+
 	if (clock <= 52000000) {
 		if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
 		    host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
 			dev_err(mmc_dev(host->mmc),
 				"Can't reduce the clock below 52MHz in HS200/HS400 mode");
-			return;
+			goto enable_clk;
 		}
 
 		/*
@@ -808,7 +811,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 			DLL_STRBIN_DELAY_NUM_SEL |
 			DLL_STRBIN_DELAY_NUM_DEFAULT << DLL_STRBIN_DELAY_NUM_OFFSET;
 		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
-		return;
+		goto enable_clk;
 	}
 
 	/* Reset DLL */
@@ -835,7 +838,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 				 500 * USEC_PER_MSEC);
 	if (err) {
 		dev_err(mmc_dev(host->mmc), "DLL lock timeout!\n");
-		return;
+		goto enable_clk;
 	}
 
 	extra = 0x1 << 16 | /* tune clock stop en */
@@ -868,6 +871,9 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 		DLL_STRBIN_TAPNUM_DEFAULT |
 		DLL_STRBIN_TAPNUM_FROM_SW;
 	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
+
+enable_clk:
+	sdhci_enable_clk(host, 0);
 }
 
 static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
-- 
2.7.4


