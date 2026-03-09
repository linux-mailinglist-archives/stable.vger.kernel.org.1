Return-Path: <stable+bounces-223474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB3uCVEwrmlrAQIAu9opvQ
	(envelope-from <stable+bounces-223474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 03:28:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F70F233439
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 03:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 965EC303DD0F
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 02:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820B2289E17;
	Mon,  9 Mar 2026 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHMefplH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CFE28641F
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022935; cv=none; b=J6bl5vhzo4oBTEg/5lalrg4S3AAsdb9289XNcNljUUUYaaBDHMq5uk0PnrTM5iew4fzSYsNGw/3eIOMuMr3NxBH7T86Wdgpwa/2VJZzF9/8Jp5iNY0S+yrj3DQsqGyFj/OVBIIOpcgNrsH+87JDoR04zch3SYYeQoHzXZ3qokNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022935; c=relaxed/simple;
	bh=hHjfugAI2wmLuqiTQpdrD0FeyO2Rh0gO6Ktv4HlhCi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mwBNUlJCUyysQ/zCSA/qd2fTbLknlBQn7/2PKaEwmfbQ6+AD2HnWAYBlq4xyeSGMGSGMlbeeHm7FoMycrEFQ2pqy0DDNNwI20RJke4M+tKl+d2pNdBDpwGDI5HhhoGiPIkOPe02Xl+Aq6VMAUOJ/PgL/xa8tCcmUu9IltHcuows=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hHMefplH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae3badc00dso90792535ad.3
        for <stable@vger.kernel.org>; Sun, 08 Mar 2026 19:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773022933; x=1773627733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2u3Zs+Rjt0MiMQEbIUbjMYBi44MTXuAO7nU4+IJIFM=;
        b=hHMefplHFeTxxl46LMUCdLufAYfDP8Q/0iKpUYNVrXiTNO1jx7aredzvQbnljBqcmB
         JG4W+39VJEYy+lCRVfb8FsPQP/h3YnISWUsgiIJrMtl3dKUgyzeo3dV03rZx8zbR6KM6
         MxB/XKlbTf1C1qAdm9N7hMvisYZ/nekvtuerRJdRn6yEHE9968fWvf2e+RnX13h5A2EX
         RBYAnXQkkTeXK9jKBWAnSFL8roHeppX3RIzTNoTzLTMWpb99eyGTbgg/8XVyDq1Y09zb
         QGXdH8vLX12KKPolz/+TbAr0SqBzrY3uinu8RjFAqWwVh3x8jYmtA56t4qd6Rntr1hXM
         jXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773022933; x=1773627733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2u3Zs+Rjt0MiMQEbIUbjMYBi44MTXuAO7nU4+IJIFM=;
        b=oJzV7iLtEkr6CbL5otW9z18VR6lDdh/GRLjAg0XsNvYs43FQJETMuI/ksnjnYHrqTS
         cfKahQE3H6CucWbvjIAcoarZzmAZh9MYQYvgSRnvcvSJI+i2s7NzzIxkspBOPZKMLt30
         hectrubPLJQq1JhitDF0WVBt1VpWDPZGnCdkIyOeaSiPHEG7JpF/BvMyb1SwKA0ajGo7
         cs62QToDqzCL66WqUF0w0YEqUxlSGKCN7YGMVoJKMjBtIYSDnrymwm1Nxtb2/dNwcgJD
         bwauvFEffOOdEpW1e6woBpUJ40Wfe2MPzm1bGLsMSUbilkvf2JUOWyWe9YLsEUxImN62
         5L1w==
X-Forwarded-Encrypted: i=1; AJvYcCUCFK9uHz8iFI9MjDwxl4Wp+u1zUaLx1KEwa3A7opgTS7J4zBLCGFJO+sFrmK4qBS16iC549oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQac1POYf3/TMHFP+EzVpC6zneEffZEkYJdOh2w2hXHCWd413V
	COQM+J+8sMIJuvgp5NEMkkVbgllXcfoWvxjGiBYj6C7lKTXziEJ0fnTtVYkKzIETcJ3NIGInqgx
	KbKBuRahJzxXwejnW3Q==
X-Received: from pgbs189.prod.google.com ([2002:a63:5ec6:0:b0:c73:987f:4708])
 (user=guanyulin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3e0d:b0:398:6bb5:54c4 with SMTP id adf61e73a8af0-3986bb55a1dmr6064755637.5.1773022933281;
 Sun, 08 Mar 2026 19:22:13 -0700 (PDT)
Date: Mon,  9 Mar 2026 02:22:04 +0000
In-Reply-To: <20260309022205.28136-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309022205.28136-1-guanyulin@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309022205.28136-2-guanyulin@google.com>
Subject: [PATCH v2 1/2] usb: offload: move device locking to callers in offload.c
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, perex@perex.cz, 
	tiwai@suse.com, quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de, 
	christophe.jaillet@wanadoo.fr, xiaopei01@kylinos.cn, 
	wesley.cheng@oss.qualcomm.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, Guan-Yu Lin <guanyulin@google.com>, stable@vger.kernel.org, 
	Hailong Liu <hailong.liu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8F70F233439
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
	TAGGED_FROM(0.00)[bounces-223474-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,intel.com,perex.cz,suse.com,quicinc.com,kernel.org,arndb.de,wanadoo.fr,kylinos.cn,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.911];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
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
Tested-by: Hailong Liu <hailong.liu@oppo.com>
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
2.53.0.473.g4a7958ca14-goog


