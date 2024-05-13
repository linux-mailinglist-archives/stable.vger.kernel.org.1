Return-Path: <stable+bounces-43680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8408C42B8
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F3FFB23070
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5915153576;
	Mon, 13 May 2024 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0+9By8xI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ACF14EC7A
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608748; cv=none; b=XwmR4XkKL6UId37mmFVDNSOEPIzIzCpLVbxXb9Sjs8fjH3hN5x7WWOktjLQJF5swJlYiotM2RO/0xvx8DXJr/D4ZQT2NPK7St8SIJUD+Z6kQNzN8g3zwCjNMYyhghmRN0zSvlsIUj6G+mpRUkLpvLVR+vxBphYenPn3wkz3g/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608748; c=relaxed/simple;
	bh=hew0zdIEpuCh2owIoksS5PgpsvdguZuKLOw4Mlb4xZs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B+XHU5LQiQ9Glp6vUWXCBl6uCS9Wa1Xz0o6yuSLmkIxIj2Sh2RH4oZbmmlOGMgCbbb0luv3WGSPi8xlLxCYLf3+4BlRBYnkXVHsUPpUh5uBOWlBb294iJ03I+ZLa6kMYr1KrWvQAw6paBhLhUIuAR6tchIfDMYxCOU7XSflQpUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0+9By8xI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848F9C4AF09;
	Mon, 13 May 2024 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715608748;
	bh=hew0zdIEpuCh2owIoksS5PgpsvdguZuKLOw4Mlb4xZs=;
	h=Subject:To:Cc:From:Date:From;
	b=0+9By8xIJxYXveT7x0MnTAKajU7uGoQ8bOc89e/LU1BXL3VL3VsoGAGY8umFKEkIK
	 8P4Vn8WZU3SF8AiMTIVGg6777hpSwUwCH4ZxAxzjW3WjfKpgKqJCMtJCQ9pefcqrQb
	 82v7jOUqNqI5+u+msl/j7RziKvGH28xehs2GDN8g=
Subject: FAILED: patch "[PATCH] net: bcmgenet: synchronize UMAC_CMD access" failed to apply to 5.4-stable tree
To: opendmb@gmail.com,davem@davemloft.net,florian.fainelli@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:59:00 +0200
Message-ID: <2024051300-stipend-sectional-89da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 0d5e2a82232605b337972fb2c7d0cbc46898aca1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051300-stipend-sectional-89da@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

0d5e2a822326 ("net: bcmgenet: synchronize UMAC_CMD access")
a9f31047baca ("net: bcmgenet: Fix EEE implementation")
53243d412ec5 ("net: use bool values to pass bool param of phy_init_eee()")
fc13d8c03773 ("net: bcmgenet: pull mac_config from adjust_link")
fcb5dfe7dc40 ("net: bcmgenet: remove old link state values")
50e356686fa9 ("net: bcmgenet: remove netif_carrier_off from adjust_link")
b972b54a68b2 ("net: bcmgenet: Patch PHY interface for dedicated PHY driver")
b82f8c3f1409 ("net: fec: add eee mode tx lpi support")
40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
28e303da55b3 ("net: broadcom: share header defining UniMAC registers")
12cf8e75727a ("bgmac: add bgmac_umac_*() helpers for accessing UniMAC registers")
c288575f7810 ("net: dsa: mt7530: Add the support of MT7531 switch")
88bdef8be9f6 ("net: dsa: mt7530: Extend device data ready for adding a new hardware")
dc8ef938c94e ("net: dsa: mt7530: Refine message in Kconfig")
f272285f6abb ("net: dsa: mt7530: fix advertising unsupported 1000baseT_Half")
ccaab4d3df98 ("MAINTAINERS: GENET: Add UniMAC MDIO controller files")
f69ccc563df0 ("MAINTAINERS: GENET: Add DT binding file")
d0cac91817c8 ("MAINTAINERS: GENET: Add missing platform data file")
2f11f0df8474 ("net: bcmgenet: test MPD_EN when resuming")
a7f7f6248d97 ("treewide: replace '---help---' in Kconfig files with 'help'")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0d5e2a82232605b337972fb2c7d0cbc46898aca1 Mon Sep 17 00:00:00 2001
From: Doug Berger <opendmb@gmail.com>
Date: Thu, 25 Apr 2024 15:27:21 -0700
Subject: [PATCH] net: bcmgenet: synchronize UMAC_CMD access

