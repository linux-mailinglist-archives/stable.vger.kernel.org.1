Return-Path: <stable+bounces-53026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AE890CFD6
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BF51C23B77
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3325A161328;
	Tue, 18 Jun 2024 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j4Kuefho"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3766161305;
	Tue, 18 Jun 2024 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715109; cv=none; b=aLa5U2bY3urcXqtT4yWsH1QfiL6QgUvFEcT/H9RDuWrYSFQkGRfrM4fQCQWo4lLyo+auhFbqWRgsYUa3Z/KZEw6kRiKm3QQTiN9qQicNK3Tmaseb7a4iNVHUEqhaAhu/oHEbgw7eX0X/AZHjVj4vV03x0N3OiGtydIRFAd3X8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715109; c=relaxed/simple;
	bh=05LnZ2LNtfUZkmfI43U3w9H3EwHSrCZw22aCt8A39b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvp9gOQEwjNZQXJIsiVLDfOxZQFCcPCnR/eC+3jrMiK3QU/5vDHfAwARSKi1f2/fYNgb9aGj9HUA3Rv7M8+dk+kwlB4yj0bxVhsdRfiwET+bTxrp/KMOWNx6qieRvS16Qhc535L2Nfchw5ca1yjxioybDVqDB/vl88vsVI/dmjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j4Kuefho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6506FC3277B;
	Tue, 18 Jun 2024 12:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715108;
	bh=05LnZ2LNtfUZkmfI43U3w9H3EwHSrCZw22aCt8A39b0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4KuefhoP57fGNnNNe9l5wI596GMmv3fSk5KULCSrhCwy61xApvqIsYnnDXyCQt1j
	 m9bCQ1LwO4a8v2Mg2Z1wArJL6OizuE8VvcMq9KOT1BhT06ar41Bk06o7MJohX0tH1G
	 7OZdlpYYhjKVO0uqEL8t+bl0hs0KrjsDqG5acasE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 197/770] NFSD: Extract the svcxdr_init_encode() helper
Date: Tue, 18 Jun 2024 14:30:50 +0200
Message-ID: <20240618123414.879602865@linuxfoundation.org>
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

[ Upstream commit bddfdbcddbe267519cd36aeb115fdf8620980111 ]

NFSD initializes an encode xdr_stream only after the RPC layer has
already inserted the RPC Reply header. Thus it behaves differently
than xdr_init_encode does, which assumes the passed-in xdr_buf is
entirely devoid of content.

nfs4proc.c has this server-side stream initialization helper, but
it is visible only to the NFSv4 code. Move this helper to a place
that can be accessed by NFSv2 and NFSv3 server XDR functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c         |  31 +++--------
 fs/nfsd/nfs4state.c        |   6 +-
 fs/nfsd/nfs4xdr.c          | 110 ++++++++++++++++++-------------------
 fs/nfsd/nfssvc.c           |   4 +-
 fs/nfsd/xdr4.h             |   2 +-
 include/linux/sunrpc/svc.h |  25 +++++++++
 6 files changed, 94 insertions(+), 84 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0acf7af9aab8f..2fba0808d975c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2256,25 +2256,6 @@ static bool need_wrongsec_check(struct svc_rqst *rqstp)
 	return !(nextd->op_flags & OP_HANDLES_WRONGSEC);
 }
 
-static void svcxdr_init_encode(struct svc_rqst *rqstp,
-			       struct nfsd4_compoundres *resp)
-{
-	struct xdr_stream *xdr = &resp->xdr;
-	struct xdr_buf *buf = &rqstp->rq_res;
-	struct kvec *head = buf->head;
-
-	xdr->buf = buf;
-	xdr->iov = head;
-	xdr->p   = head->iov_base + head->iov_len;
-	xdr->end = head->iov_base + PAGE_SIZE - rqstp->rq_auth_slack;
-	/* Tail and page_len should be zero at this point: */
-	buf->len = buf->head[0].iov_len;
-	xdr_reset_scratch_buffer(xdr);
-	xdr->page_ptr = buf->pages - 1;
-	buf->buflen = PAGE_SIZE * (1 + rqstp->rq_page_end - buf->pages)
-		- rqstp->rq_auth_slack;
-}
-
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 static void
 check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
@@ -2329,10 +2310,14 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	__be32		status;
 
-	svcxdr_init_encode(rqstp, resp);
-	resp->tagp = resp->xdr.p;
+	resp->xdr = &rqstp->rq_res_stream;
+
+	/* reserve space for: NFS status code */
+	xdr_reserve_space(resp->xdr, XDR_UNIT);
+
+	resp->tagp = resp->xdr->p;
 	/* reserve space for: taglen, tag, and opcnt */
