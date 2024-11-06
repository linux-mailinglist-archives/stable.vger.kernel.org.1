Return-Path: <stable+bounces-90373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837A99BE7FD
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982E61C235F2
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD701DF969;
	Wed,  6 Nov 2024 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BkUFBTAF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CDC1DED49;
	Wed,  6 Nov 2024 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895580; cv=none; b=PEsXIHVuJ0yNS40XyS3jjL+PNHyCxLNMJL+srMLMyhZYhJ1AcKBJ5QcflqQ13eSxhQoJ75Jel2s1vnS42/yuerd5ZMnqgC0whzQGMg7ai8TAYambqDRny4QNGEqmRc+2XQe6kmUCwdKmoGGFopuCFyelakz+R2z3aUUWsGawVuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895580; c=relaxed/simple;
	bh=CsVwJiEbcwdy9f9sWg4RTm6HCdxm4siIfLtjhbYtxrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4qjzeE5Ull7aeuCcAEFj91rrT/KC3ivSqz3PaAVMvga3qKmkR+xOWp9BIIZQ29jD8hdqCgIwCxBXrMxBnb3fdg7W8K3I4rERKy54Z/bcEgW3WZhziP/aR+b1po3APvXMXDw2/obXVg/PPHQUBm6FT9c7QNNcDpH7tozbapJSXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BkUFBTAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF59CC4CECD;
	Wed,  6 Nov 2024 12:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895579;
	bh=CsVwJiEbcwdy9f9sWg4RTm6HCdxm4siIfLtjhbYtxrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkUFBTAF1sCo9PjgI2edCXRdWy/nxJsSSAmXCsjPoUSttqTHunHQZrw4miM3/b+SR
	 M1zBju0hVNV3eELdnign+/6zzAeZeYMDKXfMiBR8XSwltTk5HqkrCb0BoPQ5x55u5L
	 qw0xLWFztK3f1kAEFNlVGJbq9m3l6hr/ccrcy/Fk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 248/350] NFS: Remove print_overflow_msg()
Date: Wed,  6 Nov 2024 13:02:56 +0100
Message-ID: <20241106120327.052295904@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit eb72f484a5eb94c53a241e6a7811270fb25200ad ]

