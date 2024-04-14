Return-Path: <stable+bounces-37438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A5489C609
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB483B20A7F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603682DF73;
	Mon,  8 Apr 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mOSqFe/R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF517BAFF;
	Mon,  8 Apr 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584233; cv=none; b=aROndRE7uQfd7IRJNYWR/aostzXkOFmWrA/eKkMrASPSia86vBqXrRLpJ7Gh5iwb0HRypYleR8UaFnCz1giiaHXeh5XHawmFN+cpn8WB7H9obtpTelAkjJhsL5VOvAE69FJu8+ul4ZfFi57+6ZnnkHjgD2Gpy4EXqM79tOIU3is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584233; c=relaxed/simple;
	bh=dINWdPh8nhdKTeQ1Cg7fXGXPdpbuNA0BelUQGwQNkeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xxa2QU5+BHWUSJHhqntjn0DayW1ZBw9VA7g18/TEDB+cnUj07IykYQ+iZbQ9CLHlws2ykpmjZaCY4TjSB9J1yzLTzA55BGpSgfx65nIFDVTa0bkOluBEUftbG+ngn4kvv23034hQYZiOWS9xMSBD34Z2bQd5u7WyaAsUwznerk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mOSqFe/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7EBC433F1;
	Mon,  8 Apr 2024 13:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584233;
	bh=dINWdPh8nhdKTeQ1Cg7fXGXPdpbuNA0BelUQGwQNkeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mOSqFe/RMUUbUdCfv4vsG2KSgngsAQKrNWuF6I0W5mn9w+s0TrWKxsR3dlJb23FeG
	 ih15qhUoKIbPMypwB/LP8dISsAWM+SGOZNQyOCVFHWJnImelov4LuGQPHoyPepBF4U
	 L97D0+HcYBdq0dBDQy67vjN3F0a4RQlg7IyzNJa0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 368/690] NFSD: Replace the "init once" mechanism
Date: Mon,  8 Apr 2024 14:53:54 +0200
Message-ID: <20240408125412.902299083@linuxfoundation.org>
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

[ Upstream commit c7b824c3d06c85e054caf86e227255112c5e3c38 ]

In a moment, the nfsd_file_hashtbl global will be replaced with an
rhashtable. Replace the one or two spots that need to check if the
hash table is available. We can easily reuse the SHUTDOWN flag for
this purpose.

Document that this mechanism relies on callers to hold the
nfsd_mutex to prevent init, shutdown, and purging to run
concurrently.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 29b1f57692a60..33bb4d31b4972 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -27,7 +27,7 @@
 #define NFSD_FILE_HASH_SIZE                  (1 << NFSD_FILE_HASH_BITS)
 #define NFSD_LAUNDRETTE_DELAY		     (2 * HZ)
 
-#define NFSD_FILE_SHUTDOWN		     (1)
+#define NFSD_FILE_CACHE_UP		     (0)
 
 /* We only care about NFSD_MAY_READ/WRITE for this cache */
 #define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
@@ -58,7 +58,7 @@ static struct kmem_cache		*nfsd_file_slab;
 static struct kmem_cache		*nfsd_file_mark_slab;
 static struct nfsd_fcache_bucket	*nfsd_file_hashtbl;
 static struct list_lru			nfsd_file_lru;
-static long				nfsd_file_lru_flags;
+static unsigned long			nfsd_file_flags;
 static struct fsnotify_group		*nfsd_file_fsnotify_group;
 static atomic_long_t			nfsd_filecache_count;
 static struct delayed_work		nfsd_filecache_laundrette;
@@ -66,9 +66,8 @@ static struct delayed_work		nfsd_filecache_laundrette;
 static void
 nfsd_file_schedule_laundrette(void)
 {
-	long count = atomic_long_read(&nfsd_filecache_count);
-
-	if (count == 0 || test_bit(NFSD_FILE_SHUTDOWN, &nfsd_file_lru_flags))
+	if ((atomic_long_read(&nfsd_filecache_count) == 0) ||
+	    test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 0)
 		return;
 
 	queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
@@ -697,9 +696,8 @@ nfsd_file_cache_init(void)
 	int		ret = -ENOMEM;
 	unsigned int	i;
 
-	clear_bit(NFSD_FILE_SHUTDOWN, &nfsd_file_lru_flags);
-
-	if (nfsd_file_hashtbl)
+	lockdep_assert_held(&nfsd_mutex);
+	if (test_and_set_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1)
 		return 0;
 
 	nfsd_filecache_wq = alloc_workqueue("nfsd_filecache", 0, 0);
@@ -785,8 +783,8 @@ nfsd_file_cache_init(void)
 /*
  * Note this can deadlock with nfsd_file_lru_cb.
  */
-void
-nfsd_file_cache_purge(struct net *net)
+static void
+__nfsd_file_cache_purge(struct net *net)
 {
 	unsigned int		i;
 	struct nfsd_file	*nf;
@@ -794,9 +792,6 @@ nfsd_file_cache_purge(struct net *net)
 	LIST_HEAD(dispose);
 	bool del;
 
-	if (!nfsd_file_hashtbl)
-		return;
-
 	for (i = 0; i < NFSD_FILE_HASH_SIZE; i++) {
 		struct nfsd_fcache_bucket *nfb = &nfsd_file_hashtbl[i];
 
@@ -857,6 +852,19 @@ nfsd_file_cache_start_net(struct net *net)
 	return nn->fcache_disposal ? 0 : -ENOMEM;
 }
 
+/**
+ * nfsd_file_cache_purge - Remove all cache items associated with @net
+ * @net: target net namespace
+ *
+ */
+void
+nfsd_file_cache_purge(struct net *net)
+{
+	lockdep_assert_held(&nfsd_mutex);
+	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1)
+		__nfsd_file_cache_purge(net);
+}
+
 void
 nfsd_file_cache_shutdown_net(struct net *net)
 {
@@ -869,7 +877,9 @@ nfsd_file_cache_shutdown(void)
 {
 	int i;
 
-	set_bit(NFSD_FILE_SHUTDOWN, &nfsd_file_lru_flags);
+	lockdep_assert_held(&nfsd_mutex);
+	if (test_and_clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 0)
+		return;
 
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
 	unregister_shrinker(&nfsd_file_shrinker);
@@ -878,7 +888,7 @@ nfsd_file_cache_shutdown(void)
 	 * calling nfsd_file_cache_purge
 	 */
 	cancel_delayed_work_sync(&nfsd_filecache_laundrette);
-	nfsd_file_cache_purge(NULL);
+	__nfsd_file_cache_purge(NULL);
 	list_lru_destroy(&nfsd_file_lru);
 	rcu_barrier();
 	fsnotify_put_group(nfsd_file_fsnotify_group);
@@ -1142,7 +1152,7 @@ static int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 	 * don't end up racing with server shutdown
 	 */
 	mutex_lock(&nfsd_mutex);
-	if (nfsd_file_hashtbl) {
+	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1) {
 		for (i = 0; i < NFSD_FILE_HASH_SIZE; i++) {
 			count += nfsd_file_hashtbl[i].nfb_count;
 			longest = max(longest, nfsd_file_hashtbl[i].nfb_count);
-- 
2.43.0




