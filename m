Return-Path: <stable+bounces-164311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A04B0E679
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 00:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB23547C8A
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 22:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6229227A446;
	Tue, 22 Jul 2025 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJSlPe0K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E6E10F2
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753223759; cv=none; b=GdGkAjyms293hPJFaCfN2aB+3BKSW1IlDYIN0Y6k4WqUvMEP6npf6wQrGnIRNYUnUnVkZZCSPuEK4g0MIG8uBvds9RiZmXycVdf1Re9Me/yYhO6VD5Db1odGok0+rQQdv601JeBz9OQ74nZoo1p/BeaRHpUpkOPT9cuw1q18JTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753223759; c=relaxed/simple;
	bh=KHktdl0yaWgzkOEaAZMNoS72sI99oX4iNSnx3yHEc+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YHOtEUontQm3HMJdNC3Hh3EOyR+ItjhmQ4miVLG4NajtGe7XiL9n6vgedCy/X3589dgl597Q6B/W6soL4+dEl7r5LpDiB+zX6prdBL8gpP7rmFCRnn8ElAo4YOXtn9i+hyRZuNmXef9Ti0ROeQP67Fj0tgF0+devuiRD7R5ywh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJSlPe0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80134C4CEEB;
	Tue, 22 Jul 2025 22:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753223758;
	bh=KHktdl0yaWgzkOEaAZMNoS72sI99oX4iNSnx3yHEc+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJSlPe0KFCxi6aWDL167NCq3uD+Ot3aPq8TDcyrznKCVAg36vuMJy6bVLVL21RZW9
	 qsSasUwefqVr0k4Eg45udntfnvSbal03dLaZs+b7lAOCKlrs5VRgmOOyKzh/8vTMaF
	 6Y3NjiTEN11iSvn8gtQIjsS07HoqUdDQmASjv/hl3uBW8qvJXVjTFXQxkohms4qmdi
	 6YaVTwlwQ66ryosxT7Z64amtKSIhmYaN7QqCa4B1pHmXwVB+dRqmY1/Y++mmH+0+5T
	 J/T0mOGtcZicvX7rblDR31IuE6N90o2UaYnTA+tKTzrLKIhdeT6/dhFw+gRWV1zuqb
	 cOZHYswael4LQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] usb: hub: fix detection of high tier USB3 devices behind suspended hubs
Date: Tue, 22 Jul 2025 18:35:54 -0400
Message-Id: <20250722223554.994323-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072211-wolverine-heroics-ee1b@gregkh>
References: <2025072211-wolverine-heroics-ee1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 8f5b7e2bec1c36578fdaa74a6951833541103e27 ]

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
[ replaced hub_get/hub_put wrapper functions with direct kref_get/kref_put calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/hub.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 585375817f5ed..e14bf25a14a69 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -51,6 +51,12 @@
 #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
 #define USB_PING_RESPONSE_TIME		400	/* ns */
 
+/*
+ * Give SS hubs 200ms time after wake to train downstream links before
+ * assuming no port activity and allowing hub to runtime suspend back.
+ */
+#define USB_SS_PORT_U0_WAKE_TIME	200  /* ms */
+
 /* Protect struct usb_device->state and ->children members
  * Note: Both are also protected by ->dev.sem, except that ->state can
  * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
@@ -1024,11 +1030,12 @@ int usb_remove_device(struct usb_device *udev)
 
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
@@ -1051,6 +1058,13 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 			goto init2;
 		goto init3;
 	}
+
+	if (type == HUB_POST_RESUME) {
+		usb_autopm_put_interface_async(to_usb_interface(hub->intfdev));
+		kref_put(&hub->kref, hub_release);
+		return;
+	}
+
 	kref_get(&hub->kref);
 
 	/* The superspeed hub except for root hub has to use Hub Depth
@@ -1299,6 +1313,16 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
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
 	kref_put(&hub->kref, hub_release);
 }
 
@@ -1317,6 +1341,13 @@ static void hub_init_func3(struct work_struct *ws)
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
-- 
2.39.5


