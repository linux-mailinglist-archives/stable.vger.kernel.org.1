Return-Path: <stable+bounces-177953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A08B46D91
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762461C218E2
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD332F0661;
	Sat,  6 Sep 2025 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovn4G7Ls"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E49131E2D
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164360; cv=none; b=ZWGyupdIweZtqC4eEvk6F3Parqj3ECKRUQWc5D632VYVgskIVxVkmstwtoB2hit6DSlwT5wFxNUHDG/eIvCeKp4ht62l3LpMPvkMblcQtxSzfbkayCYCCBSUIZKrnJVGMtp0nPhss7SH0ROcsDi6PHnUkWDE+odpDOQVeNQ84/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164360; c=relaxed/simple;
	bh=Tzg8WFzbpVUOGjZXs7Um32aTpn2dk3Vy4b7QEViNftI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jn2/aF+elEmT9Q0LW7RRXjhJKmtqb3ZKq+3pHHfIeexK5a5TXaHI/UpEABAvobNDJzmeRp5np3aOrYfCyj9XxwKooxKm3i2B8eKYPzlmp2CNC5is/iSxtfV9jdQ4p/eBWLpNZtCI7nTMpz+T9skoJJtPVas/xm5fUwuULXRExfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovn4G7Ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAF7C4CEF9;
	Sat,  6 Sep 2025 13:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757164359;
	bh=Tzg8WFzbpVUOGjZXs7Um32aTpn2dk3Vy4b7QEViNftI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovn4G7Ls5H0D1K8odSJeUSP1tJ+1dfIH3CZQHzwCs0DCZ/rWjrLQssKumF6a/XBUp
	 mRiNZ+2bjPUpNJNYQtM6W7gC5q4r84+TEs+qxLs0paB2ivjeYyrFAjfY6VvndgNKFP
	 3Q454CQl4kLamCa77SMU3eUtQKGjMturOXg3gsY814t/Dy7w6X/S/V3GX267YR0UsC
	 EI6Qc0YcD/w0xS64sh9paucNnAHU+BW9jzmWZCnsssVi/BLKV1In3374Qy6/+F9TZl
	 jU/ckjPiyP4FgpD0+EnEkXSv6alC1cZAGjaLw2Apvlg1Y8Otxir4X+eAvTFii7UbYD
	 dGZr3cIi5U+Tg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Nisar Sayed <Nisar.Sayed@microchip.com>,
	Yuiko Oshino <yuiko.oshino@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] net: phy: microchip: remove the use of .ack_interrupt()
Date: Sat,  6 Sep 2025 09:12:35 -0400
Message-ID: <20250906131236.3883856-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250906131236.3883856-1-sashal@kernel.org>
References: <2025042824-quiver-could-ffa2@gregkh>
 <20250906131236.3883856-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit cf499391982d877e9313d2adeedcf5f1ffe05d6e ]

In preparation of removing the .ack_interrupt() callback, we must replace
its occurrences (aka phy_clear_interrupt), from the 2 places where it is
called from (phy_enable_interrupts and phy_disable_interrupts), with
equivalent functionality.

This means that clearing interrupts now becomes something that the PHY
driver is responsible of doing, before enabling interrupts and after
clearing them. Make this driver follow the new contract.

Cc: Nisar Sayed <Nisar.Sayed@microchip.com>
Cc: Yuiko Oshino <yuiko.oshino@microchip.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 30a41ed32d30 ("net: phy: microchip: force IRQ polling mode for lan88xx")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/microchip.c    | 13 +++++--------
 drivers/net/phy/microchip_t1.c | 17 +++++++----------
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index b8a1cbd180cdf..f2860ec7ac17e 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -44,14 +44,12 @@ static int lan88xx_phy_config_intr(struct phy_device *phydev)
 			       LAN88XX_INT_MASK_LINK_CHANGE_);
 	} else {
 		rc = phy_write(phydev, LAN88XX_INT_MASK, 0);
-	}
-
-	return rc < 0 ? rc : 0;
-}
+		if (rc)
+			return rc;
 
-static int lan88xx_phy_ack_interrupt(struct phy_device *phydev)
-{
-	int rc = phy_read(phydev, LAN88XX_INT_STS);
+		/* Ack interrupts after they have been disabled */
+		rc = phy_read(phydev, LAN88XX_INT_STS);
+	}
 
 	return rc < 0 ? rc : 0;
 }
@@ -390,7 +388,6 @@ static struct phy_driver microchip_phy_driver[] = {
 	.config_aneg	= lan88xx_config_aneg,
 	.link_change_notify = lan88xx_link_change_notify,
 
-	.ack_interrupt	= lan88xx_phy_ack_interrupt,
 	.config_intr	= lan88xx_phy_config_intr,
 	.handle_interrupt = lan88xx_handle_interrupt,
 
diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 553b391d1747a..4440182243108 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -189,16 +189,14 @@ static int lan87xx_phy_config_intr(struct phy_device *phydev)
 		rc = phy_write(phydev, LAN87XX_INTERRUPT_MASK, 0x7FFF);
 		rc = phy_read(phydev, LAN87XX_INTERRUPT_SOURCE);
 		val = LAN87XX_MASK_LINK_UP | LAN87XX_MASK_LINK_DOWN;
-	}
-
-	rc = phy_write(phydev, LAN87XX_INTERRUPT_MASK, val);
-
-	return rc < 0 ? rc : 0;
-}
+		rc = phy_write(phydev, LAN87XX_INTERRUPT_MASK, val);
+	} else {
+		rc = phy_write(phydev, LAN87XX_INTERRUPT_MASK, val);
+		if (rc)
+			return rc;
 
-static int lan87xx_phy_ack_interrupt(struct phy_device *phydev)
-{
-	int rc = phy_read(phydev, LAN87XX_INTERRUPT_SOURCE);
+		rc = phy_read(phydev, LAN87XX_INTERRUPT_SOURCE);
+	}
 
 	return rc < 0 ? rc : 0;
 }
@@ -239,7 +237,6 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.config_init	= lan87xx_config_init,
 		.config_aneg    = genphy_config_aneg,
 
-		.ack_interrupt  = lan87xx_phy_ack_interrupt,
 		.config_intr    = lan87xx_phy_config_intr,
 		.handle_interrupt = lan87xx_handle_interrupt,
 
-- 
2.50.1


