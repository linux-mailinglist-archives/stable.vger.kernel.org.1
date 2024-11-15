Return-Path: <stable+bounces-93379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723B59CD8F1
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE58B26CC3
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA8718873F;
	Fri, 15 Nov 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CJSWNxBA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D82153800;
	Fri, 15 Nov 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653723; cv=none; b=D4liSIBZwyq8wYCgmWZNV9jgLYyQcGGceK+UIQ0AJWL9SPqGvVIhz/WDwbLRbO4QQtqcr/cnam22SOK7KetONVR7FPTJNgfXCqQ+zlQEaU8BmUFswdz7Bh4zF8omlKnjbJX4d9jJC8oQKZHNlMkMKl3LoC4k05nVBzHDurAusb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653723; c=relaxed/simple;
	bh=7IKq3kVhTuHrduhMTYKGr4BmdCOmsVDOgdYLNiziMjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEcrQ54ErxgrzCDHrIkfycfDkdvBW4fREUtmC5JxbepPklKEEnz/P096cno5eI6XELROwvF3LhhCYWfLHnT2hikMHAgmftDq7kHTD5sq1rDh6z+aH5dzXXyPnp+s7xm8ysp5Q5/7sUQIKczmFQNIAPapli/IQBUreRCpQYuVU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CJSWNxBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A89DC4CED2;
	Fri, 15 Nov 2024 06:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653723;
	bh=7IKq3kVhTuHrduhMTYKGr4BmdCOmsVDOgdYLNiziMjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJSWNxBAjn4b7wydScOPcIztk1CFt/tyjCGLnd8CJQQaNABEih3lpuaCleUjgzpKS
	 f5W7WgR95AvwcyFR8Y8oXw+lqzhy6GtfFSvVePUKo/V5FRTe41qWNuAzebHyl/anFL
	 wOYUA0wSSrMLZ10J6SivyHv2y0gzYtMYBZs83I+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Murphy <dmurphy@ti.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 18/82] net: phy: ti: implement generic .handle_interrupt() callback
Date: Fri, 15 Nov 2024 07:37:55 +0100
Message-ID: <20241115063726.222860587@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063725.561151311@linuxfoundation.org>
References: <20241115063725.561151311@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit 1d1ae3c6ca3ff49843d73852bb2a8153ce16f432 ]

In an attempt to actually support shared IRQs in phylib, we now move the
responsibility of triggering the phylib state machine or just returning
IRQ_NONE, based on the IRQ status register, to the PHY driver. Having
3 different IRQ handling callbacks (.handle_interrupt(),
.did_interrupt() and .ack_interrupt() ) is confusing so let the PHY
driver implement directly an IRQ handler like any other device driver.
Make this driver follow the new convention.

Cc: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 256748d5480b ("net: phy: ti: add PHY_RST_AFTER_CLK_EN flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83640.c   | 27 +++++++++++++++++++++++
 drivers/net/phy/dp83822.c   | 37 +++++++++++++++++++++++++++++++
 drivers/net/phy/dp83848.c   | 33 ++++++++++++++++++++++++++++
 drivers/net/phy/dp83867.c   | 25 +++++++++++++++++++++
 drivers/net/phy/dp83869.c   | 25 +++++++++++++++++++++
 drivers/net/phy/dp83tc811.c | 44 +++++++++++++++++++++++++++++++++++++
 6 files changed, 191 insertions(+)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index f2caccaf4408f..89577f1d35766 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -50,6 +50,14 @@
 #define MII_DP83640_MISR_LINK_INT_EN 0x20
 #define MII_DP83640_MISR_ED_INT_EN 0x40
 #define MII_DP83640_MISR_LQ_INT_EN 0x80
+#define MII_DP83640_MISR_ANC_INT 0x400
+#define MII_DP83640_MISR_DUP_INT 0x800
+#define MII_DP83640_MISR_SPD_INT 0x1000
+#define MII_DP83640_MISR_LINK_INT 0x2000
+#define MII_DP83640_MISR_INT_MASK (MII_DP83640_MISR_ANC_INT |\
+				   MII_DP83640_MISR_DUP_INT |\
+				   MII_DP83640_MISR_SPD_INT |\
+				   MII_DP83640_MISR_LINK_INT)
 
 /* phyter seems to miss the mark by 16 ns */
 #define ADJTIME_FIX	16
@@ -1193,6 +1201,24 @@ static int dp83640_config_intr(struct phy_device *phydev)
 	}
 }
 
