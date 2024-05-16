Return-Path: <stable+bounces-45350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0305C8C7ED7
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 01:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE773282494
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 23:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F024D9F5;
	Thu, 16 May 2024 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJnh9Qi+"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225134087F;
	Thu, 16 May 2024 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715900530; cv=none; b=HnXvag32n5SEx+SU981AQ2sngt+9vtb+B8ohRqA/YyGf13QyQUUMosw3iOeg0NlPHcYBFPOQROsYRWMRWWuAxDluJiXCGo9qzxYRT/UGz4E6pnjzlvJ5D2DlJ6zLED3V3PAaWUFUu102mpbBJQD564T4V4oJHrTIxKqkiJGkkDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715900530; c=relaxed/simple;
	bh=a7SEqQDNz97OSHhoT4UBY69oGPl9v7HBaYUzz/5xOiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TUa85L6T8Hs7I7FXM70rhb4S9raK9/bt+GG9QX19/dvDNRf/exYxG0i49VnNDuPNwb/i+p4+9COI9h75D8EIpj3E/hG+g0+0bH7NzjBJDCDD9Y9ANB7PJU+YXdalUWUqdgd3OIWkJJjqpp1G4p5CZttNhj888rCS3rTZIbUWgtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJnh9Qi+; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b2e942171cso448749eaf.3;
        Thu, 16 May 2024 16:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715900527; x=1716505327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoeHJzNVkB54yDBVnMDfuwpD4ZrJsaFqixROui8d5X0=;
        b=LJnh9Qi+rMKRe3Ku+wZJtk6L1+wj2Zg+sgT04SPuJtUNhiJnQvV5irgYMevM1VzBE7
         dly6SHCXD1ZIT5cQVeCk8/P/dEYDQN7jVJRdZZh30gwvFOBOUc6uLMebQRAKxESZCUnM
         I4p604/hMkXKBbLGEsM8x5Om3r1H0gaNv/YNBHr14IfbgREOaYxFt54GIb4NJhTiQMV5
         I27GQOnh6yMfVkAkLKw0k2yZ2tn/7itZp99GhI92DqknLX+Vlux3F/74t5pZyt9zN6vD
         fjIWEzm4GeOvK/j1sOmTWcBvVRw3HmWMkTJHQkq1TGgXKID+Cf43BeFgkmd/oHdyR07j
         dz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715900527; x=1716505327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoeHJzNVkB54yDBVnMDfuwpD4ZrJsaFqixROui8d5X0=;
        b=h9DWA/v7OZyzQJGSG6gzVc6ObsKnAPN2uDJBQrBewWH74Cf1qmPcpO0S/JlwnkX0gT
         MADETJKiMBZUk0jZBwH9CIhVsSj/GOOceOZaw2l1TTURGFUG4b8wUESDbFct+zLSpFL3
         QYKwle7q9Up0V6y2mddBGDJWzE4K7XPBk1IbeKWIfcUjjwHBfaEKjm4NRtWjQhCZUs6R
         4IfqdhsDqdbJMn8frS3U5d2TvjCL5Sl3Lfl4jdZ3jf3FSJxBdS26leXiTFuf5UV0ziBa
         CUAX9hZdn0ABvZrHoMmZitOC8xFmi63dSXF3QWgT6cSzX2Zv49/aezqbJV5HYEhwmDHR
         8y1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTpFUj+7o8L1w35ZZmfmuowyzxbHCPTHgBJfBMKV5G7vLJLS/N9isNtj9ha+fba0ShMFgOmGYmIm4vn5MkWgpPpr/8dRR0nk8OFObHyZmHyWvqjLKYyi1cCxwsf72MwMSXvg4a
X-Gm-Message-State: AOJu0YzZFnHfPgWkWsk9mNr9KFYMNrMh70+9Pb3KffSwJPSWMFAY5fWN
	QD6QFoZtF6Az3WwQe2ihVnry1W4kMCKFcoHZ66NGaBtoE0W8pz6XcP9DOg==
X-Google-Smtp-Source: AGHT+IGyHb0zSCOVAfsCt9H6tPVqdxfL0VPhf0pPA7lbucNTv3brCKOa5YPLYQnuJpsOWCiH/E2I6g==
X-Received: by 2002:a05:6358:98a5:b0:194:81b4:e96 with SMTP id e5c5f4694b2df-19481b412c2mr848089255d.30.1715900527178;
        Thu, 16 May 2024 16:02:07 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e251233c6sm47154851cf.84.2024.05.16.16.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 16:02:06 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: stable@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH stable 5.4 3/3] net: bcmgenet: synchronize UMAC_CMD access
Date: Thu, 16 May 2024 16:01:51 -0700
Message-Id: <20240516230151.1031190-4-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516230151.1031190-1-opendmb@gmail.com>
References: <20240516230151.1031190-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 0d5e2a82232605b337972fb2c7d0cbc46898aca1 ]

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
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 12 +++++++++++-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |  2 ++
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |  6 ++++++
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |  2 ++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index e34df8da65e7..da9df1d3662b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1990,14 +1990,18 @@ static void umac_enable_set(struct bcmgenet_priv *priv, u32 mask, bool enable)
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
@@ -2013,8 +2017,10 @@ static void reset_umac(struct bcmgenet_priv *priv)
 	udelay(10);
 
 	/* issue soft reset and disable MAC while updating its registers */
+	spin_lock_bh(&priv->reg_lock);
 	bcmgenet_umac_writel(priv, CMD_SW_RESET, UMAC_CMD);
 	udelay(2);
+	spin_unlock_bh(&priv->reg_lock);
 }
 
 static void bcmgenet_intr_disable(struct bcmgenet_priv *priv)
@@ -3140,16 +3146,19 @@ static void bcmgenet_set_rx_mode(struct net_device *dev)
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
@@ -3507,6 +3516,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	spin_lock_init(&priv->reg_lock);
 	spin_lock_init(&priv->lock);
 
 	SET_NETDEV_DEV(dev, &pdev->dev);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 29bf256d13f6..9efc503a9c8b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -608,6 +608,8 @@ struct bcmgenet_rx_ring {
 /* device context */
 struct bcmgenet_priv {
 	void __iomem *base;
+	/* reg_lock: lock to serialize access to shared registers */
+	spinlock_t reg_lock;
 	enum bcmgenet_version version;
 	struct net_device *dev;
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 8ebca6bf300e..973275d116b6 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -133,6 +133,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Can't suspend with WoL if MAC is still in reset */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	if (reg & CMD_SW_RESET)
 		reg &= ~CMD_SW_RESET;
@@ -140,6 +141,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	/* disable RX */
 	reg &= ~CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 	mdelay(10);
 
 	reg = bcmgenet_umac_readl(priv, UMAC_MPD_CTRL);
@@ -163,6 +165,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 		  retries);
 
 	/* Enable CRC forward */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	priv->crc_fwd_en = 1;
 	reg |= CMD_CRC_FWD;
@@ -170,6 +173,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	/* Receiver must be enabled for WOL MP detection */
 	reg |= CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 
 	return 0;
 }
@@ -191,8 +195,10 @@ void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	bcmgenet_umac_writel(priv, reg, UMAC_MPD_CTRL);
 
 	/* Disable CRC Forward */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	reg &= ~CMD_CRC_FWD;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 	priv->crc_fwd_en = 0;
 }
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index d0b59d1f6c73..bd532e5b9f73 100644
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


