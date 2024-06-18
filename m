Return-Path: <stable+bounces-53110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB3790D03F
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DA11C23C6D
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E865816DC21;
	Tue, 18 Jun 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lWHHF78F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A7F1552E4;
	Tue, 18 Jun 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715357; cv=none; b=Nn5y6hV16NegveD0zPYUe3wZ6e+8AQDP9K5LO6qjDhlOup5qqjjo3OFmaxgAJwxx57IMIfKblJyDB+wlRy3wz6Ga2LPv4oJJFvXVGMI64fn/NiJke1pHa1G7WauxLqW73aaemJ6tq/C6nXctNibqvHJb57bSxrzRSRnzLZBbo9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715357; c=relaxed/simple;
	bh=pF54TLfCJ7q3RStfDf1fWL0mGpteNgxcKg7APvbE1HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1kvbI/3KmjyrzJas4HeQ/l7/tdQVIHk9wOjabKhtHm/uXtIDianeUbEvNVNpDP15ESkeEHZM3BYfRf4JwsK7c5L3qSOnj5pGg7GXTY/AFm1PbFiP3qvQvr8I0k1foUJj6OUloZ3pWH2RYBFtDX49Lsq9UlXXw2oOe2sdAwvPZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lWHHF78F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2FDC3277B;
	Tue, 18 Jun 2024 12:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715357;
	bh=pF54TLfCJ7q3RStfDf1fWL0mGpteNgxcKg7APvbE1HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWHHF78FSSFH0tf5Id6yk+h6LfATZPEAkaXCYDE1UESGFf0nml/+DmaPhoDk7ABHA
	 r0KJCeJxxbqbEpNZ89BOPRKOLmDB8wd8hdMxd5nH65TC6OWkGArwrAPw2vOMphPJqS
	 s0Bude9fMji6Tz1g/Y6Osuc5CfDezWakVcyPOT6I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"J. Bruce Fields" <bfields@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 240/770] nfsd: helper for laundromat expiry calculations
Date: Tue, 18 Jun 2024 14:31:33 +0200
Message-ID: <20240618123416.543387294@linuxfoundation.org>
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

From: J. Bruce Fields <bfields@redhat.com>

[ Upstream commit 7f7e7a4006f74b031718055a0751c70c2e3d5e7e ]

We do this same logic repeatedly, and it's easy to get the sense of the
comparison wrong.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 49 +++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 914f60cee3226..0afc14b3e4593 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5385,6 +5385,22 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 	return true;
 }
 
+struct laundry_time {
+	time64_t cutoff;
+	time64_t new_timeo;
+};
+
+static bool state_expired(struct laundry_time *lt, time64_t last_refresh)
+{
+	time64_t time_remaining;
+
+	if (last_refresh < lt->cutoff)
+		return true;
+	time_remaining = last_refresh - lt->cutoff;
+	lt->new_timeo = min(lt->new_timeo, time_remaining);
+	return false;
+}
+
 static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
@@ -5394,14 +5410,16 @@ nfs4_laundromat(struct nfsd_net *nn)
 	struct nfs4_ol_stateid *stp;
 	struct nfsd4_blocked_lock *nbl;
 	struct list_head *pos, *next, reaplist;
-	time64_t cutoff = ktime_get_boottime_seconds() - nn->nfsd4_lease;
-	time64_t t, new_timeo = nn->nfsd4_lease;
+	struct laundry_time lt = {
+		.cutoff = ktime_get_boottime_seconds() - nn->nfsd4_lease,
+		.new_timeo = nn->nfsd4_lease
+	};
 	struct nfs4_cpntf_state *cps;
 	copy_stateid_t *cps_t;
 	int i;
 
 	if (clients_still_reclaiming(nn)) {
-		new_timeo = 0;
+		lt.new_timeo = 0;
 		goto out;
 	}
 	nfsd4_end_grace(nn);
@@ -5411,7 +5429,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
 		cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
 		if (cps->cp_stateid.sc_type == NFS4_COPYNOTIFY_STID &&
-				cps->cpntf_time < cutoff)
+				state_expired(&lt, cps->cpntf_time))
 			_free_cpntf_state_locked(nn, cps);
 	}
 	spin_unlock(&nn->s2s_cp_lock);
@@ -5419,11 +5437,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
-		if (clp->cl_time > cutoff) {
-			t = clp->cl_time - cutoff;
-			new_timeo = min(new_timeo, t);
+		if (!state_expired(&lt, clp->cl_time))
 			break;
-		}
 		if (mark_client_expired_locked(clp)) {
 			trace_nfsd_clid_expired(&clp->cl_clientid);
 			continue;
@@ -5440,11 +5455,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
-		if (dp->dl_time > cutoff) {
-			t = dp->dl_time - cutoff;
-			new_timeo = min(new_timeo, t);
+		if (!state_expired(&lt, dp->dl_time))
 			break;
-		}
 		WARN_ON(!unhash_delegation_locked(dp));
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
@@ -5460,11 +5472,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	while (!list_empty(&nn->close_lru)) {
 		oo = list_first_entry(&nn->close_lru, struct nfs4_openowner,
 					oo_close_lru);
-		if (oo->oo_time > cutoff) {
-			t = oo->oo_time - cutoff;
-			new_timeo = min(new_timeo, t);
+		if (!state_expired(&lt, oo->oo_time))
 			break;
-		}
 		list_del_init(&oo->oo_close_lru);
 		stp = oo->oo_last_closed_stid;
 		oo->oo_last_closed_stid = NULL;
@@ -5490,11 +5499,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	while (!list_empty(&nn->blocked_locks_lru)) {
 		nbl = list_first_entry(&nn->blocked_locks_lru,
 					struct nfsd4_blocked_lock, nbl_lru);
-		if (nbl->nbl_time > cutoff) {
-			t = nbl->nbl_time - cutoff;
-			new_timeo = min(new_timeo, t);
+		if (!state_expired(&lt, nbl->nbl_time))
 			break;
-		}
 		list_move(&nbl->nbl_lru, &reaplist);
 		list_del_init(&nbl->nbl_list);
 	}
@@ -5507,8 +5513,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		free_blocked_lock(nbl);
 	}
 out:
-	new_timeo = max_t(time64_t, new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
-	return new_timeo;
+	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
 }
 
 static struct workqueue_struct *laundry_wq;
-- 
2.43.0




