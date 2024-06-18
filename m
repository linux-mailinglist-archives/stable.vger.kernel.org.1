Return-Path: <stable+bounces-52817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9290CD94
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8F02815A8
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163F71B3F1B;
	Tue, 18 Jun 2024 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xkkuDAVb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6AB159568;
	Tue, 18 Jun 2024 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714565; cv=none; b=REfLhNPZBNm1qs3ldrcyMalnjG/jmbj5b7Xm0RhgKdq1qDbXWGVrXZp/KMXBg2Z5nQDifz8PTv7TvW7nWNwml3bbyIWCiI4R/POREwMi2GQRxKLzC/giYsaLFt0vXP27JdqzGiiSrqXcJ8emr1RyhpAkgOYCSuT0x/Oj46J7BcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714565; c=relaxed/simple;
	bh=GwiLoYD8dDDdQhYYOBq2Jux9TA4JZ6W2Q4EaP1YXF40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3j56o4FrL+1jxnlWjLHqTSrEc4WLIRwlPNlAoXyhGpvj6VrAgP3i+SmH9YL1GGN4f064Q5dRF+nMXcev5caJMrs06H/H6p3XCklFw0TPCysdURqStZ2yNpW5CyiPFqfOPd9n3FLPdQJ8aHtCUy34IEdFRG7sIyR2hG02+QL028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xkkuDAVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F15C4AF48;
	Tue, 18 Jun 2024 12:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718714565;
	bh=GwiLoYD8dDDdQhYYOBq2Jux9TA4JZ6W2Q4EaP1YXF40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xkkuDAVbhAzXSy3jOD4AOhJa0dg8Op02V/HyRlpwHiz1mZ3sv/XnZuy64HRmKDoDJ
	 hofvC9ECearqMCiiWDK7h27w2ApDQZ25IdQ35MeVA7VsZ/9tfG5YBVuEG5K/D56YOw
	 eJDz98DNJghdTdIcKYpqWjB51vQ2GqsllVGbrvbI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 014/770] NFSD: Replace the internals of the READ_BUF() macro
Date: Tue, 18 Jun 2024 14:27:47 +0200
Message-ID: <20240618123407.846397927@linuxfoundation.org>
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

[ Upstream commit c1346a1216ab5cb04a265380ac9035d91b16b6d5 ]

Convert the READ_BUF macro in nfs4xdr.c from open code to instead
use the new xdr_stream-style decoders already in use by the encode
side (and by the in-kernel NFS client implementation). Once this
conversion is done, each individual NFSv4 argument decoder can be
independently cleaned up to replace these macros with C code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c         |   4 +-
 fs/nfsd/nfs4xdr.c          | 181 ++++++-------------------------------
 fs/nfsd/xdr4.h             |  10 +-
 include/linux/sunrpc/xdr.h |   2 +
 net/sunrpc/xdr.c           |  45 +++++++++
 5 files changed, 77 insertions(+), 165 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 55a46e7c152b9..95545a61bfc77 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1024,8 +1024,8 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	write->wr_how_written = write->wr_stable_how;
 
-	nvecs = svc_fill_write_vector(rqstp, write->wr_pagelist,
-				      &write->wr_head, write->wr_buflen);
+	nvecs = svc_fill_write_vector(rqstp, write->wr_payload.pages,
+				      write->wr_payload.head, write->wr_buflen);
 	WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
 
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 101ada3636b78..8c694844f0efb 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -131,90 +131,13 @@ xdr_error:					\
 	memcpy((x), p, nbytes);			\
 	p += XDR_QUADLEN(nbytes);		\
 } while (0)
