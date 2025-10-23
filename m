Return-Path: <stable+bounces-189057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B8BFF46F
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 07:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DB93A83F3
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 05:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422D2242D7C;
	Thu, 23 Oct 2025 05:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABKZBjWL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C9E1D7999
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 05:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198593; cv=none; b=Ne8yNCPBLZlP9Dih95Il3PfCRcvZ32afao0Ryn25Q7/wxddvyCTG2Lv6v04XS+HtABquSNQ1101m/xm63dbmU8tJJ1ZWTcVmVDCmBUWAt600/huMrxi8kRTTelu480OerJDClulT43VTC4JuhxqqlWpMJIyjh+Bo5cjZgBZJk/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198593; c=relaxed/simple;
	bh=WE4jqOZA7KkdwOGi0+RVNNRpbqfXETLzoSlM4Ffn53Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iumBL/WHL2jbqngQ/l0orkYRzfcpr+ge9lgttgPRjajR2URzoJxu+OUxmIlsGqNdCl3F7x986b+CqQV1Wmyq1ozbnvwIdH3r6ACg4kzsQlv7B/I8Rsn0jvZZQLyZFyhEYdNzGbFt90+/us3TASkfIbipvp1ko0orBOgVB4qnj6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ABKZBjWL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290b13c5877so9378505ad.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 22:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761198590; x=1761803390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NIhAkKap4bXPdBe9tdBh2Dfw5XmidblPGWSaqTaADHM=;
        b=ABKZBjWLLZm/Oc1wpE4GI4xe5X4D20hK2ejNvvW40ymLb+BqyhEp4uOGvzZ1G+z3qu
         ZhR3+lpFOD76VFLkyCoCDKaqjdPQI2wFYoXPQwjqFKiJ3SpyLaC/yLj1FLwPX47UOxkU
         1D25Ne3w/v0ioM1LsgpYCfIkqr2v7tPjy0O2lOKHc2Uc5TnVV6Pcp3zInZk+Dht/XN1+
         3okcnq8hk0B0Q06AoJROofSLV3khshOkaCC+njrlbbx0tWdRW15yCWYyZ807XBTHCzLL
         f0Jduex7n7neiGnjLob8q5IAe3/6kmwr63mJ6rfGjl8BipVv4iJq2YDyednaVXB9ww0g
         FCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761198590; x=1761803390;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NIhAkKap4bXPdBe9tdBh2Dfw5XmidblPGWSaqTaADHM=;
        b=SFTKXEzO+ep01JXyUK/tYS/mE8ekTuviUqGmlGHsqzkD4va2oNVMwFeDEhJUS7OuAc
         TJJMo9NvGLP2fX8bWVmKyOLqdgZgF5szIAiKaNpuAIAl/yS8gCNII1GzmZLW5c94iOD/
         HYhlTerXAVdfN41Es8orh6ViD/bwrajxkpSxINUzwHBz971lPW7E+hPlPjWGfJfHFgkw
         YGFfnXEUl3KE1+x+xVXlAvDudvfObPPGqDzODDERYqSJrdlpp/orKN42iavwFZxVySXa
         5z9Nh4AIbpdWPtqNdWaOMimqHwOmtzuRhEWa2Yph+FlScFR+3q/6OaJqyDbruD8idGA7
         /sxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZYSCKzdUeVHG0V1VONmWL2rX4kXbUZmRNou4a0S+AN7gldRG3FffLHnxtIF67Xv1TIrdL9uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRiqz8AGqf2TT5529SsIL0Qn8jwMiMOt8YmmR+YSsTI7if1RIg
	ydca1Eqf0hpYLfhzsHiGTuOVAxgT7IcB5ydszyMciBAEwanp+eBybcNW5lHJsJSV4l+54uk4EzK
	B0INjSQ==
X-Google-Smtp-Source: AGHT+IEMjTPtfWycynhX8q/fK1VTeTW0RUJSCoi4GOOUYmYo+BFfUaUmR30ZiQtIXSsXWiJUkaNBSHcqvAY=
X-Received: from plxe8.prod.google.com ([2002:a17:902:ef48:b0:292:3da1:8ea8])
 (user=hhhuuu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:298c:b0:25c:38be:748f
 with SMTP id d9443c01a7336-290c9c89cb3mr259915235ad.9.1761198589120; Wed, 22
 Oct 2025 22:49:49 -0700 (PDT)
Date: Thu, 23 Oct 2025 05:49:45 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251023054945.233861-1-hhhuuu@google.com>
Subject: [PATCH v3] usb: gadget: udc: fix use-after-free in usb_gadget_state_work
From: Jimmy Hu <hhhuuu@google.com>
To: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc: badhri@google.com, hhhuuu@google.com, stern@rowland.harvard.edu, 
	royluo@google.com, Thinh.Nguyen@synopsys.com, balbi@ti.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A race condition during gadget teardown can lead to a use-after-free
in usb_gadget_state_work(), as reported by KASAN:

  BUG: KASAN: invalid-access in sysfs_notify+0x2c/0xd0
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
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
---
Changes in v3:
  - Updated patch title to more accurately describe the bug.
  - Moved changelog below the '---' line as requested by Greg KH.
  - Rebased on usb-linus branch as requested by Greg KH.

Changes in v2:
  - Removed redundant inline comments as suggested by Alan Stern.

 drivers/usb/gadget/udc/core.c | 17 ++++++++++++++++-
 include/linux/usb/gadget.h    |  5 +++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 694653761c44..8dbe79bdc0f9 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1126,8 +1126,13 @@ static void usb_gadget_state_work(struct work_struct *work)
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
 	trace_usb_gadget_set_state(gadget, 0);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_state);
@@ -1361,6 +1366,8 @@ static void usb_udc_nop_release(struct device *dev)
 void usb_initialize_gadget(struct device *parent, struct usb_gadget *gadget,
 		void (*release)(struct device *dev))
 {
+	spin_lock_init(&gadget->state_lock);
+	gadget->teardown = false;
 	INIT_WORK(&gadget->work, usb_gadget_state_work);
 	gadget->dev.parent = parent;
 
@@ -1535,6 +1542,7 @@ EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
 void usb_del_gadget(struct usb_gadget *gadget)
 {
 	struct usb_udc *udc = gadget->udc;
+	unsigned long flags;
 
 	if (!udc)
 		return;
@@ -1548,6 +1556,13 @@ void usb_del_gadget(struct usb_gadget *gadget)
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
index 3aaf19e77558..8285b19a25e0 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -376,6 +376,9 @@ struct usb_gadget_ops {
  *	can handle. The UDC must support this and all slower speeds and lower
  *	number of lanes.
  * @state: the state we are now (attached, suspended, configured, etc)
+ * @state_lock: Spinlock protecting the `state` and `teardown` members.
+ * @teardown: True if the device is undergoing teardown, used to prevent
+ *	new work from being scheduled during cleanup.
  * @name: Identifies the controller hardware type.  Used in diagnostics
  *	and sometimes configuration.
  * @dev: Driver model state for this abstract device.
@@ -451,6 +454,8 @@ struct usb_gadget {
 	enum usb_ssp_rate		max_ssp_rate;
 
 	enum usb_device_state		state;
+	spinlock_t			state_lock;
+	bool				teardown;
 	const char			*name;
 	struct device			dev;
 	unsigned			isoch_delay;
-- 
2.51.1.814.gb8fa24458f-goog


