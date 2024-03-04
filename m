Return-Path: <stable+bounces-25832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111F786FA8A
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 08:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C62B209B1
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 07:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11CD12E4F;
	Mon,  4 Mar 2024 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o2HWOS0/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156C13FE2
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536452; cv=none; b=rd24RZBr9JGC5+JJj4C0nhRURRqoYvmxXn+6aoekA9CuUoIHlk1ey0F1SC5aKHWZhneNmsZx5zmEHSQ6IN2OR1bPW3+M35hua+CEe2WdfT8iFLT741YJV0KDSwRTzvsqO9Z3nqIRD7HZdmFN0bBFnogg2aZr4IDV1CW8MnPffyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536452; c=relaxed/simple;
	bh=KZv4AW1xZOwLLv/MCGpttf/O8nf1hLD0Eh8aMnFIZ3A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FO9JhAQb7zqqSuEYnqLRjrvvJsGwCA2Amo4EyENr1piW5O4m5jfTZIT/MAOr1TxdkuQ1vF+p2Z38N7uLIEwRCNWCxfM/zMW13NgcPbKpq9ZIUeKY+itF88H4JsUlCm6u6nYvMQxyBQGb9El3UXFzfd4uOHKJqz3eFT8BCKoz9F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o2HWOS0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7775EC433F1;
	Mon,  4 Mar 2024 07:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709536451;
	bh=KZv4AW1xZOwLLv/MCGpttf/O8nf1hLD0Eh8aMnFIZ3A=;
	h=Subject:To:Cc:From:Date:From;
	b=o2HWOS0/PF896X2F8jYuxFV38IaeqzItHs4YFM6z4NrQjtUmj5Y4ZcWpdkLOjRuow
	 ZINABtMWM07uds5CK2IJmoJfgAGVD6ACt3XEVBa8cFNozi/cWPhBLnWMAiMh08eboi
	 4ITITkrEMMJtxxEWVG1teEEMTxLnxSS7vo3YzKvs=
Subject: FAILED: patch "[PATCH] mmc: sdhci-xenon: add timeout for PHY init complete" failed to apply to 4.19-stable tree
To: enachman@marvell.com,adrian.hunter@intel.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 08:14:08 +0100
Message-ID: <2024030408-hyphen-moonwalk-5e0e@gregkh>
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
git cherry-pick -x 09e23823ae9a3e2d5d20f2e1efe0d6e48cef9129
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030408-hyphen-moonwalk-5e0e@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

09e23823ae9a ("mmc: sdhci-xenon: add timeout for PHY init complete")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 09e23823ae9a3e2d5d20f2e1efe0d6e48cef9129 Mon Sep 17 00:00:00 2001
From: Elad Nachman <enachman@marvell.com>
Date: Thu, 22 Feb 2024 21:17:14 +0200
Subject: [PATCH] mmc: sdhci-xenon: add timeout for PHY init complete

AC5X spec says PHY init complete bit must be polled until zero.
We see cases in which timeout can take longer than the standard
calculation on AC5X, which is expected following the spec comment above.
According to the spec, we must wait as long as it takes for that bit to
toggle on AC5X.
Cap that with 100 delay loops so we won't get stuck forever.

Fixes: 06c8b667ff5b ("mmc: sdhci-xenon: Add support to PHYs of Marvell Xenon SDHC")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Elad Nachman <enachman@marvell.com>
Link: https://lore.kernel.org/r/20240222191714.1216470-3-enachman@marvell.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index c3096230a969..cc9d28b75eb9 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -110,6 +110,8 @@
 #define XENON_EMMC_PHY_LOGIC_TIMING_ADJUST	(XENON_EMMC_PHY_REG_BASE + 0x18)
 #define XENON_LOGIC_TIMING_VALUE		0x00AA8977
 
+#define XENON_MAX_PHY_TIMEOUT_LOOPS		100
+
 /*
  * List offset of PHY registers and some special register values
  * in eMMC PHY 5.0 or eMMC PHY 5.1
@@ -278,18 +280,27 @@ static int xenon_emmc_phy_init(struct sdhci_host *host)
 	/* get the wait time */
 	wait /= clock;
 	wait++;
-	/* wait for host eMMC PHY init completes */
-	udelay(wait);
 
-	reg = sdhci_readl(host, phy_regs->timing_adj);
-	reg &= XENON_PHY_INITIALIZAION;
-	if (reg) {
+	/*
+	 * AC5X spec says bit must be polled until zero.
+	 * We see cases in which timeout can take longer
+	 * than the standard calculation on AC5X, which is
+	 * expected following the spec comment above.
+	 * According to the spec, we must wait as long as
+	 * it takes for that bit to toggle on AC5X.
+	 * Cap that with 100 delay loops so we won't get
+	 * stuck here forever:
+	 */
+
+	ret = read_poll_timeout(sdhci_readl, reg,
+				!(reg & XENON_PHY_INITIALIZAION),
+				wait, XENON_MAX_PHY_TIMEOUT_LOOPS * wait,
+				false, host, phy_regs->timing_adj);
+	if (ret)
 		dev_err(mmc_dev(host->mmc), "eMMC PHY init cannot complete after %d us\n",
-			wait);
-		return -ETIMEDOUT;
-	}
+			wait * XENON_MAX_PHY_TIMEOUT_LOOPS);
 
-	return 0;
+	return ret;
 }
 
 #define ARMADA_3700_SOC_PAD_1_8V	0x1


