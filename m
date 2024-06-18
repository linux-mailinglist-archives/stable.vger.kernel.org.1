Return-Path: <stable+bounces-53443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0E490D325
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110CFB27606
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F90E1A08CA;
	Tue, 18 Jun 2024 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vKqteIQ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D260D158D7E;
	Tue, 18 Jun 2024 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716340; cv=none; b=BQBQggCU7WNDZOH9m+26QcWkSUl44oiDRoGp4tJMfYh1tsVQgyTy5R4RqXfr6twgyI4vgBLLiNLMoTHmm0UfTlcAKt5GozU2I++HE+fk8tm5/IShQuYdNWzwuLIhC1AEz50EekKKePNhPzlb3ej40OFz0VyAf1U2wXRY1XePVQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716340; c=relaxed/simple;
	bh=F05D0UzCr6t8O2G+Yvu5/+IviYiZPbChZX77s1LHIz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glnFLDifdmntIDUFwbJ07CpKMkwO7cM5bdr3m/Yj3aaopMKGg9qt58xv9VlaHnI2IB+xpGoLyuqrcCCD6qKmtApBsKFWrpVeHcQZDgibxdSpwDtPnMh+5xU+++gPY32vdM5fY5Lhv0mXkgVF5IcnAq8HKcsnBwKJe7pVE4pfE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vKqteIQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EBCC3277B;
	Tue, 18 Jun 2024 13:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716340;
	bh=F05D0UzCr6t8O2G+Yvu5/+IviYiZPbChZX77s1LHIz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vKqteIQ6y2H2E4eEpMxwB0fxR6Caa0b/MDT+PM2tCsDtLKupxqA9q1iTqQ1rZLAdS
	 Mi7bYn/5hbtWXvFFjWxrwhdecjl7qf8g0DvUkOAiz18iT2AV00uelCvFY06We8gXwG
	 9Tz7ATxrrI0hoJa7vDMKrQyk16q/L+v4MwW98H/o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 612/770] NFSD: introduce struct nfsd_attrs
Date: Tue, 18 Jun 2024 14:37:45 +0200
Message-ID: <20240618123430.912213182@linuxfoundation.org>
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

From: NeilBrown <neilb@suse.de>

[ Upstream commit 7fe2a71dda349a1afa75781f0cc7975be9784d15 ]

The attributes that nfsd might want to set on a file include 'struct
iattr' as well as an ACL and security label.
The latter two are passed around quite separately from the first, in
part because they are only needed for NFSv4.  This leads to some
clumsiness in the code, such as the attributes NOT being set in
nfsd_create_setattr().

We need to keep the directory locked until all attributes are set to
ensure the file is never visibile without all its attributes.  This need
combined with the inconsistent handling of attributes leads to more
clumsiness.

