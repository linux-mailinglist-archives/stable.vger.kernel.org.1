Return-Path: <stable+bounces-233512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOd2DJq31GnQwgcAu9opvQ
	(envelope-from <stable+bounces-233512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 09:51:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E233AAFE1
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 09:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C51E43026177
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 07:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3FA3A3E64;
	Tue,  7 Apr 2026 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G13xeWcv"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40D3A257B
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548244; cv=none; b=cP3ymmI6eoyMjK/y0+3SVPANxHnQBTi4RbbuZayFeq9v0xjiprChMapfIn/02o1GNvIN1yImeeGG24tJ9noUeVZRTnlbZtzCUwn0qnjpZeQf9bun/sGsNLhGhlHkrkS1KGvnFsH8WzbV1tJ2e3jeWn9G1wBVpih2mRCw2GpV5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548244; c=relaxed/simple;
	bh=IdWuS85toG2XB88l83aLIKH1J6yNHDj+tjm+o0igdrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkdhp7YE6cxt2LH04K3wYpzcOSFFgSsYRqcSVylSKQbC+ywlrUNxVcvzgUPcB2W/e2REM5lX2KFSK+d0gjVJWJE+0SMYFcNe4lFdI/Xy7iTAEOQmxAd5qDD24j88r0ttY7JC1ROqjidbLw8xvUX3CDIyGq7MKfj6vwoewMSm2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G13xeWcv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so2447352e87.2
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 00:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775548240; x=1776153040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=unfP0Io+eWCdwZ48Sql8cCkVMUb4bc5MzgzrzSKUpi4=;
        b=G13xeWcvZFDw0Xh+1xVbLWgukSCj29I1HQmfZwONtjQXufSiiADJ9iUV3YXk0vO4IV
         ornxOYJWZ83+XzxCSA4JL0WUi09uji1QYpJ1uvEknMa3qAJjAQpLTtbpJ+CaAVKPB7/m
         hcllfU6GaJm0cuAuTTHFdAIbmpyQ/7LZHJEcmpKW6wdQo1xXOmT8EGCdj/V347TH0rbc
         5SJR09E75Nwk/2kX43vEX19J01p3fS6BRSSz49alF6EWTXxTkC2DYQLvTRTTLdSigi2N
         q20/p700y83oKypb9mY0PdwxxfmwZY+A4J8QxAKGbQf2x7NJBsvbHsp4vRf2OR+TROlH
         ADjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775548240; x=1776153040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unfP0Io+eWCdwZ48Sql8cCkVMUb4bc5MzgzrzSKUpi4=;
        b=sAb9m2/q+mcGqB+5aO0TzeWbZ5vw0aGH/9VQgdZQq+sYU18Pn0oKi9Ooz2CYfj1E5K
         k0co0wUlKELXcWH53n7husTaW31yUHDxZwCgAUPC7N+ut4Ec4uaO8/KCnUPKWTw18iMJ
         BWKi3DNPKN+t0QBx7PK7D8Soywi8RBsAeqijGpyffW9p6Qxfq4MfEqU/LAJrGcat+3w1
         MmlUsqPkupeKdKB4y/1VRS7BSw9lWYU1l6XSWM3CZxJpjAoRmjlj+sE1gF+QaHgb01g9
         R+tIrEmaCCGA8OR5T5koQ5JfpX8cxE5NZ8mmbiByrNk/Vzw2YeUgsHUchNYqkWJKduVn
         RRpg==
X-Forwarded-Encrypted: i=1; AJvYcCV8ssG3LagU8SK2QxWwJfjqxs3LhuL/q8GQE1QHr1CB5YsJbPH5uYo5tlUSNB3YWhMRpRPCGQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVqdnPf0eRF4sx3TC1ygJ17QRSJlIT7peRoGOWFTfkJlxuTy53
	+gLa4N8j3Hlulgg4ZEN3DebWoKs0pllHXM3VPTNDhMBWtdEkxIQD/9xD
X-Gm-Gg: AeBDiesPeqUBQJW9exurG0m2meoYCkChI4YP8+2c+xLBGgwtp/aA4XQkJPLVmIBYt7+
	lHhtW085qLAEMxO/9N5bUr3AsYksk3ct8CUGFGcSW1FVOEbGfqQZYATxapNX10lxp3MQBWEz8Rl
	bk+eCHiQNRn5hzQSlJNmnkYf9qpswEVH2uthxXiSFmQznwMbRxG12XPNM9mNXdwusZcDa+/gt9m
	DUlT/T7G56qW4lKGVDMnyAzsT+PY6CDI6+r0iuVeT8AChDp5HOa/sFHZ4Ml+C2HSGuez6NrsOUv
	j8/ucOSGNbb794mL4d2KIyOG8xg+rCFSLsGkMGySyI3oBc0kZzTsr+9rapZOJctTKiLa/RyX8JP
	dLkv8nEqXbVq4NqAFDUfaDYzP1/iH4pRDIZWqe/kdNsxPrQLP4k5P+QBY/xG03dOSURBFDip4Tf
	x+OE9UZ1CikrzbQUO1Fo7ScnRYKa6kUpgJ0g==
X-Received: by 2002:a05:6512:124e:b0:5a2:a753:8f0a with SMTP id 2adb3069b0e04-5a337591ec2mr4435727e87.34.1775548239590;
        Tue, 07 Apr 2026 00:50:39 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6c9519bsm3960950e87.8.2026.04.07.00.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 00:50:38 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2] Input: uinput - fix circular locking dependency with ff-core