The UMAC_CMD register is written from different execution
contexts and has insufficient synchronization protections to
prevent possible corruption. Of particular concern are the
acceses from the phy_device delayed work context used by the
adjust_link call and the BH context that may be used by the
ndo_set_rx_mode call.

A spinlock is added to the driver to protect contended register
accesses (i.e. reg_lock) and it is used to synchronize accesses
to UMAC_CMD.

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 5452b7dc6e6a..c7e7dac057a3 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2467,14 +2467,18 @@ static void umac_enable_set(struct bcmgenet_priv *priv, u32 mask, bool enable)
 {
 	u32 reg;
 
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
-	if (reg & CMD_SW_RESET)
+	if (reg & CMD_SW_RESET) {
+		spin_unlock_bh(&priv->reg_lock);
 		return;
+	}
 	if (enable)
 		reg |= mask;
 	else
 		reg &= ~mask;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 
 	/* UniMAC stops on a packet boundary, wait for a full-size packet
 	 * to be processed
@@ -2490,8 +2494,10 @@ static void reset_umac(struct bcmgenet_priv *priv)
 	udelay(10);
 
 	/* issue soft reset and disable MAC while updating its registers */
+	spin_lock_bh(&priv->reg_lock);
 	bcmgenet_umac_writel(priv, CMD_SW_RESET, UMAC_CMD);
 	udelay(2);
+	spin_unlock_bh(&priv->reg_lock);
 }
 
 static void bcmgenet_intr_disable(struct bcmgenet_priv *priv)
@@ -3597,16 +3603,19 @@ static void bcmgenet_set_rx_mode(struct net_device *dev)
 	 * 3. The number of filters needed exceeds the number filters
 	 *    supported by the hardware.
 	*/
+	spin_lock(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	if ((dev->flags & (IFF_PROMISC | IFF_ALLMULTI)) ||
 	    (nfilter > MAX_MDF_FILTER)) {
 		reg |= CMD_PROMISC;
 		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+		spin_unlock(&priv->reg_lock);
 		bcmgenet_umac_writel(priv, 0, UMAC_MDF_CTRL);
 		return;
 	} else {
 		reg &= ~CMD_PROMISC;
 		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+		spin_unlock(&priv->reg_lock);
 	}
 
 	/* update MDF filter */
@@ -4005,6 +4014,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	spin_lock_init(&priv->reg_lock);
 	spin_lock_init(&priv->lock);
 
 	/* Set default pause parameters */
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 7523b60b3c1c..43b923c48b14 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2014-2020 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #ifndef __BCMGENET_H__
@@ -573,6 +573,8 @@ struct bcmgenet_rxnfc_rule {
 /* device context */
 struct bcmgenet_priv {
 	void __iomem *base;
+	/* reg_lock: lock to serialize access to shared registers */
+	spinlock_t reg_lock;
 	enum bcmgenet_version version;
 	struct net_device *dev;
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 7a41cad5788f..1248792d7fd4 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET (Gigabit Ethernet) Wake-on-LAN support
  *
- * Copyright (c) 2014-2020 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #define pr_fmt(fmt)				"bcmgenet_wol: " fmt
@@ -151,6 +151,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Can't suspend with WoL if MAC is still in reset */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	if (reg & CMD_SW_RESET)
 		reg &= ~CMD_SW_RESET;
@@ -158,6 +159,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	/* disable RX */
 	reg &= ~CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 	mdelay(10);
 
 	if (priv->wolopts & (WAKE_MAGIC | WAKE_MAGICSECURE)) {
@@ -203,6 +205,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Enable CRC forward */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	priv->crc_fwd_en = 1;
 	reg |= CMD_CRC_FWD;
@@ -210,6 +213,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	/* Receiver must be enabled for WOL MP detection */
 	reg |= CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 
 	reg = UMAC_IRQ_MPD_R;
 	if (hfb_enable)
@@ -256,7 +260,9 @@ void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Disable CRC Forward */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	reg &= ~CMD_CRC_FWD;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 }
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 86a4aa72b3d4..c4a3698cef66 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -76,6 +76,7 @@ static void bcmgenet_mac_config(struct net_device *dev)
 	reg |= RGMII_LINK;
 	bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
 
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	reg &= ~((CMD_SPEED_MASK << CMD_SPEED_SHIFT) |
 		       CMD_HD_EN |
@@ -88,6 +89,7 @@ static void bcmgenet_mac_config(struct net_device *dev)
 		reg |= CMD_TX_EN | CMD_RX_EN;
 	}
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 
 	active = phy_init_eee(phydev, 0) >= 0;
 	bcmgenet_eee_enable_set(dev,


