Return-Path: <stable+bounces-83613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB37C99B863
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 07:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A24C282941
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E3584D0D;
	Sun, 13 Oct 2024 05:29:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60C83D6A
	for <stable@vger.kernel.org>; Sun, 13 Oct 2024 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728797381; cv=none; b=q0AXXHz6XIVV1G0u4VUgzr1wM6HBXsd09ROcrpMnRFtAeCv9K/o+Uh3wwcKavb/gw4rpfOOgPLq+F/q7LSxL6oXCGoRixmuEotzTkKI7kF+jcyNffyJh0D0TX1rSq4T+zuKzakuEcIrXluhNU8PbP08UJYXCJTkogZ4P1b8A5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728797381; c=relaxed/simple;
	bh=q04B0oSl6B/Lr1hoL1EbdP8rVFP1TuxT4h5lIQMuenk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BptpxvAxz2WpA1SjqykEndOELZ1/im5wOHywReRD9/PenEBr9KiAXOhJ4K2YvD5fRRtdU90UYtiXtUhzc7DaoVS/p94OViGvYV4CLP6o8FHGLTd7EtMuqmveMfd5gKBL703ROsQAvM5zGzcD+MsSQ+cgLfQESepoD/ziynWPb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1szrAP-0003RN-BY; Sun, 13 Oct 2024 07:29:21 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1szrAN-001U5I-Dx; Sun, 13 Oct 2024 07:29:19 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1szrAN-00D4Oc-1C;
	Sun, 13 Oct 2024 07:29:19 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH net v2 1/1] net: macb: Avoid 20s boot delay by skipping MDIO bus registration for fixed-link PHY
Date: Sun, 13 Oct 2024 07:29:16 +0200
Message-Id: <20241013052916.3115142-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

A boot delay was introduced by commit 79540d133ed6 ("net: macb: Fix
handling of fixed-link node"). This delay was caused by the call to
`mdiobus_register()` in cases where a fixed-link PHY was present. The
MDIO bus registration triggered unnecessary PHY address scans, leading
to a 20-second delay due to attempts to detect Clause 45 (C45)
compatible PHYs, despite no MDIO bus being attached.

The commit 79540d133ed6 ("net: macb: Fix handling of fixed-link node")
was originally introduced to fix a regression caused by commit
7897b071ac3b4 ("net: macb: convert to phylink"), which caused the driver
to misinterpret fixed-link nodes as PHY nodes. This resulted in warnings
like:
mdio_bus f0028000.ethernet-ffffffff: fixed-link has invalid PHY address
mdio_bus f0028000.ethernet-ffffffff: scan phy fixed-link at address 0
...
mdio_bus f0028000.ethernet-ffffffff: scan phy fixed-link at address 31

This patch reworks the logic to avoid registering and allocation of the
MDIO bus when:
  - The device tree contains a fixed-link node.
  - There is no "mdio" child node in the device tree.

If a child node named "mdio" exists, the MDIO bus will be registered to
support PHYs  attached to the MACB's MDIO bus. Otherwise, with only a
fixed-link, the MDIO bus is skipped.

Tested on a sama5d35 based system with a ksz8863 switch attached to
macb0.

Fixes: 79540d133ed6 ("net: macb: Fix handling of fixed-link node")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: stable@vger.kernel.org
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
changes v2:
- s/some PHYs may be attached/some devices may be attached/
---
 drivers/net/ethernet/cadence/macb_main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f06babec04a0b..56901280ba047 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -930,9 +930,6 @@ static int macb_mdiobus_register(struct macb *bp)
 		return ret;
 	}
 
-	if (of_phy_is_fixed_link(np))
-		return mdiobus_register(bp->mii_bus);
-
 	/* Only create the PHY from the device tree if at least one PHY is
 	 * described. Otherwise scan the entire MDIO bus. We do this to support
 	 * old device tree that did not follow the best practices and did not
@@ -953,8 +950,19 @@ static int macb_mdiobus_register(struct macb *bp)
 
 static int macb_mii_init(struct macb *bp)
 {
+	struct device_node *child, *np = bp->pdev->dev.of_node;
 	int err = -ENXIO;
 
+	/* With fixed-link, we don't need to register the MDIO bus,
+	 * except if we have a child named "mdio" in the device tree.
+	 * In that case, some devices may be attached to the MACB's MDIO bus.
+	 */
+	child = of_get_child_by_name(np, "mdio");
+	if (child)
+		of_node_put(child);
+	else if (of_phy_is_fixed_link(np))
+		return macb_mii_probe(bp->dev);
+
 	/* Enable management port */
 	macb_writel(bp, NCR, MACB_BIT(MPE));
 
-- 
2.39.5


