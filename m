Return-Path: <stable+bounces-3780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4DA80245D
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54141F21195
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BE011733;
	Sun,  3 Dec 2023 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OcwRyZTb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02846156C3
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A400C433C8;
	Sun,  3 Dec 2023 13:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701611282;
	bh=8DjSmmM4XWLBBd64TpfCkmMz8P4knS3werDHv9+knLc=;
	h=Subject:To:Cc:From:Date:From;
	b=OcwRyZTb3kYnXUtUuMtfUuhFFMJjVyNbroji4BX3lP+tW2bPL0x2kxlCKsx1aX5op
	 UFrp+DQBUs7SaASXML7cOoWo+0/VosXb5NgHHKv3FHMjDVdU5I+8l2gkGEmjdsKOrk
	 LTiwZPSm9eh5sCL9SJ/7Avc9VVGUm9Om21AIefC4=
Subject: FAILED: patch "[PATCH] io_uring/kbuf: defer release of mapped buffer rings" failed to apply to 6.6-stable tree
To: axboe@kernel.dk,jannh@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:47:59 +0100
Message-ID: <2023120359-fit-broom-4a79@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c392cbecd8eca4c53f2bf508731257d9d0a21c2d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120359-fit-broom-4a79@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

c392cbecd8ec ("io_uring/kbuf: defer release of mapped buffer rings")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c392cbecd8eca4c53f2bf508731257d9d0a21c2d Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 27 Nov 2023 16:47:04 -0700
Subject: [PATCH] io_uring/kbuf: defer release of mapped buffer rings

If a provided buffer ring is setup with IOU_PBUF_RING_MMAP, then the
kernel allocates the memory for it and the application is expected to
mmap(2) this memory. However, io_uring uses remap_pfn_range() for this
operation, so we cannot rely on normal munmap/release on freeing them
for us.

Stash an io_buf_free entry away for each of these, if any, and provide
a helper to free them post ->release().

Cc: stable@vger.kernel.org
Fixes: c56e022c0a27 ("io_uring: add support for user mapped provided buffer ring")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index d3009d56af0b..805bb635cdf5 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -340,6 +340,9 @@ struct io_ring_ctx {
 
 	struct list_head	io_buffers_cache;
 
+	/* deferred free list, protected by ->uring_lock */
+	struct hlist_head	io_buf_list;
+
 	/* Keep this last, we don't need it for the fast path */
 	struct wait_queue_head		poll_wq;
 	struct io_restriction		restrictions;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index e40b11438210..3a216f0744dd 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -325,6 +325,7 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	INIT_LIST_HEAD(&ctx->sqd_list);
 	INIT_LIST_HEAD(&ctx->cq_overflow_list);
 	INIT_LIST_HEAD(&ctx->io_buffers_cache);
+	INIT_HLIST_HEAD(&ctx->io_buf_list);
 	io_alloc_cache_init(&ctx->rsrc_node_cache, IO_NODE_ALLOC_CACHE_MAX,
 			    sizeof(struct io_rsrc_node));
 	io_alloc_cache_init(&ctx->apoll_cache, IO_ALLOC_CACHE_MAX,
@@ -2950,6 +2951,7 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 		ctx->mm_account = NULL;
 	}
 	io_rings_free(ctx);
+	io_kbuf_mmap_list_free(ctx);
 
 	percpu_ref_exit(&ctx->refs);
 	free_uid(ctx->user);
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index a1e4239c7d75..85e680fc74ce 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -33,6 +33,11 @@ struct io_provide_buf {
 	__u16				bid;
 };
 
+struct io_buf_free {
+	struct hlist_node		list;
+	void				*mem;
+};
+
 static inline struct io_buffer_list *io_buffer_get_list(struct io_ring_ctx *ctx,
 							unsigned int bgid)
 {
@@ -223,7 +228,10 @@ static int __io_remove_buffers(struct io_ring_ctx *ctx,
 	if (bl->is_mapped) {
 		i = bl->buf_ring->tail - bl->head;
 		if (bl->is_mmap) {
-			folio_put(virt_to_folio(bl->buf_ring));
+			/*
+			 * io_kbuf_list_free() will free the page(s) at
+			 * ->release() time.
+			 */
 			bl->buf_ring = NULL;
 			bl->is_mmap = 0;
 		} else if (bl->buf_nr_pages) {
@@ -531,18 +539,28 @@ static int io_pin_pbuf_ring(struct io_uring_buf_reg *reg,
 	return -EINVAL;
 }
 
-static int io_alloc_pbuf_ring(struct io_uring_buf_reg *reg,
+static int io_alloc_pbuf_ring(struct io_ring_ctx *ctx,
+			      struct io_uring_buf_reg *reg,
 			      struct io_buffer_list *bl)
 {
-	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP;
+	struct io_buf_free *ibf;
 	size_t ring_size;
 	void *ptr;
 
 	ring_size = reg->ring_entries * sizeof(struct io_uring_buf_ring);
-	ptr = (void *) __get_free_pages(gfp, get_order(ring_size));
+	ptr = io_mem_alloc(ring_size);
 	if (!ptr)
 		return -ENOMEM;
 
+	/* Allocate and store deferred free entry */
+	ibf = kmalloc(sizeof(*ibf), GFP_KERNEL_ACCOUNT);
+	if (!ibf) {
+		io_mem_free(ptr);
+		return -ENOMEM;
+	}
+	ibf->mem = ptr;
+	hlist_add_head(&ibf->list, &ctx->io_buf_list);
+
 	bl->buf_ring = ptr;
 	bl->is_mapped = 1;
 	bl->is_mmap = 1;
@@ -599,7 +617,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	if (!(reg.flags & IOU_PBUF_RING_MMAP))
 		ret = io_pin_pbuf_ring(&reg, bl);
 	else
-		ret = io_alloc_pbuf_ring(&reg, bl);
+		ret = io_alloc_pbuf_ring(ctx, &reg, bl);
 
 	if (!ret) {
 		bl->nr_entries = reg.ring_entries;
@@ -649,3 +667,19 @@ void *io_pbuf_get_address(struct io_ring_ctx *ctx, unsigned long bgid)
 
 	return bl->buf_ring;
 }
+
+/*
+ * Called at or after ->release(), free the mmap'ed buffers that we used
+ * for memory mapped provided buffer rings.
+ */
+void io_kbuf_mmap_list_free(struct io_ring_ctx *ctx)
+{
+	struct io_buf_free *ibf;
+	struct hlist_node *tmp;
+
+	hlist_for_each_entry_safe(ibf, tmp, &ctx->io_buf_list, list) {
+		hlist_del(&ibf->list);
+		io_mem_free(ibf->mem);
+		kfree(ibf);
+	}
+}
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index f2d615236b2c..6c7646e6057c 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -51,6 +51,8 @@ int io_provide_buffers(struct io_kiocb *req, unsigned int issue_flags);
 int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg);
 int io_unregister_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg);
 
+void io_kbuf_mmap_list_free(struct io_ring_ctx *ctx);
+
 unsigned int __io_put_kbuf(struct io_kiocb *req, unsigned issue_flags);
 
 bool io_kbuf_recycle_legacy(struct io_kiocb *req, unsigned issue_flags);


