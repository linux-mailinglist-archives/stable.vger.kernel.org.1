Return-Path: <stable+bounces-219199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGP+J8ibnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:50:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4A8192864
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 078ED30C39A4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A404826ED5D;
	Wed, 25 Feb 2026 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6jkZjQe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B732C0F6F
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772001974; cv=none; b=DcPyAnesPsEHBdzciLD3ETbhTTBV6RRZUwwbdfJ1jWnfiREIRhUndWRuagR+Am55DuF/T36JGJijzjvEQO22ZXVLQkdjQpCpBCZ1/ZIRdKIQpOajBdl/EaVbvVw92KwfrybslsE569UNcSLCy/E/XQbg4FWxQXM5Zga//LqpgmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772001974; c=relaxed/simple;
	bh=8jXjL4fbM6gkhPw4/nMZoR6XPa+UBbga/qTa9E4J9vU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IFIrgazAkjCfce3/lr0AjNVDM2yu3OkONghsDoDqpdy0HPZwez1tJ1Pd+cwqQjq3eol4oXTLf/+/ukzuge8NMk3CFf9EDM7RaSKgAWsC2AbwcQ6fymMeAUWk0+vKzRBQ1suLZ8JxUxjncSVKHWtd2Eh/Gg56MvSiQXjE18c/Pic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6jkZjQe; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2addefa321dso2592255ad.3
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 22:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772001972; x=1772606772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q5f300QESzf5Ez7BqOSUeVAJjkHUA2IYF3yXjjVhVPI=;
        b=a6jkZjQemq9m4bFcy5fAJzVX346fmVbME9bnVdg0RUCvQ/qin2ziP751f2YSBKvDmn
         fyq1P/Dh+wCcOLQs9cBaUpQgvPq2k8ClQxsBfdPCVZKNorbDjzEHz6CSDmn5OoaNiJ9j
         ZxdpyfsGON/4vuhH1yFZrRVtyuPmbXsa7FbRgKjQ8l+Ba87nKT+I3zvhg9QcphxNssjv
         No6QKj0AHUWiO4vKPnHVwrQdqoNmlbp/L3GyToPqy1QfrX1/0v6kAGmpRy0oOO5bpD1y
         2t48v2mzl3CGVVulOc4RAw1IwnZSbimtNB7U/NKENuh58pzSwEs2o4UwjDO6FSYXlllv
         /aGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772001972; x=1772606772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5f300QESzf5Ez7BqOSUeVAJjkHUA2IYF3yXjjVhVPI=;
        b=aMMHkzPHyCws/Dyc4b4bb3kG4SmiJKAoJa5evPWPVE5lgnLQyjEa5suqT4opzowBxJ
         BiJN/LncG8dRC6nKUy+SFQpBrwUJQzX1kX9f2xo6U8LcB+8+UiN6b1kD2genVP4q2YOl
         kdzKSME00r0sNWRGtPLo7l7DlYGmCPcZR6TEQeHWFmbteTK4etSW37bEj8U4Lh6NjvQk
         +HzgWwDDGYd1DNJknaqtAPVZCqjIdtSslo+EnKp+tVEyc8LS6u9wB6h93wI4j0mBouRo
         MhjzGrrbU8L30fZoosxAi59uwVsiFkyj4hb47YY62hO4nKKj831CTj4wtfwme6KXuotC
         Rf9w==
X-Forwarded-Encrypted: i=1; AJvYcCWQXaNZ6MCuuCfaO7MUTyDzbjPe27ulbVCNvQaXZihyFq9EVQbGeFJshbQTwg5yVDaO9nFy/40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiVqLd14C0u2ezdPwkX6gSroijamyM5vdKFv8jgnAVoL4udWLM
	MQ9JtR8Vbaolu0W++Ax86TU/dWboA9Kt03OZxkgxPDd28rBVVQl4575lC1hSirq+oEoAAU4qLRq
	KsxX3Pk2vsM1UyXIKSw==
