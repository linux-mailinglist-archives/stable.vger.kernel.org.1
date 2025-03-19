Return-Path: <stable+bounces-125494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316AFA69324
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8241B8076B
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926BA221DA3;
	Wed, 19 Mar 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n1gVJhwb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B0209F50;
	Wed, 19 Mar 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395230; cv=none; b=J6NgM0Q/qhyDXwSG9QWc/nqRDEZ+XIjcO5gzhJK2c5c1MU6lFaCPcZKn/UphAFwRremBFxK7h9f+Qz/bzhFF6LLmqD5QMkselKj6b0lNS2/vpFkeweyWlgu8mi4BRc3blNqLUR89IEpz/SlrebSmIMv8G2zpGPRUkVcnRIf6Drk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395230; c=relaxed/simple;
	bh=tDp1fjyav11A1qg6TLkHfkMxOXsEtnVdi9Q8cf9uSHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQ/PwZb1bmHWBYXHneMNVp9lAZPUgLG67pxMrbjt826EXdTG3dIDIXLVR5x2YI9qo+89qo6SHocluFtQCM91IXX0qAykH4/Qg+aItX55jP5V6adfTXIBM1GA2XESF4J5AvP844FsC/fhcZq/ghdhketcP4jZkPhugorggtWXc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n1gVJhwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23215C4CEE8;
	Wed, 19 Mar 2025 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395230;
	bh=tDp1fjyav11A1qg6TLkHfkMxOXsEtnVdi9Q8cf9uSHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1gVJhwbqLTi9ka5/Q/ve2MbogEGLGFkovSV0hIyqLBMDENvBWsWmJjtDmSGvVhjW
	 NMefTBrIRN8wMhGK6r0Tca71XfICGabgccHeCJVZrnRT+DbeKZi+jJVK+MmFcT9UNh
	 WNzcNxuh+ekzzI6gbrNnZTJk/CObt8bNtg+sYCbs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 101/166] io_uring/kbuf: use vm_insert_pages() for mmaped pbuf ring
Date: Wed, 19 Mar 2025 07:31:12 -0700
Message-ID: <20250319143022.752117347@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143019.983527953@linuxfoundation.org>
References: <20250319143019.983527953@linuxfoundation.org>
User-Agent: quilt/0.68
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

Commit 87585b05757dc70545efb434669708d276125559 upstream.

Rather than use remap_pfn_range() for this and manually free later,
switch to using vm_insert_page() and have it Just Work.

