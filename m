Return-Path: <stable+bounces-235748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEI8DXN32mn82ggAu9opvQ
	(envelope-from <stable+bounces-235748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:31:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 882C63E0DD7
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A70301FD7B
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2812D2488;
	Sat, 11 Apr 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbdL375O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E1201278
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775925077; cv=none; b=s6ibEroIi7s4s99jEJCbdggjRh8CV2QfscZsRgOrpy+Sa7App8J0YY5JZ+mRr98syapajluH2jRuahNxQvpqWBfkKAvjXWiDH7vyLGngdrfiDCadXEdgFyfyq7y1pywxqitcuU7IWcewbakQ/DkSu1Z/aj/9jf9GaSWX7lDR37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775925077; c=relaxed/simple;
	bh=On8ReSxPJ5qBkpomhFYtGtrJJCZijBIsdWJBM7AxDMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiocbD0IuCMycLt1MmWeFzeJhwCL9SViEt7swJj+dTcFBwxnHoSAa83DMWw69P4d9Kw/mG+tJwmB2yyuQlKfB5pKpAsjioqkXxE5o7fZuNjL9be8HB6qExPvjGDIy0mT8M7RLjCWMwLP/3ZmlHGrPH3R3MrcVGpat/bNZ+YeI94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbdL375O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB86C4CEF7;
	Sat, 11 Apr 2026 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775925077;
	bh=On8ReSxPJ5qBkpomhFYtGtrJJCZijBIsdWJBM7AxDMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rbdL375Oupw+IMDYQ1uFFSveyPyGsgM02EaViZGFUupKdbppz30UNPKK8Y9EzWaPM
	 87sThvcRxMysvVoTiTzy2ek2ohfPYrP6nyKKpETeQ/CLQNQo2y1uyAKd9WU5NmFhWt
	 n1FIbLxmBlKueyVtB/6qamjmXNuB8pRDbu35QRAii7BRrUq8f2SLeSdqcFi1f3z6ez
	 dUGxcuqddCvoq0v46n+iwiBu/eTS61DqkKutcDUZ1aXX0D3IZyFHVI6NavXQji3dXI
	 Wz10S8Ga8JQ0PNzHUQaj0vGv/Uixnsy4Tx3rpKkhwbKisaMy7VZmW6OiEJJtq7zJlS
	 CRPLkXkUbeoUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jimmy Hu <hhhuuu@google.com>,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: gadget: uvc: fix NULL pointer dereference during unbind race
Date: Sat, 11 Apr 2026 12:31:15 -0400
Message-ID: <20260411163115.807395-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040805-algebra-rebalance-8bdc@gregkh>
References: <2026040805-algebra-rebalance-8bdc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235748-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,harvard.edu:email]
X-Rspamd-Queue-Id: 882C63E0DD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jimmy Hu <hhhuuu@google.com>

[ Upstream commit eba2936bbe6b752a31725a9eb5c674ecbf21ee7d ]

