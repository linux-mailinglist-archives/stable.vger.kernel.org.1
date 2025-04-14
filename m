Return-Path: <stable+bounces-132486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 945BEA88278
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1372517074C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFE2288CB2;
	Mon, 14 Apr 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTcBVBFi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24A288C84;
	Mon, 14 Apr 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637244; cv=none; b=pCP0p4ogyJKAsgqN5DSkszlLW7HvkIf3fG4Mx9G6j4CIB19wf4tjjMdHadFiz2aFlf/Nn/+RpocNCGwkwyyVONH4+0R0ZD7Yt9K/noyIikCpZ108oYTlqBC/ZV12qJR0N/Ym05+WNqsI03kODACZRR6DAV8yBBVfejkDeQ247/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637244; c=relaxed/simple;
	bh=fRGAxV68X4onkf5NErdfadhUqGkajt9H7jP8vKjhjQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYu9BJiMttaHQT2IKnvphvgkSnklB9YPQmcunNxwPdh48+oJM5Gju8ZBf08Y9xj8SJmtkP/PLAOaqS92p2gJsaXajJ5U0rt0TXVliK4x5xUsqiVM7Li+OX2ANp2+UFhp1BabEYrRS2Q9xWwRjeKBK8ChSI8WPtMqrDKUdhdoBgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTcBVBFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9D0C4CEEB;
	Mon, 14 Apr 2025 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637244;
	bh=fRGAxV68X4onkf5NErdfadhUqGkajt9H7jP8vKjhjQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTcBVBFiEeogZ4RmucJkf5xyEqB55tlk96pCQaCzg59QLwjOvdHEIbW/1XowQ/bgP
	 DKhoj4he6GOEn0BcfWp6c7KSMLB0lTvuwTgrNVK/ixYWCN9VRXgQ1eCEibILMWZbSw
	 Cz4NLz0l1ST7ORwVQkNfFzxGr7I0AIt5Zcx1c0dF7wMfr4gWwsoWvlT57mPiBi+z5v
	 Xh5aWWc80zydukNo9ER671NnqKgXOOrEOZ4zublIbYy2COjSUEpgNSznHiIT2DQwDJ
	 UltvdF+19og8wFuzfND2BcPS1bOONXW0GF8k7Uk9bAR0R/F7ZJL9OTyRe5riTV24Dw
	 RdoKHxslPjKfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 32/34] net: phy: move phy_link_change() prior to mdio_bus_phy_may_suspend()
Date: Mon, 14 Apr 2025 09:26:08 -0400
Message-Id: <20250414132610.677644-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit f40a673d6b4a128fe95dd9b8c3ed02da50a6a862 ]

In an upcoming change, mdio_bus_phy_may_suspend() will need to
distinguish a phylib-based PHY client from a phylink PHY client.
For that, it will need to compare the phydev->phy_link_change() function
pointer with the eponymous phy_link_change() provided by phylib.

To avoid forward function declarations, the default PHY link state
change method should be moved upwards. There is no functional change
associated with this patch, it is only to reduce the noise from a real
bug fix.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/20250407093900.2155112-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 46713d27412b7..27d61d95933fa 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -240,6 +240,19 @@ static bool phy_drv_wol_enabled(struct phy_device *phydev)
 	return wol.wolopts != 0;
 }
 
+static void phy_link_change(struct phy_device *phydev, bool up)
+{
+	struct net_device *netdev = phydev->attached_dev;
+
+	if (up)
+		netif_carrier_on(netdev);
+	else
+		netif_carrier_off(netdev);
+	phydev->adjust_link(netdev);
+	if (phydev->mii_ts && phydev->mii_ts->link_state)
+		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
+}
+
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 {
 	struct device_driver *drv = phydev->mdio.dev.driver;
@@ -1052,19 +1065,6 @@ struct phy_device *phy_find_first(struct mii_bus *bus)
 }
 EXPORT_SYMBOL(phy_find_first);
 
-static void phy_link_change(struct phy_device *phydev, bool up)
-{
-	struct net_device *netdev = phydev->attached_dev;
-
-	if (up)
-		netif_carrier_on(netdev);
-	else
-		netif_carrier_off(netdev);
-	phydev->adjust_link(netdev);
-	if (phydev->mii_ts && phydev->mii_ts->link_state)
-		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
-}
-
 /**
  * phy_prepare_link - prepares the PHY layer to monitor link status
  * @phydev: target phy_device struct
-- 
2.39.5


