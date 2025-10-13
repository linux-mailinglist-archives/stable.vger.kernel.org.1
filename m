Return-Path: <stable+bounces-184139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA53BD1E55
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 09:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0F21895C74
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 07:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F672EA46F;
	Mon, 13 Oct 2025 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4eJenCc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD52E2DFA
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342283; cv=none; b=Chza7DOdNSs87k3gSBAs1qfBc7HqwXiDkLYcnENOJRVPh6uyFqhZj0ausZXLgPxPt67Zq2lIGdNR1UvG6St0GuEfMskUwsuysOi6dT8P8URWRRGFILv9mPNL7pzbH2nDma/4b9wK8cKPSgVUldWH+MSkXJV6RINT77sRuxlchBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342283; c=relaxed/simple;
	bh=3E34g8to+7YP8tDavcynDJIlQYsxd692ze/8ljHsty4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hS1vmUgbQe/NkTUVzRuWlT0yBa8FXNgOmGJyxcZ5F+baVX8Z4EVF4o3LvK+WWk1X1vl8t91xIa1bIXL8fKNEvCEeO1HGxxslei2Cjqifn9xUNKGf3NF94geWHpCzvmCPDoNw/tJQYvJZoQMviI2jq3S4F8dortMad6/jKfB//oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F4eJenCc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27c62320f16so94066945ad.1
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 00:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760342281; x=1760947081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iGu6dFYwE/2Nf8J+0985oWxkB/pnBGdxJtFkLo+v4g8=;
        b=F4eJenCcKgr+Sug7Fn1KE7yTfs6BFHINFdsV7z9t/a0sOiQiakPiSq5ToffWy4HSZW
         OyChmYwTWnoa4jQ1qUHvX2KjI1Jcj0rG4AsMQWaO2657RfmQPC1m2tTnCgAMAzha1xkP
         oVf954067UF8qRcV7TSohGB6/As3v+aV0VgaY2SQZvk940nCsPT01AB2JTJHwhp7TxA9
         Xvk0IfJ084OEA62pat2ETitrg7Qqwt8L8UwcltTqQI9PMkNrjrFxSl+mU6nZWzZPdY/D
         IC8128O1JhHsuEURgpjSW4wLwX17FZpLSep9UFtFaqQp1h586xcqQiXVdxDFVBc3eE8z
         k/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760342281; x=1760947081;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGu6dFYwE/2Nf8J+0985oWxkB/pnBGdxJtFkLo+v4g8=;
        b=ES9DJK5soGqoNeRXhOOmqNL4ZeLKKC/BoZB6DRKTfMSqqA1Ii2iJwBxTEp0Hk4BxZr
         biud2qn/3qn1ka4rEEA2QhLlk9TF8LDRPo2ImqkoOdCY34ISq1jXOSmWGQXc09Vexno7
         y0t4+1iKbOCqDXtkve/V/5j0sXTxolSlM6k8qZ/i8MY7ISFSHxXKkIYV3EZ6LDd8Q+6k
         jT/GWOttbO/eGTyr8egxPk6Xg+8fzdT50HSNFRnbjydvvfQw0GY2Rxf0SFkxLCUrVIR8
         zTbGQVOZ4JjTSEUVmRZUTSi4p3vOSTKP4fT/91ufDE9GJTznT8+ZbBsA8/jVVQVY1MrU
         davg==
X-Forwarded-Encrypted: i=1; AJvYcCUHgKAtCX3G//lBDULvwmZvaVtiN82zmErNsT5EDxcOe/pU8gVOqVL7MeVkubEAvTCSfZGHC9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxEfIPEBV9pMKr3NdpACnSnSlbAJgo09iNS09VNj9Lg4XgOKSD
	05xdaibZceAK99hpL2p0VM5d1fg5WcwfhO6tn5OzR3XQ1y5byhRZBcnQECieka0puV64zH0K7ru
	pYqpO/g==
