Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DCC6F9ADD
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 20:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjEGSWE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 14:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjEGSWD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 14:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1442D65
        for <stable@vger.kernel.org>; Sun,  7 May 2023 11:22:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD8561B7D
        for <stable@vger.kernel.org>; Sun,  7 May 2023 18:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D63C433D2;
        Sun,  7 May 2023 18:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683483720;
        bh=a6qXS37VJnXluBTADT7ZksWl4i2v0wEwIdoOO/svZl0=;
        h=Subject:To:Cc:From:Date:From;
        b=0tcaHXFuM01jZs9xWts+gTPTRDPcO5rcKU1vnACM+kFxShzZWmSbluN1lLy/6/htM
         +M9gwdiUPN0XOxwIwpJ9O1Q7P6t/dNBc9Wdrb6X4NFtL1Gv5LW8BuvNZYR8o+d/iDo
         o89nIpo6f2Hvunix5jFjciMpv4EF4ykSpdbh/qcc=
Subject: FAILED: patch "[PATCH] cifs: avoid potential races when handling multiple dfs tcons" failed to apply to 6.2-stable tree
To:     pc@manguebit.com, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 20:21:57 +0200
Message-ID: <2023050757-banked-expulsion-d269@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.2.y
git checkout FETCH_HEAD
git cherry-pick -x 6be2ea33a4093402252724a00c4af8033725184c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050757-banked-expulsion-d269@gregkh' --subject-prefix 'PATCH 6.2.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6be2ea33a4093402252724a00c4af8033725184c Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Thu, 27 Apr 2023 04:40:08 -0300
Subject: [PATCH] cifs: avoid potential races when handling multiple dfs tcons

Now that a DFS tcon manages its own list of DFS referrals and
sessions, there is no point in having a single worker to refresh
referrals of all DFS tcons.  Make it faster and less prone to race
conditions when having several mounts by queueing a worker per DFS
tcon that will take care of refreshing only the DFS referrals related
to it.

Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index a62447404851..9c5cd332ce14 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1238,8 +1238,8 @@ struct cifs_tcon {
 	struct cached_fids *cfids;
 	/* BB add field for back pointer to sb struct(s)? */
 #ifdef CONFIG_CIFS_DFS_UPCALL
-	struct list_head ulist; /* cache update list */
 	struct list_head dfs_ses_list;
+	struct delayed_work dfs_cache_work;
 #endif
 	struct delayed_work	query_interfaces; /* query interfaces workqueue job */
 };
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 9451b1023af8..9a730efbce32 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2340,6 +2340,9 @@ cifs_put_tcon(struct cifs_tcon *tcon)
 
 	/* cancel polling of interfaces */
 	cancel_delayed_work_sync(&tcon->query_interfaces);
+#ifdef CONFIG_CIFS_DFS_UPCALL
+	cancel_delayed_work_sync(&tcon->dfs_cache_work);
+#endif
 
 	if (tcon->use_witness) {
 		int rc;
@@ -2587,7 +2590,9 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 		queue_delayed_work(cifsiod_wq, &tcon->query_interfaces,
 				   (SMB_INTERFACE_POLL_INTERVAL * HZ));
 	}
-
+#ifdef CONFIG_CIFS_DFS_UPCALL
+	INIT_DELAYED_WORK(&tcon->dfs_cache_work, dfs_cache_refresh);
+#endif
 	spin_lock(&cifs_tcp_ses_lock);
 	list_add(&tcon->tcon_list, &ses->tcon_list);
 	spin_unlock(&cifs_tcp_ses_lock);
diff --git a/fs/cifs/dfs.c b/fs/cifs/dfs.c
index c4ec5c67087b..da4e083b1ab4 100644
--- a/fs/cifs/dfs.c
+++ b/fs/cifs/dfs.c
@@ -157,6 +157,8 @@ static int get_dfs_conn(struct cifs_mount_ctx *mnt_ctx, const char *ref_path, co
 		rc = cifs_is_path_remote(mnt_ctx);
 	}
 
