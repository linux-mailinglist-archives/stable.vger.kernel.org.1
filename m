Return-Path: <stable+bounces-41294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF0C8AFB0E
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BCB286E75
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B6814C59D;
	Tue, 23 Apr 2024 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NekY3Fiy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B3114885A;
	Tue, 23 Apr 2024 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908809; cv=none; b=d05aWiPgKiui8TsCt/4mKl6WVbXtnu+oqNfxYgu+FyGWXjpqHHQFiXKJRarR9YC5Rf3AFy0NVZwn2QdRaKf7nXBcrQ78cUzLfrdr5ld9NF+NgFLg+oIw6Cae0LmkSVppgNEyP2vUuXafNC2Oho534MPEG3TIUNT2l+v7rwv8ajQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908809; c=relaxed/simple;
	bh=T0/TYXYMKKzBnXk7/5zikX0Am71pvV7G9F9Ip5Bft1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBiPZXrggk3lLc4+xzzJPftkP5GNG9JuM2Y/LNoYaY9wiyHPc0F4vRtk5b4iaXLjPwSzKRbGIT3ZG+xROJvfnGNkPSgWwNkUSE+Oo2MumxvSenW2MhCQF+hGN/vdC6Qn11Sx8uMwmNhbX1OxZ8Pyf9gSFC7SwLb2UvZuZ+p09NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NekY3Fiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C15C3277B;
	Tue, 23 Apr 2024 21:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908809;
	bh=T0/TYXYMKKzBnXk7/5zikX0Am71pvV7G9F9Ip5Bft1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NekY3FiyZ6Hdu02bNrZM6ORgnQS0I/fEdAuCFv45dBwa8mXxZ11JHwLL28K5cqANH
	 lvxnxFCaK6GNt9FYVg9zULhKaxMLf++62yDEVVkRoZbNkSNpdJky6u8sXMCZqtRm9Q
	 ozOBwhXPjDZ3NM1BTlXfkRWbW8kfsYSeqjrOf6tg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 71/71] net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards
Date: Tue, 23 Apr 2024 14:40:24 -0700
Message-ID: <20240423213846.667651340@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
References: <20240423213844.122920086@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arınç ÜNAL <arinc.unal@arinc9.com>

commit 06dfcd4098cfdc4d4577d94793a4f9125386da8b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mt7530.c |   19 +++++++++++++------
 drivers/net/dsa/mt7530.h |    1 +
 2 files changed, 14 insertions(+), 6 deletions(-)

--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2587,7 +2587,7 @@ mt7531_setup(struct dsa_switch *ds)
 	struct mt7530_priv *priv = ds->priv;
 	struct mt7530_dummy_poll p;
 	u32 val, id;
-	int ret;
+	int ret, i;
 
 	/* Reset whole chip through gpio pin or memory-mapped registers for
 	 * different type of hardware
@@ -2647,18 +2647,25 @@ mt7531_setup(struct dsa_switch *ds)
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
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -673,6 +673,7 @@ enum mt7531_clk_skew {
 #define  RG_SYSPLL_DDSFBK_EN		BIT(12)
 #define  RG_SYSPLL_BIAS_EN		BIT(11)
 #define  RG_SYSPLL_BIAS_LPF_EN		BIT(10)
+#define  MT7531_RG_SYSPLL_DMY2		BIT(6)
 #define  MT7531_PHY_PLL_OFF		BIT(5)
 #define  MT7531_PHY_PLL_BYPASS_MODE	BIT(4)
 



