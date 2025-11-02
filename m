Return-Path: <stable+bounces-192064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ADFC2907C
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 15:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8863A30DD
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ABE1B81CA;
	Sun,  2 Nov 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU8aQjyE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA07261B
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762094810; cv=none; b=CntMDxG0uW6EHlqG7F4dHKt/4JYoG71ji/xv8QmgWfcnhoQgyi9I7CZc7zbuYBoun4j8Fs4qQEpHLmv9rCWQ56vNtrMWeB9VpxzZEWcuBMdHA+7dY7SSHqwf+yCLtjhBWGH/+jIIaC0deOvzEhDHiPffjMHspnTt5dHakcn7bUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762094810; c=relaxed/simple;
	bh=tZyI5Tt+i9AV7kEqZo+T3sQvc/10fQyehpsoCSzIrtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi4J2kQIS8sBzUc6l38Mdc3Dq5pLmuxOiiVNXOu+ixCqcqcvwueeU1YtLZoY4l0MVRPGeyqe5wwf6CVc2BXLHMcJepEkPVuI6CJAM5VDB9lE+7A3q56EQriejWlooeOJbek3EubZaYiVZM+mI00xP7ef5v7nUF5HQtIEPj2kt+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU8aQjyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F40C4CEFD;
	Sun,  2 Nov 2025 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762094810;
	bh=tZyI5Tt+i9AV7kEqZo+T3sQvc/10fQyehpsoCSzIrtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YU8aQjyE2i4coWLsCy6eGtWVUTl8COtGsV7Bl/WBNXeLj15PHp1S6p6FRD+a8lZhi
	 eDt1RCxVfv9W2Z7BZDqe6rRapdezO7/xtuypS/Ak0bEam4Hus0Nz+Cgesf2+VA8WZ/
	 C9tQy/gfiwFJAjeOWXlin2lXOY4haitdGs8IQe+UJNgNMeH5Bg/p0bee76AH7m11G1
	 IsGR+uMYUELoBd5dfhf6gsmZGXTw3jWEE+v9Cl+nmpEtkc2CnC1/3MuvWB7KthTECE
	 YyAyfrFigvdL0DYicEH5SdPwqz3u0WlwjsVKW9pNvVApuQMvLMc5lQ07vOohxeHO4K
	 vyhyu+G+6WYvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] net: phy: dp83867: Disable EEE support as not implemented
Date: Sun,  2 Nov 2025 09:46:46 -0500
Message-ID: <20251102144646.3457653-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251102144646.3457653-1-sashal@kernel.org>
References: <2025110212-wavy-support-eaec@gregkh>
 <20251102144646.3457653-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83867.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 4120385c5a79d..e02e3479e1c7a 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -792,6 +792,12 @@ static int dp83867_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* Although the DP83867 reports EEE capability through the
+	 * MDIO_PCS_EEE_ABLE and MDIO_AN_EEE_ADV registers, the feature
+	 * is not actually implemented in hardware.
+	 */
+	phy_disable_eee(phydev);
+
 	if (phy_interface_is_rgmii(phydev) ||
 	    phydev->interface == PHY_INTERFACE_MODE_SGMII) {
 		val = phy_read(phydev, MII_DP83867_PHYCTRL);
-- 
2.51.0


