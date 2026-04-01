Return-Path: <stable+bounces-232771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAQrMtsZzWnOaAYAu9opvQ
	(envelope-from <stable+bounces-232771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 15:12:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2621B37B049
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 15:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1ABD320E5FF
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 12:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AAF40756C;
	Wed,  1 Apr 2026 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RP4Z/bwl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57E405ACD
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046772; cv=none; b=pak6juacJ54D1dgcDBwNIAwdRE5JLogXDX5qs4SVLUZSVNw2MBktDHmr1ZxvYxdQWExksVJR5q5Yc6sNRLZcazGAO1TYf5VKlRkYy85KREjFo2BTLlQMq92x5RqthVpY2LMW4ezsntF1tL1EfkhqwHFGNmhTnK4eqGRcC5mpcCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046772; c=relaxed/simple;
	bh=8I/jcDq3mGE2F/wBKNqz5XwEreo9yQdGTV2OX9FdU/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A8SYgWYJr8/sLj0awVoDbnYf3wmKCqwU7h2WeYcFBvh4gTuXGb9z0Fh7l4rWbrrMCYfnEVEJXrceCzO6dU7so0cAgmNBMyg+2/nTJfSIZwYjjDVTvEwOtrTmASu8/X4wmF/WgGhHbthyo0LcXEcmcoZbAf7a/hYIudvynSR+yjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RP4Z/bwl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so4296832a12.1
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 05:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775046769; x=1775651569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U913IipK0rHIz5rDmL+93HPhsWeCxazYo7f4hpEQFvU=;
        b=RP4Z/bwlH+Tb1dpHOgURx3Bj6FvUGWG+ksWwefMAWK5lEkBc1p5AOQNtzMvBEs6hUP
         TnlVIyv8yU04PF0YFkrTtIxcMUBhGn/rTutiq7UAIDwGnZlCV+BYnOtLmqhckiG/F1QM
         64Bw+gn0Ku+NBYVehDkEAgTSMNw20c2pd/d905iPR0nbqu1QkGSiSIPguHL0eQdeGqg6
         n/pnARDuhoBZxkOJxktQVN1ErLDkIaTynq59IQftiH/D9M/LSXsxqy6v9KU7x8TKcDoq
         BnaGrHwFi+tvVdMDMvh9scUy6ve0LrgG1G/SWf+0970taMPyZAm/r+wep59zldqSr816
         z5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775046769; x=1775651569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U913IipK0rHIz5rDmL+93HPhsWeCxazYo7f4hpEQFvU=;
        b=ml55LccmdBAZjfynC381ja0GD4S2NgSlKRxSXYbMqpTc8Np7IozNz/dEe0pGPsOe2y
         DKswGeyrswtin/ikaMrBgaMrhqzEvl+8KJtVF96pywXje4eozR8wgY/9lIvdPmzoGjCA
         KOtpBZVobrAJRFMEbi2zpRygq5kyhzsrE6EPWlQaicd8kw5EnQKytEng8JCNzIQWVMKG
         +303CVSAGHQFIcxb+TxgqyIQrdZPX9vLzXLGP4ceOpz/aD8ydzJcLl+9lIGJKz1FHNE6
         sr1hLX/+6elWO3SZddKzFm0mkSNGUUJEe04ISyeOeFqsyBM5lWkVH3YyTZ03B9CkvypK
         gBFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR/nRC6v2ijjO3pSISc4B92w5HZURnTHW5GMC5/IckFcfywbnYqiAs5h4qE9wZbxhYJ7lXDWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj3aMB5vGhNUdw34xvnIA2gzKFlb56VEPVM8THlxVfF9CMr+DU
	4pDdhihBr/QZBjhHhmgRQxeBMTTvC76TVOoJHyiyfJtzY7oLyMvapZ9WUKhSOa1rSDO02D5x1bz
	XBjgKQYG+2NtOHcMCDA==
X-Received: from pgcn13.prod.google.com ([2002:a63:720d:0:b0:c73:fb05:a2e3])
 (user=guanyulin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a13:b0:39b:da83:91aa with SMTP id adf61e73a8af0-39ef774f7ccmr3683797637.51.1775046768964;
 Wed, 01 Apr 2026 05:32:48 -0700 (PDT)
Date: Wed,  1 Apr 2026 12:32:17 +0000
In-Reply-To: <20260401123238.3790062-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401123238.3790062-1-guanyulin@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401123238.3790062-2-guanyulin@google.com>
Subject: [PATCH v4 1/2] usb: core: use dedicated spinlock for offload state
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, perex@perex.cz, 
	dominique.martinet@atmark-techno.com, eadavis@qq.com, hannelotta@gmail.com, 
	tiwai@suse.com, quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de, 
	xiaopei01@kylinos.cn, wesley.cheng@oss.qualcomm.com, 
	sakari.ailus@linux.intel.com, stern@rowland.harvard.edu, 
	amardeep.rai@intel.com, xu.yang_2@nxp.com, andriy.shevchenko@linux.intel.com, 
	nkapron@google.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, Guan-Yu Lin <guanyulin@google.com>, stable@vger.kernel.org, 
	Hailong Liu <hailong.liu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linuxfoundation.org,intel.com,perex.cz,atmark-techno.com,qq.com,gmail.com,suse.com,quicinc.com,kernel.org,arndb.de,kylinos.cn,oss.qualcomm.com,linux.intel.com,rowland.harvard.edu,nxp.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-232771-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oppo.com:email]
X-Rspamd-Queue-Id: 2621B37B049
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the coarse USB device lock with a dedicated offload_lock
spinlock to reduce contention during offload operations. Use
offload_pm_locked to synchronize with PM transitions and replace
the legacy offload_at_suspend flag.

Optimize usb_offload_get/put by switching from auto-resume/suspend
to pm_runtime_get_if_active(). This ensures offload state is only
modified when the device is already active, avoiding unnecessary
power transitions.

Cc: stable@vger.kernel.org
Fixes: ef82a4803aab ("xhci: sideband: add api to trace sideband usage")
Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
Tested-by: Hailong Liu <hailong.liu@oppo.com>
---
 drivers/usb/core/driver.c        |  23 ++++---
 drivers/usb/core/offload.c       | 102 ++++++++++++++++++-------------
 drivers/usb/core/usb.c           |   1 +
 drivers/usb/host/xhci-sideband.c |   4 +-
 include/linux/usb.h              |  10 ++-
 5 files changed, 84 insertions(+), 56 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index d29edc7c616a..74b8bdc27dbf 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1415,14 +1415,16 @@ static int usb_suspend_both(struct usb_device *udev, pm_message_t msg)
 	int			status = 0;
 	int			i = 0, n = 0;
 	struct usb_interface	*intf;
+	bool			offload_active = false;
 
 	if (udev->state == USB_STATE_NOTATTACHED ||
 			udev->state == USB_STATE_SUSPENDED)
 		goto done;
 
+	usb_offload_set_pm_locked(udev, true);
 	if (msg.event == PM_EVENT_SUSPEND && usb_offload_check(udev)) {
 		dev_dbg(&udev->dev, "device offloaded, skip suspend.\n");
-		udev->offload_at_suspend = 1;
+		offload_active = true;
 	}
 
 	/* Suspend all the interfaces and then udev itself */
@@ -1436,8 +1438,7 @@ static int usb_suspend_both(struct usb_device *udev, pm_message_t msg)
 			 * interrupt urbs, allowing interrupt events to be
 			 * handled during system suspend.
 			 */
-			if (udev->offload_at_suspend &&
-			    intf->needs_remote_wakeup) {
+			if (offload_active && intf->needs_remote_wakeup) {
 				dev_dbg(&intf->dev,
 					"device offloaded, skip suspend.\n");
 				continue;
@@ -1452,7 +1453,7 @@ static int usb_suspend_both(struct usb_device *udev, pm_message_t msg)
 		}
 	}
 	if (status == 0) {
-		if (!udev->offload_at_suspend)
+		if (!offload_active)
 			status = usb_suspend_device(udev, msg);
 
 		/*
@@ -1498,7 +1499,7 @@ static int usb_suspend_both(struct usb_device *udev, pm_message_t msg)
 	 */
 	} else {
 		udev->can_submit = 0;
-		if (!udev->offload_at_suspend) {
+		if (!offload_active) {
 			for (i = 0; i < 16; ++i) {
 				usb_hcd_flush_endpoint(udev, udev->ep_out[i]);
 				usb_hcd_flush_endpoint(udev, udev->ep_in[i]);
@@ -1507,6 +1508,8 @@ static int usb_suspend_both(struct usb_device *udev, pm_message_t msg)
 	}
 
  done:
+	if (status != 0)
+		usb_offload_set_pm_locked(udev, false);
 	dev_vdbg(&udev->dev, "%s: status %d\n", __func__, status);
 	return status;
 }
@@ -1536,16 +1539,19 @@ static int usb_resume_both(struct usb_device *udev, pm_message_t msg)
 	int			status = 0;
 	int			i;
 	struct usb_interface	*intf;
+	bool			offload_active = false;
 
 	if (udev->state == USB_STATE_NOTATTACHED) {
 		status = -ENODEV;
 		goto done;
 	}
 	udev->can_submit = 1;
+	if (msg.event == PM_EVENT_RESUME)
+		offload_active = usb_offload_check(udev);
 
 	/* Resume the device */
 	if (udev->state == USB_STATE_SUSPENDED || udev->reset_resume) {
-		if (!udev->offload_at_suspend)
+		if (!offload_active)
 			status = usb_resume_device(udev, msg);
 		else
 			dev_dbg(&udev->dev,
@@ -1562,8 +1568,7 @@ static int usb_resume_both(struct usb_device *udev, pm_message_t msg)
 			 * pending interrupt urbs, allowing interrupt events
 			 * to be handled during system suspend.
 			 */
-			if (udev->offload_at_suspend &&
-			    intf->needs_remote_wakeup) {
+			if (offload_active && intf->needs_remote_wakeup) {
 				dev_dbg(&intf->dev,
 					"device offloaded, skip resume.\n");
 				continue;
@@ -1572,11 +1577,11 @@ static int usb_resume_both(struct usb_device *udev, pm_message_t msg)
 					udev->reset_resume);
 		}
 	}
-	udev->offload_at_suspend = 0;
 	usb_mark_last_busy(udev);
 
  done:
 	dev_vdbg(&udev->dev, "%s: status %d\n", __func__, status);
+	usb_offload_set_pm_locked(udev, false);
 	if (!status)
 		udev->reset_resume = 0;
 	return status;
diff --git a/drivers/usb/core/offload.c b/drivers/usb/core/offload.c
index 7c699f1b8d2b..9db3cfedd29c 100644
--- a/drivers/usb/core/offload.c
+++ b/drivers/usb/core/offload.c
@@ -25,33 +25,30 @@
  */
 int usb_offload_get(struct usb_device *udev)
 {
-	int ret;
+	int ret = 0;
 
-	usb_lock_device(udev);
-	if (udev->state == USB_STATE_NOTATTACHED) {
-		usb_unlock_device(udev);
+	if (!usb_get_dev(udev))
 		return -ENODEV;
-	}
 
-	if (udev->state == USB_STATE_SUSPENDED ||
-		   udev->offload_at_suspend) {
-		usb_unlock_device(udev);
-		return -EBUSY;
+	if (pm_runtime_get_if_active(&udev->dev) != 1) {
+		ret = -EBUSY;
+		goto err_rpm;
 	}
 
-	/*
-	 * offload_usage could only be modified when the device is active, since
-	 * it will alter the suspend flow of the device.
-	 */
-	ret = usb_autoresume_device(udev);
-	if (ret < 0) {
-		usb_unlock_device(udev);
-		return ret;
+	spin_lock(&udev->offload_lock);
+
+	if (udev->offload_pm_locked) {
+		ret = -EAGAIN;
+		goto err;
 	}
 
 	udev->offload_usage++;
-	usb_autosuspend_device(udev);
-	usb_unlock_device(udev);
+
+err:
+	spin_unlock(&udev->offload_lock);
+	pm_runtime_put_autosuspend(&udev->dev);
+err_rpm:
+	usb_put_dev(udev);
 
 	return ret;
 }
@@ -69,35 +66,32 @@ EXPORT_SYMBOL_GPL(usb_offload_get);
  */
 int usb_offload_put(struct usb_device *udev)
 {
-	int ret;
+	int ret = 0;
 
-	usb_lock_device(udev);
-	if (udev->state == USB_STATE_NOTATTACHED) {
-		usb_unlock_device(udev);
+	if (!usb_get_dev(udev))
 		return -ENODEV;
-	}
 
-	if (udev->state == USB_STATE_SUSPENDED ||
-		   udev->offload_at_suspend) {
-		usb_unlock_device(udev);
-		return -EBUSY;
+	if (pm_runtime_get_if_active(&udev->dev) != 1) {
+		ret = -EBUSY;
+		goto err_rpm;
 	}
 
-	/*
-	 * offload_usage could only be modified when the device is active, since
-	 * it will alter the suspend flow of the device.
-	 */
-	ret = usb_autoresume_device(udev);
-	if (ret < 0) {
-		usb_unlock_device(udev);
-		return ret;
+	spin_lock(&udev->offload_lock);
+
+	if (udev->offload_pm_locked) {
+		ret = -EAGAIN;
+		goto err;
 	}
 
 	/* Drop the count when it wasn't 0, ignore the operation otherwise. */
 	if (udev->offload_usage)
 		udev->offload_usage--;
-	usb_autosuspend_device(udev);
-	usb_unlock_device(udev);
+
+err:
+	spin_unlock(&udev->offload_lock);
+	pm_runtime_put_autosuspend(&udev->dev);
+err_rpm:
+	usb_put_dev(udev);
 
 	return ret;
 }
@@ -112,25 +106,47 @@ EXPORT_SYMBOL_GPL(usb_offload_put);
  * management.
  *
  * The caller must hold @udev's device lock. In addition, the caller should
- * ensure downstream usb devices are all either suspended or marked as
- * "offload_at_suspend" to ensure the correctness of the return value.
+ * ensure the device itself and the downstream usb devices are all marked as
+ * "offload_pm_locked" to ensure the correctness of the return value.
  *
  * Returns true on any offload activity, false otherwise.
  */
 bool usb_offload_check(struct usb_device *udev) __must_hold(&udev->dev->mutex)
 {
 	struct usb_device *child;
-	bool active;
+	bool active = false;
 	int port1;
 
+	if (udev->offload_usage)
+		return true;
+
 	usb_hub_for_each_child(udev, port1, child) {
 		usb_lock_device(child);
 		active = usb_offload_check(child);
 		usb_unlock_device(child);
+
 		if (active)
-			return true;
+			break;
 	}
 
-	return !!udev->offload_usage;
+	return active;
 }
 EXPORT_SYMBOL_GPL(usb_offload_check);
+
+/**
+ * usb_offload_set_pm_locked - set the PM lock state of a USB device
+ * @udev: the USB device to modify
+ * @locked: the new lock state
+ *
+ * Setting @locked to true prevents offload_usage from being modified. This
+ * ensures that offload activities cannot be started or stopped during critical
+ * power management transitions, maintaining a stable state for the duration
+ * of the transition.
+ */
+void usb_offload_set_pm_locked(struct usb_device *udev, bool locked)
+{
+	spin_lock(&udev->offload_lock);
+	udev->offload_pm_locked = locked;
+	spin_unlock(&udev->offload_lock);
+}
+EXPORT_SYMBOL_GPL(usb_offload_set_pm_locked);
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index e740f7852bcd..8f7ca084010f 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -671,6 +671,7 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 	set_dev_node(&dev->dev, dev_to_node(bus->sysdev));
 	dev->state = USB_STATE_ATTACHED;
 	dev->lpm_disable_count = 1;
+	spin_lock_init(&dev->offload_lock);
 	dev->offload_usage = 0;
 	atomic_set(&dev->urbnum, 0);
 
diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index 2bd77255032b..1ddb64b0a48e 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -291,8 +291,8 @@ EXPORT_SYMBOL_GPL(xhci_sideband_get_event_buffer);
  * Allow other drivers, such as usb controller driver, to check if there are
  * any sideband activity on the host controller. This information could be used
  * for power management or other forms of resource management. The caller should
- * ensure downstream usb devices are all either suspended or marked as
- * "offload_at_suspend" to ensure the correctness of the return value.
+ * ensure downstream usb devices are all marked as "offload_pm_locked" to ensure
+ * the correctness of the return value.
  *
  * Returns true on any active sideband existence, false otherwise.
  */
diff --git a/include/linux/usb.h b/include/linux/usb.h
index fbfcc70b07fb..a4b031196da3 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -21,6 +21,7 @@
 #include <linux/completion.h>	/* for struct completion */
 #include <linux/sched.h>	/* for current && schedule_timeout */
 #include <linux/mutex.h>	/* for struct mutex */
+#include <linux/spinlock.h>	/* for spinlock_t */
 #include <linux/pm_runtime.h>	/* for runtime PM */
 
 struct usb_device;
@@ -636,8 +637,9 @@ struct usb3_lpm_parameters {
  * @do_remote_wakeup:  remote wakeup should be enabled
  * @reset_resume: needs reset instead of resume
  * @port_is_suspended: the upstream port is suspended (L2 or U3)
- * @offload_at_suspend: offload activities during suspend is enabled.
+ * @offload_pm_locked: prevents offload_usage changes during PM transitions.
  * @offload_usage: number of offload activities happening on this usb device.
+ * @offload_lock: protects offload_usage and offload_pm_locked
  * @slot_id: Slot ID assigned by xHCI
  * @l1_params: best effor service latency for USB2 L1 LPM state, and L1 timeout.
  * @u1_params: exit latencies for USB3 U1 LPM state, and hub-initiated timeout.
@@ -726,8 +728,9 @@ struct usb_device {
 	unsigned do_remote_wakeup:1;
 	unsigned reset_resume:1;
 	unsigned port_is_suspended:1;
-	unsigned offload_at_suspend:1;
+	unsigned offload_pm_locked:1;
 	int offload_usage;
+	spinlock_t offload_lock;
 	enum usb_link_tunnel_mode tunnel_mode;
 	struct device_link *usb4_link;
 
@@ -849,6 +852,7 @@ static inline void usb_mark_last_busy(struct usb_device *udev)
 int usb_offload_get(struct usb_device *udev);
 int usb_offload_put(struct usb_device *udev);
 bool usb_offload_check(struct usb_device *udev);
+void usb_offload_set_pm_locked(struct usb_device *udev, bool locked);
 #else
 
 static inline int usb_offload_get(struct usb_device *udev)
@@ -857,6 +861,8 @@ static inline int usb_offload_put(struct usb_device *udev)
 { return 0; }
 static inline bool usb_offload_check(struct usb_device *udev)
 { return false; }
+static inline void usb_offload_set_pm_locked(struct usb_device *udev, bool locked)
+{ }
 #endif
 
 extern int usb_disable_lpm(struct usb_device *udev);
-- 
2.53.0.1018.g2bb0e51243-goog


