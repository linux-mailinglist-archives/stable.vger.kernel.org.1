Return-Path: <stable+bounces-192086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFADC29625
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 21:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9AB15346B9A
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 20:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CDA22301;
	Sun,  2 Nov 2025 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn9PUgxI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3828E5
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762114530; cv=none; b=oDlGMcGOmF/ZfnkpWUHpHWKuroULACgijiz3OtB2YD9QiYJlJ3Vw/HRLskJgqZP6lYVxIZJgpT6WsoNFO0mdmT2Zj/iu/Y6VayOo4ZqTugdAAbOWWiiOLi5RkF/dRqUc78gX9mfGDwcqKfZcX+Z+cvwo1CDNEyDs6T9a+ITzZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762114530; c=relaxed/simple;
	bh=h35y5rZVKFs0xl7NzHF0HyCDxbDhmpPIzLT56sXtFkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUj7fr3a4doN/9ZB/EeyAwInUvfIE6EMh+WppMFK/q+UbjDqNV/7lJks5tOjmtFysvWg8+jAwFxT9SC0LgTXsSqQF39aibvEFK4MrnRzp4IQNsYIprAK46RIUH0xkL2taunh7qBLV5yisrsuLq/CpwiJoC6Bm9vWhjQGEAhLFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn9PUgxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CF0C4CEF7;
	Sun,  2 Nov 2025 20:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762114530;
	bh=h35y5rZVKFs0xl7NzHF0HyCDxbDhmpPIzLT56sXtFkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dn9PUgxIcpIDc0fv66dnZz3rhqMIiMc1LHcS98yJa/ZIcJLKulKqIg5oRCfs2DtSv
	 khypK3jiEwYupLVR5RYIHUOcPiXLiQE+HJAUWBHkcOQr6a9OI77YdOaywocuIvZ7/s
	 D5wU3ROfC6cJa91oT6OdBrjgFxHAm5rsmOl3+0VlUA8jmMWIxE3SpuAr35wjwXc965
	 kkpsR3w/fZJBLdxabEupA7UNi/iS4qsUaxdY7mcWK9PqVLnWWcKIfhdkDEBnKPRYIt
	 6K7VswP4N4Pe2UNNlwyXNnjU/hvNSKQXb596mJTbWtULJva24VU4R9MdOkUtcJsBcp
	 rlxtTnI5bxTzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: phy: dp83867: Disable EEE support as not implemented
Date: Sun,  2 Nov 2025 15:15:27 -0500
Message-ID: <20251102201527.3587707-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110202-hamstring-ended-9680@gregkh>
References: <2025110202-hamstring-ended-9680@gregkh>
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
index f7436191fa807..38e448c882c4b 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -743,6 +743,12 @@ static int dp83867_config_init(struct phy_device *phydev)
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


