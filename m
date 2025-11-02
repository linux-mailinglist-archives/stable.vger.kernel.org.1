Return-Path: <stable+bounces-192088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C07EC29686
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 21:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFECA188DAFD
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED8413D539;
	Sun,  2 Nov 2025 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tI1MMaAS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0373B2AD20
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762115443; cv=none; b=AqlNH5jv0LfAIomSHlXowtIAFb5iW0omZ1bs/KIsVQvQeJvLWbTVWqaUGTd+70J9AbUTYNMm3+myhBtjM5jr15hpxRgzaA8bRNEWo5T3QMDTYj/q2LlDu2SbTdypy73EvipIKvdJFjaJA+7FzU1+nJf20UrQ1sGfZQiZnt/kCTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762115443; c=relaxed/simple;
	bh=mU7AGyNyaa46xe4NoKnS3v6/17UJ1bKEVf0HpQbFNjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJkKoBX1niZjX5T55aPIXerLqA32W564YjWAmjEqwDmJ/8AZ0w6TkV55mqkZtpTHZkzoE6R4xC8CDIQSwRHN1k7wTzFFsdtoLa7GqRTDw99AV20qwYxviJHEB+h+gNUhoC+2LgChU0a09FZUT9apUDHNOra+0ZKhOX3KBSULSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tI1MMaAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE21C4CEF7;
	Sun,  2 Nov 2025 20:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762115442;
	bh=mU7AGyNyaa46xe4NoKnS3v6/17UJ1bKEVf0HpQbFNjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tI1MMaASN2Uu6iTP+RLxOj72DwUlf7+vm32tjSt3WSTcdmQqodUvi+np92a/ftdN9
	 QZ5kZMlQTasQQlG8PHNWb2/WhOUXu4Nte3IOc+yq1MOGyqtbt2f/ikG7qEDiL4LcC1
	 F9Okb4XJJMXDo4ZGMh/REfJLGZBhuVbpbNSMz3W8GnnlILaTVajicatwomNA4Ehdsk
	 Ays+rW5OyYK5ranGfXNL5EY9SIFvMp8ZykSBq0EHp7P0aQYKr5GWskfSeouE7pg2Pp
	 QheCegWrD+dY3rvNpkSfTZ8OlWlGpplgilLTM7Mpbr8pNutJnUm95PH6gE/wH55wrw
	 9uycuxOrk0X9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: phy: dp83867: Disable EEE support as not implemented
Date: Sun,  2 Nov 2025 15:30:39 -0500
Message-ID: <20251102203040.3593522-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110203-spinal-groovy-c2f2@gregkh>
References: <2025110203-spinal-groovy-c2f2@gregkh>
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
index 76ca43108d992..3865019ebb5bd 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -674,6 +674,12 @@ static int dp83867_config_init(struct phy_device *phydev)
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


