Return-Path: <stable+bounces-53037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A12E790CFDE
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932D31C23B22
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975B71662F9;
	Tue, 18 Jun 2024 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oIs3Dm17"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5453C15216F;
	Tue, 18 Jun 2024 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715141; cv=none; b=QD6uYT0KL/XvujcqD43jChx75WQUmMNLnytPsaX2AVVm0PJJiUHbAo36eDx6X7pghwwQTWZbfk1poZ3nhPHN+hekX2KZwLY5dVQva0BttJdmoBH+D/0tnnLGCkQM7C1FlLFNXWycDCMfsww1p0IvsHQ+3h9AqtlBlgM8QxaPQYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715141; c=relaxed/simple;
	bh=K9Nlvf10TG6ZquS7JaujuTcGVhJFUotzitAVfF2oeCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPJeACp4EHwVJmSLTALZrX4qf80+N6cxgoDHSJE628ydHBqB/L/OrlfS07xjJYTHf25JY/W9LXZ6SvwBv1xGlXTxMJ8hWG/N3GhhhginZ2wpWc3GlzdkV8DB0aAYgcnwlin6jl142RPFPhRKzSlEADqS4ueusB+Aarenjn8or1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oIs3Dm17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE04CC3277B;
	Tue, 18 Jun 2024 12:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715141;
	bh=K9Nlvf10TG6ZquS7JaujuTcGVhJFUotzitAVfF2oeCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIs3Dm17xVUXox9TfWpFZrfeS45UEtGRudIAeUa1rmoedZ+Di2pWTG++tKynr+NNL
	 u0KJFmustPQgEERAXR4EywJAwi+h6lNJNDyrmeR0yIVU+alCjQmmksiBHgdfR+zyC6
	 j1/Tt4cymjeMwDt7QtrF9QpE7SlcyAXa5QVxPxlY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 177/770] nfsd: report per-export stats
Date: Tue, 18 Jun 2024 14:30:30 +0200
Message-ID: <20240618123414.102571064@linuxfoundation.org>
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

[ Upstream commit 20ad856e47323e208ae8d6a9ecfe5bf0be6f505e ]

Collect some nfsd stats per export in addition to the global stats.

A new nfsdfs export_stats file is created.  It uses the same ops as the
exports file to iterate the export entries and we use the file's name to
determine the reported info per export.  For example:

 $ cat /proc/fs/nfsd/export_stats
 # Version 1.1
 # Path Client Start-time
 #	Stats
 /test	localhost	92
	fh_stale: 0
	io_read: 9
	io_write: 1

Every export entry reports the start time when stats collection
started, so stats collecting scripts can know if stats where reset
between samples.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/export.c | 68 ++++++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/export.h | 15 +++++++++++
 fs/nfsd/nfsctl.c |  3 +++
 fs/nfsd/nfsd.h   |  2 +-
 fs/nfsd/nfsfh.c  |  4 +--
 fs/nfsd/stats.h  | 12 ++++++---
 fs/nfsd/vfs.c    |  4 +--
 7 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 81e7bb12aca69..7c863f2c21e0c 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -331,12 +331,29 @@ static void nfsd4_fslocs_free(struct nfsd4_fs_locations *fsloc)
 	fsloc->locations = NULL;
 }
 
+static int export_stats_init(struct export_stats *stats)
+{
+	stats->start_time = ktime_get_seconds();
+	return nfsd_percpu_counters_init(stats->counter, EXP_STATS_COUNTERS_NUM);
+}
+
+static void export_stats_reset(struct export_stats *stats)
+{
+	nfsd_percpu_counters_reset(stats->counter, EXP_STATS_COUNTERS_NUM);
+}
+
+static void export_stats_destroy(struct export_stats *stats)
+{
+	nfsd_percpu_counters_destroy(stats->counter, EXP_STATS_COUNTERS_NUM);
+}
+
 static void svc_export_put(struct kref *ref)
 {
 	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
 	path_put(&exp->ex_path);
 	auth_domain_put(exp->ex_client);
 	nfsd4_fslocs_free(&exp->ex_fslocs);
+	export_stats_destroy(&exp->ex_stats);
 	kfree(exp->ex_uuid);
 	kfree_rcu(exp, ex_rcu);
 }
@@ -692,22 +709,47 @@ static void exp_flags(struct seq_file *m, int flag, int fsid,
 		kuid_t anonu, kgid_t anong, struct nfsd4_fs_locations *fslocs);
 static void show_secinfo(struct seq_file *m, struct svc_export *exp);
 
