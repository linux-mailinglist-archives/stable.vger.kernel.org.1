Return-Path: <stable+bounces-53352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B8B90D148
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78977287E4F
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F284319F481;
	Tue, 18 Jun 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D6IKowjV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF20319F477;
	Tue, 18 Jun 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716073; cv=none; b=jzoYEo64mWl9cAePT9n9Q8+d66Vsxxqq5EkrzEVJWMemiH3/gZX0cSMniUNqeuBn4EJeWk9XEmmq2c/LJ3TUy1vCaPjvB8NwNbGQP5tFDSh3fgYPVeMNpv6d8OmjURoRUGutAG6B3m0vX23Xx2kC8zTJbkk6gIxJ+1KTUNO+QV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716073; c=relaxed/simple;
	bh=7sm4CSsd7CJBnh5hBV/uyW9PvAh9z0hVAuwoGj94QYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9RP9SWIxHAXg5vXGAPJGIDrJnSGwm9GXV14zsOPOGbAzkRg0Upntl7ocLzXhKcwGlWH++oQLeAuvfx5B1U+/OnbZD6kywQ5UsPpWPgp8w6MTX/BmLWNMhqpSRxc8oADHNY+t2pVzStIf6+MP/fjX8hRS6TLAj0bb4OOo9sGtvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D6IKowjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E15C3277B;
	Tue, 18 Jun 2024 13:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716073;
	bh=7sm4CSsd7CJBnh5hBV/uyW9PvAh9z0hVAuwoGj94QYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6IKowjVglKGu+yCpmdnPLVDn9hede2ZjOIBngQ/EE7arhTyCjECdnKgs5ulXOksS
	 vpi87iYftXU4IswilPFtZMY7DGJaiQdtcbviADFk624TklLGcnCstEHEMPQqIOF5H5
	 yiq/4B7RkEQ4Mm0qQil+TshEwkEv2PAaWxfGfnR4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	JianHong Yin <jiyin@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 524/770] NFSD: Instantiate a struct file when creating a regular NFSv4 file
Date: Tue, 18 Jun 2024 14:36:17 +0200
Message-ID: <20240618123427.538134775@linuxfoundation.org>
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

[ Upstream commit fb70bf124b051d4ded4ce57511dfec6d3ebf2b43 ]

There have been reports of races that cause NFSv4 OPEN(CREATE) to
return an error even though the requested file was created. NFSv4
does not provide a status code for this case.

To mitigate some of these problems, reorganize the NFSv4
OPEN(CREATE) logic to allocate resources before the file is actually
created, and open the new file while the parent directory is still
locked.

Two new APIs are added:

+ Add an API that works like nfsd_file_acquire() but does not open
the underlying file. The OPEN(CREATE) path can use this API when it
already has an open file.

+ Add an API that is kin to dentry_open(). NFSD needs to create a
file and grab an open "struct file *" atomically. The
alloc_empty_file() has to be done before the inode create. If it
fails (for example, because the NFS server has exceeded its
max_files limit), we avoid creating the file and can still return
an error to the NFS client.

BugLink: https://bugzilla.linux-nfs.org/show_bug.cgi?id=382
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: JianHong Yin <jiyin@redhat.com>
[ cel: backported to 5.10.y, prior to idmapped mounts ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 51 ++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/filecache.h |  2 ++
 fs/nfsd/nfs4proc.c  | 43 ++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4state.c | 16 +++++++++++---
 fs/nfsd/xdr4.h      |  1 +
 fs/open.c           | 41 ++++++++++++++++++++++++++++++++++++
 include/linux/fs.h  |  2 ++
 7 files changed, 142 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 3c297ccfcc59d..db9c68a3c1f3b 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -898,9 +898,9 @@ nfsd_file_is_cached(struct inode *inode)
 	return ret;
 }
 