-	xdr_reserve_space(&resp->xdr, 8 + args->taglen);
+	xdr_reserve_space(resp->xdr, XDR_UNIT * 2 + args->taglen);
 	resp->taglen = args->taglen;
 	resp->tag = args->tag;
 	resp->rqstp = rqstp;
@@ -2438,7 +2423,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 encode_op:
 		if (op->status == nfserr_replay_me) {
 			op->replay = &cstate->replay_owner->so_replay;
-			nfsd4_encode_replay(&resp->xdr, op);
+			nfsd4_encode_replay(resp->xdr, op);
 			status = op->status = op->replay->rp_status;
 		} else {
 			nfsd4_encode_operation(resp, op);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c2eba93ab5138..914f60cee3226 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2925,7 +2925,7 @@ gen_callback(struct nfs4_client *clp, struct nfsd4_setclientid *se, struct svc_r
 static void
 nfsd4_store_cache_entry(struct nfsd4_compoundres *resp)
 {
-	struct xdr_buf *buf = resp->xdr.buf;
+	struct xdr_buf *buf = resp->xdr->buf;
 	struct nfsd4_slot *slot = resp->cstate.slot;
 	unsigned int base;
 
@@ -2995,7 +2995,7 @@ nfsd4_replay_cache_entry(struct nfsd4_compoundres *resp,
 			 struct nfsd4_sequence *seq)
 {
 	struct nfsd4_slot *slot = resp->cstate.slot;
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 	__be32 status;
 
@@ -3740,7 +3740,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	struct nfsd4_sequence *seq = &u->sequence;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct nfsd4_session *session;
 	struct nfs4_client *clp;
 	struct nfsd4_slot *slot;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8d5fdae568aeb..262c6fec56aa6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3595,7 +3595,7 @@ nfsd4_encode_stateid(struct xdr_stream *xdr, stateid_t *sid)
 static __be32
 nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_access *access)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 8);
@@ -3608,7 +3608,7 @@ nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 
 static __be32 nfsd4_encode_bind_conn_to_session(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_bind_conn_to_session *bcts)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, NFS4_MAX_SESSIONID_LEN + 8);
@@ -3625,7 +3625,7 @@ static __be32 nfsd4_encode_bind_conn_to_session(struct nfsd4_compoundres *resp,
 static __be32
 nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_close *close)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &close->cl_stateid);
 }
@@ -3634,7 +3634,7 @@ nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_c
 static __be32
 nfsd4_encode_commit(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_commit *commit)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, NFS4_VERIFIER_SIZE);
@@ -3648,7 +3648,7 @@ nfsd4_encode_commit(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 static __be32
 nfsd4_encode_create(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_create *create)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 20);
@@ -3663,7 +3663,7 @@ static __be32
 nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_getattr *getattr)
 {
 	struct svc_fh *fhp = getattr->ga_fhp;
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_fattr(xdr, fhp, fhp->fh_export, fhp->fh_dentry,
 				    getattr->ga_bmval, resp->rqstp, 0);
@@ -3672,7 +3672,7 @@ nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 static __be32
 nfsd4_encode_getfh(struct nfsd4_compoundres *resp, __be32 nfserr, struct svc_fh **fhpp)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct svc_fh *fhp = *fhpp;
 	unsigned int len;
 	__be32 *p;
@@ -3727,7 +3727,7 @@ nfsd4_encode_lock_denied(struct xdr_stream *xdr, struct nfsd4_lock_denied *ld)
 static __be32
 nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_lock *lock)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	if (!nfserr)
 		nfserr = nfsd4_encode_stateid(xdr, &lock->lk_resp_stateid);
@@ -3740,7 +3740,7 @@ nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_lo
 static __be32
 nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_lockt *lockt)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	if (nfserr == nfserr_denied)
 		nfsd4_encode_lock_denied(xdr, &lockt->lt_denied);
@@ -3750,7 +3750,7 @@ nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_l
 static __be32
 nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_locku *locku)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &locku->lu_stateid);
 }
@@ -3759,7 +3759,7 @@ nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_l
 static __be32
 nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_link *link)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 20);
@@ -3773,7 +3773,7 @@ nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_li
 static __be32
 nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open *open)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	nfserr = nfsd4_encode_stateid(xdr, &open->op_stateid);
@@ -3867,7 +3867,7 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_op
 static __be32
 nfsd4_encode_open_confirm(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open_confirm *oc)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &oc->oc_resp_stateid);
 }
