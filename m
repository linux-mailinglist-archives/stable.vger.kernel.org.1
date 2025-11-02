Return-Path: <stable+bounces-192077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14936C2958D
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 19:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A632A3ACF25
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 18:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEC9220F5C;
	Sun,  2 Nov 2025 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOdQrBzD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007BC2FB
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762109954; cv=none; b=qGRzVVj1aOdO6Ql8lJxfmQoQPWGAsQ9OosEsaX0kWXZ4TEdWwmoLIKfYhK2VNthVspQQDbUQ5h7aInnN4hLEKWKY4gW2qt+ITvDwqp8HICfrZ99VQylFa/9zizmZGpSPNhnuYuyNxnZ4drNd1yk1U2asvNp0cPJrq3buWi9P+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762109954; c=relaxed/simple;
	bh=wnrZC3nK9++SNaq4J/RkrrAIfftMlk9exCFtVl6/js8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hjfx1FgVZjWdLTi+ktCWJ1weFl13T1jf+rlD98jMU4xlLdygyQifouKNGJMOn7n0nV3Vil37ec1iQbsgXR+bEMiL5d/8OjaHGvjvZrIwA83VZRHlJKr+R6VSfqfNC7bXQm/TezHx7Nc61/vtGd05evo8SKNGJbm588lZWEEaWHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOdQrBzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9C3C4CEF7;
	Sun,  2 Nov 2025 18:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762109952;
	bh=wnrZC3nK9++SNaq4J/RkrrAIfftMlk9exCFtVl6/js8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sOdQrBzDGpZJw4kZO0BiFJvavs07P3RrGAM5hZdsOOp6fvc0tUtSM9Wg6kGSoMzUq
	 RfbJ2FxGFUp3fPFEg24VcfK578EVoG1CWSgG2JHvS3Y+lL1BuFVFGP5caXAunGF9qc
	 nGa8XxWcXTrha871iGBMsnfMJ1K7gvc5nwhswDNE+rIW4IfEEXpWciXD75QB81FQLm
	 VC53FtdRLGfsyR8dfmEBEAw4lVoMV7AG6/rRNvjIGzZ7a8foCTt401pycT6kogEkh4
	 ebIb6F5mciKxsyEpUrrZXhUhWsoqnvQK4iaPzy3GuxMQCpjMviRYCUM12o1H6TsvpB
	 R8DPfk25M1xSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: phy: dp83867: Disable EEE support as not implemented
Date: Sun,  2 Nov 2025 13:59:09 -0500
Message-ID: <20251102185909.3552411-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110211-modular-affection-39a7@gregkh>
References: <2025110211-modular-affection-39a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

[ Upstream commit 84a905290cb4c3d9a71a9e3b2f2e02e031e7512f ]

While the DP83867 PHYs report EEE capability through their feature
registers, the actual hardware does not support EEE (see Links).
When the connected MAC enables EEE, it causes link instability and
communication failures.

The issue is reproducible with a iMX8MP and relevant stmmac ethernet port.
Since the introduction of phylink-managed EEE support in the stmmac driver,
EEE is now enabled by default, leading to issues on systems using the
DP83867 PHY.

Call phy_disable_eee during phy initialization to prevent EEE from being
enabled on DP83867 PHYs.

Link: https://e2e.ti.com/support/interface-group/interface/f/interface-forum/1445244/dp83867ir-dp83867-disable-eee-lpi
Link: https://e2e.ti.com/support/interface-group/interface/f/interface-forum/658638/dp83867ir-eee-energy-efficient-ethernet
Fixes: 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy")
Cc: stable@vger.kernel.org
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20251023144857.529566-1-ghidoliemanuele@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ inlined phy_disable_eee() functionality ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83867.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index e397e7d642d92..a778379108ef1 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -774,6 +774,14 @@ static int dp83867_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* Although the DP83867 reports EEE capability through the
+	 * MDIO_PCS_EEE_ABLE and MDIO_AN_EEE_ADV registers, the feature
+	 * is not actually implemented in hardware.
+	 */
+	linkmode_zero(phydev->supported_eee);
+	linkmode_zero(phydev->advertising_eee);
+	phydev->eee_enabled = false;
+
 	if (phy_interface_is_rgmii(phydev) ||
 	    phydev->interface == PHY_INTERFACE_MODE_SGMII) {
 		val = phy_read(phydev, MII_DP83867_PHYCTRL);
-- 
2.51.0


