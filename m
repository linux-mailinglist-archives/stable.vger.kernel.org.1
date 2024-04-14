Return-Path: <stable+bounces-37505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9ED89C526
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538DB283FFD
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069A974BE5;
	Mon,  8 Apr 2024 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SnHRPOSe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17871B20;
	Mon,  8 Apr 2024 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584430; cv=none; b=OTUHc+GdHaJ4kesMf786zh+UcwG39holqQnz9/vDuHR8e60mtzSLl9AmxZJwD9vHVBEo3yuins9HJ1GIzNwBWMKwxnU6EjJ28XTN9sef7OJNK1qd9wDzl/v6iYC58Jc5G22SfztmoruhEKufnx6U2BdGtscts0+jl3kfS+uKT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584430; c=relaxed/simple;
	bh=O84oGCFNoWs6zVE35nsOJc26bMeAn8adh7t7EmRZA7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9CxeN29WbI3DMpUmOBgOLnVzm7M2C22la34dBSjx2n/7VKEWm7E402S+bIcPX9OrT0ldDYYdGxDSF6rIDgEjh66udTBP2irQhY6S7ragGaUsL80BKmkIlCGD3mhqKA6kcdZ80o5mfiAyiRNIV5RNRrzEAR32p55Vb04tiwx4E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SnHRPOSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BA6C433F1;
	Mon,  8 Apr 2024 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584430;
	bh=O84oGCFNoWs6zVE35nsOJc26bMeAn8adh7t7EmRZA7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnHRPOSeXpxCKzaeGwl92IOg/j8q8DpLBXOel2MiHYqfKiH3fwC13vQvG9F55Dv1J
	 F0ZxathmzVuLIunPMpl6wT4mHKq8dTqzh/2WBFoRLLy3jLdKU9V9YEF4g/ADkYGYvV
	 UAHs7xPBprM4+aexcfXvd64HAri9D+X32g0pDPJc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dai Ngo <dai.ngo@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 435/690] NFSD: add shrinker to reap courtesy clients on low memory condition
Date: Mon,  8 Apr 2024 14:55:01 +0200
Message-ID: <20240408125415.375686581@linuxfoundation.org>
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

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit 7746b32f467b3813fb61faaab3258de35806a7ac ]

Add courtesy_client_reaper to react to low memory condition triggered
by the system memory shrinker.

The delayed_work for the courtesy_client_reaper is scheduled on
the shrinker's count callback using the laundry_wq.

The shrinker's scan callback is not used for expiring the courtesy
clients due to potential deadlocks.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/netns.h     |  2 +
 fs/nfsd/nfs4state.c | 94 +++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfsctl.c    |  6 ++-
 fs/nfsd/nfsd.h      |  6 ++-
 4 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 55c7006d6109a..8c854ba3285bb 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -194,6 +194,8 @@ struct nfsd_net {
 	int			nfs4_max_clients;
 
 	atomic_t		nfsd_courtesy_clients;
+	struct shrinker		nfsd_client_shrinker;
+	struct delayed_work	nfsd_shrinker_work;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6a7a99511111d..8cbb66b07d519 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4366,7 +4366,27 @@ nfsd4_init_slabs(void)
 	return -ENOMEM;
 }
 
-void nfsd4_init_leases_net(struct nfsd_net *nn)
+static unsigned long
+nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cnt;
+	struct nfsd_net *nn = container_of(shrink,
+			struct nfsd_net, nfsd_client_shrinker);
+
+	cnt = atomic_read(&nn->nfsd_courtesy_clients);
+	if (cnt > 0)
+		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
+	return (unsigned long)cnt;
+}
+
+static unsigned long
+nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	return SHRINK_STOP;
+}
+
+int
+nfsd4_init_leases_net(struct nfsd_net *nn)
 {
 	struct sysinfo si;
 	u64 max_clients;
@@ -4387,6 +4407,16 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
 	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
 
 	atomic_set(&nn->nfsd_courtesy_clients, 0);
+	nn->nfsd_client_shrinker.scan_objects = nfsd_courtesy_client_scan;
+	nn->nfsd_client_shrinker.count_objects = nfsd_courtesy_client_count;
+	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
+	return register_shrinker(&nn->nfsd_client_shrinker);
+}
+
+void
+nfsd4_leases_net_shutdown(struct nfsd_net *nn)
+{
+	unregister_shrinker(&nn->nfsd_client_shrinker);
 }
 
 static void init_nfs4_replay(struct nfs4_replay *rp)