+static int is_export_stats_file(struct seq_file *m)
+{
+	/*
+	 * The export_stats file uses the same ops as the exports file.
+	 * We use the file's name to determine the reported info per export.
+	 * There is no rename in nsfdfs, so d_name.name is stable.
+	 */
+	return !strcmp(m->file->f_path.dentry->d_name.name, "export_stats");
+}
+
 static int svc_export_show(struct seq_file *m,
 			   struct cache_detail *cd,
 			   struct cache_head *h)
 {
-	struct svc_export *exp ;
+	struct svc_export *exp;
+	bool export_stats = is_export_stats_file(m);
 
-	if (h ==NULL) {
-		seq_puts(m, "#path domain(flags)\n");
+	if (h == NULL) {
+		if (export_stats)
+			seq_puts(m, "#path domain start-time\n#\tstats\n");
+		else
+			seq_puts(m, "#path domain(flags)\n");
 		return 0;
 	}
 	exp = container_of(h, struct svc_export, h);
 	seq_path(m, &exp->ex_path, " \t\n\\");
 	seq_putc(m, '\t');
 	seq_escape(m, exp->ex_client->name, " \t\n\\");
+	if (export_stats) {
+		seq_printf(m, "\t%lld\n", exp->ex_stats.start_time);
+		seq_printf(m, "\tfh_stale: %lld\n",
+			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_FH_STALE]));
+		seq_printf(m, "\tio_read: %lld\n",
+			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_IO_READ]));
+		seq_printf(m, "\tio_write: %lld\n",
+			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_IO_WRITE]));
+		seq_putc(m, '\n');
+		return 0;
+	}
 	seq_putc(m, '(');
-	if (test_bit(CACHE_VALID, &h->flags) && 
+	if (test_bit(CACHE_VALID, &h->flags) &&
 	    !test_bit(CACHE_NEGATIVE, &h->flags)) {
 		exp_flags(m, exp->ex_flags, exp->ex_fsid,
 			  exp->ex_anon_uid, exp->ex_anon_gid, &exp->ex_fslocs);
@@ -748,6 +790,7 @@ static void svc_export_init(struct cache_head *cnew, struct cache_head *citem)
 	new->ex_layout_types = 0;
 	new->ex_uuid = NULL;
 	new->cd = item->cd;
+	export_stats_reset(&new->ex_stats);
 }
 
 static void export_update(struct cache_head *cnew, struct cache_head *citem)
@@ -780,10 +823,15 @@ static void export_update(struct cache_head *cnew, struct cache_head *citem)
 static struct cache_head *svc_export_alloc(void)
 {
 	struct svc_export *i = kmalloc(sizeof(*i), GFP_KERNEL);
-	if (i)
-		return &i->h;
-	else
+	if (!i)
+		return NULL;
+
+	if (export_stats_init(&i->ex_stats)) {
+		kfree(i);
 		return NULL;
+	}
+
+	return &i->h;
 }
 
 static const struct cache_detail svc_export_cache_template = {
@@ -1245,10 +1293,14 @@ static int e_show(struct seq_file *m, void *p)
 	struct cache_head *cp = p;
 	struct svc_export *exp = container_of(cp, struct svc_export, h);
 	struct cache_detail *cd = m->private;
+	bool export_stats = is_export_stats_file(m);
 
 	if (p == SEQ_START_TOKEN) {
 		seq_puts(m, "# Version 1.1\n");
-		seq_puts(m, "# Path Client(Flags) # IPs\n");
+		if (export_stats)
+			seq_puts(m, "# Path Client Start-time\n#\tStats\n");
+		else
+			seq_puts(m, "# Path Client(Flags) # IPs\n");
 		return 0;
 	}
 
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index e7daa1f246f08..ee0e3aba4a6e5 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -6,6 +6,7 @@
 #define NFSD_EXPORT_H
 
 #include <linux/sunrpc/cache.h>
+#include <linux/percpu_counter.h>
 #include <uapi/linux/nfsd/export.h>
 #include <linux/nfs4.h>
 
@@ -46,6 +47,19 @@ struct exp_flavor_info {
 	u32	flags;
 };
 
+/* Per-export stats */
+enum {
+	EXP_STATS_FH_STALE,
+	EXP_STATS_IO_READ,
+	EXP_STATS_IO_WRITE,
+	EXP_STATS_COUNTERS_NUM
+};
+
+struct export_stats {
+	time64_t		start_time;
+	struct percpu_counter	counter[EXP_STATS_COUNTERS_NUM];
+};
+
 struct svc_export {
 	struct cache_head	h;
 	struct auth_domain *	ex_client;
@@ -62,6 +76,7 @@ struct svc_export {
 	struct nfsd4_deviceid_map *ex_devid_map;
 	struct cache_detail	*cd;
 	struct rcu_head		ex_rcu;
+	struct export_stats	ex_stats;
 };
 
 /* an "export key" (expkey) maps a filehandlefragement to an
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 7f85c171f83aa..fa060f91df1b8 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -32,6 +32,7 @@
 enum {
 	NFSD_Root = 1,
 	NFSD_List,
+	NFSD_Export_Stats,
 	NFSD_Export_features,
 	NFSD_Fh,
 	NFSD_FO_UnlockIP,
@@ -1352,6 +1353,8 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	static const struct tree_descr nfsd_files[] = {
 		[NFSD_List] = {"exports", &exports_nfsd_operations, S_IRUGO},
+		/* Per-export io stats use same ops as exports file */
+		[NFSD_Export_Stats] = {"export_stats", &exports_nfsd_operations, S_IRUGO},
 		[NFSD_Export_features] = {"export_features",
 					&export_features_operations, S_IRUGO},
 		[NFSD_FO_UnlockIP] = {"unlock_ip",
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 2326428e2c5bf..27c1308ffc2ba 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -24,8 +24,8 @@
 #include <uapi/linux/nfsd/debug.h>
 
 #include "netns.h"
-#include "stats.h"
 #include "export.h"
+#include "stats.h"
 
 #undef ifdebug
 #ifdef CONFIG_SUNRPC_DEBUG
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 9e31b2b5c6d26..4744a276058d4 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -349,7 +349,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 __be32
 fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 {
-	struct svc_export *exp;
+	struct svc_export *exp = NULL;
 	struct dentry	*dentry;
 	__be32		error;
 
@@ -422,7 +422,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	}
 out:
 	if (error == nfserr_stale)
-		nfsd_stats_fh_stale_inc();
+		nfsd_stats_fh_stale_inc(exp);
 	return error;
 }
 
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 87c3150c200f0..51ecda852e23b 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -59,19 +59,25 @@ static inline void nfsd_stats_rc_nocache_inc(void)
 	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]);
 }
 
