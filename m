Return-Path: <stable+bounces-40340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE6F8ABC4F
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4151C20882
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C890139AF1;
	Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+N8MDhQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6E2CCD7
	for <stable@vger.kernel.org>; Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713628813; cv=none; b=EzqBFukrTV1Oi4xpa6Ap3H79ungbFbCWWC3tps+zeVsrmMU+LU64ZYquPD3hOOo2RwxoxzcJVaZRfeuJ1WAEQR00WejUsHPZkRngAMv26DN/eMr/XkqpJd2PS6I7EzzvPn/4ejm449RoVxJpCJLnF++BoMLZ34kpTds/ELuttGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713628813; c=relaxed/simple;
	bh=zJxFIANg2IQ3jLBHpq14fSvPhF6fYk4WxDyLHF/S13I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CoGjIeFG1sRKVRLTPYqc4h4i/aKJ1aEIZAhbwKBsyv4SHr7QxXpozQALANHMQtvVm+r53ozcLl33SJGXt0ig4mzkr+nrD9BNMzXDy6wDUaLD2n/3Jr8bMRO1G1Coh3AgJLLYEG6iiHx/kTZX1fgZZuCUf17Q2Nf60jgwcT0r9dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+N8MDhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41F4DC116B1;
	Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713628813;
	bh=zJxFIANg2IQ3jLBHpq14fSvPhF6fYk4WxDyLHF/S13I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E+N8MDhQFIVOnDkQCS1tr9bKcbg5fhXFAj+DCMBrxnI1506FzKZJ4igaXUMUxgfqs
	 lJ6QOnc0i6UgSBBNyBugVOOwj3gYw9UQ3RgY7LS2b8X7e8MfgBg3Y+ZaV7t91xQu5H
	 9EI+hJsoWRa/NCRT2IEOTkdqPD4m5tMTgAHNuSnFLJfmfpos1hI6zvA3rgHC/TQf5s
	 DKIE5tDuqfSSt/wo3chOw8G/ZWIeP+GKpQmSSaRjxmZUd96sq2GDt7FUWu7tMQrWH9
	 UEaW1Av0kV/bNug4xhpYHvoVu78xoxI09LpyUzwH7AM/GMNT+Ez7/nq+TJ95s/h4Bm
	 /XlLf5/A7ni6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9B7C4345F;
	Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sat, 20 Apr 2024 18:59:53 +0300
Subject: [PATCH 4/4] net: dsa: mt7530: fix enabling EEE on MT7531 switch on
 all boards
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240420-for-stable-6-1-backports-v1-4-0c50ca4324ea@arinc9.com>
References: <20240420-for-stable-6-1-backports-v1-0-0c50ca4324ea@arinc9.com>
In-Reply-To: <20240420-for-stable-6-1-backports-v1-0-0c50ca4324ea@arinc9.com>
To: stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Jakub Kicinski <kuba@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713628810; l=4462;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=sAMzXwDUO2h667g0z0vfDrwpkEGP6YTyNCtgGexxMqw=;
 b=YGC03nSnLk6UKGMElMa72tI9wDhjPB+qzEwEs5PtAaSLNvY029OjGBsvf6xMaia2Tg+q/mnwC
 6uokk53KbGKCq/kW9jfB0r4DEG62pa4vWCd/Bev6cXdiLlasU6723BL
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

[ Upstream commit 06dfcd4098cfdc4d4577d94793a4f9125386da8b ]

The commit 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
brought EEE support but did not enable EEE on MT7531 switch MACs. EEE is
enabled on MT7531 switch MACs by pulling the LAN2LED0 pin low on the board
(bootstrapping), unsetting the EEE_DIS bit on the trap register, or setting
the internal EEE switch bit on the CORE_PLL_GROUP4 register. Thanks to
SkyLake Huang (黃啟澤) from MediaTek for providing information on the
internal EEE switch bit.

