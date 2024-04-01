Return-Path: <stable+bounces-33909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D352D8939A2
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 11:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9431F22197
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D861078F;
	Mon,  1 Apr 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZfWdEqb6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC311CB0
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964642; cv=none; b=bZKWT+xP7KLasrtkjAEvNxaBeVqtx71DJrGoP3rEFgAISDSmyPdmMCqrxAjN1DFy9aG4gOxnglfI3OtUuDC1GPLeE9RXVrBkwAixxmNVWzUDf3xhzOYfXLffxEMxXghgWSgWmBXKDjyxZ4ikGwp3QmgsMKu5y4JHgiIZT/AwDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964642; c=relaxed/simple;
	bh=tMtoUCVwAXJI1F/0FXhu5HB8CqJtnVZNIDOiXejMNWM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pMVJzi7Wuw1VPKU48I71LFGMOyLePNE15dRFn5eU6zvL2cIiwYhVAJJI4RjiF+4jgMP1VYsGphtu7qqfZt4IT8E4Mav+fDoBbRM8wiV+JlvrLEHQSABRzcw2LvgVAdT3SPJPLAlk+ZQKiJUqOtEyqEbqr4XGbQIU69/KUCwdyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZfWdEqb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD87DC433F1;
	Mon,  1 Apr 2024 09:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711964642;
	bh=tMtoUCVwAXJI1F/0FXhu5HB8CqJtnVZNIDOiXejMNWM=;
	h=Subject:To:Cc:From:Date:From;
	b=ZfWdEqb6U2Pay3TszkDQnNotGeXfCKAqbYOci1kw0B7jZ6cjwrHVJrnisg7cE8jwQ
	 EeuXA4p3smXw4xtKYYii7sx10PL6vsHO7AxoX7ysePFDpAGH0Lqyc5DqEY1fQO8I3Q
	 2UjeXWUIXzxL7kOUrXv2ihI/ODOdjcOcx3tUT2Ks=
Subject: FAILED: patch "[PATCH] USB: core: Add hub_get() and hub_put() routines" failed to apply to 5.4-stable tree
To: stern@rowland.harvard.edu,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Apr 2024 11:43:58 +0200
Message-ID: <2024040158-stump-bucked-e91c@gregkh>
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
git cherry-pick -x ee113b860aa169e9a4d2c167c95d0f1961c6e1b8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040158-stump-bucked-e91c@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

ee113b860aa1 ("USB: core: Add hub_get() and hub_put() routines")
3a6bf4a08142 ("usb: core: hub: Create platform devices for onboard hubs in hub_probe()")
1208f9e1d758 ("USB: hub: Fix the broken detection of USB3 device in SMSC hub")
95d23dc27bde ("usb, kcov: collect coverage from hub_event")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee113b860aa169e9a4d2c167c95d0f1961c6e1b8 Mon Sep 17 00:00:00 2001
From: Alan Stern <stern@rowland.harvard.edu>
Date: Fri, 15 Mar 2024 13:04:50 -0400
Subject: [PATCH] USB: core: Add hub_get() and hub_put() routines

Create hub_get() and hub_put() routines to encapsulate the kref_get()
and kref_put() calls in hub.c.  The new routines will be used by the
next patch in this series.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/604da420-ae8a-4a9e-91a4-2d511ff404fb@rowland.harvard.edu
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 3ee8455585b6..9446660e231b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -130,7 +130,6 @@ EXPORT_SYMBOL_GPL(ehci_cf_port_reset_rwsem);
 #define HUB_DEBOUNCE_STEP	  25
 #define HUB_DEBOUNCE_STABLE	 100
 
-static void hub_release(struct kref *kref);
 static int usb_reset_and_verify_device(struct usb_device *udev);
 static int hub_port_disable(struct usb_hub *hub, int port1, int set_state);
 static bool hub_port_warm_reset_required(struct usb_hub *hub, int port1,
@@ -720,14 +719,14 @@ static void kick_hub_wq(struct usb_hub *hub)
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
@@ -1095,7 +1094,7 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 			goto init2;
 		goto init3;
 	}
-	kref_get(&hub->kref);
+	hub_get(hub);
 
 	/* The superspeed hub except for root hub has to use Hub Depth
 	 * value as an offset into the route string to locate the bits
@@ -1343,7 +1342,7 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		device_unlock(&hdev->dev);
 	}
 
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 }
 
 /* Implement the continuations for the delays above */
@@ -1759,6 +1758,16 @@ static void hub_release(struct kref *kref)
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
@@ -1807,7 +1816,7 @@ static void hub_disconnect(struct usb_interface *intf)
 
 	onboard_hub_destroy_pdevs(&hub->onboard_hub_devs);
 
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 }
 
 static bool hub_descriptor_is_sane(struct usb_host_interface *desc)
@@ -5934,7 +5943,7 @@ static void hub_event(struct work_struct *work)
 
 	/* Balance the stuff in kick_hub_wq() and allow autosuspend */
 	usb_autopm_put_interface(intf);
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 
 	kcov_remote_stop();
 }
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 43ce21c96a51..183b69dc2955 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -129,6 +129,8 @@ extern void usb_hub_remove_port_device(struct usb_hub *hub,
 extern int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
 		int port1, bool set);
 extern struct usb_hub *usb_hub_to_struct_hub(struct usb_device *hdev);
+extern void hub_get(struct usb_hub *hub);
+extern void hub_put(struct usb_hub *hub);
 extern int hub_port_debounce(struct usb_hub *hub, int port1,
 		bool must_be_connected);
 extern int usb_clear_port_feature(struct usb_device *hdev,


