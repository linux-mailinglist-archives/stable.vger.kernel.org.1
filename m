Return-Path: <stable+bounces-53228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E108E90D207
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81F8B270BF
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C16166309;
	Tue, 18 Jun 2024 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NeKrnD/t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9366C145353;
	Tue, 18 Jun 2024 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715707; cv=none; b=qwIqShW6NfTS58prqBMnnNWWLk+/fAl3rcIahETJPpvWbWeiAawmxnpYOCgSfVwSad7cLeY7Sc8wLB29wvLI1fDZMr3x+4Vh6KxXnApHRCETW7SVx9qQolq6a7hAixqBdWZrfd+JIN5gF9/98l8hFZOp6sg8T2Dn1UFyrQ6zmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715707; c=relaxed/simple;
	bh=nf6xXf8+UWP8XvIJ+WkwSPq/x0c9F3WXE9zg+EUfkeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoSBL0tPVhtv54aXfbxmxbW2m2nHH9k7o6uUUQTn3Z74/pUpCQBR0no67rIvlJtJnI9xTe9VWhl3xVmfU2DsTEXNuzt/U6wf0Bn6ZS+nFTRcbMYjEaa6wQxMKWYkn60f7MBm94TNwYxE+9m6XYrcgeG0FJFT5EPqfapqd6zEXJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NeKrnD/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD45CC3277B;
	Tue, 18 Jun 2024 13:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715707;
	bh=nf6xXf8+UWP8XvIJ+WkwSPq/x0c9F3WXE9zg+EUfkeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NeKrnD/t7i9Sso1GmZnSGZjGpS7ZCFSV5+K7NVlGxvshrapVKQaEjWXRdNe9oD3sb
	 zT/BQde+mkhtZs5MBjoy98mFPeFQirMM9t0AP+nhVZwQv0WRfH6sQRZopeW9F9CV2s
	 63BzgRLbAT3b/e+aQ+cWuPUReb44CfEA8YywwSa4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 399/770] SUNRPC: Change return value type of .pc_encode
Date: Tue, 18 Jun 2024 14:34:12 +0200
Message-ID: <20240618123422.683436132@linuxfoundation.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index 32231c21c22dd..856267c0864bd 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -312,13 +312,13 @@ nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
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
@@ -327,7 +327,7 @@ nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_encode_testrply(xdr, resp);
 }
 
-int
+bool
 nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_resp;
@@ -336,18 +336,18 @@ nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
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
index c58b3b60bc2c0..1b21f88a9808c 100644
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
index 23e4c3eb2c381..96733dff354d3 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -238,7 +238,7 @@ nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 /* GETACL */
-static int
+static bool
 nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
@@ -278,7 +278,7 @@ nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 }
 
 /* ACCESS */
-static int
+static bool
 nfsaclsvc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 21aacba88ea3e..350fae92ae045 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -164,7 +164,7 @@ nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 /* GETACL */
-static int
+static bool
 nfs3svc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
@@ -176,14 +176,14 @@ nfs3svc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
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
 
@@ -192,7 +192,7 @@ nfs3svc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 			(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
 		while (w > 0) {
 			if (!*(rqstp->rq_next_page++))
-				return 0;
+				return false;
 			w -= PAGE_SIZE;
 		}
 
@@ -205,18 +205,18 @@ nfs3svc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
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
index 63f0be4e44f70..c3ac1b6aa3aaa 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -812,26 +812,26 @@ nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
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
@@ -841,166 +841,166 @@ nfs3svc_encode_wccstat(struct svc_rqst *rqstp, struct xdr_stream *xdr)
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
@@ -1011,7 +1011,7 @@ nfs3svc_encode_renameres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 }
 
 /* LINK */
-int
+bool
 nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_linkres *resp = rqstp->rq_resp;
@@ -1022,33 +1022,33 @@ nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
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
@@ -1275,26 +1275,26 @@ svcxdr_encode_fsstat3resok(struct xdr_stream *xdr,
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
@@ -1321,26 +1321,26 @@ svcxdr_encode_fsinfo3resok(struct xdr_stream *xdr,
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
@@ -1363,49 +1363,49 @@ svcxdr_encode_pathconf3resok(struct xdr_stream *xdr,
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
index 697d61819a59d..ba2ed12df2060 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5437,7 +5437,7 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return nfsd4_decode_compound(args);
 }
 
-int
+bool
 nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
@@ -5463,7 +5463,7 @@ nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	*p++ = htonl(resp->opcnt);
 
 	nfsd4_sequence_done(resp);
-	return 1;
+	return true;
 }
 
 /*
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
index 5b343d0c6963a..4a298ac5515df 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -758,7 +758,7 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 
 bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqstp);
 bool nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *, u32);
 void nfsd4_encode_operation(struct nfsd4_compoundres *, struct nfsd4_op *);
 void nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op);
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index d8bd26a5525ef..398f70093cd35 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -106,9 +106,9 @@ bool	nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
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
index 50677be3557dc..9a6b55da8fd64 100644
--- a/include/linux/lockd/xdr4.h
+++ b/include/linux/lockd/xdr4.h
@@ -32,10 +32,10 @@ bool	nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
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
index c6a0b4364f4a2..15ecd5b1abacf 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -460,7 +460,7 @@ struct svc_procedure {
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




