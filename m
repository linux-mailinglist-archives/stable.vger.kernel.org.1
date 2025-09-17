Return-Path: <stable+bounces-179816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827DFB7D449
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED10178E4B
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5DC34AAEE;
	Wed, 17 Sep 2025 09:55:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8326B2DB
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102916; cv=none; b=AZMSVUz6qsWbDBMZNR1p6l0ZwJZ9kXU/dyZq5kRqV2yg3NlVYXQ4OV143SR3lVfJ5PZX1Yx+5hSKFNuhvT+V7US8Qjc2wddH2GyioO5zdC3UEbc9kdiK+r1dQwPbgucupqhyNCasVG4OdueoucDJczCcMmn6EUBrKgvwsvHscsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102916; c=relaxed/simple;
	bh=kMPNSqfXiTA47FxCKgCB2/oJ9gSc4/KzV97yHyY8Ha4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NqkSG0bPZXssNfxwqrCNvbzICvl1O+RodPiv7slh6vps3k9dbLt53gmphKO7WLpZ9s9Q7IZ4ErMGFWK3Mqs5wd0LwTLqb1zRL+9yqbxUgL9ySmRU3J0IKMrMXS4TZUtuLJ++2O2QKQvWtkYbQnE/7AUUUtE9p0wK6NHrOXheM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uyosO-0002zq-En; Wed, 17 Sep 2025 11:55:00 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyosM-001jx6-32;
	Wed, 17 Sep 2025 11:54:58 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1uyosM-00000008pAy-3bgU;
	Wed, 17 Sep 2025 11:54:58 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Hubert=20Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Russell King <linux@armlinux.org.uk>,
	Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid PM/MDIO + RTNL deadlock
Date: Wed, 17 Sep 2025 11:54:57 +0200
Message-ID: <20250917095457.2103318-1-o.rempel@pengutronix.de>
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

Forbid USB runtime PM (autosuspend) for AX88772* in bind.

usbnet enables runtime PM by default in probe, so disabling it via the
usb_driver flag is ineffective. For AX88772B, autosuspend shows no
measurable power saving in my tests (no link partner, admin up/down).
The ~0.453 W -> ~0.248 W reduction on 6.1 comes from phylib powering
the PHY off on admin-down, not from USB autosuspend.

With autosuspend active, resume paths may require calling phylink/phylib
(caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM
resume can deadlock (RTNL may already be held), and MDIO can attempt a
runtime-wake while the USB PM lock is held. Given the lack of benefit
and poor test coverage (autosuspend is usually disabled by default in
distros), forbid runtime PM here to avoid these hazards.

This affects only AX88772* devices (per-interface in bind). System
sleep/resume is unchanged.

Fixes: 4a2c7217cd5a ("net: usb: asix: ax88772: manage PHY PM from MAC")
Reported-by: Hubert Wiśniewski <hubert.wisniewski.25632@gmail.com>
Closes: https://lore.kernel.org/all/20220622141638.GE930160@montezuma.acc.umu.se
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Link to the measurement results:
https://lore.kernel.org/all/aMkPMa650kfKfmF4@pengutronix.de/
---
 drivers/net/usb/asix_devices.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 792ddda1ad49..0d341d7e6154 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -625,6 +625,22 @@ static void ax88772_suspend(struct usbnet *dev)
 		   asix_read_medium_status(dev, 1));
 }
 
+/*
+ * Notes on PM callbacks and locking context:
+ *
+ * - asix_suspend()/asix_resume() are invoked for both runtime PM and
+ *   system-wide suspend/resume. For struct usb_driver the ->resume()
+ *   callback does not receive pm_message_t, so the resume type cannot
+ *   be distinguished here.
+ *
+ * - The MAC driver must hold RTNL when calling phylink interfaces such as
+ *   phylink_suspend()/resume(). Those calls will also perform MDIO I/O.
+ *
+ * - Taking RTNL and doing MDIO from a runtime-PM resume callback (while
+ *   the USB PM lock is held) is fragile. Since autosuspend brings no
+ *   measurable power saving for this device with current driver version, it is
+ *   disabled below.
+ */
 static int asix_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
@@ -919,6 +935,16 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 	if (ret)
 		goto initphy_err;
 
+	/* Disable USB runtime PM (autosuspend) for this interface.
+	 * Rationale:
+	 * - No measurable power saving from autosuspend for this device.
+	 * - phylink/phylib calls require caller-held RTNL and do MDIO I/O,
+	 *   which is unsafe from USB PM resume paths (possible RTNL already
+	 *   held, USB PM lock held).
+	 * System suspend/resume is unaffected.
+	 */
+	pm_runtime_forbid(&intf->dev);
+
 	return 0;
 
 initphy_err:
@@ -948,6 +974,10 @@ static void ax88772_unbind(struct usbnet *dev, struct usb_interface *intf)
 	phylink_destroy(priv->phylink);
 	ax88772_mdio_unregister(priv);
 	asix_rx_fixup_common_free(dev->driver_priv);
+	/* Re-allow runtime PM on disconnect for tidiness. The interface
+	 * goes away anyway, but this balances forbid for debug sanity.
+	 */
+	pm_runtime_allow(&intf->dev);
 }
 
 static void ax88178_unbind(struct usbnet *dev, struct usb_interface *intf)
@@ -1600,6 +1630,10 @@ static struct usb_driver asix_driver = {
 	.resume =	asix_resume,
 	.reset_resume =	asix_resume,
 	.disconnect =	usbnet_disconnect,
+	/* usbnet will force supports_autosuspend=1; we explicitly forbid RPM
+	 * per-interface in bind to keep autosuspend disabled for this driver
+	 * by using pm_runtime_forbid().
+	 */
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
 };
-- 
2.47.3


