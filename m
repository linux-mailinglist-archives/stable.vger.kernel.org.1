Return-Path: <stable+bounces-5990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0973680D833
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0601C20E06
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D6E5102A;
	Mon, 11 Dec 2023 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vfhQlr0N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45358FC06;
	Mon, 11 Dec 2023 18:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EB1C433C7;
	Mon, 11 Dec 2023 18:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320215;
	bh=/JqbYiDjLseGfg1KTC+P94yM0iBDIcipqRmszV1RoGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vfhQlr0NNAI8VOi11oLgDYTzf126xuU26FEBcinTIaBNKQUJFVU8ZkeOcxYpPGyKt
	 lCcmJcHeP2Q8CdtqhpTvrXLoGr6m3KGTteFsqL35DW0L6qMvpfY2ZvRzsaNWFfmhM4
	 mxn1QZ943HxhbaNjSk8OwwFmi2/8CUXkf83/5a/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 46/67] mmc: core: add helpers mmc_regulator_enable/disable_vqmmc
Date: Mon, 11 Dec 2023 19:22:30 +0100
Message-ID: <20231211182016.997947731@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
References: <20231211182015.049134368@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 8d91f3f8ae57e6292142ca89f322e90fa0d6ac02 ]

There's a number of drivers (e.g. dw_mmc, meson-gx, mmci, sunxi) using
the same mechanism and a private flag vqmmc_enabled to deal with
enabling/disabling the vqmmc regulator.

Move this to the core and create new helpers mmc_regulator_enable_vqmmc
and mmc_regulator_disable_vqmmc.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://lore.kernel.org/r/71586432-360f-9b92-17f6-b05a8a971bc2@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: 477865af60b2 ("mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/regulator.c | 41 ++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     |  3 +++
 2 files changed, 44 insertions(+)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index b6febbcf8978d..327032cbbb1f8 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -258,3 +258,44 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
+
+/**
+ * mmc_regulator_enable_vqmmc - enable VQMMC regulator for a host
+ * @mmc: the host to regulate
+ *
+ * Returns 0 or errno. Enables the regulator for vqmmc.
+ * Keeps track of the enable status for ensuring that calls to
+ * regulator_enable/disable are balanced.
+ */
+int mmc_regulator_enable_vqmmc(struct mmc_host *mmc)
+{
+	int ret = 0;
+
+	if (!IS_ERR(mmc->supply.vqmmc) && !mmc->vqmmc_enabled) {
+		ret = regulator_enable(mmc->supply.vqmmc);
+		if (ret < 0)
+			dev_err(mmc_dev(mmc), "enabling vqmmc regulator failed\n");
+		else
+			mmc->vqmmc_enabled = true;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_enable_vqmmc);
+
+/**
+ * mmc_regulator_disable_vqmmc - disable VQMMC regulator for a host
+ * @mmc: the host to regulate
+ *
+ * Returns 0 or errno. Disables the regulator for vqmmc.
+ * Keeps track of the enable status for ensuring that calls to
+ * regulator_enable/disable are balanced.
+ */
+void mmc_regulator_disable_vqmmc(struct mmc_host *mmc)
+{
+	if (!IS_ERR(mmc->supply.vqmmc) && mmc->vqmmc_enabled) {
+		regulator_disable(mmc->supply.vqmmc);
+		mmc->vqmmc_enabled = false;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_disable_vqmmc);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index a0e1cf1bef4e5..68880c2b4fe07 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -397,6 +397,7 @@ struct mmc_host {
 	unsigned int		use_blk_mq:1;	/* use blk-mq */
 	unsigned int		retune_crc_disable:1; /* don't trigger retune upon crc */
 	unsigned int		can_dma_map_merge:1; /* merging can be used */
+	unsigned int		vqmmc_enabled:1; /* vqmmc regulator is enabled */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
@@ -534,6 +535,8 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
 #endif
 
 int mmc_regulator_get_supply(struct mmc_host *mmc);
+int mmc_regulator_enable_vqmmc(struct mmc_host *mmc);
+void mmc_regulator_disable_vqmmc(struct mmc_host *mmc);
 
 static inline int mmc_card_is_removable(struct mmc_host *host)
 {
-- 
2.42.0