@@ -3875,7 +3875,7 @@ nfsd4_encode_open_confirm(struct nfsd4_compoundres *resp, __be32 nfserr, struct
 static __be32
 nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_open_downgrade *od)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_encode_stateid(xdr, &od->od_stateid);
 }
@@ -3885,7 +3885,7 @@ static __be32 nfsd4_encode_splice_read(
 				struct nfsd4_read *read,
 				struct file *file, unsigned long maxcount)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct xdr_buf *buf = xdr->buf;
 	int status, space_left;
 	u32 eof;
@@ -3951,7 +3951,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 				 struct nfsd4_read *read,
 				 struct file *file, unsigned long maxcount)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	u32 eof;
 	int starting_len = xdr->buf->len - 8;
 	__be32 nfserr;
@@ -3990,7 +3990,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 		  struct nfsd4_read *read)
 {
 	unsigned long maxcount;
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct file *file;
 	int starting_len = xdr->buf->len;
 	__be32 *p;
@@ -4004,7 +4004,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 		WARN_ON_ONCE(test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags));
 		return nfserr_resource;
 	}
-	if (resp->xdr.buf->page_len &&
+	if (resp->xdr->buf->page_len &&
 	    test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags)) {
 		WARN_ON_ONCE(1);
 		return nfserr_serverfault;
@@ -4034,7 +4034,7 @@ nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd
 	int maxcount;
 	__be32 wire_count;
 	int zero = 0;
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	int length_offset = xdr->buf->len;
 	int status;
 	__be32 *p;
@@ -4086,7 +4086,7 @@ nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 	int bytes_left;
 	loff_t offset;
 	__be64 wire_offset;
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	int starting_len = xdr->buf->len;
 	__be32 *p;
 
@@ -4097,8 +4097,8 @@ nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 	/* XXX: Following NFSv3, we ignore the READDIR verifier for now. */
 	*p++ = cpu_to_be32(0);
 	*p++ = cpu_to_be32(0);
-	resp->xdr.buf->head[0].iov_len = ((char *)resp->xdr.p)
-				- (char *)resp->xdr.buf->head[0].iov_base;
+	xdr->buf->head[0].iov_len = (char *)xdr->p -
+				    (char *)xdr->buf->head[0].iov_base;
 
 	/*
 	 * Number of bytes left for directory entries allowing for the
@@ -4173,7 +4173,7 @@ nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 static __be32
 nfsd4_encode_remove(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_remove *remove)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 20);
@@ -4186,7 +4186,7 @@ nfsd4_encode_remove(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_
 static __be32
 nfsd4_encode_rename(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_rename *rename)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 40);
@@ -4269,7 +4269,7 @@ static __be32
 nfsd4_encode_secinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 		     struct nfsd4_secinfo *secinfo)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_do_encode_secinfo(xdr, secinfo->si_exp);
 }
@@ -4278,7 +4278,7 @@ static __be32
 nfsd4_encode_secinfo_no_name(struct nfsd4_compoundres *resp, __be32 nfserr,
 		     struct nfsd4_secinfo_no_name *secinfo)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 
 	return nfsd4_do_encode_secinfo(xdr, secinfo->sin_exp);
 }
@@ -4290,7 +4290,7 @@ nfsd4_encode_secinfo_no_name(struct nfsd4_compoundres *resp, __be32 nfserr,
 static __be32
 nfsd4_encode_setattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_setattr *setattr)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 16);
@@ -4314,7 +4314,7 @@ nfsd4_encode_setattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 static __be32
 nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_setclientid *scd)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	if (!nfserr) {
@@ -4338,7 +4338,7 @@ nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, __be32 nfserr, struct n
 static __be32
 nfsd4_encode_write(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_write *write)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 16);
@@ -4355,7 +4355,7 @@ static __be32
 nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
 			 struct nfsd4_exchange_id *exid)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 	char *major_id;
 	char *server_scope;
@@ -4433,7 +4433,7 @@ static __be32
 nfsd4_encode_create_session(struct nfsd4_compoundres *resp, __be32 nfserr,
 			    struct nfsd4_create_session *sess)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 24);
@@ -4486,7 +4486,7 @@ static __be32
 nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
 		      struct nfsd4_sequence *seq)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, NFS4_MAX_SESSIONID_LEN + 20);
@@ -4509,7 +4509,7 @@ static __be32
 nfsd4_encode_test_stateid(struct nfsd4_compoundres *resp, __be32 nfserr,
 			  struct nfsd4_test_stateid *test_stateid)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct nfsd4_test_stateid_id *stateid, *next;
 	__be32 *p;
 
@@ -4530,7 +4530,7 @@ static __be32
 nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 		struct nfsd4_getdeviceinfo *gdev)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	const struct nfsd4_layout_ops *ops;
 	u32 starting_len = xdr->buf->len, needed_len;
 	__be32 *p;
@@ -4583,7 +4583,7 @@ static __be32
 nfsd4_encode_layoutget(struct nfsd4_compoundres *resp, __be32 nfserr,
 		struct nfsd4_layoutget *lgp)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	const struct nfsd4_layout_ops *ops;
 	__be32 *p;
 
@@ -4610,7 +4610,7 @@ static __be32
 nfsd4_encode_layoutcommit(struct nfsd4_compoundres *resp, __be32 nfserr,
 			  struct nfsd4_layoutcommit *lcp)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 4);
@@ -4631,7 +4631,7 @@ static __be32
 nfsd4_encode_layoutreturn(struct nfsd4_compoundres *resp, __be32 nfserr,
 		struct nfsd4_layoutreturn *lrp)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 4);
@@ -4649,7 +4649,7 @@ nfsd42_encode_write_res(struct nfsd4_compoundres *resp,
 		struct nfsd42_write_res *write, bool sync)
 {
 	__be32 *p;
-	p = xdr_reserve_space(&resp->xdr, 4);
+	p = xdr_reserve_space(resp->xdr, 4);
 	if (!p)
 		return nfserr_resource;
 
@@ -4658,11 +4658,11 @@ nfsd42_encode_write_res(struct nfsd4_compoundres *resp,
 	else {
 		__be32 nfserr;
 		*p++ = cpu_to_be32(1);
-		nfserr = nfsd4_encode_stateid(&resp->xdr, &write->cb_stateid);
+		nfserr = nfsd4_encode_stateid(resp->xdr, &write->cb_stateid);
 		if (nfserr)
 			return nfserr;
 	}
-	p = xdr_reserve_space(&resp->xdr, 8 + 4 + NFS4_VERIFIER_SIZE);
+	p = xdr_reserve_space(resp->xdr, 8 + 4 + NFS4_VERIFIER_SIZE);
 	if (!p)
 		return nfserr_resource;
 
@@ -4676,7 +4676,7 @@ nfsd42_encode_write_res(struct nfsd4_compoundres *resp,
 static __be32
 nfsd42_encode_nl4_server(struct nfsd4_compoundres *resp, struct nl4_server *ns)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct nfs42_netaddr *addr;
 	__be32 *p;
 
@@ -4724,7 +4724,7 @@ nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (nfserr)
 		return nfserr;
 
-	p = xdr_reserve_space(&resp->xdr, 4 + 4);
+	p = xdr_reserve_space(resp->xdr, 4 + 4);
 	*p++ = xdr_one; /* cr_consecutive */
 	*p++ = cpu_to_be32(copy->cp_synchronous);
 	return 0;
@@ -4734,7 +4734,7 @@ static __be32
 nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 			    struct nfsd4_offload_status *os)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 8 + 4);