+static irqreturn_t dp83640_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status;
+
+	irq_status = phy_read(phydev, MII_DP83640_MISR);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (!(irq_status & MII_DP83640_MISR_INT_MASK))
+		return IRQ_NONE;
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static int dp83640_hwtstamp(struct mii_timestamper *mii_ts, struct ifreq *ifr)
 {
 	struct dp83640_private *dp83640 =
@@ -1517,6 +1543,7 @@ static struct phy_driver dp83640_driver = {
 	.config_init	= dp83640_config_init,
 	.ack_interrupt  = dp83640_ack_interrupt,
 	.config_intr    = dp83640_config_intr,
+	.handle_interrupt = dp83640_handle_interrupt,
 };
 
 static int __init dp83640_init(void)
diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index c3828beccbad8..45fbb65085f96 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -303,6 +303,41 @@ static int dp83822_config_intr(struct phy_device *phydev)
 	return phy_write(phydev, MII_DP83822_PHYSCR, physcr_status);
 }
 
+static irqreturn_t dp83822_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status;
+
+	/* The MISR1 and MISR2 registers are holding the interrupt status in
+	 * the upper half (15:8), while the lower half (7:0) is used for
+	 * controlling the interrupt enable state of those individual interrupt
+	 * sources. To determine the possible interrupt sources, just read the
+	 * MISR* register and use it directly to know which interrupts have
+	 * been enabled previously or not.
+	 */
+	irq_status = phy_read(phydev, MII_DP83822_MISR1);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+	if (irq_status & ((irq_status & GENMASK(7, 0)) << 8))
+		goto trigger_machine;
+
+	irq_status = phy_read(phydev, MII_DP83822_MISR2);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+	if (irq_status & ((irq_status & GENMASK(7, 0)) << 8))
+		goto trigger_machine;
+
+	return IRQ_NONE;
+
+trigger_machine:
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static int dp8382x_disable_wol(struct phy_device *phydev)
 {
 	return phy_clear_bits_mmd(phydev, DP83822_DEVADDR, MII_DP83822_WOL_CFG,
@@ -586,6 +621,7 @@ static int dp83822_resume(struct phy_device *phydev)
 		.set_wol = dp83822_set_wol,			\
 		.ack_interrupt = dp83822_ack_interrupt,		\
 		.config_intr = dp83822_config_intr,		\
+		.handle_interrupt = dp83822_handle_interrupt,	\
 		.suspend = dp83822_suspend,			\
 		.resume = dp83822_resume,			\
 	}
@@ -601,6 +637,7 @@ static int dp83822_resume(struct phy_device *phydev)
 		.set_wol = dp83822_set_wol,			\
 		.ack_interrupt = dp83822_ack_interrupt,		\
 		.config_intr = dp83822_config_intr,		\
+		.handle_interrupt = dp83822_handle_interrupt,	\
 		.suspend = dp83822_suspend,			\
 		.resume = dp83822_resume,			\
 	}
diff --git a/drivers/net/phy/dp83848.c b/drivers/net/phy/dp83848.c
index 54c7c1b44e4d0..b707a9b278471 100644
--- a/drivers/net/phy/dp83848.c
+++ b/drivers/net/phy/dp83848.c
@@ -37,6 +37,20 @@
 	 DP83848_MISR_SPD_INT_EN |	\
 	 DP83848_MISR_LINK_INT_EN)
 
+#define DP83848_MISR_RHF_INT		BIT(8)
+#define DP83848_MISR_FHF_INT		BIT(9)
+#define DP83848_MISR_ANC_INT		BIT(10)
+#define DP83848_MISR_DUP_INT		BIT(11)
+#define DP83848_MISR_SPD_INT		BIT(12)
+#define DP83848_MISR_LINK_INT		BIT(13)
+#define DP83848_MISR_ED_INT		BIT(14)
+
+#define DP83848_INT_MASK		\
+	(DP83848_MISR_ANC_INT |	\
+	 DP83848_MISR_DUP_INT |	\
+	 DP83848_MISR_SPD_INT |	\
+	 DP83848_MISR_LINK_INT)
+
 static int dp83848_ack_interrupt(struct phy_device *phydev)
 {
 	int err = phy_read(phydev, DP83848_MISR);
@@ -66,6 +80,24 @@ static int dp83848_config_intr(struct phy_device *phydev)
 	return phy_write(phydev, DP83848_MICR, control);
 }
 
