Return-Path: <stable+bounces-178889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC34B48C16
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 13:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89183B1689
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 11:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781C021B9E7;
	Mon,  8 Sep 2025 11:26:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3B21D3E4
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330798; cv=none; b=eTbT0UkvSZTnudMPjQjqDI8J5gD5PhLTyzA76Dh9LkX0zmusRQAOV+VHC+OEuD4xtsHtpTMO8CjAnmRqgLHGND/qGVkAXlHiYxTtql6cLd/G7YSUzoKpCvJGZtzbg+vdmQ2wU3eVwQ0mkcjvyjgSSMznmw4Tz1r6nNtlyiEQO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330798; c=relaxed/simple;
	bh=c6t4cydIqpleUp8P0JIcZAYejDjGJcodaWPjnrvk1lY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O3dvtxgS0y400UIvuUxvHwFEaazq2APZCYj9Cx/hhSHAh+B5kHGnnkThFsgR613cVlk7xJIZC+CLxEKoFKQWoM5b0ILDW4XiX+ExfmSQJ6x205zc5g1xTBJdyM9S5m4pkpr2OFYKi3rSVo6iZjZEe32Z+FCRiFNrI1MVg99aisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uva0s-000411-Fl; Mon, 08 Sep 2025 13:26:22 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uva0q-000Evp-03;
	Mon, 08 Sep 2025 13:26:20 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1uva0p-0000000CAcM-3sYj;
	Mon, 08 Sep 2025 13:26:19 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Hubert=20Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Russell King <linux@armlinux.org.uk>,
	Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups
Date: Mon,  8 Sep 2025 13:26:19 +0200
Message-ID: <20250908112619.2900723-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Drop phylink_{suspend,resume}() from ax88772 PM callbacks.

MDIO bus accesses have their own runtime-PM handling and will try to
wake the device if it is suspended. Such wake attempts must not happen
from PM callbacks while the device PM lock is held. Since phylink
{sus|re}sume may trigger MDIO, it must not be called in PM context.

No extra phylink PM handling is required for this driver:
- .ndo_open/.ndo_stop control the phylink start/stop lifecycle.
- ethtool/phylib entry points run in process context, not PM.
- phylink MAC ops program the MAC on link changes after resume.

Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")
Reported-by: Hubert Wiśniewski <hubert.wisniewski.25632@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/asix_devices.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 792ddda1ad49..1e8f7089f5e8 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -607,15 +607,8 @@ static const struct net_device_ops ax88772_netdev_ops = {

 static void ax88772_suspend(struct usbnet *dev)
 {
-	struct asix_common_private *priv = dev->driver_priv;
 	u16 medium;

-	if (netif_running(dev->net)) {
-		rtnl_lock();
-		phylink_suspend(priv->phylink, false);
-		rtnl_unlock();
-	}
-
 	/* Stop MAC operation */
 	medium = asix_read_medium_status(dev, 1);
 	medium &= ~AX_MEDIUM_RE;
@@ -644,12 +637,6 @@ static void ax88772_resume(struct usbnet *dev)
 	for (i = 0; i < 3; i++)
 		if (!priv->reset(dev, 1))
 			break;
-
-	if (netif_running(dev->net)) {
-		rtnl_lock();
-		phylink_resume(priv->phylink);
-		rtnl_unlock();
-	}
 }

 static int asix_resume(struct usb_interface *intf)
--
2.47.3


