Return-Path: <stable+bounces-45203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA468C6B34
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8611A285684
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74171433BC;
	Wed, 15 May 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z0ljuulf"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAC538DE9;
	Wed, 15 May 2024 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792559; cv=none; b=dioqOpNGHk44Rx/qSinDj+Zpo5cN+bK9NKjLi2tZbFrajw3hja6LCN6WFVl8ND9+YqJu3dbJ9i8lE/mSaixl9dm4WE5pfHD1+PP8qSwFPAT0kDlprHaym2dLImPTfU7ZxsOAjLyraUlRFGgey+CdnDsYEYbS9LY54b+xjhJtZ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792559; c=relaxed/simple;
	bh=2Tc7RFgzcujFClj8kGho6fcze61Gb7T5bodb8xzwE7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+7xIpZCAbg19XftGi5FpT1ECGwq2DhPa8+ZsUX0yGVW7/6B8eKSu0LynTwBLcCM2NYwE2m6sP5/gs3agxIihZ7Cz4jlzKs0vt0nxALUvJqUvffljAj6i4hlRmOoFVtryRxFA51vdz71hpIj1/P5ZNiccwUNZ16hbKKtWSRFv0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z0ljuulf; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3BC9AC0000ED;
	Wed, 15 May 2024 10:02:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3BC9AC0000ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1715792551;
	bh=2Tc7RFgzcujFClj8kGho6fcze61Gb7T5bodb8xzwE7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0ljuulfzYoQ5xR3itHXkjkY7xrBW1vIVxWpuho4oi8HoKFl6emAA6ceGUnX6tb44
	 I/lra+qIwzBKJNNUjjg92kGsKRKcDXCX4Q8VHR7M1LjNaSJ1kQ+C5R2Hdscz1xrnue
	 4OMVOHKKcR8NmlwvMYlN8SD/74jZk6pYg7aNWe5U=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 34FC618041CAC6;
	Wed, 15 May 2024 10:02:29 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: broonie@kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:BROADCOM GENET ETHERNET DRIVER),
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH stable 6.1 1/4] net: bcmgenet: Clear RGMII_LINK upon link down
Date: Wed, 15 May 2024 10:02:24 -0700
Message-Id: <20240515170227.1679927-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515170227.1679927-1-florian.fainelli@broadcom.com>
References: <d52e7e4a-2b60-4fdf-9006-12528a91dabf@broadcom.com>
 <20240515170227.1679927-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

commit 696450c05181559a35d4d5bee55c465b1ac6fe2e upstream

Clear the RGMII_LINK bit upon detecting link down to be consistent with
setting the bit upon link up. We also move the clearing of the
out-of-band disable to the runtime initialization rather than for each
link up/down transition.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20221118213754.1383364-1-f.fainelli@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 1779ee524dac..cc3afb605b1e 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -72,7 +72,6 @@ static void bcmgenet_mac_config(struct net_device *dev)
 	 * Receive clock is provided by the PHY.
 	 */
 	reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
-	reg &= ~OOB_DISABLE;
 	reg |= RGMII_LINK;
 	bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
 
@@ -100,10 +99,18 @@ static void bcmgenet_mac_config(struct net_device *dev)
  */
 void bcmgenet_mii_setup(struct net_device *dev)
 {
+	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct phy_device *phydev = dev->phydev;
+	u32 reg;
 
-	if (phydev->link)
+	if (phydev->link) {
 		bcmgenet_mac_config(dev);
+	} else {
+		reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
+		reg &= ~RGMII_LINK;
+		bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
+	}
+
 	phy_print_status(phydev);
 }
 
@@ -264,18 +271,20 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 			(priv->phy_interface != PHY_INTERFACE_MODE_MOCA);
 
 	/* This is an external PHY (xMII), so we need to enable the RGMII
-	 * block for the interface to work
+	 * block for the interface to work, unconditionally clear the
+	 * Out-of-band disable since we do not need it.
 	 */
+	reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
+	reg &= ~OOB_DISABLE;
 	if (priv->ext_phy) {
-		reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
 		reg &= ~ID_MODE_DIS;
 		reg |= id_mode_dis;
 		if (GENET_IS_V1(priv) || GENET_IS_V2(priv) || GENET_IS_V3(priv))
 			reg |= RGMII_MODE_EN_V123;
 		else
 			reg |= RGMII_MODE_EN;
-		bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
 	}
+	bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
 
 	if (init)
 		dev_info(kdev, "configuring instance for %s\n", phy_name);
-- 
2.34.1


