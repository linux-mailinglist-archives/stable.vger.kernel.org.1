Return-Path: <stable+bounces-142255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7803FAAE9C9
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12411C420C5
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BB521E0BB;
	Wed,  7 May 2025 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OFUUxDKP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516D215766;
	Wed,  7 May 2025 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643691; cv=none; b=EKI30lZMvqcWnyltRDnovAtrntrToI6VvQGP92vI3gMdKthfM+QEvFZfCvxjWdKrgqwlS1hkqhQ6zPhFm9EXi5P1Oy5fx9dS6CtQRO/xf88vTuQeig854LdSKW4ycQXOs/xtFshmW0IqTOE/6q7CpRaGQJc/eEfQsLhrEMgMtR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643691; c=relaxed/simple;
	bh=2AZJLiwHUhn2ou3gaWTK1/d/tJ684NDodbfOCOTMF8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z65a39QQCLFMifNO80tPwkSiJBX/3BgsE2PqS5l5VoL+fI1nHf2vTwPy4LaIxuatv6I4I4sfTrbZuQkngyDmReOdZjcCBZLd1kulpg2E9P0AqWCP7uq+OdE+yPsKv2OUx3d+F1Yueijo9GYkugZ5lH6ga8NRqb3blsDrWADa2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OFUUxDKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF7DC4CEE2;
	Wed,  7 May 2025 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643691;
	bh=2AZJLiwHUhn2ou3gaWTK1/d/tJ684NDodbfOCOTMF8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFUUxDKPgSkjRfxoHbCN7IGczQtkHIJVgvUz+4riSzjx+UZAtLGZ8joLzz1ZzYMQ8
	 N/Hve2G500jCzUYAnj/vvLBsqc8qmVsHIjjMdib9FveDyYXwp4A+KNxxFWHQUpEPnT
	 LP97XEE+5Ez5sCGjNKfQvApqnYBkRV/bYLUqLBKE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fiona Klute <fiona.klute@gmx.de>,
	kernel-list@raspberrypi.com,
	Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 83/97] net: phy: microchip: force IRQ polling mode for lan88xx
Date: Wed,  7 May 2025 20:39:58 +0200
Message-ID: <20250507183810.318613379@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183806.987408728@linuxfoundation.org>
References: <20250507183806.987408728@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 0b88635f4fbca..623607fd2cefd 100644
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
@@ -392,8 +351,9 @@ static struct phy_driver microchip_phy_driver[] = {
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
2.39.5




