Return-Path: <stable+bounces-37051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDCE89C308
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CFB282CDE
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46CA6D1A9;
	Mon,  8 Apr 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rrCYdlKe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B517F7C9;
	Mon,  8 Apr 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583110; cv=none; b=GOIl1ywo665VSGXHEYYADp/E1/QaO8cpU6VPjP0cHVpJcDO3anHdIU2ciITpixDl6b+mCde5zxsfR45oQ1TyJlAHgzYQJUmqh+jDb9Mn2P6W1kDB/OR4FfCNtRGQ47iaa8bjHV0rKqp2/A80V092qPSstcEiBUusldqf+Lpcauw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583110; c=relaxed/simple;
	bh=kHVgpjfX0K4n0iLPTiVbJan3DcRaha3NkfzFVFXMqaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNi63uG/SW4WSGKHZYkRKbDMTImNw/R3SbyWjWBjzrFahuHLNZGYS4tUBgZ11KedtSWp5oQDfZjEsRaPZlYD1JRB/GEx8XB6U2Ui0DMRWvsNhskQ4004OgsTObcis9tbETa9zAObQ7HyecgkC1vXQ10n7IIzu36Nk4LHJCAWXxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rrCYdlKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FDBC433F1;
	Mon,  8 Apr 2024 13:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583110;
	bh=kHVgpjfX0K4n0iLPTiVbJan3DcRaha3NkfzFVFXMqaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrCYdlKe+KBw+tmQGC0878zHoAaIsGL+cDYPT7CEx2C4jPr/SLWtNiGWfZ4Gqqm5i
	 qMp67+QqA5wc6dClQwjdWiO5nyZsZDd3jA5jkIM5Thl7hd835gRHTkUuz8pL+sPDT9
	 nFHMlRYqxInt8FkWmIuD2RT0TLfldaSCoH7X5p1o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	"J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5.15 208/690] SUNRPC: Change return value type of .pc_encode
Date: Mon,  8 Apr 2024 14:51:14 +0200
Message-ID: <20240408125407.061706475@linuxfoundation.org>
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

[ Upstream commit 130e2054d4a652a2bd79fb1557ddcd19c053cb37 ]

Returning an undecorated integer is an age-old trope, but it's
not clear (even to previous experts in this code) that the only
valid return values are 1 and 0. These functions do not return
a negative errno, rpc_stat value, or a positive length.

Document there are only two valid return values by having
.pc_encode return only true or false.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/xdr.c             |  18 ++--
 fs/lockd/xdr4.c            |  18 ++--
 fs/nfs/callback_xdr.c      |   4 +-
 fs/nfsd/nfs2acl.c          |   4 +-
 fs/nfsd/nfs3acl.c          |  18 ++--
 fs/nfsd/nfs3xdr.c          | 166 ++++++++++++++++++-------------------
 fs/nfsd/nfs4xdr.c          |   4 +-
 fs/nfsd/nfsd.h             |   2 +-
 fs/nfsd/nfssvc.c           |   8 +-
 fs/nfsd/nfsxdr.c           |  60 +++++++-------
 fs/nfsd/xdr.h              |  14 ++--
 fs/nfsd/xdr3.h             |  30 +++----
 fs/nfsd/xdr4.h             |   2 +-
 include/linux/lockd/xdr.h  |   8 +-
 include/linux/lockd/xdr4.h |   8 +-
 include/linux/sunrpc/svc.h |   2 +-
 16 files changed, 183 insertions(+), 183 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 2595b4d14cd44..2fb5748dae0c8 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -313,13 +313,13 @@ nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  * Encode Reply results
  */
 
-int
+bool
 nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_resp;
@@ -328,7 +328,7 @@ nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_encode_testrply(xdr, resp);
 }
 
-int
+bool
 nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_resp;
@@ -337,18 +337,18 @@ nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_encode_stats(xdr, resp->status);
 }
 
-int
+bool
 nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_cookie(xdr, &resp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_encode_stats(xdr, resp->status))
