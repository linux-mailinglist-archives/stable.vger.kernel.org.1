Return-Path: <stable+bounces-192101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B55DC29A42
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 00:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8EBE2346622
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 23:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFDD155757;
	Sun,  2 Nov 2025 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtLrPmAu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD49D34D394
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762127015; cv=none; b=UG6EXqBylI1/O1qe5gbbJ1h+FHc2/qtIE69UdYUZLpwya2j8NiB9/e2nmvhTRccIVb0pOUHSaH3rVy8Uhrm3j1+OmgwD2MEwWirBEeYOMcdAJ0R/PZLrk1LRgelRZ0on3IpRnMmCpAwq+sRLI4K2G/tbOGnDb+UhxSmJNN0CyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762127015; c=relaxed/simple;
	bh=oyfJXHaQqoA6JwKf7t2izW305KM5a6z6vVcvMDXQ8ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0C1Y59TRBhw0KwYNpKCHASFKTDfaWg1wsDmCdzoYjBFIXU+qRxne1iiz7odXE1dJ0Qnbc8vscwpXrdF+DPypnqOaNGp+qRSwZIk+ltyCyYzO3J1acuA7OZ9ImwRGepgKRd6gs2J9Tx2OkgLaru3qjpDD5VmJ2Wwdl55ZwN6Gkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtLrPmAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA13C4CEF7;
	Sun,  2 Nov 2025 23:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762127015;
	bh=oyfJXHaQqoA6JwKf7t2izW305KM5a6z6vVcvMDXQ8ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RtLrPmAuy8RUCXopbhXDzUWBPxhHxf7z70tCWJWuy6hsO43rjRmr0PdmOTtyGUXRC
	 NQY7zIzqiUd17iZMirqRZaqSwuQTMpYPQC8+JRCMnsg7tE0fkovouHGCPdK0JAMvOl
	 Yf3Sp/HWCHPqlTUu1hVbFX91Sh7vDT7RDb+bbOYWkcUOAThmeFwNQ2kYvQRL/vJHiN
	 2DPYQzoZ5l/y+e2n6lPBBQqR7cW3Vbz9Y3XslXEX/qMKSqf848OM6Bmu5I+ks1FLxC
	 HX0MI9iQ+vKfGOiHwSrwMchKkXRd0DlTcUW2qi4cjx55mJg7el4s1RY8Q95UULj8ol
	 cNMPG84VF74Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] net: phy: dp83867: Disable EEE support as not implemented
Date: Sun,  2 Nov 2025 18:43:32 -0500
Message-ID: <20251102234332.3659143-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110205-customer-qualifier-2030@gregkh>
References: <2025110205-customer-qualifier-2030@gregkh>
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
[ replaced phy_disable_eee() call with direct eee_broken_modes assignment ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83867.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 1375beb3cf83c..c8a01672884bf 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -337,6 +337,12 @@ static int dp83867_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* Although the DP83867 reports EEE capability through the
+	 * MDIO_PCS_EEE_ABLE and MDIO_AN_EEE_ADV registers, the feature
+	 * is not actually implemented in hardware.
+	 */
+	phydev->eee_broken_modes = MDIO_EEE_100TX | MDIO_EEE_1000T;
+
 	if (phy_interface_is_rgmii(phydev)) {
 		val = phy_read(phydev, MII_DP83867_PHYCTRL);
 		if (val < 0)
-- 
2.51.0


