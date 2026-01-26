Return-Path: <stable+bounces-211581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Fh4CVNpd2nCfQEAu9opvQ
	(envelope-from <stable+bounces-211581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:17:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F9F88B39
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76917303EABE
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189573321B3;
	Mon, 26 Jan 2026 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h72RwgZ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14E418DB2A
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433357; cv=none; b=FxEMY3ZFjH8axXA8yHlwfpBpq1D1hqVL1bju+YwE39h7C9LIFyiHuKwV+nRtn+4xNqpuDtxlF3VUpbxBK3F7o/NpffsdriS27ff2XJCFXYJVXhjeHePEFYrqq5C8PhRAWoLIRE/l7+QcD0GyksmbX6oaDDLLhPabBwNiS5dehIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433357; c=relaxed/simple;
	bh=Vk5eV1lKH8UE80MZNzFafv18LAHSN6N0B6yYrNsND4U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h3pYWJB6i+PW5KypluiwEpWS+Lu0wEV9kkoXGUOaVl4W0eO27o+pK8AOAK1z9ytrQt2un1OyFQ1kKdhqVML3+cZR4LB7bA3m/C1PwRUc+nlYwxdeeRd3MNgJ/c3h3ZEMIX51As0lptMGpij6qzrDJKlpk28lY1Av2thIrxSNR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h72RwgZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D13C19425;
	Mon, 26 Jan 2026 13:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769433357;
	bh=Vk5eV1lKH8UE80MZNzFafv18LAHSN6N0B6yYrNsND4U=;
	h=Subject:To:Cc:From:Date:From;
	b=h72RwgZ1yKdhhJGMVO0QrO1SzJONnjj0Z7fZ+BMbYbUHFWBn+fRtOl+6ljY0kKAF9
	 ep4l7M7LXyRrDttolJjuOPDkuMBdxpBvzZl34HvEXDWru+KuGtc+NeHqiw72OINPDu
	 0TKCRH5Uq1KH5UyDIq5oRhzEssX9uqL+KWMGLBTo=
Subject: FAILED: patch "[PATCH] iio: core: add separate lockdep class for info_exist_lock" failed to apply to 6.18-stable tree
To: ravi@prevas.dk,Jonathan.Cameron@huawei.com,peda@axentia.se,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Jan 2026 14:15:54 +0100
Message-ID: <2026012654-trend-outback-5af6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211581-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,prevas.dk:email,iio_dev.info:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 86F9F88B39
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9910159f06590c17df4fbddedaabb4c0201cc4cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012654-trend-outback-5af6@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9910159f06590c17df4fbddedaabb4c0201cc4cb Mon Sep 17 00:00:00 2001
From: Rasmus Villemoes <ravi@prevas.dk>
Date: Mon, 15 Dec 2025 14:17:23 +0100
Subject: [PATCH] iio: core: add separate lockdep class for info_exist_lock

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

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f69deefcfb6f..117ffad4f376 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1657,6 +1657,7 @@ static void iio_dev_release(struct device *device)
 	mutex_destroy(&iio_dev_opaque->info_exist_lock);
 	mutex_destroy(&iio_dev_opaque->mlock);
 
+	lockdep_unregister_key(&iio_dev_opaque->info_exist_key);
 	lockdep_unregister_key(&iio_dev_opaque->mlock_key);
 
 	ida_free(&iio_ida, iio_dev_opaque->id);
@@ -1717,9 +1718,10 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
 
 	lockdep_register_key(&iio_dev_opaque->mlock_key);
+	lockdep_register_key(&iio_dev_opaque->info_exist_key);
 
 	mutex_init_with_key(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_key);
-	mutex_init(&iio_dev_opaque->info_exist_lock);
+	mutex_init_with_key(&iio_dev_opaque->info_exist_lock, &iio_dev_opaque->info_exist_key);
 
 	indio_dev->dev.parent = parent;
 	indio_dev->dev.type = &iio_device_type;
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 4247497f3f8b..b87841a355f8 100644
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


