Return-Path: <stable+bounces-98976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A199E6B5D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9226B16215E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91101F6662;
	Fri,  6 Dec 2024 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gzfa7/+T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AEE1DD0E7
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479901; cv=none; b=cfbM7gkPWyV5f98vTvxBIvqTivLIjrNJSjkHnNcMs/X4+34uHNEPrFGyon6TxyagmrH8EldXZU3TRPoCFaPGaR+BZMyGqxAvih4m5rOdqI4/yXBfYhUG2CBwRzO2mhZwagARY55W6xBVafcp5pmYshgDMgmzvJ2e88+YbEhujyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479901; c=relaxed/simple;
	bh=VrA/9076x8joXmB7b1lJHKqDlmQZfjqGKiIpsXt5oNA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uQc1bfE8Yu2Bd/SkZUYBwV42t0W5jGesURdzChABR9+BANP+sfpGfuy8jquV19xhIKGlU5psOGL6j6ElAbrjn9WdH/tS5RMquF2IoNVb8TEwJ4OwVvr6pHDGLb08z+cMGxLWwv8Q0yP4Gp/KBzgXCwW+lDpy9JswOb5GQ2ex+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gzfa7/+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087BEC4CED1;
	Fri,  6 Dec 2024 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733479901;
	bh=VrA/9076x8joXmB7b1lJHKqDlmQZfjqGKiIpsXt5oNA=;
	h=Subject:To:Cc:From:Date:From;
	b=gzfa7/+TWcBlarkViSAkTwNs5ay7vwsYX53k1tBawnIs4PhSodmuCvCNMI70tW/AU
	 ldUzaykPwXpCV9XUFGyFwLWs9biSul6jsWdp1RrwiCJ/SriMoQW25XNQgAcfEFcNYZ
	 XBc2/H/QwOz1gmpFxGQ4eo2gnRqbdChFDBnjZ7cs=
Subject: FAILED: patch "[PATCH] net: phy: dp83869: fix status reporting for 1000base-x" failed to apply to 5.10-stable tree
To: romain.gantois@bootlin.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 11:11:30 +0100
Message-ID: <2024120630-barbed-mutual-faca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 378e8feea9a70d37a5dc1678b7ec27df21099fa5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120630-barbed-mutual-faca@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 378e8feea9a70d37a5dc1678b7ec27df21099fa5 Mon Sep 17 00:00:00 2001
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 12 Nov 2024 15:06:08 +0100
Subject: [PATCH] net: phy: dp83869: fix status reporting for 1000base-x
 autonegotiation

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
Link: https://patch.msgid.link/20241112-dp83869-1000base-x-v3-1-36005f4ab0d9@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 5f056d7db83e..b6b38caf9c0e 100644
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


