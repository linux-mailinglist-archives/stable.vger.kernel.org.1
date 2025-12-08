Return-Path: <stable+bounces-200373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C329ECAE301
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 22:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B245306AEDF
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 21:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBEC2C08BC;
	Mon,  8 Dec 2025 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tw4YJp18"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC401DD9AD
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 21:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765227927; cv=none; b=rEwuKU55oFVoP42qRjFRC4KgnArQeYKvdTNNZ8qLLPoIxjRkrceSpsfxdnBiGu7a8hrY8apFpmBglPa++AIJfVdiki7yL3Y/mPRCI6twd1oTlwgQIJju10c13fnsc2J+WAHHHGSn6pCpPkbvwT0lLu/81nPYhLTzz1hIlCv6Xno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765227927; c=relaxed/simple;
	bh=qcl+hxjX+3cybnx+FfO1wrSKs+v+LKskuWGqNb9Q8CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J801OTFfkq7QxZR7S9DroSbZqT19uFvsOZzSV1VJGKN5uHRmb9RyIDe4KVfNEiB8Ca48t1ne0dawgZt0aeuWnoHUc8KitbFz+dC1DetH1gBdT3OuvgcNEUa168YYjCsGvWQ4T3u8nAp49Kze3NZ6RcCQMa1GOpa2LdLqVvzuEvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tw4YJp18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB4FC4CEF1;
	Mon,  8 Dec 2025 21:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765227927;
	bh=qcl+hxjX+3cybnx+FfO1wrSKs+v+LKskuWGqNb9Q8CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tw4YJp18726MfrECTrh+EJFrwK2SgvLXVDvCuSkSB3CWUJMa/ViPYbagSjjRls9D9
	 RAR5rUWD7X7PBCzy79NumnprqQt4GSHZZ4iOZQEtpRaooiB088v43BHGcBcjnvDMbg
	 Qw+wTA/ESwcFaUuW3tAO2JM0bLmSR7N3DMEqzNhV+aRfBvIDV4O9HMfLH6GwDF+CTd
	 HBlrosU3Qfz19MkVV0K3DlkllOvAK7Hv6y1y9MvY9WWwe9BZxEdVl6lI/L7vpIIAvQ
	 zJif4qxlw3ePtpd3MK4lDSiT8pnLdFXKgM0cTxL44AtrWoASn2do3xvCgc/yGxQKF5
	 lHHFaUSdtxfrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jimmy Hu <hhhuuu@google.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: gadget: udc: fix use-after-free in usb_gadget_state_work
Date: Mon,  8 Dec 2025 16:05:23 -0500
Message-ID: <20251208210523.401003-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120129-earthlike-curse-b3f8@gregkh>
References: <2025120129-earthlike-curse-b3f8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jimmy Hu <hhhuuu@google.com>

[ Upstream commit baeb66fbd4201d1c4325074e78b1f557dff89b5b ]

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
Cc: stable <stable@kernel.org>
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
Link: https://patch.msgid.link/20251023054945.233861-1-hhhuuu@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/core.c | 17 ++++++++++++++++-
 include/linux/usb/gadget.h    |  5 +++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index dd2fafc5b0c3e..598053bf985db 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1037,8 +1037,13 @@ static void usb_gadget_state_work(struct work_struct *work)
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
 
@@ -1199,6 +1204,8 @@ void usb_initialize_gadget(struct device *parent, struct usb_gadget *gadget,
 		void (*release)(struct device *dev))
 {
 	dev_set_name(&gadget->dev, "gadget");
+	spin_lock_init(&gadget->state_lock);
+	gadget->teardown = false;
 	INIT_WORK(&gadget->work, usb_gadget_state_work);
 	gadget->dev.parent = parent;
 
@@ -1376,6 +1383,7 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 void usb_del_gadget(struct usb_gadget *gadget)
 {
 	struct usb_udc *udc = gadget->udc;
+	unsigned long flags;
 
 	if (!udc)
 		return;
@@ -1394,6 +1402,13 @@ void usb_del_gadget(struct usb_gadget *gadget)
 	mutex_unlock(&udc_lock);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
+	/*
+	 * Set the teardown flag before flushing the work to prevent new work
+	 * from being scheduled while we are cleaning up.
+	 */
+	spin_lock_irqsave(&gadget->state_lock, flags);
+	gadget->teardown = true;
+	spin_unlock_irqrestore(&gadget->state_lock, flags);
 	flush_work(&gadget->work);
 	device_unregister(&udc->dev);
 	device_del(&gadget->dev);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 11df3d5b40c6b..8bdeced70a339 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -341,6 +341,9 @@ struct usb_gadget_ops {
  * @max_speed: Maximal speed the UDC can handle.  UDC must support this
  *      and all slower speeds.
  * @state: the state we are now (attached, suspended, configured, etc)
+ * @state_lock: Spinlock protecting the `state` and `teardown` members.
+ * @teardown: True if the device is undergoing teardown, used to prevent
+ *	new work from being scheduled during cleanup.
  * @name: Identifies the controller hardware type.  Used in diagnostics
  *	and sometimes configuration.
  * @dev: Driver model state for this abstract device.
@@ -408,6 +411,8 @@ struct usb_gadget {
 	enum usb_device_speed		speed;
 	enum usb_device_speed		max_speed;
 	enum usb_device_state		state;
+	spinlock_t			state_lock;
+	bool				teardown;
 	const char			*name;
 	struct device			dev;
 	unsigned			isoch_delay;
-- 
2.51.0


