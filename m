Return-Path: <stable+bounces-37040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A75889C2FE
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF171C202D5
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4EF7F479;
	Mon,  8 Apr 2024 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LX21yB+f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C187F46F;
	Mon,  8 Apr 2024 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583080; cv=none; b=gkH0apBaW2EdgMAIDJc2xmaxjIJCK7cyyQMLopc7PMbHMdfGcFjHBPgKXzqgw+UGXGdijvQQrnsKwYFd7ImJ7QhTBO/4xRCREtwBCg+v3gksGa8cxtdedQxswN/3H0lj0cQKwO0/2Lw92tW0Wza36Tgxe5pnM3In6XpVyaBFaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583080; c=relaxed/simple;
	bh=Cg4e9sH3QsKdDErCnxB//nQgYNGJ3I7kWfYuKk8n0Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnGMyF9fQtcJeoGpIVqI1WJ0OVBiLQ4aUM2vqalrx/fLQitEZnOp23/FLJMReA38buplHv4bMxozd4nEPYHPPE3ozA9KCz4PNR266LF3aY0xf8buQotgbEwRtqOKbPPdIZ/d3pnR/OuGAKNvcyzM52UvC42D4laXKOQpM0xOjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LX21yB+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2AFC433C7;
	Mon,  8 Apr 2024 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583080;
	bh=Cg4e9sH3QsKdDErCnxB//nQgYNGJ3I7kWfYuKk8n0Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LX21yB+fnOZF7faVJ2Rno/5GbYd7/MfMznCNkJePyvRUj8j9JSBh1vhZ3AhWNo+nF
	 TKqawEk5I46nDDF38ot7kOcSNdDUtRdWaEg6FsLhu1mPKi+5QrDF8f848QBMRS9sF1
	 P1zNtSXca2kDHBYhWRBrWu8n0f1INX1xXRZtljqA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	"J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5.15 205/690] SUNRPC: Change return value type of .pc_decode
Date: Mon,  8 Apr 2024 14:51:11 +0200
Message-ID: <20240408125406.964782195@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit c44b31c263798ec34614dd394c31ef1a2e7e716e ]

Returning an undecorated integer is an age-old trope, but it's
not clear (even to previous experts in this code) that the only
valid return values are 1 and 0. These functions do not return
a negative errno, rpc_stat value, or a positive length.

Document there are only two valid return values by having
.pc_decode return only true or false.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/xdr.c             |  96 +++++++++++++++---------------
 fs/lockd/xdr4.c            |  97 +++++++++++++++---------------
 fs/nfsd/nfs2acl.c          |  30 +++++-----
 fs/nfsd/nfs3acl.c          |  22 +++----
 fs/nfsd/nfs3xdr.c          | 118 ++++++++++++++++++-------------------
 fs/nfsd/nfs4xdr.c          |  22 +++----
 fs/nfsd/nfsd.h             |   2 +-
 fs/nfsd/nfssvc.c           |   6 +-
 fs/nfsd/nfsxdr.c           |  62 +++++++++----------
 fs/nfsd/xdr.h              |  20 +++----
 fs/nfsd/xdr3.h             |  30 +++++-----
 fs/nfsd/xdr4.h             |   2 +-
 include/linux/lockd/xdr.h  |  18 +++---
 include/linux/lockd/xdr4.h |  18 +++---
 include/linux/sunrpc/svc.h |   2 +-
 15 files changed, 273 insertions(+), 272 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 895f152221048..622c2ca37dbfd 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -145,103 +145,103 @@ svcxdr_encode_testrply(struct xdr_stream *xdr, const struct nlm_res *resp)
  * Decode Call arguments
  */
 
-int
+bool
 nlmsvc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	if (exclusive)
 		argp->lock.fl.fl_type = F_WRLCK;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &argp->block) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	if (exclusive)
 		argp->lock.fl.fl_type = F_WRLCK;
 	if (xdr_stream_decode_bool(xdr, &argp->reclaim) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return 0;
+		return false;
 	argp->monitor = 1;		/* monitor client by default */
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &argp->block) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	if (exclusive)
 		argp->lock.fl.fl_type = F_WRLCK;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	argp->lock.fl.fl_type = F_UNLCK;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_cookie(xdr, &resp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_decode_stats(xdr, &resp->status))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_reboot *argp = rqstp->rq_argp;
@@ -249,25 +249,25 @@ nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	u32 len;
 
 	if (xdr_stream_decode_u32(xdr, &len) < 0)
-		return 0;
+		return false;
 	if (len > SM_MAXSTRLEN)
