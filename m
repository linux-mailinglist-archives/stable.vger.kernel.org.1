Return-Path: <stable+bounces-92791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0619C59E5
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 15:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED851F24588
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DB41FBF6E;
	Tue, 12 Nov 2024 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rl0XCa7e"
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA581F9EDE;
	Tue, 12 Nov 2024 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420377; cv=none; b=S0tRQe1vfVqTx9rQTfqimAjcUpjEnvo/wfUU8g29pOdiqitYs9g/WNH9fB3mWKlIn3KjLtCJGqtjqKHVMM0b/9zXCsMzV4U3KU6Wuy8fJp38kF335MFseRDG/4MOOp7PioFSlWqbSlvVAVDWJEWEk/2d894asB0P2aA8mdzzU7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420377; c=relaxed/simple;
	bh=oVsMU3QmHZ+sJijB8fbDvpdSD5+M7ndL9P1tPmn4pJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=if8u99nsNDsfkD+8CsD+I5Dbf4UOfyIXWxDgKVtb4wKmCuQ3UQhXb/0WRRAoRPMTkQxfpWO6QrHjl+R3WkBS29KFVnJ+Z1RhpB8b52vgY20JntfcDJ8N05Xef/oaQsySpYGGI9E+Nv9gIfkeY6SRPQkY0I5Mexi2IxNVDMsHTRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rl0XCa7e; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66E994000F;
	Tue, 12 Nov 2024 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731420372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KV24EEa2szz4nlZ+Kb2p6Idt2RnaoZ6yTZvKtgvN9BI=;
	b=Rl0XCa7eNMPPdXnPUdOSa4I+w4m4XXC2sA6xQ4X0hiM1sKZvt+s1TB5CkVP03NN6lXccU1
	9YdxnHkI6UVuYH0kwN2pKVLfSpCb9fxyAE9jcCb+OgTWWG2KZGYX6clI8lop54dTHCWZyi
	SUq59vq5VleDTmYXAFFUQ5WZglHipQl99KxTgPt2k94oqoPKepOfTZA1wUjPi1DJcYFiFE
	CJK3sLfs2tEZPH0Wgk0svEWb38pNOPhWdvkArfBzbKYrAt0BgnPrj3BcMN4ggOZJd/5mQl
	QYP96xhXVsS/k/EWck66hb8ivvNeVJa9okeOlirZ+6TMdaV+LyTYDoqqhCfsBQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 12 Nov 2024 15:06:08 +0100
Subject: [PATCH net v3] net: phy: dp83869: fix status reporting for
 1000base-x autonegotiation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-dp83869-1000base-x-v3-1-36005f4ab0d9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAM9gM2cC/23N0QrCIBQG4FcJrzOOuk3tqveILnQ7NqF06BiLs
 XdvSRDBLv/zc75/IRmTx0zOh4UknHz2MWxBHA+k7U24I/XdlgkHXjHgNe0GJVSjKQMAazLSmYI
 D0zDJa6kqsj0OCZ2fC3olAUdy2469z2NMrzI0sVJ9Tb1nTowy6lrjUDRgO60uNsbx4cOpjc8CT
 vyHMKh2Ef5BtEShjZTKun9kXdc3p7CauwABAAA=
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
registers are mapped onto offset 0, which should make reading the
autonegotiation status transparent.

However, the fiber registers at offset 0xc04 and 0xc05 follow the bit
layout specified in Clause 37, and genphy_read_status() assumes a Clause 22
layout. Thus, genphy_read_status() doesn't properly read the capabilities
advertised by the link partner, resulting in incorrect link parameters.

Similarly, genphy_config_aneg() doesn't properly write advertised
capabilities.

Fix the 1000base-x autonegotiation procedure by replacing
genphy_read_status() and genphy_config_aneg() with their Clause 37
equivalents.

Fixes: a29de52ba2a1 ("net: dp83869: Add ability to advertise Fiber connection")
Cc: stable@vger.kernel.org
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Changes in v3:
- Used the genphy_c37 helpers instead of custom logic
- Link to v2: https://lore.kernel.org/r/20241104-dp83869-1000base-x-v2-1-f97e39a778bf@bootlin.com

Changes in v2:
- Fixed an uninitialized use.
- Link to v1: https://lore.kernel.org/r/20241029-dp83869-1000base-x-v1-1-fcafe360bd98@bootlin.com
---
 drivers/net/phy/dp83869.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 5f056d7db83eed23f1cab42365fdc566a0d8e47f..b6b38caf9c0ed0b3ae12a2af7e56754e3ece642f 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -153,19 +153,32 @@ struct dp83869_private {
 	int mode;
 };
 
+static int dp83869_config_aneg(struct phy_device *phydev)
+{
+	struct dp83869_private *dp83869 = phydev->priv;
+
+	if (dp83869->mode != DP83869_RGMII_1000_BASE)
+		return genphy_config_aneg(phydev);
+
+	return genphy_c37_config_aneg(phydev);
+}
+
 static int dp83869_read_status(struct phy_device *phydev)
 {
 	struct dp83869_private *dp83869 = phydev->priv;
+	bool changed;
 	int ret;
 
+	if (dp83869->mode == DP83869_RGMII_1000_BASE)
+		return genphy_c37_read_status(phydev, &changed);
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
@@ -898,6 +911,7 @@ static int dp83869_phy_reset(struct phy_device *phydev)
 	.soft_reset	= dp83869_phy_reset,			\
 	.config_intr	= dp83869_config_intr,			\
 	.handle_interrupt = dp83869_handle_interrupt,		\
+	.config_aneg    = dp83869_config_aneg,                  \
 	.read_status	= dp83869_read_status,			\
 	.get_tunable	= dp83869_get_tunable,			\
 	.set_tunable	= dp83869_set_tunable,			\

---
base-commit: 20bbe5b802494444791beaf2c6b9597fcc67ff49
change-id: 20241025-dp83869-1000base-x-0f0a61725784

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


