Return-Path: <stable+bounces-53584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2D190D27A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E124285F7F
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057AD15A84D;
	Tue, 18 Jun 2024 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qc/awf1v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74321ACE95;
	Tue, 18 Jun 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716762; cv=none; b=OKcVEBeUB/zne5bHdiqqXc2ecNiQqr5tn5aQMOlqZB77C4FfuWzt6BAdXuw6AfbsuF8JTPaJVqX8ld53e3+rqJnM2qbyT3CYsOMZXn32p5DjR9smT7VaaFg79MNOIyAzVBfAP1uyrpxJTwJIhS9Iag3uxfPAli4pzylxTfOJVws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716762; c=relaxed/simple;
	bh=c0zTWqnAQSWQrUwLZWQfRiJBTZmxKDTT8OnrTy3qINA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEvrIaE4cMWb9W0iORVDOEu7T1odV3WVoZkt0HTVaTYFYDWm+yUtGgeKYEc8LFA3mUWAclnAhv9e2lhPeHcuHSJG7wVtHx2FOkes1f5b2Au6yt/2wXuHdne0QtfI50z4/mAliwC+a7LaXIDTZ11kHcUTi48VbxxpN4sczw9Ecno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qc/awf1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C84C3277B;
	Tue, 18 Jun 2024 13:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716762;
	bh=c0zTWqnAQSWQrUwLZWQfRiJBTZmxKDTT8OnrTy3qINA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qc/awf1vV0ckzV3CphIZZy5FeTIclCZdwn1CKYLPcQpiEroI5945MdhzIj35/bIKZ
	 bUZ8/oG35/Pae+8f+/QHzLlPeHaza1Y/yOmjydeTzvqFr7iU5Aw1Hgap37+NXXamuL
	 xrgirJUEyiuXoR8b30nYWTlgKH5pP7QAuNEfOh64=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 723/770] Revert "SUNRPC: Use RMW bitops in single-threaded hot paths"
Date: Tue, 18 Jun 2024 14:39:36 +0200
Message-ID: <20240618123435.177654695@linuxfoundation.org>
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

[ Upstream commit 7827c81f0248e3c2f40d438b020f3d222f002171 ]

The premise that "Once an svc thread is scheduled and executing an
RPC, no other processes will touch svc_rqst::rq_flags" is false.
svc_xprt_enqueue() examines the RQ_BUSY flag in scheduled nfsd
threads when determining which thread to wake up next.

Found via KCSAN.

Fixes: 28df0988815f ("SUNRPC: Use RMW bitops in single-threaded hot paths")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c                       | 7 +++----
 fs/nfsd/nfs4xdr.c                        | 2 +-
 net/sunrpc/auth_gss/svcauth_gss.c        | 4 ++--
 net/sunrpc/svc.c                         | 6 +++---
 net/sunrpc/svc_xprt.c                    | 2 +-
 net/sunrpc/svcsock.c                     | 8 ++++----
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 2 +-
 7 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index cf558d951ec68..a89f98fa3a9d0 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -937,7 +937,7 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * the client wants us to do more in this compound:
 	 */
 	if (!nfsd4_last_compound_op(rqstp))
-		__clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
+		clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
 	/* check stateid */
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
@@ -2609,12 +2609,11 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	cstate->minorversion = args->minorversion;
 	fh_init(current_fh, NFS4_FHSIZE);
 	fh_init(save_fh, NFS4_FHSIZE);
-
 	/*
 	 * Don't use the deferral mechanism for NFSv4; compounds make it
 	 * too hard to avoid non-idempotency problems.
 	 */
-	__clear_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
+	clear_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
 
 	/*
 	 * According to RFC3010, this takes precedence over all other errors.
@@ -2736,7 +2735,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 out:
 	cstate->status = status;
 	/* Reset deferral mechanism for RPC deferrals */