-
-/* READ_BUF, read_buf(): nbytes must be <= PAGE_SIZE */
-#define READ_BUF(nbytes)  do {			\
-	if (nbytes <= (u32)((char *)argp->end - (char *)argp->p)) {	\
-		p = argp->p;			\
-		argp->p += XDR_QUADLEN(nbytes);	\
-	} else if (!(p = read_buf(argp, nbytes))) { \
-		dprintk("NFSD: xdr error (%s:%d)\n", \
-				__FILE__, __LINE__); \
-		goto xdr_error;			\
-	}					\
-} while (0)
-
-static void next_decode_page(struct nfsd4_compoundargs *argp)
-{
-	argp->p = page_address(argp->pagelist[0]);
-	argp->pagelist++;
-	if (argp->pagelen < PAGE_SIZE) {
-		argp->end = argp->p + XDR_QUADLEN(argp->pagelen);
-		argp->pagelen = 0;
-	} else {
-		argp->end = argp->p + (PAGE_SIZE>>2);
-		argp->pagelen -= PAGE_SIZE;
-	}
-}
-
-static __be32 *read_buf(struct nfsd4_compoundargs *argp, u32 nbytes)
-{
-	/* We want more bytes than seem to be available.
-	 * Maybe we need a new page, maybe we have just run out
-	 */
-	unsigned int avail = (char *)argp->end - (char *)argp->p;
-	__be32 *p;
-
-	if (argp->pagelen == 0) {
-		struct kvec *vec = &argp->rqstp->rq_arg.tail[0];
-
-		if (!argp->tail) {
-			argp->tail = true;
-			avail = vec->iov_len;
-			argp->p = vec->iov_base;
-			argp->end = vec->iov_base + avail;
-		}
-
-		if (avail < nbytes)
-			return NULL;
-
-		p = argp->p;
-		argp->p += XDR_QUADLEN(nbytes);
-		return p;
-	}
-
-	if (avail + argp->pagelen < nbytes)
-		return NULL;
-	if (avail + PAGE_SIZE < nbytes) /* need more than a page !! */
-		return NULL;
-	/* ok, we can do it with the current plus the next page */
-	if (nbytes <= sizeof(argp->tmp))
-		p = argp->tmp;
-	else {
-		kfree(argp->tmpp);
-		p = argp->tmpp = kmalloc(nbytes, GFP_KERNEL);
-		if (!p)
-			return NULL;
-		
-	}
-	/*
-	 * The following memcpy is safe because read_buf is always
-	 * called with nbytes > avail, and the two cases above both
-	 * guarantee p points to at least nbytes bytes.
-	 */
-	memcpy(p, argp->p, avail);
-	next_decode_page(argp);
-	memcpy(((char*)p)+avail, argp->p, (nbytes - avail));
-	argp->p += XDR_QUADLEN(nbytes - avail);
-	return p;
-}
-
-static unsigned int compoundargs_bytes_left(struct nfsd4_compoundargs *argp)
-{
-	unsigned int this = (char *)argp->end - (char *)argp->p;
-
-	return this + argp->pagelen;
-}
+#define READ_BUF(nbytes)			\
+	do {					\
+		p = xdr_inline_decode(argp->xdr,\
+				      nbytes);	\
+		if (!p)				\
+			goto xdr_error;		\
+	} while (0)
 
 static int zero_clientid(clientid_t *clid)
 {
@@ -261,44 +184,6 @@ svcxdr_dupstr(struct nfsd4_compoundargs *argp, void *buf, u32 len)
 	return p;
 }
 
