Return-Path: <stable+bounces-55911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494D9919EAF
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 07:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCDA1B24A4B
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 05:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D56D1C2AD;
	Thu, 27 Jun 2024 05:34:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6BB28DA5
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 05:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719466451; cv=none; b=SHbpksBH/2O3Bn6it69egw9398HRcfIw/dgMzLmnYhekaqU4OPDUATrx6MtJwG0N9KeNSA48Eta3qu6Y+KQ3C6ulvyYyHIrYL2hDCIe/ofw5rIAu/7Kl6V+P843k9XfqRBqXANph3nT/yDoN8IsG3BsYjGju8vavBvrHP6VmC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719466451; c=relaxed/simple;
	bh=LYJA4gHG3laUJKh3RirWz+ba19Ae9E87C/vzol79nZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O34aqZfnEBDX8T+HBs2YbtYEVQi/pRuRW/RWglu41GOc8KumQRt/fR/NXgFdaFjXkNTwN48YWkWBgQQirkpy8lPk8++ferQhz8LCcvy0EuCPUJ/gLwTRMBG5aPqslU3wy4qHxLJ7Adxh6O2GM3JRcM4Xxh0DpPFZJ5nm0XrSdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sMhlc-0004LN-AL; Thu, 27 Jun 2024 07:33:56 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sMhla-005IHZ-CJ; Thu, 27 Jun 2024 07:33:54 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sMhla-005wRX-12;
	Thu, 27 Jun 2024 07:33:54 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH net v1 1/1] net: phy: micrel: ksz8081: disable broadcast only if PHY address is not 0
Date: Thu, 27 Jun 2024 07:33:53 +0200
Message-Id: <20240627053353.1416261-1-o.rempel@pengutronix.de>
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

Do not disable broadcast if we are using address 0 (broadcast) to
communicate with this device. Otherwise we will use proper driver but no
communication will be possible and no link changes will be detected.
There are two scenarios where we can run in to this situation:
- PHY is bootstrapped for address 0
- no PHY address is known and linux is scanning the MDIO bus, so first
  respond and attached device will be on address 0.

The fixes tag points to the latest refactoring, not to the initial point
where kszphy_broadcast_disable() was introduced.

Fixes: 79e498a9c7da0 ("net: phy: micrel: Restore led_mode and clk_sel on resume")
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/micrel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 81c20eb4b54b9..67c2e611150d2 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -590,7 +590,7 @@ static int kszphy_config_init(struct phy_device *phydev)
 
 	type = priv->type;
 
-	if (type && type->has_broadcast_disable)
+	if (type && type->has_broadcast_disable && phydev->mdio.addr != 0)
 		kszphy_broadcast_disable(phydev);
 
 	if (type && type->has_nand_tree_disable)
-- 
2.39.2