-		return 0;
+		return false;
 	p = xdr_inline_decode(xdr, len);
 	if (!p)
-		return 0;
+		return false;
 	argp->len = len;
 	argp->mon = (char *)p;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return 0;
+		return false;
 	p = xdr_inline_decode(xdr, SM_PRIV_SIZE);
 	if (!p)
-		return 0;
+		return false;
 	memcpy(&argp->priv.data, p, sizeof(argp->priv.data));
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
@@ -278,34 +278,34 @@ nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	lock->svid = ~(u32)0;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
-		return 0;
+		return false;
 	if (!svcxdr_decode_fhandle(xdr, &lock->fh))
-		return 0;
+		return false;
 	if (!svcxdr_decode_owner(xdr, &lock->oh))
-		return 0;
+		return false;
 	/* XXX: Range checks are missing in the original code */
 	if (xdr_stream_decode_u32(xdr, &argp->fsm_mode) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->fsm_access) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_lock	*lock = &argp->lock;
 
 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 5e6885d1b92de..11d93e9de85b9 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -140,102 +140,103 @@ svcxdr_encode_testrply(struct xdr_stream *xdr, const struct nlm_res *resp)
  * Decode Call arguments
  */
 
-int
+bool
 nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	if (exclusive)
 		argp->lock.fl.fl_type = F_WRLCK;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &argp->block) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	if (exclusive)
 		argp->lock.fl.fl_type = F_WRLCK;
 	if (xdr_stream_decode_bool(xdr, &argp->reclaim) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return 0;
+		return false;
 	argp->monitor = 1;		/* monitor client by default */
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &argp->block) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	if (exclusive)
 		argp->lock.fl.fl_type = F_WRLCK;
-	return 1;
+
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	argp->lock.fl.fl_type = F_UNLCK;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_cookie(xdr, &resp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_decode_stats(xdr, &resp->status))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_reboot *argp = rqstp->rq_argp;
@@ -243,25 +244,25 @@ nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	u32 len;
 
 	if (xdr_stream_decode_u32(xdr, &len) < 0)
-		return 0;
+		return false;
 	if (len > SM_MAXSTRLEN)
-		return 0;
+		return false;
 	p = xdr_inline_decode(xdr, len);
 	if (!p)
-		return 0;
+		return false;
 	argp->len = len;
 	argp->mon = (char *)p;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return 0;
+		return false;
 	p = xdr_inline_decode(xdr, SM_PRIV_SIZE);
 	if (!p)
-		return 0;
+		return false;
 	memcpy(&argp->priv.data, p, sizeof(argp->priv.data));
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
@@ -272,34 +273,34 @@ nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	lock->svid = ~(u32)0;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
-		return 0;
+		return false;
 	if (!svcxdr_decode_fhandle(xdr, &lock->fh))
-		return 0;
+		return false;
 	if (!svcxdr_decode_owner(xdr, &lock->oh))
-		return 0;
+		return false;
 	/* XXX: Range checks are missing in the original code */
 	if (xdr_stream_decode_u32(xdr, &argp->fsm_mode) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->fsm_access) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_lock	*lock = &argp->lock;
 
 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 9bd0899455903..7b1df500e8f41 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -188,51 +188,51 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
  * XDR decode functions
  */
 
-static int
+static bool
 nfsaclsvc_decode_getaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_getaclargs *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_fhandle(xdr, &argp->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->mask) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-static int
+static bool
 nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_fhandle(xdr, &argp->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->mask) < 0)
-		return 0;
+		return false;
 	if (argp->mask & ~NFS_ACL_MASK)
-		return 0;
+		return false;
 	if (!nfs_stream_decode_acl(xdr, NULL, (argp->mask & NFS_ACL) ?
 				   &argp->acl_access : NULL))
-		return 0;
+		return false;
 	if (!nfs_stream_decode_acl(xdr, NULL, (argp->mask & NFS_DFACL) ?
 				   &argp->acl_default : NULL))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-static int
+static bool
 nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_accessargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_fhandle(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->access) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 /*
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index b1e352ed2436e..9e9f6afb2e00b 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -127,38 +127,38 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
  * XDR decode functions
  */
 
-static int
+static bool
 nfs3svc_decode_getaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_getaclargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->mask) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-static int
+static bool
 nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &argp->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->mask) < 0)
-		return 0;
+		return false;
 	if (argp->mask & ~NFS_ACL_MASK)
-		return 0;
+		return false;
 	if (!nfs_stream_decode_acl(xdr, NULL, (argp->mask & NFS_ACL) ?
 				   &argp->acl_access : NULL))
