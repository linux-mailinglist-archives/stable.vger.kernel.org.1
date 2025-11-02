Return-Path: <stable+bounces-192089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFF4C29695
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 21:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151763AA635
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 20:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB771E3DDB;
	Sun,  2 Nov 2025 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP5ch22c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA679460
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762115953; cv=none; b=Lsmd1R3T7P1ko9Z8LqRZ5pkyre28P/LP7g8xSGFZpjeh62PMjaHEDYHC5fJak4V+iffMGOTmolOncahFTe/CPHpLKHPMwH9Efm9sozKtHZeZuN/ULjref8RCXAWeSohXp3INxhlVm0o9nLCenGkGmeVQK5vp5zE6c8TFA/ryqDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762115953; c=relaxed/simple;
	bh=sClRXuC/MASXUY8l/Vox2eXIDffsHY7PJzyFl028snc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYqCDb3sFgscDDnEq53JIciVX6JDRnhNmrVC6V8dX/sAl/YpnbNqhCeR3nBZhjS28oeiIbE/1BAEA9iP27OU9dDqjfNFMpTnSNGbUONF/Kq4jpQ+C7Y5PyZMoI7OpHR88a4O4RyZZhuNLMQ+zpeaNj/1bEh/V81+WBaQIjhmGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP5ch22c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2ACC4CEF7;
	Sun,  2 Nov 2025 20:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762115951;
	bh=sClRXuC/MASXUY8l/Vox2eXIDffsHY7PJzyFl028snc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UP5ch22cU3N8mR9bE6Uv5I4PlNldT7L+HC+a4CS+56OJ+Qxy3KBnuF7Ux/NhnkREA
	 hqmqMYipXPZMSHHmpOkSSFZYr8hUGW+t1UwlUrm67l7UcvdKDVLDH0Cj7qMCNJdhl1
	 lcMyrFwjDkIM3M5RryTegXyUv5/cXfIKN0sHl192G4cThg7PxlBiPtaMV1mJIoskdn
	 H50u1pGMuH9Bu9nirGx6K+QshejqpbdhtvXTOBUHeXCFXi9qNO0jgcT4/H3YWMssbs
	 q3/EkY8uPODfzDqXQYgs4z/mEL6RdvCYjgJmq1gM5Tasz+ONsOzsVhRenVkh3PKUsb
	 rlRSaFPULB+XQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: phy: dp83867: Disable EEE support as not implemented
Date: Sun,  2 Nov 2025 15:39:09 -0500
Message-ID: <20251102203909.3597447-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110204-backroom-donated-75ff@gregkh>
References: <2025110204-backroom-donated-75ff@gregkh>
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
index 0cb24bfbfa237..d128453e1cd59 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -664,6 +664,12 @@ static int dp83867_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* Although the DP83867 reports EEE capability through the
+	 * MDIO_PCS_EEE_ABLE and MDIO_AN_EEE_ADV registers, the feature
+	 * is not actually implemented in hardware.
+	 */
+	phydev->eee_broken_modes = MDIO_EEE_100TX | MDIO_EEE_1000T;
+
 	if (phy_interface_is_rgmii(phydev) ||
 	    phydev->interface == PHY_INTERFACE_MODE_SGMII) {
 		val = phy_read(phydev, MII_DP83867_PHYCTRL);
-- 
2.51.0


