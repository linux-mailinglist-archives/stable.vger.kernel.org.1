Return-Path: <stable+bounces-52091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A370907B55
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 20:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09C2285591
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB6114A4ED;
	Thu, 13 Jun 2024 18:30:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC7E130AC8
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303458; cv=none; b=ATuba37+0cI+L7LT0jQEQABBTbecEoQrs/PSr7fi+vIrVl2Od1oaKTnELOocDmylNnirJkc2SZ0F9NGlfWbpfd/y++im+dSG/q3rHeCfpTGmIGXpgfWC8DGBIVkgxmRVotwkI82KR6EQSXCt11FO3kl/+3mw8awiJ8iVIBRQ80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303458; c=relaxed/simple;
	bh=L+BkJHJ93ZoZnAv3yF+VnHGw4NT9HnFM5BeOcKm1xfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HakuSNYkJ3h4stEIoAvmQOYklYyR6u6XYmGvhblgYOFWl89pZJde47vtH7DUKg498XVmBr0SGbYullwuRZtBRjkgLQ/VlwwcYQ5t7GeG+SZH5voBpvLgLILpsjZUfOuksxOxbXLXfJzE3hVzctuU6Kn/c2K2ZeKkXiHNgpxowJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sHpDZ-0003UU-7p; Thu, 13 Jun 2024 20:30:37 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sHpDX-0025Xj-TO; Thu, 13 Jun 2024 20:30:35 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sHpDX-00A6Nn-2i;
	Thu, 13 Jun 2024 20:30:35 +0200
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
Subject: [PATCH net v1 1/2] net: phy: dp83tg720: wake up PHYs in managed mode
Date: Thu, 13 Jun 2024 20:30:33 +0200
Message-Id: <20240613183034.2407798-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

In case this PHY is bootstrapped for managed mode, we need to manually
wake it. Otherwise no link will be detected.

Cc: stable@vger.kernel.org
Fixes: cb80ee2f9bee1 ("net: phy: Add support for the DP83TG720S Ethernet PHY")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/dp83tg720.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 326c9770a6dcc..1186dfc70fb3c 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -17,6 +17,11 @@
 #define DP83TG720S_PHY_RESET			0x1f
 #define DP83TG720S_HW_RESET			BIT(15)
 
+#define DP83TG720S_LPS_CFG3			0x18c
+/* Power modes are documented as bit fields but used as values */
+/* Power Mode 0 is Normal mode */
+#define DP83TG720S_LPS_CFG3_PWR_MODE_0		BIT(0)
+
 #define DP83TG720S_RGMII_DELAY_CTRL		0x602
 /* In RGMII mode, Enable or disable the internal delay for RXD */
 #define DP83TG720S_RGMII_RX_CLK_SEL		BIT(1)
@@ -154,10 +159,17 @@ static int dp83tg720_config_init(struct phy_device *phydev)
 	 */
 	usleep_range(1000, 2000);
 
-	if (phy_interface_is_rgmii(phydev))
-		return dp83tg720_config_rgmii_delay(phydev);
+	if (phy_interface_is_rgmii(phydev)) {
+		ret = dp83tg720_config_rgmii_delay(phydev);
+		if (ret)
+			return ret;
+	}
 
-	return 0;
+	/* In case the PHY is bootstrapped in managed mode, we need to
+	 * wake it.
+	 */
+	return phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_LPS_CFG3,
+			     DP83TG720S_LPS_CFG3_PWR_MODE_0);
 }
 
 static struct phy_driver dp83tg720_driver[] = {
-- 
2.39.2


