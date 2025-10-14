Return-Path: <stable+bounces-185608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B37BD848F
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7E07350622
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567082E0939;
	Tue, 14 Oct 2025 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWEAtvBK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2A62DC79B
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431923; cv=none; b=Rvcaxvl3K3G9Hwx6F6UatP6XMmt5XDqiB7L0BubqQ27UMaswWBrZAu50tkvo7ZFisiw5XuPsH3W8b6SHRpJkCY2l8KheVPMrdDpQza0uBse8Oj9/QSa13Z4vYll0XlgtOadwc2uzh2v5Ogc9McdPlALE9fQy19yyadv4YndNwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431923; c=relaxed/simple;
	bh=PxY9YI4CSmdKhC6uoizpHkfwmH3aq/ev/ew2lUtOZuE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h7EhDKxI4dLopmm3oL9HOB6tWSu/ra9RUEJIwgDiW+tCUSHeRT3LDNc8JBQ3T1weI4tqrP5ut7fQ+OkwPjAhvUeftWaTnL+444H5iD7u/TckSz38TMDdRmEXlxHnn4frxywlzt4iOYVsw1kWoomRGVmFEBcTQarnsLLRJGbmgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HWEAtvBK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2699ed6d43dso92406715ad.1
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760431921; x=1761036721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bX12dqdVlICTMSRoW5hHUvlBwoKcGr52PuS1MGrj6wY=;
        b=HWEAtvBKRJzCwsZpxc8cEQk4D5VsMXPcLM6KNQ74Er9O9GSI9uCAPLdY0IFN32YzFr
         4ghCsTFcxdncomvoRBPcGxPgrpAxhcYmthssDlwVRkRhuGGl0pOB/PjpV5+059WmgM0l
         XnygJbTwelO3cFA2qZm31JaY1xtQZ4AE+raeDVDePw+3tmatL5XZ3Wnd7BbfeuIxkziY
         hD8PfvnZhspoD5uN9OOGj800lNtSVkOuu0LBnlWJJQKuhpRt4AUVO8d7R8V1cCHClspH
         dg2Jj6clC5R2wOtWwAUFTw7Z/MycARw6arxWyl+1palnv4xpGUMmuwvFBYjn90fuz+KR
         EmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760431921; x=1761036721;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bX12dqdVlICTMSRoW5hHUvlBwoKcGr52PuS1MGrj6wY=;
        b=VNn9O082Xa9VMfLyyu/2vryB+go6dHsCtAhtBCEjz4DdSuEIR1RKABQcIsXpd8K+ji
         al+dYFaIQy5loXZg0x0Zmzvyh7yWLqD4B/L08PTR3xKW8XfNKo4IRqiXQeeTec4sP5pS
         sMaLwisqhs0YGzhVsFkAD1DvfmyD4//vz/oesw8Ep/dI6gGYGst2/Zb3c7Q7o6epv0Sj
         cPHTcsv1fVpc1ItrS+/O30nrd+rXpcXmnP84SnizZqEdwQa9raKLV+gKmMWVBJ5LLg0c
         X39Zsl/2F1Wzp6bSdjpLHGS9tXfg0FLZcHocCjT2gSCYeXljM4PDfkhwDs3D0/k0Nbfd
         w18w==
X-Forwarded-Encrypted: i=1; AJvYcCUuPBNpTO5RkpA/cmXeGDhZZpbL97RSGN8rdaipWTDa2UCTgmnxMt+1eS2LBauIs2aH1wsrow4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNL7cSGg2qjJ3yK6E7iEXowwpTENcgL77l1fySs0ueB5y/CiV5
	tVf3wktH/n/N8GH62GdYZSWltCk2tnshRHkw6lGvUATXjF8PuC7DfPmGM7q3f77CdSIKlPw9CsY
	fef5Mmw==
X-Google-Smtp-Source: AGHT+IG+Fi46f+lO8zssLsTmLd69T+nbCbw1cECTScqiKJBBv7O5leY+nhhN6mss+yBFIX4Zx7GK1+Ok9KU=
X-Received: from plbka8.prod.google.com ([2002:a17:903:3348:b0:290:28e2:ce54])
 (user=hhhuuu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f0e:b0:248:a642:eec6
 with SMTP id d9443c01a7336-29027402f2dmr259664015ad.50.1760431920649; Tue, 14
 Oct 2025 01:52:00 -0700 (PDT)
Date: Tue, 14 Oct 2025 08:51:56 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Message-ID: <20251014085156.2651449-1-hhhuuu@google.com>
Subject: [PATCH v2] usb: gadget: udc: fix race condition in usb_del_gadget
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

Changes in v2:
  - Removed redundant inline comments as suggested by Alan Stern.

Fixes: 5702f75375aa9 ("usb: gadget: udc-core: move sysfs_notify() to a workqueue")
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
Cc: stable@vger.kernel.org
---
 drivers/usb/gadget/udc/core.c | 17 ++++++++++++++++-
 include/linux/usb/gadget.h    |  5 +++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d709e24c1fd4..66d2428835da 100644
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
 
@@ -1357,6 +1362,8 @@ static void usb_udc_nop_release(struct device *dev)
 void usb_initialize_gadget(struct device *parent, struct usb_gadget *gadget,
 		void (*release)(struct device *dev))
 {
+	spin_lock_init(&gadget->state_lock);
+	gadget->teardown = false;
 	INIT_WORK(&gadget->work, usb_gadget_state_work);
 	gadget->dev.parent = parent;
 
@@ -1531,6 +1538,7 @@ EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
 void usb_del_gadget(struct usb_gadget *gadget)
 {
 	struct usb_udc *udc = gadget->udc;
+	unsigned long flags;
 
 	if (!udc)
 		return;
@@ -1544,6 +1552,13 @@ void usb_del_gadget(struct usb_gadget *gadget)
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
index 0f28c5512fcb..8b5e593f7966 100644
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
@@ -426,6 +429,8 @@ struct usb_gadget {
 	enum usb_ssp_rate		max_ssp_rate;
 
 	enum usb_device_state		state;
+	spinlock_t			state_lock;
+	bool				teardown;
 	const char			*name;
 	struct device			dev;
 	unsigned			isoch_delay;
-- 
2.51.0.760.g7b8bcc2412-goog


