Return-Path: <stable+bounces-53340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96F790D131
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31EC1C23EE2
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B05419EEA0;
	Tue, 18 Jun 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dntI43Mq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32F13C667;
	Tue, 18 Jun 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716038; cv=none; b=W7ll7/cS+f92q2sarKVS0ek8mJwWWoA0SHjJeHaiAOn7h+BdA4RKEheInHKBHRn5aFeBLzzF0HdLeYe8/ha7uwBOIkDSf9nKVLFd3R09CSj+YFXsS8HUgrmdEhsBE+67tQxG3weW4exCIcLHz0GYwmh29Yk/1t0OD9pYm+hzhqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716038; c=relaxed/simple;
	bh=v1jIBVHwSCTDZQwh+O4pUFBl04YozFpFZ1TNGombq0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7Hnd5XXpPJd1MQXkvVblXY97DcerA+shFpRjmf3c97u4PqIGJ53+9oHi6Zmaop8gKq9EeKdjuUFGbAjpTRugkWeW8G0NjtevdY8O833fH+8gsdOHw1NlTsPpnWiLd9mHAy1uOYpHzGdsQc6WkflEs+5qGo4M8eWw1fcFj0mBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dntI43Mq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D334AC3277B;
	Tue, 18 Jun 2024 13:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716038;
	bh=v1jIBVHwSCTDZQwh+O4pUFBl04YozFpFZ1TNGombq0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dntI43MqfEbGEHYnc3Yc0j4zovSolkmRqr8j7I4x5Yg8ZbA9p6gsF0MRIVd+I2YLI
	 3QQbKBnuuxIVzgfBrE82qkCN4uiB4fWYp7EOQpHvZKe4jcSYv6Cb5RygYj5vGoD4N4
	 Ox1uyGHY2Bgh7mC7pj0WoaBa1wx1Q9XLoY5oIiXs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 510/770] NFSD: add courteous server support for thread with only delegation
Date: Tue, 18 Jun 2024 14:36:03 +0200
Message-ID: <20240618123426.996978393@linuxfoundation.org>
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

[ Upstream commit 66af25799940b26efd41ea6e648f75c41a48a2c2 ]

This patch provides courteous server support for delegation only.
Only expired client with delegation but no conflict and no open
or lock state is allowed to be in COURTESY state.

Delegation conflict with COURTESY/EXPIRABLE client is resolved by
setting it to EXPIRABLE, queue work for the laundromat and return
delay to the caller. Conflict is resolved when the laudromat runs
and expires the EXIRABLE client while the NFS client retries the
OPEN request. Local thread request that gets conflict is doing the
retry in _break_lease.

Client in COURTESY or EXPIRABLE state is allowed to reconnect and
continues to have access to its state. Access to the nfs4_client by
the reconnecting thread and the laundromat is serialized via the
client_lock.

Reviewed-by: J. Bruce Fields <bfields@fieldses.org>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 82 ++++++++++++++++++++++++++++++++++++---------
 fs/nfsd/nfsd.h      |  1 +
 fs/nfsd/state.h     | 31 +++++++++++++++++
 3 files changed, 99 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0170aaf318ea2..74c0a88904047 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -125,6 +125,8 @@ static void free_session(struct nfsd4_session *);
 static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
 
+static struct workqueue_struct *laundry_wq;
+
 static bool is_session_dead(struct nfsd4_session *ses)
 {
 	return ses->se_flags & NFS4_SESSION_DEAD;
@@ -152,6 +154,7 @@ static __be32 get_client_locked(struct nfs4_client *clp)
 	if (is_client_expired(clp))
 		return nfserr_expired;
 	atomic_inc(&clp->cl_rpc_users);
+	clp->cl_state = NFSD4_ACTIVE;
 	return nfs_ok;
 }
 
@@ -172,6 +175,7 @@ renew_client_locked(struct nfs4_client *clp)
 
 	list_move_tail(&clp->cl_lru, &nn->client_lru);
 	clp->cl_time = ktime_get_boottime_seconds();
+	clp->cl_state = NFSD4_ACTIVE;
 }
 
 static void put_client_renew_locked(struct nfs4_client *clp)
@@ -1102,6 +1106,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	get_clnt_odstate(odstate);
 	dp->dl_type = NFS4_OPEN_DELEGATE_READ;
 	dp->dl_retries = 1;
+	dp->dl_recalled = false;
 	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
 		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
 	get_nfs4_file(fp);
@@ -2017,6 +2022,8 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	idr_init(&clp->cl_stateids);
 	atomic_set(&clp->cl_rpc_users, 0);
 	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
+	clp->cl_state = NFSD4_ACTIVE;
+	atomic_set(&clp->cl_delegs_in_recall, 0);
 	INIT_LIST_HEAD(&clp->cl_idhash);
 	INIT_LIST_HEAD(&clp->cl_openowners);
 	INIT_LIST_HEAD(&clp->cl_delegations);
@@ -4711,9 +4718,18 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	bool ret = false;
 	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
+	struct nfs4_client *clp = dp->dl_stid.sc_client;
+	struct nfsd_net *nn;
 
 	trace_nfsd_cb_recall(&dp->dl_stid);
 
