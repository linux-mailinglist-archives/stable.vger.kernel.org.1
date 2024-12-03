Return-Path: <stable+bounces-96986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A09E2265
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E5B169239
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D8E1F706C;
	Tue,  3 Dec 2024 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N8j2I6t9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334A1F4709;
	Tue,  3 Dec 2024 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239188; cv=none; b=PStlk4Vu1n0bThXMozmnNrunPRY3rINhN38YrVGmEAz3QpbIZmtoCEubZsHPZhyBHp46j00R7VwJ8Sp9xTPDLhmVlJXg16cDWyDkCDjKyJo7t6Fpe3k6QPSg999o9OdVlaUfXeetZvDrgBhAnjPUvaUnIL7U9nbLubEX8mD4vT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239188; c=relaxed/simple;
	bh=k2k89T8FGBNbxys5lyW2amJLv70Ob9g9RhLnvKpruE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrSWAAxXoOF4GENxywWC9yhgLWUWohTBgrlDnXYobRJiHuDtcrw9kBkA6PaW/u8ZUSstTTat3kZPLq5UrEK7J+39O92w1ckD9klGNbhJSR/8RWjwTJ88R+I9KYWS79hGU9yUkoqS2bxRbzRfDvT2nTBmvZcpEBz7C5BiPR6j6Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N8j2I6t9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5F9C4CECF;
	Tue,  3 Dec 2024 15:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239188;
	bh=k2k89T8FGBNbxys5lyW2amJLv70Ob9g9RhLnvKpruE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8j2I6t96ISqc8VmeRNHpplb6pZ7yLoxhEVA1yWrrs06RUKDE8lrI7Cha3UFer2Nw
	 xu0Ir9xMDpfPPMtvKH2n6aMPvzNs/FhS+WViBs3pCgpMqjYGmY6g/DZH93chAJ/sUz
	 No1IR7oLdQnomli4Edh3a7eh9gOhbMEhaMHUCubk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 529/817] nfsd: drop inode parameter from nfsd4_change_attribute()
Date: Tue,  3 Dec 2024 15:41:41 +0100
Message-ID: <20241203144016.548590564@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit f67eef8da0e8c54709fefdecd16ad8d70f0c9d20 ]

The inode that nfs4_open_delegation() passes to this function is
wrong, which throws off the result. The inode will end up getting a
directory-style change attr instead of a regular-file-style one.

Fix up nfs4_delegation_stat() to fetch STATX_MODE, and then drop the
inode parameter from nfsd4_change_attribute(), since it's no longer
needed.

Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c |  5 ++---
 fs/nfsd/nfs4xdr.c   |  2 +-
 fs/nfsd/nfsfh.c     | 20 ++++++++++++--------
 fs/nfsd/nfsfh.h     |  3 +--
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d96d8cfd1ff86..e2903f4cc3ada 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5955,7 +5955,7 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
 	path.dentry = file_dentry(nf->nf_file);
 
 	rc = vfs_getattr(&path, stat,
-			 (STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
+			 (STATX_MODE | STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
 			 AT_STATX_SYNC_AS_STAT);
 
 	nfsd_file_put(nf);
@@ -6039,8 +6039,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		}
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
 		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
-		dp->dl_cb_fattr.ncf_initial_cinfo =
-			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
+		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
 		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
 	} else {
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ebbae04837ef0..6bf37124e389f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3040,7 +3040,7 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
 		return nfs_ok;
 	}
 
-	c = nfsd4_change_attribute(&args->stat, d_inode(args->dentry));
+	c = nfsd4_change_attribute(&args->stat);
 	return nfsd4_encode_changeid4(xdr, c);
 }
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index dd4e11a703aa6..85fd4d1b15620 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -618,20 +618,18 @@ fh_update(struct svc_fh *fhp)
 __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
-	struct inode *inode;
 	struct kstat stat;
 	__be32 err;
 
 	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
 		return nfs_ok;
 
-	inode = d_inode(fhp->fh_dentry);
 	err = fh_getattr(fhp, &stat);
 	if (err)
 		return err;
 
 	if (v4)
-		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
+		fhp->fh_pre_change = nfsd4_change_attribute(&stat);
 
 	fhp->fh_pre_mtime = stat.mtime;
 	fhp->fh_pre_ctime = stat.ctime;
@@ -648,7 +646,6 @@ __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
 __be32 fh_fill_post_attrs(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
-	struct inode *inode = d_inode(fhp->fh_dentry);
 	__be32 err;
 
 	if (fhp->fh_no_wcc)
@@ -664,7 +661,7 @@ __be32 fh_fill_post_attrs(struct svc_fh *fhp)
 	fhp->fh_post_saved = true;
 	if (v4)
 		fhp->fh_post_change =
-			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
+			nfsd4_change_attribute(&fhp->fh_post_attr);
 	return nfs_ok;
 }
 
@@ -755,7 +752,14 @@ enum fsid_source fsid_source(const struct svc_fh *fhp)
 	return FSIDSOURCE_DEV;
 }
 
-/*
+/**
+ * nfsd4_change_attribute - Generate an NFSv4 change_attribute value
+ * @stat: inode attributes
+ *
+ * Caller must fill in @stat before calling, typically by invoking
+ * vfs_getattr() with STATX_MODE, STATX_CTIME, and STATX_CHANGE_COOKIE.
+ * Returns an unsigned 64-bit changeid4 value (RFC 8881 Section 3.2).
+ *
  * We could use i_version alone as the change attribute.  However, i_version
  * can go backwards on a regular file after an unclean shutdown.  On its own
  * that doesn't necessarily cause a problem, but if i_version goes backwards
@@ -772,13 +776,13 @@ enum fsid_source fsid_source(const struct svc_fh *fhp)
  * assume that the new change attr is always logged to stable storage in some
  * fashion before the results can be seen.
  */
-u64 nfsd4_change_attribute(const struct kstat *stat, const struct inode *inode)
+u64 nfsd4_change_attribute(const struct kstat *stat)
 {
 	u64 chattr;
 
 	if (stat->result_mask & STATX_CHANGE_COOKIE) {
 		chattr = stat->change_cookie;
-		if (S_ISREG(inode->i_mode) &&
+		if (S_ISREG(stat->mode) &&
 		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
 			chattr += (u64)stat->ctime.tv_sec << 30;
 			chattr += stat->ctime.tv_nsec;
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 6ebdf7ea27bfd..c3da6d194b5fb 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -293,8 +293,7 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
 	fhp->fh_pre_saved = false;
 }
 
-u64 nfsd4_change_attribute(const struct kstat *stat,
-			   const struct inode *inode);
+u64 nfsd4_change_attribute(const struct kstat *stat);
 __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp);
 __be32 fh_fill_post_attrs(struct svc_fh *fhp);
 __be32 __must_check fh_fill_both_attrs(struct svc_fh *fhp);
-- 
2.43.0




