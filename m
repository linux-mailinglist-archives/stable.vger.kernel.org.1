Return-Path: <stable+bounces-37418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0618089C4C4
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296341C22537
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52077C6C9;
	Mon,  8 Apr 2024 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lrLTFMqy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D537C0B0;
	Mon,  8 Apr 2024 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584174; cv=none; b=cBxZeji1T8aAmUDO1W4VFjuQpwVNbqXizFchbIxhn3R4Ccp9ueJk6bUXHqjbMFAiEDsYnGSJjRIGqwv4AXLjDrsyfk9EWBb/bTV1kejY6Xd8rzwl68DxkxYEC8tkwHwB5m3pkhJzrFphjXnOox/KIZ33o8Kq/+3U4zgTRMIa1fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584174; c=relaxed/simple;
	bh=MSXPvBhyM++DdwrD2gDnzHUaUj8fKe6Cibxrlo5HH8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ia5VlUvsWW9c/QzT+dPhdD7qeqfkGAzbaeBeRudjHpGAUx31Iu8xpntlC+ieCcvY1Rp7g0GURAd8fSIQFDFCQFhtknBkyWzgMB/AAcvKE9LBqzIZva7hWC7Ivtm+2rDV7+3TsliYSFhNm1PY60dAhlwhsPQmbQ+8x8SaSKBdFt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lrLTFMqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3BFC43390;
	Mon,  8 Apr 2024 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584174;
	bh=MSXPvBhyM++DdwrD2gDnzHUaUj8fKe6Cibxrlo5HH8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrLTFMqyd2jI58n1h3ioFjCsMjXQx6V4cAW16i+GVx0bmAaR0WcRyz4ZUFkv3rY01
	 GQpGDXbYYyiTc1FQZpGL85ZwCA19Fj2qo2b5NX9vYG/Yi2ZScaIb9lmyr9GCU6gOAq
	 LK0gJicO4Fvt3+Hw5WMve0JB06UzBjdC1B/aOo3Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 319/690] NFSD: Remove do_nfsd_create()
Date: Mon,  8 Apr 2024 14:53:05 +0200
Message-ID: <20240408125411.166835175@linuxfoundation.org>
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

[ Upstream commit 1c388f27759c5d9271d4fca081f7ee138986eb7d ]

Now that its two callers have their own version-specific instance of
this function, do_nfsd_create() is no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 150 --------------------------------------------------
 fs/nfsd/vfs.h |  10 ----
 2 files changed, 160 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index e4f100a43ce52..9dd14c0eaebd1 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1395,156 +1395,6 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 					rdev, resfhp);
 }
 
