Return-Path: <stable+bounces-4080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357438045E8
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F37C1C20CEF
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866938BE0;
	Tue,  5 Dec 2023 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wwZSmBDj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4679379F2;
	Tue,  5 Dec 2023 03:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDABC433CB;
	Tue,  5 Dec 2023 03:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746566;
	bh=td8Yo0i+GTMDURFDXLnjYU6CvPqlCDVrz/S7Kh1BlQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wwZSmBDjbHBV3H0ZAuZkINDggFJWDQdFHfyBlxQADRJrnwbL84WV0VVqNWXHq+FaN
	 fA1HkfLfZBUrWEzLHtxtfYfcPg6UHQsgAjzrDqYic3Hy9WObmuweyrLSnWu154ktC+
	 eArxbu7+ziFQo3FtITYq1FxHiEephAKnfPJMJ5c8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 072/134] io_uring/kbuf: defer release of mapped buffer rings
Date: Tue,  5 Dec 2023 12:15:44 +0900
Message-ID: <20231205031540.069815766@linuxfoundation.org>
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

commit c392cbecd8eca4c53f2bf508731257d9d0a21c2d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/io_uring_types.h |    3 ++
 io_uring/io_uring.c            |    2 +
 io_uring/kbuf.c                |   44 ++++++++++++++++++++++++++++++++++++-----
 io_uring/kbuf.h                |    2 +
 4 files changed, 46 insertions(+), 5 deletions(-)

--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -327,6 +327,9 @@ struct io_ring_ctx {
 
 	struct list_head	io_buffers_cache;
 
+	/* deferred free list, protected by ->uring_lock */
+	struct hlist_head	io_buf_list;
+
 	/* Keep this last, we don't need it for the fast path */
 	struct wait_queue_head		poll_wq;
 	struct io_restriction		restrictions;
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -323,6 +323,7 @@ static __cold struct io_ring_ctx *io_rin
 	INIT_LIST_HEAD(&ctx->sqd_list);
 	INIT_LIST_HEAD(&ctx->cq_overflow_list);
 	INIT_LIST_HEAD(&ctx->io_buffers_cache);
+	INIT_HLIST_HEAD(&ctx->io_buf_list);
 	io_alloc_cache_init(&ctx->rsrc_node_cache, IO_NODE_ALLOC_CACHE_MAX,
 			    sizeof(struct io_rsrc_node));
 	io_alloc_cache_init(&ctx->apoll_cache, IO_ALLOC_CACHE_MAX,
@@ -2942,6 +2943,7 @@ static __cold void io_ring_ctx_free(stru
 		ctx->mm_account = NULL;
 	}
 	io_rings_free(ctx);
+	io_kbuf_mmap_list_free(ctx);
 
 	percpu_ref_exit(&ctx->refs);
 	free_uid(ctx->user);
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -41,6 +41,11 @@ static struct io_buffer_list *__io_buffe
 	return xa_load(&ctx->io_bl_xa, bgid);
 }
 
+struct io_buf_free {
+	struct hlist_node		list;
+	void				*mem;
+};
+
 static inline struct io_buffer_list *io_buffer_get_list(struct io_ring_ctx *ctx,
 							unsigned int bgid)
 {
@@ -238,7 +243,10 @@ static int __io_remove_buffers(struct io
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
@@ -552,18 +560,28 @@ error_unpin:
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
@@ -622,7 +640,7 @@ int io_register_pbuf_ring(struct io_ring
 	if (!(reg.flags & IOU_PBUF_RING_MMAP))
 		ret = io_pin_pbuf_ring(&reg, bl);
 	else
-		ret = io_alloc_pbuf_ring(&reg, bl);
+		ret = io_alloc_pbuf_ring(ctx, &reg, bl);
 
 	if (!ret) {
 		bl->nr_entries = reg.ring_entries;
@@ -682,3 +700,19 @@ void *io_pbuf_get_address(struct io_ring
 
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
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -54,6 +54,8 @@ int io_provide_buffers(struct io_kiocb *
 int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg);
 int io_unregister_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg);
 
+void io_kbuf_mmap_list_free(struct io_ring_ctx *ctx);
+
 unsigned int __io_put_kbuf(struct io_kiocb *req, unsigned issue_flags);
 
 void io_kbuf_recycle_legacy(struct io_kiocb *req, unsigned issue_flags);