-		return 0;
+		return false;
 	if (!nfs_stream_decode_acl(xdr, NULL, (argp->mask & NFS_DFACL) ?
 				   &argp->acl_default : NULL))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 /*
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index b4a36989b3e24..a1395049db9f8 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -546,7 +546,7 @@ void fill_post_wcc(struct svc_fh *fhp)
  * XDR decode functions
  */
 
-int
+bool
 nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_fhandle *args = rqstp->rq_argp;
@@ -554,7 +554,7 @@ nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return svcxdr_decode_nfs_fh3(xdr, &args->fh);
 }
 
-int
+bool
 nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_sattrargs *args = rqstp->rq_argp;
@@ -564,7 +564,7 @@ nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_decode_sattrguard3(xdr, args);
 }
 
-int
+bool
 nfs3svc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_diropargs *args = rqstp->rq_argp;
@@ -572,75 +572,75 @@ nfs3svc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len);
 }
 
-int
+bool
 nfs3svc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_accessargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->access) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_readargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u64(xdr, &args->offset) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_writeargs *args = rqstp->rq_argp;
 	u32 max_blocksize = svc_max_payload(rqstp);
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u64(xdr, &args->offset) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->stable) < 0)
-		return 0;
+		return false;
 
 	/* opaque data */
 	if (xdr_stream_decode_u32(xdr, &args->len) < 0)
-		return 0;
+		return false;
 
 	/* request sanity */
 	if (args->count != args->len)
-		return 0;
+		return false;
 	if (args->count > max_blocksize) {
 		args->count = max_blocksize;
 		args->len = max_blocksize;
 	}
 	if (!xdr_stream_subsegment(xdr, &args->payload, args->count))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_createargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->createmode) < 0)
-		return 0;
+		return false;
 	switch (args->createmode) {
 	case NFS3_CREATE_UNCHECKED:
 	case NFS3_CREATE_GUARDED:
@@ -648,15 +648,15 @@ nfs3svc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	case NFS3_CREATE_EXCLUSIVE:
 		args->verf = xdr_inline_decode(xdr, NFS3_CREATEVERFSIZE);
 		if (!args->verf)
-			return 0;
+			return false;
 		break;
 	default:
-		return 0;
+		return false;
 	}
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_createargs *args = rqstp->rq_argp;
@@ -666,7 +666,7 @@ nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_decode_sattr3(rqstp, xdr, &args->attrs);
 }
 
-int
+bool
 nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_symlinkargs *args = rqstp->rq_argp;
@@ -675,33 +675,33 @@ nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	size_t remaining;
 
 	if (!svcxdr_decode_diropargs3(xdr, &args->ffh, &args->fname, &args->flen))
-		return 0;
+		return false;
 	if (!svcxdr_decode_sattr3(rqstp, xdr, &args->attrs))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->tlen) < 0)
-		return 0;
+		return false;
 
 	/* request sanity */
 	remaining = head->iov_len + rqstp->rq_arg.page_len + tail->iov_len;
 	remaining -= xdr_stream_pos(xdr);
 	if (remaining < xdr_align_size(args->tlen))
-		return 0;
+		return false;
 
 	args->first.iov_base = xdr->p;
 	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_mknodargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->ftype) < 0)
-		return 0;
+		return false;
 	switch (args->ftype) {
 	case NF3CHR:
 	case NF3BLK:
@@ -715,13 +715,13 @@ nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		/* Valid XDR but illegal file types */
 		break;
 	default:
-		return 0;
+		return false;
 	}
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_renameargs *args = rqstp->rq_argp;
@@ -732,7 +732,7 @@ nfs3svc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 					 &args->tname, &args->tlen);
 }
 
-int
+bool
 nfs3svc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_linkargs *args = rqstp->rq_argp;
@@ -742,59 +742,59 @@ nfs3svc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 					 &args->tname, &args->tlen);
 }
 
-int
+bool
 nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_readdirargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u64(xdr, &args->cookie) < 0)
-		return 0;
+		return false;
 	args->verf = xdr_inline_decode(xdr, NFS3_COOKIEVERFSIZE);
 	if (!args->verf)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_readdirargs *args = rqstp->rq_argp;
 	u32 dircount;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u64(xdr, &args->cookie) < 0)
-		return 0;
+		return false;
 	args->verf = xdr_inline_decode(xdr, NFS3_COOKIEVERFSIZE);
 	if (!args->verf)