Date: Tue,  7 Apr 2026 12:50:31 +0500
Message-ID: <20260407075031.38351-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-233512-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6E233AAFE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A lockdep circular locking dependency warning can be triggered
reproducibly when using a force-feedback gamepad with uinput (for
example, playing ELDEN RING under Wine with a Flydigi Vader 5
controller):

  ff->mutex -> udev->mutex -> input_mutex -> dev->mutex -> ff->mutex

The cycle is caused by four lock acquisition paths:

1. ff upload: input_ff_upload() holds ff->mutex and calls
   uinput_dev_upload_effect() -> uinput_request_submit() ->
   uinput_request_send(), which acquires udev->mutex.

2. device create: uinput_ioctl_handler() holds udev->mutex and calls
   uinput_create_device() -> input_register_device(), which acquires
   input_mutex.

3. device register: input_register_device() holds input_mutex and
   calls kbd_connect() -> input_register_handle(), which acquires
   dev->mutex.

4. evdev release: evdev_release() calls input_flush_device() under
   dev->mutex, which calls input_ff_flush() acquiring ff->mutex.

Fix this by introducing a new state_lock spinlock to protect
udev->state and udev->dev access in uinput_request_send() instead of
acquiring udev->mutex.  The function only needs to atomically check
device state and queue an input event into the ring buffer via
uinput_dev_event() -- both operations are safe under a spinlock
(ktime_get_ts64() and wake_up_interruptible() do not sleep).  This
breaks the ff->mutex -> udev->mutex link since a spinlock is a leaf in
the lock ordering and cannot form cycles with mutexes.

To keep state transitions visible to uinput_request_send(), protect
writes to udev->state in uinput_create_device() and
uinput_destroy_device() with the same state_lock spinlock.

Additionally, move init_completion(&request->done) from
uinput_request_send() to uinput_request_submit() before
uinput_request_reserve_slot().  Once the slot is allocated,
uinput_flush_requests() may call complete() on it at any time from
the destroy path, so the completion must be initialised before the
request becomes visible.

Lock ordering after the fix:

  ff->mutex -> state_lock (spinlock, leaf)
  udev->mutex -> state_lock (spinlock, leaf)
  udev->mutex -> input_mutex -> dev->mutex -> ff->mutex (no back-edge)

Fixes: ff462551235d ("Input: uinput - switch to the new FF interface")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/CABXGCsMoxag+kEwHhb7KqhuyxfmGGd0P=tHZyb1uKE0pLr8Hkg@mail.gmail.com/
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

Changes since v1:
https://lore.kernel.org/all/20260228223628.472208-1-mikhail.v.gavrilov@gmail.com/

- Use a dedicated state_lock spinlock instead of reusing requests_lock,
  as suggested by Dmitry Torokhov
- Add Fixes and Cc: stable tags

 drivers/input/misc/uinput.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index e589060db280..e24caf6fc8e8 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -57,6 +57,7 @@ struct uinput_device {
 	struct input_dev	*dev;
 	struct mutex		mutex;
 	enum uinput_state	state;
+	spinlock_t		state_lock;
 	wait_queue_head_t	waitq;
 	unsigned char		ready;
 	unsigned char		head;
@@ -146,19 +147,15 @@ static void uinput_request_release_slot(struct uinput_device *udev,
 static int uinput_request_send(struct uinput_device *udev,
 			       struct uinput_request *request)
 {
-	int retval;
+	int retval = 0;
 
-	retval = mutex_lock_interruptible(&udev->mutex);
-	if (retval)
-		return retval;
+	spin_lock(&udev->state_lock);
 
 	if (udev->state != UIST_CREATED) {
 		retval = -ENODEV;
 		goto out;
 	}
 
-	init_completion(&request->done);
-
 	/*
 	 * Tell our userspace application about this new request
 	 * by queueing an input event.
@@ -166,7 +163,7 @@ static int uinput_request_send(struct uinput_device *udev,
 	uinput_dev_event(udev->dev, EV_UINPUT, request->code, request->id);
 
  out:
-	mutex_unlock(&udev->mutex);
+	spin_unlock(&udev->state_lock);
 	return retval;
 }
 
@@ -175,6 +172,13 @@ static int uinput_request_submit(struct uinput_device *udev,
 {
 	int retval;
 
+	/*
+	 * Initialize completion before allocating the request slot.
+	 * Once the slot is allocated, uinput_flush_requests() may
+	 * complete it at any time, so it must be initialized first.
+	 */
+	init_completion(&request->done);
+
 	retval = uinput_request_reserve_slot(udev, request);
 	if (retval)
 		return retval;
@@ -289,7 +293,14 @@ static void uinput_destroy_device(struct uinput_device *udev)
 	struct input_dev *dev = udev->dev;
 	enum uinput_state old_state = udev->state;
 
+	/*
+	 * Update state under state_lock so that concurrent
+	 * uinput_request_send() sees the state change before we
+	 * flush pending requests and tear down the device.
+	 */
+	spin_lock(&udev->state_lock);
 	udev->state = UIST_NEW_DEVICE;
+	spin_unlock(&udev->state_lock);
 
 	if (dev) {
 		name = dev->name;
@@ -366,7 +377,9 @@ static int uinput_create_device(struct uinput_device *udev)
 	if (error)
 		goto fail2;
 
+	spin_lock(&udev->state_lock);
 	udev->state = UIST_CREATED;
+	spin_unlock(&udev->state_lock);
 
 	return 0;
 
@@ -384,6 +397,7 @@ static int uinput_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 
 	mutex_init(&newdev->mutex);
+	spin_lock_init(&newdev->state_lock);
 	spin_lock_init(&newdev->requests_lock);
 	init_waitqueue_head(&newdev->requests_waitq);
 	init_waitqueue_head(&newdev->waitq);
-- 
2.53.0


