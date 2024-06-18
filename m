Return-Path: <stable+bounces-53036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD90790D0B1
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D783B23EBA
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD171662F3;
	Tue, 18 Jun 2024 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Quyd1XQ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391215216F;
	Tue, 18 Jun 2024 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715138; cv=none; b=YziJp8IxFnFE3dmNqubT89f8SwUF43TcMUq3wn2rwmFFimdr/6YFGLKgB1sVgy6HPjhtHa8Tyh9GrI6V3tTyeedWKdRO4vBSBMaVp4BWxxq7Z0SvCHLDscM9myenPzkLxtSEHvDObfHmY047UcBolSFHEQTKU8HdFphv2JjY8mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715138; c=relaxed/simple;
	bh=4Cgo3K6ly/+bb6MDe0pZ5byI7I2n9IRk2IJ5QLGNi8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHbz5U63TYo6O/lBaTDsXpgwuwyw7DqiQCAMPofl+SN/uVhTrPaKIa9Bd+JyrnxpxgIGd76xMna/Qn/wgG5vCr8sRITMy0EuoUALjnUXqLt9Xv4onXJypGINw6jJYuURbH9rvBDD8PSmXejkPWSUPJW1MTOY96qql5xdwHj/xQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Quyd1XQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5676C3277B;
	Tue, 18 Jun 2024 12:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715138;
	bh=4Cgo3K6ly/+bb6MDe0pZ5byI7I2n9IRk2IJ5QLGNi8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Quyd1XQ7rL0o+sWB38HwyvFpb6PmlMZkyvNDgCfodwOUWXLiWzdkHTHHk3jpWdZg5
	 9MeCuqVMht7NTn76gXDIHmin3j7YnNN/h26lO+mYFL+uEMYzSMbeP6JiZV2XRDd5Hb
	 GCI1kFWg4gowj2V5c8G1Gg+xP+Za40xaDWZT5nb0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 176/770] nfsd: protect concurrent access to nfsd stats counters
Date: Tue, 18 Jun 2024 14:30:29 +0200
Message-ID: <20240618123414.064519508@linuxfoundation.org>
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

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit e567b98ce9a4b35b63c364d24828a9e5cd7a8179 ]

nfsd stats counters can be updated by concurrent nfsd threads without any
protection.

Convert some nfsd_stats and nfsd_net struct members to use percpu counters.

The longest_chain* members of struct nfsd_net remain unprotected.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/netns.h    | 23 +++++++------
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfscache.c | 52 +++++++++++++++++++++---------
 fs/nfsd/nfsctl.c   |  5 ++-
 fs/nfsd/nfsfh.c    |  2 +-
 fs/nfsd/stats.c    | 77 ++++++++++++++++++++++++++++++++++++--------
 fs/nfsd/stats.h    | 80 +++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/vfs.c      |  4 +--
 8 files changed, 192 insertions(+), 53 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 02d3d2f0e6168..a75abeb1e6988 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -10,6 +10,7 @@
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <linux/percpu_counter.h>
 
 /* Hash tables for nfs4_clientid state */
 #define CLIENT_HASH_BITS                 4
@@ -21,6 +22,14 @@
 struct cld_net;
 struct nfsd4_client_tracking_ops;
 
+enum {
+	/* cache misses due only to checksum comparison failures */
+	NFSD_NET_PAYLOAD_MISSES,
+	/* amount of memory (in bytes) currently consumed by the DRC */
+	NFSD_NET_DRC_MEM_USAGE,
+	NFSD_NET_COUNTERS_NUM
+};
+
 /*
  * Represents a nfsd "container". With respect to nfsv4 state tracking, the
  * fields of interest are the *_id_hashtbls and the *_name_tree. These track
@@ -149,20 +158,16 @@ struct nfsd_net {
 
 	/*
 	 * Stats and other tracking of on the duplicate reply cache.
-	 * These fields and the "rc" fields in nfsdstats are modified
-	 * with only the per-bucket cache lock, which isn't really safe
-	 * and should be fixed if we want the statistics to be
-	 * completely accurate.
+	 * The longest_chain* fields are modified with only the per-bucket
+	 * cache lock, which isn't really safe and should be fixed if we want
+	 * these statistics to be completely accurate.
 	 */
 
 	/* total number of entries */
 	atomic_t                 num_drc_entries;
 
