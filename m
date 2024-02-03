Return-Path: <stable+bounces-18277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE82848216
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834071C240B2
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD9C45951;
	Sat,  3 Feb 2024 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bddec61X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A08918E27;
	Sat,  3 Feb 2024 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933680; cv=none; b=CyIHVWz/zSI3ihnp4sOB+HUOMa77o31vo6L1XcJYlN2LdU2okyv0o5cgRPkYSs+dO9uoSwdTArgLiS3la14VgqxqSqQdfxTO8S2DlBUauPtT1H6RPwe12YW5HRtviaB1ghvpAEMyRj+l93AnSpriXe2x0Gd60CDkPGDe1S85214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933680; c=relaxed/simple;
	bh=zACnemQZFeQmxmbW+caqtZZw7zgPfxKNXx6Awo/rUH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X49u4O7tkWhYuosc5xmi72zTrWm1VZ86NiV8DahRLFVeG7hVMcfCj4P0phulF1MAEzSJx0Y/QR4DpL04NNr3u4H5i0SpxRY8XhVIxMR2Bk1fHaFb+rb2oWCt533tIztwAVU4ruSqcqGeHxpjDNHeXu81c3MQX9nHNgBcPhsM0aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bddec61X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C902AC43394;
	Sat,  3 Feb 2024 04:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933679;
	bh=zACnemQZFeQmxmbW+caqtZZw7zgPfxKNXx6Awo/rUH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bddec61XD6tLqVpPbAWUG3fuZsISLfuQ9BMfnViM6siPKO3LDeuOFmB/CwDuXCJYk
	 GWs8eZ0BPu1vofLfuj+nYZBF8SEc70Ca/ImqsidP17vgwM7H6N/JLgw3Hud67wcWuN
	 V2qu36gj8Uv7T+SIoHd3/L4lc427G7cXofMNbXNM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Golle <daniel@makrotopia.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 273/322] net: phy: mediatek-ge-soc: sync driver with MediaTek SDK
Date: Fri,  2 Feb 2024 20:06:10 -0800
Message-ID: <20240203035407.926236150@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit ff63cc2e95065bea978d2db01f7e7356cca3d021 ]

Sync initialization and calibration routines with MediaTek's reference
driver. Improves compliance and resolves link stability issues with
CH340 IoT devices connected to MT798x built-in PHYs.

Fixes: 98c485eaf509 ("net: phy: add driver for MediaTek SoC built-in GE PHYs")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Link: https://lore.kernel.org/r/f2195279c234c0f618946424b8236026126bc595.1706071311.git.daniel@makrotopia.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mediatek-ge-soc.c | 147 ++++++++++++++++--------------
 1 file changed, 81 insertions(+), 66 deletions(-)