@@ -4751,7 +4751,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 			    unsigned long *maxcount, u32 *eof,
 			    loff_t *pos)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
 	int starting_len = xdr->buf->len;
 	loff_t hole_pos;
@@ -4810,7 +4810,7 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
 	count = data_pos - read->rd_offset;
 
 	/* Content type, offset, byte count */
-	p = xdr_reserve_space(&resp->xdr, 4 + 8 + 8);
+	p = xdr_reserve_space(resp->xdr, 4 + 8 + 8);
 	if (!p)
 		return nfserr_resource;
 
@@ -4828,7 +4828,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		       struct nfsd4_read *read)
 {
 	unsigned long maxcount, count;
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct file *file;
 	int starting_len = xdr->buf->len;
 	int last_segment = xdr->buf->len;
@@ -4899,7 +4899,7 @@ static __be32
 nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
 			 struct nfsd4_copy_notify *cn)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	if (nfserr)
@@ -4935,7 +4935,7 @@ nfsd4_encode_seek(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	__be32 *p;
 
-	p = xdr_reserve_space(&resp->xdr, 4 + 8);
+	p = xdr_reserve_space(resp->xdr, 4 + 8);
 	*p++ = cpu_to_be32(seek->seek_eof);
 	p = xdr_encode_hyper(p, seek->seek_pos);
 
@@ -4996,7 +4996,7 @@ static __be32
 nfsd4_encode_getxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
 		      struct nfsd4_getxattr *getxattr)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p, err;
 
 	p = xdr_reserve_space(xdr, 4);
