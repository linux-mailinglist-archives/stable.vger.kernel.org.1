Return-Path: <stable+bounces-209990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF837D2CCDD
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 07:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74F2C302BAAD
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 06:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16DA34EF16;
	Fri, 16 Jan 2026 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="4bMfva21"
X-Original-To: stable@vger.kernel.org
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5C034DB56
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546619; cv=none; b=SchKKE+Hhx3qiLVuiX8BWSlZOFpeatWNlcDyCY+kWwhvVYHv5WnkDINZHdSC5QED48Q88txjq70RUHMvBYrt/q9zOiJDv93qiV+CakELeNy74N2csrTU8mhQWHkgZpDVEo4BbmYNZCI27q8jbXz1kk+UV9k0EmSVP1rALlkpNK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546619; c=relaxed/simple;
	bh=kLNnltjS5FnDXvFsZLh8Q/YzTwkmVbX12vj/udstN8c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=TuZ2rozuZvDgvezTuB97H9R4MN8n1mDRfhtRM5QopxiKRoWALuLRJhLGjHFThbdpGBjzW+0jnGG8rqVREIyDvcr03RazV49sqy8CNt3Kdtv1SeiauySC4EvGIFaJfgCu2U8GCm6LZGjxfXO5zpFTn8pAnlNZiDrfuhcVOrHOdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=4bMfva21; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=4bMfva216uRDiTZ/uILoZBobYBvGcWaDzk7JEAg0YUwIMxSC3/YTeaNXp9wGaZCWsn/dHwj8Tly8P
	 e/lUH97+FyfxyuTLCFL8HSlWHLT+yzb4cOQ83tvuVIYtjrTYvbd8haQ6E/x3XHL0I+QgT8bCRAuW3z
	 QEeDIcbrVOsthT0E=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[183.241.245.115])
	by rmsmtp-lg-appmail-40-12054 (RichMail) with SMTP id 2f166969e06f516-0c517;
	Fri, 16 Jan 2026 14:53:37 +0800 (CST)
X-RM-TRANSID:2f166969e06f516-0c517
From: Rajani Kantha <681739313@139.com>
To: vladimir.oltean@nxp.com,
	rmk+kernel@armlinux.org.uk,
	kuba@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y 3/3] net: phy: fix phy_uses_state_machine()
Date: Fri, 16 Jan 2026 14:53:34 +0800
Message-Id: <20260116065334.18180-3-681739313@139.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260116065334.18180-1-681739313@139.com>
References: <20260116065334.18180-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

[ Upstream commit e0d1c55501d377163eb57feed863777ed1c973ad ]

The blamed commit changed the conditions which phylib uses to stop
and start the state machine in the suspend and resume paths, and
while improving it, has caused two issues.

The original code used this test:

	phydev->attached_dev && phydev->adjust_link

and if true, the paths would handle the PHY state machine. This test
evaluates true for normal drivers that are using phylib directly
while the PHY is attached to the network device, but false in all
other cases, which include the following cases:

- when the PHY has never been attached to a network device.
- when the PHY has been detached from a network device (as phy_detach()
   sets phydev->attached_dev to NULL, phy_disconnect() calls
   phy_detach() and additionally sets phydev->adjust_link NULL.)
- when phylink is using the driver (as phydev->adjust_link is NULL.)

Only the third case was incorrect, and the blamed commit attempted to
fix this by changing this test to (simplified for brevity, see
phy_uses_state_machine()):

	phydev->phy_link_change == phy_link_change ?
		phydev->attached_dev && phydev->adjust_link : true

However, this also incorrectly evaluates true in the first two cases.

Fix the first case by ensuring that phy_uses_state_machine() returns
false when phydev->phy_link_change is NULL.

Fix the second case by ensuring that phydev->phy_link_change is set to
NULL when phy_detach() is called.

Reported-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://lore.kernel.org/r/20250806082931.3289134-1-xu.yang_2@nxp.com
Fixes: fc75ea20ffb4 ("net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/E1uvMEz-00000003Aoe-3qWe@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 drivers/net/phy/phy_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 59f0f3a534e4..3dd59376a89e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -304,8 +304,7 @@ static bool phy_uses_state_machine(struct phy_device *phydev)
 	if (phydev->phy_link_change == phy_link_change)
 		return phydev->attached_dev && phydev->adjust_link;
 
-	/* phydev->phy_link_change is implicitly phylink_phy_change() */
-	return true;
+	return !!phydev->phy_link_change;
 }
 
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
@@ -1853,6 +1852,8 @@ void phy_detach(struct phy_device *phydev)
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
 	}
+
+	phydev->phy_link_change = NULL;
 	phydev->phylink = NULL;
 
 	if (!phydev->is_on_sfp_module)
-- 
2.34.1