diff --git a/drivers/net/phy/mediatek-ge-soc.c b/drivers/net/phy/mediatek-ge-soc.c
index 8a20d9889f10..0f3a1538a8b8 100644
--- a/drivers/net/phy/mediatek-ge-soc.c
+++ b/drivers/net/phy/mediatek-ge-soc.c
@@ -489,7 +489,7 @@ static int tx_r50_fill_result(struct phy_device *phydev, u16 tx_r50_cal_val,
 	u16 reg, val;
 
 	if (phydev->drv->phy_id == MTK_GPHY_ID_MT7988)
-		bias = -2;
+		bias = -1;
 
 	val = clamp_val(bias + tx_r50_cal_val, 0, 63);
 
@@ -705,6 +705,11 @@ static int tx_vcm_cal_sw(struct phy_device *phydev, u8 rg_txreserve_x)
 static void mt798x_phy_common_finetune(struct phy_device *phydev)
 {
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
+	/* SlvDSPreadyTime = 24, MasDSPreadyTime = 24 */
+	__phy_write(phydev, 0x11, 0xc71);
+	__phy_write(phydev, 0x12, 0xc);
+	__phy_write(phydev, 0x10, 0x8fae);
+
 	/* EnabRandUpdTrig = 1 */
 	__phy_write(phydev, 0x11, 0x2f00);
 	__phy_write(phydev, 0x12, 0xe);
@@ -715,15 +720,56 @@ static void mt798x_phy_common_finetune(struct phy_device *phydev)
 	__phy_write(phydev, 0x12, 0x0);
 	__phy_write(phydev, 0x10, 0x83aa);
 
-	/* TrFreeze = 0 */
+	/* FfeUpdGainForce = 1(Enable), FfeUpdGainForceVal = 4 */
+	__phy_write(phydev, 0x11, 0x240);
+	__phy_write(phydev, 0x12, 0x0);
+	__phy_write(phydev, 0x10, 0x9680);
+
+	/* TrFreeze = 0 (mt7988 default) */
 	__phy_write(phydev, 0x11, 0x0);
 	__phy_write(phydev, 0x12, 0x0);
 	__phy_write(phydev, 0x10, 0x9686);
 
+	/* SSTrKp100 = 5 */
+	/* SSTrKf100 = 6 */
+	/* SSTrKp1000Mas = 5 */
+	/* SSTrKf1000Mas = 6 */
 	/* SSTrKp1000Slv = 5 */
+	/* SSTrKf1000Slv = 6 */
 	__phy_write(phydev, 0x11, 0xbaef);
 	__phy_write(phydev, 0x12, 0x2e);
 	__phy_write(phydev, 0x10, 0x968c);
+	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+}
+
+static void mt7981_phy_finetune(struct phy_device *phydev)
+{
+	u16 val[8] = { 0x01ce, 0x01c1,
+		       0x020f, 0x0202,
+		       0x03d0, 0x03c0,
+		       0x0013, 0x0005 };
+	int i, k;
+
+	/* 100M eye finetune:
+	 * Keep middle level of TX MLT3 shapper as default.
+	 * Only change TX MLT3 overshoot level here.
+	 */
+	for (k = 0, i = 1; i < 12; i++) {
+		if (i % 3 == 0)
+			continue;
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, i, val[k++]);
+	}
+
+	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
+	/* ResetSyncOffset = 6 */
+	__phy_write(phydev, 0x11, 0x600);
+	__phy_write(phydev, 0x12, 0x0);
+	__phy_write(phydev, 0x10, 0x8fc0);
+
+	/* VgaDecRate = 1 */
+	__phy_write(phydev, 0x11, 0x4c2a);
+	__phy_write(phydev, 0x12, 0x3e);
+	__phy_write(phydev, 0x10, 0x8fa4);
 
 	/* MrvlTrFix100Kp = 3, MrvlTrFix100Kf = 2,
 	 * MrvlTrFix1000Kp = 3, MrvlTrFix1000Kf = 2
@@ -738,7 +784,7 @@ static void mt798x_phy_common_finetune(struct phy_device *phydev)
 	__phy_write(phydev, 0x10, 0x8ec0);
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 
-	/* TR_OPEN_LOOP_EN = 1, lpf_x_average = 9*/
+	/* TR_OPEN_LOOP_EN = 1, lpf_x_average = 9 */
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DEV1E_REG234,
 		       MTK_PHY_TR_OPEN_LOOP_EN_MASK | MTK_PHY_LPF_X_AVERAGE_MASK,
 		       BIT(0) | FIELD_PREP(MTK_PHY_LPF_X_AVERAGE_MASK, 0x9));
@@ -771,48 +817,6 @@ static void mt798x_phy_common_finetune(struct phy_device *phydev)
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_LDO_OUTPUT_V, 0x2222);
 }
 
-static void mt7981_phy_finetune(struct phy_device *phydev)
-{
-	u16 val[8] = { 0x01ce, 0x01c1,
-		       0x020f, 0x0202,
-		       0x03d0, 0x03c0,
-		       0x0013, 0x0005 };
-	int i, k;
-
-	/* 100M eye finetune:
-	 * Keep middle level of TX MLT3 shapper as default.
-	 * Only change TX MLT3 overshoot level here.
-	 */
-	for (k = 0, i = 1; i < 12; i++) {
-		if (i % 3 == 0)
-			continue;
-		phy_write_mmd(phydev, MDIO_MMD_VEND1, i, val[k++]);
-	}
-
-	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	/* SlvDSPreadyTime = 24, MasDSPreadyTime = 24 */
-	__phy_write(phydev, 0x11, 0xc71);
-	__phy_write(phydev, 0x12, 0xc);
-	__phy_write(phydev, 0x10, 0x8fae);
-
-	/* ResetSyncOffset = 6 */
-	__phy_write(phydev, 0x11, 0x600);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x8fc0);
-
-	/* VgaDecRate = 1 */
-	__phy_write(phydev, 0x11, 0x4c2a);
-	__phy_write(phydev, 0x12, 0x3e);
-	__phy_write(phydev, 0x10, 0x8fa4);
-
-	/* FfeUpdGainForce = 4 */
-	__phy_write(phydev, 0x11, 0x240);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x9680);
-
-	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
-}
-
 static void mt7988_phy_finetune(struct phy_device *phydev)
 {
 	u16 val[12] = { 0x0187, 0x01cd, 0x01c8, 0x0182,
@@ -827,17 +831,7 @@ static void mt7988_phy_finetune(struct phy_device *phydev)
 	/* TCT finetune */
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_TX_FILTER, 0x5);
 
-	/* Disable TX power saving */
-	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RXADC_CTRL_RG7,
-		       MTK_PHY_DA_AD_BUF_BIAS_LP_MASK, 0x3 << 8);
-
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-
-	/* SlvDSPreadyTime = 24, MasDSPreadyTime = 12 */
-	__phy_write(phydev, 0x11, 0x671);
-	__phy_write(phydev, 0x12, 0xc);
-	__phy_write(phydev, 0x10, 0x8fae);
-
 	/* ResetSyncOffset = 5 */
 	__phy_write(phydev, 0x11, 0x500);
 	__phy_write(phydev, 0x12, 0x0);
