Return-Path: <stable+bounces-162011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D99B05B22
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD9D565401
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC351A23AF;
	Tue, 15 Jul 2025 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mcSls/be"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E9719066B;
	Tue, 15 Jul 2025 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585436; cv=none; b=cHswg6CsrmBSnXtGcvvEs6Hp7/KwqY1d0e2N6Zlf1z/Qb0b+SgMEaIO9WdRKtUFEp1LkQ56qw+lv0wLYffJy9ICziZRdzIRhPrncsRporrbV+0mYzNlBtX+cXQwCJfPnVES00rADgbHWYSLQLcufinisYm4pgs15lZBaxt+e9xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585436; c=relaxed/simple;
	bh=r2Xify7KcBT7fhCJja23KzRmBN805OJT7diY/cNAtBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0nOKbQ72d1O3Hrz/E+RSbZIVUvNjfg4ida2xAd2s8izAdwnxPH0c8xxwX+zoSoFOD/voWykG0j+ovjpaG9pvM7bSzCHSMS6rxtEe0bCfHXHwczsA4cD/ya1pOc5Jd5ITa7GaiX9zcF4sJNbxs0KmSC/j50PI/6O5Hl80BgGlIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mcSls/be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99B8C4CEE3;
	Tue, 15 Jul 2025 13:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585436;
	bh=r2Xify7KcBT7fhCJja23KzRmBN805OJT7diY/cNAtBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcSls/bemUMuQl/Hifa22aoJPc0KvdWsyHAZLOXAhNPaziyMNLDF3NNaPs1PkuEPf
	 cv18rx+XORPRZr8wMWRA0HbHIakL6pc2KA8hJDjOviugfR3BgMFCtJN5WX3SVpxZdI
	 DDY8IBY/iHqCYCemLKQezfsQ0RBPb3g/LENZHo0o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andre Edich <andre.edich@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 039/163] net: phy: smsc: Fix link failure in forced mode with Auto-MDIX
Date: Tue, 15 Jul 2025 15:11:47 +0200
Message-ID: <20250715130810.325016728@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 9dfe110cc0f6ef42af8e81ce52aef34a647d0b8a ]

Force a fixed MDI-X mode when auto-negotiation is disabled to prevent
link instability.

When forcing the link speed and duplex on a LAN9500 PHY (e.g., with
`ethtool -s eth0 autoneg off ...`) while leaving MDI-X control in auto
mode, the PHY fails to establish a stable link. This occurs because the
PHY's Auto-MDIX algorithm is not designed to operate when
auto-negotiation is disabled. In this state, the PHY continuously
toggles the TX/RX signal pairs, which prevents the link partner from
synchronizing.

This patch resolves the issue by detecting when auto-negotiation is
disabled. If the MDI-X control mode is set to 'auto', the driver now
forces a specific, stable mode (ETH_TP_MDI) to prevent the pair
toggling. This choice of a fixed MDI mode mirrors the behavior the
hardware would exhibit if the AUTOMDIX_EN strap were configured for a
fixed MDI connection.

Fixes: 05b35e7eb9a1 ("smsc95xx: add phylib support")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andre Edich <andre.edich@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250703114941.3243890-4-o.rempel@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/smsc.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 09fbc30bfd3d0..6a43f6d6e85cb 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -155,10 +155,29 @@ static int smsc_phy_reset(struct phy_device *phydev)
 
 static int lan87xx_config_aneg(struct phy_device *phydev)
 {
-	int rc;
+	u8 mdix_ctrl;
 	int val;
+	int rc;
+
+	/* When auto-negotiation is disabled (forced mode), the PHY's
+	 * Auto-MDIX will continue toggling the TX/RX pairs.
+	 *
+	 * To establish a stable link, we must select a fixed MDI mode.
+	 * If the user has not specified a fixed MDI mode (i.e., mdix_ctrl is
+	 * 'auto'), we default to ETH_TP_MDI. This choice of a ETH_TP_MDI mode
+	 * mirrors the behavior the hardware would exhibit if the AUTOMDIX_EN
+	 * strap were configured for a fixed MDI connection.
+	 */
+	if (phydev->autoneg == AUTONEG_DISABLE) {
+		if (phydev->mdix_ctrl == ETH_TP_MDI_AUTO)
+			mdix_ctrl = ETH_TP_MDI;
+		else
+			mdix_ctrl = phydev->mdix_ctrl;
+	} else {
+		mdix_ctrl = phydev->mdix_ctrl;
+	}
 
-	switch (phydev->mdix_ctrl) {
+	switch (mdix_ctrl) {
 	case ETH_TP_MDI:
 		val = SPECIAL_CTRL_STS_OVRRD_AMDIX_;
 		break;
@@ -184,7 +203,7 @@ static int lan87xx_config_aneg(struct phy_device *phydev)
 	rc |= val;
 	phy_write(phydev, SPECIAL_CTRL_STS, rc);
 
-	phydev->mdix = phydev->mdix_ctrl;
+	phydev->mdix = mdix_ctrl;
 	return genphy_config_aneg(phydev);
 }
 
-- 
2.39.5