-	/* cache misses due only to checksum comparison failures */
-	unsigned int             payload_misses;
-
-	/* amount of memory (in bytes) currently consumed by the DRC */
-	unsigned int             drc_mem_usage;
+	/* Per-netns stats counters */
+	struct percpu_counter    counter[NFSD_NET_COUNTERS_NUM];
 
 	/* longest hash chain seen */
 	unsigned int             longest_chain;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a5e1f5c1a4d64..4f64d94909ec1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2168,7 +2168,7 @@ nfsd4_proc_null(struct svc_rqst *rqstp)
 static inline void nfsd4_increment_op_stats(u32 opnum)
 {
 	if (opnum >= FIRST_NFS4_OP && opnum <= LAST_NFS4_OP)
-		nfsdstats.nfs4_opcount[opnum]++;
+		percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_NFS4_OP(opnum)]);
 }
 
 static const struct nfsd4_operation nfsd4_ops[];
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 80c90fc231a53..96cdf77925f33 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -121,14 +121,14 @@ nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
 				struct nfsd_net *nn)
 {
 	if (rp->c_type == RC_REPLBUFF && rp->c_replvec.iov_base) {
-		nn->drc_mem_usage -= rp->c_replvec.iov_len;
+		nfsd_stats_drc_mem_usage_sub(nn, rp->c_replvec.iov_len);
 		kfree(rp->c_replvec.iov_base);
 	}
 	if (rp->c_state != RC_UNUSED) {
 		rb_erase(&rp->c_node, &b->rb_head);
 		list_del(&rp->c_lru);
 		atomic_dec(&nn->num_drc_entries);
-		nn->drc_mem_usage -= sizeof(*rp);
+		nfsd_stats_drc_mem_usage_sub(nn, sizeof(*rp));
 	}
 	kmem_cache_free(drc_slab, rp);
 }
@@ -154,6 +154,16 @@ void nfsd_drc_slab_free(void)
 	kmem_cache_destroy(drc_slab);
 }
 
