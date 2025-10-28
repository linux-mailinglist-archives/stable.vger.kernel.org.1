Return-Path: <stable+bounces-191378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1F0C129D0
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 03:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49C544E15EB
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 02:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F414F1E86E;
	Tue, 28 Oct 2025 02:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Eoff3n9C"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEF828E9
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616841; cv=none; b=TVSuPm+WdR1C5aF+NUDnlb8Qkbaescdu77f8a5pd79rDwGnP71cP9daD1e8U7sFUf4Z/1Xh1TRRG2TowVc6P5pRsmdd+chVseUExCyW1QbYMTySmb6LO+IVnmFmSuAZduOonjSHJM1Rx7B5QsTHP+UB7RcG4ntu24v5/Wn7Cj6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616841; c=relaxed/simple;
	bh=rf4AIEHEW2a3laeNL4F6QNbR7b20jJ5mQqfGwNYjOKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DeJh+lgRcIMGELo7fLUtQ/onPsaiV9zFszZLZ3mbVEwRkJUYAZ4WfuuBsYvpPgbxu+WolerKavQy5kBX6pT+LNluO7bcCapV1iE5rxcB+34FWLhkFKnvbaYRxbbYeZ5axbJxD4WjhmemA40hFf1WJjchgyz8hK7SCeKZZefzwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Eoff3n9C; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761616832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fOQmhmBDEYiwvDVP6Wx0SsY1m99stZnZK9xXTiCWbmI=;
	b=Eoff3n9CRed5URbWwNozoIdyhrxXvgUMSnJE5AdRahNur0fht3tIpT2Mga2I5xckNBwrTw
	xej/x8o+ULlHU6Nkphfp1w0Bwm7s6CKDNaWvgYpncCjFetGzpBUmZeGG0FVi+lpTHclHKU
	jcxxB560oNolAfrYGbp2AQOWnYpqgfY=
From: Yi Cong <cong.yi@linux.dev>
To: Frank.Sae@motor-comm.com,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: phy: motorcomm: Fix the issue in the code regarding the incorrect use of time units
Date: Tue, 28 Oct 2025 09:59:23 +0800
Message-Id: <20251028015923.252909-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

Currently, NS (nanoseconds) is being used, but according to the datasheet,
the correct unit should be PS (picoseconds).

Fixes: 4869a146cd60 ("net: phy: Add BIT macro for Motorcomm yt8521/yt8531 gigabit ethernet phy")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/phy/motorcomm.c | 102 ++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index a3593e663059..81491c71e75b 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -171,7 +171,7 @@
  * 1b1 enable 1.9ns rxc clock delay
  */
 #define YT8521_CCR_RXC_DLY_EN			BIT(8)
-#define YT8521_CCR_RXC_DLY_1_900_NS		1900
+#define YT8521_CCR_RXC_DLY_1_900_PS		1900
 
 #define YT8521_CCR_MODE_SEL_MASK		(BIT(2) | BIT(1) | BIT(0))
 #define YT8521_CCR_MODE_UTP_TO_RGMII		0
@@ -196,22 +196,22 @@
 #define YT8521_RC1R_RX_DELAY_MASK		GENMASK(13, 10)
 #define YT8521_RC1R_FE_TX_DELAY_MASK		GENMASK(7, 4)
 #define YT8521_RC1R_GE_TX_DELAY_MASK		GENMASK(3, 0)
-#define YT8521_RC1R_RGMII_0_000_NS		0
-#define YT8521_RC1R_RGMII_0_150_NS		1
-#define YT8521_RC1R_RGMII_0_300_NS		2
-#define YT8521_RC1R_RGMII_0_450_NS		3
-#define YT8521_RC1R_RGMII_0_600_NS		4
-#define YT8521_RC1R_RGMII_0_750_NS		5
-#define YT8521_RC1R_RGMII_0_900_NS		6
-#define YT8521_RC1R_RGMII_1_050_NS		7
-#define YT8521_RC1R_RGMII_1_200_NS		8
-#define YT8521_RC1R_RGMII_1_350_NS		9
-#define YT8521_RC1R_RGMII_1_500_NS		10
-#define YT8521_RC1R_RGMII_1_650_NS		11
-#define YT8521_RC1R_RGMII_1_800_NS		12
-#define YT8521_RC1R_RGMII_1_950_NS		13
-#define YT8521_RC1R_RGMII_2_100_NS		14
-#define YT8521_RC1R_RGMII_2_250_NS		15
+#define YT8521_RC1R_RGMII_0_000_PS		0
+#define YT8521_RC1R_RGMII_0_150_PS		1
+#define YT8521_RC1R_RGMII_0_300_PS		2
+#define YT8521_RC1R_RGMII_0_450_PS		3
+#define YT8521_RC1R_RGMII_0_600_PS		4
+#define YT8521_RC1R_RGMII_0_750_PS		5
+#define YT8521_RC1R_RGMII_0_900_PS		6
+#define YT8521_RC1R_RGMII_1_050_PS		7
+#define YT8521_RC1R_RGMII_1_200_PS		8
+#define YT8521_RC1R_RGMII_1_350_PS		9
+#define YT8521_RC1R_RGMII_1_500_PS		10
+#define YT8521_RC1R_RGMII_1_650_PS		11
+#define YT8521_RC1R_RGMII_1_800_PS		12
+#define YT8521_RC1R_RGMII_1_950_PS		13
+#define YT8521_RC1R_RGMII_2_100_PS		14
+#define YT8521_RC1R_RGMII_2_250_PS		15
 
 /* LED CONFIG */
 #define YT8521_MAX_LEDS				3