-		return 0;
+		return false;
 	/* dircount is ignored */
 	if (xdr_stream_decode_u32(xdr, &dircount) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_commitargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u64(xdr, &args->offset) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 /*
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ec052e88d9008..9fcaf5f93f75d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2319,7 +2319,7 @@ nfsd4_opnum_in_range(struct nfsd4_compoundargs *argp, struct nfsd4_op *op)
 	return true;
 }
 
-static int
+static bool
 nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 {
 	struct nfsd4_op *op;
@@ -2332,25 +2332,25 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	int i;
 
 	if (xdr_stream_decode_u32(argp->xdr, &argp->taglen) < 0)
-		return 0;
+		return false;
 	max_reply += XDR_UNIT;
 	argp->tag = NULL;
 	if (unlikely(argp->taglen)) {
 		if (argp->taglen > NFSD4_MAX_TAGLEN)
-			return 0;
+			return false;
 		p = xdr_inline_decode(argp->xdr, argp->taglen);
 		if (!p)
-			return 0;
+			return false;
 		argp->tag = svcxdr_savemem(argp, p, argp->taglen);
 		if (!argp->tag)
-			return 0;
+			return false;
 		max_reply += xdr_align_size(argp->taglen);
 	}
 
 	if (xdr_stream_decode_u32(argp->xdr, &argp->minorversion) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(argp->xdr, &argp->client_opcnt) < 0)
-		return 0;
+		return false;
 
 	argp->opcnt = min_t(u32, argp->client_opcnt,
 			    NFSD_MAX_OPS_PER_COMPOUND);
@@ -2360,7 +2360,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 		if (!argp->ops) {
 			argp->ops = argp->iops;
 			dprintk("nfsd: couldn't allocate room for COMPOUND\n");
-			return 0;
+			return false;
 		}
 	}
 
@@ -2373,7 +2373,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 		op->opdesc = NULL;
 
 		if (xdr_stream_decode_u32(argp->xdr, &op->opnum) < 0)
-			return 0;
+			return false;
 		if (nfsd4_opnum_in_range(argp, op)) {
 			op->opdesc = OPDESC(op);
 			op->status = nfsd4_dec_ops[op->opnum](argp, &op->u);
@@ -2421,7 +2421,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	if (readcount > 1 || max_reply > PAGE_SIZE - auth_slack)
 		clear_bit(RQ_SPLICE_OK, &argp->rqstp->rq_flags);
 
-	return 1;
+	return true;
 }
 
 static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
@@ -5412,7 +5412,7 @@ void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 	}
 }
 
-int
+bool
 nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd4_compoundargs *args = rqstp->rq_argp;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 6e8ad5f9757c8..bfcddd4c75345 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -78,7 +78,7 @@ extern const struct seq_operations nfs_exports_op;
  */
 struct nfsd_voidargs { };
 struct nfsd_voidres { };
-int		nfssvc_decode_voidarg(struct svc_rqst *rqstp,
+bool		nfssvc_decode_voidarg(struct svc_rqst *rqstp,
 				      struct xdr_stream *xdr);
 int		nfssvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p);
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index be1d656548cfe..00aadc2635032 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1067,10 +1067,10 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
  * @xdr: XDR stream positioned at arguments to decode
  *
  * Return values:
- *   %0: Arguments were not valid
- *   %1: Decoding was successful
+ *   %false: Arguments were not valid
+ *   %true: Decoding was successful
  */
-int nfssvc_decode_voidarg(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+bool nfssvc_decode_voidarg(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	return 1;
 }
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 08e899180ee43..b5817a41b3de6 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -272,7 +272,7 @@ svcxdr_encode_fattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
  * XDR decode functions
  */
 
-int
+bool
 nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_fhandle *args = rqstp->rq_argp;
@@ -280,7 +280,7 @@ nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return svcxdr_decode_fhandle(xdr, &args->fh);
 }
 
-int
+bool
 nfssvc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_sattrargs *args = rqstp->rq_argp;
@@ -289,7 +289,7 @@ nfssvc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_decode_sattr(rqstp, xdr, &args->attrs);
 }
 
-int
+bool
 nfssvc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_diropargs *args = rqstp->rq_argp;
@@ -297,54 +297,54 @@ nfssvc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return svcxdr_decode_diropargs(xdr, &args->fh, &args->name, &args->len);
 }
 
