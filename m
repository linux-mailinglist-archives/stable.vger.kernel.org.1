Return-Path: <stable+bounces-183650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB000BC7320
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 04:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3A244ED62B
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 02:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AD22B9B7;
	Thu,  9 Oct 2025 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZAOK3i3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B842F29
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759976516; cv=none; b=EP+QFsb/rS3Ye+9SDE+0ulhFHnuR0SUOj02ax9IPdFRgneb5JCnCbv93V70GqtTb64GEOxSqG92sFYIuQ+1E2yJuUoG6atqs4UgdFbZr0XXeZ7i2fql2+cUddIg0ZAbxBzAv+w0gspCvodN6XhdmoMM9JcIv7EQa5idjlLf1Ei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759976516; c=relaxed/simple;
	bh=3E34g8to+7YP8tDavcynDJIlQYsxd692ze/8ljHsty4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P81UX0XQJCCb6BDb8pTGr4s/wdbG7uh97+Z0bhAn4mnTMJlR9BZm4Fy+Hol53UUScbnKd1I96Gk4Zx+3E7jLXOOOlLnqhviA5JRBonDETxyJ3DS2UtwSZJwuqH46zKPIz1bdwZIiRdEONx6J8irycAd5+/SOB4OIhRY3Gd7na44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZAOK3i3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7811a602576so970090b3a.0
        for <stable@vger.kernel.org>; Wed, 08 Oct 2025 19:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759976514; x=1760581314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iGu6dFYwE/2Nf8J+0985oWxkB/pnBGdxJtFkLo+v4g8=;
        b=pZAOK3i3OBcd7fytx7/AmmRRu+N+GUr06OBtfqVdf6J99rbq2yBii3KEEx6LpNb0Ty
         gHEO3c92JAX9GRE94JWG1e0OoVHy//y1dR0v/UGDbYCEWhkI7/7Ac6YOXAGWrGrwWFB2
         SCP1xmaiL91PdFO6Bi9XQImsX72rxjT8Re6rYKHp56dPlPlzLPqvXxhNDIO61CZdDcQB
         8gVj7tBOU2engbz5QZgGK8U345pUPNMQxNc93OX04Jqn+0pT8RWpqN29qvstSvU9edHQ
         pDkVcohjzQINDhREJJC0XafXLKHS2NUFQ0gwq1wGN/VqYIEfvnCW7MCSpN/z3aThORmr
         YRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759976514; x=1760581314;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGu6dFYwE/2Nf8J+0985oWxkB/pnBGdxJtFkLo+v4g8=;
        b=KEzQjeWTBzb7cPlhzoU0XkOWexKpAdvMZ5dBn/2E0fsijuJmnd8GhNRlWsgSZDiSSn
         HFTgdtsuf1yfv3FswnWdTyG0OFotp5/kHCLv1xZr/wPcVwkqM6zYmeYJGVNSEtJowddv
         JnBAJW0JqRfaRPpBrPrwZak6wBwQ/rN9pE5vwd5HWk+viJvGJRprqbT4n5I9ULYmO9HS
         WsVwdHApdXvDTiqCijpemcsQjVE6LXvYHCVUJypZrZ/Tb+3gSaFqSLOLRHfehriIanmJ
         gPH61hJ2dEqaap+gjXRne8Bbn3AzA5FSj5QJeJtDJp3aALFCDZ7c6FLvVOx8H8r+3dsb
         Kw8A==
X-Gm-Message-State: AOJu0YwkGsIGXl2mI3cpqDM2Hk30mLhY75X1ZQcuuxnzKFyaNzP3e+wf
	T4dn4Hb3TEcNJBMfkouUYj5Qz1CUHuN3ls+Ok2ToHhkBYcCgUhiKlLBx3eSEN85YkOWnpKF/RZW
	BrKcTRg==
X-Google-Smtp-Source: AGHT+IHUAlTJM0x1OZryvRkw6eJi4g2n2Y4PtPufiVsX9TNdmy2iziRDWT1xAsX+hDC6NUhRgi1y7PPodyI=
X-Received: from pjbfz20.prod.google.com ([2002:a17:90b:254:b0:33b:52d6:e13e])
 (user=hhhuuu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:430e:b0:248:4d59:93d5
 with SMTP id adf61e73a8af0-32da84edde1mr7492815637.55.1759976513668; Wed, 08
 Oct 2025 19:21:53 -0700 (PDT)
Date: Thu,  9 Oct 2025 02:21:49 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Message-ID: <20251009022150.302915-1-hhhuuu@google.com>
Subject: [PATCH] usb: gadget: udc: fix race condition in usb_del_gadget
From: Jimmy Hu <hhhuuu@google.com>
To: hhhuuu@google.com
Cc: stable@vger.kernel.org
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


