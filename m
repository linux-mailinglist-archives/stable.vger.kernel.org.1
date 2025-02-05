Return-Path: <stable+bounces-113589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2DEA292F9
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF09B3A1599
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ED818C01E;
	Wed,  5 Feb 2025 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C58e0J9N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB11591E3;
	Wed,  5 Feb 2025 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767477; cv=none; b=elJAJluFJLx9pi7LBBwMo7JePqzjvHODuNfe4Vqk5iGxJfH4o6szX0GmW3dIxbRlzcO2pwvkaxjQ9/qsdMLgH9u+ICtFjbjxTF2Vp/CclmHiac5g6glsOdCNb6UB9LlMZUNm4VjZMGTGigsterdomtYMegfmD1/YcXDQlr/TBfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767477; c=relaxed/simple;
	bh=JLTSTMf+HzRRg9zpxSCYws4wbmdPMJ7ZnC6b09u39p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqf1eU30A34uszHy5VwbzVtmkVp1mp8J471Tz1n3u/CE/rIgyO6igBFT+/VO3zauu+/pURVMc99nHxVFZ48NuQWxK1fQnJWTKFsuJOHu7YQe39SWK45JOHOsMBDiW2of7uo/4xgzjN7ENfKhP3EWXH4vXmpOJYaDOfpJCfjdfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C58e0J9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A35C4CED1;
	Wed,  5 Feb 2025 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767477;
	bh=JLTSTMf+HzRRg9zpxSCYws4wbmdPMJ7ZnC6b09u39p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C58e0J9N2Wxfx+iRRV9+VkjL/VUtIbynwGvLQ7EMIVu0M8i0xlvuQOYPskZe5OnfQ
	 EPLYVIJD80AfT+b5ZQUvlwCRAzK4JLvr+PEW88mg5gvYGdL65wNCxXDvmFGCizcgO+
	 +rWOaAorZcNMoqwGWgyBrUU4A7klCv+xPp5vJ+0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adam Ford <aford173@gmail.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 462/590] phy: freescale: fsl-samsung-hdmi: Replace register defines with macro
Date: Wed,  5 Feb 2025 14:43:37 +0100
Message-ID: <20250205134512.937730267@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 4a5a9e2577d61a4ee3e9788e0c2b0c1cbc5ba7b3 ]

There are 47 registers defined as PHY_REG_xx were xx goes from 00 to
47.  Simplify this by replacing them all with a macro which is passed
the register number to return the proper register offset.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Link: https://lore.kernel.org/r/20240914112816.520224-2-aford173@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: d567679f2b6a ("phy: freescale: fsl-samsung-hdmi: Clean up fld_tg_code calculation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 133 ++++++-------------
 1 file changed, 43 insertions(+), 90 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 9048cdc760c21..acea7008aefc5 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -14,76 +14,29 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
-#define PHY_REG_00		0x00
-#define PHY_REG_01		0x04
-#define PHY_REG_02		0x08
-#define PHY_REG_08		0x20
-#define PHY_REG_09		0x24
-#define PHY_REG_10		0x28
-#define PHY_REG_11		0x2c
-
-#define PHY_REG_12		0x30
-#define  REG12_CK_DIV_MASK	GENMASK(5, 4)
-
-#define PHY_REG_13		0x34
-#define  REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
-
-#define PHY_REG_14		0x38
-#define  REG14_TOL_MASK		GENMASK(7, 4)
-#define  REG14_RP_CODE_MASK	GENMASK(3, 1)
-#define  REG14_TG_CODE_HIGH_MASK	GENMASK(0, 0)
-
-#define PHY_REG_15		0x3c
-#define PHY_REG_16		0x40
-#define PHY_REG_17		0x44
-#define PHY_REG_18		0x48
-#define PHY_REG_19		0x4c
-#define PHY_REG_20		0x50
-
-#define PHY_REG_21		0x54
-#define  REG21_SEL_TX_CK_INV	BIT(7)
-#define  REG21_PMS_S_MASK	GENMASK(3, 0)
-
-#define PHY_REG_22		0x58
-#define PHY_REG_23		0x5c
-#define PHY_REG_24		0x60
-#define PHY_REG_25		0x64
-#define PHY_REG_26		0x68
-#define PHY_REG_27		0x6c
-#define PHY_REG_28		0x70
-#define PHY_REG_29		0x74
-#define PHY_REG_30		0x78
-#define PHY_REG_31		0x7c
-#define PHY_REG_32		0x80
+#define PHY_REG(reg)		(reg * 4)
 
