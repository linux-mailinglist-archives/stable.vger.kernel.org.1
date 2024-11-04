Return-Path: <stable+bounces-89603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F2E9BAE99
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 09:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32621F21085
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433301AB525;
	Mon,  4 Nov 2024 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AWgL7uxw"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE81494B1;
	Mon,  4 Nov 2024 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710369; cv=none; b=JpmVBYA3FZDRJPpfIHVGG3Ka9VhzjC45MkJNPLRZQDY0Z0hQKdS6rCoQPWWaO2m31tUx2bO6wlbtlT+DHe7BLtDvUyr1ly1QJW/JXZpoLAR0LtwIWNHVSKtzDPqy7jBn5d4crGfJhi3OuVPm94POoMwUODVZBgJA9eUYa4qgvK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710369; c=relaxed/simple;
	bh=funQs4EDoySiJq5gzNvq7YbPyZwqvugQA91BmnGPvoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BG6HijL9rlWYBpvp5WdVXl/+rfBLF5fQKKcik9joBfZqi5MxsQHPrCwKQtsfyNqiXp+EbG+BoBFw+8MfxtwY66h+S1t4KB5YNEw3mR/dF+LnYA454r4CAdq4nVcFcQVKgmer6KGRVgLrZW7BZTwXeZvPD511YVOXIn9zJzcSA1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AWgL7uxw; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 283BB1C0003;
	Mon,  4 Nov 2024 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730710358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s8mFq+jqyFYDthvaTeb5O0lvVCgm26reIbUNCvntJdU=;
	b=AWgL7uxwlMKi7FSWHbloGyVvKSn2hcX98NVRLl6ToKXcm7RUTCvHt7f/DgpiKey724Sseq
	qWmj/12sTOeOl33YnfirVopM8ZjBvbfNSKjnRsOHUphtsNEfqQ9j4J5UjKfI50mz/fHO1W
	qNgvJwBCzPqAF8ol2WES/SZh1KSzM+MSkYj2ON3EUA2kykkUcOPY/CXjUlXYYR/qDx8weR
	3DJy/BjHctB42XmuoyL5J8EBgSH/q/e5uTiAUsZCilcqBsfyrUg5afEBjrsvEQglNsn4dx
	grX+uXvp57h+sYLPw8agOH6LhzeIOEJYJ8tPQHKp3HgnRJOb10rG+byCAPcjwQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 04 Nov 2024 09:52:32 +0100
Subject: [PATCH net v2] net: phy: dp83869: fix status reporting for
 1000base-x autonegotiation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-dp83869-1000base-x-v2-1-f97e39a778bf@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAE+LKGcC/22NzQqDMBCEX0X23C2b+Bd76nsUD4luaqBNJBGxi
 O/eID32+M0w3+yQODpOcCt2iLy65ILPIC8FDJP2T0Y3ZgZJshIkaxxnVaqmQ0FERifGDcmSbkQ
 r61ZVkIdzZOu2U/oAzwv0OZxcWkL8nEerOKufs/vnXAUKtIO2XDZkxk7dTQjLy/nrEN7QH8fxB
 R3NsuW7AAAA
X-Change-ID: 20241025-dp83869-1000base-x-0f0a61725784
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Dan Murphy <dmurphy@ti.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: romain.gantois@bootlin.com

The DP83869 PHY transceiver supports converting from RGMII to 1000base-x.
In this operation mode, autonegotiation can be performed, as described in
IEEE802.3.

The DP83869 has a set of fiber-specific registers located at offset 0xc00.
When the transceiver is configured in RGMII-to-1000base-x mode, these
registers are mapped onto offset 0, which should, in theory, make reading
the autonegotiation status transparent.

However, the fiber registers at offset 0xc04 and 0xc05 do not follow the
bit layout of their standard counterparts. Thus, genphy_read_status()
doesn't properly read the capabilities advertised by the link partner,
resulting in incorrect link parameters.

Similarly, genphy_config_aneg() doesn't properly write advertised
capabilities.

Fix the 1000base-x autonegotiation procedure by replacing
genphy_read_status() and genphy_config_aneg() with driver-specific
functions which take into account the nonstandard bit layout of the DP83869
registers in 1000base-x mode.

Fixes: a29de52ba2a1 ("net: dp83869: Add ability to advertise Fiber connection")
Cc: stable@vger.kernel.org
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Changes in v2:
- Fixed an uninitialized use.
- Link to v1: https://lore.kernel.org/r/20241029-dp83869-1000base-x-v1-1-fcafe360bd98@bootlin.com
---
 drivers/net/phy/dp83869.c | 130 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 127 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 5f056d7db83eed23f1cab42365fdc566a0d8e47f..ca1c247d478ced890a3c7ae97b855f20056eb916 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -41,6 +41,8 @@
 #define DP83869_IO_MUX_CFG	0x0170
 #define DP83869_OP_MODE		0x01df
 #define DP83869_FX_CTRL		0x0c00
+#define DP83869_FX_ANADV        0x0c04
+#define DP83869_FX_LPABL        0x0c05
 
 #define DP83869_SW_RESET	BIT(15)
 #define DP83869_SW_RESTART	BIT(14)
@@ -135,6 +137,17 @@
 #define DP83869_DOWNSHIFT_4_COUNT	4
 #define DP83869_DOWNSHIFT_8_COUNT	8
 
