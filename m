Return-Path: <stable+bounces-53480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A9F90D1D0
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0812A1C240CB
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B611A3BA4;
	Tue, 18 Jun 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IpG8RKLJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0181A38E7;
	Tue, 18 Jun 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716449; cv=none; b=fqQBX2Q8cCNRBwMFwnrg5FFgqs7rklk7xVSf1QjPmdJuo2fpH4scQIkRXx1dpcX0IZaYlsEU6VZPFQZS+VrOSx/GXWW+A78M0KjVgGVMAbcTmOpltVh0o5qgyVmUjLLptKdOR56mHuu2Uqlmnm959LskWumTMPS2nN1zjJ9IErs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716449; c=relaxed/simple;
	bh=cexiw87bpeg8HDJcxVJ62iUSO0LiXHefaZuyeXUHy/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKtFwiqnBMU6+OT9ZpBOlPm/ms6ogHIJBJ0K6rSXPmoHxpHjPs+PPOMR3gZ2Uyl2ntbq8ET1Jf6Qs8q34vxaJ0PIM3EjaD6Sir1Xn9ti0Xg1Glqvdeb25hzAoF4XJ0nqHE6RztsVjdccfmBqHBb0/xc8/tQ2s74XooWadSsQmkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IpG8RKLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E06AC3277B;
	Tue, 18 Jun 2024 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716449;
	bh=cexiw87bpeg8HDJcxVJ62iUSO0LiXHefaZuyeXUHy/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IpG8RKLJU5HOD0jC5HncLVjNqOZfOddCmHnKKZJtBgCj2HsCphthAV4XJ+1ziAHtu
	 TzL85DbyCVhdBdeovf1fXg+bPh1ulU+xBvBpBke462vzuG/ZaDWTrUGwF83gf1TsG6
	 Z09urIRnUlUyuWuziFCMRy9n2nksxYkI+92K8pIY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 619/770] NFSD: reduce locking in nfsd_lookup()
Date: Tue, 18 Jun 2024 14:37:52 +0200
Message-ID: <20240618123431.181441743@linuxfoundation.org>
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

[ Upstream commit 19d008b46941b8c668402170522e0f7a9258409c ]

nfsd_lookup() takes an exclusive lock on the parent inode, but no
callers want the lock and it may not be needed at all if the
result is in the dcache.

Change nfsd_lookup_dentry() to not take the lock, and call
lookup_one_len_locked() which takes lock only if needed.

nfsd4_open() currently expects the lock to still be held, but that isn't
necessary as nfsd_validate_delegated_dentry() provides required
guarantees without the lock.

NOTE: NFSv4 requires directory changeinfo for OPEN even when a create
  wasn't requested and no change happened.  Now that nfsd_lookup()
  doesn't use fh_lock(), we need to explicitly fill the attributes
  when no create happens.  A new fh_fill_both_attrs() is provided
  for that task.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c  | 20 ++++++++++++--------
 fs/nfsd/nfs4state.c |  3 ---
 fs/nfsd/nfsfh.c     | 19 +++++++++++++++++++
 fs/nfsd/nfsfh.h     |  2 +-
 fs/nfsd/vfs.c       | 34 ++++++++++++++--------------------
 5 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f588e592a0703..9cf4298817c4b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -302,6 +302,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (d_really_is_positive(child)) {
 		status = nfs_ok;
 
+		/* NFSv4 protocol requires change attributes even though
+		 * no change happened.
+		 */
+		fh_fill_both_attrs(fhp);
+
 		switch (open->op_createmode) {
 		case NFS4_CREATE_UNCHECKED:
 			if (!d_is_reg(child))
@@ -417,15 +422,15 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 		if (nfsd4_create_is_exclusive(open->op_createmode) && status == 0)
 			open->op_bmval[1] |= (FATTR4_WORD1_TIME_ACCESS |
 						FATTR4_WORD1_TIME_MODIFY);
-	} else
-		/*
-		 * Note this may exit with the parent still locked.
-		 * We will hold the lock until nfsd4_open's final
-		 * lookup, to prevent renames or unlinks until we've had
-		 * a chance to an acquire a delegation if appropriate.
-		 */
+	} else {
 		status = nfsd_lookup(rqstp, current_fh,
 				     open->op_fname, open->op_fnamelen, *resfh);
+		if (!status)
+			/* NFSv4 protocol requires change attributes even though
+			 * no change happened.
+			 */
+			fh_fill_both_attrs(current_fh);
+	}
 	if (status)
 		goto out;
 	status = nfsd_check_obj_isreg(*resfh);
