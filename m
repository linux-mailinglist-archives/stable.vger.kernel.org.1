Return-Path: <stable+bounces-53483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7709990D1DA
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE0D1F27C9C
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3774D1A3BD2;
	Tue, 18 Jun 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xwE4ltRq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95761A3BC8;
	Tue, 18 Jun 2024 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716459; cv=none; b=WAVgU26frAB2kY+yCQavwtJAsaTKPppmq+nLAoywkk2G73bCw59936K1dr2KJvbZ5pVwTw95xVJ/r4NTXczR3jd8+0Jhsy5YT5e8LacBBd17pqldCpDX0oX2zczlJvB4zC03j1n44xA+CaTHJBHVkNR60KM1ZpudW5squ0UOqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716459; c=relaxed/simple;
	bh=B2Ywz4iYTOGNXhTSclSv+ELVp/P3C8+Z5Ai2eYIbWuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSssF1KbFRyetO5KspqOjxQVhrIfkrLEdMry5s83zUQx/TsAV86px5JvQj8fPj7IR74T5wMkFmEuObBl7tLIfh2E2P0k4yIx0ggjGsIVnE7hfFMzyoabJDCTm0L/DxkDLjCZt6QgXUPfZcaOOIIeVOUeaIOtWt20FWUKzjWGCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xwE4ltRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151C1C3277B;
	Tue, 18 Jun 2024 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716458;
	bh=B2Ywz4iYTOGNXhTSclSv+ELVp/P3C8+Z5Ai2eYIbWuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xwE4ltRqlbEdYlcrsgJptQYMGuV0VfXOI8PQrZSuP+EUqJT5z2ijWBwFaKkotz0Ex
	 yTK1w00WwZopFvXxQ+u4hVJH2SzPIZGQ0a9LwaUGAxf87EmjicWTC9ySGD0JwZF4jx
	 8DgfukgZ9AMb4A47k0TtU/5q0rsyy4Fu9K3XpQlQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 622/770] NFSD: discard fh_locked flag and fh_lock/fh_unlock
Date: Tue, 18 Jun 2024 14:37:55 +0200
Message-ID: <20240618123431.295420760@linuxfoundation.org>
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

[ Upstream commit dd8dd403d7b223cc77ee89d8d09caf045e90e648 ]

As all inode locking is now fully balanced, fh_put() does not need to
call fh_unlock().
fh_lock() and fh_unlock() are no longer used, so discard them.
These are the only real users of ->fh_locked, so discard that too.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsfh.c |  3 +--
 fs/nfsd/nfsfh.h | 56 ++++---------------------------------------------
 fs/nfsd/vfs.c   | 17 +--------------
 3 files changed, 6 insertions(+), 70 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index cc680deecafa7..db8d62632a5be 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -547,7 +547,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 	if (ref_fh == fhp)
 		fh_put(ref_fh);
 