-static inline void nfsd_stats_fh_stale_inc(void)
+static inline void nfsd_stats_fh_stale_inc(struct svc_export *exp)
 {
 	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_FH_STALE]);
+	if (exp)
+		percpu_counter_inc(&exp->ex_stats.counter[EXP_STATS_FH_STALE]);
 }
 
-static inline void nfsd_stats_io_read_add(s64 amount)
+static inline void nfsd_stats_io_read_add(struct svc_export *exp, s64 amount)
 {
 	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_READ], amount);
+	if (exp)
+		percpu_counter_add(&exp->ex_stats.counter[EXP_STATS_IO_READ], amount);
 }
 
-static inline void nfsd_stats_io_write_add(s64 amount)
+static inline void nfsd_stats_io_write_add(struct svc_export *exp, s64 amount)
 {
 	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_WRITE], amount);
+	if (exp)
+		percpu_counter_add(&exp->ex_stats.counter[EXP_STATS_IO_WRITE], amount);
 }
 
 static inline void nfsd_stats_payload_misses_inc(struct nfsd_net *nn)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 1b44d8f985be9..3e30788e0046b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -897,7 +897,7 @@ static __be32 nfsd_finish_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			       unsigned long *count, u32 *eof, ssize_t host_err)
 {
 	if (host_err >= 0) {
-		nfsd_stats_io_read_add(host_err);
+		nfsd_stats_io_read_add(fhp->fh_export, host_err);
 		*eof = nfsd_eof_on_read(file, offset, host_err, *count);
 		*count = host_err;
 		fsnotify_access(file);
@@ -1050,7 +1050,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		goto out_nfserr;
 	}
 	*cnt = host_err;
-	nfsd_stats_io_write_add(*cnt);
+	nfsd_stats_io_write_add(exp, *cnt);
 	fsnotify_modify(file);
 	host_err = filemap_check_wb_err(file->f_mapping, since);
 	if (host_err < 0)
-- 
2.43.0