This issue is now captured by a trace point in the RPC client.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Stable-dep-of: 6dbf1f341b6b ("SUNRPC: Fix integer overflow in decode_rc_list()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/clnt4xdr.c    |  14 --
 fs/lockd/clntxdr.c     |  14 --
 fs/nfs/callback_xdr.c  |  59 +++---
 fs/nfs/nfs2xdr.c       |  84 +++-----
 fs/nfs/nfs3xdr.c       | 163 +++++----------
 fs/nfs/nfs42xdr.c      |  21 +-
 fs/nfs/nfs4xdr.c       | 451 +++++++++++------------------------------
 fs/nfsd/nfs4callback.c |  13 --
 8 files changed, 219 insertions(+), 600 deletions(-)

diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index 214a2fa1f1e39..7df6324ccb8ab 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -74,17 +74,6 @@ static void nlm4_compute_offsets(const struct nlm_lock *lock,
 		*l_len = loff_t_to_s64(fl->fl_end - fl->fl_start + 1);
 }
 
-/*
- * Handle decode buffer overflows out-of-line.
- */
-static void print_overflow_msg(const char *func, const struct xdr_stream *xdr)
-{
-	dprintk("lockd: %s prematurely hit the end of our receive buffer. "
-		"Remaining buffer length is %tu words.\n",
-		func, xdr->end - xdr->p);
-}
-
-
 /*
  * Encode/decode NLMv4 basic data types
  *
@@ -176,7 +165,6 @@ static int decode_cookie(struct xdr_stream *xdr,
 	dprintk("NFS: returned cookie was too long: %u\n", length);
 	return -EIO;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
@@ -236,7 +224,6 @@ static int decode_nlm4_stat(struct xdr_stream *xdr, __be32 *stat)
 			__func__, be32_to_cpup(p));
 	return -EIO;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
@@ -309,7 +296,6 @@ static int decode_nlm4_holder(struct xdr_stream *xdr, struct nlm_res *result)
 out:
 	return error;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
index 747b9c8c940ac..4df62f6355295 100644
--- a/fs/lockd/clntxdr.c
+++ b/fs/lockd/clntxdr.c
@@ -70,17 +70,6 @@ static void nlm_compute_offsets(const struct nlm_lock *lock,
 		*l_len = loff_t_to_s32(fl->fl_end - fl->fl_start + 1);
 }
 
-/*
- * Handle decode buffer overflows out-of-line.
- */
-static void print_overflow_msg(const char *func, const struct xdr_stream *xdr)
-{
-	dprintk("lockd: %s prematurely hit the end of our receive buffer. "
-		"Remaining buffer length is %tu words.\n",
-		func, xdr->end - xdr->p);
-}
-
-
 /*
  * Encode/decode NLMv3 basic data types
  *
@@ -173,7 +162,6 @@ static int decode_cookie(struct xdr_stream *xdr,
 	dprintk("NFS: returned cookie was too long: %u\n", length);
 	return -EIO;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
@@ -231,7 +219,6 @@ static int decode_nlm_stat(struct xdr_stream *xdr,
 		__func__, be32_to_cpup(p));
 	return -EIO;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
@@ -303,7 +290,6 @@ static int decode_nlm_holder(struct xdr_stream *xdr, struct nlm_res *result)
 out:
 	return error;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 2f84c612838c4..38dc33c537ab6 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -72,16 +72,6 @@ static int nfs4_encode_void(struct svc_rqst *rqstp, __be32 *p)
 	return xdr_ressize_check(rqstp, p);
 }
 
-static __be32 *read_buf(struct xdr_stream *xdr, size_t nbytes)
-{
-	__be32 *p;
-
-	p = xdr_inline_decode(xdr, nbytes);
-	if (unlikely(p == NULL))
-		printk(KERN_WARNING "NFS: NFSv4 callback reply buffer overflowed!\n");
-	return p;
-}
-
 static __be32 decode_string(struct xdr_stream *xdr, unsigned int *len,
 		const char **str, size_t maxlen)
 {
@@ -98,13 +88,13 @@ static __be32 decode_fh(struct xdr_stream *xdr, struct nfs_fh *fh)
 {
 	__be32 *p;
 
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 	fh->size = ntohl(*p);
 	if (fh->size > NFS4_FHSIZE)
 		return htonl(NFS4ERR_BADHANDLE);
-	p = read_buf(xdr, fh->size);
+	p = xdr_inline_decode(xdr, fh->size);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 	memcpy(&fh->data[0], p, fh->size);
@@ -117,11 +107,11 @@ static __be32 decode_bitmap(struct xdr_stream *xdr, uint32_t *bitmap)
 	__be32 *p;
 	unsigned int attrlen;
 
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 	attrlen = ntohl(*p);
-	p = read_buf(xdr, attrlen << 2);
+	p = xdr_inline_decode(xdr, attrlen << 2);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 	if (likely(attrlen > 0))
@@ -135,7 +125,7 @@ static __be32 decode_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
 {
 	__be32 *p;
 
-	p = read_buf(xdr, NFS4_STATEID_SIZE);
+	p = xdr_inline_decode(xdr, NFS4_STATEID_SIZE);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 	memcpy(stateid->data, p, NFS4_STATEID_SIZE);
@@ -156,7 +146,7 @@ static __be32 decode_compound_hdr_arg(struct xdr_stream *xdr, struct cb_compound
 	status = decode_string(xdr, &hdr->taglen, &hdr->tag, CB_OP_TAGLEN_MAXSZ);
 	if (unlikely(status != 0))
 		return status;
-	p = read_buf(xdr, 12);
+	p = xdr_inline_decode(xdr, 12);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 	hdr->minorversion = ntohl(*p++);
@@ -176,7 +166,7 @@ static __be32 decode_compound_hdr_arg(struct xdr_stream *xdr, struct cb_compound
 static __be32 decode_op_hdr(struct xdr_stream *xdr, unsigned int *op)
 {
 	__be32 *p;
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE_HDR);
 	*op = ntohl(*p);
@@ -205,7 +195,7 @@ static __be32 decode_recall_args(struct svc_rqst *rqstp,
 	status = decode_delegation_stateid(xdr, &args->stateid);
 	if (unlikely(status != 0))
 		return status;
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 	args->truncate = ntohl(*p);
@@ -227,7 +217,7 @@ static __be32 decode_layoutrecall_args(struct svc_rqst *rqstp,
 	__be32 status = 0;
 	uint32_t iomode;
 
-	p = read_buf(xdr, 4 * sizeof(uint32_t));
+	p = xdr_inline_decode(xdr, 4 * sizeof(uint32_t));
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_BADXDR);
 
@@ -245,14 +235,14 @@ static __be32 decode_layoutrecall_args(struct svc_rqst *rqstp,
 		if (unlikely(status != 0))
 			return status;
 
-		p = read_buf(xdr, 2 * sizeof(uint64_t));
+		p = xdr_inline_decode(xdr, 2 * sizeof(uint64_t));
 		if (unlikely(p == NULL))
 			return htonl(NFS4ERR_BADXDR);
 		p = xdr_decode_hyper(p, &args->cbl_range.offset);
 		p = xdr_decode_hyper(p, &args->cbl_range.length);
 		return decode_layout_stateid(xdr, &args->cbl_stateid);
 	} else if (args->cbl_recall_type == RETURN_FSID) {
-		p = read_buf(xdr, 2 * sizeof(uint64_t));
+		p = xdr_inline_decode(xdr, 2 * sizeof(uint64_t));
 		if (unlikely(p == NULL))
 			return htonl(NFS4ERR_BADXDR);
 		p = xdr_decode_hyper(p, &args->cbl_fsid.major);
@@ -273,7 +263,7 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 	__be32 status = 0;
 
 	/* Num of device notifications */
-	p = read_buf(xdr, sizeof(uint32_t));
+	p = xdr_inline_decode(xdr, sizeof(uint32_t));
 	if (unlikely(p == NULL)) {
 		status = htonl(NFS4ERR_BADXDR);
 		goto out;
@@ -292,7 +282,8 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 	for (i = 0; i < n; i++) {
 		struct cb_devicenotifyitem *dev = &args->devs[i];
 
-		p = read_buf(xdr, (4 * sizeof(uint32_t)) + NFS4_DEVICEID4_SIZE);
+		p = xdr_inline_decode(xdr, (4 * sizeof(uint32_t)) +
+				      NFS4_DEVICEID4_SIZE);
 		if (unlikely(p == NULL)) {
 			status = htonl(NFS4ERR_BADXDR);
 			goto err;
@@ -323,7 +314,7 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 		p += XDR_QUADLEN(NFS4_DEVICEID4_SIZE);
 
 		if (dev->cbd_layout_type == NOTIFY_DEVICEID4_CHANGE) {
-			p = read_buf(xdr, sizeof(uint32_t));
+			p = xdr_inline_decode(xdr, sizeof(uint32_t));
 			if (unlikely(p == NULL)) {
 				status = htonl(NFS4ERR_BADXDR);
 				goto err;
@@ -355,7 +346,7 @@ static __be32 decode_sessionid(struct xdr_stream *xdr,
 {
 	__be32 *p;
 
-	p = read_buf(xdr, NFS4_MAX_SESSIONID_LEN);
+	p = xdr_inline_decode(xdr, NFS4_MAX_SESSIONID_LEN);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 
@@ -375,13 +366,13 @@ static __be32 decode_rc_list(struct xdr_stream *xdr,
 		goto out;
 
 	status = htonl(NFS4ERR_RESOURCE);
-	p = read_buf(xdr, sizeof(uint32_t));
+	p = xdr_inline_decode(xdr, sizeof(uint32_t));
 	if (unlikely(p == NULL))
 		goto out;
 
 	rc_list->rcl_nrefcalls = ntohl(*p++);
 	if (rc_list->rcl_nrefcalls) {
-		p = read_buf(xdr,
+		p = xdr_inline_decode(xdr,
 			     rc_list->rcl_nrefcalls * 2 * sizeof(uint32_t));
 		if (unlikely(p == NULL))
 			goto out;
@@ -414,7 +405,7 @@ static __be32 decode_cb_sequence_args(struct svc_rqst *rqstp,
 	if (status)
 		return status;
 
-	p = read_buf(xdr, 5 * sizeof(uint32_t));
+	p = xdr_inline_decode(xdr, 5 * sizeof(uint32_t));
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
 
@@ -457,7 +448,7 @@ static __be32 decode_recallany_args(struct svc_rqst *rqstp,
 	uint32_t bitmap[2];
 	__be32 *p, status;
 
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_BADXDR);
 	args->craa_objs_to_keep = ntohl(*p++);
@@ -476,7 +467,7 @@ static __be32 decode_recallslot_args(struct svc_rqst *rqstp,
 	struct cb_recallslotargs *args = argp;
 	__be32 *p;
 
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_BADXDR);
 	args->crsa_target_highest_slotid = ntohl(*p++);
@@ -488,14 +479,14 @@ static __be32 decode_lockowner(struct xdr_stream *xdr, struct cb_notify_lock_arg
 	__be32		*p;
 	unsigned int	len;
 
-	p = read_buf(xdr, 12);
+	p = xdr_inline_decode(xdr, 12);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_BADXDR);
 
 	p = xdr_decode_hyper(p, &args->cbnl_owner.clientid);
 	len = be32_to_cpu(*p);
 
-	p = read_buf(xdr, len);
+	p = xdr_inline_decode(xdr, len);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_BADXDR);
 
@@ -533,7 +524,7 @@ static __be32 decode_write_response(struct xdr_stream *xdr,
 	__be32 *p;
 
 	/* skip the always zero field */
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
 		goto out;
 	p++;
@@ -573,7 +564,7 @@ static __be32 decode_offload_args(struct svc_rqst *rqstp,
 		return status;
 
 	/* decode status */
-	p = read_buf(xdr, 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
 		goto out;
 	args->error = ntohl(*p++);
diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 040a05f0e61ef..6968d6ffe84fa 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -79,17 +79,6 @@ static void prepare_reply_buffer(struct rpc_rqst *req, struct page **pages,
 	xdr_inline_pages(&req->rq_rcv_buf, replen << 2, pages, base, len);
 }
 
-/*
- * Handle decode buffer overflows out-of-line.
- */
-static void print_overflow_msg(const char *func, const struct xdr_stream *xdr)
-{
-	dprintk("NFS: %s prematurely hit the end of our receive buffer. "
-		"Remaining buffer length is %tu words.\n",
-		func, xdr->end - xdr->p);
-}
-
-
 /*
  * Encode/decode NFSv2 basic data types
  *
@@ -110,8 +99,8 @@ static int decode_nfsdata(struct xdr_stream *xdr, struct nfs_pgio_res *result)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	count = be32_to_cpup(p);
 	recvd = xdr_read_pages(xdr, count);
 	if (unlikely(count > recvd))
@@ -125,9 +114,6 @@ static int decode_nfsdata(struct xdr_stream *xdr, struct nfs_pgio_res *result)
 		"count %u > recvd %u\n", count, recvd);
 	count = recvd;
 	goto out;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -157,13 +143,10 @@ static int decode_stat(struct xdr_stream *xdr, enum nfs_stat *status)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	*status = be32_to_cpup(p);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -205,14 +188,11 @@ static int decode_fhandle(struct xdr_stream *xdr, struct nfs_fh *fh)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, NFS2_FHSIZE);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	fh->size = NFS2_FHSIZE;
 	memcpy(fh->data, p, NFS2_FHSIZE);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -282,8 +262,8 @@ static int decode_fattr(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, NFS_fattr_sz << 2);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 
 	fattr->valid |= NFS_ATTR_FATTR_V2;
 
@@ -325,9 +305,6 @@ static int decode_fattr(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 out_gid:
 	dprintk("NFS: returned invalid gid\n");
 	return -EINVAL;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -416,23 +393,20 @@ static int decode_filename_inline(struct xdr_stream *xdr,
 	u32 count;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	count = be32_to_cpup(p);
 	if (count > NFS3_MAXNAMLEN)
 		goto out_nametoolong;
 	p = xdr_inline_decode(xdr, count);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	*name = (const char *)p;
 	*length = count;
 	return 0;
 out_nametoolong:
 	dprintk("NFS: returned filename too long: %u\n", count);
 	return -ENAMETOOLONG;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -455,8 +429,8 @@ static int decode_path(struct xdr_stream *xdr)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	length = be32_to_cpup(p);
 	if (unlikely(length >= xdr->buf->page_len || length > NFS_MAXPATHLEN))
 		goto out_size;
@@ -472,9 +446,6 @@ static int decode_path(struct xdr_stream *xdr)
 	dprintk("NFS: server cheating in pathname result: "
 		"length %u > received %u\n", length, recvd);
 	return -EIO;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -951,12 +922,12 @@ int nfs2_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	int error;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EAGAIN;
 	if (*p++ == xdr_zero) {
 		p = xdr_inline_decode(xdr, 4);
-		if (unlikely(p == NULL))
-			goto out_overflow;
+		if (unlikely(!p))
+			return -EAGAIN;
 		if (*p++ == xdr_zero)
 			return -EAGAIN;
 		entry->eof = 1;
@@ -964,8 +935,8 @@ int nfs2_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	}
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EAGAIN;
 	entry->ino = be32_to_cpup(p);
 
 	error = decode_filename_inline(xdr, &entry->name, &entry->len);
@@ -978,17 +949,13 @@ int nfs2_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	 */
 	entry->prev_cookie = entry->cookie;
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EAGAIN;
 	entry->cookie = be32_to_cpup(p);
 
 	entry->d_type = DT_UNKNOWN;
 
 	return 0;
-
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EAGAIN;
 }
 
 /*
@@ -1052,17 +1019,14 @@ static int decode_info(struct xdr_stream *xdr, struct nfs2_fsstat *result)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, NFS_info_sz << 2);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	result->tsize  = be32_to_cpup(p++);
 	result->bsize  = be32_to_cpup(p++);
 	result->blocks = be32_to_cpup(p++);
 	result->bfree  = be32_to_cpup(p++);
 	result->bavail = be32_to_cpup(p);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int nfs2_xdr_dec_statfsres(struct rpc_rqst *req, struct xdr_stream *xdr,
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 0ed419bb02b0f..ebe7d1ce00e39 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -119,17 +119,6 @@ static void prepare_reply_buffer(struct rpc_rqst *req, struct page **pages,
 	xdr_inline_pages(&req->rq_rcv_buf, replen << 2, pages, base, len);
 }
 
-/*
- * Handle decode buffer overflows out-of-line.
- */
-static void print_overflow_msg(const char *func, const struct xdr_stream *xdr)
-{
-	dprintk("NFS: %s prematurely hit the end of our receive buffer. "
-		"Remaining buffer length is %tu words.\n",
-		func, xdr->end - xdr->p);
-}
-
-
 /*
  * Encode/decode NFSv3 basic data types
  *
@@ -152,13 +141,10 @@ static int decode_uint32(struct xdr_stream *xdr, u32 *value)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	*value = be32_to_cpup(p);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_uint64(struct xdr_stream *xdr, u64 *value)
@@ -166,13 +152,10 @@ static int decode_uint64(struct xdr_stream *xdr, u64 *value)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 8);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	xdr_decode_hyper(p, value);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -212,14 +195,14 @@ static int decode_inline_filename3(struct xdr_stream *xdr,
 	u32 count;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	count = be32_to_cpup(p);
 	if (count > NFS3_MAXNAMLEN)
 		goto out_nametoolong;
 	p = xdr_inline_decode(xdr, count);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	*name = (const char *)p;
 	*length = count;
 	return 0;
@@ -227,9 +210,6 @@ static int decode_inline_filename3(struct xdr_stream *xdr,
 out_nametoolong:
 	dprintk("NFS: returned filename too long: %u\n", count);
 	return -ENAMETOOLONG;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -250,8 +230,8 @@ static int decode_nfspath3(struct xdr_stream *xdr)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	count = be32_to_cpup(p);
 	if (unlikely(count >= xdr->buf->page_len || count > NFS3_MAXPATHLEN))
 		goto out_nametoolong;
@@ -268,9 +248,6 @@ static int decode_nfspath3(struct xdr_stream *xdr)
 	dprintk("NFS: server cheating in pathname result: "
 		"count %u > recvd %u\n", count, recvd);
 	return -EIO;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -304,13 +281,10 @@ static int decode_cookieverf3(struct xdr_stream *xdr, __be32 *verifier)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, NFS3_COOKIEVERFSIZE);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	memcpy(verifier, p, NFS3_COOKIEVERFSIZE);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -331,13 +305,10 @@ static int decode_writeverf3(struct xdr_stream *xdr, struct nfs_write_verifier *
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, NFS3_WRITEVERFSIZE);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	memcpy(verifier->data, p, NFS3_WRITEVERFSIZE);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -365,13 +336,10 @@ static int decode_nfsstat3(struct xdr_stream *xdr, enum nfs_stat *status)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	*status = be32_to_cpup(p);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -454,23 +422,20 @@ static int decode_nfs_fh3(struct xdr_stream *xdr, struct nfs_fh *fh)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	length = be32_to_cpup(p++);
 	if (unlikely(length > NFS3_FHSIZE))
 		goto out_toobig;
 	p = xdr_inline_decode(xdr, length);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	fh->size = length;
 	memcpy(fh->data, p, length);
 	return 0;
 out_toobig:
 	dprintk("NFS: file handle size (%u) too big\n", length);
 	return -E2BIG;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static void zero_nfs_fh3(struct nfs_fh *fh)
@@ -656,8 +621,8 @@ static int decode_fattr3(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, NFS3_fattr_sz << 2);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 
 	p = xdr_decode_ftype3(p, &fmode);
 
@@ -691,9 +656,6 @@ static int decode_fattr3(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 out_gid:
 	dprintk("NFS: returned invalid gid\n");
 	return -EINVAL;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -711,14 +673,11 @@ static int decode_post_op_attr(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	if (*p != xdr_zero)
 		return decode_fattr3(xdr, fattr);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -734,8 +693,8 @@ static int decode_wcc_attr(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, NFS3_wcc_attr_sz << 2);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 
 	fattr->valid |= NFS_ATTR_FATTR_PRESIZE
 		| NFS_ATTR_FATTR_PRECHANGE
@@ -748,9 +707,6 @@ static int decode_wcc_attr(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 	fattr->pre_change_attr = nfs_timespec_to_change_attr(&fattr->pre_ctime);
 
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -774,14 +730,11 @@ static int decode_pre_op_attr(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	if (*p != xdr_zero)
 		return decode_wcc_attr(xdr, fattr);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_wcc_data(struct xdr_stream *xdr, struct nfs_fattr *fattr)
@@ -809,15 +762,12 @@ static int decode_wcc_data(struct xdr_stream *xdr, struct nfs_fattr *fattr)
 static int decode_post_op_fh3(struct xdr_stream *xdr, struct nfs_fh *fh)
 {
 	__be32 *p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	if (*p != xdr_zero)
 		return decode_nfs_fh3(xdr, fh);
 	zero_nfs_fh3(fh);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -1641,8 +1591,8 @@ static int decode_read3resok(struct xdr_stream *xdr,
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4 + 4 + 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	count = be32_to_cpup(p++);
 	eof = be32_to_cpup(p++);
 	ocount = be32_to_cpup(p++);
@@ -1665,9 +1615,6 @@ static int decode_read3resok(struct xdr_stream *xdr,
 	count = recvd;
 	eof = 0;
 	goto out;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int nfs3_xdr_dec_read3res(struct rpc_rqst *req, struct xdr_stream *xdr,
@@ -1726,22 +1673,18 @@ static int decode_write3resok(struct xdr_stream *xdr,
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4 + 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	result->count = be32_to_cpup(p++);
 	result->verf->committed = be32_to_cpup(p++);
 	if (unlikely(result->verf->committed > NFS_FILE_SYNC))
 		goto out_badvalue;
 	if (decode_writeverf3(xdr, &result->verf->verifier))
-		goto out_eio;
+		return -EIO;
 	return result->count;
 out_badvalue:
 	dprintk("NFS: bad stable_how value: %u\n", result->verf->committed);
 	return -EIO;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-out_eio:
-	return -EIO;
 }
 
 static int nfs3_xdr_dec_write3res(struct rpc_rqst *req, struct xdr_stream *xdr,
@@ -2005,12 +1948,12 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	u64 new_cookie;
 
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EAGAIN;
 	if (*p == xdr_zero) {
 		p = xdr_inline_decode(xdr, 4);
-		if (unlikely(p == NULL))
-			goto out_overflow;
+		if (unlikely(!p))
+			return -EAGAIN;
 		if (*p == xdr_zero)
 			return -EAGAIN;
 		entry->eof = 1;
@@ -2046,8 +1989,8 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 		/* In fact, a post_op_fh3: */
 		p = xdr_inline_decode(xdr, 4);
-		if (unlikely(p == NULL))
-			goto out_overflow;
+		if (unlikely(!p))
+			return -EAGAIN;
 		if (*p != xdr_zero) {
 			error = decode_nfs_fh3(xdr, entry->fh);
 			if (unlikely(error)) {
@@ -2064,9 +2007,6 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 	return 0;
 
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EAGAIN;
 out_truncated:
 	dprintk("NFS: directory entry contains invalid file handle\n");
 	*entry = old;
@@ -2178,8 +2118,8 @@ static int decode_fsstat3resok(struct xdr_stream *xdr,
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 8 * 6 + 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	p = xdr_decode_size3(p, &result->tbytes);
 	p = xdr_decode_size3(p, &result->fbytes);
 	p = xdr_decode_size3(p, &result->abytes);
@@ -2188,9 +2128,6 @@ static int decode_fsstat3resok(struct xdr_stream *xdr,
 	xdr_decode_size3(p, &result->afiles);
 	/* ignore invarsec */
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int nfs3_xdr_dec_fsstat3res(struct rpc_rqst *req,
@@ -2250,8 +2187,8 @@ static int decode_fsinfo3resok(struct xdr_stream *xdr,
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4 * 7 + 8 + 8 + 4);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	result->rtmax  = be32_to_cpup(p++);
 	result->rtpref = be32_to_cpup(p++);
 	result->rtmult = be32_to_cpup(p++);
@@ -2265,9 +2202,6 @@ static int decode_fsinfo3resok(struct xdr_stream *xdr,
 	/* ignore properties */
 	result->lease_time = 0;
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int nfs3_xdr_dec_fsinfo3res(struct rpc_rqst *req,
@@ -2323,15 +2257,12 @@ static int decode_pathconf3resok(struct xdr_stream *xdr,
 	__be32 *p;
 
 	p = xdr_inline_decode(xdr, 4 * 6);
-	if (unlikely(p == NULL))
-		goto out_overflow;
+	if (unlikely(!p))
+		return -EIO;
 	result->max_link = be32_to_cpup(p++);
 	result->max_namelen = be32_to_cpup(p);
 	/* ignore remaining fields */
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int nfs3_xdr_dec_pathconf3res(struct rpc_rqst *req,
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index eee011de3f58b..d66e1025b4a4c 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -404,7 +404,7 @@ static int decode_write_response(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	count = be32_to_cpup(p);
 	if (count > 1)
 		return -EREMOTEIO;
@@ -412,18 +412,14 @@ static int decode_write_response(struct xdr_stream *xdr,
 		status = decode_opaque_fixed(xdr, &res->stateid,
 				NFS4_STATEID_SIZE);
 		if (unlikely(status))
-			goto out_overflow;
+			return -EIO;
 	}
 	p = xdr_inline_decode(xdr, 8 + 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	p = xdr_decode_hyper(p, &res->count);
 	res->verifier.committed = be32_to_cpup(p);
 	return decode_verifier(xdr, &res->verifier.verifier);
-
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_copy_requirements(struct xdr_stream *xdr,
@@ -432,14 +428,11 @@ static int decode_copy_requirements(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 4 + 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 
 	res->consecutive = be32_to_cpup(p++);
 	res->synchronous = be32_to_cpup(p++);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_copy(struct xdr_stream *xdr, struct nfs42_copy_res *res)
@@ -484,15 +477,11 @@ static int decode_seek(struct xdr_stream *xdr, struct nfs42_seek_res *res)
 
 	p = xdr_inline_decode(xdr, 4 + 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 
 	res->sr_eof = be32_to_cpup(p++);
 	p = xdr_decode_hyper(p, &res->sr_offset);
 	return 0;
-
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_layoutstats(struct xdr_stream *xdr)
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index f0021e3b8efdd..767448b015cff 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -3144,22 +3144,12 @@ static void nfs4_xdr_enc_free_stateid(struct rpc_rqst *req,
 }
 #endif /* CONFIG_NFS_V4_1 */
 
-static void print_overflow_msg(const char *func, const struct xdr_stream *xdr)
-{
-	dprintk("nfs: %s: prematurely hit end of receive buffer. "
-		"Remaining buffer length is %tu words.\n",
-		func, xdr->end - xdr->p);
-}
-
 static int decode_opaque_inline(struct xdr_stream *xdr, unsigned int *len, char **string)
 {
 	ssize_t ret = xdr_stream_decode_opaque_inline(xdr, (void **)string,
 			NFS4_OPAQUE_LIMIT);
-	if (unlikely(ret < 0)) {
-		if (ret == -EBADMSG)
-			print_overflow_msg(__func__, xdr);
+	if (unlikely(ret < 0))
 		return -EIO;
-	}
 	*len = ret;
 	return 0;
 }
@@ -3170,22 +3160,19 @@ static int decode_compound_hdr(struct xdr_stream *xdr, struct compound_hdr *hdr)
 
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	hdr->status = be32_to_cpup(p++);
 	hdr->taglen = be32_to_cpup(p);
 
 	p = xdr_inline_decode(xdr, hdr->taglen + 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	hdr->tag = (char *)p;
 	p += XDR_QUADLEN(hdr->taglen);
 	hdr->nops = be32_to_cpup(p);
 	if (unlikely(hdr->nops < 1))
 		return nfs4_stat_to_errno(hdr->status);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static bool __decode_op_hdr(struct xdr_stream *xdr, enum nfs_opnum4 expected,
@@ -3214,7 +3201,6 @@ static bool __decode_op_hdr(struct xdr_stream *xdr, enum nfs_opnum4 expected,
 	*nfs_retval = -EREMOTEIO;
 	return false;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	*nfs_retval = -EIO;
 	return false;
 }
@@ -3235,10 +3221,9 @@ static int decode_ace(struct xdr_stream *xdr, void *ace)
 	char *str;
 
 	p = xdr_inline_decode(xdr, 12);
-	if (likely(p))
-		return decode_opaque_inline(xdr, &strlen, &str);
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
+	if (unlikely(!p))
+		return -EIO;
+	return decode_opaque_inline(xdr, &strlen, &str);
 }
 
 static ssize_t
@@ -3249,10 +3234,9 @@ decode_bitmap4(struct xdr_stream *xdr, uint32_t *bitmap, size_t sz)
 	ret = xdr_stream_decode_uint32_array(xdr, bitmap, sz);
 	if (likely(ret >= 0))
 		return ret;
-	if (ret == -EMSGSIZE)
-		return sz;
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
+	if (ret != -EMSGSIZE)
+		return -EIO;
+	return sz;
 }
 
 static int decode_attr_bitmap(struct xdr_stream *xdr, uint32_t *bitmap)
@@ -3268,13 +3252,10 @@ static int decode_attr_length(struct xdr_stream *xdr, uint32_t *attrlen, unsigne
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	*attrlen = be32_to_cpup(p);
 	*savep = xdr_stream_pos(xdr);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_supported(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *bitmask)
@@ -3303,7 +3284,7 @@ static int decode_attr_type(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *
 	if (likely(bitmap[0] & FATTR4_WORD0_TYPE)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*type = be32_to_cpup(p);
 		if (*type < NF4REG || *type > NF4NAMEDATTR) {
 			dprintk("%s: bad type %d\n", __func__, *type);
@@ -3314,9 +3295,6 @@ static int decode_attr_type(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *
 	}
 	dprintk("%s: type=0%o\n", __func__, nfs_type2fmt[*type]);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_fh_expire_type(struct xdr_stream *xdr,
@@ -3330,15 +3308,12 @@ static int decode_attr_fh_expire_type(struct xdr_stream *xdr,
 	if (likely(bitmap[0] & FATTR4_WORD0_FH_EXPIRE_TYPE)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*type = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_FH_EXPIRE_TYPE;
 	}
 	dprintk("%s: expire type=0x%x\n", __func__, *type);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_change(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *change)
@@ -3352,7 +3327,7 @@ static int decode_attr_change(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t
 	if (likely(bitmap[0] & FATTR4_WORD0_CHANGE)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, change);
 		bitmap[0] &= ~FATTR4_WORD0_CHANGE;
 		ret = NFS_ATTR_FATTR_CHANGE;
@@ -3360,9 +3335,6 @@ static int decode_attr_change(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t
 	dprintk("%s: change attribute=%Lu\n", __func__,
 			(unsigned long long)*change);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_size(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *size)
@@ -3376,16 +3348,13 @@ static int decode_attr_size(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *
 	if (likely(bitmap[0] & FATTR4_WORD0_SIZE)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, size);
 		bitmap[0] &= ~FATTR4_WORD0_SIZE;
 		ret = NFS_ATTR_FATTR_SIZE;
 	}
 	dprintk("%s: file size=%Lu\n", __func__, (unsigned long long)*size);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_link_support(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
@@ -3398,15 +3367,12 @@ static int decode_attr_link_support(struct xdr_stream *xdr, uint32_t *bitmap, ui
 	if (likely(bitmap[0] & FATTR4_WORD0_LINK_SUPPORT)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*res = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_LINK_SUPPORT;
 	}
 	dprintk("%s: link support=%s\n", __func__, *res == 0 ? "false" : "true");
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_symlink_support(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
@@ -3419,15 +3385,12 @@ static int decode_attr_symlink_support(struct xdr_stream *xdr, uint32_t *bitmap,
 	if (likely(bitmap[0] & FATTR4_WORD0_SYMLINK_SUPPORT)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*res = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_SYMLINK_SUPPORT;
 	}
 	dprintk("%s: symlink support=%s\n", __func__, *res == 0 ? "false" : "true");
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_fsid(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs_fsid *fsid)
@@ -3442,7 +3405,7 @@ static int decode_attr_fsid(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs
 	if (likely(bitmap[0] & FATTR4_WORD0_FSID)) {
 		p = xdr_inline_decode(xdr, 16);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		p = xdr_decode_hyper(p, &fsid->major);
 		xdr_decode_hyper(p, &fsid->minor);
 		bitmap[0] &= ~FATTR4_WORD0_FSID;
@@ -3452,9 +3415,6 @@ static int decode_attr_fsid(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs
 			(unsigned long long)fsid->major,
 			(unsigned long long)fsid->minor);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_lease_time(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
@@ -3467,15 +3427,12 @@ static int decode_attr_lease_time(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	if (likely(bitmap[0] & FATTR4_WORD0_LEASE_TIME)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*res = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_LEASE_TIME;
 	}
 	dprintk("%s: file size=%u\n", __func__, (unsigned int)*res);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_error(struct xdr_stream *xdr, uint32_t *bitmap, int32_t *res)
@@ -3487,14 +3444,11 @@ static int decode_attr_error(struct xdr_stream *xdr, uint32_t *bitmap, int32_t *
 	if (likely(bitmap[0] & FATTR4_WORD0_RDATTR_ERROR)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		bitmap[0] &= ~FATTR4_WORD0_RDATTR_ERROR;
 		*res = -be32_to_cpup(p);
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_exclcreat_supported(struct xdr_stream *xdr,
@@ -3526,13 +3480,13 @@ static int decode_attr_filehandle(struct xdr_stream *xdr, uint32_t *bitmap, stru
 	if (likely(bitmap[0] & FATTR4_WORD0_FILEHANDLE)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		len = be32_to_cpup(p);
 		if (len > NFS4_FHSIZE)
 			return -EIO;
 		p = xdr_inline_decode(xdr, len);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		if (fh != NULL) {
 			memcpy(fh->data, p, len);
 			fh->size = len;
@@ -3540,9 +3494,6 @@ static int decode_attr_filehandle(struct xdr_stream *xdr, uint32_t *bitmap, stru
 		bitmap[0] &= ~FATTR4_WORD0_FILEHANDLE;
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_aclsupport(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
@@ -3555,15 +3506,12 @@ static int decode_attr_aclsupport(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	if (likely(bitmap[0] & FATTR4_WORD0_ACLSUPPORT)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*res = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_ACLSUPPORT;
 	}
 	dprintk("%s: ACLs supported=%u\n", __func__, (unsigned int)*res);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_fileid(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *fileid)
@@ -3577,16 +3525,13 @@ static int decode_attr_fileid(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t
 	if (likely(bitmap[0] & FATTR4_WORD0_FILEID)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, fileid);
 		bitmap[0] &= ~FATTR4_WORD0_FILEID;
 		ret = NFS_ATTR_FATTR_FILEID;
 	}
 	dprintk("%s: fileid=%Lu\n", __func__, (unsigned long long)*fileid);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_mounted_on_fileid(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *fileid)
@@ -3600,16 +3545,13 @@ static int decode_attr_mounted_on_fileid(struct xdr_stream *xdr, uint32_t *bitma
 	if (likely(bitmap[1] & FATTR4_WORD1_MOUNTED_ON_FILEID)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, fileid);
 		bitmap[1] &= ~FATTR4_WORD1_MOUNTED_ON_FILEID;
 		ret = NFS_ATTR_FATTR_MOUNTED_ON_FILEID;
 	}
 	dprintk("%s: fileid=%Lu\n", __func__, (unsigned long long)*fileid);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_files_avail(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
@@ -3623,15 +3565,12 @@ static int decode_attr_files_avail(struct xdr_stream *xdr, uint32_t *bitmap, uin
 	if (likely(bitmap[0] & FATTR4_WORD0_FILES_AVAIL)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 		bitmap[0] &= ~FATTR4_WORD0_FILES_AVAIL;
 	}
 	dprintk("%s: files avail=%Lu\n", __func__, (unsigned long long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_files_free(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
@@ -3645,15 +3584,12 @@ static int decode_attr_files_free(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	if (likely(bitmap[0] & FATTR4_WORD0_FILES_FREE)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 		bitmap[0] &= ~FATTR4_WORD0_FILES_FREE;
 	}
 	dprintk("%s: files free=%Lu\n", __func__, (unsigned long long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_files_total(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
@@ -3667,15 +3603,12 @@ static int decode_attr_files_total(struct xdr_stream *xdr, uint32_t *bitmap, uin
 	if (likely(bitmap[0] & FATTR4_WORD0_FILES_TOTAL)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 		bitmap[0] &= ~FATTR4_WORD0_FILES_TOTAL;
 	}
 	dprintk("%s: files total=%Lu\n", __func__, (unsigned long long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_pathname(struct xdr_stream *xdr, struct nfs4_pathname *path)
@@ -3686,7 +3619,7 @@ static int decode_pathname(struct xdr_stream *xdr, struct nfs4_pathname *path)
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	n = be32_to_cpup(p);
 	if (n == 0)
 		goto root_path;
@@ -3718,9 +3651,6 @@ static int decode_pathname(struct xdr_stream *xdr, struct nfs4_pathname *path)
 	dprintk(" status %d", status);
 	status = -EIO;
 	goto out;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_fs_locations(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs4_fs_locations *res)
@@ -3745,7 +3675,7 @@ static int decode_attr_fs_locations(struct xdr_stream *xdr, uint32_t *bitmap, st
 		goto out;
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		goto out_eio;
 	n = be32_to_cpup(p);
 	for (res->nlocations = 0; res->nlocations < n; res->nlocations++) {
 		u32 m;
@@ -3756,7 +3686,7 @@ static int decode_attr_fs_locations(struct xdr_stream *xdr, uint32_t *bitmap, st
 		loc = &res->locations[res->nlocations];
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			goto out_eio;
 		m = be32_to_cpup(p);
 
 		dprintk("%s: servers:\n", __func__);
@@ -3794,8 +3724,6 @@ static int decode_attr_fs_locations(struct xdr_stream *xdr, uint32_t *bitmap, st
 out:
 	dprintk("%s: fs_locations done, error = %d\n", __func__, status);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
 out_eio:
 	status = -EIO;
 	goto out;
@@ -3812,15 +3740,12 @@ static int decode_attr_maxfilesize(struct xdr_stream *xdr, uint32_t *bitmap, uin
 	if (likely(bitmap[0] & FATTR4_WORD0_MAXFILESIZE)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 		bitmap[0] &= ~FATTR4_WORD0_MAXFILESIZE;
 	}
 	dprintk("%s: maxfilesize=%Lu\n", __func__, (unsigned long long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_maxlink(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *maxlink)
@@ -3834,15 +3759,12 @@ static int decode_attr_maxlink(struct xdr_stream *xdr, uint32_t *bitmap, uint32_
 	if (likely(bitmap[0] & FATTR4_WORD0_MAXLINK)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*maxlink = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_MAXLINK;
 	}
 	dprintk("%s: maxlink=%u\n", __func__, *maxlink);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_maxname(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *maxname)
@@ -3856,15 +3778,12 @@ static int decode_attr_maxname(struct xdr_stream *xdr, uint32_t *bitmap, uint32_
 	if (likely(bitmap[0] & FATTR4_WORD0_MAXNAME)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*maxname = be32_to_cpup(p);
 		bitmap[0] &= ~FATTR4_WORD0_MAXNAME;
 	}
 	dprintk("%s: maxname=%u\n", __func__, *maxname);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_maxread(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
@@ -3879,7 +3798,7 @@ static int decode_attr_maxread(struct xdr_stream *xdr, uint32_t *bitmap, uint32_
 		uint64_t maxread;
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, &maxread);
 		if (maxread > 0x7FFFFFFF)
 			maxread = 0x7FFFFFFF;
@@ -3888,9 +3807,6 @@ static int decode_attr_maxread(struct xdr_stream *xdr, uint32_t *bitmap, uint32_
 	}
 	dprintk("%s: maxread=%lu\n", __func__, (unsigned long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_maxwrite(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
@@ -3905,7 +3821,7 @@ static int decode_attr_maxwrite(struct xdr_stream *xdr, uint32_t *bitmap, uint32
 		uint64_t maxwrite;
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, &maxwrite);
 		if (maxwrite > 0x7FFFFFFF)
 			maxwrite = 0x7FFFFFFF;
@@ -3914,9 +3830,6 @@ static int decode_attr_maxwrite(struct xdr_stream *xdr, uint32_t *bitmap, uint32
 	}
 	dprintk("%s: maxwrite=%lu\n", __func__, (unsigned long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_mode(struct xdr_stream *xdr, uint32_t *bitmap, umode_t *mode)
@@ -3931,7 +3844,7 @@ static int decode_attr_mode(struct xdr_stream *xdr, uint32_t *bitmap, umode_t *m
 	if (likely(bitmap[1] & FATTR4_WORD1_MODE)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		tmp = be32_to_cpup(p);
 		*mode = tmp & ~S_IFMT;
 		bitmap[1] &= ~FATTR4_WORD1_MODE;
@@ -3939,9 +3852,6 @@ static int decode_attr_mode(struct xdr_stream *xdr, uint32_t *bitmap, umode_t *m
 	}
 	dprintk("%s: file mode=0%o\n", __func__, (unsigned int)*mode);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_nlink(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *nlink)
@@ -3955,16 +3865,13 @@ static int decode_attr_nlink(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t
 	if (likely(bitmap[1] & FATTR4_WORD1_NUMLINKS)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		*nlink = be32_to_cpup(p);
 		bitmap[1] &= ~FATTR4_WORD1_NUMLINKS;
 		ret = NFS_ATTR_FATTR_NLINK;
 	}
 	dprintk("%s: nlink=%u\n", __func__, (unsigned int)*nlink);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static ssize_t decode_nfs4_string(struct xdr_stream *xdr,
@@ -4009,10 +3916,9 @@ static int decode_attr_owner(struct xdr_stream *xdr, uint32_t *bitmap,
 		return NFS_ATTR_FATTR_OWNER;
 	}
 out:
-	if (len != -EBADMSG)
-		return 0;
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
+	if (len == -EBADMSG)
+		return -EIO;
+	return 0;
 }
 
 static int decode_attr_group(struct xdr_stream *xdr, uint32_t *bitmap,
@@ -4044,10 +3950,9 @@ static int decode_attr_group(struct xdr_stream *xdr, uint32_t *bitmap,
 		return NFS_ATTR_FATTR_GROUP;
 	}
 out:
-	if (len != -EBADMSG)
-		return 0;
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
+	if (len == -EBADMSG)
+		return -EIO;
+	return 0;
 }
 
 static int decode_attr_rdev(struct xdr_stream *xdr, uint32_t *bitmap, dev_t *rdev)
@@ -4064,7 +3969,7 @@ static int decode_attr_rdev(struct xdr_stream *xdr, uint32_t *bitmap, dev_t *rde
 
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		major = be32_to_cpup(p++);
 		minor = be32_to_cpup(p);
 		tmp = MKDEV(major, minor);
@@ -4075,9 +3980,6 @@ static int decode_attr_rdev(struct xdr_stream *xdr, uint32_t *bitmap, dev_t *rde
 	}
 	dprintk("%s: rdev=(0x%x:0x%x)\n", __func__, major, minor);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_space_avail(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
@@ -4091,15 +3993,12 @@ static int decode_attr_space_avail(struct xdr_stream *xdr, uint32_t *bitmap, uin
 	if (likely(bitmap[1] & FATTR4_WORD1_SPACE_AVAIL)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 		bitmap[1] &= ~FATTR4_WORD1_SPACE_AVAIL;
 	}
 	dprintk("%s: space avail=%Lu\n", __func__, (unsigned long long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_space_free(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
@@ -4113,15 +4012,12 @@ static int decode_attr_space_free(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	if (likely(bitmap[1] & FATTR4_WORD1_SPACE_FREE)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 		bitmap[1] &= ~FATTR4_WORD1_SPACE_FREE;
 	}
 	dprintk("%s: space free=%Lu\n", __func__, (unsigned long long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_space_total(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
@@ -4135,15 +4031,12 @@ static int decode_attr_space_total(struct xdr_stream *xdr, uint32_t *bitmap, uin
 	if (likely(bitmap[1] & FATTR4_WORD1_SPACE_TOTAL)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 		bitmap[1] &= ~FATTR4_WORD1_SPACE_TOTAL;
 	}
 	dprintk("%s: space total=%Lu\n", __func__, (unsigned long long)*res);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_space_used(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *used)
@@ -4157,7 +4050,7 @@ static int decode_attr_space_used(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	if (likely(bitmap[1] & FATTR4_WORD1_SPACE_USED)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, used);
 		bitmap[1] &= ~FATTR4_WORD1_SPACE_USED;
 		ret = NFS_ATTR_FATTR_SPACE_USED;
@@ -4165,9 +4058,6 @@ static int decode_attr_space_used(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	dprintk("%s: space used=%Lu\n", __func__,
 			(unsigned long long)*used);
 	return ret;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static __be32 *
@@ -4187,12 +4077,9 @@ static int decode_attr_time(struct xdr_stream *xdr, struct timespec *time)
 
 	p = xdr_inline_decode(xdr, nfstime4_maxsz << 2);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	xdr_decode_nfstime4(p, time);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_time_access(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec *time)
@@ -4263,19 +4150,19 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 	if (likely(bitmap[2] & FATTR4_WORD2_SECURITY_LABEL)) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		lfs = be32_to_cpup(p++);
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		pi = be32_to_cpup(p++);
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		len = be32_to_cpup(p++);
 		p = xdr_inline_decode(xdr, len);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		if (len < NFS4_MAXLABELLEN) {
 			if (label && label->len) {
 				if (label->len < len)
@@ -4296,10 +4183,6 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 				label->len, label->pi, label->lfs);
 	}
 	return status;
-
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_attr_time_modify(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec *time)
@@ -4343,14 +4226,11 @@ static int decode_change_info(struct xdr_stream *xdr, struct nfs4_change_info *c
 
 	p = xdr_inline_decode(xdr, 20);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	cinfo->atomic = be32_to_cpup(p++);
 	p = xdr_decode_hyper(p, &cinfo->before);
 	xdr_decode_hyper(p, &cinfo->after);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_access(struct xdr_stream *xdr, u32 *supported, u32 *access)
@@ -4364,24 +4244,19 @@ static int decode_access(struct xdr_stream *xdr, u32 *supported, u32 *access)
 		return status;
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	supp = be32_to_cpup(p++);
 	acc = be32_to_cpup(p);
 	*supported = supp;
 	*access = acc;
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_opaque_fixed(struct xdr_stream *xdr, void *buf, size_t len)
 {
 	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
-	if (unlikely(ret < 0)) {
-		print_overflow_msg(__func__, xdr);
+	if (unlikely(ret < 0))
 		return -EIO;
-	}
 	return 0;
 }
 
@@ -4464,13 +4339,11 @@ static int decode_create(struct xdr_stream *xdr, struct nfs4_change_info *cinfo)
 		return status;
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	bmlen = be32_to_cpup(p);
 	p = xdr_inline_decode(xdr, bmlen << 2);
 	if (likely(p))
 		return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
@@ -4578,13 +4451,10 @@ static int decode_threshold_hint(struct xdr_stream *xdr,
 	if (likely(bitmap[0] & hint_bit)) {
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		xdr_decode_hyper(p, res);
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_first_threshold_item4(struct xdr_stream *xdr,
@@ -4597,10 +4467,8 @@ static int decode_first_threshold_item4(struct xdr_stream *xdr,
 
 	/* layout type */
 	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(!p)) {
-		print_overflow_msg(__func__, xdr);
+	if (unlikely(!p))
 		return -EIO;
-	}
 	res->l_type = be32_to_cpup(p);
 
 	/* thi_hintset bitmap */
@@ -4658,7 +4526,7 @@ static int decode_attr_mdsthreshold(struct xdr_stream *xdr,
 			return -EREMOTEIO;
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		num = be32_to_cpup(p);
 		if (num == 0)
 			return 0;
@@ -4671,9 +4539,6 @@ static int decode_attr_mdsthreshold(struct xdr_stream *xdr,
 		bitmap[2] &= ~FATTR4_WORD2_MDSTHRESHOLD;
 	}
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
@@ -4861,7 +4726,7 @@ static int decode_pnfs_layout_types(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	fsinfo->nlayouttypes = be32_to_cpup(p);
 
 	/* pNFS is not supported by the underlying file system */
@@ -4871,7 +4736,7 @@ static int decode_pnfs_layout_types(struct xdr_stream *xdr,
 	/* Decode and set first layout type, move xdr->p past unused types */
 	p = xdr_inline_decode(xdr, fsinfo->nlayouttypes * 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 
 	/* If we get too many, then just cap it at the max */
 	if (fsinfo->nlayouttypes > NFS_MAX_LAYOUT_TYPES) {
@@ -4883,9 +4748,6 @@ static int decode_pnfs_layout_types(struct xdr_stream *xdr,
 	for(i = 0; i < fsinfo->nlayouttypes; ++i)
 		fsinfo->layouttype[i] = be32_to_cpup(p++);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 /*
@@ -4919,10 +4781,8 @@ static int decode_attr_layout_blksize(struct xdr_stream *xdr, uint32_t *bitmap,
 	*res = 0;
 	if (bitmap[2] & FATTR4_WORD2_LAYOUT_BLKSIZE) {
 		p = xdr_inline_decode(xdr, 4);
-		if (unlikely(!p)) {
-			print_overflow_msg(__func__, xdr);
+		if (unlikely(!p))
 			return -EIO;
-		}
 		*res = be32_to_cpup(p);
 		bitmap[2] &= ~FATTR4_WORD2_LAYOUT_BLKSIZE;
 	}
@@ -4941,10 +4801,8 @@ static int decode_attr_clone_blksize(struct xdr_stream *xdr, uint32_t *bitmap,
 	*res = 0;
 	if (bitmap[2] & FATTR4_WORD2_CLONE_BLKSIZE) {
 		p = xdr_inline_decode(xdr, 4);
-		if (unlikely(!p)) {
-			print_overflow_msg(__func__, xdr);
+		if (unlikely(!p))
 			return -EIO;
-		}
 		*res = be32_to_cpup(p);
 		bitmap[2] &= ~FATTR4_WORD2_CLONE_BLKSIZE;
 	}
@@ -5020,19 +4878,16 @@ static int decode_getfh(struct xdr_stream *xdr, struct nfs_fh *fh)
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	len = be32_to_cpup(p);
 	if (len > NFS4_FHSIZE)
 		return -EIO;
 	fh->size = len;
 	p = xdr_inline_decode(xdr, len);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	memcpy(fh->data, p, len);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_link(struct xdr_stream *xdr, struct nfs4_change_info *cinfo)
@@ -5056,7 +4911,7 @@ static int decode_lock_denied (struct xdr_stream *xdr, struct file_lock *fl)
 
 	p = xdr_inline_decode(xdr, 32); /* read 32 bytes */
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	p = xdr_decode_hyper(p, &offset); /* read 2 8-byte long words */
 	p = xdr_decode_hyper(p, &length);
 	type = be32_to_cpup(p++); /* 4 byte read */
@@ -5073,11 +4928,9 @@ static int decode_lock_denied (struct xdr_stream *xdr, struct file_lock *fl)
 	p = xdr_decode_hyper(p, &clientid); /* read 8 bytes */
 	namelen = be32_to_cpup(p); /* read 4 bytes */  /* have read all 32 bytes now */
 	p = xdr_inline_decode(xdr, namelen); /* variable size field */
-	if (likely(p))
-		return -NFS4ERR_DENIED;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
+	if (likely(!p))
+		return -EIO;
+	return -NFS4ERR_DENIED;
 }
 
 static int decode_lock(struct xdr_stream *xdr, struct nfs_lock_res *res)
@@ -5146,7 +4999,7 @@ static int decode_space_limit(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 12);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	limit_type = be32_to_cpup(p++);
 	switch (limit_type) {
 	case NFS4_LIMIT_SIZE:
@@ -5160,9 +5013,6 @@ static int decode_space_limit(struct xdr_stream *xdr,
 	maxsize >>= PAGE_SHIFT;
 	*pagemod_limit = min_t(u64, maxsize, ULONG_MAX);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_rw_delegation(struct xdr_stream *xdr,
@@ -5177,7 +5027,7 @@ static int decode_rw_delegation(struct xdr_stream *xdr,
 		return status;
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	res->do_recall = be32_to_cpup(p);
 
 	switch (delegation_type) {
@@ -5190,9 +5040,6 @@ static int decode_rw_delegation(struct xdr_stream *xdr,
 				return -EIO;
 	}
 	return decode_ace(xdr, NULL);
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_no_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
@@ -5202,7 +5049,7 @@ static int decode_no_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	why_no_delegation = be32_to_cpup(p);
 	switch (why_no_delegation) {
 		case WND4_CONTENTION:
@@ -5211,9 +5058,6 @@ static int decode_no_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
 			/* Ignore for now */
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
@@ -5223,7 +5067,7 @@ static int decode_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	delegation_type = be32_to_cpup(p);
 	res->delegation_type = 0;
 	switch (delegation_type) {
@@ -5236,9 +5080,6 @@ static int decode_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
 		return decode_no_delegation(xdr, res);
 	}
 	return -EIO;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_open(struct xdr_stream *xdr, struct nfs_openres *res)
@@ -5260,7 +5101,7 @@ static int decode_open(struct xdr_stream *xdr, struct nfs_openres *res)
 
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	res->rflags = be32_to_cpup(p++);
 	bmlen = be32_to_cpup(p);
 	if (bmlen > 10)
@@ -5268,7 +5109,7 @@ static int decode_open(struct xdr_stream *xdr, struct nfs_openres *res)
 
 	p = xdr_inline_decode(xdr, bmlen << 2);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	savewords = min_t(uint32_t, bmlen, NFS4_BITMAP_SIZE);
 	for (i = 0; i < savewords; ++i)
 		res->attrset[i] = be32_to_cpup(p++);
@@ -5279,9 +5120,6 @@ static int decode_open(struct xdr_stream *xdr, struct nfs_openres *res)
 xdr_error:
 	dprintk("%s: Bitmap too large! Length = %u\n", __func__, bmlen);
 	return -EIO;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_open_confirm(struct xdr_stream *xdr, struct nfs_open_confirmres *res)
@@ -5330,7 +5168,7 @@ static int decode_read(struct xdr_stream *xdr, struct rpc_rqst *req,
 		return status;
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	eof = be32_to_cpup(p++);
 	count = be32_to_cpup(p);
 	recvd = xdr_read_pages(xdr, count);
@@ -5343,9 +5181,6 @@ static int decode_read(struct xdr_stream *xdr, struct rpc_rqst *req,
 	res->eof = eof;
 	res->count = count;
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_readdir(struct xdr_stream *xdr, struct rpc_rqst *req, struct nfs4_readdir_res *readdir)
@@ -5378,7 +5213,7 @@ static int decode_readlink(struct xdr_stream *xdr, struct rpc_rqst *req)
 	/* Convert length of symlink */
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	len = be32_to_cpup(p);
 	if (len >= rcvbuf->page_len || len <= 0) {
 		dprintk("nfs: server returned giant symlink!\n");
@@ -5399,9 +5234,6 @@ static int decode_readlink(struct xdr_stream *xdr, struct rpc_rqst *req)
 	 */
 	xdr_terminate_string(rcvbuf, len);
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_remove(struct xdr_stream *xdr, struct nfs4_change_info *cinfo)
@@ -5504,7 +5336,6 @@ static int decode_setattr(struct xdr_stream *xdr)
 		return status;
 	if (decode_bitmap4(xdr, NULL, 0) >= 0)
 		return 0;
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
@@ -5516,7 +5347,7 @@ static int decode_setclientid(struct xdr_stream *xdr, struct nfs4_setclientid_re
 
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	opnum = be32_to_cpup(p++);
 	if (opnum != OP_SETCLIENTID) {
 		dprintk("nfs: decode_setclientid: Server returned operation"
@@ -5527,7 +5358,7 @@ static int decode_setclientid(struct xdr_stream *xdr, struct nfs4_setclientid_re
 	if (nfserr == NFS_OK) {
 		p = xdr_inline_decode(xdr, 8 + NFS4_VERIFIER_SIZE);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		p = xdr_decode_hyper(p, &res->clientid);
 		memcpy(res->confirm.data, p, NFS4_VERIFIER_SIZE);
 	} else if (nfserr == NFSERR_CLID_INUSE) {
@@ -5536,28 +5367,25 @@ static int decode_setclientid(struct xdr_stream *xdr, struct nfs4_setclientid_re
 		/* skip netid string */
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		len = be32_to_cpup(p);
 		p = xdr_inline_decode(xdr, len);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 
 		/* skip uaddr string */
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		len = be32_to_cpup(p);
 		p = xdr_inline_decode(xdr, len);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		return -NFSERR_CLID_INUSE;
 	} else
 		return nfs4_stat_to_errno(nfserr);
 
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_setclientid_confirm(struct xdr_stream *xdr)
@@ -5576,13 +5404,10 @@ static int decode_write(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	res->count = be32_to_cpup(p++);
 	res->verf->committed = be32_to_cpup(p++);
 	return decode_write_verifier(xdr, &res->verf->verifier);
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_delegreturn(struct xdr_stream *xdr)
@@ -5598,30 +5423,24 @@ static int decode_secinfo_gss(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	oid_len = be32_to_cpup(p);
 	if (oid_len > GSS_OID_MAX_LEN)
-		goto out_err;
+		return -EINVAL;
 
 	p = xdr_inline_decode(xdr, oid_len);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	memcpy(flavor->flavor_info.oid.data, p, oid_len);
 	flavor->flavor_info.oid.len = oid_len;
 
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	flavor->flavor_info.qop = be32_to_cpup(p++);
 	flavor->flavor_info.service = be32_to_cpup(p);
 
 	return 0;
-
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
-out_err:
-	return -EINVAL;
 }
 
 static int decode_secinfo_common(struct xdr_stream *xdr, struct nfs4_secinfo_res *res)
@@ -5633,7 +5452,7 @@ static int decode_secinfo_common(struct xdr_stream *xdr, struct nfs4_secinfo_res
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 
 	res->flavors->num_flavors = 0;
 	num_flavors = be32_to_cpup(p);
@@ -5645,7 +5464,7 @@ static int decode_secinfo_common(struct xdr_stream *xdr, struct nfs4_secinfo_res
 
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		sec_flavor->flavor = be32_to_cpup(p);
 
 		if (sec_flavor->flavor == RPC_AUTH_GSS) {
@@ -5659,9 +5478,6 @@ static int decode_secinfo_common(struct xdr_stream *xdr, struct nfs4_secinfo_res
 	status = 0;
 out:
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_secinfo(struct xdr_stream *xdr, struct nfs4_secinfo_res *res)
@@ -5715,11 +5531,11 @@ static int decode_exchange_id(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	xdr_decode_hyper(p, &res->clientid);
 	p = xdr_inline_decode(xdr, 12);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	res->seqid = be32_to_cpup(p++);
 	res->flags = be32_to_cpup(p++);
 
@@ -5743,7 +5559,7 @@ static int decode_exchange_id(struct xdr_stream *xdr,
 	/* server_owner4.so_minor_id */
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	p = xdr_decode_hyper(p, &res->server_owner->minor_id);
 
 	/* server_owner4.so_major_id */
@@ -5763,7 +5579,7 @@ static int decode_exchange_id(struct xdr_stream *xdr,
 	/* Implementation Id */
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	impl_id_count = be32_to_cpup(p++);
 
 	if (impl_id_count) {
@@ -5782,16 +5598,13 @@ static int decode_exchange_id(struct xdr_stream *xdr,
 		/* nii_date */
 		p = xdr_inline_decode(xdr, 12);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 		p = xdr_decode_hyper(p, &res->impl_id->date.seconds);
 		res->impl_id->date.nseconds = be32_to_cpup(p);
 
 		/* if there's more than one entry, ignore the rest */
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_chan_attrs(struct xdr_stream *xdr,
@@ -5802,7 +5615,7 @@ static int decode_chan_attrs(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 28);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	val = be32_to_cpup(p++);	/* headerpadsz */
 	if (val)
 		return -EINVAL;		/* no support for header padding yet */
@@ -5820,12 +5633,9 @@ static int decode_chan_attrs(struct xdr_stream *xdr,
 	if (nr_attrs == 1) {
 		p = xdr_inline_decode(xdr, 4); /* skip rdma_attrs */
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_sessionid(struct xdr_stream *xdr, struct nfs4_sessionid *sid)
@@ -5848,7 +5658,7 @@ static int decode_bind_conn_to_session(struct xdr_stream *xdr,
 	/* dir flags, rdma mode bool */
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 
 	res->dir = be32_to_cpup(p++);
 	if (res->dir == 0 || res->dir > NFS4_CDFS4_BOTH)
@@ -5859,9 +5669,6 @@ static int decode_bind_conn_to_session(struct xdr_stream *xdr,
 		res->use_conn_in_rdma_mode = true;
 
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_create_session(struct xdr_stream *xdr,
@@ -5879,7 +5686,7 @@ static int decode_create_session(struct xdr_stream *xdr,
 	/* seqid, flags */
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	res->seqid = be32_to_cpup(p++);
 	res->flags = be32_to_cpup(p);
 
@@ -5888,9 +5695,6 @@ static int decode_create_session(struct xdr_stream *xdr,
 	if (!status)
 		status = decode_chan_attrs(xdr, &res->bc_attrs);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_destroy_session(struct xdr_stream *xdr, void *dummy)
@@ -5971,7 +5775,6 @@ static int decode_sequence(struct xdr_stream *xdr,
 	res->sr_status = status;
 	return status;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	status = -EIO;
 	goto out_err;
 #else  /* CONFIG_NFS_V4_1 */
@@ -5999,7 +5802,7 @@ static int decode_getdeviceinfo(struct xdr_stream *xdr,
 		if (status == -ETOOSMALL) {
 			p = xdr_inline_decode(xdr, 4);
 			if (unlikely(!p))
-				goto out_overflow;
+				return -EIO;
 			pdev->mincount = be32_to_cpup(p);
 			dprintk("%s: Min count too small. mincnt = %u\n",
 				__func__, pdev->mincount);
@@ -6009,7 +5812,7 @@ static int decode_getdeviceinfo(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 8);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	type = be32_to_cpup(p++);
 	if (type != pdev->layout_type) {
 		dprintk("%s: layout mismatch req: %u pdev: %u\n",
@@ -6023,19 +5826,19 @@ static int decode_getdeviceinfo(struct xdr_stream *xdr,
 	 */
 	pdev->mincount = be32_to_cpup(p);
 	if (xdr_read_pages(xdr, pdev->mincount) != pdev->mincount)
-		goto out_overflow;
+		return -EIO;
 
 	/* Parse notification bitmap, verifying that it is zero. */
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	len = be32_to_cpup(p);
 	if (len) {
 		uint32_t i;
 
 		p = xdr_inline_decode(xdr, 4 * len);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 
 		res->notification = be32_to_cpup(p++);
 		for (i = 1; i < len; i++) {
@@ -6047,9 +5850,6 @@ static int decode_getdeviceinfo(struct xdr_stream *xdr,
 		}
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
@@ -6119,7 +5919,6 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 	res->status = status;
 	return status;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	status = -EIO;
 	goto out;
 }
@@ -6135,16 +5934,13 @@ static int decode_layoutreturn(struct xdr_stream *xdr,
 		return status;
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	res->lrs_present = be32_to_cpup(p);
 	if (res->lrs_present)
 		status = decode_layout_stateid(xdr, &res->stateid);
 	else
 		nfs4_stateid_copy(&res->stateid, &invalid_stateid);
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_layoutcommit(struct xdr_stream *xdr,
@@ -6162,19 +5958,16 @@ static int decode_layoutcommit(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	sizechanged = be32_to_cpup(p);
 
 	if (sizechanged) {
 		/* throw away new size */
 		p = xdr_inline_decode(xdr, 8);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EIO;
 	}
 	return 0;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EIO;
 }
 
 static int decode_test_stateid(struct xdr_stream *xdr,
@@ -6190,21 +5983,17 @@ static int decode_test_stateid(struct xdr_stream *xdr,
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	num_res = be32_to_cpup(p++);
 	if (num_res != 1)
-		goto out;
+		return -EIO;
 
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EIO;
 	res->status = be32_to_cpup(p++);
 
 	return status;
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-out:
-	return -EIO;
 }
 
 static int decode_free_stateid(struct xdr_stream *xdr,
@@ -7574,11 +7363,11 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	uint64_t new_cookie;
 	__be32 *p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EAGAIN;
 	if (*p == xdr_zero) {
 		p = xdr_inline_decode(xdr, 4);
 		if (unlikely(!p))
-			goto out_overflow;
+			return -EAGAIN;
 		if (*p == xdr_zero)
 			return -EAGAIN;
 		entry->eof = 1;
@@ -7587,13 +7376,13 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 	p = xdr_inline_decode(xdr, 12);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EAGAIN;
 	p = xdr_decode_hyper(p, &new_cookie);
 	entry->len = be32_to_cpup(p);
 
 	p = xdr_inline_decode(xdr, entry->len);
 	if (unlikely(!p))
-		goto out_overflow;
+		return -EAGAIN;
 	entry->name = (const char *) p;
 
 	/*
@@ -7605,14 +7394,14 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	entry->fattr->valid = 0;
 
 	if (decode_attr_bitmap(xdr, bitmap) < 0)
-		goto out_overflow;
+		return -EAGAIN;
 
 	if (decode_attr_length(xdr, &len, &savep) < 0)
-		goto out_overflow;
+		return -EAGAIN;
 
 	if (decode_getfattr_attrs(xdr, bitmap, entry->fattr, entry->fh,
 			NULL, entry->label, entry->server) < 0)
-		goto out_overflow;
+		return -EAGAIN;
 	if (entry->fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID)
 		entry->ino = entry->fattr->mounted_on_fileid;
 	else if (entry->fattr->valid & NFS_ATTR_FATTR_FILEID)
@@ -7626,10 +7415,6 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	entry->cookie = new_cookie;
 
 	return 0;
-
-out_overflow:
-	print_overflow_msg(__func__, xdr);
-	return -EAGAIN;
 }
 
 /*
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 519d994c0c4c0..e6c7448d3d89a 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -59,16 +59,6 @@ struct nfs4_cb_compound_hdr {
 	int		status;
 };
 
-/*
- * Handle decode buffer overflows out-of-line.
- */
-static void print_overflow_msg(const char *func, const struct xdr_stream *xdr)
-{
-	dprintk("NFS: %s prematurely hit the end of our receive buffer. "
-		"Remaining buffer length is %tu words.\n",
-		func, xdr->end - xdr->p);
-}
-
 static __be32 *xdr_encode_empty_array(__be32 *p)
 {
 	*p++ = xdr_zero;
@@ -238,7 +228,6 @@ static int decode_cb_op_status(struct xdr_stream *xdr,
 	*status = nfs_cb_stat_to_errno(be32_to_cpup(p));
 	return 0;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 out_unexpected:
 	dprintk("NFSD: Callback server returned operation %d but "
@@ -307,7 +296,6 @@ static int decode_cb_compound4res(struct xdr_stream *xdr,
 	hdr->nops = be32_to_cpup(p);
 	return 0;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	return -EIO;
 }
 
@@ -435,7 +423,6 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
 	cb->cb_seq_status = status;
 	return status;
 out_overflow:
-	print_overflow_msg(__func__, xdr);
 	status = -EIO;
 	goto out;
 }
-- 
2.43.0