+static irqreturn_t dp83848_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status;
+
+	irq_status = phy_read(phydev, DP83848_MISR);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (!(irq_status & DP83848_INT_MASK))
+		return IRQ_NONE;
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static int dp83848_config_init(struct phy_device *phydev)
 {
 	int val;
@@ -104,6 +136,7 @@ MODULE_DEVICE_TABLE(mdio, dp83848_tbl);
 		/* IRQ related */				\
 		.ack_interrupt	= dp83848_ack_interrupt,	\
 		.config_intr	= dp83848_config_intr,		\
+		.handle_interrupt = dp83848_handle_interrupt,	\
 	}
 
 static struct phy_driver dp83848_driver[] = {
diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 834bf63dc2009..0cb24bfbfa237 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -312,6 +312,30 @@ static int dp83867_config_intr(struct phy_device *phydev)
 	return phy_write(phydev, MII_DP83867_MICR, micr_status);
 }
 
+static irqreturn_t dp83867_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status, irq_enabled;
+
+	irq_status = phy_read(phydev, MII_DP83867_ISR);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	irq_enabled = phy_read(phydev, MII_DP83867_MICR);
+	if (irq_enabled < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (!(irq_status & irq_enabled))
+		return IRQ_NONE;
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static int dp83867_read_status(struct phy_device *phydev)
 {
 	int status = phy_read(phydev, MII_DP83867_PHYSTS);
@@ -878,6 +902,7 @@ static struct phy_driver dp83867_driver[] = {
 		/* IRQ related */
 		.ack_interrupt	= dp83867_ack_interrupt,
 		.config_intr	= dp83867_config_intr,
+		.handle_interrupt = dp83867_handle_interrupt,
 
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 01b593e0bb4a1..e2fe89c8059ea 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -207,6 +207,30 @@ static int dp83869_config_intr(struct phy_device *phydev)
 	return phy_write(phydev, MII_DP83869_MICR, micr_status);
 }
 
+static irqreturn_t dp83869_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status, irq_enabled;
+
+	irq_status = phy_read(phydev, MII_DP83869_ISR);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	irq_enabled = phy_read(phydev, MII_DP83869_MICR);
+	if (irq_enabled < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (!(irq_status & irq_enabled))
+		return IRQ_NONE;
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static int dp83869_set_wol(struct phy_device *phydev,
 			   struct ethtool_wolinfo *wol)
 {
@@ -853,6 +877,7 @@ static struct phy_driver dp83869_driver[] = {
 		/* IRQ related */
 		.ack_interrupt	= dp83869_ack_interrupt,
 		.config_intr	= dp83869_config_intr,
+		.handle_interrupt = dp83869_handle_interrupt,
 		.read_status	= dp83869_read_status,
 
 		.get_tunable	= dp83869_get_tunable,
diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
index d73725312c7c3..a93c64ac76a39 100644
--- a/drivers/net/phy/dp83tc811.c
+++ b/drivers/net/phy/dp83tc811.c
@@ -254,6 +254,49 @@ static int dp83811_config_intr(struct phy_device *phydev)
 	return err;
 }
 
+static irqreturn_t dp83811_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status;
+
+	/* The INT_STAT registers 1, 2 and 3 are holding the interrupt status
+	 * in the upper half (15:8), while the lower half (7:0) is used for
+	 * controlling the interrupt enable state of those individual interrupt
+	 * sources. To determine the possible interrupt sources, just read the
+	 * INT_STAT* register and use it directly to know which interrupts have
+	 * been enabled previously or not.
+	 */
+	irq_status = phy_read(phydev, MII_DP83811_INT_STAT1);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+	if (irq_status & ((irq_status & GENMASK(7, 0)) << 8))
+		goto trigger_machine;
+
+	irq_status = phy_read(phydev, MII_DP83811_INT_STAT2);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+	if (irq_status & ((irq_status & GENMASK(7, 0)) << 8))
+		goto trigger_machine;
+
+	irq_status = phy_read(phydev, MII_DP83811_INT_STAT3);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+	if (irq_status & ((irq_status & GENMASK(7, 0)) << 8))
+		goto trigger_machine;
+
+	return IRQ_NONE;
+
+trigger_machine:
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static int dp83811_config_aneg(struct phy_device *phydev)
 {
 	int value, err;
@@ -345,6 +388,7 @@ static struct phy_driver dp83811_driver[] = {
 		.set_wol = dp83811_set_wol,
 		.ack_interrupt = dp83811_ack_interrupt,
 		.config_intr = dp83811_config_intr,
+		.handle_interrupt = dp83811_handle_interrupt,
 		.suspend = dp83811_suspend,
 		.resume = dp83811_resume,
 	 },
-- 
2.43.0




