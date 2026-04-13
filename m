Return-Path: <stable+bounces-236469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNb1JD4a3WknaAkAu9opvQ
	(envelope-from <stable+bounces-236469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:30:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E1D3EF207
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A11430E24CB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B901D3016EE;
	Mon, 13 Apr 2026 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ZiD0B2E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0842EBB8C;
	Mon, 13 Apr 2026 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096985; cv=none; b=ho9E1V6rtOKVOX9XgXYVmS98rU0quu+taoCstH2mS7pzh/PgutFPEDIiXBUIR+fVqlV/zKa++nU7wqA2qzTY4WVc2qVIeEyvXr6t5QOiW5ub/anvN8IaOPBI4jBtdGFkTxoW1jiC/1ALxVzMEc+dAbCqoH+rAUFzyf5KetSIJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096985; c=relaxed/simple;
	bh=BHHdONAJRa4ftbg1+Yqlfg8dqYjDy6J3A4P9BQ+7D+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAxPpbwQxQzwa7AwB3aUeshJVaQMzIxxK6mo5qI0BchlaF7F+Z8Rx7MENc2MnCFf67/7a6wama7XUqeH9j6NDutsSVVjEeJv8si/36BZTRj1SWTzIaIPfqtWuZWt8DHETpg6vTKkxWjOpZqrnMrcU+8PVsTIL798l9o2v0wykLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2ZiD0B2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DCFC2BCB8;
	Mon, 13 Apr 2026 16:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096985;
	bh=BHHdONAJRa4ftbg1+Yqlfg8dqYjDy6J3A4P9BQ+7D+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2ZiD0B2E/jxdkOQbOgpeKtydW88JDBpgr9gzePU7/lpuySWx2RzJoD0+EAGmckM2o
	 M7N3uOQ1vXfnJzROVKomE2iGnoQQoZqabNjUE+Tx6QxACYOvhtvAMJDFehGLe3y6p7
	 syzgUjsQpIGM20UzZ+UXhUOrkWlId52uxLCkxMMQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.1 05/55] Input: uinput - fix circular locking dependency with ff-core
Date: Mon, 13 Apr 2026 18:00:39 +0200
Message-ID: <20260413155725.027691280@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.820472494@linuxfoundation.org>
References: <20260413155724.820472494@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-236469-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 48E1D3EF207
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

commit 4cda78d6f8bf2b700529f2fbccb994c3e826d7c2 upstream.

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
Link: https://patch.msgid.link/20260407075031.38351-1-mikhail.v.gavrilov@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/uinput.c |   28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -56,6 +56,7 @@ struct uinput_device {
 	struct input_dev	*dev;
 	struct mutex		mutex;
 	enum uinput_state	state;
+	spinlock_t		state_lock;
 	wait_queue_head_t	waitq;
 	unsigned char		ready;
 	unsigned char		head;
@@ -145,19 +146,15 @@ static void uinput_request_release_slot(
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
@@ -165,7 +162,7 @@ static int uinput_request_send(struct ui
 	uinput_dev_event(udev->dev, EV_UINPUT, request->code, request->id);
 
  out:
-	mutex_unlock(&udev->mutex);
+	spin_unlock(&udev->state_lock);
 	return retval;
 }
 
@@ -174,6 +171,13 @@ static int uinput_request_submit(struct
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
@@ -288,7 +292,14 @@ static void uinput_destroy_device(struct
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
@@ -365,7 +376,9 @@ static int uinput_create_device(struct u
 	if (error)
 		goto fail2;
 
+	spin_lock(&udev->state_lock);
 	udev->state = UIST_CREATED;
+	spin_unlock(&udev->state_lock);
 
 	return 0;
 
@@ -383,6 +396,7 @@ static int uinput_open(struct inode *ino
 		return -ENOMEM;
 
 	mutex_init(&newdev->mutex);
+	spin_lock_init(&newdev->state_lock);
 	spin_lock_init(&newdev->requests_lock);
 	init_waitqueue_head(&newdev->requests_waitq);
 	init_waitqueue_head(&newdev->waitq);