+#define REG12_CK_DIV_MASK	GENMASK(5, 4)
+
+#define REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
+
+#define REG14_TOL_MASK		GENMASK(7, 4)
+#define REG14_RP_CODE_MASK	GENMASK(3, 1)
+#define REG14_TG_CODE_HIGH_MASK	GENMASK(0, 0)
+
+#define REG21_SEL_TX_CK_INV	BIT(7)
+#define REG21_PMS_S_MASK	GENMASK(3, 0)
 /*
  * REG33 does not match the ref manual. According to Sandor Yu from NXP,
  * "There is a doc issue on the i.MX8MP latest RM"
  * REG33 is being used per guidance from Sandor
  */
+#define REG33_MODE_SET_DONE	BIT(7)
+#define REG33_FIX_DA		BIT(1)
 
-#define PHY_REG_33		0x84
-#define  REG33_MODE_SET_DONE	BIT(7)
-#define  REG33_FIX_DA		BIT(1)
-
-#define PHY_REG_34		0x88
-#define  REG34_PHY_READY	BIT(7)
-#define  REG34_PLL_LOCK		BIT(6)
-#define  REG34_PHY_CLK_READY	BIT(5)
-
-#define PHY_REG_35		0x8c
-#define PHY_REG_36		0x90
-#define PHY_REG_37		0x94
-#define PHY_REG_38		0x98
-#define PHY_REG_39		0x9c
-#define PHY_REG_40		0xa0
-#define PHY_REG_41		0xa4
-#define PHY_REG_42		0xa8
-#define PHY_REG_43		0xac
-#define PHY_REG_44		0xb0
-#define PHY_REG_45		0xb4
-#define PHY_REG_46		0xb8
-#define PHY_REG_47		0xbc
+#define REG34_PHY_READY	BIT(7)
+#define REG34_PLL_LOCK		BIT(6)
+#define REG34_PHY_CLK_READY	BIT(5)
 
 #define PHY_PLL_DIV_REGS_NUM 6
 
@@ -369,29 +322,29 @@ struct reg_settings {
 };
 
 static const struct reg_settings common_phy_cfg[] = {
-	{ PHY_REG_00, 0x00 }, { PHY_REG_01, 0xd1 },
-	{ PHY_REG_08, 0x4f }, { PHY_REG_09, 0x30 },
-	{ PHY_REG_10, 0x33 }, { PHY_REG_11, 0x65 },
+	{ PHY_REG(0), 0x00 }, { PHY_REG(1), 0xd1 },
+	{ PHY_REG(8), 0x4f }, { PHY_REG(9), 0x30 },
+	{ PHY_REG(10), 0x33 }, { PHY_REG(11), 0x65 },
 	/* REG12 pixclk specific */
 	/* REG13 pixclk specific */
 	/* REG14 pixclk specific */
-	{ PHY_REG_15, 0x80 }, { PHY_REG_16, 0x6c },
-	{ PHY_REG_17, 0xf2 }, { PHY_REG_18, 0x67 },
-	{ PHY_REG_19, 0x00 }, { PHY_REG_20, 0x10 },
+	{ PHY_REG(15), 0x80 }, { PHY_REG(16), 0x6c },
+	{ PHY_REG(17), 0xf2 }, { PHY_REG(18), 0x67 },
+	{ PHY_REG(19), 0x00 }, { PHY_REG(20), 0x10 },
 	/* REG21 pixclk specific */
-	{ PHY_REG_22, 0x30 }, { PHY_REG_23, 0x32 },
-	{ PHY_REG_24, 0x60 }, { PHY_REG_25, 0x8f },
-	{ PHY_REG_26, 0x00 }, { PHY_REG_27, 0x00 },
-	{ PHY_REG_28, 0x08 }, { PHY_REG_29, 0x00 },
-	{ PHY_REG_30, 0x00 }, { PHY_REG_31, 0x00 },
-	{ PHY_REG_32, 0x00 }, { PHY_REG_33, 0x80 },
-	{ PHY_REG_34, 0x00 }, { PHY_REG_35, 0x00 },
-	{ PHY_REG_36, 0x00 }, { PHY_REG_37, 0x00 },
-	{ PHY_REG_38, 0x00 }, { PHY_REG_39, 0x00 },
-	{ PHY_REG_40, 0x00 }, { PHY_REG_41, 0xe0 },
-	{ PHY_REG_42, 0x83 }, { PHY_REG_43, 0x0f },
-	{ PHY_REG_44, 0x3E }, { PHY_REG_45, 0xf8 },
-	{ PHY_REG_46, 0x00 }, { PHY_REG_47, 0x00 }
+	{ PHY_REG(22), 0x30 }, { PHY_REG(23), 0x32 },
+	{ PHY_REG(24), 0x60 }, { PHY_REG(25), 0x8f },
+	{ PHY_REG(26), 0x00 }, { PHY_REG(27), 0x00 },
+	{ PHY_REG(28), 0x08 }, { PHY_REG(29), 0x00 },
+	{ PHY_REG(30), 0x00 }, { PHY_REG(31), 0x00 },
+	{ PHY_REG(32), 0x00 }, { PHY_REG(33), 0x80 },
+	{ PHY_REG(34), 0x00 }, { PHY_REG(35), 0x00 },
+	{ PHY_REG(36), 0x00 }, { PHY_REG(37), 0x00 },
+	{ PHY_REG(38), 0x00 }, { PHY_REG(39), 0x00 },
+	{ PHY_REG(40), 0x00 }, { PHY_REG(41), 0xe0 },
+	{ PHY_REG(42), 0x83 }, { PHY_REG(43), 0x0f },
+	{ PHY_REG(44), 0x3E }, { PHY_REG(45), 0xf8 },
+	{ PHY_REG(46), 0x00 }, { PHY_REG(47), 0x00 }
 };
 
 struct fsl_samsung_hdmi_phy {
@@ -442,7 +395,7 @@ fsl_samsung_hdmi_phy_configure_pixclk(struct fsl_samsung_hdmi_phy *phy,
 	}
 
 	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK, div),
