Return-Path: <stable+bounces-227235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NO2ARK4u2lHmwIAu9opvQ
	(envelope-from <stable+bounces-227235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:47:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A232C8088
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D77123018E11
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B44346AC4;
	Thu, 19 Mar 2026 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3J0melb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8922DFA4
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910008; cv=none; b=P9N1ivslNlUALHtmlnhlYlwXJ2Nb9MpPJwn2ZZpdrm3GLcAFge5n4hnYSDfPpa5eNJ1HH7/v8syLO7oGrbCWnKrnxvocJBsrfGXI5cWPa5RlNsWZ4CY3Pe3MIL5/tbyXrmw11JutyJeY3IEboG5XkS50g1UsZF4cPP7ZRzyb0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910008; c=relaxed/simple;
	bh=yNCVy5eXzx1OF2RHYdmVdbj7luATkIhRigBAH70mGOo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=flJUNtstJSEnHzLK0ZOF/Fr++X+HnDrtjnyhHCLn2xuhT3h2Ysc/zNX2Ur2q2MvZod2QZIJworhmdYa+cdva7s8LdDt3/OmcqxI1ItD68Fddz7WBHUrJ6WPkOBlzCk9KYKpqY68yh+MJawOtMjUmKGoyKUb+goMYzVuAOXnQEpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m3J0melb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aebfa0af7dso51912225ad.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 01:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773910005; x=1774514805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TIdXwdLb4GWT1CEh5fYnvFM9TmOnxGOTFsDM+rsdmHg=;
        b=m3J0melbZe6Y2Ze5XwK/F9PVmMucvOYwY2H2g5zrXeTY5K5JNctsnind7jKIUjFhHE
         vXj3jOT5ao25MYpvYlbT7XTR5YpunEx2Ilw6z6cgUt4uMj4e6aP5Op+XFayDMoo8u9FP
         GPVFCUXFc1rtI7bLuOyob6HBOGe57ihKxwoLUpF69YJD5khf+ELBD+aimL/eIVvF1mN0
         OpSJ1Hs5+XhRsU3vAbDjtK8MD3UL991yn1BZWb7u0S3RYpoz4URm1aU6zhOGhthAWV51
         FeHGAO5Wh41rbun5QvCuH9PFUPyqSfgPgTysxJja5IYjb+zaFuHmg0hb99xizAgAAHd+
         b1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773910005; x=1774514805;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIdXwdLb4GWT1CEh5fYnvFM9TmOnxGOTFsDM+rsdmHg=;
        b=EWKmOY9QcTwlzl8hGa5iiFlRvll9Vk4B8QnFLI8cz0fhbV3caBt91kKySO3AHsJT79
         1gDS/MiwW1Ip2X4WXZ7MsjIjTUDudzPU7L1lxkTuEqpBP/GpHEkH/i2xCU0r1CqSNFjW
         Kl/xCrLLdp3NFV2nCGU/zWymsMPuvrJ+Se5vjijVHn/ikcxljMa2TyM9Rv85opwScIQ1
         P57A7cUlOhEEhgOiJ9/CRX8BnRnJ5AnuBKVlhhcHAALCy/sXw2R/0AVnWXVguhTgAOCx
         D4odGqfwukCyVKaFB9LmIfWmOuPW1iEpPvZ2Ho3olIS1bEDcTgAMyeOS5aKMPJMZ6t9R
         8VCg==
X-Forwarded-Encrypted: i=1; AJvYcCU4Oxh4HaB6sguVxEyeaUs+6ihqv2WQ7xoSzv1/ggRdHnk4lH7zCyib4+2cTGso6Sfy9n0pUIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkxhy6QU4OuklxYB0foTG4r77VCM97kbbR+l1qOvrPJqxSRwtB
	T45daKRDQHzqvDD4zYqvYx2u7XSBkY0a9kRRNPjp/mTVIAsqAYixsrOEwuC0U8vEk+xe/AhTNhU
	6BGt8AQ==
X-Received: from plap4.prod.google.com ([2002:a17:902:f084:b0:2b0:4c25:8ef6])
 (user=hhhuuu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2445:b0:2b0:5e10:9dbd
 with SMTP id d9443c01a7336-2b06e30f40dmr67510615ad.3.1773910005011; Thu, 19
 Mar 2026 01:46:45 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:46:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319084640.478695-1-hhhuuu@google.com>
Subject: [PATCH v3] usb: gadget: f_uvc: fix NULL pointer dereference during
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227235-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[motorola.com,rowland.harvard.edu,ideasonboard.com,xs4all.nl,vger.kernel.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hhhuuu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[harvard.edu:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07A232C8088
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

This patch fixes these issues by:

1. State Synchronization (flag + mutex)
Introduce a 'func_unbound' flag in struct uvc_device. This allows
uvc_function_disconnect() to safely skip accessing the nullified
cdev->gadget pointer. As suggested by Alan Stern, this flag is protected
by a new mutex (uvc->lock) to ensure proper memory ordering and prevent
instruction reordering or speculative loads.

2. Explicit Synchronization (completion)
Use a completion to synchronize uvc_function_unbind() with the
uvc_vdev_release() callback. This prevents Use-After-Free (UAF) by
ensuring struct uvc_device is freed after all video device resources
are released.

Fixes: b81ac4395bbe ("usb: gadget: uvc: allow for application to cleanly shutdown")
Cc: <stable@vger.kernel.org>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
---
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

v2: https://lore.kernel.org/all/20260309053107.2591494-1-hhhuuu@google.com/
v1: https://lore.kernel.org/all/20260224083955.1375032-1-hhhuuu@google.com/

 drivers/usb/gadget/function/f_uvc.c | 35 ++++++++++++++++++++++++++++-
 drivers/usb/gadget/function/uvc.h   |  3 +++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 494fdbc4e85b..390156e70df9 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -413,8 +413,18 @@ uvc_function_disconnect(struct uvc_device *uvc)
 {
 	int ret;
 
+	mutex_lock(&uvc->lock);
+	if (uvc->func_unbound) {
+		pr_debug("%s: %s unbound, skipping function deactivate\n",
+			 uvc->func.name, uvc->func.fi->group.cg_item.ci_name);
+		goto unlock;
+	}
+
 	if ((ret = usb_function_deactivate(&uvc->func)) < 0)
 		uvcg_info(&uvc->func, "UVC disconnect failed with %d\n", ret);
+
+unlock:
+	mutex_unlock(&uvc->lock);
 }
 
 /* --------------------------------------------------------------------------
@@ -431,6 +441,15 @@ static ssize_t function_name_show(struct device *dev,
 
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
@@ -443,7 +462,7 @@ uvc_register_video(struct uvc_device *uvc)
 	uvc->vdev.v4l2_dev->dev = &cdev->gadget->dev;
 	uvc->vdev.fops = &uvc_v4l2_fops;
 	uvc->vdev.ioctl_ops = &uvc_v4l2_ioctl_ops;
-	uvc->vdev.release = video_device_release_empty;
+	uvc->vdev.release = uvc_vdev_release;
 	uvc->vdev.vfl_dir = VFL_DIR_TX;
 	uvc->vdev.lock = &uvc->video.mutex;
 	uvc->vdev.device_caps = V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_STREAMING;
@@ -659,6 +678,9 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	int ret = -EINVAL;
 
 	uvcg_info(f, "%s()\n", __func__);
+	mutex_lock(&uvc->lock);
+	uvc->func_unbound = false;
+	mutex_unlock(&uvc->lock);
 
 	opts = fi_to_f_uvc_opts(f->fi);
 	/* Sanity check the streaming endpoint module parameters. */
@@ -992,8 +1014,13 @@ static void uvc_function_unbind(struct usb_configuration *c,
 	struct uvc_device *uvc = to_uvc(f);
 	struct uvc_video *video = &uvc->video;
 	long wait_ret = 1;
+	DECLARE_COMPLETION_ONSTACK(vdev_release_done);
 
 	uvcg_info(f, "%s()\n", __func__);
+	mutex_lock(&uvc->lock);
+	uvc->func_unbound = true;
+	uvc->vdev_release_done = &vdev_release_done;
+	mutex_unlock(&uvc->lock);
 
 	kthread_cancel_work_sync(&video->hw_submit);
 
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
index 676419a04976..6fa98a173a35 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -155,6 +155,9 @@ struct uvc_device {
 	enum uvc_state state;
 	struct usb_function func;
 	struct uvc_video video;
+	struct completion *vdev_release_done;
+	struct mutex lock;	/* protects func_unbound flag */
+	bool func_unbound;
 	bool func_connected;
 	wait_queue_head_t func_connected_queue;
 

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.53.0.959.g497ff81fa9-goog


