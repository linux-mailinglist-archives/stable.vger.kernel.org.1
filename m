Return-Path: <stable+bounces-52177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 965689087E1
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417F01F2837C
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 09:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1996718413A;
	Fri, 14 Jun 2024 09:45:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DCE19149D
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358332; cv=none; b=fYDdbdDIiPWZQyYCpP71OSFBmMDh+D/E/rrRl+V3tzTmHRqKKNxcStfXrkFwbnTPgFkvvLeBelB99G4b8lvPNk70ibOJtJtKyTDFgdw+y4IIhZvDM6JlWBz1hKx2I3x2BO2UXTFqb4IazvuzWsqrjaKQjR/183Px+nnKTOdFZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358332; c=relaxed/simple;
	bh=UGXeGLWZTsXFSCEt0SvKoZJVAG3H9kZuD88qPQGsr9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h16+jytx6+GMIvHdBfsrPq+5jkloPgV0fHNMAZBTDnUwMA9pr40lgIjbWksrq0QOBawDmkuPntvETkU3TaNdng/ycfY4WkmP//d3+EokCwPONwEn6yXsGYTM6ysXb6BKuGbyRIb2yTECEeShqNP9o7qcRxeHLaIMwcMXkLghwz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sI3Ul-0000Su-E4; Fri, 14 Jun 2024 11:45:19 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sI3Uj-002Elw-Ox; Fri, 14 Jun 2024 11:45:17 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sI3Uj-006DOn-2E;
	Fri, 14 Jun 2024 11:45:17 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net v2 2/2] net: phy: dp83tg720: get master/slave configuration in link down state
Date: Fri, 14 Jun 2024 11:45:16 +0200
Message-Id: <20240614094516.1481231-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240614094516.1481231-1-o.rempel@pengutronix.de>
References: <20240614094516.1481231-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Get master/slave configuration for initial system start with the link in
down state. This ensures ethtool shows current configuration.  Also
fixes link reconfiguration with ethtool while in down state, preventing
ethtool from displaying outdated configuration.

Even though dp83tg720_config_init() is executed periodically as long as
the link is in admin up state but no carrier is detected, this is not
sufficient for the link in admin down state where
dp83tg720_read_status() is not periodically executed. To cover this
case, we need an extra read role configuration in
dp83tg720_config_aneg().

Fixes: cb80ee2f9bee1 ("net: phy: Add support for the DP83TG720S Ethernet PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- add genphy_c45_pma_baset1_read_master_slave() to .config_aneg
- add comments
---
 drivers/net/phy/dp83tg720.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 1186dfc70fb3c..c706429b225a2 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -36,11 +36,20 @@
 
 static int dp83tg720_config_aneg(struct phy_device *phydev)
 {
+	int ret;
+
 	/* Autoneg is not supported and this PHY supports only one speed.
 	 * We need to care only about master/slave configuration if it was
 	 * changed by user.
 	 */
-	return genphy_c45_pma_baset1_setup_master_slave(phydev);
+	ret = genphy_c45_pma_baset1_setup_master_slave(phydev);
+	if (ret)
+		return ret;
+
+	/* Re-read role configuration to make changes visible even if
+	 * the link is in administrative down state.
+	 */
+	return genphy_c45_pma_baset1_read_master_slave(phydev);
 }
 
 static int dp83tg720_read_status(struct phy_device *phydev)
@@ -69,6 +78,8 @@ static int dp83tg720_read_status(struct phy_device *phydev)
 			return ret;
 
 		/* After HW reset we need to restore master/slave configuration.
+		 * genphy_c45_pma_baset1_read_master_slave() call will be done
+		 * by the dp83tg720_config_aneg() function.
 		 */
 		ret = dp83tg720_config_aneg(phydev);
 		if (ret)
@@ -168,8 +179,15 @@ static int dp83tg720_config_init(struct phy_device *phydev)
 	/* In case the PHY is bootstrapped in managed mode, we need to
 	 * wake it.
 	 */
-	return phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_LPS_CFG3,
-			     DP83TG720S_LPS_CFG3_PWR_MODE_0);
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_LPS_CFG3,
+			    DP83TG720S_LPS_CFG3_PWR_MODE_0);
+	if (ret)
+		return ret;
+
+	/* Make role configuration visible for ethtool on init and after
+	 * rest.
+	 */
+	return genphy_c45_pma_baset1_read_master_slave(phydev);
 }
 
 static struct phy_driver dp83tg720_driver[] = {
-- 
2.39.2


