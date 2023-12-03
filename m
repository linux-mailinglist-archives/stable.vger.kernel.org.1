Return-Path: <stable+bounces-3769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7B180243A
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407FD1C20901
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D18EF9C4;
	Sun,  3 Dec 2023 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u0fMuL21"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B019C2EE
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEB4C433C8;
	Sun,  3 Dec 2023 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701610289;
	bh=Uln+sFK2Vmt7l/R5coXVbMWIwHOiW1tVtbHuIWI4KgY=;
	h=Subject:To:Cc:From:Date:From;
	b=u0fMuL2189/VBdZsWeCTG0AiZAYP69DQMPk7WeNw1sPFtEcSDG99tn7n1ihj/U/X/
	 9xFPqEg8RuzWnv9CfZyjRtRm274ENDa9Xs6M643P400lWCKCN9R+K/JNfuiy8JUmKr
	 2jUUIS/H9Q/6jCqYBwX1iITrD+YDkQ7QhVzZNRe4=
Subject: FAILED: patch "[PATCH] mmc: sdhci-sprd: Fix vqmmc not shutting down after the card" failed to apply to 5.10-stable tree
To: wenchao.chen@unisoc.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:31:11 +0100
Message-ID: <2023120311-backlands-resupply-6887@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 477865af60b2117ceaa1d558e03559108c15c78c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120311-backlands-resupply-6887@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

477865af60b2 ("mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 477865af60b2117ceaa1d558e03559108c15c78c Mon Sep 17 00:00:00 2001
From: Wenchao Chen <wenchao.chen@unisoc.com>
Date: Wed, 15 Nov 2023 16:34:06 +0800
Subject: [PATCH] mmc: sdhci-sprd: Fix vqmmc not shutting down after the card
 was pulled

With cat regulator_summary, we found that vqmmc was not shutting
down after the card was pulled.

cat /sys/kernel/debug/regulator/regulator_summary
1.before fix
1)Insert SD card
 vddsdio		1    1  0 unknown  3500mV 0mA  1200mV  3750mV
    71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV

2)Pull out the SD card
 vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
    71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV

2.after fix
1)Insert SD cardt
 vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
    71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV

2)Pull out the SD card
 vddsdio		0    1  0 unknown  3500mV 0mA  1200mV  3750mV
    71100000.mmc-vqmmc  0                         0mA  3500mV  3600mV

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231115083406.7368-1-wenchao.chen@unisoc.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 6b84ba27e6ab..6b8a57e2d20f 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -416,12 +416,33 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
 	mmc_request_done(host->mmc, mrq);
 }
 
+static void sdhci_sprd_set_power(struct sdhci_host *host, unsigned char mode,
+				 unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	switch (mode) {
+	case MMC_POWER_OFF:
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, 0);
+
+		mmc_regulator_disable_vqmmc(mmc);
+		break;
+	case MMC_POWER_ON:
+		mmc_regulator_enable_vqmmc(mmc);
+		break;
+	case MMC_POWER_UP:
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, vdd);
+		break;
+	}
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
 	.write_w = sdhci_sprd_writew,
 	.write_b = sdhci_sprd_writeb,
 	.set_clock = sdhci_sprd_set_clock,
+	.set_power = sdhci_sprd_set_power,
 	.get_max_clock = sdhci_sprd_get_max_clock,
 	.get_min_clock = sdhci_sprd_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -823,6 +844,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
 			 SDHCI_SUPPORT_DDR50);
 
+	ret = mmc_regulator_get_supply(host->mmc);
+	if (ret)
+		goto pm_runtime_disable;
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto pm_runtime_disable;