-static __be32
-svcxdr_construct_vector(struct nfsd4_compoundargs *argp, struct kvec *head,
-			struct page ***pagelist, u32 buflen)
-{
-	int avail;
-	int len;
-	int pages;
-
-	/* Sorry .. no magic macros for this.. *
-	 * READ_BUF(write->wr_buflen);
-	 * SAVEMEM(write->wr_buf, write->wr_buflen);
-	 */
-	avail = (char *)argp->end - (char *)argp->p;
-	if (avail + argp->pagelen < buflen) {
-		dprintk("NFSD: xdr error (%s:%d)\n",
-			       __FILE__, __LINE__);
-		return nfserr_bad_xdr;
-	}
-	head->iov_base = argp->p;
-	head->iov_len = avail;
-	*pagelist = argp->pagelist;
-
-	len = XDR_QUADLEN(buflen) << 2;
-	if (len >= avail) {
-		len -= avail;
-
-		pages = len >> PAGE_SHIFT;
-		argp->pagelist += pages;
-		argp->pagelen -= pages * PAGE_SIZE;
-		len -= pages * PAGE_SIZE;
-
-		next_decode_page(argp);
-	}
-	argp->p += XDR_QUADLEN(len);
-
-	return 0;
-}
-
 /**
  * savemem - duplicate a chunk of memory for later processing
  * @argp: NFSv4 compound argument structure to be freed with
@@ -398,7 +283,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		READ_BUF(4); len += 4;
 		nace = be32_to_cpup(p++);
 
-		if (nace > compoundargs_bytes_left(argp)/20)
+		if (nace > xdr_stream_remaining(argp->xdr) / sizeof(struct nfs4_ace))
 			/*
 			 * Even with 4-byte names there wouldn't be
 			 * space for that many aces; something fishy is
@@ -929,7 +814,7 @@ static __be32 nfsd4_decode_share_deny(struct nfsd4_compoundargs *argp, u32 *x)
 
 static __be32 nfsd4_decode_opaque(struct nfsd4_compoundargs *argp, struct xdr_netobj *o)
 {
-	__be32 *p;
+	DECODE_HEAD;
 
 	READ_BUF(4);
 	o->len = be32_to_cpup(p++);
@@ -939,9 +824,8 @@ static __be32 nfsd4_decode_opaque(struct nfsd4_compoundargs *argp, struct xdr_ne
 
 	READ_BUF(o->len);
 	SAVEMEM(o->data, o->len);
-	return nfs_ok;
-xdr_error:
-	return nfserr_bad_xdr;
+
+	DECODE_TAIL;
 }
 
 static __be32
@@ -1319,10 +1203,8 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 		goto xdr_error;
 	write->wr_buflen = be32_to_cpup(p++);
 
-	status = svcxdr_construct_vector(argp, &write->wr_head,
-					 &write->wr_pagelist, write->wr_buflen);
-	if (status)
-		return status;
+	if (!xdr_stream_subsegment(argp->xdr, &write->wr_payload, write->wr_buflen))
+		goto xdr_error;
 
 	DECODE_TAIL;
 }
@@ -1891,13 +1773,14 @@ nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
  */
 
 /*
- * Decode data into buffer. Uses head and pages constructed by
- * svcxdr_construct_vector.
+ * Decode data into buffer.
  */
 static __be32