-	__set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
+	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8bbf85da1de05..d0b9fbf189ac6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2523,7 +2523,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	argp->rqstp->rq_cachetype = cachethis ? RC_REPLBUFF : RC_NOCACHE;
 
 	if (readcount > 1 || max_reply > PAGE_SIZE - auth_slack)
-		__clear_bit(RQ_SPLICE_OK, &argp->rqstp->rq_flags);
+		clear_bit(RQ_SPLICE_OK, &argp->rqstp->rq_flags);
 
 	return true;
 }
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index abaa952ae7518..329eac782cc5e 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -898,7 +898,7 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct g
 	 * rejecting the server-computed MIC in this somewhat rare case,
 	 * do not use splice with the GSS integrity service.
 	 */
-	__clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
+	clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
 	/* Did we already verify the signature on the original pass through? */
 	if (rqstp->rq_deferred)
@@ -970,7 +970,7 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	int pad, remaining_len, offset;
 	u32 rseqno;
 
-	__clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
+	clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
 	priv_len = svc_getnl(&buf->head[0]);
 	if (rqstp->rq_deferred) {
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 8c29181796492..26d972c54a593 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1276,10 +1276,10 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 		goto err_short_len;
 
 	/* Will be turned off by GSS integrity and privacy services */
-	__set_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
+	set_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 	/* Will be turned off only when NFSv4 Sessions are used */
-	__set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
-	__clear_bit(RQ_DROPME, &rqstp->rq_flags);
+	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
+	clear_bit(RQ_DROPME, &rqstp->rq_flags);
 
 	svc_putu32(resv, rqstp->rq_xid);
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index ea65036dc5068..000b737784bd9 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1228,7 +1228,7 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 	trace_svc_defer(rqstp);
 	svc_xprt_get(rqstp->rq_xprt);
 	dr->xprt = rqstp->rq_xprt;
-	__set_bit(RQ_DROPME, &rqstp->rq_flags);
+	set_bit(RQ_DROPME, &rqstp->rq_flags);
 
 	dr->handle.revisit = svc_revisit;
 	return &dr->handle;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index ff8dcebbdfc4e..90f6231d6ed67 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -309,9 +309,9 @@ static void svc_sock_setbufsize(struct svc_sock *svsk, unsigned int nreqs)
 static void svc_sock_secure_port(struct svc_rqst *rqstp)
 {
 	if (svc_port_is_privileged(svc_addr(rqstp)))
-		__set_bit(RQ_SECURE, &rqstp->rq_flags);
+		set_bit(RQ_SECURE, &rqstp->rq_flags);
 	else
-		__clear_bit(RQ_SECURE, &rqstp->rq_flags);
+		clear_bit(RQ_SECURE, &rqstp->rq_flags);
 }
 
 /*
@@ -1014,9 +1014,9 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	rqstp->rq_xprt_ctxt   = NULL;
 	rqstp->rq_prot	      = IPPROTO_TCP;
 	if (test_bit(XPT_LOCAL, &svsk->sk_xprt.xpt_flags))
-		__set_bit(RQ_LOCAL, &rqstp->rq_flags);
+		set_bit(RQ_LOCAL, &rqstp->rq_flags);
 	else
-		__clear_bit(RQ_LOCAL, &rqstp->rq_flags);
+		clear_bit(RQ_LOCAL, &rqstp->rq_flags);
 
 	p = (__be32 *)rqstp->rq_arg.head[0].iov_base;
 	calldir = p[1];
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index e72e36989985f..c895f80df659c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -606,7 +606,7 @@ static int svc_rdma_has_wspace(struct svc_xprt *xprt)
 
 static void svc_rdma_secure_port(struct svc_rqst *rqstp)
 {
-	__set_bit(RQ_SECURE, &rqstp->rq_flags);
+	set_bit(RQ_SECURE, &rqstp->rq_flags);
 }
 
 static void svc_rdma_kill_temp_xprt(struct svc_xprt *xprt)
-- 
2.43.0




