Return-Path: <stable+bounces-53227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A636590D0C3
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C29D2875CF
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092BD1662F1;
	Tue, 18 Jun 2024 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lOzJvTZZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949515443F;
	Tue, 18 Jun 2024 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715704; cv=none; b=NgdGeMKzDJv9CfT63ei2FLvTK0V0WeMQXP0EYKRS06Z43v3gck/M6cGL+PrC0J0yiIDWk1j+pDJyvgoTIu+XpvrfIl5FIF/IAcdrz5L5CN4KjfKLN3yrgsvpzfLGz63O6e5CwagpiNgB+YcHl1ayUxyZhC2k1unmYvipI2SRAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715704; c=relaxed/simple;
	bh=gKSBxv0tb1WFScUNreBa+OFtA+m7sb96YPtiFNefu5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQASpuyPhU8c60LPNN+qbFofyMORrmEW7FdwKyvlYTM8FdULZt4sVnWEmTRmFUpmVnS+IZ0kY7VIgjEl1NIyRRb7XC+CU9lt/suasLyGnj1jo9CRUpJx5+BVU19cmPt5xtCXrDCjwxymXI+6Hfc+SwfVW5Pg4jI/2RkfkDZ1WKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lOzJvTZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B849CC3277B;
	Tue, 18 Jun 2024 13:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715704;
	bh=gKSBxv0tb1WFScUNreBa+OFtA+m7sb96YPtiFNefu5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lOzJvTZZ1RKGo2VSuulVE7s80wutGNc0+MYai1cbKywiDpZ9Wa+mE6vdRLzMfRIbO
	 +TaE1aEnjv6Seq+kM9+mu2JdEy4WmlEUe/5TPsmgr0rkPOvrkV/C5AFfBEGX6zrQH5
	 QJFIDmxtF3wxBq3x8cVSaDPPkbKVb2rRbhzpffBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 398/770] SUNRPC: Replace the "__be32 *p" parameter to .pc_encode
Date: Tue, 18 Jun 2024 14:34:11 +0200
Message-ID: <20240618123422.642963403@linuxfoundation.org>
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

[ Upstream commit fda494411485aff91768842c532f90fb8eb54943 ]

The passed-in value of the "__be32 *p" parameter is now unused in
every server-side XDR encoder, and can be removed.

Note also that there is a line in each encoder that sets up a local
pointer to a struct xdr_stream. Passing that pointer from the
dispatcher instead saves one line per encoder function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index 45551dee26b41..32231c21c22dd 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -313,15 +313,14 @@ nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
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
@@ -329,9 +328,8 @@ nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_encode_res(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
@@ -339,9 +337,8 @@ nlm4svc_encode_res(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_encode_shareres(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_cookie(xdr, &resp->cookie))
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 600e640682401..c58b3b60bc2c0 100644
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
index eb6a89baf675f..23e4c3eb2c381 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -238,9 +238,9 @@ nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
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
@@ -278,9 +278,9 @@ static int nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
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
index f60b072ce9ecc..21aacba88ea3e 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -164,9 +164,9 @@ nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
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
@@ -216,9 +216,9 @@ static int nfs3svc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
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
index 1f3de46d24d46..63f0be4e44f70 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -813,9 +813,8 @@ nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 
 /* GETATTR */
 int
-nfs3svc_encode_getattrres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_getattrres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -833,9 +832,8 @@ nfs3svc_encode_getattrres(struct svc_rqst *rqstp, __be32 *p)
 
 /* SETATTR, REMOVE, RMDIR */
 int
-nfs3svc_encode_wccstat(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_wccstat(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_nfsstat3(xdr, resp->status) &&
@@ -843,9 +841,9 @@ nfs3svc_encode_wccstat(struct svc_rqst *rqstp, __be32 *p)
 }
 
 /* LOOKUP */
-int nfs3svc_encode_lookupres(struct svc_rqst *rqstp, __be32 *p)
+int
+nfs3svc_encode_lookupres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -869,9 +867,8 @@ int nfs3svc_encode_lookupres(struct svc_rqst *rqstp, __be32 *p)
 
 /* ACCESS */
 int
-nfs3svc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -893,9 +890,8 @@ nfs3svc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
 
 /* READLINK */
 int
-nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_readlinkres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
@@ -921,9 +917,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 
 /* READ */
 int
-nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_readres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
@@ -954,9 +949,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 
 /* WRITE */
 int
-nfs3svc_encode_writeres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_writeres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_writeres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -982,9 +976,8 @@ nfs3svc_encode_writeres(struct svc_rqst *rqstp, __be32 *p)
 
 /* CREATE, MKDIR, SYMLINK, MKNOD */
 int
-nfs3svc_encode_createres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_createres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -1008,9 +1001,8 @@ nfs3svc_encode_createres(struct svc_rqst *rqstp, __be32 *p)
 
 /* RENAME */
 int
-nfs3svc_encode_renameres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_renameres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_renameres *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_nfsstat3(xdr, resp->status) &&
@@ -1020,9 +1012,8 @@ nfs3svc_encode_renameres(struct svc_rqst *rqstp, __be32 *p)
 
 /* LINK */
 int
-nfs3svc_encode_linkres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_linkres *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_nfsstat3(xdr, resp->status) &&
@@ -1032,9 +1023,8 @@ nfs3svc_encode_linkres(struct svc_rqst *rqstp, __be32 *p)
 
 /* READDIR */
 int
-nfs3svc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_readdirres *resp = rqstp->rq_resp;
 	struct xdr_buf *dirlist = &resp->dirlist;
 
@@ -1286,9 +1276,8 @@ svcxdr_encode_fsstat3resok(struct xdr_stream *xdr,
 
 /* FSSTAT */
 int
-nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_fsstatres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -1333,9 +1322,8 @@ svcxdr_encode_fsinfo3resok(struct xdr_stream *xdr,
 
 /* FSINFO */
 int
-nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_fsinfores *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -1376,9 +1364,8 @@ svcxdr_encode_pathconf3resok(struct xdr_stream *xdr,
 
 /* PATHCONF */
 int
-nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_pathconfres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -1400,9 +1387,8 @@ nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, __be32 *p)
 
 /* COMMIT */
 int
-nfs3svc_encode_commitres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_commitres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_commitres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3f8d23586ea79..697d61819a59d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5438,10 +5438,11 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
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
@@ -5454,7 +5455,7 @@ nfs4svc_encode_compoundres(struct svc_rqst *rqstp, __be32 *p)
 
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
index 8e11dfdc2563a..5b343d0c6963a 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -758,7 +758,7 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 
 bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqstp);
 bool nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs4svc_encode_compoundres(struct svc_rqst *, __be32 *);
+int nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *, u32);
 void nfsd4_encode_operation(struct nfsd4_compoundres *, struct nfsd4_op *);
 void nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op);
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index e1362244f909b..d8bd26a5525ef 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -106,9 +106,9 @@ bool	nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
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
index 376b8f6a3763a..50677be3557dc 100644
--- a/include/linux/lockd/xdr4.h
+++ b/include/linux/lockd/xdr4.h
@@ -32,10 +32,10 @@ bool	nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
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
index 85a9884b10743..c6a0b4364f4a2 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -460,7 +460,8 @@ struct svc_procedure {
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




