Return-Path: <stable+bounces-163665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19312B0D458
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 10:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B22B1624AE
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 08:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB97E28B7F1;
	Tue, 22 Jul 2025 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i76ZqXSo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63E1DF25C
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172474; cv=none; b=jPUIE7UUrgQGG8cG2EeptJb5Z0/oF5d6WWfjKLvhK7JigDlft5ahFpdyiX8b5r0xPs7PiWeagLJ+S8NRSbmtiuDDL2GNyl3MCX5H0ZhC5v5xZyyZceYOrvCTZlA5zAFCMM1bvkSLvH3oScMY/jDs2AnFxJQbU9PZ6NUt+2dTku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172474; c=relaxed/simple;
	bh=swl5Y3Ky3EvyvejvCW0pOIWfbHneLoMfVrRxsKgLqwM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=etzdQS7W9gy13l5umNia0weI2z43gHMwxHk8B8PMIzoubrjtnVhzUNEEs2Nbw2ueOdylvkglJ760eOrXVZx50gwC7cAhu2r4UTzDDRCdlkGHcKeY3WlCvSVPPRpCpXVbJ4djndA8ZVGNZ4xEerbx5wZzWFK9lRJ/6xXgo5mZ13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i76ZqXSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47BDC4CEEB;
	Tue, 22 Jul 2025 08:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753172474;
	bh=swl5Y3Ky3EvyvejvCW0pOIWfbHneLoMfVrRxsKgLqwM=;
	h=Subject:To:Cc:From:Date:From;
	b=i76ZqXSo+rafmgfR9lclbPlptsysvLegd9DVdK38HW/480rVcwUrDflbYgSGuJ6Gs
	 QTuuedpVwhf4cFiWeu40YfsJlOYB4KrkSzI/qwbIqPfEcY8FtYl/jhKY5xpW0cYpHt
	 xCAVS4jGx5GqMjsFEcX8cVs1qOERqgoCUn5oi8fs=
Subject: FAILED: patch "[PATCH] usb: hub: fix detection of high tier USB3 devices behind" failed to apply to 5.4-stable tree
To: mathias.nyman@linux.intel.com,gregkh@linuxfoundation.org,stable@kernel.org,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Jul 2025 10:21:11 +0200
Message-ID: <2025072211-wolverine-heroics-ee1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8f5b7e2bec1c36578fdaa74a6951833541103e27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072211-wolverine-heroics-ee1b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8f5b7e2bec1c36578fdaa74a6951833541103e27 Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Wed, 11 Jun 2025 14:24:41 +0300
Subject: [PATCH] usb: hub: fix detection of high tier USB3 devices behind
 suspended hubs

USB3 devices connected behind several external suspended hubs may not
be detected when plugged in due to aggressive hub runtime pm suspend.

The hub driver immediately runtime-suspends hubs if there are no
active children or port activity.

There is a delay between the wake signal causing hub resume, and driver
visible port activity on the hub downstream facing ports.
Most of the LFPS handshake, resume signaling and link training done
on the downstream ports is not visible to the hub driver until completed,
when device then will appear fully enabled and running on the port.

This delay between wake signal and detectable port change is even more
significant with chained suspended hubs where the wake signal will
propagate upstream first. Suspended hubs will only start resuming
downstream ports after upstream facing port resumes.

The hub driver may resume a USB3 hub, read status of all ports, not
yet see any activity, and runtime suspend back the hub before any
port activity is visible.

This exact case was seen when conncting USB3 devices to a suspended
Thunderbolt dock.

USB3 specification defines a 100ms tU3WakeupRetryDelay, indicating
USB3 devices expect to be resumed within 100ms after signaling wake.
if not then device will resend the wake signal.

Give the USB3 hubs twice this time (200ms) to detect any port
changes after resume, before allowing hub to runtime suspend again.

Cc: stable <stable@kernel.org>
Fixes: 2839f5bcfcfc ("USB: Turn on auto-suspend for USB 3.0 hubs.")
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250611112441.2267883-1-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 770d1e91183c..5c12dfdef569 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -68,6 +68,12 @@
  */
 #define USB_SHORT_SET_ADDRESS_REQ_TIMEOUT	500  /* ms */
 
+/*
+ * Give SS hubs 200ms time after wake to train downstream links before
+ * assuming no port activity and allowing hub to runtime suspend back.
+ */
+#define USB_SS_PORT_U0_WAKE_TIME	200  /* ms */
+
 /* Protect struct usb_device->state and ->children members
  * Note: Both are also protected by ->dev.sem, except that ->state can
  * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
@@ -1068,11 +1074,12 @@ int usb_remove_device(struct usb_device *udev)
 
 enum hub_activation_type {
 	HUB_INIT, HUB_INIT2, HUB_INIT3,		/* INITs must come first */
-	HUB_POST_RESET, HUB_RESUME, HUB_RESET_RESUME,
+	HUB_POST_RESET, HUB_RESUME, HUB_RESET_RESUME, HUB_POST_RESUME,
 };
 
 static void hub_init_func2(struct work_struct *ws);
 static void hub_init_func3(struct work_struct *ws);
+static void hub_post_resume(struct work_struct *ws);
 
 static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 {
@@ -1095,6 +1102,13 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 			goto init2;
 		goto init3;
 	}
+
+	if (type == HUB_POST_RESUME) {
+		usb_autopm_put_interface_async(to_usb_interface(hub->intfdev));
+		hub_put(hub);
+		return;
+	}
+
 	hub_get(hub);
 
 	/* The superspeed hub except for root hub has to use Hub Depth
@@ -1343,6 +1357,16 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		device_unlock(&hdev->dev);
 	}
 
+	if (type == HUB_RESUME && hub_is_superspeed(hub->hdev)) {
+		/* give usb3 downstream links training time after hub resume */
+		INIT_DELAYED_WORK(&hub->init_work, hub_post_resume);
+		queue_delayed_work(system_power_efficient_wq, &hub->init_work,
+				   msecs_to_jiffies(USB_SS_PORT_U0_WAKE_TIME));
+		usb_autopm_get_interface_no_resume(
+			to_usb_interface(hub->intfdev));
+		return;
+	}
+
 	hub_put(hub);
 }
 
@@ -1361,6 +1385,13 @@ static void hub_init_func3(struct work_struct *ws)
 	hub_activate(hub, HUB_INIT3);
 }
 
+static void hub_post_resume(struct work_struct *ws)
+{
+	struct usb_hub *hub = container_of(ws, struct usb_hub, init_work.work);
+
+	hub_activate(hub, HUB_POST_RESUME);
+}
+
 enum hub_quiescing_type {
 	HUB_DISCONNECT, HUB_PRE_RESET, HUB_SUSPEND
 };