+static int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
+{
+	return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
+}
+
+static void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
+{
+	nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
+}
+
 int nfsd_reply_cache_init(struct nfsd_net *nn)
 {
 	unsigned int hashsize;
@@ -165,12 +175,16 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	hashsize = nfsd_hashsize(nn->max_drc_entries);
 	nn->maskbits = ilog2(hashsize);
 
+	status = nfsd_reply_cache_stats_init(nn);
+	if (status)
+		goto out_nomem;
+
 	nn->nfsd_reply_cache_shrinker.scan_objects = nfsd_reply_cache_scan;
 	nn->nfsd_reply_cache_shrinker.count_objects = nfsd_reply_cache_count;
 	nn->nfsd_reply_cache_shrinker.seeks = 1;
 	status = register_shrinker(&nn->nfsd_reply_cache_shrinker);
 	if (status)
-		goto out_nomem;
+		goto out_stats_destroy;
 
 	nn->drc_hashtbl = kvzalloc(array_size(hashsize,
 				sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
@@ -186,6 +200,8 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	return 0;
 out_shrinker:
 	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
+out_stats_destroy:
+	nfsd_reply_cache_stats_destroy(nn);
 out_nomem:
 	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
 	return -ENOMEM;
@@ -196,6 +212,7 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 	struct svc_cacherep	*rp;
 	unsigned int i;
 
+	nfsd_reply_cache_stats_destroy(nn);
 	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
 
 	for (i = 0; i < nn->drc_hashsize; i++) {
@@ -324,7 +341,7 @@ nfsd_cache_key_cmp(const struct svc_cacherep *key,
 {
 	if (key->c_key.k_xid == rp->c_key.k_xid &&
 	    key->c_key.k_csum != rp->c_key.k_csum) {
-		++nn->payload_misses;
+		nfsd_stats_payload_misses_inc(nn);
 		trace_nfsd_drc_mismatch(nn, key, rp);
 	}
 
@@ -407,7 +424,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 
 	rqstp->rq_cacherep = NULL;
 	if (type == RC_NOCACHE) {
-		nfsdstats.rcnocache++;
+		nfsd_stats_rc_nocache_inc();
 		goto out;
 	}
 
@@ -429,12 +446,12 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 		goto found_entry;
 	}
 
-	nfsdstats.rcmisses++;
+	nfsd_stats_rc_misses_inc();
 	rqstp->rq_cacherep = rp;
 	rp->c_state = RC_INPROG;
 
 	atomic_inc(&nn->num_drc_entries);
-	nn->drc_mem_usage += sizeof(*rp);
+	nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
 
 	/* go ahead and prune the cache */
 	prune_bucket(b, nn);
@@ -446,7 +463,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 
 found_entry:
 	/* We found a matching entry which is either in progress or done. */
-	nfsdstats.rchits++;
+	nfsd_stats_rc_hits_inc();
 	rtn = RC_DROPIT;
 
 	/* Request being processed */
@@ -548,7 +565,7 @@ void nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, __be32 *statp)
 		return;
 	}
 	spin_lock(&b->cache_lock);
-	nn->drc_mem_usage += bufsize;
+	nfsd_stats_drc_mem_usage_add(nn, bufsize);
 	lru_put_end(b, rp);
 	rp->c_secure = test_bit(RQ_SECURE, &rqstp->rq_flags);
 	rp->c_type = cachetype;
@@ -588,13 +605,18 @@ static int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
 
 	seq_printf(m, "max entries:           %u\n", nn->max_drc_entries);
 	seq_printf(m, "num entries:           %u\n",
-			atomic_read(&nn->num_drc_entries));
+		   atomic_read(&nn->num_drc_entries));
 	seq_printf(m, "hash buckets:          %u\n", 1 << nn->maskbits);
-	seq_printf(m, "mem usage:             %u\n", nn->drc_mem_usage);
-	seq_printf(m, "cache hits:            %u\n", nfsdstats.rchits);
-	seq_printf(m, "cache misses:          %u\n", nfsdstats.rcmisses);
-	seq_printf(m, "not cached:            %u\n", nfsdstats.rcnocache);
-	seq_printf(m, "payload misses:        %u\n", nn->payload_misses);
+	seq_printf(m, "mem usage:             %lld\n",
+		   percpu_counter_sum_positive(&nn->counter[NFSD_NET_DRC_MEM_USAGE]));
+	seq_printf(m, "cache hits:            %lld\n",
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_HITS]));
+	seq_printf(m, "cache misses:          %lld\n",
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_MISSES]));
+	seq_printf(m, "not cached:            %lld\n",
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]));
+	seq_printf(m, "payload misses:        %lld\n",
+		   percpu_counter_sum_positive(&nn->counter[NFSD_NET_PAYLOAD_MISSES]));
 	seq_printf(m, "longest chain len:     %u\n", nn->longest_chain);
 	seq_printf(m, "cachesize at longest:  %u\n", nn->longest_chain_cachesize);
 	return 0;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index c4b11560ac1b6..7f85c171f83aa 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1522,7 +1522,9 @@ static int __init init_nfsd(void)
 	retval = nfsd4_init_pnfs();
 	if (retval)
 		goto out_free_slabs;
-	nfsd_stat_init();	/* Statistics */
+	retval = nfsd_stat_init();	/* Statistics */
+	if (retval)
+		goto out_free_pnfs;
 	retval = nfsd_drc_slab_create();
 	if (retval)
 		goto out_free_stat;
@@ -1552,6 +1554,7 @@ static int __init init_nfsd(void)
 	nfsd_drc_slab_free();
 out_free_stat:
 	nfsd_stat_shutdown();