@@ -800,40 +800,40 @@ struct ytphy_cfg_reg_map {
 
 static const struct ytphy_cfg_reg_map ytphy_rgmii_delays[] = {
 	/* for tx delay / rx delay with YT8521_CCR_RXC_DLY_EN is not set. */
-	{ 0,	YT8521_RC1R_RGMII_0_000_NS },
-	{ 150,	YT8521_RC1R_RGMII_0_150_NS },
-	{ 300,	YT8521_RC1R_RGMII_0_300_NS },
-	{ 450,	YT8521_RC1R_RGMII_0_450_NS },
-	{ 600,	YT8521_RC1R_RGMII_0_600_NS },
-	{ 750,	YT8521_RC1R_RGMII_0_750_NS },
-	{ 900,	YT8521_RC1R_RGMII_0_900_NS },
-	{ 1050,	YT8521_RC1R_RGMII_1_050_NS },
-	{ 1200,	YT8521_RC1R_RGMII_1_200_NS },
-	{ 1350,	YT8521_RC1R_RGMII_1_350_NS },
-	{ 1500,	YT8521_RC1R_RGMII_1_500_NS },
-	{ 1650,	YT8521_RC1R_RGMII_1_650_NS },
-	{ 1800,	YT8521_RC1R_RGMII_1_800_NS },
-	{ 1950,	YT8521_RC1R_RGMII_1_950_NS },	/* default tx/rx delay */
-	{ 2100,	YT8521_RC1R_RGMII_2_100_NS },
-	{ 2250,	YT8521_RC1R_RGMII_2_250_NS },
+	{ 0,	YT8521_RC1R_RGMII_0_000_PS },
+	{ 150,	YT8521_RC1R_RGMII_0_150_PS },
+	{ 300,	YT8521_RC1R_RGMII_0_300_PS },
+	{ 450,	YT8521_RC1R_RGMII_0_450_PS },
+	{ 600,	YT8521_RC1R_RGMII_0_600_PS },
+	{ 750,	YT8521_RC1R_RGMII_0_750_PS },
+	{ 900,	YT8521_RC1R_RGMII_0_900_PS },
+	{ 1050,	YT8521_RC1R_RGMII_1_050_PS },
+	{ 1200,	YT8521_RC1R_RGMII_1_200_PS },
+	{ 1350,	YT8521_RC1R_RGMII_1_350_PS },
+	{ 1500,	YT8521_RC1R_RGMII_1_500_PS },
+	{ 1650,	YT8521_RC1R_RGMII_1_650_PS },
+	{ 1800,	YT8521_RC1R_RGMII_1_800_PS },
+	{ 1950,	YT8521_RC1R_RGMII_1_950_PS },	/* default tx/rx delay */
+	{ 2100,	YT8521_RC1R_RGMII_2_100_PS },
+	{ 2250,	YT8521_RC1R_RGMII_2_250_PS },
 
 	/* only for rx delay with YT8521_CCR_RXC_DLY_EN is set. */
-	{ 0    + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_0_000_NS },
-	{ 150  + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_0_150_NS },
-	{ 300  + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_0_300_NS },
-	{ 450  + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_0_450_NS },
-	{ 600  + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_0_600_NS },
-	{ 750  + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_0_750_NS },
-	{ 900  + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_0_900_NS },
-	{ 1050 + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_1_050_NS },
-	{ 1200 + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_1_200_NS },
-	{ 1350 + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_1_350_NS },
-	{ 1500 + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_1_500_NS },
-	{ 1650 + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_1_650_NS },
-	{ 1800 + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_1_800_NS },
-	{ 1950 + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_1_950_NS },
-	{ 2100 + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_2_100_NS },
-	{ 2250 + YT8521_CCR_RXC_DLY_1_900_NS,	YT8521_RC1R_RGMII_2_250_NS }
+	{ 0    + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_0_000_PS },
+	{ 150  + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_0_150_PS },
+	{ 300  + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_0_300_PS },
+	{ 450  + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_0_450_PS },
+	{ 600  + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_0_600_PS },
+	{ 750  + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_0_750_PS },
+	{ 900  + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_0_900_PS },
+	{ 1050 + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_1_050_PS },
+	{ 1200 + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_1_200_PS },
+	{ 1350 + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_1_350_PS },
+	{ 1500 + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_1_500_PS },
+	{ 1650 + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_1_650_PS },
+	{ 1800 + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_1_800_PS },
+	{ 1950 + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_1_950_PS },
+	{ 2100 + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_2_100_PS },
+	{ 2250 + YT8521_CCR_RXC_DLY_1_900_PS,	YT8521_RC1R_RGMII_2_250_PS }
 };
 
 static u32 ytphy_get_delay_reg_value(struct phy_device *phydev,
@@ -890,10 +890,10 @@ static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
 	rx_reg = ytphy_get_delay_reg_value(phydev, "rx-internal-delay-ps",
 					   ytphy_rgmii_delays, tb_size,
 					   &rxc_dly_en,
-					   YT8521_RC1R_RGMII_1_950_NS);
+					   YT8521_RC1R_RGMII_1_950_PS);
 	tx_reg = ytphy_get_delay_reg_value(phydev, "tx-internal-delay-ps",
 					   ytphy_rgmii_delays, tb_size, NULL,
-					   YT8521_RC1R_RGMII_1_950_NS);
+					   YT8521_RC1R_RGMII_1_950_PS);
 
 	switch (phydev->interface) {
 	case PHY_INTERFACE_MODE_RGMII:
-- 
2.25.1


