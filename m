Return-Path: <stable+bounces-136888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C7EA9F163
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 14:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D6A7A9B80
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF796266B67;
	Mon, 28 Apr 2025 12:51:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6319B3CB
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844696; cv=none; b=YI4V2dDwIJQNyfEb0Eya44SKGsSMk3TAPzHp2Qx0158HsRPkinSBQXPUtzAiYWLmJ4g2sCeEAacc0d3vEM79po4BdTT6QaVG9tXXCfGqXX4rp8iXA70osugVIpsa5eEOfKLgjAUk3vGoB+1yGklyIbyj1mZdvTI7+X3WTK0NXi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844696; c=relaxed/simple;
	bh=JIQwydwFWZlPN3ngN48yH8aK8cCEPw7Uxcw6j2JoWwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AbDO4olEIlPQXrIIzO9IZfqge2q3retP/FyqtkJr8q7dFNy7PdM9MHlwe+90eX7kbr9pQZ/DGX6XIHJTsqkKKMw8j5BRLhioTKxWbK0Mcre7FyTEnpsEvoZfr5p1va0xDXf4Nd8w6JNwDuzqYyOunMiGiIbawEYmGntrrDPWbPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u9NxD-0002iG-AH; Mon, 28 Apr 2025 14:51:23 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9NxB-00068G-2o;
	Mon, 28 Apr 2025 14:51:21 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9NxB-00EK9u-2Z;
	Mon, 28 Apr 2025 14:51:21 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net v1 1/2] net: dsa: microchip: let phylink manage PHY EEE configuration on KSZ switches
Date: Mon, 28 Apr 2025 14:51:18 +0200
Message-Id: <20250428125119.3414046-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428125119.3414046-1-o.rempel@pengutronix.de>
References: <20250428125119.3414046-1-o.rempel@pengutronix.de>
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

Phylink expects MAC drivers to provide LPI callbacks to properly manage
Energy Efficient Ethernet (EEE) configuration. On KSZ switches with
integrated PHYs, LPI is internally handled by hardware, while ports
without integrated PHYs have no documented MAC-level LPI support.

Provide dummy mac_disable_tx_lpi() and mac_enable_tx_lpi() callbacks to
satisfy phylink requirements. Also, set default EEE capabilities during
phylink initialization where applicable.

Since phylink can now gracefully handle optional EEE configuration,
remove the need for the MICREL_NO_EEE PHY flag.

