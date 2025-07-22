Return-Path: <stable+bounces-163667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F31CFB0D479
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 10:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2076C5D83
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D272D7805;
	Tue, 22 Jul 2025 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pkMZu12i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CC42D6614
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172617; cv=none; b=fUpfQnxRyImtuBCesC3hURNQ6dvEtenoJ90kZMNuJ3FC7Ml7kPv/eGn68Fpupq9ml4s/5GRvoLzue847Sqzz+pgBfnkTN6YU+nSTfvrikuQkKx7Uh41lu88/6Yts5RDsQCxO3FenbRZdjsmPJsrt68wjwF2IZSfxlEtCAfymz9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172617; c=relaxed/simple;
	bh=uJVqG6ScilmMKsvtFudMQo1RBYU2GMGkmE6xqpplhUU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GsK2yiMEUjVOSAROloT4nXdTe0eqeso15BGYK01/QQiyogF4fXgt0J+clRCpJt2L+If6hgbArcHkSF+g+X0RLYyJMh849pTbZflDRvc2bdoiJZfruxrLSrOq/tdTRpyklwPwkLer9QunvKgk6uKISiWw7HgbjigpIKnXfGt//pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pkMZu12i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807CCC4CEEB;
	Tue, 22 Jul 2025 08:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753172616;
	bh=uJVqG6ScilmMKsvtFudMQo1RBYU2GMGkmE6xqpplhUU=;
	h=Subject:To:Cc:From:Date:From;
	b=pkMZu12ilHaXPFMIlnMQY433zMLva3NFqSgeVJ3lo/tJE0JMAUygVb+c7O5jisgkz
	 Vx0PoZ0RNQ1IS4BiZJN7F9kySzx5kWlJkMUtQRrvkALF87CFwVDHO6NtVlMcLYd1ul
	 ITEwfuG5zFtWiBC5prvjXs0li087oJVDskjSS4uc=
Subject: FAILED: patch "[PATCH] usb: hub: Fix flushing of delayed work used for post resume" failed to apply to 5.4-stable tree
To: mathias.nyman@linux.intel.com,broonie@kernel.org,gregkh@linuxfoundation.org,konrad.dybcio@oss.qualcomm.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Jul 2025 10:23:32 +0200
Message-ID: <2025072232-starlight-oink-cfe5@gregkh>
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
git cherry-pick -x 9bd9c8026341f75f25c53104eb7e656e357ca1a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072232-starlight-oink-cfe5@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9bd9c8026341f75f25c53104eb7e656e357ca1a2 Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Fri, 27 Jun 2025 19:43:48 +0300
Subject: [PATCH] usb: hub: Fix flushing of delayed work used for post resume
 purposes

Delayed work that prevents USB3 hubs from runtime-suspending too early
needed to be flushed in hub_quiesce() to resolve issues detected on
QC SC8280XP CRD board during suspend resume testing.

This flushing did however trigger new issues on Raspberry Pi 3B+, which
doesn't have USB3 ports, and doesn't queue any post resume delayed work.

The flushed 'hub->init_work' item is used for several purposes, and
is originally initialized with a 'NULL' work function. The work function
is also changed on the fly, which may contribute to the issue.

Solve this by creating a dedicated delayed work item for post resume work,
and flush that delayed work in hub_quiesce()

Cc: stable <stable@kernel.org>
Fixes: a49e1e2e785f ("usb: hub: Fix flushing and scheduling of delayed work that tunes runtime pm")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/linux-usb/aF5rNp1l0LWITnEB@finisterre.sirena.org.uk
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # SC8280XP CRD
Tested-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20250627164348.3982628-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 08562711dcf2..3e1215f7a9a0 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1074,12 +1074,11 @@ int usb_remove_device(struct usb_device *udev)
 
 enum hub_activation_type {
 	HUB_INIT, HUB_INIT2, HUB_INIT3,		/* INITs must come first */
-	HUB_POST_RESET, HUB_RESUME, HUB_RESET_RESUME, HUB_POST_RESUME,
+	HUB_POST_RESET, HUB_RESUME, HUB_RESET_RESUME,
 };
 
 static void hub_init_func2(struct work_struct *ws);
 static void hub_init_func3(struct work_struct *ws);
-static void hub_post_resume(struct work_struct *ws);
 
 static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 {
@@ -1103,12 +1102,6 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		goto init3;
 	}
 
-	if (type == HUB_POST_RESUME) {
-		usb_autopm_put_interface_async(to_usb_interface(hub->intfdev));
-		hub_put(hub);
-		return;
-	}
-
 	hub_get(hub);
 
 	/* The superspeed hub except for root hub has to use Hub Depth
@@ -1362,8 +1355,8 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		usb_autopm_get_interface_no_resume(
 			to_usb_interface(hub->intfdev));
 
-		INIT_DELAYED_WORK(&hub->init_work, hub_post_resume);
-		queue_delayed_work(system_power_efficient_wq, &hub->init_work,
+		queue_delayed_work(system_power_efficient_wq,
+				   &hub->post_resume_work,
 				   msecs_to_jiffies(USB_SS_PORT_U0_WAKE_TIME));
 		return;
 	}
@@ -1388,9 +1381,10 @@ static void hub_init_func3(struct work_struct *ws)
 
 static void hub_post_resume(struct work_struct *ws)
 {
-	struct usb_hub *hub = container_of(ws, struct usb_hub, init_work.work);
+	struct usb_hub *hub = container_of(ws, struct usb_hub, post_resume_work.work);
 
-	hub_activate(hub, HUB_POST_RESUME);
+	usb_autopm_put_interface_async(to_usb_interface(hub->intfdev));
+	hub_put(hub);
 }
 
 enum hub_quiescing_type {
@@ -1418,7 +1412,7 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
 
 	/* Stop hub_wq and related activity */
 	timer_delete_sync(&hub->irq_urb_retry);
-	flush_delayed_work(&hub->init_work);
+	flush_delayed_work(&hub->post_resume_work);
 	usb_kill_urb(hub->urb);
 	if (hub->has_indicators)
 		cancel_delayed_work_sync(&hub->leds);
@@ -1977,6 +1971,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	hub->hdev = hdev;
 	INIT_DELAYED_WORK(&hub->leds, led_work);
 	INIT_DELAYED_WORK(&hub->init_work, NULL);
+	INIT_DELAYED_WORK(&hub->post_resume_work, hub_post_resume);
 	INIT_WORK(&hub->events, hub_event);
 	INIT_LIST_HEAD(&hub->onboard_devs);
 	spin_lock_init(&hub->irq_urb_lock);
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index e6ae73f8a95d..9ebc5ef54a32 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -70,6 +70,7 @@ struct usb_hub {
 	u8			indicator[USB_MAXCHILDREN];
 	struct delayed_work	leds;
 	struct delayed_work	init_work;
+	struct delayed_work	post_resume_work;
 	struct work_struct      events;
 	spinlock_t		irq_urb_lock;
 	struct timer_list	irq_urb_retry;


