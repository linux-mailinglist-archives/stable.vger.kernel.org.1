Return-Path: <stable+bounces-53341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC9A90D132
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0EE1C23CC3
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988F119EEB1;
	Tue, 18 Jun 2024 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NAzHT1A3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5E19EEA9;
	Tue, 18 Jun 2024 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716041; cv=none; b=u4gAWu5Am5xO339nyjvnzLtKGisR2mj+9CRiLHsMz+mOFVlBKFB6EYTRCU7B83H4Ez3vXfivo0u5k8fIz+9hfVBh/o2DyRlRY4yHLEhtLiAsXQb6yu/Yopi0QdD8DPslaZCspKHMDVPoEkFJxrYQ60Y9XYdSa5/YL7NSlo+nFlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716041; c=relaxed/simple;
	bh=a3ghAKvMm6pSvBn9KZlnX1mu9GqTJ5Ed1CiNZPHB6k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zx+fZnnWicdEPHDLyfo02m8b28DUnuzuqfHGW96gSUf6Msxy5f5UJNy1wBn+brhN57V5FNd5vKRVNkNSfvhCXkPcOjW7ELc4UCrDshOvZEqNmZL85SXen7Or2JdPCxnR8MJAFUL4jEFP+b1RubwM7eU6e+T1YgLP6mrMD8lpWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NAzHT1A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF7EC4AF51;
	Tue, 18 Jun 2024 13:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716041;
	bh=a3ghAKvMm6pSvBn9KZlnX1mu9GqTJ5Ed1CiNZPHB6k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAzHT1A37AHin7l5ASQOE+PJ7gKlBnKyqC4jHZhKgTGAP0AzyUgTf3tKIlRBMeYWt
	 mWxjFUadSMy0w0BlXM6PC69FMok7eO+63cuYXOay1JKNthdpnEkn8+95vb4ugjrliN
	 86NJAXhmoZtxn4HgWfzIbZdcj7NT+pyn/zrnbdQw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 511/770] NFSD: add support for share reservation conflict to courteous server
Date: Tue, 18 Jun 2024 14:36:04 +0200
Message-ID: <20240618123427.035190867@linuxfoundation.org>
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

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit 3d69427151806656abf129342028f3f4e5e1fee0 ]

This patch allows expired client with open state to be in COURTESY
state. Share/access conflict with COURTESY client is resolved by
setting COURTESY client to EXPIRABLE state, schedule laundromat
to run and returning nfserr_jukebox to the request client.

Reviewed-by: J. Bruce Fields <bfields@fieldses.org>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 109 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 101 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 74c0a88904047..4ba0a70d8990f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -705,6 +705,57 @@ static unsigned int file_hashval(struct svc_fh *fh)
 
 static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
 
+/*
+ * Check if courtesy clients have conflicting access and resolve it if possible
+ *
+ * access:  is op_share_access if share_access is true.
+ *	    Check if access mode, op_share_access, would conflict with
+ *	    the current deny mode of the file 'fp'.
+ * access:  is op_share_deny if share_access is false.
+ *	    Check if the deny mode, op_share_deny, would conflict with
+ *	    current access of the file 'fp'.
+ * stp:     skip checking this entry.
+ * new_stp: normal open, not open upgrade.
+ *
+ * Function returns:
+ *	false - access/deny mode conflict with normal client.
+ *	true  - no conflict or conflict with courtesy client(s) is resolved.
+ */
+static bool
+nfs4_resolve_deny_conflicts_locked(struct nfs4_file *fp, bool new_stp,
+		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
+{
+	struct nfs4_ol_stateid *st;
+	bool resolvable = true;
+	unsigned char bmap;
+	struct nfsd_net *nn;
+	struct nfs4_client *clp;
+
+	lockdep_assert_held(&fp->fi_lock);
+	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
+		/* ignore lock stateid */
+		if (st->st_openstp)
+			continue;
+		if (st == stp && new_stp)
+			continue;
+		/* check file access against deny mode or vice versa */
+		bmap = share_access ? st->st_deny_bmap : st->st_access_bmap;
+		if (!(access & bmap_to_share_mode(bmap)))
+			continue;
+		clp = st->st_stid.sc_client;
+		if (try_to_expire_client(clp))
+			continue;
+		resolvable = false;
+		break;
+	}
+	if (resolvable) {
+		clp = stp->st_stid.sc_client;
+		nn = net_generic(clp->net, nfsd_net_id);
+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+	}
+	return resolvable;
+}
+
 static void
 __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
 {
@@ -4985,7 +5036,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 
 static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
-		struct nfsd4_open *open)
+		struct nfsd4_open *open, bool new_stp)
 {
 	struct nfsd_file *nf = NULL;
 	__be32 status;
@@ -5001,6 +5052,13 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	 */
 	status = nfs4_file_check_deny(fp, open->op_share_deny);
 	if (status != nfs_ok) {
+		if (status != nfserr_share_denied) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
+		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
+				stp, open->op_share_deny, false))
+			status = nfserr_jukebox;
 		spin_unlock(&fp->fi_lock);
 		goto out;
 	}
