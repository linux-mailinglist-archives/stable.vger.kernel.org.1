Return-Path: <stable+bounces-184228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 243B8BD2D7F
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 13:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7806A189C238
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3820319CCFC;
	Mon, 13 Oct 2025 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zwfnvPZH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7213A258
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356132; cv=none; b=Gt6bhYhfrqO6Yb0C/MZeArZzNAKsqL452H2SY0Bcpah50vB1I6ng7LP4raXmynvVapu6lm97Oqg1t5+zO7MDrWDtbnVmgrpG2ruXp3LpX5h8NVYnFw2YgC7c8WhIoqDrJ+uRKU7ztEJcL/Sde+GBwLu0IpPnw0vVBhTl2HccTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356132; c=relaxed/simple;
	bh=qbcuS25rekJ4p1Goi9QF6iD/LH4Vw8EWyylAbrSRTzc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J16GctHHEsGI+aXIG6W6JLgYGBwYVxam6PTIacw84YrHwgnTzDCyvdIfUmZqJzjGwI4pGR/3MyUCYnyu4Uzpo2ur8CLidITp1trykkXLaWnNvq3lunb48S/Z8xfpI2Qe432ajvBHVVXsbNPxEanTJt9RU9Fu5QxfUfMfqA4XyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zwfnvPZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73557C4CEE7;
	Mon, 13 Oct 2025 11:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760356131;
	bh=qbcuS25rekJ4p1Goi9QF6iD/LH4Vw8EWyylAbrSRTzc=;
	h=Subject:To:Cc:From:Date:From;
	b=zwfnvPZHTa+huxjh9VE+sR9A9u8TEdDk7UQbPaCkXeoH8Vd6+PkY0lvtiPjh8/VNa
	 7sd7gc3AKL0+3/c1YrRmLnIJRfpUK2vGy2B7l7TpSgstKCqCRcef8sQQHv9EZz6SCf
	 wfn1EMs48XFJNVlSfdCM9V7h5BZbDF3MODE3Dc4I=
Subject: FAILED: patch "[PATCH] net: usb: asix: hold PM usage ref to avoid PM/MDIO + RTNL" failed to apply to 5.15-stable tree
To: o.rempel@pengutronix.de,hubert.wisniewski.25632@gmail.com,m.szyprowski@samsung.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 13:48:49 +0200
Message-ID: <2025101349-reptile-seldom-427d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3d3c4cd5c62f24bb3cb4511b7a95df707635e00a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101349-reptile-seldom-427d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d3c4cd5c62f24bb3cb4511b7a95df707635e00a Mon Sep 17 00:00:00 2001
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Sun, 5 Oct 2025 10:12:03 +0200
Subject: [PATCH] net: usb: asix: hold PM usage ref to avoid PM/MDIO + RTNL
 deadlock
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Holding a runtime-PM usage ref does not affect system-wide suspend;
system sleep/resume callbacks continue to run as before.

Fixes: 4a2c7217cd5a ("net: usb: asix: ax88772: manage PHY PM from MAC")
Reported-by: Hubert Wiśniewski <hubert.wisniewski.25632@gmail.com>
Closes: https://lore.kernel.org/all/DCGHG5UJT9G3.2K1GHFZ3H87T0@gmail.com
Tested-by: Hubert Wiśniewski <hubert.wisniewski.25632@gmail.com>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20251005081203.3067982-1-o.rempel@pengutronix.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 792ddda1ad49..85bd5d845409 100644
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
+ *   measurable power saving here, we block it by holding a PM usage
+ *   reference in ax88772_bind().
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
@@ -1600,6 +1624,11 @@ static struct usb_driver asix_driver = {
 	.resume =	asix_resume,
 	.reset_resume =	asix_resume,
 	.disconnect =	usbnet_disconnect,
+	/* usbnet enables autosuspend by default (supports_autosuspend=1).
+	 * We keep runtime-PM active for AX88772* by taking a PM usage
+	 * reference in ax88772_bind() (pm_runtime_get_noresume()) and
+	 * dropping it in unbind(), which effectively blocks autosuspend.
+	 */
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
 };