-		return 0;
+		return false;
 	/* sequence */
 	if (xdr_stream_encode_u32(xdr, 0) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 4c04b1e2bd9d8..5fcbf30cd2759 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -308,13 +308,13 @@ nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  * Encode Reply results
  */
 
-int
+bool
 nlm4svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_resp;
@@ -323,7 +323,7 @@ nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_encode_testrply(xdr, resp);
 }
 
-int
+bool
 nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_resp;
@@ -332,18 +332,18 @@ nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_encode_stats(xdr, resp->status);
 }
 
-int
+bool
 nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_cookie(xdr, &resp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_encode_stats(xdr, resp->status))
-		return 0;
+		return false;
 	/* sequence */
 	if (xdr_stream_encode_u32(xdr, 0) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 688d58c036de7..8dcb08e1a885d 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -67,9 +67,9 @@ static __be32 nfs4_callback_null(struct svc_rqst *rqstp)
  * svc_process_common() looks for an XDR encoder to know when
  * not to drop a Reply.
  */
-static int nfs4_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+static bool nfs4_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return 1;
+	return true;
 }
 
 static __be32 decode_string(struct xdr_stream *xdr, unsigned int *len,
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index cbd042fbe0f39..efcd429b0f28e 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -240,7 +240,7 @@ nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 /* GETACL */
-static int
+static bool
 nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
@@ -270,7 +270,7 @@ nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 }
 
 /* ACCESS */
-static int
+static bool
 nfsaclsvc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index e186467b63ecb..35b2ebda14dac 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -166,7 +166,7 @@ nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 /* GETACL */
-static int
+static bool
 nfs3svc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
@@ -178,14 +178,14 @@ nfs3svc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	int w;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		inode = d_inode(dentry);
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->mask) < 0)
-			return 0;
+			return false;
 
 		base = (char *)xdr->p - (char *)head->iov_base;
 
@@ -194,7 +194,7 @@ nfs3svc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 			(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
 		while (w > 0) {
 			if (!*(rqstp->rq_next_page++))
-				return 0;
+				return false;
 			w -= PAGE_SIZE;
 		}
 
@@ -207,18 +207,18 @@ nfs3svc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 					  resp->mask & NFS_DFACL,
 					  NFS_ACL_DEFAULT);
 		if (n <= 0)
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* SETACL */
-static int
+static bool
 nfs3svc_encode_setaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index dd87076a8b0d7..48e8a02ebc83b 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -802,26 +802,26 @@ nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 /* GETATTR */
-int
+bool
 nfs3svc_encode_getattrres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		lease_get_mtime(d_inode(resp->fh.fh_dentry), &resp->stat.mtime);
 		if (!svcxdr_encode_fattr3(rqstp, xdr, &resp->fh, &resp->stat))
-			return 0;
+			return false;
 		break;
 	}
 
-	return 1;
+	return true;
 }
 
 /* SETATTR, REMOVE, RMDIR */
-int
+bool
 nfs3svc_encode_wccstat(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
@@ -831,166 +831,166 @@ nfs3svc_encode_wccstat(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 }
 
 /* LOOKUP */
-int
+bool
 nfs3svc_encode_lookupres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_nfs_fh3(xdr, &resp->fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->dirfh))
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->dirfh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* ACCESS */
-int
+bool
 nfs3svc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->access) < 0)
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* READLINK */
-int
+bool
 nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_readlinkres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->len) < 0)
-			return 0;
+			return false;
 		xdr_write_pages(xdr, resp->pages, 0, resp->len);
 		if (svc_encode_result_payload(rqstp, head->iov_len, resp->len) < 0)
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* READ */
-int
+bool
 nfs3svc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_readres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
-			return 0;
+			return false;
 		if (xdr_stream_encode_bool(xdr, resp->eof) < 0)
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
-			return 0;
+			return false;
 		xdr_write_pages(xdr, resp->pages, rqstp->rq_res.page_base,
 				resp->count);
 		if (svc_encode_result_payload(rqstp, head->iov_len, resp->count) < 0)
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* WRITE */
-int
+bool
 nfs3svc_encode_writeres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_writeres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->committed) < 0)
