Return-Path: <stable+bounces-4051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 276CA8045CD
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87095B20B5F
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C886FB1;
	Tue,  5 Dec 2023 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xJqiVbRo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A26AA0;
	Tue,  5 Dec 2023 03:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212D5C433C8;
	Tue,  5 Dec 2023 03:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746494;
	bh=sYBqSVYgZAwTS9Pydo92qxDC7neZ02LXbWcnIgVaxe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xJqiVbRoaElAluZvxctxGqlF2BicudusI8nyWjWPGKwTeExsPYcepaIraNmtijBAp
	 YJdnrsaBWa6ZaNrd1gwQOme2k8XnRLQpOWd21LxbKYe+JYXR+PZ5XuOaVfbrZpUNRX
	 eB/dk4Rgs3qy5ayguj5HUgEkcreXgnjjbqkD569k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 044/134] io_uring: free io_buffer_list entries via RCU
Date: Tue,  5 Dec 2023 12:15:16 +0900
Message-ID: <20231205031538.347386160@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 5cf4f52e6d8aa2d3b7728f568abbf9d42a3af252 upstream.

mmap_lock nests under uring_lock out of necessity, as we may be doing
user copies with uring_lock held. However, for mmap of provided buffer
rings, we attempt to grab uring_lock with mmap_lock already held from
do_mmap(). This makes lockdep, rightfully, complain:

WARNING: possible circular locking dependency detected
6.7.0-rc1-00009-gff3337ebaf94-dirty #4438 Not tainted
------------------------------------------------------
buf-ring.t/442 is trying to acquire lock:
ffff00020e1480a8 (&ctx->uring_lock){+.+.}-{3:3}, at: io_uring_validate_mmap_request.isra.0+0x4c/0x140

but task is already holding lock:
ffff0000dc226190 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x124/0x264

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       __might_fault+0x90/0xbc
       io_register_pbuf_ring+0x94/0x488
       __arm64_sys_io_uring_register+0x8dc/0x1318
       invoke_syscall+0x5c/0x17c
       el0_svc_common.constprop.0+0x108/0x130
       do_el0_svc+0x2c/0x38
       el0_svc+0x4c/0x94
       el0t_64_sync_handler+0x118/0x124
       el0t_64_sync+0x168/0x16c

-> #0 (&ctx->uring_lock){+.+.}-{3:3}:
       __lock_acquire+0x19a0/0x2d14
       lock_acquire+0x2e0/0x44c
       __mutex_lock+0x118/0x564
       mutex_lock_nested+0x20/0x28
       io_uring_validate_mmap_request.isra.0+0x4c/0x140
       io_uring_mmu_get_unmapped_area+0x3c/0x98
       get_unmapped_area+0xa4/0x158
       do_mmap+0xec/0x5b4
       vm_mmap_pgoff+0x158/0x264
       ksys_mmap_pgoff+0x1d4/0x254
       __arm64_sys_mmap+0x80/0x9c
       invoke_syscall+0x5c/0x17c
       el0_svc_common.constprop.0+0x108/0x130
       do_el0_svc+0x2c/0x38
       el0_svc+0x4c/0x94
       el0t_64_sync_handler+0x118/0x124
       el0t_64_sync+0x168/0x16c

>From that mmap(2) path, we really just need to ensure that the buffer
list doesn't go away from underneath us. For the lower indexed entries,
they never go away until the ring is freed and we can always sanely
reference those as long as the caller has a file reference. For the
higher indexed ones in our xarray, we just need to ensure that the
buffer list remains valid while we return the address of it.

Free the higher indexed io_buffer_list entries via RCU. With that we can
avoid needing ->uring_lock inside mmap(2), and simply hold the RCU read
lock around the buffer list lookup and address check.

To ensure that the arrayed lookup either returns a valid fully formulated
entry via RCU lookup, add an 'is_ready' flag that we access with store
and release memory ordering. This isn't needed for the xarray lookups,
but doesn't hurt either. Since this isn't a fast path, retain it across
both types. Similarly, for the allocated array inside the ctx, ensure
we use the proper load/acquire as setup could in theory be running in
parallel with mmap.

While in there, add a few lockdep checks for documentation purposes.

