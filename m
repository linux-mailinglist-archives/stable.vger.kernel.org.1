Return-Path: <stable+bounces-118177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6BBA3BA2D
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B0F1886F3C
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212801DF26F;
	Wed, 19 Feb 2025 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L/879mI2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C061B1E105E;
	Wed, 19 Feb 2025 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957456; cv=none; b=lt4B42SBxbXUUNO2YkF+cFujQ1uxXXWRbAJJXp+o1BpCQWYpX5rAJlNmT7QCLU9jwqABrivOw/MSIRfrdrUBc5/KCJveG+sliNOBAAY46iIlCmDtqh38J2MV9zc2OArMaDwQk8pKFLIAlkfRaGr8OzeC3IlX3fYKcZvwQLN+aPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957456; c=relaxed/simple;
	bh=rh3xowcIWDb8NbQZfAtRT4TV38t7wS1p1BZaurH1Tio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKlff97jHHwwQpDytHyOJ+cQnOpiBBnkUpyDE8y2A3VC4MhYFXylkAaeFxSSAlQxAFoMYkMtVDtpoYWsVrfhteEsUMO5+yLaHVThaTTo0PWlZd8HL4ud08uUzU97mY7OJeb8aPsHeLIvTwOEl9d69AJ4XynxF6eSZHqXoxUTF/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L/879mI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44468C4CED1;
	Wed, 19 Feb 2025 09:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739957456;
	bh=rh3xowcIWDb8NbQZfAtRT4TV38t7wS1p1BZaurH1Tio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/879mI2xaYMFtxdRayPrjKXNFaiNxnHiEBwrCvyaIxqf+ZkMtaMyjl3GJMQ52b09
	 SUAUToQDKlrVAOVXU3I8UZbE8uOlSL+xVGtPJv9U6ZsR+aY6yGrP1cBaS0z+4fWLKv
	 7tKSMoHQTMbMimiXgStsoHSy22IYm0c2PKo7poec=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy-ld Lu <andy-ld.lu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.1 533/578] mmc: mtk-sd: Fix register settings for hs400(es) mode
Date: Wed, 19 Feb 2025 09:28:57 +0100
Message-ID: <20250219082713.944247639@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy-ld Lu <andy-ld.lu@mediatek.com>

commit 3e68abf2b9cebe76c6cd4b1aca8e95cd671035a3 upstream.

For hs400(es) mode, the 'hs400-ds-delay' is typically configured in the
dts. However, some projects may only define 'mediatek,hs400-ds-dly3',
which can lead to initialization failures in hs400es mode. CMD13 reported
response crc error in the mmc_switch_status() just after switching to
hs400es mode.

[    1.914038][   T82] mmc0: mmc_select_hs400es failed, error -84
[    1.914954][   T82] mmc0: error -84 whilst initialising MMC card

Currently, the hs400_ds_dly3 value is set within the tuning function. This
means that the PAD_DS_DLY3 field is not configured before tuning process,
which is the reason for the above-mentioned CMD13 response crc error.

Move the PAD_DS_DLY3 field configuration into msdc_prepare_hs400_tuning(),
and add a value check of hs400_ds_delay to prevent overwriting by zero when
the 'hs400-ds-delay' is not set in the dts. In addition, since hs400(es)
only tune the PAD_DS_DLY1, the PAD_DS_DLY2_SEL bit should be cleared to
bypass it.

Fixes: c4ac38c6539b ("mmc: mtk-sd: Add HS400 online tuning support")
Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250123092644.7359-1-andy-ld.lu@mediatek.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/mtk-sd.c |   31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -262,6 +262,7 @@
 #define MSDC_PAD_TUNE_CMD_SEL	  BIT(21)   /* RW */
 
 #define PAD_DS_TUNE_DLY_SEL       BIT(0)	  /* RW */
+#define PAD_DS_TUNE_DLY2_SEL      BIT(1)	  /* RW */
 #define PAD_DS_TUNE_DLY1	  GENMASK(6, 2)   /* RW */
 #define PAD_DS_TUNE_DLY2	  GENMASK(11, 7)  /* RW */
 #define PAD_DS_TUNE_DLY3	  GENMASK(16, 12) /* RW */
@@ -307,6 +308,7 @@
 
 /* EMMC50_PAD_DS_TUNE mask */
 #define PAD_DS_DLY_SEL		BIT(16)	/* RW */
+#define PAD_DS_DLY2_SEL		BIT(15)	/* RW */
 #define PAD_DS_DLY1		GENMASK(14, 10)	/* RW */
 #define PAD_DS_DLY3		GENMASK(4, 0)	/* RW */
 
@@ -2293,13 +2295,23 @@ tune_done:
 static int msdc_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct msdc_host *host = mmc_priv(mmc);
+
 	host->hs400_mode = true;
 
-	if (host->top_base)
-		writel(host->hs400_ds_delay,
-		       host->top_base + EMMC50_PAD_DS_TUNE);
-	else
-		writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
+	if (host->top_base) {
+		if (host->hs400_ds_dly3)
+			sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
+				      PAD_DS_DLY3, host->hs400_ds_dly3);
+		if (host->hs400_ds_delay)
+			writel(host->hs400_ds_delay,
+			       host->top_base + EMMC50_PAD_DS_TUNE);
+	} else {
+		if (host->hs400_ds_dly3)
+			sdr_set_field(host->base + PAD_DS_TUNE,
+				      PAD_DS_TUNE_DLY3, host->hs400_ds_dly3);
+		if (host->hs400_ds_delay)
+			writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
+	}
 	/* hs400 mode must set it to 0 */
 	sdr_clr_bits(host->base + MSDC_PATCH_BIT2, MSDC_PATCH_BIT2_CFGCRCSTS);
 	/* to improve read performance, set outstanding to 2 */
@@ -2319,14 +2331,11 @@ static int msdc_execute_hs400_tuning(str
 	if (host->top_base) {
 		sdr_set_bits(host->top_base + EMMC50_PAD_DS_TUNE,
 			     PAD_DS_DLY_SEL);
-		if (host->hs400_ds_dly3)
-			sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
-				      PAD_DS_DLY3, host->hs400_ds_dly3);
+		sdr_clr_bits(host->top_base + EMMC50_PAD_DS_TUNE,
+			     PAD_DS_DLY2_SEL);
 	} else {
 		sdr_set_bits(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY_SEL);
-		if (host->hs400_ds_dly3)
-			sdr_set_field(host->base + PAD_DS_TUNE,
-				      PAD_DS_TUNE_DLY3, host->hs400_ds_dly3);
+		sdr_clr_bits(host->base + PAD_DS_TUNE, PAD_DS_TUNE_DLY2_SEL);
 	}
 
 	host->hs400_tuning = true;