-			return 0;
+			return false;
 		if (!svcxdr_encode_writeverf3(xdr, resp->verf))
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* CREATE, MKDIR, SYMLINK, MKNOD */
-int
+bool
 nfs3svc_encode_createres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_fh3(xdr, &resp->fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->dirfh))
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->dirfh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* RENAME */
-int
+bool
 nfs3svc_encode_renameres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_renameres *resp = rqstp->rq_resp;
@@ -1001,7 +1001,7 @@ nfs3svc_encode_renameres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 }
 
 /* LINK */
-int
+bool
 nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_linkres *resp = rqstp->rq_resp;
@@ -1012,33 +1012,33 @@ nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 }
 
 /* READDIR */
-int
+bool
 nfs3svc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_readdirres *resp = rqstp->rq_resp;
 	struct xdr_buf *dirlist = &resp->dirlist;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_cookieverf3(xdr, resp->verf))
-			return 0;
+			return false;
 		xdr_write_pages(xdr, dirlist->pages, 0, dirlist->len);
 		/* no more entries */
 		if (xdr_stream_encode_item_absent(xdr) < 0)
-			return 0;
+			return false;
 		if (xdr_stream_encode_bool(xdr, resp->common.err == nfserr_eof) < 0)
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 static __be32
@@ -1265,26 +1265,26 @@ svcxdr_encode_fsstat3resok(struct xdr_stream *xdr,
 }
 
 /* FSSTAT */
-int
+bool
 nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_fsstatres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_fsstat3resok(xdr, resp))
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 static bool
@@ -1311,26 +1311,26 @@ svcxdr_encode_fsinfo3resok(struct xdr_stream *xdr,
 }
 
 /* FSINFO */
-int
+bool
 nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_fsinfores *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_fsinfo3resok(xdr, resp))
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 static bool
@@ -1353,49 +1353,49 @@ svcxdr_encode_pathconf3resok(struct xdr_stream *xdr,
 }
 
 /* PATHCONF */
-int
+bool
 nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_pathconfres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_pathconf3resok(xdr, resp))
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* COMMIT */
-int
+bool
 nfs3svc_encode_commitres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_commitres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_writeverf3(xdr, resp->verf))
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /*
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index cc2367a6922a6..1483cd1b5eed7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5427,7 +5427,7 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return nfsd4_decode_compound(args);
 }
 
-int
+bool
 nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
@@ -5453,5 +5453,5 @@ nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	*p++ = htonl(resp->opcnt);
 
 	nfsd4_sequence_done(resp);
-	return 1;
+	return true;
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 345f8247d5da9..498e5a4898260 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -80,7 +80,7 @@ struct nfsd_voidargs { };
 struct nfsd_voidres { };
 bool		nfssvc_decode_voidarg(struct svc_rqst *rqstp,
 				      struct xdr_stream *xdr);
-int		nfssvc_encode_voidres(struct svc_rqst *rqstp,
+bool		nfssvc_encode_voidres(struct svc_rqst *rqstp,
 				      struct xdr_stream *xdr);
 
 /*
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 195f2bcc65384..7df1505425edc 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1078,12 +1078,12 @@ bool nfssvc_decode_voidarg(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  * @xdr: XDR stream into which to encode results
  *
  * Return values:
- *   %0: Local error while encoding
- *   %1: Encoding was successful
+ *   %false: Local error while encoding
+ *   %true: Encoding was successful
  */
-int nfssvc_encode_voidres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+bool nfssvc_encode_voidres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return 1;
+	return true;
 }
 
 int nfsd_pool_stats_open(struct inode *inode, struct file *file)
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 6aa8138ae2f7d..aba8520b4b8b6 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -414,7 +414,7 @@ nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  * XDR encode functions
  */
 
-int
+bool
 nfssvc_encode_statres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_stat *resp = rqstp->rq_resp;
@@ -422,110 +422,110 @@ nfssvc_encode_statres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return svcxdr_encode_stat(xdr, resp->status);
 }
 
-int
+bool
 nfssvc_encode_attrstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_fattr(rqstp, xdr, &resp->fh, &resp->stat))
