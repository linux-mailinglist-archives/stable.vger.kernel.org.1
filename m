Return-Path: <stable+bounces-37048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3766589C305
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7961C21E7A
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12367F49A;
	Mon,  8 Apr 2024 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nXd4xEXJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6FC7F482;
	Mon,  8 Apr 2024 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583101; cv=none; b=nEMaeYjDFiM70BUY51ms4PVWPy66+82tJkppFBbOlWPD/VGZBivrfsmoNTVhi3PUlcfR9R+D70WG9M6ulJz71RrV9ZlJOuYcGn9/c4xHEAIQ751sd1+A6DZ/tB8XsqE8oqbCC9WW17eWX7VduhQL4ebmTv48wSg8iYR177FG4FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583101; c=relaxed/simple;
	bh=H6ojv8RohefuCnGUArboZeGC385IvqLdqGNDZCimgFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh0ohan4xylbZUE2jO/vUbIjUwX+exaIXOHM8PdybsVwgD0iJMIfhXFxc8BiospUEvwGrjv4rsbQxHGxg91VndpzvcZTxepiyGjChxp0cGPdQrv3RKRCAkC4URRJL8EQN2vUzvgx7PHmxB8QC+p9u30xufNl19uzPd7UvIt83bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nXd4xEXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D993C433C7;
	Mon,  8 Apr 2024 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583101;
	bh=H6ojv8RohefuCnGUArboZeGC385IvqLdqGNDZCimgFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXd4xEXJdfN2yw+VQrbbOS1NbhEsbQf1IZ45RUPWiu5wVPiYLyOWCS4wfwRE+SpKI
	 rr4fVgE+S6HC05uG7b3vmnn2celY3G20x9ksiFboDljDwa8mir85ZYrdmh5lzfeGaF
	 1k13XmKU12/6KAGHs/Jq0eBjoCl33Se/TVVVIt0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	"J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5.15 207/690] SUNRPC: Replace the "__be32 *p" parameter to .pc_encode
Date: Mon,  8 Apr 2024 14:51:13 +0200
Message-ID: <20240408125407.026696299@linuxfoundation.org>
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

[ Upstream commit fda494411485aff91768842c532f90fb8eb54943 ]

The passed-in value of the "__be32 *p" parameter is now unused in
every server-side XDR encoder, and can be removed.

Note also that there is a line in each encoder that sets up a local
pointer to a struct xdr_stream. Passing that pointer from the
dispatcher instead saves one line per encoder function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c             |  3 +--
 fs/lockd/xdr.c             | 11 ++++-----
 fs/lockd/xdr4.c            | 11 ++++-----
 fs/nfs/callback_xdr.c      |  4 ++--
 fs/nfsd/nfs2acl.c          |  8 +++----
 fs/nfsd/nfs3acl.c          |  8 +++----
 fs/nfsd/nfs3xdr.c          | 46 +++++++++++++-------------------------
 fs/nfsd/nfs4xdr.c          |  7 +++---
 fs/nfsd/nfsd.h             |  3 ++-
 fs/nfsd/nfssvc.c           |  9 +++-----
 fs/nfsd/nfsxdr.c           | 22 +++++++-----------
 fs/nfsd/xdr.h              | 14 ++++++------
 fs/nfsd/xdr3.h             | 30 ++++++++++++-------------
 fs/nfsd/xdr4.h             |  2 +-
 include/linux/lockd/xdr.h  |  8 +++----
 include/linux/lockd/xdr4.h |  8 +++----
 include/linux/sunrpc/svc.h |  3 ++-
 17 files changed, 85 insertions(+), 112 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 9a82471bda071..b220e1b917268 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -780,7 +780,6 @@ module_exit(exit_nlm);
 static int nlmsvc_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *procp = rqstp->rq_procinfo;
-	struct kvec *resv = rqstp->rq_res.head;
 
 	svcxdr_init_decode(rqstp);
 	if (!procp->pc_decode(rqstp, &rqstp->rq_arg_stream))
@@ -793,7 +792,7 @@ static int nlmsvc_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 		return 1;
 
 	svcxdr_init_encode(rqstp);
