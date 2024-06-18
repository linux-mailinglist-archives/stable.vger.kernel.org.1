Return-Path: <stable+bounces-53382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D4090D164
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2FA1F25D45
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879D1A01A9;
	Tue, 18 Jun 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bLctTCsJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558B11586D5;
	Tue, 18 Jun 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716159; cv=none; b=tD6EW/9p2rH3xiHBAWUeUlLJ+8ZhqMVDTtKq8cBajNDfkpgydujqeY2kkb9rVYK9LdXX2IFeFymNHLDBu9Hbq3I5veHWPWQOpkbxR3bICtHupXABWO8n74KfHEWsvCuLvcQ5KD7tS6CX01uYQQptqHI8fDH4gDWpn3FdF6fBW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716159; c=relaxed/simple;
	bh=RIk3fff49srFeZ3B+OX0DBa1BmOrUGpKa969HdiubzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reeWVNl6pdLwRNFaEjchkQkPME4kZuil01FuhHgYeZUT2tPfKfLjsxiBuNA/gBZej+u8jSz8iobHdwFHZMjroZR8qlmcDNoprtaZBcqbk9Oo4OUWM7H15K5dmwelxVEgUwNvoDrThZ/nSxGJvVU9PMYL0KdNWi2lzzjeYZDYZ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bLctTCsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12F9C32786;
	Tue, 18 Jun 2024 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716159;
	bh=RIk3fff49srFeZ3B+OX0DBa1BmOrUGpKa969HdiubzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLctTCsJoOlHNQvdsw+TTJqa0Nt+kZ1LM4ZPDniSSdiIvIIFmZzNwy4uMmpmJRDHd
	 vfOiwwuw+f2qnRYlvjcegbxZK1XQkmeeFkmfGj4nwUXiruMzxHRLmRxrkMLU5cak+a
	 Stn0j2kL0kD4dV8cFTdEtgjj6GKbz4BAFIlew1ww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 521/770] NFSD: Refactor NFSv4 OPEN(CREATE)
Date: Tue, 18 Jun 2024 14:36:14 +0200
Message-ID: <20240618123427.423829438@linuxfoundation.org>
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

[ Upstream commit 254454a5aa4a9f696d6bae080c08d5863e650f49 ]

Copy do_nfsd_create() to nfs4proc.c and remove NFSv3-specific logic.

[ cel: backported to 5.10.y, prior to idmapped mounts ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 162 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 152 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f3d6bd2bfa4f7..adb64c9259bd8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -37,6 +37,8 @@
 #include <linux/falloc.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
+#include <linux/namei.h>
+
 #include <linux/sunrpc/addr.h>
 #include <linux/nfs_ssc.h>
 
@@ -235,6 +237,154 @@ static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_state *cstate
 			&resfh->fh_handle);
 }
 
