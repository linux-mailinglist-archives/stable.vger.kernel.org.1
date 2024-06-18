Return-Path: <stable+bounces-52865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8377B90CF18
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04D4280F9D
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE9715B132;
	Tue, 18 Jun 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iTWP8WPZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05DF15B111;
	Tue, 18 Jun 2024 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714640; cv=none; b=oZWSj+nVibaqgiytEPA2xtmSFnMfq7iwSQlKs7aAcr0cT3Hvzppu4RjlQvnbp1sO8mWp1ZBHRBZk/7t6PhUeWFijvKeZh9fKByIHfhwnk/89NsIuAz78om66TA3KplBcnxusm/Ii7TuzLkto5SQVhG9qjL3kOB5rXdtO/H4utdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714640; c=relaxed/simple;
	bh=hMIMwuTAeN28VndxJs8aq1rzbHEjp/V2omp2NHYrNbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXEiyexw+MumGCr/+J8jtedU5QvyA+PYoae7Y9H7YnkqcUK2xfOOYtQz2Onq91Zk1xHYsVrdLikjtSB9W/KRyAPG5zduS5TdmzztLx5E/r4iaxsF+PkdOmHRU9hrmQt1a1BkNTsZwBNOFjwBRzlj/Lnr9xk7CII6vJYGdPhBrfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iTWP8WPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6505CC3277B;
	Tue, 18 Jun 2024 12:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718714639;
	bh=hMIMwuTAeN28VndxJs8aq1rzbHEjp/V2omp2NHYrNbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTWP8WPZ3/5acwqyk1utAwLXZu4yxPVpvvfvH8SpsHPAz4uVm7ozfjCGbg5emWo9s
	 WsX7t4TazcNHuX+buyOPSF6u+6nWPLipjmkS8H2KgvMyX1m7OB+i76crfyjf/pNPtM
	 PzdHI66CdIaNfi5xuA+06Q5MxyZL/vzOAlvULLdk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 009/770] SUNRPC: Add xdr_set_scratch_page() and xdr_reset_scratch_buffer()
Date: Tue, 18 Jun 2024 14:27:42 +0200
Message-ID: <20240618123407.649776913@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 0ae4c3e8a64ace1b8d7de033b0751afe43024416 ]

