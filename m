Return-Path: <stable+bounces-37483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD17889C56F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C39AB2631B
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7534342046;
	Mon,  8 Apr 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cxaNcVip"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379A524AF;
	Mon,  8 Apr 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584366; cv=none; b=lrskE3FVlhAoPijipSE39QDgwhnc5xmODTcujkkRk3LLRItzLbYUunZitvginx0h9ic5/VoNmzUWU+9jAXu5ik+m2K9Rn0cL+7orI/9/kgn3hpweSa3E21muflJ7KLt4y65g91phJpFASCmegRenI1ZPrvs5eo1TxKDTGS9bmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584366; c=relaxed/simple;
	bh=xBiH/GYv5sy6xfE7ZrKwoT0nsDnTjEw1yXwzaVwyDDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jf8OQXEjwsivAXfgJ8tNPFr9flvZTyv9Gqcvi1J9+A4pWD+AjQ7SzfFt+zpSlR81qS+JEpsb5XOgjVVxW27EyL3vX0oFK0UXgbzfSzLFiqybgIY72WvjTxXFc8835XdzRixUYpHxYp+Z6fqgOeCK/uBSk06suzHPTPV7x5cxW1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cxaNcVip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A25C433C7;
	Mon,  8 Apr 2024 13:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584366;
	bh=xBiH/GYv5sy6xfE7ZrKwoT0nsDnTjEw1yXwzaVwyDDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cxaNcVipcFc8it5fxJXYOMzlFrZOIaeBH8liR75mRcPAGLm5RrA2c6eTcElD6pKZ7
	 gBuJ8Dii+AQyBeN6JWTfSba+ZE9p3Dz43Hvav+6JmH7RLQVvgtis9BtwthDrrXAeQB
	 o35islVczWdhFlyrfgg/yp/jqmWB9yokUzPmZnJ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 412/690] NFSD: use (un)lock_inode instead of fh_(un)lock for file operations
Date: Mon,  8 Apr 2024 14:54:38 +0200
Message-ID: <20240408125414.519176566@linuxfoundation.org>
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

[ Upstream commit bb4d53d66e4b8c8b8e5634802262e53851a2d2db ]

When locking a file to access ACLs and xattrs etc, use explicit locking
with inode_lock() instead of fh_lock().  This means that the calls to
fh_fill_pre/post_attr() are also explicit which improves readability and
allows us to place them only where they are needed.  Only the xattr
calls need pre/post information.

When locking a file we don't need I_MUTEX_PARENT as the file is not a
parent of anything, so we can use inode_lock() directly rather than the
inode_lock_nested() call that fh_lock() uses.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs2acl.c   |  6 +++---
 fs/nfsd/nfs3acl.c   |  4 ++--
 fs/nfsd/nfs4state.c |  9 +++++----
 fs/nfsd/vfs.c       | 34 ++++++++++++++++++++--------------
 4 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index efcd429b0f28e..87f224cd30a85 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -111,7 +111,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 	if (error)
 		goto out_errno;
 
-	fh_lock(fh);
+	inode_lock(inode);
 
 	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
 			      argp->acl_access);
@@ -122,7 +122,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 	if (error)
 		goto out_drop_lock;
 
-	fh_unlock(fh);
+	inode_unlock(inode);
 
 	fh_drop_write(fh);
 
@@ -136,7 +136,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 	return rpc_success;
 
 out_drop_lock:
-	fh_unlock(fh);
+	inode_unlock(inode);
 	fh_drop_write(fh);
 out_errno:
 	resp->status = nfserrno(error);
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 35b2ebda14dac..9446c67436649 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -101,7 +101,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 	if (error)
 		goto out_errno;
 
-	fh_lock(fh);
+	inode_lock(inode);
 
 	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
 			      argp->acl_access);
@@ -111,7 +111,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 			      argp->acl_default);
 
 out_drop_lock:
