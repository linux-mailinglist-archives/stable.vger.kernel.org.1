Return-Path: <stable+bounces-177954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B86A3B46D92
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE6E1C2196E
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8B12EFD9F;
	Sat,  6 Sep 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO/FhkK1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA0E131E2D
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164360; cv=none; b=uf5ScslAqgaG9dO3yarm1GDJu/X1mh8lc/4UnnRm5MN/ut1W2WcqsgqVONjEpuMZNrsWRSUhe8Phr/r4TYfdqEr6Laz6wIPhX0WY3sfd0Y0CS6MeV7xnky57KTkIyG1UU2J7BcdcZ7xPBORsisdeiBCfrftlF1MGWxOpRupsZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164360; c=relaxed/simple;
	bh=mS/hcsaXnrRoINtu/aS/rwlZrnZSz4yAvaxJTlI6WYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNfhvvFrSQ9SNQq75wJy/m3EwE3at/QAE2YJhiQpfB2BQ3NKn0TGYzB3ZY4YgU8rxBN+/tQpiI/Xn4qxHkfrAF9m552DZfGyLZGxUDtsWqaGv7aDlQVyTwZJ5QoFbgH+4ZvJ+wdyA/ZxKm4JWe3zIYFigSWdk9iJIGoAiSWhn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO/FhkK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB62CC4CEF4;
	Sat,  6 Sep 2025 13:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757164360;
	bh=mS/hcsaXnrRoINtu/aS/rwlZrnZSz4yAvaxJTlI6WYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hO/FhkK1vA9FCK92Xhu7H497SyjqwngC4PIPMzdb5O/yuXTlmKBc5bD614CCBuAe5
	 qP1lcqIi2uKV+nlT3MxEavk8baHnk5VLePS6YNvkcQeuX2q3b7dDZ3lTDv/GKQciwF
	 U5m3yLYqLDTtvnpUCI5tbZP2ENtvnifKRrCWdGL/QBeST3cuNkNVBrqIgPgvIjggkx
	 JiDH5nXCilDq88dg3V02IQtDZ35ZlY25d9lOrmCv4k1DbbBg7svOVdL+qg3mvGbc8C
	 RBffGPXx6pwNkCD1Pj9jC4evCB2wQWjCKHQh7q8/gBDYYP7bLKZA5fw2FdhSsDQuaH
	 Wlupl2WuoK7wA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fiona Klute <fiona.klute@gmx.de>,
	kernel-list@raspberrypi.com,
	Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] net: phy: microchip: force IRQ polling mode for lan88xx
Date: Sat,  6 Sep 2025 09:12:36 -0400
Message-ID: <20250906131236.3883856-3-sashal@kernel.org>
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

From: Fiona Klute <fiona.klute@gmx.de>

[ Upstream commit 30a41ed32d3088cd0d682a13d7f30b23baed7e93 ]

With lan88xx based devices the lan78xx driver can get stuck in an
interrupt loop while bringing the device up, flooding the kernel log
with messages like the following:

lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped

Removing interrupt support from the lan88xx PHY driver forces the
driver to use polling instead, which avoids the problem.

The issue has been observed with Raspberry Pi devices at least since
4.14 (see [1], bug report for their downstream kernel), as well as
with Nvidia devices [2] in 2020, where disabling interrupts was the
vendor-suggested workaround (together with the claim that phylib
changes in 4.9 made the interrupt handling in lan78xx incompatible).

Iperf reports well over 900Mbits/sec per direction with client in
--dualtest mode, so there does not seem to be a significant impact on
throughput (lan88xx device connected via switch to the peer).

[1] https://github.com/raspberrypi/linux/issues/2447
[2] https://forums.developer.nvidia.com/t/jetson-xavier-and-lan7800-problem/142134/11

Link: https://lore.kernel.org/0901d90d-3f20-4a10-b680-9c978e04ddda@lunn.ch
Fixes: 792aec47d59d ("add microchip LAN88xx phy driver")
Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
Cc: kernel-list@raspberrypi.com
Cc: stable@vger.kernel.org
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250416102413.30654-1-fiona.klute@gmx.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/microchip.c | 46 +++----------------------------------
 1 file changed, 3 insertions(+), 43 deletions(-)

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index f2860ec7ac17e..738b24b832091 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -31,47 +31,6 @@ static int lan88xx_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, LAN88XX_EXT_PAGE_ACCESS, page);
 }
 
-static int lan88xx_phy_config_intr(struct phy_device *phydev)
-{
-	int rc;
-
-	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
-		/* unmask all source and clear them before enable */
-		rc = phy_write(phydev, LAN88XX_INT_MASK, 0x7FFF);
-		rc = phy_read(phydev, LAN88XX_INT_STS);
-		rc = phy_write(phydev, LAN88XX_INT_MASK,
-			       LAN88XX_INT_MASK_MDINTPIN_EN_ |
-			       LAN88XX_INT_MASK_LINK_CHANGE_);
-	} else {
-		rc = phy_write(phydev, LAN88XX_INT_MASK, 0);
-		if (rc)
-			return rc;
-
-		/* Ack interrupts after they have been disabled */
-		rc = phy_read(phydev, LAN88XX_INT_STS);
-	}
-
-	return rc < 0 ? rc : 0;
-}
-
-static irqreturn_t lan88xx_handle_interrupt(struct phy_device *phydev)
-{
-	int irq_status;
-
-	irq_status = phy_read(phydev, LAN88XX_INT_STS);
-	if (irq_status < 0) {
-		phy_error(phydev);
-		return IRQ_NONE;
-	}
-
-	if (!(irq_status & LAN88XX_INT_STS_LINK_CHANGE_))
-		return IRQ_NONE;
-
-	phy_trigger_machine(phydev);
-
-	return IRQ_HANDLED;
-}
-
 static int lan88xx_suspend(struct phy_device *phydev)
 {
 	struct lan88xx_priv *priv = phydev->priv;
@@ -388,8 +347,9 @@ static struct phy_driver microchip_phy_driver[] = {
 	.config_aneg	= lan88xx_config_aneg,
 	.link_change_notify = lan88xx_link_change_notify,
 
-	.config_intr	= lan88xx_phy_config_intr,
-	.handle_interrupt = lan88xx_handle_interrupt,
+	/* Interrupt handling is broken, do not define related
+	 * functions to force polling.
+	 */
 
 	.suspend	= lan88xx_suspend,
 	.resume		= genphy_resume,
-- 
2.50.1


