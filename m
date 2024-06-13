Return-Path: <stable+bounces-52092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C72F907B58
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 20:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38ECF1C238C5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AC314A0AD;
	Thu, 13 Jun 2024 18:31:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A9E26AF0
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303460; cv=none; b=GhlpfapnWBpcfQ13DdJMBJ4NwVBBPWDqAw/noCiswUSwCd/UM/jxS9d6J960otd5OPfTGTmJQdc2B1QUhhXOqYe+2/OoVXZE1GH+lpDBWsz75eCCWxtKHKtLupRPVhXUh7ix7Ur0J7YKjiFvmnLvkFtFjwdhc3OGVs0X/Us5tOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303460; c=relaxed/simple;
	bh=0e+G3kQB6Uq5qxJSceMPJhaKZk0F5S/1gS0TWqkhT+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M1J06fl4jbtBhO14ns56XE3D3JQ/k2cNp2Zb5gbeVkCsiDvrUYNFttJYdYmdsAjHTyC+9zHTbTN4NMZJJiqNpTA0mgT6krSxZWkWEWtca+zYtcApFRQE3ewLbCgDmfcMb9hgLKjf7CmL70Al/RdFCtkgO+TlEl0bE99YFQ1p5Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sHpDZ-0003UW-7p; Thu, 13 Jun 2024 20:30:37 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sHpDX-0025Xk-UN; Thu, 13 Jun 2024 20:30:35 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sHpDX-00A6Nx-2p;
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
Subject: [PATCH net v1 2/2] net: phy: dp83tg720: get initial master/slave configuration
Date: Thu, 13 Jun 2024 20:30:34 +0200
Message-Id: <20240613183034.2407798-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613183034.2407798-1-o.rempel@pengutronix.de>
References: <20240613183034.2407798-1-o.rempel@pengutronix.de>
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

Get initial master/slave configuration, otherwise ethtool
wont be able to provide this information until link is
established. This makes troubleshooting harder, since wrong
role configuration would prevent the link start.

Fixes: cb80ee2f9bee1 ("net: phy: Add support for the DP83TG720S Ethernet PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/dp83tg720.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 1186dfc70fb3c..84256827a03bf 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -168,8 +168,12 @@ static int dp83tg720_config_init(struct phy_device *phydev)
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
+	return genphy_c45_pma_baset1_read_master_slave(phydev);
 }
 
 static struct phy_driver dp83tg720_driver[] = {
-- 
2.39.2