+/* FX_ANADV bits */
+#define DP83869_BP_FULL_DUPLEX       BIT(5)
+#define DP83869_BP_PAUSE             BIT(7)
+#define DP83869_BP_ASYMMETRIC_PAUSE  BIT(8)
+
+/* FX_LPABL bits */
+#define DP83869_LPA_1000FULL   BIT(5)
+#define DP83869_LPA_PAUSE_CAP  BIT(7)
+#define DP83869_LPA_PAUSE_ASYM BIT(8)
+#define DP83869_LPA_LPACK      BIT(14)
+
 enum {
 	DP83869_PORT_MIRRORING_KEEP,
 	DP83869_PORT_MIRRORING_EN,
@@ -153,19 +166,129 @@ struct dp83869_private {
 	int mode;
 };
 
+static int dp83869_config_aneg(struct phy_device *phydev)
+{
+	struct dp83869_private *dp83869 = phydev->priv;
+	unsigned long *advertising;
+	int err, changed = false;
+	u32 adv = 0;
+
+	if (dp83869->mode != DP83869_RGMII_1000_BASE)
+		return genphy_config_aneg(phydev);
+
+	/* Forcing speed or duplex isn't supported in 1000base-x mode */
+	if (phydev->autoneg != AUTONEG_ENABLE)
+		return 0;
+
+	/* In fiber modes, register locations 0xc0... get mapped to offset 0.
+	 * Unfortunately, the fiber-specific autonegotiation advertisement
+	 * register at address 0xc04 does not have the same bit layout as the
+	 * corresponding standard MII_ADVERTISE register. Thus, functions such
+	 * as genphy_config_advert() will write the advertisement register
+	 * incorrectly.
+	 */
+	advertising = phydev->advertising;
+
+	/* Only allow advertising what this PHY supports */
+	linkmode_and(advertising, advertising,
+		     phydev->supported);
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, advertising))
+		adv |= DP83869_BP_FULL_DUPLEX;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT, advertising))
+		adv |= DP83869_BP_PAUSE;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, advertising))
+		adv |= DP83869_BP_ASYMMETRIC_PAUSE;
+
+	err = phy_modify_changed(phydev, DP83869_FX_ANADV,
+				 DP83869_BP_FULL_DUPLEX | DP83869_BP_PAUSE |
+				 DP83869_BP_ASYMMETRIC_PAUSE,
+				 adv);
+
+	if (err < 0)
+		return err;
+	else if (err)
+		changed = true;
+
+	return genphy_check_and_restart_aneg(phydev, changed);
+}
+
+static int dp83869_read_status_fiber(struct phy_device *phydev)
+{
+	int err, lpa, old_link = phydev->link;
+	unsigned long *lp_advertising;
+
+	err = genphy_update_link(phydev);
+	if (err)
+		return err;
+
+	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
+		return 0;
+
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+
+	lp_advertising = phydev->lp_advertising;
+
+	if (phydev->autoneg != AUTONEG_ENABLE) {
+		linkmode_zero(lp_advertising);
+
+		phydev->duplex = DUPLEX_FULL;
+		phydev->speed = SPEED_1000;
+
+		return 0;
+	}
+
+	if (!phydev->autoneg_complete) {
+		linkmode_zero(lp_advertising);
+		return 0;
+	}
+
+	/* In fiber modes, register locations 0xc0... get mapped to offset 0.
+	 * Unfortunately, the fiber-specific link partner capabilities register
+	 * at address 0xc05 does not have the same bit layout as the
+	 * corresponding standard MII_LPA register. Thus, functions such as
+	 * genphy_read_lpa() will read autonegotiation results incorrectly.
+	 */
+
+	lpa = phy_read(phydev, DP83869_FX_LPABL);
+	if (lpa < 0)
+		return lpa;
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+			 lp_advertising, lpa & DP83869_LPA_1000FULL);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT, lp_advertising,
+			 lpa & DP83869_LPA_PAUSE_CAP);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, lp_advertising,
+			 lpa & DP83869_LPA_PAUSE_ASYM);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+			 lp_advertising, lpa & DP83869_LPA_LPACK);
+
+	phy_resolve_aneg_linkmode(phydev);
+
+	return 0;
+}
+
 static int dp83869_read_status(struct phy_device *phydev)
 {
 	struct dp83869_private *dp83869 = phydev->priv;
 	int ret;
 
+	if (dp83869->mode == DP83869_RGMII_1000_BASE)
+		return dp83869_read_status_fiber(phydev);
+
 	ret = genphy_read_status(phydev);
 	if (ret)
 		return ret;
 
-	if (linkmode_test_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported)) {
+	if (dp83869->mode == DP83869_RGMII_100_BASE) {
 		if (phydev->link) {
-			if (dp83869->mode == DP83869_RGMII_100_BASE)
-				phydev->speed = SPEED_100;
+			phydev->speed = SPEED_100;
 		} else {
 			phydev->speed = SPEED_UNKNOWN;
 			phydev->duplex = DUPLEX_UNKNOWN;
@@ -898,6 +1021,7 @@ static int dp83869_phy_reset(struct phy_device *phydev)
 	.soft_reset	= dp83869_phy_reset,			\
 	.config_intr	= dp83869_config_intr,			\
 	.handle_interrupt = dp83869_handle_interrupt,		\
+	.config_aneg    = dp83869_config_aneg,                  \
 	.read_status	= dp83869_read_status,			\
 	.get_tunable	= dp83869_get_tunable,			\
 	.set_tunable	= dp83869_set_tunable,			\

---
base-commit: 5ccdcdf186aec6b9111845fd37e1757e9b413e2f
change-id: 20241025-dp83869-1000base-x-0f0a61725784

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