Cc: stable@vger.kernel.org
Fixes: c56e022c0a27 ("io_uring: add support for user mapped provided buffer ring")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    4 +--
 io_uring/kbuf.c     |   64 +++++++++++++++++++++++++++++++++++++++++-----------
 io_uring/kbuf.h     |    3 ++
 3 files changed, 56 insertions(+), 15 deletions(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3452,9 +3452,9 @@ static void *io_uring_validate_mmap_requ
 		unsigned int bgid;
 
 		bgid = (offset & ~IORING_OFF_MMAP_MASK) >> IORING_OFF_PBUF_SHIFT;
-		mutex_lock(&ctx->uring_lock);
+		rcu_read_lock();
 		ptr = io_pbuf_get_address(ctx, bgid);
-		mutex_unlock(&ctx->uring_lock);
+		rcu_read_unlock();
 		if (!ptr)
 			return ERR_PTR(-EINVAL);
 		break;
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -31,19 +31,35 @@ struct io_provide_buf {
 	__u16				bid;
 };
 
+static struct io_buffer_list *__io_buffer_get_list(struct io_ring_ctx *ctx,
+						   struct io_buffer_list *bl,
+						   unsigned int bgid)
+{
+	if (bl && bgid < BGID_ARRAY)
+		return &bl[bgid];
+
+	return xa_load(&ctx->io_bl_xa, bgid);
+}
+
 static inline struct io_buffer_list *io_buffer_get_list(struct io_ring_ctx *ctx,
 							unsigned int bgid)
 {
-	if (ctx->io_bl && bgid < BGID_ARRAY)
-		return &ctx->io_bl[bgid];
+	lockdep_assert_held(&ctx->uring_lock);
 
-	return xa_load(&ctx->io_bl_xa, bgid);
+	return __io_buffer_get_list(ctx, ctx->io_bl, bgid);
 }
 
 static int io_buffer_add_list(struct io_ring_ctx *ctx,
 			      struct io_buffer_list *bl, unsigned int bgid)
 {
+	/*
+	 * Store buffer group ID and finally mark the list as visible.
+	 * The normal lookup doesn't care about the visibility as we're
+	 * always under the ->uring_lock, but the RCU lookup from mmap does.
+	 */
 	bl->bgid = bgid;
+	smp_store_release(&bl->is_ready, 1);
+
 	if (bgid < BGID_ARRAY)
 		return 0;
 
@@ -194,18 +210,19 @@ void __user *io_buffer_select(struct io_
 
 static __cold int io_init_bl_list(struct io_ring_ctx *ctx)
 {
+	struct io_buffer_list *bl;
 	int i;
 
-	ctx->io_bl = kcalloc(BGID_ARRAY, sizeof(struct io_buffer_list),
-				GFP_KERNEL);
-	if (!ctx->io_bl)
+	bl = kcalloc(BGID_ARRAY, sizeof(struct io_buffer_list), GFP_KERNEL);
+	if (!bl)
 		return -ENOMEM;
 
 	for (i = 0; i < BGID_ARRAY; i++) {
-		INIT_LIST_HEAD(&ctx->io_bl[i].buf_list);
-		ctx->io_bl[i].bgid = i;
+		INIT_LIST_HEAD(&bl[i].buf_list);
+		bl[i].bgid = i;
 	}
 
+	smp_store_release(&ctx->io_bl, bl);
 	return 0;
 }
 
@@ -270,7 +287,7 @@ void io_destroy_buffers(struct io_ring_c
 	xa_for_each(&ctx->io_bl_xa, index, bl) {
 		xa_erase(&ctx->io_bl_xa, bl->bgid);
 		__io_remove_buffers(ctx, bl, -1U);
-		kfree(bl);
+		kfree_rcu(bl, rcu);
 	}
 
 	while (!list_empty(&ctx->io_buffers_pages)) {
@@ -455,7 +472,16 @@ int io_provide_buffers(struct io_kiocb *
 		INIT_LIST_HEAD(&bl->buf_list);
 		ret = io_buffer_add_list(ctx, bl, p->bgid);
 		if (ret) {
-			kfree(bl);
+			/*
+			 * Doesn't need rcu free as it was never visible, but
+			 * let's keep it consistent throughout. Also can't
+			 * be a lower indexed array group, as adding one
+			 * where lookup failed cannot happen.
+			 */
+			if (p->bgid >= BGID_ARRAY)
+				kfree_rcu(bl, rcu);
+			else
+				WARN_ON_ONCE(1);
 			goto err;
 		}
 	}
@@ -550,6 +576,8 @@ int io_register_pbuf_ring(struct io_ring
 	struct io_buffer_list *bl, *free_bl = NULL;
 	int ret;
 
+	lockdep_assert_held(&ctx->uring_lock);
+
 	if (copy_from_user(&reg, arg, sizeof(reg)))
 		return -EFAULT;
 
@@ -604,7 +632,7 @@ int io_register_pbuf_ring(struct io_ring
 		return 0;
 	}
 
-	kfree(free_bl);
+	kfree_rcu(free_bl, rcu);
 	return ret;
 }
 
@@ -613,6 +641,8 @@ int io_unregister_pbuf_ring(struct io_ri
 	struct io_uring_buf_reg reg;
 	struct io_buffer_list *bl;
 
+	lockdep_assert_held(&ctx->uring_lock);
+
 	if (copy_from_user(&reg, arg, sizeof(reg)))
 		return -EFAULT;
 	if (reg.resv[0] || reg.resv[1] || reg.resv[2])
@@ -629,7 +659,7 @@ int io_unregister_pbuf_ring(struct io_ri
 	__io_remove_buffers(ctx, bl, -1U);
 	if (bl->bgid >= BGID_ARRAY) {
 		xa_erase(&ctx->io_bl_xa, bl->bgid);
-		kfree(bl);
+		kfree_rcu(bl, rcu);
 	}
 	return 0;
 }
@@ -638,7 +668,15 @@ void *io_pbuf_get_address(struct io_ring
 {
 	struct io_buffer_list *bl;
 
-	bl = io_buffer_get_list(ctx, bgid);
+	bl = __io_buffer_get_list(ctx, smp_load_acquire(&ctx->io_bl), bgid);
+
+	/*
+	 * Ensure the list is fully setup. Only strictly needed for RCU lookup
+	 * via mmap, and in that case only for the array indexed groups. For
+	 * the xarray lookups, it's either visible and ready, or not at all.
+	 */
+	if (!smp_load_acquire(&bl->is_ready))
+		return NULL;
 	if (!bl || !bl->is_mmap)
 		return NULL;
 
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -15,6 +15,7 @@ struct io_buffer_list {
 			struct page **buf_pages;
 			struct io_uring_buf_ring *buf_ring;
 		};
+		struct rcu_head rcu;
 	};
 	__u16 bgid;
 
@@ -28,6 +29,8 @@ struct io_buffer_list {
 	__u8 is_mapped;
 	/* ring mapped provided buffers, but mmap'ed by application */
 	__u8 is_mmap;
+	/* bl is visible from an RCU point of view for lookup */
+	__u8 is_ready;
 };
 
 struct io_buffer {