@@ -5020,7 +5020,7 @@ static __be32
 nfsd4_encode_setxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
 		      struct nfsd4_setxattr *setxattr)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 20);
@@ -5061,7 +5061,7 @@ static __be32
 nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 			struct nfsd4_listxattrs *listxattrs)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	u32 cookie_offset, count_offset, eof;
 	u32 left, xdrleft, slen, count;
 	u32 xdrlen, offset;
@@ -5172,7 +5172,7 @@ static __be32
 nfsd4_encode_removexattr(struct nfsd4_compoundres *resp, __be32 nfserr,
 			 struct nfsd4_removexattr *removexattr)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 20);
@@ -5312,7 +5312,7 @@ __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *resp, u32 respsize)
 void
 nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 {
-	struct xdr_stream *xdr = &resp->xdr;
+	struct xdr_stream *xdr = resp->xdr;
 	struct nfs4_stateowner *so = resp->cstate.replay_owner;
 	struct svc_rqst *rqstp = resp->rqstp;
 	const struct nfsd4_operation *opdesc = op->opdesc;
@@ -5441,14 +5441,14 @@ int
 nfs4svc_encode_compoundres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
-	struct xdr_buf *buf = resp->xdr.buf;
+	struct xdr_buf *buf = resp->xdr->buf;
 
 	WARN_ON_ONCE(buf->len != buf->head[0].iov_len + buf->page_len +
 				 buf->tail[0].iov_len);
 
 	*p = resp->cstate.status;
 
-	rqstp->rq_next_page = resp->xdr.page_ptr + 1;
+	rqstp->rq_next_page = resp->xdr->page_ptr + 1;
 
 	p = resp->tagp;
 	*p++ = htonl(resp->taglen);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 6c1d70935ea81..0666ef4b87b7a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1030,7 +1030,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 * NFSv4 does some encoding while processing
 	 */
 	p = resv->iov_base + resv->iov_len;
-	resv->iov_len += sizeof(__be32);
+	svcxdr_init_encode(rqstp);
 
 	*statp = proc->pc_func(rqstp);
 	if (*statp == rpc_drop_reply || test_bit(RQ_DROPME, &rqstp->rq_flags))
@@ -1085,7 +1085,7 @@ int nfssvc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p)
  */
 int nfssvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p)
 {
-        return xdr_ressize_check(rqstp, p);
+	return 1;
 }
 
 int nfsd_pool_stats_open(struct inode *inode, struct file *file)
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index c300885ae75dd..fe540a3415c6a 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -698,7 +698,7 @@ struct nfsd4_compoundargs {
 
 struct nfsd4_compoundres {
 	/* scratch variables for XDR encode */
-	struct xdr_stream		xdr;
+	struct xdr_stream		*xdr;
 	struct svc_rqst *		rqstp;
 
 	u32				taglen;
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 31ee3b6047c30..e91d51ea028bb 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -248,6 +248,7 @@ struct svc_rqst {
 	size_t			rq_xprt_hlen;	/* xprt header len */
 	struct xdr_buf		rq_arg;
 	struct xdr_stream	rq_arg_stream;
+	struct xdr_stream	rq_res_stream;
 	struct page		*rq_scratch_page;
 	struct xdr_buf		rq_res;
 	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
@@ -574,4 +575,28 @@ static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
 	xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
 }
 
+/**
+ * svcxdr_init_encode - Prepare an xdr_stream for svc Reply encoding
+ * @rqstp: controlling server RPC transaction context
+ *
+ */
+static inline void svcxdr_init_encode(struct svc_rqst *rqstp)
+{
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
+	struct xdr_buf *buf = &rqstp->rq_res;
+	struct kvec *resv = buf->head;
+
+	xdr_reset_scratch_buffer(xdr);
+
+	xdr->buf = buf;
+	xdr->iov = resv;
+	xdr->p   = resv->iov_base + resv->iov_len;
+	xdr->end = resv->iov_base + PAGE_SIZE - rqstp->rq_auth_slack;
+	buf->len = resv->iov_len;
+	xdr->page_ptr = buf->pages - 1;
+	buf->buflen = PAGE_SIZE * (1 + rqstp->rq_page_end - buf->pages);
+	buf->buflen -= rqstp->rq_auth_slack;
+	xdr->rqst = NULL;
+}
+
 #endif /* SUNRPC_SVC_H */
-- 
2.43.0




