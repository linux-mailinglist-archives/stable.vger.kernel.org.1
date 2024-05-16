Return-Path: <stable+bounces-45346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C7C8C7E7A
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 00:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DE71C2113E
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 22:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F29158216;
	Thu, 16 May 2024 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwZZB00l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98FB15820E
	for <stable@vger.kernel.org>; Thu, 16 May 2024 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897456; cv=none; b=Hix0Kp7Lzho+XCAA5CoBY3rFW/QIMbtwpYQ4f7OQ4hK7kApV8k67B5gWtAP+ZWMbb/2wZxaNt8gIGcwY2RJhQWF4b3f+S0gE+s0ndAnaT8m6gPCsihnoHNsO45idRRLfnLaULoSxthZoDf/0ePF6YrvcT17Xj5gMzLrOYOoKhu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897456; c=relaxed/simple;
	bh=6HYfxx+in3W6SiBHerCtcxCVYmeBq5G623Tbf/2Nrc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d6LDzKYEKAQhZvB61T8qlONpo/YhIUNl2X6It4o6fQ2faHNfmgEjhbEm+5uZ9ORxF80Itd4YmmVRjXEiyxLE1SlE8RdaWvDFaQu2l+Y7EjtYY2muagPS4aVFGnBaEcjeIrd2BVssvh4QNVLSVdrpXTFWADCYBIKMarirtLC7Evg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwZZB00l; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b3f5fcecc1so609527a91.1
        for <stable@vger.kernel.org>; Thu, 16 May 2024 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715897453; x=1716502253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWU9oer8w3CYsIdirQ7y7OZA1rx5Ghnmt+0lgyNxhm4=;
        b=FwZZB00lBDp4JBBjhx7bS1ktf91/EGw4uo0jLVe5p3wNPM6CaXqCjm+ffTwHA8YlXV
         WK9hzVxV1hoVGzCC+C3NmfW+7Ukv8IWCruIv8/EL0D3OQ5BMgUcrXm4yMXcdjbFGoTc+
         BVAuX9sYavxjSJjnaHLSu4f/Xe2+Xt7ekwQX0Xawp0XD1O6pDVY9ZgdycBSBR0SMykTO
         EtiIkpSh/1CfAzu+RRha7OW5oImwf4lxA2lZxQ+FSOucHvBtDfbI8g3SPb5yY5OBlRF8
         0r1TNXdst2lEAS9lww8yjNafcFZhE6vC/rIHyWW4R+QejXMkIS7X9AHXCiOvjok8pqCQ
         zjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715897453; x=1716502253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWU9oer8w3CYsIdirQ7y7OZA1rx5Ghnmt+0lgyNxhm4=;
        b=QgJ915ty+xkHjcWAtWLhUtELpKgpafXyMdugKROL7oWlEunopuYR4WTPBZkijJ+cDa
         tQyJ1PNrBUVFKdDo5W8GgCH+ibEdtF9HYRnXawkFcgWLw2xg8vhS3NXHrxWcZV9G3q46
         xbv7CFgOHSoi/Z6mtKqUJG0FNvI+eA+IBBMtVNM8XpUbrGyoO9hVCyof+Ng65s7K3tFE
         MW358M2GNPYeTcJlBDT/Lf/UH1Hyse2/BcyGJ3NNHoAfDT//ym99dWf7mV5v4FATOMCK
         A+BXp6SC/K9OMQjPqIH5cvYGIM18s88pmC9ZYNtRGRpT8HCDkjRcayXRADqgjEUBeIlg
         L5pA==
X-Gm-Message-State: AOJu0YwZ97JdlyJx5oDrFyoJDWWrtheWvNc63qGpnXdcNt8Nn5R4d+yQ
	L69xUhpZ648UvPGZHf0BxqdfI8uckTxhE3dPBGCk1u62f+Rmpf/jflc4lQ==