@@ -5008,6 +5066,13 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	/* set access to the file */
 	status = nfs4_file_get_access(fp, open->op_share_access);
 	if (status != nfs_ok) {
+		if (status != nfserr_share_denied) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
+		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
+				stp, open->op_share_access, true))
+			status = nfserr_jukebox;
 		spin_unlock(&fp->fi_lock);
 		goto out;
 	}
@@ -5054,21 +5119,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 }
 
 static __be32
-nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp, struct nfsd4_open *open)
+nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
+		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
+		struct nfsd4_open *open)
 {
 	__be32 status;
 	unsigned char old_deny_bmap = stp->st_deny_bmap;
 
 	if (!test_access(open->op_share_access, stp))
-		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
+		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
 
 	/* test and set deny mode */
 	spin_lock(&fp->fi_lock);
 	status = nfs4_file_check_deny(fp, open->op_share_deny);
 	if (status == nfs_ok) {
-		set_deny(open->op_share_deny, stp);
-		fp->fi_share_deny |=
+		if (status != nfserr_share_denied) {
+			set_deny(open->op_share_deny, stp);
+			fp->fi_share_deny |=
 				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
+		} else {
+			if (nfs4_resolve_deny_conflicts_locked(fp, false,
+					stp, open->op_share_deny, false))
+				status = nfserr_jukebox;
+		}
 	}
 	spin_unlock(&fp->fi_lock);
 
@@ -5409,7 +5482,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			goto out;
 		}
 	} else {
-		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
+		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
 		if (status) {
 			stp->st_stid.sc_type = NFS4_CLOSED_STID;
 			release_open_stateid(stp);
@@ -5643,6 +5716,26 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 }
 #endif
 
+static bool
+nfs4_has_any_locks(struct nfs4_client *clp)
+{
+	int i;
+	struct nfs4_stateowner *so;
+
+	spin_lock(&clp->cl_lock);
+	for (i = 0; i < OWNER_HASH_SIZE; i++) {
+		list_for_each_entry(so, &clp->cl_ownerstr_hashtbl[i],
+				so_strhash) {
+			if (so->so_is_open_owner)
+				continue;
+			spin_unlock(&clp->cl_lock);
+			return true;
+		}
+	}
+	spin_unlock(&clp->cl_lock);
+	return false;
+}
+
 /*
  * place holder for now, no check for lock blockers yet
  */
@@ -5650,8 +5743,8 @@ static bool
 nfs4_anylock_blockers(struct nfs4_client *clp)
 {
 	if (atomic_read(&clp->cl_delegs_in_recall) ||
-			client_has_openowners(clp)  ||
-			!list_empty(&clp->async_copies))
+			!list_empty(&clp->async_copies) ||
+			nfs4_has_any_locks(clp))
 		return true;
 	return false;
 }
-- 
2.43.0




