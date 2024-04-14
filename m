Return-Path: <stable+bounces-37482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD4489C50E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21981C20257
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6596671B3D;
	Mon,  8 Apr 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AjosdO72"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21728524AF;
	Mon,  8 Apr 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584363; cv=none; b=kK5BCgTUAHVGx+CZC5Qdq3Ds2BHeZ3GnoD5+YtLmU/u9HmmE51jXVzqhBm2PI2Hb6J4E5IT8geJ5Dcz0hlC/2od8pknI5EhpUjqqy1AmzwviSYW3YO5v5/TDA4LkWZkmYYYGcdDoxpN1/Jdzl7Hpy6NzsgTvKOHz7CtDEpQvJNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584363; c=relaxed/simple;
	bh=vdjSbnBuL115EbVli7jBkkzh58FRX8RGQoKQCXuQKvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvker0N/bKTeCNqiLk9pI8BPJDY5M7tSDsH7RQnNBNf4Ayk+yfbhWXLrEGblh6Z1gDJ35uPWoOYd8ezPmOMb3TXLlyf+Heym3GTVyN2xLXgPFPIajgoSJd1sB7PVAJu171rHZbxCMofC/2cbPVFh1SLXu/9mb9iLAFiZm73qEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AjosdO72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE5DC433F1;
	Mon,  8 Apr 2024 13:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584363;
	bh=vdjSbnBuL115EbVli7jBkkzh58FRX8RGQoKQCXuQKvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjosdO72i7+i8RlNwWwU1rshy5eq44mp6rVE7qKZ7imTOoxGOVR4tS28RS4g1y07v
	 6I3NZibrSjuMP+c0Eej2pCNgrRtvZdY4DSMi3ihd3yYl4wkaKrYhgrxvpl3B7NNToG
	 3dhJvKdKfmAavjxsR1q5qThJ4zRVop9kEr9z1FU0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 411/690] NFSD: use explicit lock/unlock for directory ops
Date: Mon,  8 Apr 2024 14:54:37 +0200
Message-ID: <20240408125414.472658706@linuxfoundation.org>
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

From: NeilBrown <neilb@suse.de>

[ Upstream commit debf16f0c671cb8db154a9ebcd6014cfff683b80 ]

When creating or unlinking a name in a directory use explicit
inode_lock_nested() instead of fh_lock(), and explicit calls to
fh_fill_pre_attrs() and fh_fill_post_attrs().  This is already done
for renames, with lock_rename() as the explicit locking.

Also move the 'fill' calls closer to the operation that might change the
attributes.  This way they are avoided on some error paths.

For the v2-only code in nfsproc.c, the fill calls are not replaced as
they aren't needed.

Making the locking explicit will simplify proposed future changes to
locking for directories.  It also makes it easily visible exactly where
pre/post attributes are used - not all callers of fh_lock() actually
need the pre/post attributes.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |  6 ++++--
 fs/nfsd/nfs4proc.c |  6 ++++--
 fs/nfsd/nfsproc.c  |  5 ++---
 fs/nfsd/vfs.c      | 30 +++++++++++++++++++-----------
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index fbdc109fbd067..5b1e771238b35 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -260,7 +260,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
+	inode_lock_nested(inode, I_MUTEX_PARENT);
 
 	child = lookup_one_len(argp->name, parent, argp->len);
 	if (IS_ERR(child)) {
@@ -318,11 +318,13 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
+	fh_fill_pre_attrs(fhp);
 	host_err = vfs_create(&init_user_ns, inode, child, iap->ia_mode, true);
 	if (host_err < 0) {
 		status = nfserrno(host_err);
 		goto out;
 	}
+	fh_fill_post_attrs(fhp);
 
 	/* A newly created file already has a file size of zero. */
 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
@@ -340,7 +342,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
 out:
-	fh_unlock(fhp);
+	inode_unlock(inode);
 	if (child && !IS_ERR(child))
 		dput(child);
 	fh_drop_write(fhp);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b6df56fb6755d..5e4b7858b2e50 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -264,7 +264,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (is_create_with_attrs(open))
 		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
+	inode_lock_nested(inode, I_MUTEX_PARENT);
 
 	child = lookup_one_len(open->op_fname, parent, open->op_fnamelen);
 	if (IS_ERR(child)) {
@@ -348,10 +348,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
+	fh_fill_pre_attrs(fhp);
 	status = nfsd4_vfs_create(fhp, child, open);
 	if (status != nfs_ok)
 		goto out;
 	open->op_created = true;
+	fh_fill_post_attrs(fhp);
 
 	/* A newly created file already has a file size of zero. */
 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
@@ -373,7 +375,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (attrs.na_aclerr)
 		open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
 out:
-	fh_unlock(fhp);
+	inode_unlock(inode);
 	nfsd_attrs_free(&attrs);
 	if (child && !IS_ERR(child))
 		dput(child);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 09afd188099be..4b19cc727ea50 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -292,7 +292,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		goto done;
 	}
 
-	fh_lock_nested(dirfhp, I_MUTEX_PARENT);
+	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
 	dchild = lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
 	if (IS_ERR(dchild)) {
 		resp->status = nfserrno(PTR_ERR(dchild));
@@ -408,8 +408,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	}
 
 out_unlock:
-	/* We don't really need to unlock, as fh_put does it. */
-	fh_unlock(dirfhp);
+	inode_unlock(dirfhp->fh_dentry->d_inode);
 	fh_drop_write(dirfhp);
 done:
 	fh_put(dirfhp);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c07fe50d6bdfb..7de76b37a9bc2 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1371,7 +1371,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
+	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
 	dchild = lookup_one_len(fname, dentry, flen);
 	host_err = PTR_ERR(dchild);
 	if (IS_ERR(dchild)) {
@@ -1386,10 +1386,12 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dput(dchild);
 	if (err)
 		goto out_unlock;
+	fh_fill_pre_attrs(fhp);
 	err = nfsd_create_locked(rqstp, fhp, fname, flen, attrs, type,
 				 rdev, resfhp);
+	fh_fill_post_attrs(fhp);
 out_unlock:
-	fh_unlock(fhp);
+	inode_unlock(dentry->d_inode);
 	return err;
 }
 
@@ -1472,20 +1474,22 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out;
 	}
 
