Return-Path: <stable+bounces-41477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4638B2CE6
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 00:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613831F20D4A
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 22:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01A9159584;
	Thu, 25 Apr 2024 22:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn/VQGlM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3A158D93;
	Thu, 25 Apr 2024 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083023; cv=none; b=emtMtPdM8HFz/1XtBbPbOHahxjnjPOKLq7Ok3/I+bTEEsZjfYWrpBTQ6m44OCNnCAoY6MJC7zQDV6qT8jL4pKniZRvyrk8CyUO038mAR0CMNLMqDjmG7/yWdgbVBtv2/DFLS/BTu0W2q4PdZCmbAhqdaMH6RCutYtcdBfnrjKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083023; c=relaxed/simple;
	bh=TIHi716ql6W7JkAg87hK+/NlxNNTNr3j5+ozLhVFT40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pzo3XNTfK/Z9jClwwi/3SsIbzKSPas+C8/pkTgVf/VNy5Si6jZ/kUWNH9ponyA2+39sunTTTXuIHagqko7WQegXw1YhOm6bZ1IIWM9KQICBPCOqsFgipaoUcKDzvHwPKqOtwX4EUzE7vbXhLuxqRexFlgbWiEh44vL6jQDf+BCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn/VQGlM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f074520c8cso1644566b3a.0;
        Thu, 25 Apr 2024 15:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714083021; x=1714687821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OvkLf2eq0KdJa5mTu/U97lc17pEWUvnY93iweSl7Ps=;
        b=hn/VQGlMjm5DhXxc2PxSqUWptGEzcSeGStGWR6xZnXfiuYbtNml/wJqPWa5JrHq4Tt
         gUXGb56SaJEdz7yxNuceNWNqxP+T1aa4BmTES1Bv+TTpWhVvHoDM6M0z5p/49tQRk7RZ
         ZDCpG3dgCVVcDMxoK8oKNNXIMYvkaXfQ0Ac5dGRFbB2Jc11aOosjc91u6WekARHdWOgf
         0cQkfGDu6SQGHBhsejiPiCQ7uAe1Tla0nTQdJeuV4Bsi/Ojb3fejFxU3u2aDw8/1xRbZ
         LWkwEA0nJeLpD9D8Hjyanl3Abw8ZNRW/Lxmd6TT0RQwNzljtbGpcYrq/QoSA03EeklPZ
         P2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714083021; x=1714687821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OvkLf2eq0KdJa5mTu/U97lc17pEWUvnY93iweSl7Ps=;
        b=mh2vUUpzlfWIa3Ch2s/Lyq+a6H7vQmhnzDdDoCQc8Iqa+7K/Vxb+jFfGx1jF/2w+et
         BhUclAAy9mtDosf42sNUFBsASPQyaDwQkUveNkrr8xLzT1J4MYE0UWOFwNoYYd1/5Zxw
         +waiDlVjMey8AK5kRcjuwXpC0bhayKNJd8TUhPeeSr1uuHnJr7dkiu3nsmJhHJNZboz6
         5A+WUO2MYqqcNX4zwxQ9A43BYfgyqLLmhXNfHFCb4WpaRweSnznm9jJM6t7151J7nURC
         8xzXGcGAr+hAN2lu7NhXSMIsiGAg8cgF0v2X+j6Ye1p0hU9i/9ZO1oqhNxAUJve3yspK
         rXJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/0bqd75mVM617glci95rcxFGiDy5MwKnGZtWrLO9Vf9n8erL6IAh90UMOlGVy4sdvafDmblYwa0NxKmii6IwGUKVW2aVH
X-Gm-Message-State: AOJu0YyT5sZExJ3AFTE7TurrO7nyw+PybSBsyqRzaMg/ETVtI2sj5Dch
	7oxCo8lZyYykWrEeLqIZVeNUZlYDHcKLIeEP67/nNeeHi4DPV9Ov3D0uoQ==
X-Google-Smtp-Source: AGHT+IGHHq8qdM765zzSQ9zu35dD9Rheqz/01TMI1wYC/TBFEHgpO4Pilq0nBBvxkGJedBmv9b75IQ==
X-Received: by 2002:a05:6a20:c707:b0:1a7:84e8:8037 with SMTP id hi7-20020a056a20c70700b001a784e88037mr1223947pzb.41.1714083020835;
        Thu, 25 Apr 2024 15:10:20 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a4a0500b002a269828bb8sm13394766pjh.40.2024.04.25.15.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:10:19 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] net: bcmgenet: synchronize UMAC_CMD access
Date: Thu, 25 Apr 2024 15:10:07 -0700
Message-Id: <20240425221007.2140041-4-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425221007.2140041-1-opendmb@gmail.com>
References: <20240425221007.2140041-1-opendmb@gmail.com>
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
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 12 +++++++++++-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |  4 +++-
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |  8 +++++++-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |  2 ++
 4 files changed, 23 insertions(+), 3 deletions(-)

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
-- 
2.34.1