As a first step towards tidying this up, introduce 'struct nfsd_attrs'.
This is passed (by reference) to vfs.c functions that work with
attributes, and is assembled by the various nfs*proc functions which
call them.  As yet only iattr is included, but future patches will
expand this.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs3proc.c  | 20 ++++++++++++++++----
 fs/nfsd/nfs4proc.c  | 23 ++++++++++++++++-------
 fs/nfsd/nfs4state.c |  5 ++++-
 fs/nfsd/nfsproc.c   | 17 +++++++++++++----
 fs/nfsd/vfs.c       | 24 ++++++++++++++----------
 fs/nfsd/vfs.h       | 12 ++++++++----
 6 files changed, 71 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index e314545bbdb2e..7b81d871f0d3c 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -67,12 +67,15 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
 {
 	struct nfsd3_sattrargs *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
+	struct nfsd_attrs attrs = {
+		.na_iattr	= &argp->attrs,
+	};
 
 	dprintk("nfsd: SETATTR(3)  %s\n",
 				SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
-	resp->status = nfsd_setattr(rqstp, &resp->fh, &argp->attrs,
+	resp->status = nfsd_setattr(rqstp, &resp->fh, &attrs,
 				    argp->check_guard, argp->guardtime);
 	return rpc_success;
 }
@@ -233,6 +236,9 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 {
 	struct iattr *iap = &argp->attrs;
 	struct dentry *parent, *child;
+	struct nfsd_attrs attrs = {
+		.na_iattr	= iap,
+	};
 	__u32 v_mtime, v_atime;
 	struct inode *inode;
 	__be32 status;
@@ -331,7 +337,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 set_attr:
-	status = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
+	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
 out:
 	fh_unlock(fhp);
@@ -368,6 +374,9 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 {
 	struct nfsd3_createargs *argp = rqstp->rq_argp;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
+	struct nfsd_attrs attrs = {
+		.na_iattr	= &argp->attrs,
+	};
 
 	dprintk("nfsd: MKDIR(3)    %s %.*s\n",
 				SVCFH_fmt(&argp->fh),
@@ -378,7 +387,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 	fh_copy(&resp->dirfh, &argp->fh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
-				   &argp->attrs, S_IFDIR, 0, &resp->fh);
+				   &attrs, S_IFDIR, 0, &resp->fh);
 	fh_unlock(&resp->dirfh);
 	return rpc_success;
 }
@@ -428,6 +437,9 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 {
 	struct nfsd3_mknodargs *argp = rqstp->rq_argp;
 	struct nfsd3_diropres  *resp = rqstp->rq_resp;
+	struct nfsd_attrs attrs = {
+		.na_iattr	= &argp->attrs,
+	};
 	int type;
 	dev_t	rdev = 0;
 
@@ -453,7 +465,7 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 
 	type = nfs3_ftypes[argp->ftype];
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
-				   &argp->attrs, type, rdev, &resp->fh);
+				   &attrs, type, rdev, &resp->fh);
 	fh_unlock(&resp->dirfh);
 out:
 	return rpc_success;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7685bbe9d78dd..f8a157e4bc708 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -286,6 +286,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  struct svc_fh *resfhp, struct nfsd4_open *open)
 {
 	struct iattr *iap = &open->op_iattr;
+	struct nfsd_attrs attrs = {
+		.na_iattr	= iap,
+	};
 	struct dentry *parent, *child;
 	__u32 v_mtime, v_atime;
 	struct inode *inode;
@@ -404,7 +407,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 set_attr:
-	status = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
+	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
 out:
 	fh_unlock(fhp);
@@ -787,6 +790,9 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
 {
 	struct nfsd4_create *create = &u->create;
+	struct nfsd_attrs attrs = {
+		.na_iattr	= &create->cr_iattr,
+	};
 	struct svc_fh resfh;
 	__be32 status;
 	dev_t rdev;
@@ -818,7 +824,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_umask;
 		status = nfsd_create(rqstp, &cstate->current_fh,
 				     create->cr_name, create->cr_namelen,
-				     &create->cr_iattr, S_IFBLK, rdev, &resfh);
+				     &attrs, S_IFBLK, rdev, &resfh);
 		break;
 
 	case NF4CHR:
@@ -829,26 +835,26 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_umask;
 		status = nfsd_create(rqstp, &cstate->current_fh,
 				     create->cr_name, create->cr_namelen,
-				     &create->cr_iattr, S_IFCHR, rdev, &resfh);
+				     &attrs, S_IFCHR, rdev, &resfh);
 		break;
 
 	case NF4SOCK:
 		status = nfsd_create(rqstp, &cstate->current_fh,
 				     create->cr_name, create->cr_namelen,
-				     &create->cr_iattr, S_IFSOCK, 0, &resfh);
+				     &attrs, S_IFSOCK, 0, &resfh);
 		break;
 
 	case NF4FIFO:
 		status = nfsd_create(rqstp, &cstate->current_fh,
 				     create->cr_name, create->cr_namelen,
-				     &create->cr_iattr, S_IFIFO, 0, &resfh);
+				     &attrs, S_IFIFO, 0, &resfh);
 		break;
 
 	case NF4DIR:
 		create->cr_iattr.ia_valid &= ~ATTR_SIZE;
 		status = nfsd_create(rqstp, &cstate->current_fh,
 				     create->cr_name, create->cr_namelen,
-				     &create->cr_iattr, S_IFDIR, 0, &resfh);
+				     &attrs, S_IFDIR, 0, &resfh);
 		break;
 
 	default:
@@ -1142,6 +1148,9 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	      union nfsd4_op_u *u)
 {
 	struct nfsd4_setattr *setattr = &u->setattr;
+	struct nfsd_attrs attrs = {
+		.na_iattr	= &setattr->sa_iattr,
+	};
 	__be32 status = nfs_ok;
 	int err;
 
@@ -1174,7 +1183,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				&setattr->sa_label);
 	if (status)
 		goto out;
