Return-Path: <stable+bounces-210954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCn6AvcycWlQfQAAu9opvQ
	(envelope-from <stable+bounces-210954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:11:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B33825CE5E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8975845C2D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E19301493;
	Wed, 21 Jan 2026 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cl1ehSyq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF8357708;
	Wed, 21 Jan 2026 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019944; cv=none; b=Y7fxryeuX+riumNjf3k9g4qbkY3JA+cUwpcnzPKlrS5P4xIr5NYE61wn7k+13H9Vi6vDBLpu+qGl0EQzvk/cOu+VUaB1az9MeL2PdhX8KiwzaNXy/hRyH9FIZAEpgvw7+rgrbgmXkpY35zawZRU4YSmIuk+2QOhpFLaX7wNclmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019944; c=relaxed/simple;
	bh=s3HIha4z6d+V0YGjg+AVCe0RGF0nopngXgVnUvnti6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqZd2uI9ssNZu8b96jnolDHGJKdsjZOjD86VE2dOsqr7+OJEuF9HnCEzYqSlJdlXX003ldKs+Aa0UXEaCWEWrVgz41EVKKCAsm697F3NUlbJG3/IzOwpm/jbdxO///hcpox/g95B8HDEKgqh+1TEOPciK0654GjgztcWAu3Mks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cl1ehSyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BD1C4CEF1;
	Wed, 21 Jan 2026 18:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019943;
	bh=s3HIha4z6d+V0YGjg+AVCe0RGF0nopngXgVnUvnti6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cl1ehSyqWJI7V0u/KTxFpphJh7l0IkLJkh654yrNdDdgrrV+pwtZgUNqYabRPHXNI
	 0PNOqKkgObeqxupHgjN0avSbvqoJKqetxuP0CxSu7V9HH7UebO7q2JlLl3pbOuUK+0
	 /pRLhQcLxA7VsWh7BFHMWWYTY6UXPuekCrHui1U0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 014/198] pNFS: Fix a deadlock when returning a delegation during open()
Date: Wed, 21 Jan 2026 19:14:02 +0100
Message-ID: <20260121181419.060618800@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-210954-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,hammerspace.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B33825CE5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 857bf9056291a16785ae3be1d291026b2437fc48 ]

Ben Coddington reports seeing a hang in the following stack trace:
  0 [ffffd0b50e1774e0] __schedule at ffffffff9ca05415
  1 [ffffd0b50e177548] schedule at ffffffff9ca05717
  2 [ffffd0b50e177558] bit_wait at ffffffff9ca061e1
  3 [ffffd0b50e177568] __wait_on_bit at ffffffff9ca05cfb
  4 [ffffd0b50e1775c8] out_of_line_wait_on_bit at ffffffff9ca05ea5
  5 [ffffd0b50e177618] pnfs_roc at ffffffffc154207b [nfsv4]
  6 [ffffd0b50e1776b8] _nfs4_proc_delegreturn at ffffffffc1506586 [nfsv4]
  7 [ffffd0b50e177788] nfs4_proc_delegreturn at ffffffffc1507480 [nfsv4]
  8 [ffffd0b50e1777f8] nfs_do_return_delegation at ffffffffc1523e41 [nfsv4]
  9 [ffffd0b50e177838] nfs_inode_set_delegation at ffffffffc1524a75 [nfsv4]
 10 [ffffd0b50e177888] nfs4_process_delegation at ffffffffc14f41dd [nfsv4]
 11 [ffffd0b50e1778a0] _nfs4_opendata_to_nfs4_state at ffffffffc1503edf [nfsv4]
 12 [ffffd0b50e1778c0] _nfs4_open_and_get_state at ffffffffc1504e56 [nfsv4]
 13 [ffffd0b50e177978] _nfs4_do_open at ffffffffc15051b8 [nfsv4]
 14 [ffffd0b50e1779f8] nfs4_do_open at ffffffffc150559c [nfsv4]
 15 [ffffd0b50e177a80] nfs4_atomic_open at ffffffffc15057fb [nfsv4]
 16 [ffffd0b50e177ad0] nfs4_file_open at ffffffffc15219be [nfsv4]
 17 [ffffd0b50e177b78] do_dentry_open at ffffffff9c09e6ea
 18 [ffffd0b50e177ba8] vfs_open at ffffffff9c0a082e
 19 [ffffd0b50e177bd0] dentry_open at ffffffff9c0a0935