-			return 0;
+			return false;
 		break;
 	}
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfssvc_encode_diropres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_diropres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_fhandle(xdr, &resp->fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_fattr(rqstp, xdr, &resp->fh, &resp->stat))
-			return 0;
+			return false;
 		break;
 	}
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfssvc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_readlinkres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (xdr_stream_encode_u32(xdr, resp->len) < 0)
-			return 0;
+			return false;
 		xdr_write_pages(xdr, &resp->page, 0, resp->len);
 		if (svc_encode_result_payload(rqstp, head->iov_len, resp->len) < 0)
-			return 0;
+			return false;
 		break;
 	}
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfssvc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_readres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_fattr(rqstp, xdr, &resp->fh, &resp->stat))
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
-			return 0;
+			return false;
 		xdr_write_pages(xdr, resp->pages, rqstp->rq_res.page_base,
 				resp->count);
 		if (svc_encode_result_payload(rqstp, head->iov_len, resp->count) < 0)
-			return 0;
+			return false;
 		break;
 	}
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfssvc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
 	struct xdr_buf *dirlist = &resp->dirlist;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		xdr_write_pages(xdr, dirlist->pages, 0, dirlist->len);
 		/* no more entries */
 		if (xdr_stream_encode_item_absent(xdr) < 0)
-			return 0;
+			return false;
 		if (xdr_stream_encode_bool(xdr, resp->common.err == nfserr_eof) < 0)
-			return 0;
+			return false;
 		break;
 	}
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_statfsres *resp = rqstp->rq_resp;
@@ -533,12 +533,12 @@ nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	__be32 *p;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		p = xdr_reserve_space(xdr, XDR_UNIT * 5);
 		if (!p)
-			return 0;
+			return false;
 		*p++ = cpu_to_be32(NFSSVC_MAXBLKSIZE_V2);
 		*p++ = cpu_to_be32(stat->f_bsize);
 		*p++ = cpu_to_be32(stat->f_blocks);
@@ -547,7 +547,7 @@ nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		break;
 	}
 
-	return 1;
+	return true;
 }
 
 /**
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index bff7258041fc4..852f71580bd06 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -152,13 +152,13 @@ bool nfssvc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int nfssvc_encode_statres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_encode_attrstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_encode_diropres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_encode_statres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_encode_attrstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_encode_diropres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 void nfssvc_encode_nfscookie(struct nfsd_readdirres *resp, u32 offset);
 int nfssvc_encode_entry(void *data, const char *name, int namlen,
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index bb017fc7cba19..03fe4e21306cb 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -281,21 +281,21 @@ bool nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int nfs3svc_encode_getattrres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_wccstat(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_lookupres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_writeres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_createres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_renameres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_commitres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_getattrres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_wccstat(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_lookupres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_writeres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_createres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_renameres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_commitres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 void nfs3svc_release_fhandle(struct svc_rqst *);
 void nfs3svc_release_fhandle2(struct svc_rqst *);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 9921915b4c163..4f1090c32c29b 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -759,7 +759,7 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 
 bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqstp);
 bool nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *, u32);
 void nfsd4_encode_operation(struct nfsd4_compoundres *, struct nfsd4_op *);
 void nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op);
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index 94f1ca900ca3a..67e4a2c5500bd 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -108,9 +108,9 @@ bool	nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int	nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 #endif /* LOCKD_XDR_H */
diff --git a/include/linux/lockd/xdr4.h b/include/linux/lockd/xdr4.h
index ee44d7357a7f7..72831e35dca32 100644
--- a/include/linux/lockd/xdr4.h
+++ b/include/linux/lockd/xdr4.h
@@ -33,10 +33,10 @@ bool	nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int	nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 extern const struct rpc_version nlm_version4;
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index dc6fc8940261f..4813cc5613f27 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -459,7 +459,7 @@ struct svc_procedure {
 	bool			(*pc_decode)(struct svc_rqst *rqstp,
 					     struct xdr_stream *xdr);
 	/* XDR encode result: */
-	int			(*pc_encode)(struct svc_rqst *rqstp,
+	bool			(*pc_encode)(struct svc_rqst *rqstp,
 					     struct xdr_stream *xdr);
 	/* XDR free result: */
 	void			(*pc_release)(struct svc_rqst *);
-- 
2.43.0