X-Google-Smtp-Source: AGHT+IFvTmmWr3tIB6mhnCn4+peypHwZbH7zGPqecXhSEr1QpNdAQvbeGtbS6T0N/2y+nv718s/WoA==
X-Received: by 2002:a17:90a:d34f:b0:2b4:3669:65f0 with SMTP id 98e67ed59e1d1-2b6cc342aefmr17731611a91.6.1715897453207;
        Thu, 16 May 2024 15:10:53 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b671056613sm15656290a91.4.2024.05.16.15.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 15:10:52 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: stable@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.10.y] net: bcmgenet: synchronize UMAC_CMD access
Date: Thu, 16 May 2024 15:10:43 -0700
Message-Id: <20240516221043.458878-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024051356-partly-sizzle-f63e@gregkh>
References: <2024051356-partly-sizzle-f63e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 0d5e2a82232605b337972fb2c7d0cbc46898aca1)
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 12 +++++++++++-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |  2 ++
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |  6 ++++++
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |  2 ++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index ed0589a1a00d..f5d691328a47 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2420,14 +2420,18 @@ static void umac_enable_set(struct bcmgenet_priv *priv, u32 mask, bool enable)
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
@@ -2443,8 +2447,10 @@ static void reset_umac(struct bcmgenet_priv *priv)
 	udelay(10);
 
 	/* issue soft reset and disable MAC while updating its registers */
+	spin_lock_bh(&priv->reg_lock);
 	bcmgenet_umac_writel(priv, CMD_SW_RESET, UMAC_CMD);
 	udelay(2);
+	spin_unlock_bh(&priv->reg_lock);
 }
 
 static void bcmgenet_intr_disable(struct bcmgenet_priv *priv)
@@ -3562,16 +3568,19 @@ static void bcmgenet_set_rx_mode(struct net_device *dev)
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
@@ -3965,6 +3974,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	spin_lock_init(&priv->reg_lock);
 	spin_lock_init(&priv->lock);
 
 	SET_NETDEV_DEV(dev, &pdev->dev);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index c7853d5304b0..82f9fdf59103 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -627,6 +627,8 @@ struct bcmgenet_rxnfc_rule {
 /* device context */
 struct bcmgenet_priv {
 	void __iomem *base;
+	/* reg_lock: lock to serialize access to shared registers */
+	spinlock_t reg_lock;
 	enum bcmgenet_version version;
 	struct net_device *dev;
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 2c2a56d5a0a1..35c12938cb34 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -134,6 +134,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Can't suspend with WoL if MAC is still in reset */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	if (reg & CMD_SW_RESET)
 		reg &= ~CMD_SW_RESET;
@@ -141,6 +142,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	/* disable RX */
 	reg &= ~CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 	mdelay(10);
 
 	if (priv->wolopts & (WAKE_MAGIC | WAKE_MAGICSECURE)) {
@@ -186,6 +188,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Enable CRC forward */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	priv->crc_fwd_en = 1;
 	reg |= CMD_CRC_FWD;
@@ -193,6 +196,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	/* Receiver must be enabled for WOL MP detection */
 	reg |= CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 
 	reg = UMAC_IRQ_MPD_R;
 	if (hfb_enable)
@@ -239,7 +243,9 @@ void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Disable CRC Forward */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	reg &= ~CMD_CRC_FWD;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 }
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 7c56f76bad11..1e07f57ff3ed 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -91,6 +91,7 @@ void bcmgenet_mii_setup(struct net_device *dev)
 		reg |= RGMII_LINK;
 		bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
 
+		spin_lock_bh(&priv->reg_lock);
 		reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 		reg &= ~((CMD_SPEED_MASK << CMD_SPEED_SHIFT) |
 			       CMD_HD_EN |
@@ -103,6 +104,7 @@ void bcmgenet_mii_setup(struct net_device *dev)
 			reg |= CMD_TX_EN | CMD_RX_EN;
 		}
 		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+		spin_unlock_bh(&priv->reg_lock);
 
 		priv->eee.eee_active = phy_init_eee(phydev, 0) >= 0;
 		bcmgenet_eee_enable_set(dev,
-- 
2.34.1