-__be32
-nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		  unsigned int may_flags, struct nfsd_file **pnf)
+static __be32
+nfsd_do_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		     unsigned int may_flags, struct nfsd_file **pnf, bool open)
 {
 	__be32	status;
 	struct net *net = SVC_NET(rqstp);
@@ -995,10 +995,13 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		nfsd_file_gc();
 
 	nf->nf_mark = nfsd_file_mark_find_or_create(nf);
-	if (nf->nf_mark)
-		status = nfsd_open_verified(rqstp, fhp, may_flags,
-					    &nf->nf_file);
-	else
+	if (nf->nf_mark) {
+		if (open)
+			status = nfsd_open_verified(rqstp, fhp, may_flags,
+						    &nf->nf_file);
+		else
+			status = nfs_ok;
+	} else
 		status = nfserr_jukebox;
 	/*
 	 * If construction failed, or we raced with a call to unlink()
@@ -1018,6 +1021,40 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	goto out;
 }
 
+/**
+ * nfsd_file_acquire - Get a struct nfsd_file with an open file
+ * @rqstp: the RPC transaction being executed
+ * @fhp: the NFS filehandle of the file to be opened
+ * @may_flags: NFSD_MAY_ settings for the file
+ * @pnf: OUT: new or found "struct nfsd_file" object
+ *
+ * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
+ * network byte order is returned.
+ */
+__be32
+nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  unsigned int may_flags, struct nfsd_file **pnf)
+{
+	return nfsd_do_file_acquire(rqstp, fhp, may_flags, pnf, true);
+}
+
+/**
+ * nfsd_file_create - Get a struct nfsd_file, do not open
+ * @rqstp: the RPC transaction being executed
+ * @fhp: the NFS filehandle of the file just created
+ * @may_flags: NFSD_MAY_ settings for the file
+ * @pnf: OUT: new or found "struct nfsd_file" object
+ *
+ * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
+ * network byte order is returned.
+ */
+__be32
+nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		 unsigned int may_flags, struct nfsd_file **pnf)
+{
+	return nfsd_do_file_acquire(rqstp, fhp, may_flags, pnf, false);
+}
+
 /*
  * Note that fields may be added, removed or reordered in the future. Programs
  * scraping this file for info should test the labels to ensure they're
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 435ceab27897a..1da0c79a55804 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -59,5 +59,7 @@ void nfsd_file_close_inode_sync(struct inode *inode);
 bool nfsd_file_is_cached(struct inode *inode);
 __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **nfp);
+__be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  unsigned int may_flags, struct nfsd_file **nfp);
 int	nfsd_file_cache_stats_open(struct inode *, struct file *);
 #endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index adb64c9259bd8..166ebb126d37b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -243,6 +243,37 @@ static inline bool nfsd4_create_is_exclusive(int createmode)
 		createmode == NFS4_CREATE_EXCLUSIVE4_1;
 }
 
+static __be32
+nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *child,
+		 struct nfsd4_open *open)
+{
+	struct file *filp;
+	struct path path;
+	int oflags;
+
+	oflags = O_CREAT | O_LARGEFILE;
+	switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
+	case NFS4_SHARE_ACCESS_WRITE:
+		oflags |= O_WRONLY;
+		break;
+	case NFS4_SHARE_ACCESS_BOTH:
+		oflags |= O_RDWR;
+		break;
+	default:
+		oflags |= O_RDONLY;
+	}
+
+	path.mnt = fhp->fh_export->ex_path.mnt;
+	path.dentry = child;
+	filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
+			     current_cred());
+	if (IS_ERR(filp))
+		return nfserrno(PTR_ERR(filp));
+
+	open->op_filp = filp;
+	return nfs_ok;
+}
+
 /*
  * Implement NFSv4's unchecked, guarded, and exclusive create
  * semantics for regular files. Open state for this new file is
@@ -355,11 +386,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
-	host_err = vfs_create(inode, child, iap->ia_mode, true);
-	if (host_err < 0) {
-		status = nfserrno(host_err);
+	status = nfsd4_vfs_create(fhp, child, open);
+	if (status != nfs_ok)
 		goto out;
-	}
 	open->op_created = true;
 
 	/* A newly created file already has a file size of zero. */
@@ -517,6 +546,8 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		(int)open->op_fnamelen, open->op_fname,
 		open->op_openowner);
 
+	open->op_filp = NULL;
+
 	/* This check required by spec. */
 	if (open->op_create && open->op_claim_type != NFS4_OPEN_CLAIM_NULL)
 		return nfserr_inval;
