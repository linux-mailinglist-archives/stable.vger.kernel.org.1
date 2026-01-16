Return-Path: <stable+bounces-209992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D72D2CCE3
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 07:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ED5B3024D53
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 06:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8159034EEE1;
	Fri, 16 Jan 2026 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="L4dt6LI9"
X-Original-To: stable@vger.kernel.org
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87B230C601
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546623; cv=none; b=VjEWtuBJL7e97a28cVnlgROIQ3O4LOBHCwnWClNkCgxMjO6hZDaY0QTPxSp6zU0IfarJ5O17hyMYCJK5x06z5R0R1Z/qZWwU5nMLNFEPyr2JO0J1B86UBQSvgCY3qr/oxNYUwwDPrfKDPLZFCt2sl5bhMjsl9dVulZ4oiVv0WSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546623; c=relaxed/simple;
	bh=XvR4D2Uwyn3QyBgTf/XgPA1a92+l+FC9kGW/mMIYmnA=;
	h=From:To:Subject:Date:Message-Id; b=i86fhqZMIFZimGkYUISy3YoekGovysKP33VNZG7u2EBOiX0UobKk8oSCAzQ5faq3Q3OJx2HUKH/yPAg/8mD5rWEEytsG0lUu34Wj7anCc3BT+KHv2ye2XAd523WDxMfv5neUAk+7cCI7W0/uLqPf+3Z8SOJYsmf67GosgOu20Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=L4dt6LI9; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=L4dt6LI9VZABehsi63Dhm8TocQQeLivU66kt61et+80LL3tFNDPhX5W3xZ94rhkX2ZywloXmwr+GH
	 n2GCWFROVSCAkDI9yt9bw9prTvxxGvlNyHAmH3ro6Ot3sVZdXqELJ1rJKrShPi6Hh2jVjhZW0equ3U
	 HcBb04cf0hdHReVs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[183.241.245.115])
	by rmsmtp-lg-appmail-40-12054 (RichMail) with SMTP id 2f166969e06f516-0c510;
	Fri, 16 Jan 2026 14:53:36 +0800 (CST)
X-RM-TRANSID:2f166969e06f516-0c510
From: Rajani Kantha <681739313@139.com>
To: vladimir.oltean@nxp.com,
	rmk+kernel@armlinux.org.uk,
	kuba@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y 1/3] net: phy: move phy_link_change() prior to mdio_bus_phy_may_suspend()
Date: Fri, 16 Jan 2026 14:53:32 +0800
Message-Id: <20260116065334.18180-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

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
[ Minor context change fixed ]
Signed-off-by: Rajani Kantha <681739313@139.com>
---
---
 drivers/net/phy/phy_device.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 875788918bcb..2c4af6f96390 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -268,6 +268,19 @@ static struct phy_driver genphy_driver;
 static LIST_HEAD(phy_fixup_list);
 static DEFINE_MUTEX(phy_fixup_lock);
 
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
@@ -1069,19 +1082,6 @@ struct phy_device *phy_find_first(struct mii_bus *bus)
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
2.34.1