@@ -5959,10 +5989,49 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 	spin_unlock(&nn->client_lock);
 }
 
+static void
+nfs4_get_courtesy_client_reaplist(struct nfsd_net *nn,
+				struct list_head *reaplist)
+{
+	unsigned int maxreap = 0, reapcnt = 0;
+	struct list_head *pos, *next;
+	struct nfs4_client *clp;
+
+	maxreap = NFSD_CLIENT_MAX_TRIM_PER_RUN;
+	INIT_LIST_HEAD(reaplist);
+
+	spin_lock(&nn->client_lock);
+	list_for_each_safe(pos, next, &nn->client_lru) {
+		clp = list_entry(pos, struct nfs4_client, cl_lru);
+		if (clp->cl_state == NFSD4_ACTIVE)
+			break;
+		if (reapcnt >= maxreap)
+			break;
+		if (!mark_client_expired_locked(clp)) {
+			list_add(&clp->cl_lru, reaplist);
+			reapcnt++;
+		}
+	}
+	spin_unlock(&nn->client_lock);
+}
+
+static void
+nfs4_process_client_reaplist(struct list_head *reaplist)
+{
+	struct list_head *pos, *next;
+	struct nfs4_client *clp;
+
+	list_for_each_safe(pos, next, reaplist) {
+		clp = list_entry(pos, struct nfs4_client, cl_lru);
+		trace_nfsd_clid_purged(&clp->cl_clientid);
+		list_del_init(&clp->cl_lru);
+		expire_client(clp);
+	}
+}
+
 static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
-	struct nfs4_client *clp;
 	struct nfs4_openowner *oo;
 	struct nfs4_delegation *dp;
 	struct nfs4_ol_stateid *stp;
@@ -5991,12 +6060,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	}
 	spin_unlock(&nn->s2s_cp_lock);
 	nfs4_get_client_reaplist(nn, &reaplist, &lt);
-	list_for_each_safe(pos, next, &reaplist) {
-		clp = list_entry(pos, struct nfs4_client, cl_lru);
-		trace_nfsd_clid_purged(&clp->cl_clientid);
-		list_del_init(&clp->cl_lru);
-		expire_client(clp);
-	}
+	nfs4_process_client_reaplist(&reaplist);
+
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
@@ -6079,6 +6144,18 @@ laundromat_main(struct work_struct *laundry)
 	queue_delayed_work(laundry_wq, &nn->laundromat_work, t*HZ);
 }
 
+static void
+courtesy_client_reaper(struct work_struct *reaper)
+{
+	struct list_head reaplist;
+	struct delayed_work *dwork = to_delayed_work(reaper);
+	struct nfsd_net *nn = container_of(dwork, struct nfsd_net,
+					nfsd_shrinker_work);
+
+	nfs4_get_courtesy_client_reaplist(nn, &reaplist);
+	nfs4_process_client_reaplist(&reaplist);
+}
+
 static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
 {
 	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
@@ -7897,6 +7974,7 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
 
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
+	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
 	get_net(net);
 
 	return 0;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 917fa1892fd2d..597a26ad4183f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1481,11 +1481,12 @@ static __net_init int nfsd_init_net(struct net *net)
 		goto out_idmap_error;
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
+	retval = nfsd4_init_leases_net(nn);
+	if (retval)
+		goto out_drc_error;
 	retval = nfsd_reply_cache_init(nn);
 	if (retval)
 		goto out_drc_error;
-	nfsd4_init_leases_net(nn);
-
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
 
@@ -1507,6 +1508,7 @@ static __net_exit void nfsd_exit_net(struct net *net)
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
+	nfsd4_leases_net_shutdown(nn);
 }
 
 static struct pernet_operations nfsd_net_ops = {
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 6ab4ad41ae84e..09726c5b9a317 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -505,7 +505,8 @@ extern void unregister_cld_notifier(void);
 extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
 #endif
 
-extern void nfsd4_init_leases_net(struct nfsd_net *nn);
+extern int nfsd4_init_leases_net(struct nfsd_net *nn);
+extern void nfsd4_leases_net_shutdown(struct nfsd_net *nn);
 
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
@@ -513,7 +514,8 @@ static inline int nfsd4_is_junction(struct dentry *dentry)
 	return 0;
 }
 
-static inline void nfsd4_init_leases_net(struct nfsd_net *nn) {};
+static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0; };
+static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) {};
 
 #define register_cld_notifier() 0
 #define unregister_cld_notifier() do { } while(0)
-- 
2.43.0