-	if (fhp->fh_locked || fhp->fh_dentry) {
+	if (fhp->fh_dentry) {
 		printk(KERN_ERR "fh_compose: fh %pd2 not initialized!\n",
 		       dentry);
 	}
@@ -698,7 +698,6 @@ fh_put(struct svc_fh *fhp)
 	struct dentry * dentry = fhp->fh_dentry;
 	struct svc_export * exp = fhp->fh_export;
 	if (dentry) {
-		fh_unlock(fhp);
 		fhp->fh_dentry = NULL;
 		dput(dentry);
 		fh_clear_pre_post_attrs(fhp);
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 28a4f9a94e2c8..c3ae6414fc5cf 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -81,7 +81,6 @@ typedef struct svc_fh {
 	struct dentry *		fh_dentry;	/* validated dentry */
 	struct svc_export *	fh_export;	/* export pointer */
 
-	bool			fh_locked;	/* inode locked by us */
 	bool			fh_want_write;	/* remount protection taken */
 	bool			fh_no_wcc;	/* no wcc data needed */
 	bool			fh_no_atomic_attr;
@@ -93,7 +92,7 @@ typedef struct svc_fh {
 	bool			fh_post_saved;	/* post-op attrs saved */
 	bool			fh_pre_saved;	/* pre-op attrs saved */
 
-	/* Pre-op attributes saved during fh_lock */
+	/* Pre-op attributes saved when inode is locked */
 	__u64			fh_pre_size;	/* size before operation */
 	struct timespec64	fh_pre_mtime;	/* mtime before oper */
 	struct timespec64	fh_pre_ctime;	/* ctime before oper */
@@ -103,7 +102,7 @@ typedef struct svc_fh {
 	 */
 	u64			fh_pre_change;
 
-	/* Post-op attributes saved in fh_unlock */
+	/* Post-op attributes saved in fh_fill_post_attrs() */
 	struct kstat		fh_post_attr;	/* full attrs after operation */
 	u64			fh_post_change; /* nfsv4 change; see above */
 } svc_fh;
@@ -223,8 +222,8 @@ void	fh_put(struct svc_fh *);
 static __inline__ struct svc_fh *
 fh_copy(struct svc_fh *dst, struct svc_fh *src)
 {
-	WARN_ON(src->fh_dentry || src->fh_locked);
-			
+	WARN_ON(src->fh_dentry);
+
 	*dst = *src;
 	return dst;
 }
@@ -323,51 +322,4 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
 extern void fh_fill_pre_attrs(struct svc_fh *fhp);
 extern void fh_fill_post_attrs(struct svc_fh *fhp);
 extern void fh_fill_both_attrs(struct svc_fh *fhp);
-
-/*
- * Lock a file handle/inode
- * NOTE: both fh_lock and fh_unlock are done "by hand" in
- * vfs.c:nfsd_rename as it needs to grab 2 i_mutex's at once
- * so, any changes here should be reflected there.
- */
-
-static inline void
-fh_lock_nested(struct svc_fh *fhp, unsigned int subclass)
-{
-	struct dentry	*dentry = fhp->fh_dentry;
-	struct inode	*inode;
-
-	BUG_ON(!dentry);
-
-	if (fhp->fh_locked) {
-		printk(KERN_WARNING "fh_lock: %pd2 already locked!\n",
-			dentry);
-		return;
-	}
-
-	inode = d_inode(dentry);
-	inode_lock_nested(inode, subclass);
-	fh_fill_pre_attrs(fhp);
-	fhp->fh_locked = true;
-}
-
-static inline void
-fh_lock(struct svc_fh *fhp)
-{
-	fh_lock_nested(fhp, I_MUTEX_NORMAL);
-}
-
-/*
- * Unlock a file handle/inode
- */
-static inline void
-fh_unlock(struct svc_fh *fhp)
-{
-	if (fhp->fh_locked) {
-		fh_fill_post_attrs(fhp);
-		inode_unlock(d_inode(fhp->fh_dentry));
-		fhp->fh_locked = false;
-	}
-}
-
 #endif /* _LINUX_NFSD_NFSFH_H */
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 504a3ddfaf75b..5a7fee4ee2079 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1282,13 +1282,6 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dirp = d_inode(dentry);
 
 	dchild = dget(resfhp->fh_dentry);
-	if (!fhp->fh_locked) {
-		WARN_ONCE(1, "nfsd_create: parent %pd2 not locked!\n",
-				dentry);
-		err = nfserr_io;
-		goto out;
-	}
-
 	err = nfsd_permission(rqstp, fhp->fh_export, dentry, NFSD_MAY_CREATE);
 	if (err)
 		goto out;
@@ -1656,10 +1649,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		goto out;
 	}
 
-	/* cannot use fh_lock as we need deadlock protective ordering
-	 * so do it by hand */
 	trap = lock_rename(tdentry, fdentry);
-	ffhp->fh_locked = tfhp->fh_locked = true;
 	fh_fill_pre_attrs(ffhp);
 	fh_fill_pre_attrs(tfhp);
 
@@ -1707,17 +1697,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	dput(odentry);
  out_nfserr:
 	err = nfserrno(host_err);
-	/*
-	 * We cannot rely on fh_unlock on the two filehandles,
-	 * as that would do the wrong thing if the two directories
-	 * were the same, so again we do it by hand.
-	 */
+
 	if (!close_cached) {
 		fh_fill_post_attrs(ffhp);
 		fh_fill_post_attrs(tfhp);
 	}
 	unlock_rename(tdentry, fdentry);
-	ffhp->fh_locked = tfhp->fh_locked = false;
 	fh_drop_write(ffhp);
 
 	/*
-- 
2.43.0