@@ -845,13 +839,27 @@ static void mt7988_phy_finetune(struct phy_device *phydev)
 
 	/* VgaDecRate is 1 at default on mt7988 */
 
-	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+	/* MrvlTrFix100Kp = 6, MrvlTrFix100Kf = 7,
+	 * MrvlTrFix1000Kp = 6, MrvlTrFix1000Kf = 7
+	 */
+	__phy_write(phydev, 0x11, 0xb90a);
+	__phy_write(phydev, 0x12, 0x6f);
+	__phy_write(phydev, 0x10, 0x8f82);
+
+	/* RemAckCntLimitCtrl = 1 */
+	__phy_write(phydev, 0x11, 0xfbba);
+	__phy_write(phydev, 0x12, 0xc3);
+	__phy_write(phydev, 0x10, 0x87f8);
 
-	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_2A30);
-	/* TxClkOffset = 2 */
-	__phy_modify(phydev, MTK_PHY_ANARG_RG, MTK_PHY_TCLKOFFSET_MASK,
-		     FIELD_PREP(MTK_PHY_TCLKOFFSET_MASK, 0x2));
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+
+	/* TR_OPEN_LOOP_EN = 1, lpf_x_average = 10 */
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DEV1E_REG234,
+		       MTK_PHY_TR_OPEN_LOOP_EN_MASK | MTK_PHY_LPF_X_AVERAGE_MASK,
+		       BIT(0) | FIELD_PREP(MTK_PHY_LPF_X_AVERAGE_MASK, 0xa));
+
+	/* rg_tr_lpf_cnt_val = 1023 */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_LPF_CNT_VAL, 0x3ff);
 }
 
 static void mt798x_phy_eee(struct phy_device *phydev)
@@ -884,11 +892,11 @@ static void mt798x_phy_eee(struct phy_device *phydev)
 		       MTK_PHY_LPI_SLV_SEND_TX_EN,
 		       FIELD_PREP(MTK_PHY_LPI_SLV_SEND_TX_TIMER_MASK, 0x120));
 
-	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DEV1E_REG239,
-		       MTK_PHY_LPI_SEND_LOC_TIMER_MASK |
-		       MTK_PHY_LPI_TXPCS_LOC_RCV,
-		       FIELD_PREP(MTK_PHY_LPI_SEND_LOC_TIMER_MASK, 0x117));
+	/* Keep MTK_PHY_LPI_SEND_LOC_TIMER as 375 */
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DEV1E_REG239,
+			   MTK_PHY_LPI_TXPCS_LOC_RCV);
 
+	/* This also fixes some IoT issues, such as CH340 */
 	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_DEV1E_REG2C7,
 		       MTK_PHY_MAX_GAIN_MASK | MTK_PHY_MIN_GAIN_MASK,
 		       FIELD_PREP(MTK_PHY_MAX_GAIN_MASK, 0x8) |
@@ -922,7 +930,7 @@ static void mt798x_phy_eee(struct phy_device *phydev)
 	__phy_write(phydev, 0x12, 0x0);
 	__phy_write(phydev, 0x10, 0x9690);
 
-	/* REG_EEE_st2TrKf1000 = 3 */
+	/* REG_EEE_st2TrKf1000 = 2 */
 	__phy_write(phydev, 0x11, 0x114f);
 	__phy_write(phydev, 0x12, 0x2);
 	__phy_write(phydev, 0x10, 0x969a);
@@ -947,7 +955,7 @@ static void mt798x_phy_eee(struct phy_device *phydev)
 	__phy_write(phydev, 0x12, 0x0);
 	__phy_write(phydev, 0x10, 0x96b8);
 
-	/* REGEEE_wake_slv_tr_wait_dfesigdet_en = 1 */
+	/* REGEEE_wake_slv_tr_wait_dfesigdet_en = 0 */
 	__phy_write(phydev, 0x11, 0x1463);
 	__phy_write(phydev, 0x12, 0x0);
 	__phy_write(phydev, 0x10, 0x96ca);
@@ -1459,6 +1467,13 @@ static int mt7988_phy_probe(struct phy_device *phydev)
 	if (err)
 		return err;
 
+	/* Disable TX power saving at probing to:
+	 * 1. Meet common mode compliance test criteria
+	 * 2. Make sure that TX-VCM calibration works fine
+	 */
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RXADC_CTRL_RG7,
+		       MTK_PHY_DA_AD_BUF_BIAS_LP_MASK, 0x3 << 8);
+
 	return mt798x_phy_calibration(phydev);
 }
 
-- 
2.43.0




