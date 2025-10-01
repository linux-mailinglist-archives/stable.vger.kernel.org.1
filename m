Return-Path: <stable+bounces-182936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E8BBB0683
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 15:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1961945CDB
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 13:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEE21F181F;
	Wed,  1 Oct 2025 13:05:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5C54501A
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323901; cv=none; b=j+oTt7IdkhDngug04x5iOwP0uJHldyWInoadgrFhCyVLboCOuo+U3slJsxNfbZWow1rMmdxo27if6Yfx9/YoMaqnSSRKSc3OrjQVb3NYVaCKRcj4ZHDdFOTnHGjkd4H7ncfTxiUlsGjs2PvwtPJc7vAN5i4Bd/2i1achLpVoMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323901; c=relaxed/simple;
	bh=lCdM8Ah7f9siwPk1NgsZaY5JPUTlBRBFs0s9yqMejNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HxtHvhMxeM8WsJmRYFGfChkD+AbzA38qgvK/XRqaMeqqM2Vg09R7xs9D3Rf1Giivlax5nAdUCMijOgMz2pBRj0T/QiWlHLDhKvLasVd9Q8gQsr2A7hVVfAOipQ8HwGvh6CqoUXcnpKo0WnCwL8IcKi3eUOFHZ9IPnOv6DJyBJ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v3wVX-0006cN-RX; Wed, 01 Oct 2025 15:04:35 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v3wVV-001Q4u-1w;
	Wed, 01 Oct 2025 15:04:33 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1v3wVV-0000000AG1g-27OZ;
	Wed, 01 Oct 2025 15:04:33 +0200
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
Subject: [PATCH net v2 1/1] net: usb: asix: hold PM usage ref to avoid PM/MDIO + RTNL deadlock
Date: Wed,  1 Oct 2025 15:04:32 +0200
Message-ID: <20251001130432.2444863-1-o.rempel@pengutronix.de>
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

Prevent USB runtime PM (autosuspend) for AX88772* in bind.

usbnet enables runtime PM (autosuspend) by default, so disabling it via
the usb_driver flag is ineffective. On AX88772B, autosuspend shows no
measurable power saving with current driver (no link partner, admin
up/down). The ~0.453 W -> ~0.248 W drop on v6.1 comes from phylib powering
the PHY off on admin-down, not from USB autosuspend.

The real hazard is that with runtime PM enabled, ndo_open() (under RTNL)
may synchronously trigger autoresume (usb_autopm_get_interface()) into
asix_resume() while the USB PM lock is held. Resume paths then invoke
phylink/phylib and MDIO, which also expect RTNL, leading to possible
deadlocks or PM lock vs MDIO wake issues.

To avoid this, keep the device runtime-PM active by taking a usage
reference in ax88772_bind() and dropping it in unbind(). A non-zero PM
usage count blocks runtime suspend regardless of userspace policy
(.../power/control - pm_runtime_allow/forbid), making this approach
robust against sysfs overrides.

System sleep/resume is unchanged.

Fixes: 4a2c7217cd5a ("net: usb: asix: ax88772: manage PHY PM from MAC")
Reported-by: Hubert Wiśniewski <hubert.wisniewski.25632@gmail.com>
Closes: https://lore.kernel.org/all/DCGHG5UJT9G3.2K1GHFZ3H87T0@gmail.com
Tested-by: Hubert Wiśniewski <hubert.wisniewski.25632@gmail.com>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes in v2:
- Switch from pm_runtime_forbid()/allow() to pm_runtime_get_noresume()/put()
  as suggested by Alan Stern, to block autosuspend robustly.
- Reword commit message to clarify the actual deadlock condition
  (autoresume under RTNL) as pointed out by Oliver Neukum.
- Keep explanation in commit message, shorten in-code comment.

Link to the measurement results:
https://lore.kernel.org/all/aMkPMa650kfKfmF4@pengutronix.de/
---
 drivers/net/usb/asix_devices.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 792ddda1ad49..5c939446515b 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -625,6 +625,21 @@ static void ax88772_suspend(struct usbnet *dev)
 		   asix_read_medium_status(dev, 1));
 }
 
+/* Notes on PM callbacks and locking context:
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
@@ -919,6 +934,13 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 	if (ret)
 		goto initphy_err;
 
+	/* Keep this interface runtime-PM active by taking a usage ref.
+	 * Prevents runtime suspend while bound and avoids resume paths
+	 * that could deadlock (autoresume under RTNL while USB PM lock
+	 * is held, phylink/MDIO wants RTNL).
+	 */
+	pm_runtime_get_noresume(&intf->dev);
+
 	return 0;
 
 initphy_err:
@@ -948,6 +970,8 @@ static void ax88772_unbind(struct usbnet *dev, struct usb_interface *intf)
 	phylink_destroy(priv->phylink);
 	ax88772_mdio_unregister(priv);
 	asix_rx_fixup_common_free(dev->driver_priv);
+	/* Drop the PM usage ref taken in bind() */
+	pm_runtime_put(&intf->dev);
 }
 
 static void ax88178_unbind(struct usbnet *dev, struct usb_interface *intf)
@@ -1600,6 +1624,10 @@ static struct usb_driver asix_driver = {
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