+out_free_pnfs:
 	nfsd4_exit_pnfs();
 out_free_slabs:
 	nfsd4_free_slabs();
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 66f2ef67792a7..9e31b2b5c6d26 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -422,7 +422,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	}
 out:
 	if (error == nfserr_stale)
-		nfsdstats.fh_stale++;
+		nfsd_stats_fh_stale_inc();
 	return error;
 }
 
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index e928e224205ac..1d3b881e73821 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -36,13 +36,13 @@ static int nfsd_proc_show(struct seq_file *seq, void *v)
 {
 	int i;
 
-	seq_printf(seq, "rc %u %u %u\nfh %u 0 0 0 0\nio %u %u\n",
-		      nfsdstats.rchits,
-		      nfsdstats.rcmisses,
-		      nfsdstats.rcnocache,
-		      nfsdstats.fh_stale,
-		      nfsdstats.io_read,
-		      nfsdstats.io_write);
+	seq_printf(seq, "rc %lld %lld %lld\nfh %lld 0 0 0 0\nio %lld %lld\n",
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_HITS]),
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_MISSES]),
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]),
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_FH_STALE]),
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_IO_READ]),
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_IO_WRITE]));
 
 	/* thread usage: */
 	seq_printf(seq, "th %u 0", nfsdstats.th_cnt);
@@ -61,8 +61,10 @@ static int nfsd_proc_show(struct seq_file *seq, void *v)
 	/* Show count for individual nfsv4 operations */
 	/* Writing operation numbers 0 1 2 also for maintaining uniformity */
 	seq_printf(seq,"proc4ops %u", LAST_NFS4_OP + 1);
-	for (i = 0; i <= LAST_NFS4_OP; i++)
-		seq_printf(seq, " %u", nfsdstats.nfs4_opcount[i]);
+	for (i = 0; i <= LAST_NFS4_OP; i++) {
+		seq_printf(seq, " %lld",
+			   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_NFS4_OP(i)]));
+	}
 
 	seq_putc(seq, '\n');
 #endif
@@ -82,14 +84,63 @@ static const struct proc_ops nfsd_proc_ops = {
 	.proc_release	= single_release,
 };
 