Clean up: De-duplicate some frequently-used code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/blocklayout/blocklayout.c          |  2 +-
 fs/nfs/blocklayout/dev.c                  |  2 +-
 fs/nfs/dir.c                              |  2 +-
 fs/nfs/filelayout/filelayout.c            |  2 +-
 fs/nfs/filelayout/filelayoutdev.c         |  2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    |  2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |  2 +-
 fs/nfs/nfs42xdr.c                         |  2 +-
 fs/nfs/nfs4xdr.c                          |  6 ++--
 fs/nfsd/nfs4proc.c                        |  2 +-
 include/linux/sunrpc/xdr.h                | 44 ++++++++++++++++++++++-
 net/sunrpc/auth_gss/gss_rpc_xdr.c         |  2 +-
 net/sunrpc/xdr.c                          | 28 +++------------
 13 files changed, 59 insertions(+), 39 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 73000aa2d220b..a9e563145e0c2 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -699,7 +699,7 @@ bl_alloc_lseg(struct pnfs_layout_hdr *lo, struct nfs4_layoutget_res *lgr,
 
 	xdr_init_decode_pages(&xdr, &buf,
 			lgr->layoutp->pages, lgr->layoutp->len);
-	xdr_set_scratch_buffer(&xdr, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(&xdr, scratch);
 
 	status = -EIO;
 	p = xdr_inline_decode(&xdr, 4);
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 6e3a14fdff9c8..16412d6636e86 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -510,7 +510,7 @@ bl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 		goto out;
 
 	xdr_init_decode_pages(&xdr, &buf, pdev->pages, pdev->pglen);
-	xdr_set_scratch_buffer(&xdr, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(&xdr, scratch);
 
 	p = xdr_inline_decode(&xdr, sizeof(__be32));
 	if (!p)
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 9f88ca7b20015..935029632d5f6 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -576,7 +576,7 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 		goto out_nopages;
 
 	xdr_init_decode_pages(&stream, &buf, xdr_pages, buflen);
-	xdr_set_scratch_buffer(&stream, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(&stream, scratch);
 
 	do {
 		if (entry->label)
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index deecfb50dd7e3..45eec08ec904f 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -666,7 +666,7 @@ filelayout_decode_layout(struct pnfs_layout_hdr *flo,
 		return -ENOMEM;
 
 	xdr_init_decode_pages(&stream, &buf, lgr->layoutp->pages, lgr->layoutp->len);
-	xdr_set_scratch_buffer(&stream, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(&stream, scratch);
 
 	/* 20 = ufl_util (4), first_stripe_index (4), pattern_offset (8),
 	 * num_fh (4) */
diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index d913e818858f3..86c3f7e69ec42 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -82,7 +82,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 		goto out_err;
 
 	xdr_init_decode_pages(&stream, &buf, pdev->pages, pdev->pglen);
-	xdr_set_scratch_buffer(&stream, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(&stream, scratch);
 
 	/* Get the stripe count (number of stripe index) */
 	p = xdr_inline_decode(&stream, 4);
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index e4f2820ba5a59..f2ae271fe7ec7 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -378,7 +378,7 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 
 	xdr_init_decode_pages(&stream, &buf, lgr->layoutp->pages,
 			      lgr->layoutp->len);
-	xdr_set_scratch_buffer(&stream, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(&stream, scratch);
 
 	/* stripe unit and mirror_array_cnt */
 	rc = -EIO;
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index 1f12297109b41..bfa7202ca7be1 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -69,7 +69,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	INIT_LIST_HEAD(&dsaddrs);
 
 	xdr_init_decode_pages(&stream, &buf, pdev->pages, pdev->pglen);
-	xdr_set_scratch_buffer(&stream, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(&stream, scratch);
 
 	/* multipath count */
 	p = xdr_inline_decode(&stream, 4);
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index f2248d9d4db51..df5bee2f505c4 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1536,7 +1536,7 @@ static int nfs4_xdr_dec_listxattrs(struct rpc_rqst *rqstp,
 	struct compound_hdr hdr;
 	int status;
 
-	xdr_set_scratch_buffer(xdr, page_address(res->scratch), PAGE_SIZE);
+	xdr_set_scratch_page(xdr, res->scratch);
 
 	status = decode_compound_hdr(xdr, &hdr);
 	if (status)
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index f1e599553f2be..4e5c6cb770ad5 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -6404,10 +6404,8 @@ nfs4_xdr_dec_getacl(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	struct compound_hdr hdr;
 	int status;
 
-	if (res->acl_scratch != NULL) {
-		void *p = page_address(res->acl_scratch);
-		xdr_set_scratch_buffer(xdr, p, PAGE_SIZE);
-	}
+	if (res->acl_scratch != NULL)
+		xdr_set_scratch_page(xdr, res->acl_scratch);
 	status = decode_compound_hdr(xdr, &hdr);
 	if (status)
 		goto out;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e84996c3867c7..c01b6f7462fcb 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2266,7 +2266,7 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
 	xdr->end = head->iov_base + PAGE_SIZE - rqstp->rq_auth_slack;
 	/* Tail and page_len should be zero at this point: */
 	buf->len = buf->head[0].iov_len;
-	xdr->scratch.iov_len = 0;
+	xdr_reset_scratch_buffer(xdr);
 	xdr->page_ptr = buf->pages - 1;
 	buf->buflen = PAGE_SIZE * (1 + rqstp->rq_page_end - buf->pages)
 		- rqstp->rq_auth_slack;
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 6d9d1520612b8..0c8cab6210b3b 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -246,7 +246,6 @@ extern void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf,
 			    __be32 *p, struct rpc_rqst *rqst);
 extern void xdr_init_decode_pages(struct xdr_stream *xdr, struct xdr_buf *buf,
 		struct page **pages, unsigned int len);
-extern void xdr_set_scratch_buffer(struct xdr_stream *xdr, void *buf, size_t buflen);
 extern __be32 *xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes);
 extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
 extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
@@ -254,6 +253,49 @@ extern int xdr_process_buf(struct xdr_buf *buf, unsigned int offset, unsigned in
 extern uint64_t xdr_align_data(struct xdr_stream *, uint64_t, uint32_t);
 extern uint64_t xdr_expand_hole(struct xdr_stream *, uint64_t, uint64_t);
 
+/**
+ * xdr_set_scratch_buffer - Attach a scratch buffer for decoding data.
+ * @xdr: pointer to xdr_stream struct
+ * @buf: pointer to an empty buffer
+ * @buflen: size of 'buf'
+ *
+ * The scratch buffer is used when decoding from an array of pages.
+ * If an xdr_inline_decode() call spans across page boundaries, then
+ * we copy the data into the scratch buffer in order to allow linear
+ * access.
+ */
+static inline void
+xdr_set_scratch_buffer(struct xdr_stream *xdr, void *buf, size_t buflen)
+{
+	xdr->scratch.iov_base = buf;
+	xdr->scratch.iov_len = buflen;
+}
+
+/**
+ * xdr_set_scratch_page - Attach a scratch buffer for decoding data
+ * @xdr: pointer to xdr_stream struct
+ * @page: an anonymous page
+ *
+ * See xdr_set_scratch_buffer().
+ */
+static inline void
+xdr_set_scratch_page(struct xdr_stream *xdr, struct page *page)
+{
+	xdr_set_scratch_buffer(xdr, page_address(page), PAGE_SIZE);
+}
+
+/**
+ * xdr_reset_scratch_buffer - Clear scratch buffer information
+ * @xdr: pointer to xdr_stream struct
+ *
+ * See xdr_set_scratch_buffer().
+ */
+static inline void
+xdr_reset_scratch_buffer(struct xdr_stream *xdr)
+{
+	xdr_set_scratch_buffer(xdr, NULL, 0);
+}
+
 /**
  * xdr_stream_remaining - Return the number of bytes remaining in the stream
  * @xdr: pointer to struct xdr_stream
diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
index e265b8d38aa14..a857fc99431ce 100644
--- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
+++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
@@ -800,7 +800,7 @@ int gssx_dec_accept_sec_context(struct rpc_rqst *rqstp,
 	scratch = alloc_page(GFP_KERNEL);
 	if (!scratch)
 		return -ENOMEM;
-	xdr_set_scratch_buffer(xdr, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(xdr, scratch);
 
 	/* res->status */
 	err = gssx_dec_status(xdr, &res->status);
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index d84bb5037bb5b..02adc5c7f034d 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -669,7 +669,7 @@ void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *buf, __be32 *p,
 	struct kvec *iov = buf->head;
 	int scratch_len = buf->buflen - buf->page_len - buf->tail[0].iov_len;
 
-	xdr_set_scratch_buffer(xdr, NULL, 0);
+	xdr_reset_scratch_buffer(xdr);
 	BUG_ON(scratch_len < 0);
 	xdr->buf = buf;
 	xdr->iov = iov;
@@ -713,7 +713,7 @@ inline void xdr_commit_encode(struct xdr_stream *xdr)
 	page = page_address(*xdr->page_ptr);
 	memcpy(xdr->scratch.iov_base, page, shift);
 	memmove(page, page + shift, (void *)xdr->p - page);
-	xdr->scratch.iov_len = 0;
+	xdr_reset_scratch_buffer(xdr);
 }
 EXPORT_SYMBOL_GPL(xdr_commit_encode);
 
@@ -743,8 +743,7 @@ static __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
 	 * the "scratch" iov to track any temporarily unused fragment of
 	 * space at the end of the previous buffer:
 	 */
-	xdr->scratch.iov_base = xdr->p;
-	xdr->scratch.iov_len = frag1bytes;
+	xdr_set_scratch_buffer(xdr, xdr->p, frag1bytes);
 	p = page_address(*xdr->page_ptr);
 	/*
 	 * Note this is where the next encode will start after we've
@@ -1056,8 +1055,7 @@ void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf, __be32 *p,
 		     struct rpc_rqst *rqst)
 {
 	xdr->buf = buf;
-	xdr->scratch.iov_base = NULL;
-	xdr->scratch.iov_len = 0;
+	xdr_reset_scratch_buffer(xdr);
 	xdr->nwords = XDR_QUADLEN(buf->len);
 	if (buf->head[0].iov_len != 0)
 		xdr_set_iov(xdr, buf->head, buf->len);
@@ -1105,24 +1103,6 @@ static __be32 * __xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes)
 	return p;
 }
 
-/**
- * xdr_set_scratch_buffer - Attach a scratch buffer for decoding data.
- * @xdr: pointer to xdr_stream struct
- * @buf: pointer to an empty buffer
- * @buflen: size of 'buf'
- *
- * The scratch buffer is used when decoding from an array of pages.
- * If an xdr_inline_decode() call spans across page boundaries, then
- * we copy the data into the scratch buffer in order to allow linear
- * access.
- */
-void xdr_set_scratch_buffer(struct xdr_stream *xdr, void *buf, size_t buflen)
-{
-	xdr->scratch.iov_base = buf;
-	xdr->scratch.iov_len = buflen;
-}
-EXPORT_SYMBOL_GPL(xdr_set_scratch_buffer);
-
 static __be32 *xdr_copy_to_scratch(struct xdr_stream *xdr, size_t nbytes)
 {
 	__be32 *p;
-- 
2.43.0