@@ -1043,7 +1048,6 @@ nfsd4_secinfo(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				    &exp, &dentry);
 	if (err)
 		return err;
-	fh_unlock(&cstate->current_fh);
 	if (d_really_is_negative(dentry)) {
 		exp_put(exp);
 		err = nfserr_noent;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2b6c9f1b9de88..e44d9c8d5065a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5321,9 +5321,6 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *open, struct nfs4_file *fp,
 	struct dentry *child;
 	__be32 err;
 
-	/* parent may already be locked, and it may get unlocked by
-	 * this call, but that is safe.
-	 */
 	err = nfsd_lookup_dentry(open->op_rqstp, parent,
 				 open->op_fname, open->op_fnamelen,
 				 &exp, &child);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index d4ae838948ba5..cc680deecafa7 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -670,6 +670,25 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
 			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
 }
 
+/**
+ * fh_fill_both_attrs - Fill pre-op and post-op attributes
+ * @fhp: file handle to be updated
+ *
+ * This is used when the directory wasn't changed, but wcc attributes
+ * are needed anyway.
+ */
+void fh_fill_both_attrs(struct svc_fh *fhp)
+{
+	fh_fill_post_attrs(fhp);
+	if (!fhp->fh_post_saved)
+		return;
+	fhp->fh_pre_change = fhp->fh_post_change;
+	fhp->fh_pre_mtime = fhp->fh_post_attr.mtime;
+	fhp->fh_pre_ctime = fhp->fh_post_attr.ctime;
+	fhp->fh_pre_size = fhp->fh_post_attr.size;
+	fhp->fh_pre_saved = true;
+}
+
 /*
  * Release a file handle.
  */
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index fb9d358a267e5..28a4f9a94e2c8 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -322,7 +322,7 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
 
 extern void fh_fill_pre_attrs(struct svc_fh *fhp);
 extern void fh_fill_post_attrs(struct svc_fh *fhp);
-
+extern void fh_fill_both_attrs(struct svc_fh *fhp);
 
 /*
  * Lock a file handle/inode
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index dd945099ae6b5..03f6dd2ec653b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -198,27 +198,13 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				goto out_nfserr;
 		}
 	} else {
-		/*
-		 * In the nfsd4_open() case, this may be held across
-		 * subsequent open and delegation acquisition which may
-		 * need to take the child's i_mutex:
-		 */
-		fh_lock_nested(fhp, I_MUTEX_PARENT);
-		dentry = lookup_one_len(name, dparent, len);
+		dentry = lookup_one_len_unlocked(name, dparent, len);
 		host_err = PTR_ERR(dentry);
 		if (IS_ERR(dentry))
 			goto out_nfserr;
 		if (nfsd_mountpoint(dentry, exp)) {
-			/*
-			 * We don't need the i_mutex after all.  It's
-			 * still possible we could open this (regular
-			 * files can be mountpoints too), but the
-			 * i_mutex is just there to prevent renames of
-			 * something that we might be about to delegate,
-			 * and a mountpoint won't be renamed:
-			 */
-			fh_unlock(fhp);
-			if ((host_err = nfsd_cross_mnt(rqstp, &dentry, &exp))) {
+			host_err = nfsd_cross_mnt(rqstp, &dentry, &exp);
+			if (host_err) {
 				dput(dentry);
 				goto out_nfserr;
 			}
@@ -233,7 +219,15 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return nfserrno(host_err);
 }
 
-/*
+/**
+ * nfsd_lookup - look up a single path component for nfsd
+ *
+ * @rqstp:   the request context
+ * @fhp:     the file handle of the directory
+ * @name:    the component name, or %NULL to look up parent
+ * @len:     length of name to examine
+ * @resfh:   pointer to pre-initialised filehandle to hold result.
+ *
  * Look up one component of a pathname.
  * N.B. After this call _both_ fhp and resfh need an fh_put
  *
@@ -243,11 +237,11 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * returned. Otherwise the covered directory is returned.
  * NOTE: this mountpoint crossing is not supported properly by all
  *   clients and is explicitly disallowed for NFSv3
- *      NeilBrown <neilb@cse.unsw.edu.au>
+ *
  */
 __be32
 nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
-				unsigned int len, struct svc_fh *resfh)
+	    unsigned int len, struct svc_fh *resfh)
 {
 	struct svc_export	*exp;
 	struct dentry		*dentry;
-- 
2.43.0