@@ -613,6 +644,10 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (reclaim && !status)
 		nn->somebody_reclaimed = true;
 out:
+	if (open->op_filp) {
+		fput(open->op_filp);
+		open->op_filp = NULL;
+	}
 	if (resfh && resfh != &cstate->current_fh) {
 		fh_dup2(&cstate->current_fh, resfh);
 		fh_put(resfh);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9116496b476aa..9f972ca09eec7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5110,9 +5110,19 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 
 	if (!fp->fi_fds[oflag]) {
 		spin_unlock(&fp->fi_lock);
-		status = nfsd_file_acquire(rqstp, cur_fh, access, &nf);
-		if (status)
-			goto out_put_access;
+
+		if (!open->op_filp) {
+			status = nfsd_file_acquire(rqstp, cur_fh, access, &nf);
+			if (status != nfs_ok)
+				goto out_put_access;
+		} else {
+			status = nfsd_file_create(rqstp, cur_fh, access, &nf);
+			if (status != nfs_ok)
+				goto out_put_access;
+			nf->nf_file = open->op_filp;
+			open->op_filp = NULL;
+		}
+
 		spin_lock(&fp->fi_lock);
 		if (!fp->fi_fds[oflag]) {
 			fp->fi_fds[oflag] = nf;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 4a298ac5515df..448b687943cd3 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -273,6 +273,7 @@ struct nfsd4_open {
 	bool		op_truncate;        /* used during processing */
 	bool		op_created;         /* used during processing */
 	struct nfs4_openowner *op_openowner; /* used during processing */
+	struct file	*op_filp;           /* used during processing */
 	struct nfs4_file *op_file;          /* used during processing */
 	struct nfs4_ol_stateid *op_stp;	    /* used during processing */
 	struct nfs4_clnt_odstate *op_odstate; /* used during processing */
diff --git a/fs/open.c b/fs/open.c
index 9f56ebacfbefe..d69312a2d434b 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -954,6 +954,47 @@ struct file *dentry_open(const struct path *path, int flags,
 }
 EXPORT_SYMBOL(dentry_open);
 
+/**
+ * dentry_create - Create and open a file
+ * @path: path to create
+ * @flags: O_ flags
+ * @mode: mode bits for new file
+ * @cred: credentials to use
+ *
+ * Caller must hold the parent directory's lock, and have prepared
+ * a negative dentry, placed in @path->dentry, for the new file.
+ *
+ * Caller sets @path->mnt to the vfsmount of the filesystem where
+ * the new file is to be created. The parent directory and the
+ * negative dentry must reside on the same filesystem instance.
+ *
+ * On success, returns a "struct file *". Otherwise a ERR_PTR
+ * is returned.
+ */
+struct file *dentry_create(const struct path *path, int flags, umode_t mode,
+			   const struct cred *cred)
+{
+	struct file *f;
+	int error;
+
+	validate_creds(cred);
+	f = alloc_empty_file(flags, cred);
+	if (IS_ERR(f))
+		return f;
+
+	error = vfs_create(d_inode(path->dentry->d_parent),
+			   path->dentry, mode, true);
+	if (!error)
+		error = vfs_open(path, f);
+
+	if (unlikely(error)) {
+		fput(f);
+		return ERR_PTR(error);
+	}
+	return f;
+}
+EXPORT_SYMBOL(dentry_create);
+
 struct file *open_with_fake_path(const struct path *path, int flags,
 				struct inode *inode, const struct cred *cred)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3e9105b3cc767..7e7098bf2c57e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2618,6 +2618,8 @@ extern struct file *filp_open(const char *, int, umode_t);
 extern struct file *file_open_root(struct dentry *, struct vfsmount *,
 				   const char *, int, umode_t);
 extern struct file * dentry_open(const struct path *, int, const struct cred *);
+extern struct file *dentry_create(const struct path *path, int flags,
+				  umode_t mode, const struct cred *cred);
 extern struct file * open_with_fake_path(const struct path *, int,
 					 struct inode*, const struct cred *);
 static inline struct file *file_clone_open(struct file *file)
-- 
2.43.0