This requires a bit of effort on the mmap lookup side, as the ctx
uring_lock isn't held, which  otherwise protects buffer_lists from being
torn down, and it's not safe to grab from mmap context that would
introduce an ABBA deadlock between the mmap lock and the ctx uring_lock.
Instead, lookup the buffer_list under RCU, as the the list is RCU freed
already. Use the existing reference count to determine whether it's
possible to safely grab a reference to it (eg if it's not zero already),
and drop that reference when done with the mapping. If the mmap
reference is the last one, the buffer_list and the associated memory can
go away, since the vma insertion has references to the inserted pages at
that point.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/io_uring_types.h |    3 
 io_uring/io_uring.c            |   58 ++++-------------
 io_uring/io_uring.h            |    6 +
 io_uring/kbuf.c                |  137 ++++++++---------------------------------
 io_uring/kbuf.h                |    3 
 5 files changed, 48 insertions(+), 159 deletions(-)

--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -326,9 +326,6 @@ struct io_ring_ctx {
 
 	struct list_head	io_buffers_cache;
 
-	/* deferred free list, protected by ->uring_lock */
-	struct hlist_head	io_buf_list;
-
 	/* Keep this last, we don't need it for the fast path */
 	struct wait_queue_head		poll_wq;
 	struct io_restriction		restrictions;
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -311,7 +311,6 @@ static __cold struct io_ring_ctx *io_rin
 	INIT_LIST_HEAD(&ctx->sqd_list);
 	INIT_LIST_HEAD(&ctx->cq_overflow_list);
 	INIT_LIST_HEAD(&ctx->io_buffers_cache);
-	INIT_HLIST_HEAD(&ctx->io_buf_list);
 	io_alloc_cache_init(&ctx->rsrc_node_cache, IO_NODE_ALLOC_CACHE_MAX,
 			    sizeof(struct io_rsrc_node));
 	io_alloc_cache_init(&ctx->apoll_cache, IO_ALLOC_CACHE_MAX,
@@ -2682,15 +2681,15 @@ static int io_cqring_wait(struct io_ring
 	return READ_ONCE(rings->cq.head) == READ_ONCE(rings->cq.tail) ? ret : 0;
 }
 
-static void io_pages_unmap(void *ptr, struct page ***pages,
-			   unsigned short *npages)
+void io_pages_unmap(void *ptr, struct page ***pages, unsigned short *npages,
+		    bool put_pages)
 {
 	bool do_vunmap = false;
 
 	if (!ptr)
 		return;
 
-	if (*npages) {
+	if (put_pages && *npages) {
 		struct page **to_free = *pages;
 		int i;
 
@@ -2712,14 +2711,6 @@ static void io_pages_unmap(void *ptr, st
 	*npages = 0;
 }
 
-void io_mem_free(void *ptr)
-{
-	if (!ptr)
-		return;
-
-	folio_put(virt_to_folio(ptr));
-}
-
 static void io_pages_free(struct page ***pages, int npages)
 {
 	struct page **page_array;
@@ -2818,8 +2809,10 @@ static void *io_sqes_map(struct io_ring_
 static void io_rings_free(struct io_ring_ctx *ctx)
 {
 	if (!(ctx->flags & IORING_SETUP_NO_MMAP)) {
-		io_pages_unmap(ctx->rings, &ctx->ring_pages, &ctx->n_ring_pages);
-		io_pages_unmap(ctx->sq_sqes, &ctx->sqe_pages, &ctx->n_sqe_pages);
+		io_pages_unmap(ctx->rings, &ctx->ring_pages, &ctx->n_ring_pages,
+				true);
+		io_pages_unmap(ctx->sq_sqes, &ctx->sqe_pages, &ctx->n_sqe_pages,
+				true);
 	} else {
 		io_pages_free(&ctx->ring_pages, ctx->n_ring_pages);
 		ctx->n_ring_pages = 0;
@@ -2876,8 +2869,8 @@ err:
 	return ERR_PTR(-ENOMEM);
 }
 
-static void *io_pages_map(struct page ***out_pages, unsigned short *npages,
-			  size_t size)
+void *io_pages_map(struct page ***out_pages, unsigned short *npages,
+		   size_t size)
 {
 	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN;
 	struct page **pages;
@@ -2909,17 +2902,6 @@ fail:
 	return ret;
 }
 
-void *io_mem_alloc(size_t size)
-{
-	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP;
-	void *ret;
-
-	ret = (void *) __get_free_pages(gfp, get_order(size));
-	if (ret)
-		return ret;
-	return ERR_PTR(-ENOMEM);
-}
-
 static unsigned long rings_size(struct io_ring_ctx *ctx, unsigned int sq_entries,
 				unsigned int cq_entries, size_t *sq_offset)
 {
@@ -3073,7 +3055,6 @@ static __cold void io_ring_ctx_free(stru
 		ctx->mm_account = NULL;
 	}
 	io_rings_free(ctx);
-	io_kbuf_mmap_list_free(ctx);
 
 	percpu_ref_exit(&ctx->refs);
 	free_uid(ctx->user);
@@ -3563,10 +3544,8 @@ static void *io_uring_validate_mmap_requ
 {
 	struct io_ring_ctx *ctx = file->private_data;
 	loff_t offset = pgoff << PAGE_SHIFT;
-	struct page *page;
-	void *ptr;
 
-	switch (offset & IORING_OFF_MMAP_MASK) {
+	switch ((pgoff << PAGE_SHIFT) & IORING_OFF_MMAP_MASK) {
 	case IORING_OFF_SQ_RING:
 	case IORING_OFF_CQ_RING:
 		/* Don't allow mmap if the ring was setup without it */
@@ -3581,6 +3560,7 @@ static void *io_uring_validate_mmap_requ
 	case IORING_OFF_PBUF_RING: {
 		struct io_buffer_list *bl;
 		unsigned int bgid;
+		void *ptr;
 
 		bgid = (offset & ~IORING_OFF_MMAP_MASK) >> IORING_OFF_PBUF_SHIFT;
 		bl = io_pbuf_get_bl(ctx, bgid);
@@ -3588,17 +3568,11 @@ static void *io_uring_validate_mmap_requ
 			return bl;
 		ptr = bl->buf_ring;
 		io_put_bl(ctx, bl);
-		break;
+		return ptr;
 		}
-	default:
-		return ERR_PTR(-EINVAL);
 	}
 
-	page = virt_to_head_page(ptr);
-	if (sz > page_size(page))
-		return ERR_PTR(-EINVAL);
-
-	return ptr;
+	return ERR_PTR(-EINVAL);
 }
 
 int io_uring_mmap_pages(struct io_ring_ctx *ctx, struct vm_area_struct *vma,
@@ -3618,7 +3592,6 @@ static __cold int io_uring_mmap(struct f
 	size_t sz = vma->vm_end - vma->vm_start;
 	long offset = vma->vm_pgoff << PAGE_SHIFT;
 	unsigned int npages;
-	unsigned long pfn;
 	void *ptr;
 
 	ptr = io_uring_validate_mmap_request(file, vma->vm_pgoff, sz);
@@ -3633,10 +3606,11 @@ static __cold int io_uring_mmap(struct f
 	case IORING_OFF_SQES:
 		return io_uring_mmap_pages(ctx, vma, ctx->sqe_pages,
 						ctx->n_sqe_pages);
+	case IORING_OFF_PBUF_RING:
+		return io_pbuf_mmap(file, vma);
 	}
 
-	pfn = virt_to_phys(ptr) >> PAGE_SHIFT;
-	return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
+	return -EINVAL;
 }
 
 static unsigned long io_uring_mmu_get_unmapped_area(struct file *filp,
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -93,8 +93,10 @@ bool __io_alloc_req_refill(struct io_rin
 bool io_match_task_safe(struct io_kiocb *head, struct task_struct *task,
 			bool cancel_all);
 
-void *io_mem_alloc(size_t size);
-void io_mem_free(void *ptr);
+void *io_pages_map(struct page ***out_pages, unsigned short *npages,
+		   size_t size);
+void io_pages_unmap(void *ptr, struct page ***pages, unsigned short *npages,
+		    bool put_pages);
 
 #if defined(CONFIG_PROVE_LOCKING)
 static inline void io_lockdep_assert_cq_locked(struct io_ring_ctx *ctx)
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -30,25 +30,12 @@ struct io_provide_buf {
 	__u16				bid;
 };
 
-static inline struct io_buffer_list *__io_buffer_get_list(struct io_ring_ctx *ctx,
-							  unsigned int bgid)
-{
-	return xa_load(&ctx->io_bl_xa, bgid);
-}
-
-struct io_buf_free {
-	struct hlist_node		list;
-	void				*mem;
-	size_t				size;
-	int				inuse;
-};
-
 static inline struct io_buffer_list *io_buffer_get_list(struct io_ring_ctx *ctx,
 							unsigned int bgid)
 {
 	lockdep_assert_held(&ctx->uring_lock);
 
-	return __io_buffer_get_list(ctx, bgid);
+	return xa_load(&ctx->io_bl_xa, bgid);
 }
 
 static int io_buffer_add_list(struct io_ring_ctx *ctx,
@@ -199,24 +186,6 @@ void __user *io_buffer_select(struct io_
 	return ret;
 }
 
-/*
- * Mark the given mapped range as free for reuse
- */
-static void io_kbuf_mark_free(struct io_ring_ctx *ctx, struct io_buffer_list *bl)
-{
-	struct io_buf_free *ibf;
-
-	hlist_for_each_entry(ibf, &ctx->io_buf_list, list) {
-		if (bl->buf_ring == ibf->mem) {
-			ibf->inuse = 0;
-			return;
-		}
-	}
-
-	/* can't happen... */
-	WARN_ON_ONCE(1);
-}
-
 static int __io_remove_buffers(struct io_ring_ctx *ctx,
 			       struct io_buffer_list *bl, unsigned nbufs)
 {
@@ -228,23 +197,16 @@ static int __io_remove_buffers(struct io
 
 	if (bl->is_mapped) {
 		i = bl->buf_ring->tail - bl->head;
-		if (bl->is_mmap) {
-			/*
-			 * io_kbuf_list_free() will free the page(s) at
-			 * ->release() time.
-			 */
-			io_kbuf_mark_free(ctx, bl);
-			bl->buf_ring = NULL;
-			bl->is_mmap = 0;
-		} else if (bl->buf_nr_pages) {
+		if (bl->buf_nr_pages) {
 			int j;
 
-			for (j = 0; j < bl->buf_nr_pages; j++)
-				unpin_user_page(bl->buf_pages[j]);
-			kvfree(bl->buf_pages);
-			vunmap(bl->buf_ring);
-			bl->buf_pages = NULL;
-			bl->buf_nr_pages = 0;
+			if (!bl->is_mmap) {
+				for (j = 0; j < bl->buf_nr_pages; j++)
+					unpin_user_page(bl->buf_pages[j]);
+			}
+			io_pages_unmap(bl->buf_ring, &bl->buf_pages,
+					&bl->buf_nr_pages, bl->is_mmap);
+			bl->is_mmap = 0;
 		}
 		/* make sure it's seen as empty */
 		INIT_LIST_HEAD(&bl->buf_list);
@@ -540,63 +502,17 @@ error_unpin:
 	return ret;
 }
 
-/*
- * See if we have a suitable region that we can reuse, rather than allocate
- * both a new io_buf_free and mem region again. We leave it on the list as
- * even a reused entry will need freeing at ring release.
- */
-static struct io_buf_free *io_lookup_buf_free_entry(struct io_ring_ctx *ctx,
-						    size_t ring_size)
-{
-	struct io_buf_free *ibf, *best = NULL;
-	size_t best_dist;
-
-	hlist_for_each_entry(ibf, &ctx->io_buf_list, list) {
-		size_t dist;
-
-		if (ibf->inuse || ibf->size < ring_size)
-			continue;
-		dist = ibf->size - ring_size;
-		if (!best || dist < best_dist) {
-			best = ibf;
-			if (!dist)
-				break;
-			best_dist = dist;
-		}
-	}
-
-	return best;
-}
-
 static int io_alloc_pbuf_ring(struct io_ring_ctx *ctx,
 			      struct io_uring_buf_reg *reg,
 			      struct io_buffer_list *bl)
 {
-	struct io_buf_free *ibf;
 	size_t ring_size;
-	void *ptr;
 
 	ring_size = reg->ring_entries * sizeof(struct io_uring_buf_ring);
 
-	/* Reuse existing entry, if we can */
-	ibf = io_lookup_buf_free_entry(ctx, ring_size);
-	if (!ibf) {
-		ptr = io_mem_alloc(ring_size);
-		if (IS_ERR(ptr))
-			return PTR_ERR(ptr);
-
-		/* Allocate and store deferred free entry */
-		ibf = kmalloc(sizeof(*ibf), GFP_KERNEL_ACCOUNT);
-		if (!ibf) {
-			io_mem_free(ptr);
-			return -ENOMEM;
-		}
-		ibf->mem = ptr;
-		ibf->size = ring_size;
-		hlist_add_head(&ibf->list, &ctx->io_buf_list);
-	}
-	ibf->inuse = 1;
-	bl->buf_ring = ibf->mem;
+	bl->buf_ring = io_pages_map(&bl->buf_pages, &bl->buf_nr_pages, ring_size);
+	if (!bl->buf_ring)
+		return -ENOMEM;
 	bl->is_mapped = 1;
 	bl->is_mmap = 1;
 	return 0;
@@ -719,18 +635,19 @@ struct io_buffer_list *io_pbuf_get_bl(st
 	return ERR_PTR(-EINVAL);
 }
 
-/*
- * Called at or after ->release(), free the mmap'ed buffers that we used
- * for memory mapped provided buffer rings.
- */
-void io_kbuf_mmap_list_free(struct io_ring_ctx *ctx)
-{
-	struct io_buf_free *ibf;
-	struct hlist_node *tmp;
-
-	hlist_for_each_entry_safe(ibf, tmp, &ctx->io_buf_list, list) {
-		hlist_del(&ibf->list);
-		io_mem_free(ibf->mem);
-		kfree(ibf);
-	}
+int io_pbuf_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct io_ring_ctx *ctx = file->private_data;
+	loff_t pgoff = vma->vm_pgoff << PAGE_SHIFT;
+	struct io_buffer_list *bl;
+	int bgid, ret;
+
+	bgid = (pgoff & ~IORING_OFF_MMAP_MASK) >> IORING_OFF_PBUF_SHIFT;
+	bl = io_pbuf_get_bl(ctx, bgid);
+	if (IS_ERR(bl))
+		return PTR_ERR(bl);
+
+	ret = io_uring_mmap_pages(ctx, vma, bl->buf_pages, bl->buf_nr_pages);
+	io_put_bl(ctx, bl);
+	return ret;
 }
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -54,8 +54,6 @@ int io_provide_buffers(struct io_kiocb *
 int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg);
 int io_unregister_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg);
 
-void io_kbuf_mmap_list_free(struct io_ring_ctx *ctx);
-
 unsigned int __io_put_kbuf(struct io_kiocb *req, unsigned issue_flags);
 
 void io_kbuf_recycle_legacy(struct io_kiocb *req, unsigned issue_flags);
@@ -63,6 +61,7 @@ void io_kbuf_recycle_legacy(struct io_ki
 void io_put_bl(struct io_ring_ctx *ctx, struct io_buffer_list *bl);
 struct io_buffer_list *io_pbuf_get_bl(struct io_ring_ctx *ctx,
 				      unsigned long bgid);
+int io_pbuf_mmap(struct file *file, struct vm_area_struct *vma);
 
 static inline void io_kbuf_recycle_ring(struct io_kiocb *req)
 {