X-Received: from pgav17.prod.google.com ([2002:a05:6a02:2dd1:b0:c70:95a6:8599])
 (user=guanyulin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2d2b:b0:392:e583:b766 with SMTP id adf61e73a8af0-39545f8e05cmr13793496637.42.1772001971759;
 Tue, 24 Feb 2026 22:46:11 -0800 (PST)
Date: Wed, 25 Feb 2026 06:45:50 +0000
In-Reply-To: <20260225064601.270301-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225064601.270301-1-guanyulin@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225064601.270301-2-guanyulin@google.com>
Subject: [PATCH v1 1/2] usb: offload: move device locking to callers in offload.c
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, perex@perex.cz, 
	tiwai@suse.com, quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de, 
	harshit.m.mogalapalli@oracle.com, wesley.cheng@oss.qualcomm.com, 
	dan.carpenter@linaro.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, Guan-Yu Lin <guanyulin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219199-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA4A8192864
X-Rspamd-Action: no action

Update usb_offload_get() and usb_offload_put() to require that the
caller holds the USB device lock. Remove the internal call to
usb_lock_device() and add device_lock_assert() to ensure synchronization
is handled by the caller. These functions continue to manage the
device's power state via autoresume/autosuspend and update the
offload_usage counter.

Additionally, decouple the xHCI sideband interrupter lifecycle from the
offload usage counter by removing the calls to usb_offload_get() and
usb_offload_put() from the interrupter creation and removal paths. This
allows interrupters to be managed independently of the device's offload
activity status.

Cc: stable@vger.kernel.org
Fixes: ef82a4803aab ("xhci: sideband: add api to trace sideband usage")
Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 drivers/usb/core/offload.c       | 34 +++++++++++---------------------
 drivers/usb/host/xhci-sideband.c | 14 +------------
 2 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/core/offload.c b/drivers/usb/core/offload.c
index 7c699f1b8d2b..e13a4c21d61b 100644
--- a/drivers/usb/core/offload.c
+++ b/drivers/usb/core/offload.c
@@ -20,6 +20,7 @@
  * enabled on this usb_device; that is, another entity is actively handling USB
  * transfers. This information allows the USB driver to adjust its power
  * management policy based on offload activity.
+ * The caller must hold @udev's device lock.
  *
  * Return: 0 on success. A negative error code otherwise.
  */
@@ -27,31 +28,25 @@ int usb_offload_get(struct usb_device *udev)
 {
 	int ret;
 
-	usb_lock_device(udev);
-	if (udev->state == USB_STATE_NOTATTACHED) {
-		usb_unlock_device(udev);
+	device_lock_assert(&udev->dev);
+
+	if (udev->state == USB_STATE_NOTATTACHED)
 		return -ENODEV;
-	}
 
 	if (udev->state == USB_STATE_SUSPENDED ||
-		   udev->offload_at_suspend) {
-		usb_unlock_device(udev);
+	    udev->offload_at_suspend)
 		return -EBUSY;
-	}
 
 	/*
 	 * offload_usage could only be modified when the device is active, since
 	 * it will alter the suspend flow of the device.
 	 */
 	ret = usb_autoresume_device(udev);
-	if (ret < 0) {
-		usb_unlock_device(udev);
+	if (ret < 0)
 		return ret;
-	}
 
 	udev->offload_usage++;
 	usb_autosuspend_device(udev);
-	usb_unlock_device(udev);
 
 	return ret;
 }
@@ -64,6 +59,7 @@ EXPORT_SYMBOL_GPL(usb_offload_get);
  * The inverse operation of usb_offload_get, which drops the offload_usage of
  * a USB device. This information allows the USB driver to adjust its power
  * management policy based on offload activity.
+ * The caller must hold @udev's device lock.
  *
  * Return: 0 on success. A negative error code otherwise.
  */
@@ -71,33 +67,27 @@ int usb_offload_put(struct usb_device *udev)
 {
 	int ret;
 
-	usb_lock_device(udev);
-	if (udev->state == USB_STATE_NOTATTACHED) {
-		usb_unlock_device(udev);
+	device_lock_assert(&udev->dev);
+
+	if (udev->state == USB_STATE_NOTATTACHED)
 		return -ENODEV;
-	}
 
 	if (udev->state == USB_STATE_SUSPENDED ||
-		   udev->offload_at_suspend) {
-		usb_unlock_device(udev);
+	    udev->offload_at_suspend)
 		return -EBUSY;
-	}
 
 	/*
 	 * offload_usage could only be modified when the device is active, since
 	 * it will alter the suspend flow of the device.
 	 */
 	ret = usb_autoresume_device(udev);
-	if (ret < 0) {
-		usb_unlock_device(udev);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* Drop the count when it wasn't 0, ignore the operation otherwise. */
 	if (udev->offload_usage)
 		udev->offload_usage--;
 	usb_autosuspend_device(udev);
-	usb_unlock_device(udev);
 
 	return ret;
 }
diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index 2bd77255032b..6fc0ad658d66 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -93,8 +93,6 @@ __xhci_sideband_remove_endpoint(struct xhci_sideband *sb, struct xhci_virt_ep *e
 static void
 __xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
 {
-	struct usb_device *udev;
-
 	lockdep_assert_held(&sb->mutex);
 
 	if (!sb->ir)
@@ -102,10 +100,6 @@ __xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
 
 	xhci_remove_secondary_interrupter(xhci_to_hcd(sb->xhci), sb->ir);
 	sb->ir = NULL;
-	udev = sb->vdev->udev;
-
-	if (udev->state != USB_STATE_NOTATTACHED)
-		usb_offload_put(udev);
 }
 
 /* sideband api functions */
@@ -328,9 +322,6 @@ int
 xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
 				 bool ip_autoclear, u32 imod_interval, int intr_num)
 {
-	int ret = 0;
-	struct usb_device *udev;
-
 	if (!sb || !sb->xhci)
 		return -ENODEV;
 
@@ -348,12 +339,9 @@ xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
 	if (!sb->ir)
 		return -ENOMEM;
 
-	udev = sb->vdev->udev;
-	ret = usb_offload_get(udev);
-
 	sb->ir->ip_autoclear = ip_autoclear;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_create_interrupter);
 
-- 
2.53.0.414.gf7e9f6c205-goog


