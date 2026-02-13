Return-Path: <stable+bounces-216042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEo6BG34jmnbGAEAu9opvQ
	(envelope-from <stable+bounces-216042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 11:09:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9ED134E26
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 11:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC1B3308B18C
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 10:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0545A3502B9;
	Fri, 13 Feb 2026 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXmez4S6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2396350299
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977363; cv=none; b=gjDRmBAMPVC9GRovkmME4D9pB676aPKZn3M74765AInVrYvIxeHpn947shHlrP7eejLKl+YKKVnBVWXNMBFC+Z169SPqPea3lYheiBtEjy1+Zwn12JsgjREv9VrOqFu+/qG/+CQL31vuciLtJiCakp3CvDYkrayOm1CIEoUMO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977363; c=relaxed/simple;
	bh=Gmr69WGMLjBvur+7uCQXLHA9odNRHmal7j3YUPNU3ZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZGfjNzKJwbNkFuwyc4j/6Q1uM9+Dvjm6Nd+eMmWjDsfzgWgYCKH0MlSNbWiCan/14Y9QaFp+6XGO0KbZOUrLpSyPH2rYU3wG+0qx7pg/jIGgATkTIPawVQAD48zqbaMEVnbqK4OoBWQ3jU35zeg8rTsmvSX263B7nqbycBFFQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OXmez4S6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ab4de9580dso23924605ad.3
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 02:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770977362; x=1771582162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwUi3JIHoNvBN2bDQam1XZ1HxEGtt5ZvqQPmazzonYA=;
        b=OXmez4S6eASUJ5aMR3jT0QhjgMMB/j1r17AtoH7b7/k9LXKhtRkJps9DU/94QVMyKG
         Yn/tpCvtYMK9mWddJ5XI82c5c8xX2u1X+akH0OG12Px0ZR2+2KKFzDytj5/lTI4OytEB
         2mKy3VF7Djr51lxhjOQ2uQUMRMfLq3hsOU4iq9vCGg7giAIA7Ohi9FvJWOHulylz2cUX
         +rcnBMVrKBABSBrn61szfXxDSvWm7ipYbA+Q238IPuCYt4xfd2datY+1idCyt9Mo02nW
         uy0yhKWUQmWDe80aW7byXas9zHgbW1b9pBLHGwAjHz3adgu3ccpCqzv7XT0w7MKim9/k
         nEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770977362; x=1771582162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwUi3JIHoNvBN2bDQam1XZ1HxEGtt5ZvqQPmazzonYA=;
        b=YVP2f13KuFBXCqJOc8ZeonKNcpbpFtDdH2vm7Ybp0ESEH6fKlRP9tDbixByhBIssMJ
         0boQd0SKokKSMAruO1Svn3AVDqyXjHT3+BLHo6tff/dAYVRVq5U8VUaNROEPUI3kJ1yt
         26uKNlnPAZmgU74JUp3g3M3okSsrZke1LjL2DBRrsM1rjsBJCw21Xc7Ux9QW2DUjQG8d
         JhVcDbmHhuBwnlEwUr+TvYWw9704oc3mKCi8LVEV/91CVTpgHmOWk8hq+9g+ct+NXKH0
         yuI85Erb31CI/YDDIVndU6ezIQL9NzjIaV4G0dIJ+yr+aRsRYDKOrU8za9wcnvLVqhvH
         yjXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXEzRmT1+c1PG7LzDoWPzyAJUe2GOfoNayr1mmQkbhlBm2gTvCfQzZoPHp6naUvNUWKisw1vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxLogpNTfreoqE14KD9IZ0mfDP0m2GrhOjyZ65pCqc7qe91Fdg
	73dDZb8bUvnFLX6+gtWIDCTsiTZybYzjNp5E5zJ0Yp9dQUqknNSvLItukH7vYJ1QF2wnt6G/FfD
	4EAeAI3RXEIHQv0ZOPw==
X-Received: from plbje12.prod.google.com ([2002:a17:903:264c:b0:2a7:5a4a:5bc0])
 (user=guanyulin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:b4b:b0:298:5abe:4b1 with SMTP id d9443c01a7336-2ab5062cd61mr14490185ad.52.1770977361891;
 Fri, 13 Feb 2026 02:09:21 -0800 (PST)
Date: Fri, 13 Feb 2026 10:07:35 +0000
In-Reply-To: <20260213100736.2914690-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260213100736.2914690-1-guanyulin@google.com>
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260213100736.2914690-2-guanyulin@google.com>
Subject: [RFC PATCH v2 1/2] usb: offload: move device locking to callers in offload.c
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, perex@perex.cz, 
	tiwai@suse.com, quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de, 
	harshit.m.mogalapalli@oracle.com, wesley.cheng@oss.qualcomm.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, Guan-Yu Lin <guanyulin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-216042-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 7C9ED134E26
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
2.53.0.273.g2a3d683680-goog


