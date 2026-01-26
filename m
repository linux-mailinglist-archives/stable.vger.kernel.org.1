Return-Path: <stable+bounces-211673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I9HE2+yd2l2kQEAu9opvQ
	(envelope-from <stable+bounces-211673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 19:29:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 864C88C16A
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 19:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B16302E7A0
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4633081D2;
	Mon, 26 Jan 2026 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np2b2MXG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FF64F881
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769452138; cv=none; b=BPv2hZiySu20I0fIsy6LBhdhpoS8IRBeUgd64cJ8POwtZffEUvof+1w1X9wGtatcIKMgw+O0qWRYpqc76IDFw+h+EGYh5CAqe/cRpBEutyEAubLC0jFbga+gOuVXcyh7UHAqGxaftH3RSLNY1uNnTeNJG4u8nFufmUVr0jf8MrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769452138; c=relaxed/simple;
	bh=Jk0p4aez1WR0s9YEyI9gowi8TGaZEBd/6DGOanx6b1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8G+P5gPyi5/NKh+CjEyMxVfGeGVNcHRBgAhOGTzbNchv6eT1VY1FuQphmQ1IxwRZVBL+6SmXoHVHvobe18dv6YtM5tcgCivrI5mxN+6zdoM+LhsGmr/tIVR94a7VsM89tGnertxx1u+/0TzjGs48aRF5Gi2Nlvk553PlFQnTsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np2b2MXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7B3C19421;
	Mon, 26 Jan 2026 18:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769452138;
	bh=Jk0p4aez1WR0s9YEyI9gowi8TGaZEBd/6DGOanx6b1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Np2b2MXG5lJZodA50Fh2b+KiRZZUeSbyDujK24P90E9FZ5y5BVI4PVQYZrQ42X0cS
	 cLJI5w1Y5oXxDgJD28KPe0Yy1bK0NYspLf4EsWe+6GSMKbXSWNC6hzT/G00OQHQ/l6
	 lJC8s6r0nAwHxebtnGjO6iG9KwHJ6kjN4Thf1m9otdmzmQffbqJcIWY4B0wOjm6wHR
	 EpSpS7WsE3PQsW1/hVZg+z09QCCeJe70uaX25nph4YMTNiDwgeC9w859TgYl3P16XH
	 syF3xPAMmeTdqLkAwNUeK92jdKArVxiD9pDPCBzsEAdQg3xVgaUt2eGcN4LCK21sXN
	 VDRa4GZtoOnoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rasmus Villemoes <ravi@prevas.dk>,
	Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] iio: core: add separate lockdep class for info_exist_lock
Date: Mon, 26 Jan 2026 13:28:55 -0500
Message-ID: <20260126182855.3622441-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126182855.3622441-1-sashal@kernel.org>
References: <2026012656-eggbeater-hungrily-6fb3@gregkh>
 <20260126182855.3622441-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211673-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,axentia.se:email]
X-Rspamd-Queue-Id: 864C88C16A
X-Rspamd-Action: no action

From: Rasmus Villemoes <ravi@prevas.dk>

[ Upstream commit 9910159f06590c17df4fbddedaabb4c0201cc4cb ]

When one iio device is a consumer of another, it is possible that
the ->info_exist_lock of both ends up being taken when reading the
value of the consumer device.

