Return-Path: <stable+bounces-35153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0E98942A5
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116051F2629F
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A494B433DA;
	Mon,  1 Apr 2024 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mZezsR57"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619951DFF4;
	Mon,  1 Apr 2024 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990477; cv=none; b=LQtIuEcEywAAZQ16gG7Y8eg0OEhZ/E55qzddGNW3VmnrRgpIYgQ37Tw/2kplCB/H4ZXZ2rh5TOqQCuqIc25FZH8WcE2rgEAbELrb89HlQ4ALsyJuBvhF3H8mwUIlnwLC4IV62+jZPWPq1emrDfiZh7+rwrZ+Dqudq+fsmgOjywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990477; c=relaxed/simple;
	bh=3Y+QXRrC15QdtcLlgemb5nwnal7JilUYIno+o6K9bnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTfV7eZDqXKRIMFOrAlAazQ3FjHgpWYp1wWIrtd+6oJsyCeGURNHM3fGKF2Wsd/fq8wlVvbDNAF4HvvC5Z+hMWHwojA+iLLOoTB/i0Xk45CPhTC6vr3nOUFzeoj2rtV0qdtx056oqo31O3d9nWMXuDyCu4XCzmKvNKQRmTw2iHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mZezsR57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0084C433F1;
	Mon,  1 Apr 2024 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990477;
	bh=3Y+QXRrC15QdtcLlgemb5nwnal7JilUYIno+o6K9bnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZezsR5730GpC7+SFE4/hTUFUTNaoG7KhOAgby801v5NIpEEUPm5yYx1fupo5vbJC
	 APKvE0tIRmKqhLh4s6f11iiqKV2RLzw4wAyXsQ6SwssxQrXQRzFfYnHI3frkydKedZ
	 D114p2MlFB+fn3fnc0i7nG63Y217gMtrmfKOTuLI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alan Stern <stern@rowland.harvard.edu>,
	stable <stable@kernel.org>
Subject: [PATCH 6.6 364/396] USB: core: Add hub_get() and hub_put() routines
Date: Mon,  1 Apr 2024 17:46:53 +0200
Message-ID: <20240401152558.772027496@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit ee113b860aa169e9a4d2c167c95d0f1961c6e1b8 upstream.

Create hub_get() and hub_put() routines to encapsulate the kref_get()
and kref_put() calls in hub.c.  The new routines will be used by the
next patch in this series.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/604da420-ae8a-4a9e-91a4-2d511ff404fb@rowland.harvard.edu
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/hub.c |   23 ++++++++++++++++-------
 drivers/usb/core/hub.h |    2 ++
 2 files changed, 18 insertions(+), 7 deletions(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -123,7 +123,6 @@ EXPORT_SYMBOL_GPL(ehci_cf_port_reset_rws
 #define HUB_DEBOUNCE_STEP	  25
 #define HUB_DEBOUNCE_STABLE	 100
 
-static void hub_release(struct kref *kref);
 static int usb_reset_and_verify_device(struct usb_device *udev);
 static int hub_port_disable(struct usb_hub *hub, int port1, int set_state);
 static bool hub_port_warm_reset_required(struct usb_hub *hub, int port1,
@@ -685,14 +684,14 @@ static void kick_hub_wq(struct usb_hub *
 	 */
 	intf = to_usb_interface(hub->intfdev);
 	usb_autopm_get_interface_no_resume(intf);
-	kref_get(&hub->kref);
+	hub_get(hub);
 
 	if (queue_work(hub_wq, &hub->events))
 		return;
 
 	/* the work has already been scheduled */
 	usb_autopm_put_interface_async(intf);
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 }
 
 void usb_kick_hub_wq(struct usb_device *hdev)
@@ -1060,7 +1059,7 @@ static void hub_activate(struct usb_hub
 			goto init2;
 		goto init3;
 	}
-	kref_get(&hub->kref);
+	hub_get(hub);
 
 	/* The superspeed hub except for root hub has to use Hub Depth
 	 * value as an offset into the route string to locate the bits
@@ -1308,7 +1307,7 @@ static void hub_activate(struct usb_hub
 		device_unlock(&hdev->dev);
 	}
 
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 }
 
 /* Implement the continuations for the delays above */
@@ -1724,6 +1723,16 @@ static void hub_release(struct kref *kre
 	kfree(hub);
 }
 
+void hub_get(struct usb_hub *hub)
+{
+	kref_get(&hub->kref);
+}
+
+void hub_put(struct usb_hub *hub)
+{
+	kref_put(&hub->kref, hub_release);
+}
+
 static unsigned highspeed_hubs;
 
 static void hub_disconnect(struct usb_interface *intf)
@@ -1772,7 +1781,7 @@ static void hub_disconnect(struct usb_in
 
 	onboard_hub_destroy_pdevs(&hub->onboard_hub_devs);
 
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 }
 
 static bool hub_descriptor_is_sane(struct usb_host_interface *desc)
@@ -5890,7 +5899,7 @@ out_hdev_lock:
 
 	/* Balance the stuff in kick_hub_wq() and allow autosuspend */
 	usb_autopm_put_interface(intf);
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 
 	kcov_remote_stop();
 }
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -126,6 +126,8 @@ extern void usb_hub_remove_port_device(s
 extern int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
 		int port1, bool set);
 extern struct usb_hub *usb_hub_to_struct_hub(struct usb_device *hdev);
+extern void hub_get(struct usb_hub *hub);
+extern void hub_put(struct usb_hub *hub);
 extern int hub_port_debounce(struct usb_hub *hub, int port1,
 		bool must_be_connected);
 extern int usb_clear_port_feature(struct usb_device *hdev,