+static inline bool nfsd4_create_is_exclusive(int createmode)
+{
+	return createmode == NFS4_CREATE_EXCLUSIVE ||
+		createmode == NFS4_CREATE_EXCLUSIVE4_1;
+}
+
+/*
+ * Implement NFSv4's unchecked, guarded, and exclusive create
+ * semantics for regular files. Open state for this new file is
+ * subsequently fabricated in nfsd4_process_open2().
+ *
+ * Upon return, caller must release @fhp and @resfhp.
+ */
+static __be32
+nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  struct svc_fh *resfhp, struct nfsd4_open *open)
+{
+	struct iattr *iap = &open->op_iattr;
+	struct dentry *parent, *child;
+	__u32 v_mtime, v_atime;
+	struct inode *inode;
+	__be32 status;
+	int host_err;
+
+	if (isdotent(open->op_fname, open->op_fnamelen))
+		return nfserr_exist;
+	if (!(iap->ia_valid & ATTR_MODE))
+		iap->ia_mode = 0;
+
+	status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
+	if (status != nfs_ok)
+		return status;
+	parent = fhp->fh_dentry;
+	inode = d_inode(parent);
+
+	host_err = fh_want_write(fhp);
+	if (host_err)
+		return nfserrno(host_err);
+
+	fh_lock_nested(fhp, I_MUTEX_PARENT);
+
+	child = lookup_one_len(open->op_fname, parent, open->op_fnamelen);
+	if (IS_ERR(child)) {
+		status = nfserrno(PTR_ERR(child));
+		goto out;
+	}
+
+	if (d_really_is_negative(child)) {
+		status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
+		if (status != nfs_ok)
+			goto out;
+	}
+
+	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
+	if (status != nfs_ok)
+		goto out;
+
+	v_mtime = 0;
+	v_atime = 0;
+	if (nfsd4_create_is_exclusive(open->op_createmode)) {
+		u32 *verifier = (u32 *)open->op_verf.data;
+
+		/*
+		 * Solaris 7 gets confused (bugid 4218508) if these have
+		 * the high bit set, as do xfs filesystems without the
+		 * "bigtime" feature. So just clear the high bits. If this
+		 * is ever changed to use different attrs for storing the
+		 * verifier, then do_open_lookup() will also need to be
+		 * fixed accordingly.
+		 */
+		v_mtime = verifier[0] & 0x7fffffff;
+		v_atime = verifier[1] & 0x7fffffff;
+	}
+
+	if (d_really_is_positive(child)) {
+		status = nfs_ok;
+
+		switch (open->op_createmode) {
+		case NFS4_CREATE_UNCHECKED:
+			if (!d_is_reg(child))
+				break;
+
+			/*
+			 * In NFSv4, we don't want to truncate the file
+			 * now. This would be wrong if the OPEN fails for
+			 * some other reason. Furthermore, if the size is
+			 * nonzero, we should ignore it according to spec!
+			 */
+			open->op_truncate = (iap->ia_valid & ATTR_SIZE) &&
+						!iap->ia_size;
+			break;
+		case NFS4_CREATE_GUARDED:
+			status = nfserr_exist;
+			break;
+		case NFS4_CREATE_EXCLUSIVE:
+			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
+			    d_inode(child)->i_atime.tv_sec == v_atime &&
+			    d_inode(child)->i_size == 0) {
+				open->op_created = true;
+				break;		/* subtle */
+			}
+			status = nfserr_exist;
+			break;
+		case NFS4_CREATE_EXCLUSIVE4_1:
+			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
+			    d_inode(child)->i_atime.tv_sec == v_atime &&
+			    d_inode(child)->i_size == 0) {
+				open->op_created = true;
+				goto set_attr;	/* subtle */
+			}
+			status = nfserr_exist;
+		}
+		goto out;
+	}
+
+	if (!IS_POSIXACL(inode))
+		iap->ia_mode &= ~current_umask();
+
+	host_err = vfs_create(inode, child, iap->ia_mode, true);
+	if (host_err < 0) {
+		status = nfserrno(host_err);
+		goto out;
+	}
+	open->op_created = true;
+
+	/* A newly created file already has a file size of zero. */
+	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
+		iap->ia_valid &= ~ATTR_SIZE;
+	if (nfsd4_create_is_exclusive(open->op_createmode)) {
+		iap->ia_valid = ATTR_MTIME | ATTR_ATIME |
+				ATTR_MTIME_SET|ATTR_ATIME_SET;
+		iap->ia_mtime.tv_sec = v_mtime;
+		iap->ia_atime.tv_sec = v_atime;
+		iap->ia_mtime.tv_nsec = 0;
+		iap->ia_atime.tv_nsec = 0;
+	}
+
+set_attr:
+	status = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
+
+out:
+	fh_unlock(fhp);
+	if (child && !IS_ERR(child))
+		dput(child);
+	fh_drop_write(fhp);
+	return status;
+}
+
 static __be32
 do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, struct nfsd4_open *open, struct svc_fh **resfh)
 {
@@ -264,16 +414,8 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 		 * yes          | yes    | GUARDED4        | GUARDED4
 		 */
 
-		/*
-		 * Note: create modes (UNCHECKED,GUARDED...) are the same
-		 * in NFSv4 as in v3 except EXCLUSIVE4_1.
-		 */
 		current->fs->umask = open->op_umask;
-		status = do_nfsd_create(rqstp, current_fh, open->op_fname,
-					open->op_fnamelen, &open->op_iattr,
-					*resfh, open->op_createmode,
-					(u32 *)open->op_verf.data,
-					&open->op_truncate, &open->op_created);
+		status = nfsd4_create_file(rqstp, current_fh, *resfh, open);
 		current->fs->umask = 0;
 
 		if (!status && open->op_label.len)
@@ -284,7 +426,7 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 		 * use the returned bitmask to indicate which attributes
 		 * we used to store the verifier:
 		 */
-		if (nfsd_create_is_exclusive(open->op_createmode) && status == 0)
+		if (nfsd4_create_is_exclusive(open->op_createmode) && status == 0)
 			open->op_bmval[1] |= (FATTR4_WORD1_TIME_ACCESS |
 						FATTR4_WORD1_TIME_MODIFY);
 	} else
-- 
2.43.0




