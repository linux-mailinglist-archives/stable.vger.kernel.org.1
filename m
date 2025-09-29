Return-Path: <stable+bounces-181890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9CABA9129
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893DC3C3396
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 11:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E349301482;
	Mon, 29 Sep 2025 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CBDfufik"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D681301463
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145974; cv=none; b=CSRAWavHMzEVE3FkaVMaFi+6RPgwL+AEsUt+q/4c5ghiD3zxSwim1LJZfCR7AqndGX21LFgdIrMnZPXHE9zGE5ZWa5PgvzEVS4Y1UoRRJBLfTQeYbXzI598BTphESs01FI79T6SKwlWWls3IusTAskYCTX9rK45Gybbx5eflZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145974; c=relaxed/simple;
	bh=ZDuXO5QmukrBCgbnKpUhno1u4G+d54/GIlE9sbgHbbo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PjOTxufwtgxeWwHzsEm3L5Eeb79NUTb0P8FRurgxAIU2B7m1Di+4BFV363sPirX30PTM0ct2KwgTZe02FL2zxN8Vik+NRWJbSRzrY3+bLZ7vuSixnSbE1bbc7wsxQY+zdiCIVpSW+TS7eV/XIEw8ZPDYu3NF9GNeYxqmW39GJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CBDfufik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5D5C4CEF4;
	Mon, 29 Sep 2025 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759145974;
	bh=ZDuXO5QmukrBCgbnKpUhno1u4G+d54/GIlE9sbgHbbo=;
	h=Subject:To:Cc:From:Date:From;
	b=CBDfufik+Sw9K9lFkTl+16M9tz+BgL8BiiYqTiEVhrMBymPK0J3gfmXZlerPS3E7w
	 JvM8kXIVrb9UNMqtQQFu+RElf1+qcczW/COMmQ2UUsqR+dSzVG0OubfqMOBwloNg33
	 8mY8kihmeAaURKHvA46VPKFmpeitBb5Sk93nATGg=
Subject: FAILED: patch "[PATCH] iommufd: Fix race during abort for file descriptors" failed to apply to 6.16-stable tree
To: jgg@ziepe.ca,jgg@nvidia.com,kevin.tian@intel.com,nicolinc@nvidia.com,nirmoyd@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Sep 2025 13:39:31 +0200
Message-ID: <2025092931-uneven-never-0b1f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 4e034bf045b12852a24d5d33f2451850818ba0c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092931-uneven-never-0b1f@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e034bf045b12852a24d5d33f2451850818ba0c1 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Tue, 16 Sep 2025 20:47:10 -0300
Subject: [PATCH] iommufd: Fix race during abort for file descriptors

fput() doesn't actually call file_operations release() synchronously, it
puts the file on a work queue and it will be released eventually.

This is normally fine, except for iommufd the file and the iommufd_object
are tied to gether. The file has the object as it's private_data and holds
a users refcount, while the object is expected to remain alive as long as
the file is.

When the allocation of a new object aborts before installing the file it
will fput() the file and then go on to immediately kfree() the obj. This
causes a UAF once the workqueue completes the fput() and tries to
decrement the users refcount.

Fix this by putting the core code in charge of the file lifetime, and call
__fput_sync() during abort to ensure that release() is called before
kfree. __fput_sync() is a bit too tricky to open code in all the object
implementations. Instead the objects tell the core code where the file
pointer is and the core will take care of the life cycle.

If the object is successfully allocated then the file will hold a users
refcount and the iommufd_object cannot be destroyed.

It is worth noting that close(); ioctl(IOMMU_DESTROY); doesn't have an
issue because close() is already using a synchronous version of fput().

The UAF looks like this:

    BUG: KASAN: slab-use-after-free in iommufd_eventq_fops_release+0x45/0xc0 drivers/iommu/iommufd/eventq.c:376
    Write of size 4 at addr ffff888059c97804 by task syz.0.46/6164

    CPU: 0 UID: 0 PID: 6164 Comm: syz.0.46 Not tainted syzkaller #0 PREEMPT(full)
    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
    Call Trace:
     <TASK>
     __dump_stack lib/dump_stack.c:94 [inline]
     dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
     print_address_description mm/kasan/report.c:378 [inline]
     print_report+0xcd/0x630 mm/kasan/report.c:482
     kasan_report+0xe0/0x110 mm/kasan/report.c:595
     check_region_inline mm/kasan/generic.c:183 [inline]
     kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:189
     instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
     atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
     __refcount_dec include/linux/refcount.h:455 [inline]
     refcount_dec include/linux/refcount.h:476 [inline]
     iommufd_eventq_fops_release+0x45/0xc0 drivers/iommu/iommufd/eventq.c:376
     __fput+0x402/0xb70 fs/file_table.c:468
     task_work_run+0x14d/0x240 kernel/task_work.c:227
     resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
     exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:43
     exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
     syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
     syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
     do_syscall_64+0x41c/0x4c0 arch/x86/entry/syscall_64.c:100
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