-	status = nfsd_setattr(rqstp, &cstate->current_fh, &setattr->sa_iattr,
+	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
 				0, (time64_t)0);
 out:
 	fh_drop_write(&cstate->current_fh);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b3ab112695837..2b6c9f1b9de88 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5077,11 +5077,14 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 		.ia_valid = ATTR_SIZE,
 		.ia_size = 0,
 	};
+	struct nfsd_attrs attrs = {
+		.na_iattr	= &iattr,
+	};
 	if (!open->op_truncate)
 		return 0;
 	if (!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
 		return nfserr_inval;
-	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
+	return nfsd_setattr(rqstp, fh, &attrs, 0, (time64_t)0);
 }
 
 static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index b8ddf21e70ea0..f061f229d5ff0 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -51,6 +51,9 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 	struct nfsd_sattrargs *argp = rqstp->rq_argp;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 	struct iattr *iap = &argp->attrs;
+	struct nfsd_attrs attrs = {
+		.na_iattr	= iap,
+	};
 	struct svc_fh *fhp;
 
 	dprintk("nfsd: SETATTR  %s, valid=%x, size=%ld\n",
@@ -100,7 +103,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		}
 	}
 
-	resp->status = nfsd_setattr(rqstp, fhp, iap, 0, (time64_t)0);
+	resp->status = nfsd_setattr(rqstp, fhp, &attrs, 0, (time64_t)0);
 	if (resp->status != nfs_ok)
 		goto out;
 
@@ -260,6 +263,9 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	svc_fh		*dirfhp = &argp->fh;
 	svc_fh		*newfhp = &resp->fh;
 	struct iattr	*attr = &argp->attrs;
+	struct nfsd_attrs attrs = {
+		.na_iattr	= attr,
+	};
 	struct inode	*inode;
 	struct dentry	*dchild;
 	int		type, mode;
@@ -385,7 +391,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	if (!inode) {
 		/* File doesn't exist. Create it and set attrs */
 		resp->status = nfsd_create_locked(rqstp, dirfhp, argp->name,
-						  argp->len, attr, type, rdev,
+						  argp->len, &attrs, type, rdev,
 						  newfhp);
 	} else if (type == S_IFREG) {
 		dprintk("nfsd:   existing %s, valid=%x, size=%ld\n",
@@ -396,7 +402,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		 */
 		attr->ia_valid &= ATTR_SIZE;
 		if (attr->ia_valid)
-			resp->status = nfsd_setattr(rqstp, newfhp, attr, 0,
+			resp->status = nfsd_setattr(rqstp, newfhp, &attrs, 0,
 						    (time64_t)0);
 	}
 
@@ -511,6 +517,9 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 {
 	struct nfsd_createargs *argp = rqstp->rq_argp;
 	struct nfsd_diropres *resp = rqstp->rq_resp;
+	struct nfsd_attrs attrs = {
+		.na_iattr	= &argp->attrs,
+	};
 
 	dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
 
@@ -522,7 +531,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 	argp->attrs.ia_valid &= ~ATTR_SIZE;
 	fh_init(&resp->fh, NFS_FHSIZE);
 	resp->status = nfsd_create(rqstp, &argp->fh, argp->name, argp->len,
-				   &argp->attrs, S_IFDIR, 0, &resp->fh);
+				   &attrs, S_IFDIR, 0, &resp->fh);
 	fh_put(&argp->fh);
 	if (resp->status != nfs_ok)
 		goto out;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5c8dc1a05e57e..c86c3a8e42329 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -362,11 +362,13 @@ nfsd_get_write_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * Set various file attributes.  After this call fhp needs an fh_put.
  */
 __be32
-nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
+nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
+	     struct nfsd_attrs *attr,
 	     int check_guard, time64_t guardtime)
 {
 	struct dentry	*dentry;
 	struct inode	*inode;
+	struct iattr	*iap = attr->na_iattr;
 	int		accmode = NFSD_MAY_SATTR;
 	umode_t		ftype = 0;
 	__be32		err;
@@ -1221,14 +1223,15 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
  * @rqstp: RPC transaction being executed
  * @fhp: NFS filehandle of parent directory
  * @resfhp: NFS filehandle of new object
- * @iap: requested attributes of new object
+ * @attrs: requested attributes of new object
  *
  * Returns nfs_ok on success, or an nfsstat in network byte order.
  */
 __be32
 nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		    struct svc_fh *resfhp, struct iattr *iap)
+		    struct svc_fh *resfhp, struct nfsd_attrs *attrs)
 {
+	struct iattr *iap = attrs->na_iattr;
 	__be32 status;
 
 	/*
@@ -1249,7 +1252,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * if the attributes have not changed.
 	 */
 	if (iap->ia_valid)
-		status = nfsd_setattr(rqstp, resfhp, iap, 0, (time64_t)0);
+		status = nfsd_setattr(rqstp, resfhp, attrs, 0, (time64_t)0);
 	else
 		status = nfserrno(commit_metadata(resfhp));
 
@@ -1288,11 +1291,12 @@ nfsd_check_ignore_resizing(struct iattr *iap)
 /* The parent directory should already be locked: */
 __be32
 nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		char *fname, int flen, struct iattr *iap,
-		int type, dev_t rdev, struct svc_fh *resfhp)
+		   char *fname, int flen, struct nfsd_attrs *attrs,
+		   int type, dev_t rdev, struct svc_fh *resfhp)
 {
 	struct dentry	*dentry, *dchild;
 	struct inode	*dirp;
+	struct iattr	*iap = attrs->na_iattr;
 	__be32		err;
 	int		host_err;
 
@@ -1365,7 +1369,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err < 0)
 		goto out_nfserr;
 
