Return-Path: <stable+bounces-227440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFCCHzbvvGme4gIAu9opvQ
	(envelope-from <stable+bounces-227440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 07:54:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9CD2D65B9
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 07:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64509306A522
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 06:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA333563F6;
	Fri, 20 Mar 2026 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jv3PRAzz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7B355F56
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773989673; cv=none; b=T62joPRUY2Y+iyfUuLe3NdMJTDj/BRrJSp6tHBXEHU58NrcM0oJtCDJPhnV3m8yKRhLZWXoZ1AD6ShVwJFchZUhj5nQQJHeuhYZ+bX6U1ZBVc8tbQuXw1T0OD+Zj5EtxDRnBe6y69sTh2fEPAD8iuDA9SLnTp5MbxdDGfeL3zOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773989673; c=relaxed/simple;
	bh=KE7ryRI217ghJKTIFCU76Brwb6dBcjnOO8TMElWQeSM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kFyR1waFNk9AhsFbSrGn9Q0DnxmPy5hs/2EjAEcjS9XAQVOao9vCKLXTDoOEIwwNMj1xHNccR3olLaY25LrFLOoVgBny598Vbm1gtiKRL4TxCl/wM+EySCWdPGM7/bTCK0J7bgn2yYNezp37PsdJzekRqZrVBKlBnFs/Fv1EU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jv3PRAzz; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a11aeee8cso174661b3a.0
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773989672; x=1774594472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/wPANvJo1MTxq8jSz8DIizqvGS0ZDwyTVHtzAj8yEPA=;
        b=jv3PRAzz8TYT75aWjbFwnhs/F3nN1/Y+7++ugH8332iHEvkidLTGjRJc1erYs9DKRT
         NEqHlw5Qb/mZNXsqGhlVtqPt9ROw7eA5PqLVTiyqNJKTFEZ7Y3egMRyyhMqorK5a/Af0
         3cE2B38vbrd5dtTt1HFr/wX9KJFRlU75QfLqDEK91hLZ4rdTtHZrpdghHtucaAA2hPqg
         ryDzx20b9BtJcDuEmdSwaQvgh5P1IwKypZ1lUOfPaVigwVl3XXN33RMXBzq+S0z5oPR4
         l8Ze9OqlH16bNiUmLaj8SkJulJnVjYizQOHm7ONiK5gvutst0M9mm8ppetkWzK/D2vZz
         ciNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773989672; x=1774594472;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/wPANvJo1MTxq8jSz8DIizqvGS0ZDwyTVHtzAj8yEPA=;
        b=lfkrOHPFRVFNnsKR7Rn6ItvOvj6dyNa3aDSc9cBlAaRXImfGRCFsYL1A8qsUdtULbc
         E4pqlzy/8a0DE0O/JjMK3bzT9vMvup8/I2o75qdkKOmG7HN1M7lHOWRKu6gCMtGP11FK
         puWdt+qz4XFqYly+nf1IyPGejV6ULz5HA1OemUw/Bagm5TbQyjxt7gw1M2cNFE8B3ibk
         tVa3vb/8og5pF2khjrw7lo/epVDak5bcy0TSSwgLmkm/9cFqg3RqFDLqybjnFd761v+O
         t7z7FHOL8YHvQVmCDuzSwzPXSygcuvoIaTLQfpaCSIJyBEacOdp20LQ5lrhWq/1o2gT0
         eLOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVugOSPYbfWbW7w5CxU61JLIvi4mPO25IfIz9y8Z6n28jTSm/n2G2CbfQdLTfiirqOb26BAFk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySqJ99V5EwlC9p7sKhd/hjsj1Yy2t1uGC373248kbDG4pJl+CU
	bj7EjeqOvNgkhOsd/T3Rp+fkKQgGEqgU071DiWIsb6+0RUxZrdZ7z6/9qPdwCBGbEzTQsAkz3+E
	7+LZ6mQ==
X-Received: from pfbhh2.prod.google.com ([2002:a05:6a00:8682:b0:824:1dc9:90db])
 (user=hhhuuu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1392:b0:827:2995:3b99
 with SMTP id d2e1a72fcca58-82a8c324815mr1582927b3a.31.1773989671540; Thu, 19
 Mar 2026 23:54:31 -0700 (PDT)
Date: Fri, 20 Mar 2026 14:54:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320065427.1374555-1-hhhuuu@google.com>
Subject: [PATCH v4] usb: gadget: uvc: fix NULL pointer dereference during
 unbind race
From: Jimmy Hu <hhhuuu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Vacura <w36195@motorola.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Jimmy Hu <hhhuuu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227440-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[motorola.com,rowland.harvard.edu,ideasonboard.com,xs4all.nl,vger.kernel.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hhhuuu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.958];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[harvard.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D9CD2D65B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Cc: <stable@vger.kernel.org>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
---
v3 -> v4:
- Replaced pr_debug() with dev_dbg(), as suggested by Greg KH.
- Used guard() and scoped_guard(), as suggested by Greg KH.
- Expanded 'uvc->lock' to protect 'func_unbound' and 'func_connected', 
  using a local copy in unbind() to avoid wait_event() deadlocks.

v2 -> v3:
- Replaced pr_info() with pr_debug() instead of uvcg_info() to stay quiet 
  and avoided potential NULL pointer dereferences on cdev->gadget, as 
  suggested by Greg KH.
- Replaced kref-based lifecycle management with a completion to synchronize 
  uvc_function_unbind() with the video device release callback, avoiding 
  redundant reference counting, as suggested by Greg KH.
- Added a proper comment for 'lock' in struct uvc_device to describe 
  what it protects, as suggested by Greg KH.

v1 -> v2:
- Renamed 'func_unbinding' to 'func_unbound' for clearer state semantics.
- Added a mutex (uvc->lock) to protect the 'func_unbound' flag and ensure
  proper memory ordering, as suggested by Alan Stern.
- Integrated kref to manage the struct uvc_device lifecycle, allowing the 
  removal of redundant buffer cleanup skip logic in uvc_v4l2_disable().

v3: https://lore.kernel.org/all/20260319084640.478695-1-hhhuuu@google.com/
v2: https://lore.kernel.org/all/20260309053107.2591494-1-hhhuuu@google.com/
v1: https://lore.kernel.org/all/20260224083955.1375032-1-hhhuuu@google.com/

 drivers/usb/gadget/function/f_uvc.c    | 39 ++++++++++++++++++++++++--
 drivers/usb/gadget/function/uvc.h      |  3 ++
 drivers/usb/gadget/function/uvc_v4l2.c |  5 +++-
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 494fdbc4e85b..8d404d88391c 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -413,6 +413,12 @@ uvc_function_disconnect(struct uvc_device *uvc)
 {
 	int ret;
 
+	guard(mutex)(&uvc->lock);
+	if (uvc->func_unbound) {
+		dev_dbg(&uvc->vdev.dev, "skipping function deactivate (unbound)\n");
+		return;
+	}
+
 	if ((ret = usb_function_deactivate(&uvc->func)) < 0)
 		uvcg_info(&uvc->func, "UVC disconnect failed with %d\n", ret);
 }
@@ -431,6 +437,15 @@ static ssize_t function_name_show(struct device *dev,
 
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
@@ -443,7 +458,7 @@ uvc_register_video(struct uvc_device *uvc)
 	uvc->vdev.v4l2_dev->dev = &cdev->gadget->dev;
 	uvc->vdev.fops = &uvc_v4l2_fops;
 	uvc->vdev.ioctl_ops = &uvc_v4l2_ioctl_ops;
-	uvc->vdev.release = video_device_release_empty;
+	uvc->vdev.release = uvc_vdev_release;
 	uvc->vdev.vfl_dir = VFL_DIR_TX;
 	uvc->vdev.lock = &uvc->video.mutex;
 	uvc->vdev.device_caps = V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_STREAMING;
@@ -659,6 +674,8 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	int ret = -EINVAL;
 
 	uvcg_info(f, "%s()\n", __func__);
+	scoped_guard(mutex, &uvc->lock)
+		uvc->func_unbound = false;
 
 	opts = fi_to_f_uvc_opts(f->fi);
 	/* Sanity check the streaming endpoint module parameters. */
@@ -988,12 +1005,19 @@ static void uvc_free(struct usb_function *f)
 static void uvc_function_unbind(struct usb_configuration *c,
 				struct usb_function *f)
 {
+	DECLARE_COMPLETION_ONSTACK(vdev_release_done);
 	struct usb_composite_dev *cdev = c->cdev;
 	struct uvc_device *uvc = to_uvc(f);
 	struct uvc_video *video = &uvc->video;
 	long wait_ret = 1;
+	bool connected;
 
 	uvcg_info(f, "%s()\n", __func__);
+	scoped_guard(mutex, &uvc->lock) {
+		uvc->func_unbound = true;
+		uvc->vdev_release_done = &vdev_release_done;
+		connected = uvc->func_connected;
+	}
 
 	kthread_cancel_work_sync(&video->hw_submit);
 
@@ -1006,7 +1030,7 @@ static void uvc_function_unbind(struct usb_configuration *c,
 	 * though the video device removal uevent. Allow some time for the
 	 * application to close out before things get deleted.
 	 */
-	if (uvc->func_connected) {
+	if (connected) {
 		uvcg_dbg(f, "waiting for clean disconnect\n");
 		wait_ret = wait_event_interruptible_timeout(uvc->func_connected_queue,
 				uvc->func_connected == false, msecs_to_jiffies(500));
@@ -1017,7 +1041,10 @@ static void uvc_function_unbind(struct usb_configuration *c,
 	video_unregister_device(&uvc->vdev);
 	v4l2_device_unregister(&uvc->v4l2_dev);
 
-	if (uvc->func_connected) {
+	scoped_guard(mutex, &uvc->lock)
+		connected = uvc->func_connected;
+
+	if (connected) {
 		/*
 		 * Wait for the release to occur to ensure there are no longer any
 		 * pending operations that may cause panics when resources are cleaned
@@ -1029,6 +1056,10 @@ static void uvc_function_unbind(struct usb_configuration *c,
 		uvcg_dbg(f, "done waiting for release with ret: %ld\n", wait_ret);
 	}
 
+	/* Wait for the video device to be released */
+	wait_for_completion(&vdev_release_done);
+	uvc->vdev_release_done = NULL;
+
 	usb_ep_free_request(cdev->gadget->ep0, uvc->control_req);
 	kfree(uvc->control_buf);
 
@@ -1047,6 +1078,8 @@ static struct usb_function *uvc_alloc(struct usb_function_instance *fi)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&uvc->video.mutex);
+	mutex_init(&uvc->lock);
+	uvc->func_unbound = true;
 	uvc->state = UVC_STATE_DISCONNECTED;
 	init_waitqueue_head(&uvc->func_connected_queue);
 	opts = fi_to_f_uvc_opts(fi);
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 676419a04976..7abfdd5e1eef 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -155,6 +155,9 @@ struct uvc_device {
 	enum uvc_state state;
 	struct usb_function func;
 	struct uvc_video video;
+	struct completion *vdev_release_done;
+	struct mutex lock;	/* protects func_unbound and func_connected */
+	bool func_unbound;
 	bool func_connected;
 	wait_queue_head_t func_connected_queue;
 
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index ed48d38498fb..514e5930b9ca 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -574,6 +574,8 @@ uvc_v4l2_subscribe_event(struct v4l2_fh *fh,
 	if (sub->type < UVC_EVENT_FIRST || sub->type > UVC_EVENT_LAST)
 		return -EINVAL;
 
+	guard(mutex)(&uvc->lock);
+
 	if (sub->type == UVC_EVENT_SETUP && uvc->func_connected)
 		return -EBUSY;
 
@@ -595,7 +597,8 @@ static void uvc_v4l2_disable(struct uvc_device *uvc)
 	uvc_function_disconnect(uvc);
 	uvcg_video_disable(&uvc->video);
 	uvcg_free_buffers(&uvc->video.queue);
-	uvc->func_connected = false;
+	scoped_guard(mutex, &uvc->lock)
+		uvc->func_connected = false;
 	wake_up_interruptible(&uvc->func_connected_queue);
 }
 

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.53.0.959.g497ff81fa9-goog


