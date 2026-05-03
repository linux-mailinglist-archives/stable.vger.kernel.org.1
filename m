Return-Path: <stable+bounces-242664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIKFFAg192nQdQIAu9opvQ
	(envelope-from <stable+bounces-242664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:44:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B979D4B554A
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DEB53006F3C
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 11:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2E43126C0;
	Sun,  3 May 2026 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TRT6r6KK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B068840DFA3
	for <stable@vger.kernel.org>; Sun,  3 May 2026 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777808643; cv=none; b=A3QWJ5TbTuSJk+mGP8ospboDXdPle/fcVZkURguKXgNY7ZGCQE0AyBb+/iHdaswOMA+ZX6SAtGbsWAt8mvOUpz0Vy9iswftEjdRb26zFfGJajyQBEphNbOPoyf3ClsNqMzrkeUzq2ABZPrRXOd41LYn7ZMLRy9zZ6uL/D0Ge2Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777808643; c=relaxed/simple;
	bh=/En+DjwZENBnejKp/p+j7MbjwJY+YfG5gpKVaBvIaag=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t3L3gIfySrdrqfXS2fvtHVzdX7FO1+OFDJHZqayBa9L2h+1IAzzOw2n5m5ErM0iJQoX+bQZ1xf3+it+Ot/AG8Q+sxGVpyz3cYj/joqST/FssBJ4SsAARFubLuFezVfiYMP1Mb5vxYL8ulfhwBIWkTPrJp6hMspiVtxOFs0Tc/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TRT6r6KK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBC0C2BCB4;
	Sun,  3 May 2026 11:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777808643;
	bh=/En+DjwZENBnejKp/p+j7MbjwJY+YfG5gpKVaBvIaag=;
	h=Subject:To:Cc:From:Date:From;
	b=TRT6r6KKUdNwHyWXb2F0/5jkIyukpBkHrZVYujh7eoF0USJ3Nj1MVJKa6cVspFK9Q
	 yACXmnrR8aLcQLLeAcV+K/89/JJHaXbrj0F9k36lKaZllNTHbmEqn7LbYJIonjHH4P
	 TSV8sbNyuGXduOwigJARTKhbW6NCX5FHZrNaobjI=
Subject: FAILED: patch "[PATCH] mmc: sdhci-of-dwcmshc: Disable clock before DLL configuration" failed to apply to 5.15-stable tree
To: shawn.lin@rock-chips.com,adrian.hunter@intel.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 13:44:01 +0200
Message-ID: <2026050301-robe-placate-cf0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B979D4B554A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242664-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linaro.org:email,gregkh:email,intel.com:email]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6546a49bbe656981d99a389195560999058c89c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050301-robe-placate-cf0b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6546a49bbe656981d99a389195560999058c89c4 Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin@rock-chips.com>
Date: Wed, 8 Apr 2026 15:18:49 +0800
Subject: [PATCH] mmc: sdhci-of-dwcmshc: Disable clock before DLL configuration

According to the ASIC design recommendations, the clock must be
disabled before operating the DLL to prevent glitches that could
affect the internal digital logic. In extreme cases, failing to
do so may cause the controller to malfunction completely.

Adds a step to disable the clock before DLL configuration and
re-enables it at the end.

Fixes: 08f3dff799d4 ("mmc: sdhci-of-dwcmshc: add rockchip platform support")
Cc: stable@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 6139516c6488..0b2158a7e409 100644
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
@@ -868,6 +871,16 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 		DLL_STRBIN_TAPNUM_DEFAULT |
 		DLL_STRBIN_TAPNUM_FROM_SW;
 	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
+
+enable_clk:
+	/*
+	 * The sdclk frequency select bits in SDHCI_CLOCK_CONTROL are not functional
+	 * on Rockchip's SDHCI implementation. Instead, the clock frequency is fully
+	 * controlled via external clk provider by calling clk_set_rate(). Consequently,
+	 * passing 0 to sdhci_enable_clk() only re-enables the already-configured clock,
+	 * which matches the hardware's actual behavior.
+	 */
+	sdhci_enable_clk(host, 0);
 }
 
 static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)