-	if (!procp->pc_encode(rqstp, resv->iov_base + resv->iov_len))
+	if (!procp->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
 	return 1;
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 622c2ca37dbfd..2595b4d14cd44 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -314,15 +314,14 @@ nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 int
-nlmsvc_encode_void(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	return 1;
 }
 
 int
-nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
@@ -330,9 +329,8 @@ nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlmsvc_encode_res(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
@@ -340,9 +338,8 @@ nlmsvc_encode_res(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlmsvc_encode_shareres(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_cookie(xdr, &resp->cookie))
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 11d93e9de85b9..4c04b1e2bd9d8 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -309,15 +309,14 @@ nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 int
-nlm4svc_encode_void(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	return 1;
 }
 
 int
-nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
@@ -325,9 +324,8 @@ nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_encode_res(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
@@ -335,9 +333,8 @@ nlm4svc_encode_res(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_encode_shareres(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_cookie(xdr, &resp->cookie))
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index ea17085ef884b..688d58c036de7 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -67,9 +67,9 @@ static __be32 nfs4_callback_null(struct svc_rqst *rqstp)
  * svc_process_common() looks for an XDR encoder to know when
  * not to drop a Reply.
  */
-static int nfs4_encode_void(struct svc_rqst *rqstp, __be32 *p)
+static int nfs4_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return xdr_ressize_check(rqstp, p);
+	return 1;
 }
 
 static __be32 decode_string(struct xdr_stream *xdr, unsigned int *len,
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 7b1df500e8f41..cbd042fbe0f39 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -240,9 +240,9 @@ nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 /* GETACL */
-static int nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
+static int
+nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
 	struct dentry *dentry = resp->fh.fh_dentry;
 	struct inode *inode;
@@ -270,9 +270,9 @@ static int nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 /* ACCESS */
-static int nfsaclsvc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
+static int
+nfsaclsvc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 9e9f6afb2e00b..e186467b63ecb 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -166,9 +166,9 @@ nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 /* GETACL */
-static int nfs3svc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
+static int
+nfs3svc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
 	struct dentry *dentry = resp->fh.fh_dentry;
 	struct kvec *head = rqstp->rq_res.head;
@@ -218,9 +218,9 @@ static int nfs3svc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 /* SETACL */
-static int nfs3svc_encode_setaclres(struct svc_rqst *rqstp, __be32 *p)
+static int
+nfs3svc_encode_setaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_nfsstat3(xdr, resp->status) &&
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index a1395049db9f8..dd87076a8b0d7 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -803,9 +803,8 @@ nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 
 /* GETATTR */
 int
-nfs3svc_encode_getattrres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_getattrres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -823,9 +822,8 @@ nfs3svc_encode_getattrres(struct svc_rqst *rqstp, __be32 *p)
 
 /* SETATTR, REMOVE, RMDIR */
 int
-nfs3svc_encode_wccstat(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_wccstat(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_nfsstat3(xdr, resp->status) &&
@@ -833,9 +831,9 @@ nfs3svc_encode_wccstat(struct svc_rqst *rqstp, __be32 *p)
 }
 
 /* LOOKUP */
-int nfs3svc_encode_lookupres(struct svc_rqst *rqstp, __be32 *p)
+int
+nfs3svc_encode_lookupres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -859,9 +857,8 @@ int nfs3svc_encode_lookupres(struct svc_rqst *rqstp, __be32 *p)
 
 /* ACCESS */
 int
-nfs3svc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -883,9 +880,8 @@ nfs3svc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
 
 /* READLINK */
 int
-nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_readlinkres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
@@ -911,9 +907,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 
 /* READ */
 int
-nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_readres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
@@ -944,9 +939,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 
 /* WRITE */
 int
-nfs3svc_encode_writeres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_writeres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_writeres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -972,9 +966,8 @@ nfs3svc_encode_writeres(struct svc_rqst *rqstp, __be32 *p)
 
 /* CREATE, MKDIR, SYMLINK, MKNOD */
 int
-nfs3svc_encode_createres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_createres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -998,9 +991,8 @@ nfs3svc_encode_createres(struct svc_rqst *rqstp, __be32 *p)
 
 /* RENAME */
 int
-nfs3svc_encode_renameres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_renameres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_renameres *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_nfsstat3(xdr, resp->status) &&
@@ -1010,9 +1002,8 @@ nfs3svc_encode_renameres(struct svc_rqst *rqstp, __be32 *p)
 
 /* LINK */
 int
-nfs3svc_encode_linkres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_linkres *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_nfsstat3(xdr, resp->status) &&
@@ -1022,9 +1013,8 @@ nfs3svc_encode_linkres(struct svc_rqst *rqstp, __be32 *p)
 
 /* READDIR */
 int
-nfs3svc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_readdirres *resp = rqstp->rq_resp;
 	struct xdr_buf *dirlist = &resp->dirlist;
 
@@ -1276,9 +1266,8 @@ svcxdr_encode_fsstat3resok(struct xdr_stream *xdr,
 
 /* FSSTAT */
 int
-nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_fsstatres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -1323,9 +1312,8 @@ svcxdr_encode_fsinfo3resok(struct xdr_stream *xdr,
 
 /* FSINFO */
 int
-nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_fsinfores *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -1366,9 +1354,8 @@ svcxdr_encode_pathconf3resok(struct xdr_stream *xdr,
 
 /* PATHCONF */
 int
-nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_pathconfres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -1390,9 +1377,8 @@ nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, __be32 *p)
 
 /* COMMIT */
 int
-nfs3svc_encode_commitres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_commitres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_commitres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e94f57f174f12..cc2367a6922a6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5428,10 +5428,11 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 }
 
 int
-nfs4svc_encode_compoundres(struct svc_rqst *rqstp, __be32 *p)
+nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
-	struct xdr_buf *buf = resp->xdr->buf;
+	struct xdr_buf *buf = xdr->buf;
+	__be32 *p;
 
 	WARN_ON_ONCE(buf->len != buf->head[0].iov_len + buf->page_len +
 				 buf->tail[0].iov_len);
@@ -5444,7 +5445,7 @@ nfs4svc_encode_compoundres(struct svc_rqst *rqstp, __be32 *p)
 
 	*p++ = resp->cstate.status;
 
-	rqstp->rq_next_page = resp->xdr->page_ptr + 1;
+	rqstp->rq_next_page = xdr->page_ptr + 1;
 
 	*p++ = htonl(resp->taglen);
 	memcpy(p, resp->tag, resp->taglen);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index bfcddd4c75345..345f8247d5da9 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -80,7 +80,8 @@ struct nfsd_voidargs { };
 struct nfsd_voidres { };
 bool		nfssvc_decode_voidarg(struct svc_rqst *rqstp,
 				      struct xdr_stream *xdr);
-int		nfssvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p);
+int		nfssvc_encode_voidres(struct svc_rqst *rqstp,
+				      struct xdr_stream *xdr);
 
 /*
  * Function prototypes.
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 00aadc2635032..195f2bcc65384 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1004,8 +1004,6 @@ nfsd(void *vrqstp)
 int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
-	struct kvec *resv = &rqstp->rq_res.head[0];
-	__be32 *p;
 
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
@@ -1030,14 +1028,13 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 * Need to grab the location to store the status, as
 	 * NFSv4 does some encoding while processing
 	 */
-	p = resv->iov_base + resv->iov_len;
 	svcxdr_init_encode(rqstp);
 
 	*statp = proc->pc_func(rqstp);
 	if (*statp == rpc_drop_reply || test_bit(RQ_DROPME, &rqstp->rq_flags))
 		goto out_update_drop;
 
-	if (!proc->pc_encode(rqstp, p))
+	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
 	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
@@ -1078,13 +1075,13 @@ bool nfssvc_decode_voidarg(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 /**
  * nfssvc_encode_voidres - Encode void results
  * @rqstp: Server RPC transaction context
- * @p: buffer in which to encode results
+ * @xdr: XDR stream into which to encode results
  *
  * Return values:
  *   %0: Local error while encoding
  *   %1: Encoding was successful
  */
-int nfssvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p)
+int nfssvc_encode_voidres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	return 1;
 }
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index b5817a41b3de6..6aa8138ae2f7d 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -415,18 +415,16 @@ nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 int
-nfssvc_encode_statres(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_statres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_stat(xdr, resp->status);
 }
 
 int
-nfssvc_encode_attrstatres(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_attrstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
@@ -442,9 +440,8 @@ nfssvc_encode_attrstatres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_encode_diropres(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_diropres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_diropres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
@@ -462,9 +459,8 @@ nfssvc_encode_diropres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_readlinkres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
@@ -484,9 +480,8 @@ nfssvc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_readres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
@@ -509,9 +504,8 @@ nfssvc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
 	struct xdr_buf *dirlist = &resp->dirlist;
 
@@ -532,11 +526,11 @@ nfssvc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_encode_statfsres(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_statfsres *resp = rqstp->rq_resp;
 	struct kstatfs	*stat = &resp->stats;
+	__be32 *p;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
 		return 0;
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index d897c198c9126..bff7258041fc4 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -152,13 +152,13 @@ bool nfssvc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int nfssvc_encode_statres(struct svc_rqst *, __be32 *);
-int nfssvc_encode_attrstatres(struct svc_rqst *, __be32 *);
-int nfssvc_encode_diropres(struct svc_rqst *, __be32 *);
-int nfssvc_encode_readlinkres(struct svc_rqst *, __be32 *);
-int nfssvc_encode_readres(struct svc_rqst *, __be32 *);
-int nfssvc_encode_statfsres(struct svc_rqst *, __be32 *);
-int nfssvc_encode_readdirres(struct svc_rqst *, __be32 *);
+int nfssvc_encode_statres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_encode_attrstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_encode_diropres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 void nfssvc_encode_nfscookie(struct nfsd_readdirres *resp, u32 offset);
 int nfssvc_encode_entry(void *data, const char *name, int namlen,
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index ef72bc4868da6..bb017fc7cba19 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -281,21 +281,21 @@ bool nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int nfs3svc_encode_getattrres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_wccstat(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_lookupres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_accessres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_readlinkres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_readres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_writeres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_createres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_renameres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_linkres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_readdirres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_fsstatres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_fsinfores(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_pathconfres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_commitres(struct svc_rqst *, __be32 *);
+int nfs3svc_encode_getattrres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_wccstat(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_lookupres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_writeres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_createres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_renameres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_commitres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 void nfs3svc_release_fhandle(struct svc_rqst *);
 void nfs3svc_release_fhandle2(struct svc_rqst *);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index f20c1ae97fec5..9921915b4c163 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -759,7 +759,7 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 
 bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqstp);
 bool nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs4svc_encode_compoundres(struct svc_rqst *, __be32 *);
+int nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *, u32);
 void nfsd4_encode_operation(struct nfsd4_compoundres *, struct nfsd4_op *);
 void nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op);
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index a3d0bc4fd2109..94f1ca900ca3a 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -108,9 +108,9 @@ bool	nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int	nlmsvc_encode_testres(struct svc_rqst *, __be32 *);
-int	nlmsvc_encode_res(struct svc_rqst *, __be32 *);
-int	nlmsvc_encode_void(struct svc_rqst *, __be32 *);
-int	nlmsvc_encode_shareres(struct svc_rqst *, __be32 *);
+int	nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 #endif /* LOCKD_XDR_H */
diff --git a/include/linux/lockd/xdr4.h b/include/linux/lockd/xdr4.h
index 6eec19629cd69..ee44d7357a7f7 100644
--- a/include/linux/lockd/xdr4.h
+++ b/include/linux/lockd/xdr4.h
@@ -33,10 +33,10 @@ bool	nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int	nlm4svc_encode_testres(struct svc_rqst *, __be32 *);
-int	nlm4svc_encode_res(struct svc_rqst *, __be32 *);
-int	nlm4svc_encode_void(struct svc_rqst *, __be32 *);
-int	nlm4svc_encode_shareres(struct svc_rqst *, __be32 *);
+int	nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlm4svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 extern const struct rpc_version nlm_version4;
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 2bb68625bc76c..dc6fc8940261f 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -459,7 +459,8 @@ struct svc_procedure {
 	bool			(*pc_decode)(struct svc_rqst *rqstp,
 					     struct xdr_stream *xdr);
 	/* XDR encode result: */
-	int			(*pc_encode)(struct svc_rqst *, __be32 *data);
+	int			(*pc_encode)(struct svc_rqst *rqstp,
+					     struct xdr_stream *xdr);
 	/* XDR free result: */
 	void			(*pc_release)(struct svc_rqst *);
 	unsigned int		pc_argsize;	/* argument struct size */
-- 
2.43.0