-	fh_unlock(fh);
+	inode_unlock(inode);
 	fh_drop_write(fh);
 out_errno:
 	resp->status = nfserrno(error);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f66fb39714893..66cf8217ebe57 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7415,21 +7415,22 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file_lock *lock)
 {
 	struct nfsd_file *nf;
+	struct inode *inode;
 	__be32 err;
 
 	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
 	if (err)
 		return err;
-	fh_lock(fhp); /* to block new leases till after test_lock: */
-	err = nfserrno(nfsd_open_break_lease(fhp->fh_dentry->d_inode,
-							NFSD_MAY_READ));
+	inode = fhp->fh_dentry->d_inode;
+	inode_lock(inode); /* to block new leases till after test_lock: */
+	err = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
 	if (err)
 		goto out;
 	lock->fl_file = nf->nf_file;
 	err = nfserrno(vfs_test_lock(nf->nf_file, lock));
 	lock->fl_file = NULL;
 out:
-	fh_unlock(fhp);
+	inode_unlock(inode);
 	nfsd_file_put(nf);
 	return err;
 }
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7de76b37a9bc2..73a153be6a5ad 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -417,7 +417,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			return err;
 	}
 
-	fh_lock(fhp);
+	inode_lock(inode);
 	if (size_change) {
 		/*
 		 * RFC5661, Section 18.30.4:
@@ -465,7 +465,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		attr->na_aclerr = set_posix_acl(&init_user_ns,
 						inode, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
-	fh_unlock(fhp);
+	inode_unlock(inode);
 	if (size_change)
 		put_write_access(inode);
 out:
@@ -2156,13 +2156,16 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char **bufp,
 	return err;
 }
 
-/*
- * Removexattr and setxattr need to call fh_lock to both lock the inode
- * and set the change attribute. Since the top-level vfs_removexattr
- * and vfs_setxattr calls already do their own inode_lock calls, call
- * the _locked variant. Pass in a NULL pointer for delegated_inode,
- * and let the client deal with NFS4ERR_DELAY (same as with e.g.
- * setattr and remove).
+/**
+ * nfsd_removexattr - Remove an extended attribute
+ * @rqstp: RPC transaction being executed
+ * @fhp: NFS filehandle of object with xattr to remove
+ * @name: name of xattr to remove (NUL-terminate)
+ *
+ * Pass in a NULL pointer for delegated_inode, and let the client deal
+ * with NFS4ERR_DELAY (same as with e.g. setattr and remove).
+ *
+ * Returns nfs_ok on success, or an nfsstat in network byte order.
  */
 __be32
 nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
@@ -2178,12 +2181,14 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
 	if (ret)
 		return nfserrno(ret);
 
-	fh_lock(fhp);
+	inode_lock(fhp->fh_dentry->d_inode);
+	fh_fill_pre_attrs(fhp);
 
 	ret = __vfs_removexattr_locked(&init_user_ns, fhp->fh_dentry,
 				       name, NULL);
 
-	fh_unlock(fhp);
+	fh_fill_post_attrs(fhp);
+	inode_unlock(fhp->fh_dentry->d_inode);
 	fh_drop_write(fhp);
 
 	return nfsd_xattr_errno(ret);
@@ -2203,12 +2208,13 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 	ret = fh_want_write(fhp);
 	if (ret)
 		return nfserrno(ret);
-	fh_lock(fhp);
+	inode_lock(fhp->fh_dentry->d_inode);
+	fh_fill_pre_attrs(fhp);
 
 	ret = __vfs_setxattr_locked(&init_user_ns, fhp->fh_dentry, name, buf,
 				    len, flags, NULL);
-
-	fh_unlock(fhp);
+	fh_fill_post_attrs(fhp);
+	inode_unlock(fhp->fh_dentry->d_inode);
 	fh_drop_write(fhp);
 
 	return nfsd_xattr_errno(ret);
-- 
2.43.0




