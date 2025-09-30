Return-Path: <stable+bounces-182419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EB1BAD89F
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D6D16A517
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E300302CD6;
	Tue, 30 Sep 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H8FF3HOU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8FE266B65;
	Tue, 30 Sep 2025 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244885; cv=none; b=Tj5v27L4Olv7f+xkVoCeBQ6ucg3OSOb/XiLPUAIxGG75BgH4SzsV9TsLtYT5H42kFtgr6cofQECyc1VUilJJWjP7n0Jn7OxxiOrElYFYoDxRqvl389ILKaVc0jif+tgRze0MG/ldm9VPGZgTbrSKsF8aVTmRdo3JnHBJtCNcsEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244885; c=relaxed/simple;
	bh=n/42wk4fzeoTzMKflk9d3+SlJkG5wPc5eQ2i8DboK3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnG/wmk0SGeAx4BGzO/1s0UJMYHSGY9C/GWo6ADXbIs1Nn82OKx7ANDiYCk8Go1r9QhHifyfvUqc6qnzQsurZ9laKwY58abBSgMdLXQoJCdyYL4dQiO7OKj0LlJ5lYlwE60J8LCpwWoQgY0Up3brim8IAIK0W4ZVA94SxAn1me8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H8FF3HOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F65C4CEF0;
	Tue, 30 Sep 2025 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244885;
	bh=n/42wk4fzeoTzMKflk9d3+SlJkG5wPc5eQ2i8DboK3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8FF3HOUVVcRAVBOsy4p+eHQerUVYyVz0jExE5nGHDxUfCAOYeBZpf9kgnUlDCglz
	 MP2CoK94GP7zS47Y8qB+EWBCpbNbqxPrPW99qydtFJwi1nOq3bblFxTC7PLY8oXevd
	 ublJ6FBV1X7J+TBazlSRwyn1P7kYS2hA2znjP29Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>,
	Nirmoy Das <nirmoyd@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 143/143] iommufd: Fix race during abort for file descriptors
Date: Tue, 30 Sep 2025 16:47:47 +0200
Message-ID: <20250930143836.941765889@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
References: <20250930143831.236060637@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 4e034bf045b12852a24d5d33f2451850818ba0c1 ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/iommufd/eventq.c |    9 ++-------
 drivers/iommu/iommufd/main.c   |   35 ++++++++++++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 10 deletions(-)

--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -393,12 +393,12 @@ static int iommufd_eventq_init(struct io
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
@@ -408,10 +408,7 @@ static int iommufd_eventq_init(struct io
 	eventq->filep = filep;
 	refcount_inc(&eventq->obj.users);
 
-	fdno = get_unused_fd_flags(O_CLOEXEC);
-	if (fdno < 0)
-		fput(filep);
-	return fdno;
+	return get_unused_fd_flags(O_CLOEXEC);
 }
 
 static const struct file_operations iommufd_fault_fops =
@@ -455,7 +452,6 @@ int iommufd_fault_alloc(struct iommufd_u
 	return 0;
 out_put_fdno:
 	put_unused_fd(fdno);
-	fput(fault->common.filep);
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->common.obj);
 
@@ -542,7 +538,6 @@ int iommufd_veventq_alloc(struct iommufd
 
 out_put_fdno:
 	put_unused_fd(fdno);
-	fput(veventq->common.filep);
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &veventq->common.obj);
 out_unlock_veventqs:
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -23,6 +23,7 @@
 #include "iommufd_test.h"
 
 struct iommufd_object_ops {
+	size_t file_offset;
 	void (*destroy)(struct iommufd_object *obj);
 	void (*abort)(struct iommufd_object *obj);
 };
@@ -71,10 +72,30 @@ void iommufd_object_abort(struct iommufd
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
 
@@ -493,6 +514,12 @@ void iommufd_ctx_put(struct iommufd_ctx
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
@@ -502,6 +529,7 @@ static const struct iommufd_object_ops i
 	},
 	[IOMMUFD_OBJ_FAULT] = {
 		.destroy = iommufd_fault_destroy,
+		IOMMUFD_FILE_OFFSET(struct iommufd_fault, common.filep, common.obj),
 	},
 	[IOMMUFD_OBJ_HWPT_PAGING] = {
 		.destroy = iommufd_hwpt_paging_destroy,
@@ -520,6 +548,7 @@ static const struct iommufd_object_ops i
 	[IOMMUFD_OBJ_VEVENTQ] = {
 		.destroy = iommufd_veventq_destroy,
 		.abort = iommufd_veventq_abort,
+		IOMMUFD_FILE_OFFSET(struct iommufd_veventq, common.filep, common.obj),
 	},
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,