-nfsd4_vbuf_from_vector(struct nfsd4_compoundargs *argp, struct kvec *head,
-		       struct page **pages, char **bufp, u32 buflen)
+nfsd4_vbuf_from_vector(struct nfsd4_compoundargs *argp, struct xdr_buf *xdr,
+		       char **bufp, u32 buflen)
 {
+	struct page **pages = xdr->pages;
+	struct kvec *head = xdr->head;
 	char *tmp, *dp;
 	u32 len;
 
@@ -2012,8 +1895,6 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 {
 	DECODE_HEAD;
 	u32 flags, maxcount, size;
-	struct kvec head;
-	struct page **pagelist;
 
 	READ_BUF(4);
 	flags = be32_to_cpup(p++);
@@ -2036,12 +1917,12 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 
 	setxattr->setxa_len = size;
 	if (size > 0) {
-		status = svcxdr_construct_vector(argp, &head, &pagelist, size);
-		if (status)
-			return status;
+		struct xdr_buf payload;
 
-		status = nfsd4_vbuf_from_vector(argp, &head, pagelist,
-		    &setxattr->setxa_buf, size);
+		if (!xdr_stream_subsegment(argp->xdr, &payload, size))
+			goto xdr_error;
+		status = nfsd4_vbuf_from_vector(argp, &payload,
+						&setxattr->setxa_buf, size);
 	}
 
 	DECODE_TAIL;
@@ -5305,8 +5186,6 @@ void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 		kfree(args->ops);
 		args->ops = args->iops;
 	}
-	kfree(args->tmpp);
-	args->tmpp = NULL;
 	while (args->to_free) {
 		struct svcxdr_tmpbuf *tb = args->to_free;
 		args->to_free = tb->next;
@@ -5319,19 +5198,11 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd4_compoundargs *args = rqstp->rq_argp;
 
-	if (rqstp->rq_arg.head[0].iov_len % 4) {
-		/* client is nuts */
-		dprintk("%s: compound not properly padded! (peeraddr=%pISc xid=0x%x)",
-			__func__, svc_addr(rqstp), be32_to_cpu(rqstp->rq_xid));
-		return 0;
-	}
-	args->p = p;
-	args->end = rqstp->rq_arg.head[0].iov_base + rqstp->rq_arg.head[0].iov_len;
-	args->pagelist = rqstp->rq_arg.pages;
-	args->pagelen = rqstp->rq_arg.page_len;
-	args->tail = false;
+	/* svcxdr_tmp_alloc */
 	args->tmpp = NULL;
 	args->to_free = NULL;
+
+	args->xdr = &rqstp->rq_arg_stream;
 	args->ops = args->iops;
 	args->rqstp = rqstp;
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 37f89ad5e9923..0eb13bd603ea6 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -419,8 +419,7 @@ struct nfsd4_write {
 	u64		wr_offset;          /* request */
 	u32		wr_stable_how;      /* request */
 	u32		wr_buflen;          /* request */
-	struct kvec	wr_head;
-	struct page **	wr_pagelist;        /* request */
+	struct xdr_buf	wr_payload;         /* request */
 
 	u32		wr_bytes_written;   /* response */
 	u32		wr_how_written;     /* response */
@@ -696,15 +695,10 @@ struct svcxdr_tmpbuf {
 
 struct nfsd4_compoundargs {
 	/* scratch variables for XDR decode */
-	__be32 *			p;
-	__be32 *			end;
-	struct page **			pagelist;
-	int				pagelen;
-	bool				tail;
 	__be32				tmp[8];
 	__be32 *			tmpp;
+	struct xdr_stream		*xdr;
 	struct svcxdr_tmpbuf		*to_free;
-
 	struct svc_rqst			*rqstp;
 
 	u32				taglen;
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 0c8cab6210b3b..c03f7bf585c96 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -252,6 +252,8 @@ extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
 extern int xdr_process_buf(struct xdr_buf *buf, unsigned int offset, unsigned int len, int (*actor)(struct scatterlist *, void *), void *data);
 extern uint64_t xdr_align_data(struct xdr_stream *, uint64_t, uint32_t);
 extern uint64_t xdr_expand_hole(struct xdr_stream *, uint64_t, uint64_t);
+extern bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf,
+				  unsigned int len);
 
 /**
  * xdr_set_scratch_buffer - Attach a scratch buffer for decoding data.
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 02adc5c7f034d..722586696fade 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1412,6 +1412,51 @@ xdr_buf_subsegment(struct xdr_buf *buf, struct xdr_buf *subbuf,
 }
 EXPORT_SYMBOL_GPL(xdr_buf_subsegment);
 
+/**
+ * xdr_stream_subsegment - set @subbuf to a portion of @xdr
+ * @xdr: an xdr_stream set up for decoding
+ * @subbuf: the result buffer
+ * @nbytes: length of @xdr to extract, in bytes
+ *
+ * Sets up @subbuf to represent a portion of @xdr. The portion
+ * starts at the current offset in @xdr, and extends for a length
+ * of @nbytes. If this is successful, @xdr is advanced to the next
+ * position following that portion.
+ *
+ * Return values:
+ *   %true: @subbuf has been initialized, and @xdr has been advanced.
+ *   %false: a bounds error has occurred
+ */
+bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf,
+			   unsigned int nbytes)
+{
+	unsigned int remaining, offset, len;
+
+	if (xdr_buf_subsegment(xdr->buf, subbuf, xdr_stream_pos(xdr), nbytes))
+		return false;
+
+	if (subbuf->head[0].iov_len)
+		if (!__xdr_inline_decode(xdr, subbuf->head[0].iov_len))
+			return false;
+
+	remaining = subbuf->page_len;
+	offset = subbuf->page_base;
+	while (remaining) {
+		len = min_t(unsigned int, remaining, PAGE_SIZE) - offset;
+
+		if (xdr->p == xdr->end && !xdr_set_next_buffer(xdr))
+			return false;
+		if (!__xdr_inline_decode(xdr, len))
+			return false;
+
+		remaining -= len;
+		offset = 0;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(xdr_stream_subsegment);
+
 /**
  * xdr_buf_trim - lop at most "len" bytes off the end of "buf"
  * @buf: buf to be trimmed
-- 
2.43.0




