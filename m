Return-Path: <stable+bounces-45344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF468C7E74
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 00:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168A61F22084
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 22:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9327B158215;
	Thu, 16 May 2024 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YokpLdzs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57851A2C39
	for <stable@vger.kernel.org>; Thu, 16 May 2024 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897259; cv=none; b=dbO+Y4/Ph2B5Y62w1Ss9d/QvFyCXxm+AuOnSm6r+YH1nGTS9YEH/IXYwAgBHbeeadxDelC2PmWd0V8yS+IpqkaETSHUTsC412qIX5m3PqULHwlgCnfHR6CbavOegDcqvgOhIdWSbJeuvrEY9tBFReoPQAjuE1t3Mg/JRjed93Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897259; c=relaxed/simple;
	bh=8+OJPOvaTrvEKuTXlXlM63uDAwN6D5hd1s0jUHnhoS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQckL+kGjdq4jqhLdrYiOlTA+ocsXh6Zl3+UR6QMqC7vcwmlRslUF7ui96f2V7msbx6CBOLGKsh0fNPmRQs8vG574gqxUIvJINL19hIfJ0+P1p2Dre5VbBQ37PDqDpfUqse3ud/XPXK9nDUIvH+QJzJ3ETvaSZdZnnLH6n2y9yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YokpLdzs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f67c6fc504so672520b3a.1
        for <stable@vger.kernel.org>; Thu, 16 May 2024 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715897256; x=1716502056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC01bDMxPIwsErYDno16RDH0urRn6OVXvCsEmO+MpWY=;
        b=YokpLdzsT+E3G2kDgJajPLNHRkZvm7q5yhemeChmCwK1kWa8DQFYWmTWVS9jCZQ8CU
         GVzZjsHzxcAivk/pnK5epYTeKASoJC0gHFdwky3U1fFF4PzdlRqCSxL1NYoisMYdCYZS
         fMH46vZsA6nyswIiQppfhs45Hq//eDpWFSjF8jeOEBLUX3IOWW1LzL0tAWyw4IjakMFx
         eZdUe7cw2kFmRxt3QmW+V9Jowjm0iLOrCOWBJVnBcuFpXaPvMWUJoFQQgoY3qFBb4eEI
         zhLdatM8d1YGgmgcvm/3+XzVa2Qvdeex2jwLNOqjtFFSfJEY2KiuEzAM+0SW/xehMrMV
         v6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715897256; x=1716502056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pC01bDMxPIwsErYDno16RDH0urRn6OVXvCsEmO+MpWY=;
        b=ja0iaccq4xDU/dTV024dl2MiE/ry7U9l+xf6D9jOgT/LIHpgIcP0XdDL0oPX8KVLvL
         JBxqkIno1TtJVysUuVQG8F9ddftrzIWOVuatMjlnRmvV4AtJIMUgsdZ5Vv+FZjgNbXMD
         O2KA7dx9/09xplC7slmKBCBbkLTSrGVfx7y5LjNfLl+EzF/tT/eGujoywz/Ljg3b3RLl
         o7M4oVfUeR2LAJEWGWFvRNv3QrWR9sD1+5noKE5wdnVoESCuS70UdN9YAfNP2bG1ZRR9
         2Xn24HJYmU/+wHSwAcL4x2aKQxlcdpaXdQBfeypKDkzcQAGxw1RlwbrLuhy/3N8noakr
         4syw==
X-Gm-Message-State: AOJu0YzDSLlNnT3jQhzRPQmh5P6WsLALMOiVE+DNSc0zgAsVUeIKEp7M
	ecn498fllT5ZhYAJJ/XQYTC4rjQroWQTi+FjEuEvgTWxNJ3kZMe5JrdshQ==
X-Google-Smtp-Source: AGHT+IGoD/UlW39HWW53dsBUYCiG5iVL+JydXjpb4lpXFWnZb2DPDENb7RUXJE73IucJa0uxjLor9w==
X-Received: by 2002:a05:6a00:98b:b0:6f3:854c:d2d with SMTP id d2e1a72fcca58-6f4e02ab564mr22271638b3a.9.1715897256272;
        Thu, 16 May 2024 15:07:36 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4f2f0b6absm10463539b3a.76.2024.05.16.15.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 15:07:35 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: stable@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.15.y] net: bcmgenet: synchronize UMAC_CMD access
Date: Thu, 16 May 2024 15:07:25 -0700
Message-Id: <20240516220725.458444-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024051352-twins-rumor-dcc9@gregkh>
References: <2024051352-twins-rumor-dcc9@gregkh>
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
index a2b736a9d20c..0cfb00feb607 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2424,14 +2424,18 @@ static void umac_enable_set(struct bcmgenet_priv *priv, u32 mask, bool enable)
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
@@ -2447,8 +2451,10 @@ static void reset_umac(struct bcmgenet_priv *priv)
 	udelay(10);
 
 	/* issue soft reset and disable MAC while updating its registers */
+	spin_lock_bh(&priv->reg_lock);
 	bcmgenet_umac_writel(priv, CMD_SW_RESET, UMAC_CMD);
 	udelay(2);
+	spin_unlock_bh(&priv->reg_lock);
 }
 
 static void bcmgenet_intr_disable(struct bcmgenet_priv *priv)
@@ -3566,16 +3572,19 @@ static void bcmgenet_set_rx_mode(struct net_device *dev)
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
@@ -3969,6 +3978,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	spin_lock_init(&priv->reg_lock);
 	spin_lock_init(&priv->lock);
 
 	SET_NETDEV_DEV(dev, &pdev->dev);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 0eeb304a4263..34a3c448d44f 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -572,6 +572,8 @@ struct bcmgenet_rxnfc_rule {
 /* device context */
 struct bcmgenet_priv {
 	void __iomem *base;
+	/* reg_lock: lock to serialize access to shared registers */
+	spinlock_t reg_lock;
 	enum bcmgenet_version version;
 	struct net_device *dev;
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index f55d9d9c01a8..38d41028e98a 100644
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
 
 	if (priv->wolopts & (WAKE_MAGIC | WAKE_MAGICSECURE)) {
@@ -185,6 +187,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Enable CRC forward */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	priv->crc_fwd_en = 1;
 	reg |= CMD_CRC_FWD;
@@ -192,6 +195,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	/* Receiver must be enabled for WOL MP detection */
 	reg |= CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 
 	reg = UMAC_IRQ_MPD_R;
 	if (hfb_enable)
@@ -238,7 +242,9 @@ void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Disable CRC Forward */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	reg &= ~CMD_CRC_FWD;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 }
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 6d823c107476..8c743e67d9f3 100644
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


