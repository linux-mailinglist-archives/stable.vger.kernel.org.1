Return-Path: <stable+bounces-68518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948249532BD
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0C1288274
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72F51B0127;
	Thu, 15 Aug 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S/uyoI6p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969EC19F473;
	Thu, 15 Aug 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730822; cv=none; b=ZWnArhXxAygYNYIH8CR3XrJDfelr61HH2+CCRbMhkGBAH9Mg8MHypibFym+JxQJnk2xU7BefXZACwAZKVOMDng/JzCL9+m8LaffUBgBCFwgQvXjiOSmG+Vo30cD2ZiypmdLekyGV0EUbffKBEY/+IxDlWlhxrGAI8ALOw4nQlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730822; c=relaxed/simple;
	bh=62vi8p6xloFpiHgdUGzhPZ0DreMT8/GawRLqv1/1+So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7rixgJhMUrVwv+5Ebc2Xx8U7EYSd8MzLSR/KzOqbRORqxOSR1LAJN4LgFNZdUps8NI5pBmqZR7sugcmyRNjrgMGmhLhTF8YtmGv5yzdgatp7NrW/BcQcXUzRYy0YeHd/OenrnZ5f54vBKo3iEY7u1C/ZkNQq/Lz0o/M2z7OwRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S/uyoI6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E73C32786;
	Thu, 15 Aug 2024 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730822;
	bh=62vi8p6xloFpiHgdUGzhPZ0DreMT8/GawRLqv1/1+So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/uyoI6pDT0ociPtghYdbrU5x7nhRV3RqCfkNbSYZ8Ja3sqhh5V6ScxqcaNaOEhh0
	 QQJHj75qQ64BbMNzn2vNdWx6ELULZLTe7Lr6Nrq30E5orvyPdIKY97D8Nt+mXDvZ7D
	 9TO2cAAweNWadhc3wqxMkrsDwtLGOsyZDHp0ErlE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Eirik Fuller <efuller@redhat.com>
Subject: [PATCH 6.1 11/38] nfsd: move init of percpu reply_cache_stats counters back to nfsd_init_net
Date: Thu, 15 Aug 2024 15:25:45 +0200
Message-ID: <20240815131833.386760021@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131832.944273699@linuxfoundation.org>
References: <20240815131832.944273699@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit ed9ab7346e908496816cffdecd46932035f66e2e ]

Commit f5f9d4a314da ("nfsd: move reply cache initialization into nfsd
startup") moved the initialization of the reply cache into nfsd startup,
but didn't account for the stats counters, which can be accessed before
nfsd is ever started. The result can be a NULL pointer dereference when
someone accesses /proc/fs/nfsd/reply_cache_stats while nfsd is still
shut down.

This is a regression and a user-triggerable oops in the right situation:

- non-x86_64 arch
- /proc/fs/nfsd is mounted in the namespace
- nfsd is not started in the namespace
- unprivileged user calls "cat /proc/fs/nfsd/reply_cache_stats"

Although this is easy to trigger on some arches (like aarch64), on
x86_64, calling this_cpu_ptr(NULL) evidently returns a pointer to the
fixed_percpu_data. That struct looks just enough like a newly
initialized percpu var to allow nfsd_reply_cache_stats_show to access
it without Oopsing.

Move the initialization of the per-net+per-cpu reply-cache counters
back into nfsd_init_net, while leaving the rest of the reply cache
allocations to be done at nfsd startup time.

Kudos to Eirik who did most of the legwork to track this down.

Cc: stable@vger.kernel.org # v6.3+
Fixes: f5f9d4a314da ("nfsd: move reply cache initialization into nfsd startup")
Reported-and-tested-by: Eirik Fuller <efuller@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2215429
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Stable-dep-of: 4b14885411f7 ("nfsd: make all of the nfsd stats per-network namespace")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/cache.h    |    2 ++
 fs/nfsd/nfscache.c |   25 ++++++++++++++-----------
 fs/nfsd/nfsctl.c   |   10 +++++++++-
 3 files changed, 25 insertions(+), 12 deletions(-)

--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -80,6 +80,8 @@ enum {
 
 int	nfsd_drc_slab_create(void);
 void	nfsd_drc_slab_free(void);
+int	nfsd_net_reply_cache_init(struct nfsd_net *nn);
+void	nfsd_net_reply_cache_destroy(struct nfsd_net *nn);
 int	nfsd_reply_cache_init(struct nfsd_net *);
 void	nfsd_reply_cache_shutdown(struct nfsd_net *);
 int	nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -148,12 +148,23 @@ void nfsd_drc_slab_free(void)
 	kmem_cache_destroy(drc_slab);
 }
 
-static int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
+/**
+ * nfsd_net_reply_cache_init - per net namespace reply cache set-up
+ * @nn: nfsd_net being initialized
+ *
+ * Returns zero on succes; otherwise a negative errno is returned.
+ */
+int nfsd_net_reply_cache_init(struct nfsd_net *nn)
 {
 	return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
 }
 
-static void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
+/**
+ * nfsd_net_reply_cache_destroy - per net namespace reply cache tear-down
+ * @nn: nfsd_net being freed
+ *
+ */
+void nfsd_net_reply_cache_destroy(struct nfsd_net *nn)
 {
 	nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
 }
@@ -169,17 +180,13 @@ int nfsd_reply_cache_init(struct nfsd_ne
 	hashsize = nfsd_hashsize(nn->max_drc_entries);
 	nn->maskbits = ilog2(hashsize);
 
-	status = nfsd_reply_cache_stats_init(nn);
-	if (status)
-		goto out_nomem;
-
 	nn->nfsd_reply_cache_shrinker.scan_objects = nfsd_reply_cache_scan;
 	nn->nfsd_reply_cache_shrinker.count_objects = nfsd_reply_cache_count;
 	nn->nfsd_reply_cache_shrinker.seeks = 1;
 	status = register_shrinker(&nn->nfsd_reply_cache_shrinker,
 				   "nfsd-reply:%s", nn->nfsd_name);
 	if (status)
-		goto out_stats_destroy;
+		return status;
 
 	nn->drc_hashtbl = kvzalloc(array_size(hashsize,
 				sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
@@ -195,9 +202,6 @@ int nfsd_reply_cache_init(struct nfsd_ne
 	return 0;
 out_shrinker:
 	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
-out_stats_destroy:
-	nfsd_reply_cache_stats_destroy(nn);
-out_nomem:
 	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
 	return -ENOMEM;
 }
@@ -217,7 +221,6 @@ void nfsd_reply_cache_shutdown(struct nf
 									rp, nn);
 		}
 	}
-	nfsd_reply_cache_stats_destroy(nn);
 
 	kvfree(nn->drc_hashtbl);
 	nn->drc_hashtbl = NULL;
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1450,6 +1450,9 @@ static __net_init int nfsd_init_net(stru
 	retval = nfsd_idmap_init(net);
 	if (retval)
 		goto out_idmap_error;
+	retval = nfsd_net_reply_cache_init(nn);
+	if (retval)
+		goto out_repcache_error;
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
@@ -1458,6 +1461,8 @@ static __net_init int nfsd_init_net(stru
 
 	return 0;
 
+out_repcache_error:
+	nfsd_idmap_shutdown(net);
 out_idmap_error:
 	nfsd_export_shutdown(net);
 out_export_error:
@@ -1466,9 +1471,12 @@ out_export_error:
 
 static __net_exit void nfsd_exit_net(struct net *net)
 {
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	nfsd_net_reply_cache_destroy(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
-	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
+	nfsd_netns_free_versions(nn);
 }
 
 static struct pernet_operations nfsd_net_ops = {