The issue is that the delegreturn is being asked to wait for a layout
return that cannot complete because a state recovery was initiated. The
state recovery cannot complete until the open() finishes processing the
delegations it was given.

The solution is to propagate the existing flags that indicate a
non-blocking call to the function pnfs_roc(), so that it knows not to
wait in this situation.

Reported-by: Benjamin Coddington <bcodding@hammerspace.com>
Fixes: 29ade5db1293 ("pNFS: Wait on outstanding layoutreturns to complete in pnfs_roc()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c |  6 ++---
 fs/nfs/pnfs.c     | 58 +++++++++++++++++++++++++++++++++--------------
 fs/nfs/pnfs.h     | 17 ++++++--------
 3 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3b436ba2ed3bf..3745c59f0af25 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3894,8 +3894,8 @@ int nfs4_do_close(struct nfs4_state *state, gfp_t gfp_mask, int wait)
 	calldata->res.seqid = calldata->arg.seqid;
 	calldata->res.server = server;
 	calldata->res.lr_ret = -NFS4ERR_NOMATCHING_LAYOUT;
-	calldata->lr.roc = pnfs_roc(state->inode,
-			&calldata->lr.arg, &calldata->lr.res, msg.rpc_cred);
+	calldata->lr.roc = pnfs_roc(state->inode, &calldata->lr.arg,
+				    &calldata->lr.res, msg.rpc_cred, wait);
 	if (calldata->lr.roc) {
 		calldata->arg.lr_args = &calldata->lr.arg;
 		calldata->res.lr_res = &calldata->lr.res;
@@ -6946,7 +6946,7 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 	data->inode = nfs_igrab_and_active(inode);
 	if (data->inode || issync) {
 		data->lr.roc = pnfs_roc(inode, &data->lr.arg, &data->lr.res,
-					cred);
+					cred, issync);
 		if (data->lr.roc) {
 			data->args.lr_args = &data->lr.arg;
 			data->res.lr_res = &data->lr.res;
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 7ce2e840217cf..33bc6db0dc92f 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1533,10 +1533,9 @@ static int pnfs_layout_return_on_reboot(struct pnfs_layout_hdr *lo)
 				      PNFS_FL_LAYOUTRETURN_PRIVILEGED);
 }
 
-bool pnfs_roc(struct inode *ino,
-		struct nfs4_layoutreturn_args *args,
-		struct nfs4_layoutreturn_res *res,
-		const struct cred *cred)
+bool pnfs_roc(struct inode *ino, struct nfs4_layoutreturn_args *args,
+	      struct nfs4_layoutreturn_res *res, const struct cred *cred,
+	      bool sync)
 {
 	struct nfs_inode *nfsi = NFS_I(ino);
 	struct nfs_open_context *ctx;
@@ -1547,7 +1546,7 @@ bool pnfs_roc(struct inode *ino,
 	nfs4_stateid stateid;
 	enum pnfs_iomode iomode = 0;
 	bool layoutreturn = false, roc = false;
-	bool skip_read = false;
+	bool skip_read;
 
 	if (!nfs_have_layout(ino))
 		return false;
@@ -1560,20 +1559,14 @@ bool pnfs_roc(struct inode *ino,
 		lo = NULL;
 		goto out_noroc;
 	}
-	pnfs_get_layout_hdr(lo);
-	if (test_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags)) {
-		spin_unlock(&ino->i_lock);
-		rcu_read_unlock();
-		wait_on_bit(&lo->plh_flags, NFS_LAYOUT_RETURN,
-				TASK_UNINTERRUPTIBLE);
-		pnfs_put_layout_hdr(lo);
-		goto retry;
-	}
 
 	/* no roc if we hold a delegation */
+	skip_read = false;
 	if (nfs4_check_delegation(ino, FMODE_READ)) {
-		if (nfs4_check_delegation(ino, FMODE_WRITE))
+		if (nfs4_check_delegation(ino, FMODE_WRITE)) {
+			lo = NULL;
 			goto out_noroc;
+		}
 		skip_read = true;
 	}
 
@@ -1582,12 +1575,43 @@ bool pnfs_roc(struct inode *ino,
 		if (state == NULL)
 			continue;
 		/* Don't return layout if there is open file state */
-		if (state->state & FMODE_WRITE)
+		if (state->state & FMODE_WRITE) {
+			lo = NULL;
 			goto out_noroc;
+		}
 		if (state->state & FMODE_READ)
 			skip_read = true;
 	}
 
+	if (skip_read) {
+		bool writes = false;
+
+		list_for_each_entry(lseg, &lo->plh_segs, pls_list) {
+			if (lseg->pls_range.iomode != IOMODE_READ) {
+				writes = true;
+				break;
+			}
+		}
+		if (!writes) {
+			lo = NULL;
+			goto out_noroc;
+		}
+	}
+
+	pnfs_get_layout_hdr(lo);
+	if (test_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags)) {
+		if (!sync) {
+			pnfs_set_plh_return_info(
+				lo, skip_read ? IOMODE_RW : IOMODE_ANY, 0);
+			goto out_noroc;
+		}
+		spin_unlock(&ino->i_lock);
+		rcu_read_unlock();
+		wait_on_bit(&lo->plh_flags, NFS_LAYOUT_RETURN,
+			    TASK_UNINTERRUPTIBLE);
+		pnfs_put_layout_hdr(lo);
+		goto retry;
+	}
 
 	list_for_each_entry_safe(lseg, next, &lo->plh_segs, pls_list) {
 		if (skip_read && lseg->pls_range.iomode == IOMODE_READ)
@@ -1627,7 +1651,7 @@ bool pnfs_roc(struct inode *ino,
 out_noroc:
 	spin_unlock(&ino->i_lock);
 	rcu_read_unlock();
-	pnfs_layoutcommit_inode(ino, true);
+	pnfs_layoutcommit_inode(ino, sync);
 	if (roc) {
 		struct pnfs_layoutdriver_type *ld = NFS_SERVER(ino)->pnfs_curr_ld;
 		if (ld->prepare_layoutreturn)
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 91ff877185c8a..3db8f13d8fe4e 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -303,10 +303,9 @@ int pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
 				u32 seq);
 int pnfs_mark_layout_stateid_invalid(struct pnfs_layout_hdr *lo,
 		struct list_head *lseg_list);
-bool pnfs_roc(struct inode *ino,
-		struct nfs4_layoutreturn_args *args,
-		struct nfs4_layoutreturn_res *res,
-		const struct cred *cred);
+bool pnfs_roc(struct inode *ino, struct nfs4_layoutreturn_args *args,
+	      struct nfs4_layoutreturn_res *res, const struct cred *cred,
+	      bool sync);
 int pnfs_roc_done(struct rpc_task *task, struct nfs4_layoutreturn_args **argpp,
 		  struct nfs4_layoutreturn_res **respp, int *ret);
 void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
@@ -773,12 +772,10 @@ pnfs_layoutcommit_outstanding(struct inode *inode)
 	return false;
 }
 
-
-static inline bool
-pnfs_roc(struct inode *ino,
-		struct nfs4_layoutreturn_args *args,
-		struct nfs4_layoutreturn_res *res,
-		const struct cred *cred)
+static inline bool pnfs_roc(struct inode *ino,
+			    struct nfs4_layoutreturn_args *args,
+			    struct nfs4_layoutreturn_res *res,
+			    const struct cred *cred, bool sync)
 {
 	return false;
 }
-- 
2.51.0