-/*
- * NFSv3 and NFSv4 version of nfsd_create
- */
-__be32
-do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		char *fname, int flen, struct iattr *iap,
-		struct svc_fh *resfhp, int createmode, u32 *verifier,
-	        bool *truncp, bool *created)
-{
-	struct dentry	*dentry, *dchild = NULL;
-	struct inode	*dirp;
-	__be32		err;
-	int		host_err;
-	__u32		v_mtime=0, v_atime=0;
-
-	err = nfserr_perm;
-	if (!flen)
-		goto out;
-	err = nfserr_exist;
-	if (isdotent(fname, flen))
-		goto out;
-	if (!(iap->ia_valid & ATTR_MODE))
-		iap->ia_mode = 0;
-	err = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
-	if (err)
-		goto out;
-
-	dentry = fhp->fh_dentry;
-	dirp = d_inode(dentry);
-
-	host_err = fh_want_write(fhp);
-	if (host_err)
-		goto out_nfserr;
-
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
-
-	/*
-	 * Compose the response file handle.
-	 */
-	dchild = lookup_one_len(fname, dentry, flen);
-	host_err = PTR_ERR(dchild);
-	if (IS_ERR(dchild))
-		goto out_nfserr;
-
-	/* If file doesn't exist, check for permissions to create one */
-	if (d_really_is_negative(dchild)) {
-		err = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
-		if (err)
-			goto out;
-	}
-
-	err = fh_compose(resfhp, fhp->fh_export, dchild, fhp);
-	if (err)
-		goto out;
-
-	if (nfsd_create_is_exclusive(createmode)) {
-		/* solaris7 gets confused (bugid 4218508) if these have
-		 * the high bit set, as do xfs filesystems without the
-		 * "bigtime" feature.  So just clear the high bits. If this is
-		 * ever changed to use different attrs for storing the
-		 * verifier, then do_open_lookup() will also need to be fixed
-		 * accordingly.
-		 */
-		v_mtime = verifier[0]&0x7fffffff;
-		v_atime = verifier[1]&0x7fffffff;
-	}
-	
-	if (d_really_is_positive(dchild)) {
-		err = 0;
-
-		switch (createmode) {
-		case NFS3_CREATE_UNCHECKED:
-			if (! d_is_reg(dchild))
-				goto out;
-			else if (truncp) {
-				/* in nfsv4, we need to treat this case a little
-				 * differently.  we don't want to truncate the
-				 * file now; this would be wrong if the OPEN
-				 * fails for some other reason.  furthermore,
-				 * if the size is nonzero, we should ignore it
-				 * according to spec!
-				 */
-				*truncp = (iap->ia_valid & ATTR_SIZE) && !iap->ia_size;
-			}
-			else {
-				iap->ia_valid &= ATTR_SIZE;
-				goto set_attr;
-			}
-			break;
-		case NFS3_CREATE_EXCLUSIVE:
-			if (   d_inode(dchild)->i_mtime.tv_sec == v_mtime
-			    && d_inode(dchild)->i_atime.tv_sec == v_atime
-			    && d_inode(dchild)->i_size  == 0 ) {
-				if (created)
-					*created = true;
-				break;
-			}
-			fallthrough;
-		case NFS4_CREATE_EXCLUSIVE4_1:
-			if (   d_inode(dchild)->i_mtime.tv_sec == v_mtime
-			    && d_inode(dchild)->i_atime.tv_sec == v_atime
-			    && d_inode(dchild)->i_size  == 0 ) {
-				if (created)
-					*created = true;
-				goto set_attr;
-			}
-			fallthrough;
-		case NFS3_CREATE_GUARDED:
-			err = nfserr_exist;
-		}
-		goto out;
-	}
-
-	if (!IS_POSIXACL(dirp))
-		iap->ia_mode &= ~current_umask();
-
-	host_err = vfs_create(&init_user_ns, dirp, dchild, iap->ia_mode, true);
-	if (host_err < 0)
-		goto out_nfserr;
-	if (created)
-		*created = true;
-
-	nfsd_check_ignore_resizing(iap);
-
-	if (nfsd_create_is_exclusive(createmode)) {
-		/* Cram the verifier into atime/mtime */
-		iap->ia_valid = ATTR_MTIME|ATTR_ATIME
-			| ATTR_MTIME_SET|ATTR_ATIME_SET;
-		/* XXX someone who knows this better please fix it for nsec */ 
-		iap->ia_mtime.tv_sec = v_mtime;
-		iap->ia_atime.tv_sec = v_atime;
-		iap->ia_mtime.tv_nsec = 0;
-		iap->ia_atime.tv_nsec = 0;
-	}
-
- set_attr:
-	err = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
-
- out:
-	fh_unlock(fhp);
-	if (dchild && !IS_ERR(dchild))
-		dput(dchild);
-	fh_drop_write(fhp);
- 	return err;
- 
- out_nfserr:
-	err = nfserrno(host_err);
-	goto out;
-}
-
 /*
  * Read a symlink. On entry, *lenp must contain the maximum path length that
  * fits into the buffer. On return, it contains the true length.
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 1f32a83456b03..f99794b033a55 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -71,10 +71,6 @@ __be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_access(struct svc_rqst *, struct svc_fh *, u32 *, u32 *);
 __be32		nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct svc_fh *resfhp, struct iattr *iap);
-__be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
-				char *name, int len, struct iattr *attrs,
-				struct svc_fh *res, int createmode,
-				u32 *verifier, bool *truncp, bool *created);
 __be32		nfsd_commit(struct svc_rqst *rqst, struct svc_fh *fhp,
 				u64 offset, u32 count, __be32 *verf);
 #ifdef CONFIG_NFSD_V4
@@ -161,10 +157,4 @@ static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
 				    AT_STATX_SYNC_AS_STAT));
 }
 
-static inline int nfsd_create_is_exclusive(int createmode)
-{
-	return createmode == NFS3_CREATE_EXCLUSIVE
-	       || createmode == NFS4_CREATE_EXCLUSIVE4_1;
-}
-
 #endif /* LINUX_NFSD_VFS_H */
-- 
2.43.0