+	dp->dl_recalled = true;
+	atomic_inc(&clp->cl_delegs_in_recall);
+	if (try_to_expire_client(clp)) {
+		nn = net_generic(clp->net, nfsd_net_id);
+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+	}
+
 	/*
 	 * We don't want the locks code to timeout the lease for us;
 	 * we'll remove it ourself if a delegation isn't returned
@@ -4756,9 +4772,14 @@ static int
 nfsd_change_deleg_cb(struct file_lock *onlist, int arg,
 		     struct list_head *dispose)
 {
-	if (arg & F_UNLCK)
+	struct nfs4_delegation *dp = (struct nfs4_delegation *)onlist->fl_owner;
+	struct nfs4_client *clp = dp->dl_stid.sc_client;
+
+	if (arg & F_UNLCK) {
+		if (dp->dl_recalled)
+			atomic_dec(&clp->cl_delegs_in_recall);
 		return lease_modify(onlist, arg, dispose);
-	else
+	} else
 		return -EAGAIN;
 }
 
@@ -5622,6 +5643,49 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 }
 #endif
 
+/*
+ * place holder for now, no check for lock blockers yet
+ */
+static bool
+nfs4_anylock_blockers(struct nfs4_client *clp)
+{
+	if (atomic_read(&clp->cl_delegs_in_recall) ||
+			client_has_openowners(clp)  ||
+			!list_empty(&clp->async_copies))
+		return true;
+	return false;
+}
+
+static void
+nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
+				struct laundry_time *lt)
+{
+	struct list_head *pos, *next;
+	struct nfs4_client *clp;
+
+	INIT_LIST_HEAD(reaplist);
+	spin_lock(&nn->client_lock);
+	list_for_each_safe(pos, next, &nn->client_lru) {
+		clp = list_entry(pos, struct nfs4_client, cl_lru);
+		if (clp->cl_state == NFSD4_EXPIRABLE)
+			goto exp_client;
+		if (!state_expired(lt, clp->cl_time))
+			break;
+		if (!atomic_read(&clp->cl_rpc_users))
+			clp->cl_state = NFSD4_COURTESY;
+		if (!client_has_state(clp) ||
+				ktime_get_boottime_seconds() >=
+				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
+			goto exp_client;
+		if (nfs4_anylock_blockers(clp)) {
+exp_client:
+			if (!mark_client_expired_locked(clp))
+				list_add(&clp->cl_lru, reaplist);
+		}
+	}
+	spin_unlock(&nn->client_lock);
+}
+
 static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
@@ -5644,7 +5708,6 @@ nfs4_laundromat(struct nfsd_net *nn)
 		goto out;
 	}
 	nfsd4_end_grace(nn);
-	INIT_LIST_HEAD(&reaplist);
 
 	spin_lock(&nn->s2s_cp_lock);
 	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
@@ -5654,17 +5717,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 			_free_cpntf_state_locked(nn, cps);
 	}
 	spin_unlock(&nn->s2s_cp_lock);
-
-	spin_lock(&nn->client_lock);
-	list_for_each_safe(pos, next, &nn->client_lru) {
-		clp = list_entry(pos, struct nfs4_client, cl_lru);
-		if (!state_expired(&lt, clp->cl_time))
-			break;
-		if (mark_client_expired_locked(clp))
-			continue;
-		list_add(&clp->cl_lru, &reaplist);
-	}
-	spin_unlock(&nn->client_lock);
+	nfs4_get_client_reaplist(nn, &reaplist, &lt);
 	list_for_each_safe(pos, next, &reaplist) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
 		trace_nfsd_clid_purged(&clp->cl_clientid);
@@ -5739,7 +5792,6 @@ nfs4_laundromat(struct nfsd_net *nn)
 	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
 }
 
-static struct workqueue_struct *laundry_wq;
 static void laundromat_main(struct work_struct *);
 
 static void
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4fc1fd639527a..23996c6ca75e3 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
 #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
 
 #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
+#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 95457cfd37fc0..f3d6313914ed0 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -149,6 +149,7 @@ struct nfs4_delegation {
 /* For recall: */
 	int			dl_retries;
 	struct nfsd4_callback	dl_recall;
+	bool			dl_recalled;
 };
 
 #define cb_to_delegation(cb) \
@@ -282,6 +283,28 @@ struct nfsd4_sessionid {
 
 #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name plus '\0' */
 
+/*
+ *       State                Meaning                  Where set
+ * --------------------------------------------------------------------------
+ * | NFSD4_ACTIVE      | Confirmed, active    | Default                     |
+ * |------------------- ----------------------------------------------------|
+ * | NFSD4_COURTESY    | Courtesy state.      | nfs4_get_client_reaplist    |
+ * |                   | Lease/lock/share     |                             |
+ * |                   | reservation conflict |                             |
+ * |                   | can cause Courtesy   |                             |
+ * |                   | client to be expired |                             |
+ * |------------------------------------------------------------------------|
+ * | NFSD4_EXPIRABLE   | Courtesy client to be| nfs4_laundromat             |
+ * |                   | expired by Laundromat| try_to_expire_client        |
+ * |                   | due to conflict      |                             |
+ * |------------------------------------------------------------------------|
+ */
+enum {
+	NFSD4_ACTIVE = 0,
+	NFSD4_COURTESY,
+	NFSD4_EXPIRABLE,
+};
+
 /*
  * struct nfs4_client - one per client.  Clientids live here.
  *
@@ -385,6 +408,9 @@ struct nfs4_client {
 	struct list_head	async_copies;	/* list of async copies */
 	spinlock_t		async_lock;	/* lock for async copies */
 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
+
+	unsigned int		cl_state;
+	atomic_t		cl_delegs_in_recall;
 };
 
 /* struct nfs4_client_reset
@@ -702,4 +728,9 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
 extern int nfsd4_client_record_check(struct nfs4_client *clp);
 extern void nfsd4_record_grace_done(struct nfsd_net *nn);
 
+static inline bool try_to_expire_client(struct nfs4_client *clp)
+{
+	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
+	return clp->cl_state == NFSD4_EXPIRABLE;
+}
 #endif   /* NFSD4_STATE_H */
-- 
2.43.0