There are existing boards that were not designed to pull the pin low.
Because of that, the EEE status currently depends on the board design.

The EEE_DIS bit on the trap pertains to the LAN2LED0 pin which is usually
used to control an LED. Once the bit is unset, the pin will be low. That
will make the active low LED turn on. The pin is controlled by the switch
PHY. It seems that the PHY controls the pin in the way that it inverts the
pin state. That means depending on the wiring of the LED connected to
LAN2LED0 on the board, the LED may be on without an active link.

To not cause this unwanted behaviour whilst enabling EEE on all boards, set
the internal EEE switch bit on the CORE_PLL_GROUP4 register.

My testing on MT7531 shows a certain amount of traffic loss when EEE is
enabled. That said, I haven't come across a board that enables EEE. So
enable EEE on the switch MACs but disable EEE advertisement on the switch
PHYs. This way, we don't change the behaviour of the majority of the boards
that have this switch. The mediatek-ge PHY driver already disables EEE
advertisement on the switch PHYs but my testing shows that it is somehow
enabled afterwards. Disabling EEE advertisement before the PHY driver
initialises keeps it off.

With this change, EEE can now be enabled using ethtool.

Fixes: 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Tested-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Link: https://lore.kernel.org/r/20240408-for-net-mt7530-fix-eee-for-mt7531-mt7988-v3-1-84fdef1f008b@arinc9.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 17 ++++++++++++-----
 drivers/net/dsa/mt7530.h |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index a917ad56191b..c9fffb787cad 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2669,18 +2669,25 @@ mt7531_setup(struct dsa_switch *ds)
 	priv->p5_interface = PHY_INTERFACE_MODE_NA;
 	priv->p6_interface = PHY_INTERFACE_MODE_NA;
 
-	/* Enable PHY core PLL, since phy_device has not yet been created
-	 * provided for phy_[read,write]_mmd_indirect is called, we provide
-	 * our own mt7531_ind_mmd_phy_[read,write] to complete this
-	 * function.
+	/* Enable Energy-Efficient Ethernet (EEE) and PHY core PLL, since
+	 * phy_device has not yet been created provided for
+	 * phy_[read,write]_mmd_indirect is called, we provide our own
+	 * mt7531_ind_mmd_phy_[read,write] to complete this function.
 	 */
 	val = mt7531_ind_c45_phy_read(priv, MT753X_CTRL_PHY_ADDR,
 				      MDIO_MMD_VEND2, CORE_PLL_GROUP4);
-	val |= MT7531_PHY_PLL_BYPASS_MODE;
+	val |= MT7531_RG_SYSPLL_DMY2 | MT7531_PHY_PLL_BYPASS_MODE;
 	val &= ~MT7531_PHY_PLL_OFF;
 	mt7531_ind_c45_phy_write(priv, MT753X_CTRL_PHY_ADDR, MDIO_MMD_VEND2,
 				 CORE_PLL_GROUP4, val);
 
+	/* Disable EEE advertisement on the switch PHYs. */
+	for (i = MT753X_CTRL_PHY_ADDR;
+	     i < MT753X_CTRL_PHY_ADDR + MT7530_NUM_PHYS; i++) {
+		mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
+					 0);
+	}
+
 	mt7531_setup_common(ds);
 
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 0facaf21d69f..78d4e47489ba 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -669,6 +669,7 @@ enum mt7531_clk_skew {
 #define  RG_SYSPLL_DDSFBK_EN		BIT(12)
 #define  RG_SYSPLL_BIAS_EN		BIT(11)
 #define  RG_SYSPLL_BIAS_LPF_EN		BIT(10)
+#define  MT7531_RG_SYSPLL_DMY2		BIT(6)
 #define  MT7531_PHY_PLL_OFF		BIT(5)
 #define  MT7531_PHY_PLL_BYPASS_MODE	BIT(4)
 

-- 
2.40.1