-void
-nfsd_stat_init(void)
+int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)
 {
+	int i, err = 0;
+
+	for (i = 0; !err && i < num; i++)
+		err = percpu_counter_init(&counters[i], 0, GFP_KERNEL);
+
+	if (!err)
+		return 0;
+
+	for (; i > 0; i--)
+		percpu_counter_destroy(&counters[i-1]);
+
+	return err;
+}
+
+void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		percpu_counter_set(&counters[i], 0);
+}
+
+void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		percpu_counter_destroy(&counters[i]);
+}
+
+static int nfsd_stat_counters_init(void)
+{
+	return nfsd_percpu_counters_init(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
+}
+
+static void nfsd_stat_counters_destroy(void)
+{
+	nfsd_percpu_counters_destroy(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
+}
+
+int nfsd_stat_init(void)
+{
+	int err;
+
+	err = nfsd_stat_counters_init();
+	if (err)
+		return err;
+
 	svc_proc_register(&init_net, &nfsd_svcstats, &nfsd_proc_ops);
+
+	return 0;
 }
 
-void
-nfsd_stat_shutdown(void)
+void nfsd_stat_shutdown(void)
 {
+	nfsd_stat_counters_destroy();
 	svc_proc_unregister(&init_net, "nfsd");
 }
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 5e3cdf21556a1..87c3150c200f0 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -8,27 +8,85 @@
 #define _NFSD_STATS_H
 
 #include <uapi/linux/nfsd/stats.h>
+#include <linux/percpu_counter.h>
 
 
-struct nfsd_stats {
-	unsigned int	rchits;		/* repcache hits */
-	unsigned int	rcmisses;	/* repcache hits */
-	unsigned int	rcnocache;	/* uncached reqs */
-	unsigned int	fh_stale;	/* FH stale error */
-	unsigned int	io_read;	/* bytes returned to read requests */
-	unsigned int	io_write;	/* bytes passed in write requests */
-	unsigned int	th_cnt;		/* number of available threads */
+enum {
+	NFSD_STATS_RC_HITS,		/* repcache hits */
+	NFSD_STATS_RC_MISSES,		/* repcache misses */
+	NFSD_STATS_RC_NOCACHE,		/* uncached reqs */
+	NFSD_STATS_FH_STALE,		/* FH stale error */
+	NFSD_STATS_IO_READ,		/* bytes returned to read requests */
+	NFSD_STATS_IO_WRITE,		/* bytes passed in write requests */
 #ifdef CONFIG_NFSD_V4
-	unsigned int	nfs4_opcount[LAST_NFS4_OP + 1];	/* count of individual nfsv4 operations */
+	NFSD_STATS_FIRST_NFS4_OP,	/* count of individual nfsv4 operations */
+	NFSD_STATS_LAST_NFS4_OP = NFSD_STATS_FIRST_NFS4_OP + LAST_NFS4_OP,
+#define NFSD_STATS_NFS4_OP(op)	(NFSD_STATS_FIRST_NFS4_OP + (op))
 #endif
+	NFSD_STATS_COUNTERS_NUM
+};
+
+struct nfsd_stats {
+	struct percpu_counter	counter[NFSD_STATS_COUNTERS_NUM];
 
+	/* Protected by nfsd_mutex */
+	unsigned int	th_cnt;		/* number of available threads */
 };
 
 
 extern struct nfsd_stats	nfsdstats;
+
 extern struct svc_stat		nfsd_svcstats;
 
-void	nfsd_stat_init(void);
-void	nfsd_stat_shutdown(void);
+int nfsd_percpu_counters_init(struct percpu_counter counters[], int num);
+void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num);
+void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num);
+int nfsd_stat_init(void);
+void nfsd_stat_shutdown(void);
+
+static inline void nfsd_stats_rc_hits_inc(void)
+{
+	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_HITS]);
+}
+
+static inline void nfsd_stats_rc_misses_inc(void)
+{
+	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_MISSES]);
+}
+
+static inline void nfsd_stats_rc_nocache_inc(void)
+{
+	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]);
+}
+
+static inline void nfsd_stats_fh_stale_inc(void)
+{
+	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_FH_STALE]);
+}
+
+static inline void nfsd_stats_io_read_add(s64 amount)
+{
+	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_READ], amount);
+}
+
+static inline void nfsd_stats_io_write_add(s64 amount)
+{
+	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_WRITE], amount);
+}
+
+static inline void nfsd_stats_payload_misses_inc(struct nfsd_net *nn)
+{
+	percpu_counter_inc(&nn->counter[NFSD_NET_PAYLOAD_MISSES]);
+}
+
+static inline void nfsd_stats_drc_mem_usage_add(struct nfsd_net *nn, s64 amount)
+{
+	percpu_counter_add(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
+}
+
+static inline void nfsd_stats_drc_mem_usage_sub(struct nfsd_net *nn, s64 amount)
+{
+	percpu_counter_sub(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
+}
 
 #endif /* _NFSD_STATS_H */
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a515cbd0a7d8f..1b44d8f985be9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -897,7 +897,7 @@ static __be32 nfsd_finish_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			       unsigned long *count, u32 *eof, ssize_t host_err)
 {
 	if (host_err >= 0) {
-		nfsdstats.io_read += host_err;
+		nfsd_stats_io_read_add(host_err);
 		*eof = nfsd_eof_on_read(file, offset, host_err, *count);
 		*count = host_err;
 		fsnotify_access(file);
@@ -1050,7 +1050,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		goto out_nfserr;
 	}
 	*cnt = host_err;
-	nfsdstats.io_write += *cnt;
+	nfsd_stats_io_write_add(*cnt);
 	fsnotify_modify(file);
 	host_err = filemap_check_wb_err(file->f_mapping, since);
 	if (host_err < 0)
-- 
2.43.0