X-Google-Smtp-Source: AGHT+IHJ/pA9YA+/yrVB2YKyaQZ1ueZAHnptFV5pNWfOzlJvkkhQMMmsTQndiI2iKW3n9vHmx1cju8mAurg=
X-Received: from plly16.prod.google.com ([2002:a17:902:7c90:b0:290:28e2:ce61])
 (user=hhhuuu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec2:b0:256:2b13:5f11
 with SMTP id d9443c01a7336-290272e19bbmr311483875ad.40.1760342280491; Mon, 13
 Oct 2025 00:58:00 -0700 (PDT)
Date: Mon, 13 Oct 2025 07:57:56 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013075756.2056211-1-hhhuuu@google.com>
Subject: [PATCH] usb: gadget: udc: fix race condition in usb_del_gadget
From: Jimmy Hu <hhhuuu@google.com>
To: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc: badhri@google.com, hhhuuu@google.com, stern@rowland.harvard.edu, 
	royluo@google.com, Thinh.Nguyen@synopsys.com, balbi@ti.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A race condition during gadget teardown can lead to a use-after-free
in usb_gadget_state_work(), as reported by KASAN:

  BUG: KASAN: invalid-access in sysfs_notify+0_x_2c/0_x_d0
  Workqueue: events usb_gadget_state_work

The fundamental race occurs because a concurrent event (e.g., an
interrupt) can call usb_gadget_set_state() and schedule gadget->work
at any time during the cleanup process in usb_del_gadget().

Commit 399a45e5237c ("usb: gadget: core: flush gadget workqueue after
device removal") attempted to fix this by moving flush_work() to after
device_del(). However, this does not fully solve the race, as a new
work item can still be scheduled *after* flush_work() completes but
before the gadget's memory is freed, leading to the same use-after-free.

This patch fixes the race condition robustly by introducing a 'teardown'
flag and a 'state_lock' spinlock to the usb_gadget struct. The flag is
set during cleanup in usb_del_gadget() *before* calling flush_work() to
prevent any new work from being scheduled once cleanup has commenced.
The scheduling site, usb_gadget_set_state(), now checks this flag under
the lock before queueing the work, thus safely closing the race window.

Fixes: 5702f75375aa9 ("usb: gadget: udc-core: move sysfs_notify() to a workqueue")
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
Cc: stable@vger.kernel.org
---
 drivers/usb/gadget/udc/core.c | 18 +++++++++++++++++-
 include/linux/usb/gadget.h    |  6 ++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d709e24c1fd4..c4268b76d747 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1123,8 +1123,13 @@ static void usb_gadget_state_work(struct work_struct *work)
 void usb_gadget_set_state(struct usb_gadget *gadget,
 		enum usb_device_state state)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&gadget->state_lock, flags);
 	gadget->state = state;
-	schedule_work(&gadget->work);
+	if (!gadget->teardown)
+		schedule_work(&gadget->work);
+	spin_unlock_irqrestore(&gadget->state_lock, flags);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
@@ -1357,6 +1362,9 @@ static void usb_udc_nop_release(struct device *dev)
 void usb_initialize_gadget(struct device *parent, struct usb_gadget *gadget,
 		void (*release)(struct device *dev))
 {
+	/* For race-free teardown */
+	spin_lock_init(&gadget->state_lock);
+	gadget->teardown = false;
 	INIT_WORK(&gadget->work, usb_gadget_state_work);
 	gadget->dev.parent = parent;
 
@@ -1531,6 +1539,7 @@ EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
 void usb_del_gadget(struct usb_gadget *gadget)
 {
 	struct usb_udc *udc = gadget->udc;
+	unsigned long flags;
 
 	if (!udc)
 		return;
@@ -1544,6 +1553,13 @@ void usb_del_gadget(struct usb_gadget *gadget)
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	sysfs_remove_link(&udc->dev.kobj, "gadget");
 	device_del(&gadget->dev);
+	/*
+	 * Set the teardown flag before flushing the work to prevent new work
+	 * from being scheduled while we are cleaning up.
+	 */
+	spin_lock_irqsave(&gadget->state_lock, flags);
+	gadget->teardown = true;
+	spin_unlock_irqrestore(&gadget->state_lock, flags);
 	flush_work(&gadget->work);
 	ida_free(&gadget_id_numbers, gadget->id_number);
 	cancel_work_sync(&udc->vbus_work);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 0f28c5512fcb..8302aeaea82e 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -351,6 +351,9 @@ struct usb_gadget_ops {
  *	can handle. The UDC must support this and all slower speeds and lower
  *	number of lanes.
  * @state: the state we are now (attached, suspended, configured, etc)
+ * @state_lock: Spinlock protecting the `state` and `teardown` members.
+ * @teardown: True if the device is undergoing teardown, used to prevent
+ *	new work from being scheduled during cleanup.
  * @name: Identifies the controller hardware type.  Used in diagnostics
  *	and sometimes configuration.
  * @dev: Driver model state for this abstract device.
@@ -426,6 +429,9 @@ struct usb_gadget {
 	enum usb_ssp_rate		max_ssp_rate;
 
 	enum usb_device_state		state;
+	/* For race-free teardown and state management */
+	spinlock_t			state_lock;
+	bool				teardown;
 	const char			*name;
 	struct device			dev;
 	unsigned			isoch_delay;
-- 
2.51.0.618.g983fd99d29-goog