-int
+bool
 nfssvc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_readargs *args = rqstp->rq_argp;
 	u32 totalcount;
 
 	if (!svcxdr_decode_fhandle(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->offset) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
-		return 0;
+		return false;
 	/* totalcount is ignored */
 	if (xdr_stream_decode_u32(xdr, &totalcount) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfssvc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_writeargs *args = rqstp->rq_argp;
 	u32 beginoffset, totalcount;
 
 	if (!svcxdr_decode_fhandle(xdr, &args->fh))
-		return 0;
+		return false;
 	/* beginoffset is ignored */
 	if (xdr_stream_decode_u32(xdr, &beginoffset) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->offset) < 0)
-		return 0;
+		return false;
 	/* totalcount is ignored */
 	if (xdr_stream_decode_u32(xdr, &totalcount) < 0)
-		return 0;
+		return false;
 
 	/* opaque data */
 	if (xdr_stream_decode_u32(xdr, &args->len) < 0)
-		return 0;
+		return false;
 	if (args->len > NFSSVC_MAXBLKSIZE_V2)
-		return 0;
+		return false;
 	if (!xdr_stream_subsegment(xdr, &args->payload, args->len))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfssvc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_createargs *args = rqstp->rq_argp;
@@ -354,7 +354,7 @@ nfssvc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_decode_sattr(rqstp, xdr, &args->attrs);
 }
 
-int
+bool
 nfssvc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_renameargs *args = rqstp->rq_argp;
@@ -365,7 +365,7 @@ nfssvc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 					&args->tname, &args->tlen);
 }
 
-int
+bool
 nfssvc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_linkargs *args = rqstp->rq_argp;
@@ -375,39 +375,39 @@ nfssvc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 					&args->tname, &args->tlen);
 }
 
-int
+bool
 nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_symlinkargs *args = rqstp->rq_argp;
 	struct kvec *head = rqstp->rq_arg.head;
 
 	if (!svcxdr_decode_diropargs(xdr, &args->ffh, &args->fname, &args->flen))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->tlen) < 0)
-		return 0;
+		return false;
 	if (args->tlen == 0)
-		return 0;
+		return false;
 
 	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
 	args->first.iov_base = xdr_inline_decode(xdr, args->tlen);
 	if (!args->first.iov_base)
-		return 0;
+		return false;
 	return svcxdr_decode_sattr(rqstp, xdr, &args->attrs);
 }
 
-int
+bool
 nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_readdirargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_fhandle(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->cookie) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 /*
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 19e281382bb98..d897c198c9126 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -141,16 +141,16 @@ union nfsd_xdrstore {
 #define NFS2_SVC_XDRSIZE	sizeof(union nfsd_xdrstore)
 
 
-int nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 int nfssvc_encode_statres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_attrstatres(struct svc_rqst *, __be32 *);
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 60a8909205e5a..ef72bc4868da6 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -265,21 +265,21 @@ union nfsd3_xdrstore {
 
 #define NFS3_SVC_XDRSIZE		sizeof(union nfsd3_xdrstore)
 
-int nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 int nfs3svc_encode_getattrres(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_wccstat(struct svc_rqst *, __be32 *);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 4c22eecd65de0..50242d8cd09e8 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -757,7 +757,7 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 
 
 bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqstp);
-int nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 int nfs4svc_encode_compoundres(struct svc_rqst *, __be32 *);
 __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *, u32);
 void nfsd4_encode_operation(struct nfsd4_compoundres *, struct nfsd4_op *);
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index 931bd0b064e6f..a3d0bc4fd2109 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -98,15 +98,15 @@ struct nlm_reboot {
  */
 #define NLMSVC_XDRSIZE		sizeof(struct nlm_args)
 
-int	nlmsvc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 int	nlmsvc_encode_testres(struct svc_rqst *, __be32 *);
 int	nlmsvc_encode_res(struct svc_rqst *, __be32 *);
diff --git a/include/linux/lockd/xdr4.h b/include/linux/lockd/xdr4.h
index 44c9d03d261b9..6eec19629cd69 100644
--- a/include/linux/lockd/xdr4.h
+++ b/include/linux/lockd/xdr4.h
@@ -23,15 +23,15 @@
 #define	nlm4_failed		cpu_to_be32(NLM_FAILED)
 
 void	nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 len);
-int	nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 int	nlm4svc_encode_testres(struct svc_rqst *, __be32 *);
 int	nlm4svc_encode_res(struct svc_rqst *, __be32 *);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index f74ac0fdd5f32..2bb68625bc76c 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -456,7 +456,7 @@ struct svc_procedure {
 	/* process the request: */
 	__be32			(*pc_func)(struct svc_rqst *);
 	/* XDR decode args: */
-	int			(*pc_decode)(struct svc_rqst *rqstp,
+	bool			(*pc_decode)(struct svc_rqst *rqstp,
 					     struct xdr_stream *xdr);
 	/* XDR encode result: */
 	int			(*pc_encode)(struct svc_rqst *, __be32 *data);
-- 
2.43.0




