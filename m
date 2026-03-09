Return-Path: <stable+bounces-223493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v6nVAytbrmkpCgIAu9opvQ
	(envelope-from <stable+bounces-223493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 06:31:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD778233EB6
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 06:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B6DF3012873
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 05:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E07313537;
	Mon,  9 Mar 2026 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmmBfnpW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B87820DE3
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773034275; cv=none; b=CWcelRR/Z82AiGLxyk/h0CxpS8/kNVMt7JW0VLP76b15RWHVp0Gkig8oA498FbUBYY6CAcN/MqjTVh4Cojw5C9yck2aKE7CJgopk5r3yr+SDij4aeYhjO8SBTu5s9UuLgPAs1qU0IquXKdy52OjjO5rLzUuKYPOW4+/mx3NhnI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773034275; c=relaxed/simple;
	bh=sL41Qlw2uVKdjiA6AJ3MSq6wQiEX+X0x+5AelMD1nY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nzkBRb5cI2awClzNFdeAnM3UVhRad2dFD/XwP/vzVmMqTMK0LZYEB0sH/pkV6Pq/lItgvlnIIUlnnfut4YoYVJ+UuKriOq2vs2I2SepWAJC/gl/PaTPHbUgTWD+5SuBA6NQbNsLnnJMxKCKuL3Pl+0RBpUPq1f1PVb7uYzfhcWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmmBfnpW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c738662b963so2873871a12.0
        for <stable@vger.kernel.org>; Sun, 08 Mar 2026 22:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773034272; x=1773639072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4e2d0zR+YICG3x4BqXaU4k+VrwxgDuOe9nAJceukt/M=;
        b=OmmBfnpWTC/uZZv0AfUv8P4oYphTRHEJgyuk62j/dWLNcrWAsq6TmH+XWMPC2UOvvs
         n8+uiN/cu0V/9KaV4SMJezu17/3QoVewT88Lohj8gkzvoKNqqH/wHpCAaiW4UYDtxDOL
         2pfRylE+zd+iMLhNaVt1UWiJ9iUnfd6WsvQUuW4cQ6bPnnNWK214ykuVQCDekqqBHiXR
         NXSWKYWYBEkb/z099pRNZNwQR9ajRQisKqsGTU+w374Vz2/LzKwz2YiX7PLUksNGrnA7
         iMqxfYoDuCkgYZobJWXQFzvplWlVBbitA1s1iQzkuoF2C/DqRwVfudiHaSbyG/2b/paf
         5w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773034272; x=1773639072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4e2d0zR+YICG3x4BqXaU4k+VrwxgDuOe9nAJceukt/M=;
        b=fJObO7QxWDCyzXIlNg/E68Yfx3kWk0pfspYuevh5q5vlseT1IrLoeA9DI9IfCXTuDt
         1DsrXheDqi78luWNYesXfI+Qoc5JO9JwGSGKFFAFlR9bdfHDl7OSQlmelero+GM8j0j3
         cLGqCaglvn71q678OgTqCLH8QS6z4thZYFOAUDX/YEbnnPLIOwuGyVHbpXch1ArFM+m4
         80IttIkMKrxyt2QWgpxB9EGSzbnhyRryCoB/vhFIqJFYIDVCDHCfoFY5DJoCJXAFKkJA
         axfg93s91TZ5GDDF3utIqlL55KzRDCZxoqx/EXBMwogTeyqdV60IScoRJwR57bRlWMAy
         73oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgjebB8glAIspyyTuYUUquXzrFGV7/Y3pz4mcverkr6UrWneJmguxufqoz/ckv1meauuay6O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuPtNAdVKutAHNw4vCGGm2xgcNduCSFygAttyhFHIS4hsPQ3Ce
	lrKVowvvRK6yTT3sqekgyhgiTyZuOw5qXvhrVR+q9c6jgU7GmKHlrZPJfzipQlncQ2HLlsDxY4b
	QY3xAkA==
X-Received: from pgbdn1.prod.google.com ([2002:a05:6a02:e01:b0:c6e:8a54:4017])
 (user=hhhuuu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e92:b0:398:9301:b9d3
 with SMTP id adf61e73a8af0-3989301d42bmr1618729637.7.1773034272326; Sun, 08
 Mar 2026 22:31:12 -0700 (PDT)
Date: Mon,  9 Mar 2026 13:31:07 +0800
In-Reply-To: <20260224083955.1375032-1-hhhuuu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260224083955.1375032-1-hhhuuu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309053107.2591494-1-hhhuuu@google.com>
Subject: [PATCH v2] usb: gadget: f_uvc: fix NULL pointer dereference during
 unbind race
From: Jimmy Hu <hhhuuu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Dan Vacura <w36195@motorola.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, badhri@google.com, Jimmy Hu <hhhuuu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DD778233EB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223493-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hhhuuu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.932];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,harvard.edu:email]
X-Rspamd-Action: no action

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

This patch introduces the following safeguards:

1. State Synchronization (flag + mutex)
Introduced a 'func_unbound' flag in struct uvc_device. This allows
uvc_function_disconnect() to safely skip accessing the nullified
cdev->gadget pointer. As suggested by Alan Stern, this flag is protected
by a new mutex (uvc->lock) to ensure proper memory ordering and prevent
instruction reordering or speculative loads.

