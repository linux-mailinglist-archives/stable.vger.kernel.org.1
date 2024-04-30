Return-Path: <stable+bounces-42327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620348B7275
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18495283291
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62711E50A;
	Tue, 30 Apr 2024 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ocMgRiP+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D012C490;
	Tue, 30 Apr 2024 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475300; cv=none; b=hNIq/dox0Rr2x1QlfTZU45VKO/3eB4VbHDqBf9NZoLzu1ldm1kjGm4uGc+K5912nC65tqVOj3IG1jzZ3h82Qs/tsP1E8My4Eb9/nzJO4rZjSnuc1VlKrKb68/SSQ5i9/6URTZTrGLz3UeahTqdCW+C5iCWiIkBCxjZtwsWIPc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475300; c=relaxed/simple;
	bh=lS7jRbLCWGirW7s/7qvOmQq7eCYl7T6ZyUQ18yx6Eqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCkMhRjM1kVE6ttdlzWHCEh2Mi+fcUEqwEUcMVW9BdmKSUbfO6dh0pLn865o7mTrufe7jKAz8POIHvhAp80zGzykCKZabFSIm4x++L+FN9eJEB9t81eWtt4ADseQBmr5QUMZmLrIQmcVfyYqTlnC8WX9cShqC5AQ7bE5+0d4q8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ocMgRiP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D945FC2BBFC;
	Tue, 30 Apr 2024 11:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475300;
	bh=lS7jRbLCWGirW7s/7qvOmQq7eCYl7T6ZyUQ18yx6Eqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocMgRiP+yisq94BbYJ/toZmNsjI3N3oc9d4tRroGQmGD6/UwAa8wLPeVlzK+L47mD
	 F4fIXv7r5ubHPJ8vsbh+/cD5xg0eM0O7Eq3zGgrIwKcocrrTf215vtApNe6dnDPq3s
	 3E8GuuWiW1o1Ao4Fm2ejArPVUK1qIqWZmxPb59i8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 055/186] net: dsa: mv88e6xx: fix supported_interfaces setup in mv88e6250_phylink_get_caps()
Date: Tue, 30 Apr 2024 12:38:27 +0200
Message-ID: <20240430103059.628958934@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

[ Upstream commit a4e3899065ffa87d49dc20e8c17501edbc189692 ]

With the recent PHYLINK changes requiring supported_interfaces to be set,
MV88E6250 family switches like the 88E6020 fail to probe - cmode is
never initialized on these devices, so mv88e6250_phylink_get_caps() does
not set any supported_interfaces flags.

Instead of a cmode, on 88E6250 we have a read-only port mode value that
encodes similar information. There is no reason to bother mapping port
mode to the cmodes of other switch models; instead we introduce a
mv88e6250_setup_supported_interfaces() that is called directly from
mv88e6250_phylink_get_caps().

Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be filled")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Link: https://lore.kernel.org/r/20240417103737.166651-1-matthias.schiffer@ew.tq-group.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 56 +++++++++++++++++++++++++++++---
 drivers/net/dsa/mv88e6xxx/port.h | 23 ++++++++++---
 2 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index b8fde22aebf93..8556502f06721 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -566,13 +566,61 @@ static void mv88e6xxx_translate_cmode(u8 cmode, unsigned long *supported)
 		phy_interface_set_rgmii(supported);
 }
 
-static void mv88e6250_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
-				       struct phylink_config *config)
+static void
+mv88e6250_setup_supported_interfaces(struct mv88e6xxx_chip *chip, int port,
+				     struct phylink_config *config)
 {
 	unsigned long *supported = config->supported_interfaces;
+	int err;
+	u16 reg;
 
-	/* Translate the default cmode */
-	mv88e6xxx_translate_cmode(chip->ports[port].cmode, supported);
+	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &reg);
+	if (err) {
+		dev_err(chip->dev, "p%d: failed to read port status\n", port);
+		return;
+	}
+
+	switch (reg & MV88E6250_PORT_STS_PORTMODE_MASK) {
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_HALF_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_100_HALF_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_FULL_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_100_FULL_PHY:
+		__set_bit(PHY_INTERFACE_MODE_REVMII, supported);
+		break;
+
+	case MV88E6250_PORT_STS_PORTMODE_MII_HALF:
+	case MV88E6250_PORT_STS_PORTMODE_MII_FULL:
+		__set_bit(PHY_INTERFACE_MODE_MII, supported);
+		break;
+
+	case MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_200_RMII_FULL_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_HALF_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL_PHY:
+		__set_bit(PHY_INTERFACE_MODE_REVRMII, supported);
+		break;
+
+	case MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL:
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL:
+		__set_bit(PHY_INTERFACE_MODE_RMII, supported);
+		break;
+
+	case MV88E6250_PORT_STS_PORTMODE_MII_100_RGMII:
+		__set_bit(PHY_INTERFACE_MODE_RGMII, supported);
+		break;
+
+	default:
+		dev_err(chip->dev,
+			"p%d: invalid port mode in status register: %04x\n",
+			port, reg);
+	}
+}
+
+static void mv88e6250_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
+				       struct phylink_config *config)
+{
+	if (!mv88e6xxx_phy_is_internal(chip, port))
+		mv88e6250_setup_supported_interfaces(chip, port, config);
 
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100;
 }
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index 86deeb347cbc1..ddadeb9bfdaee 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -25,10 +25,25 @@
 #define MV88E6250_PORT_STS_PORTMODE_PHY_100_HALF	0x0900
 #define MV88E6250_PORT_STS_PORTMODE_PHY_10_FULL		0x0a00
 #define MV88E6250_PORT_STS_PORTMODE_PHY_100_FULL	0x0b00
-#define MV88E6250_PORT_STS_PORTMODE_MII_10_HALF		0x0c00
-#define MV88E6250_PORT_STS_PORTMODE_MII_100_HALF	0x0d00
-#define MV88E6250_PORT_STS_PORTMODE_MII_10_FULL		0x0e00
-#define MV88E6250_PORT_STS_PORTMODE_MII_100_FULL	0x0f00
+/* - Modes with PHY suffix use output instead of input clock
+ * - Modes without RMII or RGMII use MII
+ * - Modes without speed do not have a fixed speed specified in the manual
+ *   ("DC to x MHz" - variable clock support?)
+ */
+#define MV88E6250_PORT_STS_PORTMODE_MII_DISABLED		0x0000
+#define MV88E6250_PORT_STS_PORTMODE_MII_100_RGMII		0x0100
+#define MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL_PHY	0x0200
+#define MV88E6250_PORT_STS_PORTMODE_MII_200_RMII_FULL_PHY	0x0400
+#define MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL	0x0600
+#define MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL	0x0700
+#define MV88E6250_PORT_STS_PORTMODE_MII_HALF			0x0800
+#define MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_HALF_PHY	0x0900
+#define MV88E6250_PORT_STS_PORTMODE_MII_FULL			0x0a00
+#define MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL_PHY	0x0b00
+#define MV88E6250_PORT_STS_PORTMODE_MII_10_HALF_PHY		0x0c00
+#define MV88E6250_PORT_STS_PORTMODE_MII_100_HALF_PHY		0x0d00
+#define MV88E6250_PORT_STS_PORTMODE_MII_10_FULL_PHY		0x0e00
+#define MV88E6250_PORT_STS_PORTMODE_MII_100_FULL_PHY		0x0f00
 #define MV88E6XXX_PORT_STS_LINK			0x0800
 #define MV88E6XXX_PORT_STS_DUPLEX		0x0400
 #define MV88E6XXX_PORT_STS_SPEED_MASK		0x0300
-- 
2.43.0