-	       phy->regs + PHY_REG_21);
+	       phy->regs + PHY_REG(21));
 }
 
 static void
@@ -469,7 +422,7 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
 		break;
 	}
 
-	writeb(FIELD_PREP(REG12_CK_DIV_MASK, ilog2(div)), phy->regs + PHY_REG_12);
+	writeb(FIELD_PREP(REG12_CK_DIV_MASK, ilog2(div)), phy->regs + PHY_REG(12));
 
 	/*
 	 * Calculation for the frequency lock detector target code (fld_tg_code)
@@ -489,11 +442,11 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
 
 	/* FLD_TOL and FLD_RP_CODE taken from downstream driver */
 	writeb(FIELD_PREP(REG13_TG_CODE_LOW_MASK, fld_tg_code),
-	       phy->regs + PHY_REG_13);
+	       phy->regs + PHY_REG(13));
 	writeb(FIELD_PREP(REG14_TOL_MASK, 2) |
 	       FIELD_PREP(REG14_RP_CODE_MASK, 2) |
 	       FIELD_PREP(REG14_TG_CODE_HIGH_MASK, fld_tg_code >> 8),
-	       phy->regs + PHY_REG_14);
+	       phy->regs + PHY_REG(14));
 }
 
 static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
@@ -503,7 +456,7 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
 	u8 val;
 
 	/* HDMI PHY init */
-	writeb(REG33_FIX_DA, phy->regs + PHY_REG_33);
+	writeb(REG33_FIX_DA, phy->regs + PHY_REG(33));
 
 	/* common PHY registers */
 	for (i = 0; i < ARRAY_SIZE(common_phy_cfg); i++)
@@ -511,14 +464,14 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
 
 	/* set individual PLL registers PHY_REG2 ... PHY_REG7 */
 	for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
-		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG_02 + i * 4);
+		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
 
 	fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
 	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
 
-	writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG_33);
+	writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG(33));
 
-	ret = readb_poll_timeout(phy->regs + PHY_REG_34, val,
+	ret = readb_poll_timeout(phy->regs + PHY_REG(34), val,
 				 val & REG34_PLL_LOCK, 50, 20000);
 	if (ret)
 		dev_err(phy->dev, "PLL failed to lock\n");
-- 
2.39.5