2. Lifecycle Management (kref)
Introduced kref to manage the struct uvc_device lifecycle. This prevents
Use-After-Free (UAF) by ensuring the structure is only freed after the
final reference, including the V4L2 release path, is dropped.

Fixes: b81ac4395bbe ("usb: gadget: uvc: allow for application to cleanly shutdown")
Cc: <stable@vger.kernel.org>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
---
v1 -> v2:
- Renamed 'func_unbinding' to 'func_unbound' for clearer state semantics.
- Added a mutex (uvc->lock) to protect the 'func_unbound' flag and ensure
  proper memory ordering, as suggested by Alan Stern.
- Integrated kref to manage the struct uvc_device lifecycle, allowing the 
  removal of redundant buffer cleanup skip logic in uvc_v4l2_disable().
  
v1: https://patchwork.kernel.org/project/linux-usb/patch/20260224083955.1375032-1-hhhuuu@google.com/

 drivers/usb/gadget/function/f_uvc.c    | 27 +++++++++++++++++++++++++-
 drivers/usb/gadget/function/uvc.h      |  4 ++++
 drivers/usb/gadget/function/uvc_v4l2.c |  2 ++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 494fdbc4e85b..485cd91770d5 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -413,8 +413,17 @@ uvc_function_disconnect(struct uvc_device *uvc)
 {
 	int ret;
 
+	mutex_lock(&uvc->lock);
+	if (uvc->func_unbound) {
+		pr_info("uvc: unbound, skipping function deactivate\n");
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
@@ -659,6 +668,9 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	int ret = -EINVAL;
 
 	uvcg_info(f, "%s()\n", __func__);
+	mutex_lock(&uvc->lock);
+	uvc->func_unbound = false;
+	mutex_unlock(&uvc->lock);
 
 	opts = fi_to_f_uvc_opts(f->fi);
 	/* Sanity check the streaming endpoint module parameters. */
@@ -974,6 +986,13 @@ static struct usb_function_instance *uvc_alloc_inst(void)
 	return &opts->func_inst;
 }
 
+void uvc_device_release(struct kref *kref)
+{
+	struct uvc_device *uvc = container_of(kref, struct uvc_device, kref);
+
+	kfree(uvc);
+}
+
 static void uvc_free(struct usb_function *f)
 {
 	struct uvc_device *uvc = to_uvc(f);
@@ -982,7 +1001,7 @@ static void uvc_free(struct usb_function *f)
 	if (!opts->header)
 		config_item_put(&uvc->header->item);
 	--opts->refcnt;
-	kfree(uvc);
+	kref_put(&uvc->kref, uvc_device_release);
 }
 
 static void uvc_function_unbind(struct usb_configuration *c,
@@ -994,6 +1013,9 @@ static void uvc_function_unbind(struct usb_configuration *c,
 	long wait_ret = 1;
 
 	uvcg_info(f, "%s()\n", __func__);
+	mutex_lock(&uvc->lock);
+	uvc->func_unbound = true;
+	mutex_unlock(&uvc->lock);
 
 	kthread_cancel_work_sync(&video->hw_submit);
 
@@ -1046,8 +1068,11 @@ static struct usb_function *uvc_alloc(struct usb_function_instance *fi)
 	if (uvc == NULL)
 		return ERR_PTR(-ENOMEM);
 
+	kref_init(&uvc->kref);
+	mutex_init(&uvc->lock);
 	mutex_init(&uvc->video.mutex);
 	uvc->state = UVC_STATE_DISCONNECTED;
+	uvc->func_unbound = true;
 	init_waitqueue_head(&uvc->func_connected_queue);
 	opts = fi_to_f_uvc_opts(fi);
 
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 676419a04976..22b70f25607d 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -155,6 +155,9 @@ struct uvc_device {
 	enum uvc_state state;
 	struct usb_function func;
 	struct uvc_video video;
+	struct kref kref;
+	struct mutex lock;
+	bool func_unbound;
 	bool func_connected;
 	wait_queue_head_t func_connected_queue;
 
@@ -209,5 +212,6 @@ static inline struct uvc_file_handle *file_to_uvc_file_handle(struct file *filp)
 extern void uvc_function_setup_continue(struct uvc_device *uvc, int disable_ep);
 extern void uvc_function_connect(struct uvc_device *uvc);
 extern void uvc_function_disconnect(struct uvc_device *uvc);
+extern void uvc_device_release(struct kref *kref);
 
 #endif /* _UVC_GADGET_H_ */
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index ed48d38498fb..2dae27f05e2a 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -671,6 +671,7 @@ uvc_v4l2_open(struct file *file)
 	if (handle == NULL)
 		return -ENOMEM;
 
+	kref_get(&uvc->kref);
 	v4l2_fh_init(&handle->vfh, vdev);
 	v4l2_fh_add(&handle->vfh, file);
 
@@ -695,6 +696,7 @@ uvc_v4l2_release(struct file *file)
 	v4l2_fh_del(&handle->vfh, file);
 	v4l2_fh_exit(&handle->vfh);
 	kfree(handle);
+	kref_put(&uvc->kref, uvc_device_release);
 
 	return 0;
 }

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.53.0.473.g4a7958ca14-goog


