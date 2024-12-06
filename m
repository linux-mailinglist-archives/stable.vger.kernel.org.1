Return-Path: <stable+bounces-98975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A94E99E6B5C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617FD2815E4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E721F4737;
	Fri,  6 Dec 2024 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0HBupa46"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C71EE016
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479893; cv=none; b=n53I/rdk9eC9w60rk1bUvb5awZ8cNPl3rVlMuPPF2tqoMSkS+Ttp7tYDLl7eKYEJTEo8jLHJoFit/pt4U8Pxr++hOt1NzQu0aMz3S57YDyIgz/7WYGZCLz2dY6N3vu3P0es7glf6zSpQnEuYxp7xhK/A2xew40lu4AGe9aSpej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479893; c=relaxed/simple;
	bh=LtfyzNCJuD+YZtC9l9TnZTbA14ay8vE+PNFB9+kDhaU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nIaYkb/gdKYrgLFlFMZnW6T9JVgXi4wUfNLaQwgOROWCjJXTOV+g4mxcmkA7LmcWEy5tmd/fuflbkwqdXY5FU+S2jY13Y5Stjr09dd4x1hlQ9H9F4ioEsniqtHk1h7GQ69mlnYQA/18qC6beSaqxf2C/wYYQ6Sw7dPpBxjV9bmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0HBupa46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D838C4CED1;
	Fri,  6 Dec 2024 10:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733479892;
	bh=LtfyzNCJuD+YZtC9l9TnZTbA14ay8vE+PNFB9+kDhaU=;
	h=Subject:To:Cc:From:Date:From;
	b=0HBupa46P4Chu04dGv1ROe7N5I/v6Oy2xINoZrTKwGbznXDp54rYgLQ8alWAkyrBj
	 6S56nVYnl2YVJxUlH3C+r08sgkTkgiSEdaFakH/75eSVOO3/w6w38HLHNvGQzhrbgC
	 Pq+hgV4KRrLLj9dhPbI7taSSwy0D57sruTws7qCs=
Subject: FAILED: patch "[PATCH] net: phy: dp83869: fix status reporting for 1000base-x" failed to apply to 5.15-stable tree
To: romain.gantois@bootlin.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 11:11:29 +0100
Message-ID: <2024120629-collage-gratitude-7244@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 378e8feea9a70d37a5dc1678b7ec27df21099fa5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120629-collage-gratitude-7244@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


