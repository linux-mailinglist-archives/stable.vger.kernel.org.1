Return-Path: <stable+bounces-217888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDhVJTxknWksPQQAu9opvQ
	(envelope-from <stable+bounces-217888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 09:41:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D4D183E43
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 09:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA41B3030130
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61FD366DBD;
	Tue, 24 Feb 2026 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYoS2pAP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C082D59E8
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922404; cv=none; b=cykoOCiG9q5fiwlLJA0Bobz4d9hsmaP6GqCFF0opNvYrCqZvHqyl9jQr5+AlyjYuKa/Wjjw9YRA3z50LucqFsR7rEed9WwVTFJ5XKjb6feZIwd5X9ANMyo9sU+NSkWPXykHemNE9eSUW8574TFtEvzgGZ0UjN/3ZugYk2qM7zaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922404; c=relaxed/simple;
	bh=U/TgxUQYVzZqCgle8jF8DXPoqtJ16jLgQc6UMKe3QvM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bzlJaqq4VKx8FCOhM/YxVioivKpNJSkHLidOU9wsmpFECVZII1bxO7ROBjGgOQiQqZo5zdSGyve5EWSnhBNXK7QJllMysoykPgXKnsrGnMTmD+tY73WJQzknun16RADmgi7Soe0BAqpjZ3B5vM7xUqJI4KXb2nVhkLsbJbGE0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYoS2pAP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c6e18ade2c2so3531265a12.1
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 00:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771922403; x=1772527203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AA20LKX/qg4rXIAP9XbWMbFshuFo56WlS+omTggeYsk=;
        b=eYoS2pAPwMqaCT9YmF3U9mleycoYxO5c/my893bGADyVzXLGCcIAY1yC/9A+MFV/Kn
         K7cjHeLrQrxlzJAkFUId77a+uD0zgKntBBHoDh1/az3PGzpXXCuZaOizxObLFlB9dU40
         mqJiElYDTFyQsIz+B6dtJpQq+EnqUIwyveNx2dYkTrMuM7EOMj1PItFVpRbGlTAEizCy
         TQq88D+R2kStyt4qh5E9up1INZEv2RKY17/gcl18hUPWJ2T+SJslY6LtGbNi1AGZVxb0
         VDQKZ2jiGPlCUTRn606kcTXxey0ZZOTLOtFhHoCPZrBkvfjgG0daL9/LxSrj+MqPFTDf
         o3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771922403; x=1772527203;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AA20LKX/qg4rXIAP9XbWMbFshuFo56WlS+omTggeYsk=;
        b=Ci7kXmybxWVqKlilGpXxAkVGtkMsiq5/BYFRpnlHKx1Vw+TYQvKJMqyTjsI6Z279MV
         OBnHiANJWVpoOLEUn0e8sxFyo34eRPAMxXb1dWtMa3tqlovEI7RDJbcI6SZobLSjDlv8
         Qa93EU/WBPWWXFjF4aCg6Si7FyYs4fh3tIkmqL+HdhD8f5NItjMI6ztmYWiHI0w2TyAK
         qhAKe9wQhrX91cr7CaS3DBx1NWp7o1KzD05WDKeVqiePYJNbBpXUm6YO2cVM6PjrcPce
         vRyivSVoK/zZj32tzjfORhlie4OAZ+hIp4UZfEa2+RYUcsk0GXuJlca+xurkmJCMmT0R
         7e0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRmPu1PJ82BC/DzVhMRF6ZOl7tJR1Y5A8dw9VSw00bwhMVqNJlEs9y879CVh56Vp9FMJJFfOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5ORFIuOBa+ophtGeOafXc/kiwLFYEOSKitV6LHl0KeVx/XBD
	hOvaSNttfkommaqXXZV2pr/onFQIVjiSpu+PyooehhMXLLl+T9xql8IOdU6Ty3VbOq38CKZLuTL
	wn7w+Zw==
X-Received: from pgc16.prod.google.com ([2002:a05:6a02:2f90:b0:c70:ab5b:1d92])
 (user=hhhuuu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a04:b0:394:8455:d1a9
 with SMTP id adf61e73a8af0-39545e5081dmr8121765637.2.1771922402547; Tue, 24
 Feb 2026 00:40:02 -0800 (PST)
Date: Tue, 24 Feb 2026 16:39:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260224083955.1375032-1-hhhuuu@google.com>
Subject: [PATCH] usb: gadget: f_uvc: fix NULL pointer dereference during
 unbind race
From: Jimmy Hu <hhhuuu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dan Vacura <w36195@motorola.com>, Jimmy Hu <hhhuuu@google.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Frank Li <Frank.Li@nxp.com>, Hans Verkuil <hverkuil+cisco@kernel.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, badhri@google.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217888-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1D4D183E43
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

The fix introduces a 'func_unbinding' flag in struct uvc_device to protect
critical sections:
1. In uvc_function_disconnect(), it prevents accessing the nullified
   cdev->gadget pointer.
2. In uvc_v4l2_release(), it ensures uvcg_free_buffers() is skipped
   if unbind is already in progress, avoiding races with concurrent
   bind operations or use-after-free on the video queue memory.

Fixes: b81ac4395bbe ("usb: gadget: uvc: allow for application to cleanly shutdown")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
---
 drivers/usb/gadget/function/f_uvc.c    | 7 +++++++
 drivers/usb/gadget/function/uvc.h      | 1 +
 drivers/usb/gadget/function/uvc_v4l2.c | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index a96476507d2f..f8c609ad1a43 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -413,6 +413,11 @@ uvc_function_disconnect(struct uvc_device *uvc)
 {
 	int ret;
 
+	if (uvc->func_unbinding) {
+		pr_info("uvc: unbinding, skipping function deactivate\n");
+		return;
+	}
+
 	if ((ret = usb_function_deactivate(&uvc->func)) < 0)
 		uvcg_info(&uvc->func, "UVC disconnect failed with %d\n", ret);
 }
@@ -659,6 +664,7 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	int ret = -EINVAL;
 
 	uvcg_info(f, "%s()\n", __func__);
+	uvc->func_unbinding = false;
 
 	opts = fi_to_f_uvc_opts(f->fi);
 	/* Sanity check the streaming endpoint module parameters. */
@@ -994,6 +1000,7 @@ static void uvc_function_unbind(struct usb_configuration *c,
 	long wait_ret = 1;
 
 	uvcg_info(f, "%s()\n", __func__);
+	uvc->func_unbinding = true;
 
 	kthread_cancel_work_sync(&video->hw_submit);
 
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 676419a04976..7ca56ff737a4 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -155,6 +155,7 @@ struct uvc_device {
 	enum uvc_state state;
 	struct usb_function func;
 	struct uvc_video video;
+	bool func_unbinding;
 	bool func_connected;
 	wait_queue_head_t func_connected_queue;
 
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index fd4b998ccd16..a8a15b584648 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -594,7 +594,13 @@ static void uvc_v4l2_disable(struct uvc_device *uvc)
 {
 	uvc_function_disconnect(uvc);
 	uvcg_video_disable(&uvc->video);
+	if (uvc->func_unbinding) {
+		pr_info("uvc: unbinding, skipping buffer cleanup\n");
+		goto skip_buffer_cleanup;
+	}
 	uvcg_free_buffers(&uvc->video.queue);
+
+skip_buffer_cleanup:
 	uvc->func_connected = false;
 	wake_up_interruptible(&uvc->func_connected_queue);
 }

base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
-- 
2.53.0.371.g1d285c8824-goog


