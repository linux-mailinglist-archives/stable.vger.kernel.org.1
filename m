Return-Path: <stable+bounces-91742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB67F9BFBCE
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 02:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7493DB2184E
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 01:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768B211712;
	Thu,  7 Nov 2024 01:43:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D104EF9D6;
	Thu,  7 Nov 2024 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943785; cv=none; b=LkPh70si5Nvy9cOAKrB2HEnbbs8k/0XWCtjs0hTRtG95/fKQ3GM670Ocp6Lp3ko0ACXhUs2VtZTqc6S0Lrdn37a21Ccgg0Z0WVGcyQ50n6L8Nh3qqe5XjfCj1CnK8rndOGYBOM/GpISC9kN/+6qLuEa9mlaiCH/6gkx58PhjETw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943785; c=relaxed/simple;
	bh=bDlEMe4p+Ix+XDJgWpZjIDVzNG8F46fsApthqT/VKs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lO2pZlKwwRSVRibyGKxRc7ieTs+EbllLImSM5oSzRwHbsh1cTzW4ZvMeUzDbrOGkblYwM6lXLRZj2TtgUJT/mVe7LSwgGYId9D7XMMkvOnAYfelkKeqjo0zrsij2iPqXWfBESZGJ2jDyUzYutwVTNNpF8YsZL4FEKqBXbdRtpjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C236F497;
	Wed,  6 Nov 2024 17:43:31 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A7F83F66E;
	Wed,  6 Nov 2024 17:43:00 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Yangtao Li <tiny.windzz@gmail.com>,
	Cody Eksal <masterr3c0rd@epochal.quest>,
	Parthiban <parthiban@linumiz.com>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: sunxi-mmc: Fix A100 compatible description
Date: Thu,  7 Nov 2024 01:42:40 +0000
Message-ID: <20241107014240.24669-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It turns out that the Allwinner A100/A133 SoC only supports 8K DMA
blocks (13 bits wide), for both the SD/SDIO and eMMC instances.
And while this alone would make a trivial fix, the H616 falls back to
the A100 compatible string, so we have to now match the H616 compatible
string explicitly against the description advertising 64K DMA blocks.

As the A100 is now compatible with the D1 description, let the A100
compatible string point to that block instead, and introduce an explicit
match against the H616 string, pointing to the old description.
Also remove the redundant setting of clk_delays to NULL on the way.

Fixes: 3536b82e5853 ("mmc: sunxi: add support for A100 mmc controller")
Cc: stable@vger.kernel.org
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mmc/host/sunxi-mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index d3bd0ac99ec46..e0ab5fd635e6c 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1191,10 +1191,9 @@ static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
 	.needs_new_timings = true,
 };
 
-static const struct sunxi_mmc_cfg sun50i_a100_cfg = {
+static const struct sunxi_mmc_cfg sun50i_h616_cfg = {
 	.idma_des_size_bits = 16,
 	.idma_des_shift = 2,
-	.clk_delays = NULL,
 	.can_calibrate = true,
 	.mask_data0 = true,
 	.needs_new_timings = true,
@@ -1217,8 +1216,9 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun20i-d1-mmc", .data = &sun20i_d1_cfg },
 	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
-	{ .compatible = "allwinner,sun50i-a100-mmc", .data = &sun50i_a100_cfg },
+	{ .compatible = "allwinner,sun50i-a100-mmc", .data = &sun20i_d1_cfg },
 	{ .compatible = "allwinner,sun50i-a100-emmc", .data = &sun50i_a100_emmc_cfg },
+	{ .compatible = "allwinner,sun50i-h616-mmc", .data = &sun50i_h616_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
-- 
2.46.2