Since they currently belong to the same lockdep class (being
initialized in a single location with mutex_init()), that results in a
lockdep warning

         CPU0
         ----
    lock(&iio_dev_opaque->info_exist_lock);
    lock(&iio_dev_opaque->info_exist_lock);

   *** DEADLOCK ***

   May be due to missing lock nesting notation

  4 locks held by sensors/414:
   #0: c31fd6dc (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0x44/0x4e4
   #1: c4f5a1c4 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x1c/0xac
   #2: c2827548 (kn->active#34){.+.+}-{0:0}, at: kernfs_seq_start+0x30/0xac
   #3: c1dd2b68 (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_read_channel_processed_scale+0x24/0xd8

  stack backtrace:
  CPU: 0 UID: 0 PID: 414 Comm: sensors Not tainted 6.17.11 #5 NONE
  Hardware name: Generic AM33XX (Flattened Device Tree)
  Call trace:
   unwind_backtrace from show_stack+0x10/0x14
   show_stack from dump_stack_lvl+0x44/0x60
   dump_stack_lvl from print_deadlock_bug+0x2b8/0x334
   print_deadlock_bug from __lock_acquire+0x13a4/0x2ab0
   __lock_acquire from lock_acquire+0xd0/0x2c0
   lock_acquire from __mutex_lock+0xa0/0xe8c
   __mutex_lock from mutex_lock_nested+0x1c/0x24
   mutex_lock_nested from iio_read_channel_raw+0x20/0x6c
   iio_read_channel_raw from rescale_read_raw+0x128/0x1c4
   rescale_read_raw from iio_channel_read+0xe4/0xf4
   iio_channel_read from iio_read_channel_processed_scale+0x6c/0xd8
   iio_read_channel_processed_scale from iio_hwmon_read_val+0x68/0xbc
   iio_hwmon_read_val from dev_attr_show+0x18/0x48
   dev_attr_show from sysfs_kf_seq_show+0x80/0x110
   sysfs_kf_seq_show from seq_read_iter+0xdc/0x4e4
   seq_read_iter from vfs_read+0x238/0x2e4
   vfs_read from ksys_read+0x6c/0xec
   ksys_read from ret_fast_syscall+0x0/0x1c

Just as the mlock_key already has its own lockdep class, add a
lock_class_key for the info_exist mutex.

Note that this has in theory been a problem since before IIO first
left staging, but it only occurs when a chain of consumers is in use
and that is not often done.

Fixes: ac917a81117c ("staging:iio:core set the iio_dev.info pointer to null on unregister under lock.")
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
Reviewed-by: Peter Rosin <peda@axentia.se>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/industrialio-core.c | 3 ++-
 include/linux/iio/iio-opaque.h  | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 00a82f1688375..f3e0788f51ca5 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1621,6 +1621,7 @@ static void iio_dev_release(struct device *device)
 	mutex_destroy(&iio_dev_opaque->info_exist_lock);
 	mutex_destroy(&iio_dev_opaque->mlock);
 
+	lockdep_unregister_key(&iio_dev_opaque->info_exist_key);
 	lockdep_unregister_key(&iio_dev_opaque->mlock_key);
 
 	ida_free(&iio_ida, iio_dev_opaque->id);
@@ -1687,7 +1688,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
 
 	lockdep_register_key(&iio_dev_opaque->mlock_key);
-	lockdep_set_class(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_key);
+	lockdep_register_key(&iio_dev_opaque->info_exist_key);
 
 	mutex_init(&iio_dev_opaque->mlock);
 	mutex_init(&iio_dev_opaque->info_exist_lock);
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 5aec3945555bf..0e184cd5d6acc 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -14,6 +14,7 @@
  * @mlock:			lock used to prevent simultaneous device state changes
  * @mlock_key:			lockdep class for iio_dev lock
  * @info_exist_lock:		lock to prevent use during removal
+ * @info_exist_key:		lockdep class for info_exist lock
  * @trig_readonly:		mark the current trigger immutable
  * @event_interface:		event chrdevs associated with interrupt lines
  * @attached_buffers:		array of buffers statically attached by the driver
@@ -47,6 +48,7 @@ struct iio_dev_opaque {
 	struct mutex			mlock;
 	struct lock_class_key		mlock_key;
 	struct mutex			info_exist_lock;
+	struct lock_class_key		info_exist_key;
 	bool				trig_readonly;
 	struct iio_event_interface	*event_interface;
 	struct iio_buffer		**attached_buffers;
-- 
2.51.0


