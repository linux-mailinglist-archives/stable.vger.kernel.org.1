Return-Path: <stable+bounces-136862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 487D4A9EFBC
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7DB189E056
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52260266595;
	Mon, 28 Apr 2025 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w7t7d6aD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13199265CAE
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841268; cv=none; b=mTYZug6bFM0E3k+JK2WKW2BOOM1IRWBs+RUGKu5RCBw5KAccPp4oKv+U7Du8NIpeIm/15e9dgjjGuzgKW9pUIgAk8nheUTWNwMMUdewQotYj3x+nS91YpoBCl4vYJeQcQpejDBbxvQKSqyDzDyTTGdr56H43hGbJ+Qvlz7oq7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841268; c=relaxed/simple;
	bh=wyEI6bwHRI4NO2TiEA0rEHIbPnczkXtOwF3CgIIYBFo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Gqxvggv4clLXMHIxsX7bg82mwf2oNg6pv9RNZ0W6Q4y4SS/OLY0/dno11eKka6Y8+ELnD3DsPepMmScRTPn5ugE4wU1gSSjEvxTosdRy+pcUzEXNVAwq8Rq3eiDDRjcpQfI2mu9eOGQpwTcDpON/PP6a7V/xE8OJgzO0qFNVTL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w7t7d6aD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86C0C4CEE4;
	Mon, 28 Apr 2025 11:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745841267;
	bh=wyEI6bwHRI4NO2TiEA0rEHIbPnczkXtOwF3CgIIYBFo=;
	h=Subject:To:Cc:From:Date:From;
	b=w7t7d6aDL6HydBedvBhD01U0MI8yLPSm4ABxbxR0qktuJ4yHGO0M4/+yJBTNsLign
	 JPgwtCFKzDj65+6StlA9MSOToDTsP36SwyT5VpTexfbxHxEltQ1lkgB4by5zQYQ3iO
	 cm9NaJv3Yn3dxiiy+AmG9JCKcTuM2YkJOJ6clif4=
Subject: FAILED: patch "[PATCH] net: phy: microchip: force IRQ polling mode for lan88xx" failed to apply to 5.10-stable tree
To: fiona.klute@gmx.de,andrew@lunn.ch,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 13:54:24 +0200
Message-ID: <2025042824-quiver-could-ffa2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 30a41ed32d3088cd0d682a13d7f30b23baed7e93
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042824-quiver-could-ffa2@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30a41ed32d3088cd0d682a13d7f30b23baed7e93 Mon Sep 17 00:00:00 2001
From: Fiona Klute <fiona.klute@gmx.de>
Date: Wed, 16 Apr 2025 12:24:13 +0200
Subject: [PATCH] net: phy: microchip: force IRQ polling mode for lan88xx

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

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index 0e17cc458efd..93de88c1c8fd 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -37,47 +37,6 @@ static int lan88xx_write_page(struct phy_device *phydev, int page)
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
@@ -528,8 +487,9 @@ static struct phy_driver microchip_phy_driver[] = {
 	.config_aneg	= lan88xx_config_aneg,
 	.link_change_notify = lan88xx_link_change_notify,
 
-	.config_intr	= lan88xx_phy_config_intr,
-	.handle_interrupt = lan88xx_handle_interrupt,
+	/* Interrupt handling is broken, do not define related
+	 * functions to force polling.
+	 */
 
 	.suspend	= lan88xx_suspend,
 	.resume		= genphy_resume,