Commit b81ac4395bbe ("usb: gadget: uvc: allow for application to cleanly
shutdown") introduced two stages of synchronization waits totaling 1500ms
in uvc_function_unbind() to prevent several types of kernel panics.
However, this timing-based approach is insufficient during power
management (PM) transitions.

When the PM subsystem starts freezing user space processes, the
wait_event_interruptible_timeout() is aborted early, which allows the
unbind thread to proceed and nullify the gadget pointer
(cdev->gadget = NULL):

[  814.123447][  T947] configfs-gadget.g1 gadget.0: uvc: uvc_function_unbind()
[  814.178583][ T3173] PM: suspend entry (deep)
[  814.192487][ T3173] Freezing user space processes
[  814.197668][  T947] configfs-gadget.g1 gadget.0: uvc: uvc_function_unbind no clean disconnect, wait for release

When the PM subsystem resumes or aborts the suspend and tasks are
restarted, the V4L2 release path is executed and attempts to access the
already nullified gadget pointer, triggering a kernel panic:

[  814.292597][    C0] PM: pm_system_irq_wakeup: 479 triggered dhdpcie_host_wake
[  814.386727][ T3173] Restarting tasks ...
[  814.403522][ T4558] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
[  814.404021][ T4558] pc : usb_gadget_deactivate+0x14/0xf4
[  814.404031][ T4558] lr : usb_function_deactivate+0x54/0x94
[  814.404078][ T4558] Call trace:
[  814.404080][ T4558]  usb_gadget_deactivate+0x14/0xf4
[  814.404083][ T4558]  usb_function_deactivate+0x54/0x94
[  814.404087][ T4558]  uvc_function_disconnect+0x1c/0x5c
[  814.404092][ T4558]  uvc_v4l2_release+0x44/0xac
[  814.404095][ T4558]  v4l2_release+0xcc/0x130

Address the race condition and NULL pointer dereference by:

1. State Synchronization (flag + mutex)
Introduce a 'func_unbound' flag in struct uvc_device. This allows
uvc_function_disconnect() to safely skip accessing the nullified
cdev->gadget pointer. As suggested by Alan Stern, this flag is protected
by a new mutex (uvc->lock) to ensure proper memory ordering and prevent
instruction reordering or speculative loads. This mutex is also used to
protect 'func_connected' for consistent state management.

2. Explicit Synchronization (completion)
Use a completion to synchronize uvc_function_unbind() with the
uvc_vdev_release() callback. This prevents Use-After-Free (UAF) by
ensuring struct uvc_device is freed after all video device resources
are released.

Fixes: b81ac4395bbe ("usb: gadget: uvc: allow for application to cleanly shutdown")
Cc: stable <stable@kernel.org>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
Link: https://patch.msgid.link/20260320065427.1374555-1-hhhuuu@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ replaced guard()/scoped_guard() macros ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_uvc.c    | 46 +++++++++++++++++++++++---
 drivers/usb/gadget/function/uvc.h      |  3 ++
 drivers/usb/gadget/function/uvc_v4l2.c | 13 ++++++--
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 5d39aff263f00..7821e72842220 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -393,6 +393,14 @@ uvc_function_disconnect(struct uvc_device *uvc)
 {
 	int ret;
 
+	mutex_lock(&uvc->lock);
+	if (uvc->func_unbound) {
+		dev_dbg(&uvc->vdev.dev, "skipping function deactivate (unbound)\n");
+		mutex_unlock(&uvc->lock);
+		return;
+	}
+	mutex_unlock(&uvc->lock);
+
 	if ((ret = usb_function_deactivate(&uvc->func)) < 0)
 		uvcg_info(&uvc->func, "UVC disconnect failed with %d\n", ret);
 }
@@ -411,6 +419,15 @@ static ssize_t function_name_show(struct device *dev,
 
 static DEVICE_ATTR_RO(function_name);
 
+static void uvc_vdev_release(struct video_device *vdev)
+{
+	struct uvc_device *uvc = video_get_drvdata(vdev);
+
+	/* Signal uvc_function_unbind() that the video device has been released */
+	if (uvc->vdev_release_done)
+		complete(uvc->vdev_release_done);
+}
+
 static int
 uvc_register_video(struct uvc_device *uvc)
 {
@@ -421,7 +438,7 @@ uvc_register_video(struct uvc_device *uvc)
 	uvc->vdev.v4l2_dev = &uvc->v4l2_dev;
 	uvc->vdev.fops = &uvc_v4l2_fops;
 	uvc->vdev.ioctl_ops = &uvc_v4l2_ioctl_ops;
-	uvc->vdev.release = video_device_release_empty;
+	uvc->vdev.release = uvc_vdev_release;
 	uvc->vdev.vfl_dir = VFL_DIR_TX;
 	uvc->vdev.lock = &uvc->video.mutex;
 	uvc->vdev.device_caps = V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_STREAMING;
@@ -595,6 +612,9 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	int ret = -EINVAL;
 
 	uvcg_info(f, "%s()\n", __func__);
+	mutex_lock(&uvc->lock);
+	uvc->func_unbound = false;
+	mutex_unlock(&uvc->lock);
 
 	opts = fi_to_f_uvc_opts(f->fi);
 	/* Sanity check the streaming endpoint module parameters.
@@ -887,18 +907,25 @@ static void uvc_free(struct usb_function *f)
 static void uvc_function_unbind(struct usb_configuration *c,
 				struct usb_function *f)
 {
+	DECLARE_COMPLETION_ONSTACK(vdev_release_done);
 	struct usb_composite_dev *cdev = c->cdev;
 	struct uvc_device *uvc = to_uvc(f);
 	long wait_ret = 1;
+	bool connected;
 
 	uvcg_info(f, "%s()\n", __func__);
+	mutex_lock(&uvc->lock);
+	uvc->func_unbound = true;
+	uvc->vdev_release_done = &vdev_release_done;
+	connected = uvc->func_connected;
+	mutex_unlock(&uvc->lock);
 
 	/* If we know we're connected via v4l2, then there should be a cleanup
 	 * of the device from userspace either via UVC_EVENT_DISCONNECT or
 	 * though the video device removal uevent. Allow some time for the
 	 * application to close out before things get deleted.
 	 */
-	if (uvc->func_connected) {
+	if (connected) {
 		uvcg_dbg(f, "waiting for clean disconnect\n");
 		wait_ret = wait_event_interruptible_timeout(uvc->func_connected_queue,
 				uvc->func_connected == false, msecs_to_jiffies(500));
@@ -909,8 +936,13 @@ static void uvc_function_unbind(struct usb_configuration *c,
 	video_unregister_device(&uvc->vdev);
 	v4l2_device_unregister(&uvc->v4l2_dev);
 
-	if (uvc->func_connected) {
-		/* Wait for the release to occur to ensure there are no longer any
+	mutex_lock(&uvc->lock);
+	connected = uvc->func_connected;
+	mutex_unlock(&uvc->lock);
+
+	if (connected) {
+		/*
+		 * Wait for the release to occur to ensure there are no longer any
 		 * pending operations that may cause panics when resources are cleaned
 		 * up.
 		 */
@@ -920,6 +952,10 @@ static void uvc_function_unbind(struct usb_configuration *c,
 		uvcg_dbg(f, "done waiting for release with ret: %ld\n", wait_ret);
 	}
 
+	/* Wait for the video device to be released */
+	wait_for_completion(&vdev_release_done);
+	uvc->vdev_release_done = NULL;
+
 	usb_ep_free_request(cdev->gadget->ep0, uvc->control_req);
 	kfree(uvc->control_buf);
 
@@ -937,6 +973,8 @@ static struct usb_function *uvc_alloc(struct usb_function_instance *fi)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&uvc->video.mutex);
+	mutex_init(&uvc->lock);
+	uvc->func_unbound = true;
 	uvc->state = UVC_STATE_DISCONNECTED;
 	init_waitqueue_head(&uvc->func_connected_queue);
 	opts = fi_to_f_uvc_opts(fi);
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 6c4fc4913f4fd..ff67d0c4ebc43 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -118,6 +118,9 @@ struct uvc_device {
 	enum uvc_state state;
 	struct usb_function func;
 	struct uvc_video video;
+	struct completion *vdev_release_done;
+	struct mutex lock;	/* protects func_unbound and func_connected */
+	bool func_unbound;
 	bool func_connected;
 	wait_queue_head_t func_connected_queue;
 
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index 65abd55ce2348..2a1efaf3708ee 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -234,12 +234,18 @@ uvc_v4l2_subscribe_event(struct v4l2_fh *fh,
 	if (sub->type < UVC_EVENT_FIRST || sub->type > UVC_EVENT_LAST)
 		return -EINVAL;
 
-	if (sub->type == UVC_EVENT_SETUP && uvc->func_connected)
+	mutex_lock(&uvc->lock);
+
+	if (sub->type == UVC_EVENT_SETUP && uvc->func_connected) {
+		mutex_unlock(&uvc->lock);
 		return -EBUSY;
+	}
 
 	ret = v4l2_event_subscribe(fh, sub, 2, NULL);
-	if (ret < 0)
+	if (ret < 0) {
+		mutex_unlock(&uvc->lock);
 		return ret;
+	}
 
 	if (sub->type == UVC_EVENT_SETUP) {
 		uvc->func_connected = true;
@@ -247,6 +253,7 @@ uvc_v4l2_subscribe_event(struct v4l2_fh *fh,
 		uvc_function_connect(uvc);
 	}
 
+	mutex_unlock(&uvc->lock);
 	return 0;
 }
 
@@ -255,7 +262,9 @@ static void uvc_v4l2_disable(struct uvc_device *uvc)
 	uvc_function_disconnect(uvc);
 	uvcg_video_enable(&uvc->video, 0);
 	uvcg_free_buffers(&uvc->video.queue);
+	mutex_lock(&uvc->lock);
 	uvc->func_connected = false;
+	mutex_unlock(&uvc->lock);
 	wake_up_interruptible(&uvc->func_connected_queue);
 }
 
-- 
2.53.0