This change addresses issues caused by incomplete EEE refactoring
introduced in commit fe0d4fd9285e ("net: phy: Keep track of EEE
configuration"). It is not easily possible to fix all older kernels, but
this patch ensures proper behavior on latest kernels and can be
considered for backporting to stable kernels starting from v6.14.

Fixes: fe0d4fd9285e ("net: phy: Keep track of EEE configuration")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: stable@vger.kernel.org # v6.14+
---
 drivers/net/dsa/microchip/ksz_common.c | 97 ++++++++++++++++++--------
 1 file changed, 69 insertions(+), 28 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b45052497f8a..f4b928e54c5b 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -265,16 +265,48 @@ static void ksz_phylink_mac_link_down(struct phylink_config *config,
 				      unsigned int mode,
 				      phy_interface_t interface);
 
+/**
+ * ksz_phylink_mac_disable_tx_lpi() - Dummy handler to disable TX LPI
+ * @config: phylink config structure
+ *
+ * For ports with integrated PHYs, LPI is managed internally by hardware.
+ * Ports without integrated PHYs do not document MAC-level LPI support.
+ * No software action is needed.
+ */
+static void ksz_phylink_mac_disable_tx_lpi(struct phylink_config *config)
+{
+}
+
+/**
+ * ksz_phylink_mac_enable_tx_lpi() - Dummy handler to enable TX LPI
+ * @config: phylink config structure
+ * @timer: timer value before entering LPI
+ * @tx_clock_stop: whether to stop the TX clock in LPI mode
+ *
+ * For ports with integrated PHYs, LPI is managed internally by hardware.
+ * Ports without integrated PHYs do not document MAC-level LPI support.
+ * Always return success.
+ */
+static int ksz_phylink_mac_enable_tx_lpi(struct phylink_config *config,
+					 u32 timer, bool tx_clock_stop)
+{
+	return 0;
+}
+
 static const struct phylink_mac_ops ksz88x3_phylink_mac_ops = {
 	.mac_config	= ksz88x3_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
 	.mac_link_up	= ksz8_phylink_mac_link_up,
+	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
 };
 
 static const struct phylink_mac_ops ksz8_phylink_mac_ops = {
 	.mac_config	= ksz_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
 	.mac_link_up	= ksz8_phylink_mac_link_up,
+	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
 };
 
 static const struct ksz_dev_ops ksz88xx_dev_ops = {
@@ -358,6 +390,8 @@ static const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
 	.mac_config	= ksz_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
 	.mac_link_up	= ksz9477_phylink_mac_link_up,
+	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
 };
 
 static const struct ksz_dev_ops ksz9477_dev_ops = {
@@ -401,6 +435,8 @@ static const struct phylink_mac_ops lan937x_phylink_mac_ops = {
 	.mac_config	= ksz_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
 	.mac_link_up	= ksz9477_phylink_mac_link_up,
+	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
 };
 
 static const struct ksz_dev_ops lan937x_dev_ops = {
@@ -2016,6 +2052,18 @@ static void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
 
 	if (dev->dev_ops->get_caps)
 		dev->dev_ops->get_caps(dev, port, config);
+
+	if (ds->ops->support_eee && ds->ops->support_eee(ds, port)) {
+		memcpy(config->lpi_interfaces, config->supported_interfaces,
+		       sizeof(config->lpi_interfaces));
+
+		config->lpi_capabilities = MAC_100FD;
+		if (dev->info->gbit_capable[port])
+			config->lpi_capabilities |= MAC_1000FD;
+
+		/* EEE is fully operational */
+		config->eee_enabled_default = true;
+	}
 }
 
 void ksz_r_mib_stats64(struct ksz_device *dev, int port)
@@ -3008,31 +3056,6 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
 		if (!port)
 			return MICREL_KSZ8_P1_ERRATA;
 		break;
-	case KSZ8567_CHIP_ID:
-		/* KSZ8567R Errata DS80000752C Module 4 */
-	case KSZ8765_CHIP_ID:
-	case KSZ8794_CHIP_ID:
-	case KSZ8795_CHIP_ID:
-		/* KSZ879x/KSZ877x/KSZ876x Errata DS80000687C Module 2 */
-	case KSZ9477_CHIP_ID:
-		/* KSZ9477S Errata DS80000754A Module 4 */
-	case KSZ9567_CHIP_ID:
-		/* KSZ9567S Errata DS80000756A Module 4 */
-	case KSZ9896_CHIP_ID:
-		/* KSZ9896C Errata DS80000757A Module 3 */
-	case KSZ9897_CHIP_ID:
-	case LAN9646_CHIP_ID:
-		/* KSZ9897R Errata DS80000758C Module 4 */
-		/* Energy Efficient Ethernet (EEE) feature select must be manually disabled
-		 *   The EEE feature is enabled by default, but it is not fully
-		 *   operational. It must be manually disabled through register
-		 *   controls. If not disabled, the PHY ports can auto-negotiate
-		 *   to enable EEE, and this feature can cause link drops when
-		 *   linked to another device supporting EEE.
-		 *
-		 * The same item appears in the errata for all switches above.
-		 */
-		return MICREL_NO_EEE;
 	}
 
 	return 0;
@@ -3475,15 +3498,33 @@ static bool ksz_support_eee(struct dsa_switch *ds, int port)
 
 	switch (dev->chip_id) {
 	case KSZ8563_CHIP_ID:
+	case KSZ9563_CHIP_ID:
+	case KSZ9893_CHIP_ID:
+		return true;
 	case KSZ8567_CHIP_ID:
+		/* KSZ8567R Errata DS80000752C Module 4 */
+	case KSZ8765_CHIP_ID:
+	case KSZ8794_CHIP_ID:
+	case KSZ8795_CHIP_ID:
+		/* KSZ879x/KSZ877x/KSZ876x Errata DS80000687C Module 2 */
 	case KSZ9477_CHIP_ID:
-	case KSZ9563_CHIP_ID:
+		/* KSZ9477S Errata DS80000754A Module 4 */
 	case KSZ9567_CHIP_ID:
-	case KSZ9893_CHIP_ID:
+		/* KSZ9567S Errata DS80000756A Module 4 */
 	case KSZ9896_CHIP_ID:
+		/* KSZ9896C Errata DS80000757A Module 3 */
 	case KSZ9897_CHIP_ID:
 	case LAN9646_CHIP_ID:
-		return true;
+		/* KSZ9897R Errata DS80000758C Module 4 */
+		/* Energy Efficient Ethernet (EEE) feature select must be manually disabled
+		 *   The EEE feature is enabled by default, but it is not fully
+		 *   operational. It must be manually disabled through register
+		 *   controls. If not disabled, the PHY ports can auto-negotiate
+		 *   to enable EEE, and this feature can cause link drops when
+		 *   linked to another device supporting EEE.
+		 *
+		 * The same item appears in the errata for all switches above.
+		 */
 	}
 
 	return false;
-- 
2.39.5


