Return-Path: <stable+bounces-212848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FFOJmlifGmTMAIAu9opvQ
	(envelope-from <stable+bounces-212848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 08:48:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14370B808F
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 08:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDEB230173BA
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 07:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8245306B3E;
	Fri, 30 Jan 2026 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIMFr94a"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC482EB87E
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769759332; cv=none; b=HG+2hA6PG50fzIpI2VuIp7pmdBbWnAz8ZvD4KzkDj04wleDQ4QOWvh2f2mYdtKRxrw1KwlgaYsLmlrZnzHhfTgsvfwC6gaWb8FDIYD1b+8LOZ13yDMKzX+twauosvfFtwxSGgfRsf0hmXJp/oYAe94FW7QchomIl3DTV8ERGbtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769759332; c=relaxed/simple;
	bh=p4RI/PJNo9P2zoz4qNZVHYn11CSHjlAh2ePSn95HglE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uBwh937sJKQLJMW9NP7Bi4777VcnxivXmZi+l0CqmRaUgUGP8lZmYLAN2xGtil+yTkYVEnqFip1XrgkBz81n/CDeP23UO4tDWgEQxk40YZ1mc2MniwfVbY60Y4AA3MH4pD4X3N05U7L2scEVxeFN9MWnXfFWiEPISpvq4Y56780=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CIMFr94a; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a0e952f153so46973185ad.0
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 23:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769759330; x=1770364130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ubwoGcMvFrz/YoKawnL1KLVWp0+NDz5W2QGY4b7pS8w=;
        b=CIMFr94a38nYU0TPcZkC1HtZEz7iqDL405VIpITH9+GpTvg6P/NO7lC46HnKw40zzb
         HN7tbrQkH4WvKBUc0MgaT4cEtAEpiG6UKG9asJjz6ixyW2AhL7TmzoZ/88tQmcEVOTzF
         YYRZ1V6wjpCmG8mkVtzo7YGUIxk17497LSaOSYbgUiK0Jeusd74qrRXIfrL5Uzg2oozD
         ADzLccvqhQcnYRPlSM2NoBqUtQUM9dfhZDSL9okli0MwCnNtfu1niULYl7Q0pXY915Hl
         vW8yKlswl8Ay1FLr7NX3pI47vQA0UTmR6GSgJu8ubrR8flinkZYr8Pz9UfTe9LWBYmwA
         OcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769759330; x=1770364130;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubwoGcMvFrz/YoKawnL1KLVWp0+NDz5W2QGY4b7pS8w=;
        b=vekAvwgFyxRv0XL4GtFH15bjzkjLrBI9AjlnSTPPV5eVgWLvDXs4+wYzcKFUYtBOPP
         BmENrvtCpRQ5g+6iib+4Q7DhvNnln4F2CEetflCxYTdpsMTpHPWyLzdRB9X/VCqgzJTa
         yCAPG18OJSjUXPCAf2pJLxElhPUoVqRlR9wvPuBIxvSv462TkINhDc/LEO/iApCmHyP5
         E2dEHAOJ52WrND31sBiq9Z1ClGS35NTaMIlxRY6a/ha5y85KAUWV0DaAs2Ci8Vmh5LwS
         HnOvxaVbW0hC6+s9W4pm6gBBVUUOn2YWxhJJZoLkr5hFyzUtOU4eG7FTeiLqcLR6m0uk
         0K5g==
X-Forwarded-Encrypted: i=1; AJvYcCV1UJLxSzsW0NhBQ1jpnjp1Dp3MuFzVtUukWECvybfERppmq1RB89JdtmJwzirpKYlc76D/0mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOsc8orbi9dFgpUem2itTWnn8+UaWINyn+WPnJt4LmnMkEpfH
	MIsaD35NrFL5ULCGQN0bTDCq6zL1VhW3s1GVfS804uH94Q47a4ip2WR+26C4+PZcFsrWIEpZrCy
	xeMwcJ4s6veAw2z/Qew==
X-Received: from plsl6.prod.google.com ([2002:a17:903:2446:b0:2a3:1bf9:d25])
 (user=guanyulin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2d0:b0:2a7:cf36:819 with SMTP id d9443c01a7336-2a8d9a5edc8mr22929475ad.44.1769759330394;
 Thu, 29 Jan 2026 23:48:50 -0800 (PST)
Date: Fri, 30 Jan 2026 07:47:46 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130074746.287750-1-guanyulin@google.com>
Subject: [RFC PATCH] usb: host: xhci-sideband: fix deadlock in unregister path
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, 
	stern@rowland.harvard.edu, wesley.cheng@oss.qualcomm.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guan-Yu Lin <guanyulin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212848-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14370B808F
X-Rspamd-Action: no action

When a USB device is disconnected or a driver is unbound, the USB core
invokes the driver's disconnect callback while holding the udev device
lock. If the driver calls xhci_sideband_unregister(), it eventually
reaches usb_offload_put(), which attempts to acquire the same udev
lock, resulting in a self-deadlock.

Introduce lockless variants __usb_offload_get() and __usb_offload_put()
to allow modifying the offload usage count when the device lock is
already held. These helpers use device_lock_assert() to ensure callers
meet the locking requirements.

Update the xHCI sideband implementation to use these lockless variants
in the unregister and interrupter removal paths. For public sideband
APIs that can be called from other contexts, wrap the calls with
explicit udev locking to maintain synchronization.

Cc: stable@vger.kernel.org
Fixes: ef82a4803aab ("xhci: sideband: add api to trace sideband usage")
Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
Hi Maintainers,

In the current implementation, xhci_sideband_unregister() is only invoked
when a driver manages a USB interface via snd_usb_platform_ops callbacks
(.connect_cb and .disconnect_cb). In these contexts, the parent USB
device lock is already held by the USB core. However, the original design
of usb_offload_put() attempts to re-acquire the same USB device lock,
leading to a recursive locking scenario.

This patch resolves the issue by:
1. Refactoring Lock Ownership: Shifting lock acquisition responsibility
to the upper-level USB driver. This ensures usb_offload_put() can be
safely called from contexts where the lock is already held.
2. Standardizing the Lock Hierarchy: To prevent potential ABBA deadlocks,
the locking sequence is unified across the driver. The functions
xhci_sideband_create_interrupter() and xhci_sideband_remove_interrupter()
have been updated to strictly follow the same hierarchy.
---
 drivers/usb/core/offload.c       | 92 +++++++++++++++++++++-----------
 drivers/usb/host/xhci-sideband.c | 48 +++++++++++------
 include/linux/usb.h              |  6 +++
 3 files changed, 100 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/core/offload.c b/drivers/usb/core/offload.c
index 7c699f1b8d2b..bc5f337fb355 100644
--- a/drivers/usb/core/offload.c
+++ b/drivers/usb/core/offload.c
@@ -13,44 +13,59 @@
 #include "usb.h"
 
 /**
- * usb_offload_get - increment the offload_usage of a USB device
+ * __usb_offload_get - increment the offload_usage of a USB device
  * @udev: the USB device to increment its offload_usage
  *
- * Incrementing the offload_usage of a usb_device indicates that offload is
- * enabled on this usb_device; that is, another entity is actively handling USB
- * transfers. This information allows the USB driver to adjust its power
- * management policy based on offload activity.
+ * This is the lockless version of usb_offload_get. The caller must hold
+ * @udev's device lock.
  *
  * Return: 0 on success. A negative error code otherwise.
  */
-int usb_offload_get(struct usb_device *udev)
+int __usb_offload_get(struct usb_device *udev)
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
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__usb_offload_get);
+
+/**
+ * usb_offload_get - increment the offload_usage of a USB device
+ * @udev: the USB device to increment its offload_usage
+ *
+ * Incrementing the offload_usage of a usb_device indicates that offload is
+ * enabled on this usb_device; that is, another entity is actively handling USB
+ * transfers. This information allows the USB driver to adjust its power
+ * management policy based on offload activity.
+ *
+ * Return: 0 on success. A negative error code otherwise.
+ */
+int usb_offload_get(struct usb_device *udev)
+{
+	int ret;
+
+	usb_lock_device(udev);
+	ret = __usb_offload_get(udev);
 	usb_unlock_device(udev);
 
 	return ret;
@@ -58,45 +73,60 @@ int usb_offload_get(struct usb_device *udev)
 EXPORT_SYMBOL_GPL(usb_offload_get);
 
 /**
- * usb_offload_put - drop the offload_usage of a USB device
+ * __usb_offload_put - drop the offload_usage of a USB device
  * @udev: the USB device to drop its offload_usage
  *
- * The inverse operation of usb_offload_get, which drops the offload_usage of
- * a USB device. This information allows the USB driver to adjust its power
- * management policy based on offload activity.
+ * This is the lockless version of usb_offload_put. The caller must hold
+ * @udev's device lock.
  *
  * Return: 0 on success. A negative error code otherwise.
  */
-int usb_offload_put(struct usb_device *udev)
+int __usb_offload_put(struct usb_device *udev)
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
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__usb_offload_put);
+
+/**
+ * usb_offload_put - drop the offload_usage of a USB device
+ * @udev: the USB device to drop its offload_usage
+ *
+ * The inverse operation of usb_offload_get, which drops the offload_usage of
+ * a USB device. This information allows the USB driver to adjust its power
+ * management policy based on offload activity.
+ *
+ * Return: 0 on success. A negative error code otherwise.
+ */
+int usb_offload_put(struct usb_device *udev)
+{
+	int ret;
+
+	usb_lock_device(udev);
+	ret = __usb_offload_put(udev);
 	usb_unlock_device(udev);
 
 	return ret;
diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index 2bd77255032b..c37c3f3adf4a 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -89,7 +89,7 @@ __xhci_sideband_remove_endpoint(struct xhci_sideband *sb, struct xhci_virt_ep *e
 	sb->eps[ep->ep_index] = NULL;
 }
 
-/* Caller must hold sb->mutex */
+/* Caller must hold sb->mutex and udev device lock */
 static void
 __xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
 {
@@ -102,10 +102,10 @@ __xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
 
 	xhci_remove_secondary_interrupter(xhci_to_hcd(sb->xhci), sb->ir);
 	sb->ir = NULL;
-	udev = sb->vdev->udev;
 
-	if (udev->state != USB_STATE_NOTATTACHED)
-		usb_offload_put(udev);
+	udev = interface_to_usbdev(sb->intf);
+	device_lock_assert(&udev->dev);
+	__usb_offload_put(udev);
 }
 
 /* sideband api functions */
@@ -334,25 +334,36 @@ xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
 	if (!sb || !sb->xhci)
 		return -ENODEV;
 
-	guard(mutex)(&sb->mutex);
+	udev = interface_to_usbdev(sb->intf);
+	usb_lock_device(udev);
+	mutex_lock(&sb->mutex);
 
-	if (!sb->vdev)
-		return -ENODEV;
+	if (!sb->vdev) {
+		ret = -ENODEV;
+		goto unlock;
+	}
 
-	if (sb->ir)
-		return -EBUSY;
+	if (sb->ir) {
+		ret = -EBUSY;
+		goto unlock;
+	}
 
 	sb->ir = xhci_create_secondary_interrupter(xhci_to_hcd(sb->xhci),
 						   num_seg, imod_interval,
 						   intr_num);
-	if (!sb->ir)
-		return -ENOMEM;
+	if (!sb->ir) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
 
-	udev = sb->vdev->udev;
-	ret = usb_offload_get(udev);
+	ret = __usb_offload_get(udev);
 
 	sb->ir->ip_autoclear = ip_autoclear;
 
+unlock:
+	mutex_unlock(&sb->mutex);
+	usb_unlock_device(udev);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_create_interrupter);
@@ -367,12 +378,19 @@ EXPORT_SYMBOL_GPL(xhci_sideband_create_interrupter);
 void
 xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
 {
-	if (!sb)
+	struct usb_device *udev;
+
+	if (!sb || !sb->vdev)
 		return;
 
-	guard(mutex)(&sb->mutex);
+	udev = interface_to_usbdev(sb->intf);
+	usb_lock_device(udev);
+	mutex_lock(&sb->mutex);
 
 	__xhci_sideband_remove_interrupter(sb);
+
+	mutex_unlock(&sb->mutex);
+	usb_unlock_device(udev);
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_remove_interrupter);
 
diff --git a/include/linux/usb.h b/include/linux/usb.h
index fbfcc70b07fb..19c84c05f376 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -846,11 +846,17 @@ static inline void usb_mark_last_busy(struct usb_device *udev)
 #endif
 
 #if IS_ENABLED(CONFIG_USB_XHCI_SIDEBAND)
+int __usb_offload_get(struct usb_device *udev);
+int __usb_offload_put(struct usb_device *udev);
 int usb_offload_get(struct usb_device *udev);
 int usb_offload_put(struct usb_device *udev);
 bool usb_offload_check(struct usb_device *udev);
 #else
 
+static inline int __usb_offload_get(struct usb_device *udev)
+{ return 0; }
+static inline int __usb_offload_put(struct usb_device *udev)
+{ return 0; }
 static inline int usb_offload_get(struct usb_device *udev)
 { return 0; }
 static inline int usb_offload_put(struct usb_device *udev)
-- 
2.53.0.rc1.225.gd81095ad13-goog