+	dfs_cache_noreq_update_tgthint(ref_path + 1, tit);
+
 	if (rc == -EREMOTE && is_refsrv) {
 		rc2 = get_root_smb_session(mnt_ctx);
 		if (rc2)
@@ -259,6 +261,8 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 		if (list_empty(&tcon->dfs_ses_list)) {
 			list_replace_init(&mnt_ctx->dfs_ses_list,
 					  &tcon->dfs_ses_list);
+			queue_delayed_work(dfscache_wq, &tcon->dfs_cache_work,
+					   dfs_cache_get_ttl() * HZ);
 		} else {
 			dfs_put_root_smb_sessions(&mnt_ctx->dfs_ses_list);
 		}
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 6557d7b2798a..1513b2709889 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -20,12 +20,14 @@
 #include "cifs_unicode.h"
 #include "smb2glob.h"
 #include "dns_resolve.h"
+#include "dfs.h"
 
 #include "dfs_cache.h"
 
-#define CACHE_HTABLE_SIZE 32
-#define CACHE_MAX_ENTRIES 64
-#define CACHE_MIN_TTL 120 /* 2 minutes */
+#define CACHE_HTABLE_SIZE	32
+#define CACHE_MAX_ENTRIES	64
+#define CACHE_MIN_TTL		120 /* 2 minutes */
+#define CACHE_DEFAULT_TTL	300 /* 5 minutes */
 
 #define IS_DFS_INTERLINK(v) (((v) & DFSREF_REFERRAL_SERVER) && !((v) & DFSREF_STORAGE_SERVER))
 
@@ -50,10 +52,9 @@ struct cache_entry {
 };
 
 static struct kmem_cache *cache_slab __read_mostly;
-static struct workqueue_struct *dfscache_wq __read_mostly;
+struct workqueue_struct *dfscache_wq;
 
-static int cache_ttl;
-static DEFINE_SPINLOCK(cache_ttl_lock);
+atomic_t dfs_cache_ttl;
 
 static struct nls_table *cache_cp;
 
@@ -65,10 +66,6 @@ static atomic_t cache_count;
 static struct hlist_head cache_htable[CACHE_HTABLE_SIZE];
 static DECLARE_RWSEM(htable_rw_lock);
 
-static void refresh_cache_worker(struct work_struct *work);
-
-static DECLARE_DELAYED_WORK(refresh_task, refresh_cache_worker);
-
 /**
  * dfs_cache_canonical_path - get a canonical DFS path
  *
@@ -290,7 +287,9 @@ int dfs_cache_init(void)
 	int rc;
 	int i;
 
-	dfscache_wq = alloc_workqueue("cifs-dfscache", WQ_FREEZABLE | WQ_UNBOUND, 1);
+	dfscache_wq = alloc_workqueue("cifs-dfscache",
+				      WQ_UNBOUND|WQ_FREEZABLE|WQ_MEM_RECLAIM,
+				      0);
 	if (!dfscache_wq)
 		return -ENOMEM;
 
@@ -306,6 +305,7 @@ int dfs_cache_init(void)
 		INIT_HLIST_HEAD(&cache_htable[i]);
 
 	atomic_set(&cache_count, 0);
+	atomic_set(&dfs_cache_ttl, CACHE_DEFAULT_TTL);
 	cache_cp = load_nls("utf8");
 	if (!cache_cp)
 		cache_cp = load_nls_default();
@@ -480,6 +480,7 @@ static struct cache_entry *add_cache_entry_locked(struct dfs_info3_param *refs,
 	int rc;
 	struct cache_entry *ce;
 	unsigned int hash;
+	int ttl;
 
 	WARN_ON(!rwsem_is_locked(&htable_rw_lock));
 
@@ -496,15 +497,8 @@ static struct cache_entry *add_cache_entry_locked(struct dfs_info3_param *refs,
 	if (IS_ERR(ce))
 		return ce;
 
-	spin_lock(&cache_ttl_lock);
-	if (!cache_ttl) {
-		cache_ttl = ce->ttl;
-		queue_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
-	} else {
-		cache_ttl = min_t(int, cache_ttl, ce->ttl);
-		mod_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
-	}
-	spin_unlock(&cache_ttl_lock);
+	ttl = min_t(int, atomic_read(&dfs_cache_ttl), ce->ttl);
+	atomic_set(&dfs_cache_ttl, ttl);
 
 	hlist_add_head(&ce->hlist, &cache_htable[hash]);
 	dump_ce(ce);
@@ -616,7 +610,6 @@ static struct cache_entry *lookup_cache_entry(const char *path)
  */
 void dfs_cache_destroy(void)
 {
-	cancel_delayed_work_sync(&refresh_task);
 	unload_nls(cache_cp);
 	flush_cache_ents();
 	kmem_cache_destroy(cache_slab);
@@ -1142,6 +1135,7 @@ static bool target_share_equal(struct TCP_Server_Info *server, const char *s1, c
  * target shares in @refs.
  */
 static void mark_for_reconnect_if_needed(struct TCP_Server_Info *server,
+					 const char *path,
 					 struct dfs_cache_tgt_list *old_tl,
 					 struct dfs_cache_tgt_list *new_tl)
 {
@@ -1153,8 +1147,10 @@ static void mark_for_reconnect_if_needed(struct TCP_Server_Info *server,
 		     nit = dfs_cache_get_next_tgt(new_tl, nit)) {
 			if (target_share_equal(server,
 					       dfs_cache_get_tgt_name(oit),
-					       dfs_cache_get_tgt_name(nit)))
+					       dfs_cache_get_tgt_name(nit))) {
+				dfs_cache_noreq_update_tgthint(path, nit);
 				return;
+			}
 		}
 	}
 
@@ -1162,13 +1158,28 @@ static void mark_for_reconnect_if_needed(struct TCP_Server_Info *server,
 	cifs_signal_cifsd_for_reconnect(server, true);
 }
 
+static bool is_ses_good(struct cifs_ses *ses)
+{
+	struct TCP_Server_Info *server = ses->server;
+	struct cifs_tcon *tcon = ses->tcon_ipc;
+	bool ret;
+
+	spin_lock(&ses->ses_lock);
+	spin_lock(&ses->chan_lock);
+	ret = !cifs_chan_needs_reconnect(ses, server) &&
+		ses->ses_status == SES_GOOD &&
+		!tcon->need_reconnect;
+	spin_unlock(&ses->chan_lock);
+	spin_unlock(&ses->ses_lock);
+	return ret;
+}
+
 /* Refresh dfs referral of tcon and mark it for reconnect if needed */
-static int __refresh_tcon(const char *path, struct cifs_tcon *tcon, bool force_refresh)
+static int __refresh_tcon(const char *path, struct cifs_ses *ses, bool force_refresh)
 {
 	struct dfs_cache_tgt_list old_tl = DFS_CACHE_TGT_LIST_INIT(old_tl);
 	struct dfs_cache_tgt_list new_tl = DFS_CACHE_TGT_LIST_INIT(new_tl);
-	struct cifs_ses *ses = CIFS_DFS_ROOT_SES(tcon->ses);
-	struct cifs_tcon *ipc = ses->tcon_ipc;
+	struct TCP_Server_Info *server = ses->server;
 	bool needs_refresh = false;
 	struct cache_entry *ce;
 	unsigned int xid;
@@ -1190,20 +1201,19 @@ static int __refresh_tcon(const char *path, struct cifs_tcon *tcon, bool force_r
 		goto out;
 	}
 
-	spin_lock(&ipc->tc_lock);
-	if (ipc->status != TID_GOOD) {
-		spin_unlock(&ipc->tc_lock);
-		cifs_dbg(FYI, "%s: skip cache refresh due to disconnected ipc\n", __func__);
+	ses = CIFS_DFS_ROOT_SES(ses);
+	if (!is_ses_good(ses)) {
+		cifs_dbg(FYI, "%s: skip cache refresh due to disconnected ipc\n",
+			 __func__);
 		goto out;
 	}
-	spin_unlock(&ipc->tc_lock);
 
 	ce = cache_refresh_path(xid, ses, path, true);
 	if (!IS_ERR(ce)) {
 		rc = get_targets(ce, &new_tl);
 		up_read(&htable_rw_lock);
 		cifs_dbg(FYI, "%s: get_targets: %d\n", __func__, rc);
-		mark_for_reconnect_if_needed(tcon->ses->server, &old_tl, &new_tl);
+		mark_for_reconnect_if_needed(server, path, &old_tl, &new_tl);
 	}
 
 out:
@@ -1216,10 +1226,11 @@ out:
 static int refresh_tcon(struct cifs_tcon *tcon, bool force_refresh)
 {
 	struct TCP_Server_Info *server = tcon->ses->server;
+	struct cifs_ses *ses = tcon->ses;
 
 	mutex_lock(&server->refpath_lock);
 	if (server->leaf_fullpath)
-		__refresh_tcon(server->leaf_fullpath + 1, tcon, force_refresh);
+		__refresh_tcon(server->leaf_fullpath + 1, ses, force_refresh);
 	mutex_unlock(&server->refpath_lock);
 	return 0;
 }
@@ -1263,60 +1274,32 @@ int dfs_cache_remount_fs(struct cifs_sb_info *cifs_sb)
 	return refresh_tcon(tcon, true);
 }
 
-/*
- * Worker that will refresh DFS cache from all active mounts based on lowest TTL value
- * from a DFS referral.
- */
-static void refresh_cache_worker(struct work_struct *work)
+/* Refresh all DFS referrals related to DFS tcon */
+void dfs_cache_refresh(struct work_struct *work)
 {
 	struct TCP_Server_Info *server;
-	struct cifs_tcon *tcon, *ntcon;
-	struct list_head tcons;
+	struct dfs_root_ses *rses;
+	struct cifs_tcon *tcon;
 	struct cifs_ses *ses;
 
-	INIT_LIST_HEAD(&tcons);
+	tcon = container_of(work, struct cifs_tcon, dfs_cache_work.work);
+	ses = tcon->ses;
+	server = ses->server;
 
-	spin_lock(&cifs_tcp_ses_lock);
-	list_for_each_entry(server, &cifs_tcp_ses_list, tcp_ses_list) {
-		spin_lock(&server->srv_lock);
-		if (!server->leaf_fullpath) {
-			spin_unlock(&server->srv_lock);
-			continue;
-		}
-		spin_unlock(&server->srv_lock);
-
-		list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
-			if (ses->tcon_ipc) {
-				ses->ses_count++;
-				list_add_tail(&ses->tcon_ipc->ulist, &tcons);
-			}
-			list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
-				if (!tcon->ipc) {
-					tcon->tc_count++;
-					list_add_tail(&tcon->ulist, &tcons);
-				}
-			}
-		}
-	}
-	spin_unlock(&cifs_tcp_ses_lock);
-
-	list_for_each_entry_safe(tcon, ntcon, &tcons, ulist) {
-		struct TCP_Server_Info *server = tcon->ses->server;
-
-		list_del_init(&tcon->ulist);
+	mutex_lock(&server->refpath_lock);
+	if (server->leaf_fullpath)
+		__refresh_tcon(server->leaf_fullpath + 1, ses, false);
+	mutex_unlock(&server->refpath_lock);
 
+	list_for_each_entry(rses, &tcon->dfs_ses_list, list) {
+		ses = rses->ses;
+		server = ses->server;
 		mutex_lock(&server->refpath_lock);
 		if (server->leaf_fullpath)
-			__refresh_tcon(server->leaf_fullpath + 1, tcon, false);
+			__refresh_tcon(server->leaf_fullpath + 1, ses, false);
 		mutex_unlock(&server->refpath_lock);
-
-		if (tcon->ipc)
-			cifs_put_smb_ses(tcon->ses);
-		else
-			cifs_put_tcon(tcon);
 	}
 
-	spin_lock(&cache_ttl_lock);
-	queue_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
-	spin_unlock(&cache_ttl_lock);
+	queue_delayed_work(dfscache_wq, &tcon->dfs_cache_work,
+			   atomic_read(&dfs_cache_ttl) * HZ);
 }
diff --git a/fs/cifs/dfs_cache.h b/fs/cifs/dfs_cache.h
index e0d39393035a..c6d89cd6d4fd 100644
--- a/fs/cifs/dfs_cache.h
+++ b/fs/cifs/dfs_cache.h
@@ -13,6 +13,9 @@
 #include <linux/uuid.h>
 #include "cifsglob.h"
 
+extern struct workqueue_struct *dfscache_wq;
+extern atomic_t dfs_cache_ttl;
+
 #define DFS_CACHE_TGT_LIST_INIT(var) { .tl_numtgts = 0, .tl_list = LIST_HEAD_INIT((var).tl_list), }
 
 struct dfs_cache_tgt_list {
@@ -42,6 +45,7 @@ int dfs_cache_get_tgt_share(char *path, const struct dfs_cache_tgt_iterator *it,
 			    char **prefix);
 char *dfs_cache_canonical_path(const char *path, const struct nls_table *cp, int remap);
 int dfs_cache_remount_fs(struct cifs_sb_info *cifs_sb);
+void dfs_cache_refresh(struct work_struct *work);
 
 static inline struct dfs_cache_tgt_iterator *
 dfs_cache_get_next_tgt(struct dfs_cache_tgt_list *tl,
@@ -89,4 +93,9 @@ dfs_cache_get_nr_tgts(const struct dfs_cache_tgt_list *tl)
 	return tl ? tl->tl_numtgts : 0;
 }
 
+static inline int dfs_cache_get_ttl(void)
+{
+	return atomic_read(&dfs_cache_ttl);
+}
+
 #endif /* _CIFS_DFS_CACHE_H */