-	err = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
+	err = nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 
 out:
 	dput(dchild);
@@ -1384,8 +1388,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 __be32
 nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		char *fname, int flen, struct iattr *iap,
-		int type, dev_t rdev, struct svc_fh *resfhp)
+	    char *fname, int flen, struct nfsd_attrs *attrs,
+	    int type, dev_t rdev, struct svc_fh *resfhp)
 {
 	struct dentry	*dentry, *dchild = NULL;
 	__be32		err;
@@ -1417,7 +1421,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dput(dchild);
 	if (err)
 		return err;
-	return nfsd_create_locked(rqstp, fhp, fname, flen, iap, type,
+	return nfsd_create_locked(rqstp, fhp, fname, flen, attrs, type,
 					rdev, resfhp);
 }
 
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 26347d76f44a0..d8b1a36fca956 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -42,6 +42,10 @@ struct nfsd_file;
 typedef int (*nfsd_filldir_t)(void *, const char *, int, loff_t, u64, unsigned);
 
 /* nfsd/vfs.c */
+struct nfsd_attrs {
+	struct iattr		*na_iattr;	/* input */
+};
+
 int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		                struct svc_export **expp);
 __be32		nfsd_lookup(struct svc_rqst *, struct svc_fh *,
@@ -50,7 +54,7 @@ __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct svc_fh *,
 				const char *, unsigned int,
 				struct svc_export **, struct dentry **);
 __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
-				struct iattr *, int, time64_t);
+				struct nfsd_attrs *, int, time64_t);
 int nfsd_mountpoint(struct dentry *, struct svc_export *);
 #ifdef CONFIG_NFSD_V4
 __be32          nfsd4_set_nfs4_label(struct svc_rqst *, struct svc_fh *,
@@ -63,14 +67,14 @@ __be32		nfsd4_clone_file_range(struct svc_rqst *rqstp,
 				       u64 count, bool sync);
 #endif /* CONFIG_NFSD_V4 */
 __be32		nfsd_create_locked(struct svc_rqst *, struct svc_fh *,
-				char *name, int len, struct iattr *attrs,
+				char *name, int len, struct nfsd_attrs *attrs,
 				int type, dev_t rdev, struct svc_fh *res);
 __be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
-				char *name, int len, struct iattr *attrs,
+				char *name, int len, struct nfsd_attrs *attrs,
 				int type, dev_t rdev, struct svc_fh *res);
 __be32		nfsd_access(struct svc_rqst *, struct svc_fh *, u32 *, u32 *);
 __be32		nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
-				struct svc_fh *resfhp, struct iattr *iap);
+				struct svc_fh *resfhp, struct nfsd_attrs *iap);
 __be32		nfsd_commit(struct svc_rqst *rqst, struct svc_fh *fhp,
 				u64 offset, u32 count, __be32 *verf);
 #ifdef CONFIG_NFSD_V4
-- 
2.43.0




