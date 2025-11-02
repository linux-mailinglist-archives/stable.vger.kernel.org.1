Return-Path: <stable+bounces-192099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F257BC29A19
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 00:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9041886E29
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 23:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D4E13D539;
	Sun,  2 Nov 2025 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCDCnKha"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621C13C3F2
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762126082; cv=none; b=Civ0xZEkzU3pPr9vRPQYCRIYPrg9oFNoLWBWDGS3zYckpaoSzq0GKPdXEIolgKCV2ukwOpkxKJeuFvAGNtk05Hvmk1PvTgKR7ebDMA3M0dv8DdQyGseERncC3+zsuScqwHdl4gp1CqmZvNaVRh9Kdb9auNHXIlAjlU7bNTSWUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762126082; c=relaxed/simple;
	bh=oyfJXHaQqoA6JwKf7t2izW305KM5a6z6vVcvMDXQ8ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWhZ6qlOc6JLe9hWbnHr+Y5dR34cEBtK3WG61T5V03FdXHKCNO2huQCrWIm2zlEdClLRrESSs7UunnqkieGAjUiq8wA7irVm08JXDPjy7HO8H8LFpLP0TM3vw7QaFan/Lq5g7P80mJKWXRAVok0R/nztZwH3+CnQyt/AiJqnde0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCDCnKha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39C1C4CEF7;
	Sun,  2 Nov 2025 23:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762126081;
	bh=oyfJXHaQqoA6JwKf7t2izW305KM5a6z6vVcvMDXQ8ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCDCnKharVku1E2vgUvJjOET3kBvhkaQLCLfq4pRp3YCH4eVJpYmblmyEgsMN+KL5
	 q+csU8gOhvrV6e3SE62yhDdC824tD37vtinrYQ0M25Q23Ewr2uXmqrXUkqId0QRbS0
	 JU+SFhT1sr4DMwWtOFyXx2zrRIoKTupX78l/0uFLcoKcgBr3L763WWiWfljswXaj/M
	 5sPShjivqCJ+78SzgQ7nJC66pbbDs9nXRWEnRuNaGhJifGM281eADf8nf7A2dco8dX
	 r+G51vesI7GQ2FYFM7fxR8tQMbhgpBpQsLjVBssz+HwqGmgY+WOdOqnLD2+3Sft+J8
	 4cLJKd2fZeCOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] net: phy: dp83867: Disable EEE support as not implemented
Date: Sun,  2 Nov 2025 18:27:59 -0500
Message-ID: <20251102232759.3653486-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110211-badly-cut-6b14@gregkh>
References: <2025110211-badly-cut-6b14@gregkh>
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