-	fh_lock(fhp);
 	dentry = fhp->fh_dentry;
+	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
 	dnew = lookup_one_len(fname, dentry, flen);
 	if (IS_ERR(dnew)) {
 		err = nfserrno(PTR_ERR(dnew));
-		fh_unlock(fhp);
+		inode_unlock(dentry->d_inode);
 		goto out_drop_write;
 	}
+	fh_fill_pre_attrs(fhp);
 	host_err = vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
 	err = nfserrno(host_err);
 	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
 	if (!err)
 		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
-	fh_unlock(fhp);
+	fh_fill_post_attrs(fhp);
+	inode_unlock(dentry->d_inode);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
 	dput(dnew);
@@ -1531,9 +1535,9 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 		goto out;
 	}
 
-	fh_lock_nested(ffhp, I_MUTEX_PARENT);
 	ddir = ffhp->fh_dentry;
 	dirp = d_inode(ddir);
+	inode_lock_nested(dirp, I_MUTEX_PARENT);
 
 	dnew = lookup_one_len(name, ddir, len);
 	if (IS_ERR(dnew)) {
@@ -1546,8 +1550,10 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	err = nfserr_noent;
 	if (d_really_is_negative(dold))
 		goto out_dput;
+	fh_fill_pre_attrs(ffhp);
 	host_err = vfs_link(dold, &init_user_ns, dirp, dnew, NULL);
-	fh_unlock(ffhp);
+	fh_fill_post_attrs(ffhp);
+	inode_unlock(dirp);
 	if (!host_err) {
 		err = nfserrno(commit_metadata(ffhp));
 		if (!err)
@@ -1567,7 +1573,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 out_dput:
 	dput(dnew);
 out_unlock:
-	fh_unlock(ffhp);
+	inode_unlock(dirp);
 	goto out_drop_write;
 }
 
@@ -1742,9 +1748,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	if (host_err)
 		goto out_nfserr;
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
 	dentry = fhp->fh_dentry;
 	dirp = d_inode(dentry);
+	inode_lock_nested(dirp, I_MUTEX_PARENT);
 
 	rdentry = lookup_one_len(fname, dentry, flen);
 	host_err = PTR_ERR(rdentry);
@@ -1762,6 +1768,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	if (!type)
 		type = d_inode(rdentry)->i_mode & S_IFMT;
 
+	fh_fill_pre_attrs(fhp);
 	if (type != S_IFDIR) {
 		if (rdentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK)
 			nfsd_close_cached_files(rdentry);
@@ -1769,8 +1776,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	} else {
 		host_err = vfs_rmdir(&init_user_ns, dirp, rdentry);
 	}
+	fh_fill_post_attrs(fhp);
 
-	fh_unlock(fhp);
+	inode_unlock(dirp);
 	if (!host_err)
 		host_err = commit_metadata(fhp);
 	dput(rdentry);
@@ -1793,7 +1801,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 out:
 	return err;
 out_unlock:
-	fh_unlock(fhp);
+	inode_unlock(dirp);
 	goto out_drop_write;
 }
 
-- 
2.43.0