Link: https://patch.msgid.link/r/1-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com
Cc: stable@vger.kernel.org
Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Nirmoy Das <nirmoyd@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reported-by: syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/68c8583d.050a0220.2ff435.03a2.GAE@google.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index fc4de63b0bce..e23d9ee4fe38 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -393,12 +393,12 @@ static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
 			       const struct file_operations *fops)
 {
 	struct file *filep;
-	int fdno;
 
 	spin_lock_init(&eventq->lock);
 	INIT_LIST_HEAD(&eventq->deliver);
 	init_waitqueue_head(&eventq->wait_queue);
 
+	/* The filep is fput() by the core code during failure */
 	filep = anon_inode_getfile(name, fops, eventq, O_RDWR);
 	if (IS_ERR(filep))
 		return PTR_ERR(filep);
@@ -408,10 +408,7 @@ static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
 	eventq->filep = filep;
 	refcount_inc(&eventq->obj.users);
 
-	fdno = get_unused_fd_flags(O_CLOEXEC);
-	if (fdno < 0)
-		fput(filep);
-	return fdno;
+	return get_unused_fd_flags(O_CLOEXEC);
 }
 
 static const struct file_operations iommufd_fault_fops =
@@ -452,7 +449,6 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	return 0;
 out_put_fdno:
 	put_unused_fd(fdno);
-	fput(fault->common.filep);
 	return rc;
 }
 
@@ -536,7 +532,6 @@ int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 
 out_put_fdno:
 	put_unused_fd(fdno);
-	fput(veventq->common.filep);
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &veventq->common.obj);
 out_unlock_veventqs:
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index a9d4decc8ba1..88be2e157245 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -23,6 +23,7 @@
 #include "iommufd_test.h"
 
 struct iommufd_object_ops {
+	size_t file_offset;
 	void (*pre_destroy)(struct iommufd_object *obj);
 	void (*destroy)(struct iommufd_object *obj);
 	void (*abort)(struct iommufd_object *obj);
@@ -131,10 +132,30 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
 void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 				      struct iommufd_object *obj)
 {
-	if (iommufd_object_ops[obj->type].abort)
-		iommufd_object_ops[obj->type].abort(obj);
+	const struct iommufd_object_ops *ops = &iommufd_object_ops[obj->type];
+
+	if (ops->file_offset) {
+		struct file **filep = ((void *)obj) + ops->file_offset;
+
+		/*
+		 * A file should hold a users refcount while the file is open
+		 * and put it back in its release. The file should hold a
+		 * pointer to obj in their private data. Normal fput() is
+		 * deferred to a workqueue and can get out of order with the
+		 * following kfree(obj). Using the sync version ensures the
+		 * release happens immediately. During abort we require the file
+		 * refcount is one at this point - meaning the object alloc
+		 * function cannot do anything to allow another thread to take a
+		 * refcount prior to a guaranteed success.
+		 */
+		if (*filep)
+			__fput_sync(*filep);
+	}
+
+	if (ops->abort)
+		ops->abort(obj);
 	else
-		iommufd_object_ops[obj->type].destroy(obj);
+		ops->destroy(obj);
 	iommufd_object_abort(ictx, obj);
 }
 
@@ -659,6 +680,12 @@ void iommufd_ctx_put(struct iommufd_ctx *ictx)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, "IOMMUFD");
 
+#define IOMMUFD_FILE_OFFSET(_struct, _filep, _obj)                           \
+	.file_offset = (offsetof(_struct, _filep) +                          \
+			BUILD_BUG_ON_ZERO(!__same_type(                      \
+				struct file *, ((_struct *)NULL)->_filep)) + \
+			BUILD_BUG_ON_ZERO(offsetof(_struct, _obj)))
+
 static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_ACCESS] = {
 		.destroy = iommufd_access_destroy_object,
@@ -669,6 +696,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	},
 	[IOMMUFD_OBJ_FAULT] = {
 		.destroy = iommufd_fault_destroy,
+		IOMMUFD_FILE_OFFSET(struct iommufd_fault, common.filep, common.obj),
 	},
 	[IOMMUFD_OBJ_HW_QUEUE] = {
 		.destroy = iommufd_hw_queue_destroy,
@@ -691,6 +719,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_VEVENTQ] = {
 		.destroy = iommufd_veventq_destroy,
 		.abort = iommufd_veventq_abort,
+		IOMMUFD_FILE_OFFSET(struct iommufd_veventq, common.filep, common.obj),
 	},
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,


