Return-Path: <stable+bounces-53583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D690D279
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32176286159
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BAD1AC226;
	Tue, 18 Jun 2024 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H/FbyjsK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F015A84D;
	Tue, 18 Jun 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716759; cv=none; b=iCLHZZMXrc0sg64MaSlQixjwplmo7XVqeGVkBFBhrtxxSOabwEuWQ5WIBlGxyLM2NCFCEBXQOeoRic3gOvni6u7byTi6/k15sVb7ircGV0t9VDn8IOk+xeIrS4HPCxV/IoSpnHDrcwEwfsUf+8mt3wwXEF46i1fLTq0uWg5Src8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716759; c=relaxed/simple;
	bh=i62FEO5LsB/8riVeQz7HCeCCfgoHDjb8iIjCxs8rIRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eX8nC5OHjtdYEhh0/i20pG4TLXXmM7HUVhO+4vzR+S4GUEnYmPWQxwsyUhUWtPFe+2cqplS2Elakiti1P/L1JSAuFWMgOerJSEJwEgATKckZ8CVTgIDaisMA4/qmM6YJbpj78ZKYf75VGM3VszLBl1Ola4OzSVuJXUk6FCiZAr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H/FbyjsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552BAC3277B;
	Tue, 18 Jun 2024 13:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716759;
	bh=i62FEO5LsB/8riVeQz7HCeCCfgoHDjb8iIjCxs8rIRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/FbyjsKNYaKBTjT5LD3hD+exiLK4ra3nuIgIRr1eH/AlrSlXaNvyqkmhEcqAJfRv
	 /uLxHuwh4ulTFCNfLOdAbKdVzKE5zzroYSzMgJ2rNoD3gdLVcJl2YWXFojuuslF3pw
	 11pxNL8GBuughzjvHOcXU5o2YItWnU0+Vs3NJivU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trondmy@hammerspace.com>,
	Stanislav Saner <ssaner@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	Ruben Vestergaard <rubenv@drcmr.dk>,
	Torkil Svensgaard <torkil@drcmr.dk>
Subject: [PATCH 5.10 722/770] nfsd: fix handling of cached open files in nfsd4_open codepath
Date: Tue, 18 Jun 2024 14:39:35 +0200
Message-ID: <20240618123435.137866910@linuxfoundation.org>
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 0b3a551fa58b4da941efeb209b3770868e2eddd7 ]

Commit fb70bf124b05 ("NFSD: Instantiate a struct file when creating a
regular NFSv4 file") added the ability to cache an open fd over a
compound. There are a couple of problems with the way this currently
works:

It's racy, as a newly-created nfsd_file can end up with its PENDING bit
cleared while the nf is hashed, and the nf_file pointer is still zeroed
out. Other tasks can find it in this state and they expect to see a
valid nf_file, and can oops if nf_file is NULL.

Also, there is no guarantee that we'll end up creating a new nfsd_file
if one is already in the hash. If an extant entry is in the hash with a
valid nf_file, nfs4_get_vfs_file will clobber its nf_file pointer with
the value of op_file and the old nf_file will leak.

Fix both issues by making a new nfsd_file_acquirei_opened variant that
takes an optional file pointer. If one is present when this is called,
we'll take a new reference to it instead of trying to open the file. If
the nfsd_file already has a valid nf_file, we'll just ignore the
optional file and pass the nfsd_file back as-is.

Also rework the tracepoints a bit to allow for an "opened" variant and
don't try to avoid counting acquisitions in the case where we already
have a cached open file.

Fixes: fb70bf124b05 ("NFSD: Instantiate a struct file when creating a regular NFSv4 file")
Cc: Trond Myklebust <trondmy@hammerspace.com>
Reported-by: Stanislav Saner <ssaner@redhat.com>
Reported-and-Tested-by: Ruben Vestergaard <rubenv@drcmr.dk>
Reported-and-Tested-by: Torkil Svensgaard <torkil@drcmr.dk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 40 ++++++++++++++++++----------------
 fs/nfsd/filecache.h |  5 +++--
 fs/nfsd/nfs4state.c | 16 ++++----------
 fs/nfsd/trace.h     | 52 ++++++++++++---------------------------------
 4 files changed, 42 insertions(+), 71 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 140094a44cc40..6a62d95d5ce64 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1070,8 +1070,8 @@ nfsd_file_is_cached(struct inode *inode)
 
 static __be32
 nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		     unsigned int may_flags, struct nfsd_file **pnf,
-		     bool open, bool want_gc)
+		     unsigned int may_flags, struct file *file,
+		     struct nfsd_file **pnf, bool want_gc)
 {
 	struct nfsd_file_lookup_key key = {
 		.type	= NFSD_FILE_KEY_FULL,
@@ -1146,8 +1146,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_flags));
 out:
 	if (status == nfs_ok) {
-		if (open)
-			this_cpu_inc(nfsd_file_acquisitions);
+		this_cpu_inc(nfsd_file_acquisitions);
 		*pnf = nf;
 	} else {
 		if (refcount_dec_and_test(&nf->nf_ref))
@@ -1157,20 +1156,23 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 out_status:
 	put_cred(key.cred);
-	if (open)
-		trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
+	trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
 	return status;
 
 open_file:
 	trace_nfsd_file_alloc(nf);
 	nf->nf_mark = nfsd_file_mark_find_or_create(nf, key.inode);
 	if (nf->nf_mark) {
-		if (open) {
+		if (file) {
+			get_file(file);
+			nf->nf_file = file;
+			status = nfs_ok;
+			trace_nfsd_file_opened(nf, status);
+		} else {
 			status = nfsd_open_verified(rqstp, fhp, may_flags,
 						    &nf->nf_file);
 			trace_nfsd_file_open(nf, status);
-		} else
-			status = nfs_ok;
+		}
 	} else
 		status = nfserr_jukebox;
 	/*
@@ -1206,7 +1208,7 @@ __be32
 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, true);
+	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
 }
 
 /**
@@ -1227,28 +1229,30 @@ __be32
 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, false);
+	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, false);
 }
 
 /**
- * nfsd_file_create - Get a struct nfsd_file, do not open
+ * nfsd_file_acquire_opened - Get a struct nfsd_file using existing open file
  * @rqstp: the RPC transaction being executed
  * @fhp: the NFS filehandle of the file just created
  * @may_flags: NFSD_MAY_ settings for the file
+ * @file: cached, already-open file (may be NULL)
  * @pnf: OUT: new or found "struct nfsd_file" object
  *
- * The nfsd_file_object returned by this API is reference-counted
- * but not garbage-collected. The object is released immediately
- * one RCU grace period after the final nfsd_file_put().
+ * Acquire a nfsd_file object that is not GC'ed. If one doesn't already exist,
+ * and @file is non-NULL, use it to instantiate a new nfsd_file instead of
+ * opening a new one.
  *
  * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
  * network byte order is returned.
  */
 __be32
-nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		 unsigned int may_flags, struct nfsd_file **pnf)
+nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
+			 unsigned int may_flags, struct file *file,
+			 struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false, false);
+	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
 }
 
 /*
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index b7efb2c3ddb18..41516a4263ea5 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -60,7 +60,8 @@ __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **nfp);
 __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **nfp);
-__be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		  unsigned int may_flags, struct nfsd_file **nfp);
+__be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  unsigned int may_flags, struct file *file,
+		  struct nfsd_file **nfp);
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
 #endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4e05ad774c861..5eb3e055fde43 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5261,18 +5261,10 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	if (!fp->fi_fds[oflag]) {
 		spin_unlock(&fp->fi_lock);
 
-		if (!open->op_filp) {
-			status = nfsd_file_acquire(rqstp, cur_fh, access, &nf);
-			if (status != nfs_ok)
-				goto out_put_access;
-		} else {
-			status = nfsd_file_create(rqstp, cur_fh, access, &nf);
-			if (status != nfs_ok)
-				goto out_put_access;
-			nf->nf_file = open->op_filp;
-			open->op_filp = NULL;
-			trace_nfsd_file_create(rqstp, access, nf);
-		}
+		status = nfsd_file_acquire_opened(rqstp, cur_fh, access,
+						  open->op_filp, &nf);
+		if (status != nfs_ok)
+			goto out_put_access;
 
 		spin_lock(&fp->fi_lock);
 		if (!fp->fi_fds[oflag]) {
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 8db7eecde9e39..0f674982785ce 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -891,43 +891,6 @@ TRACE_EVENT(nfsd_file_acquire,
 	)
 );
 
-TRACE_EVENT(nfsd_file_create,
-	TP_PROTO(
-		const struct svc_rqst *rqstp,
-		unsigned int may_flags,
-		const struct nfsd_file *nf
-	),
-
-	TP_ARGS(rqstp, may_flags, nf),
-
-	TP_STRUCT__entry(
-		__field(const void *, nf_inode)
-		__field(const void *, nf_file)
-		__field(unsigned long, may_flags)
-		__field(unsigned long, nf_flags)
-		__field(unsigned long, nf_may)
-		__field(unsigned int, nf_ref)
-		__field(u32, xid)
-	),
-
-	TP_fast_assign(
-		__entry->nf_inode = nf->nf_inode;
-		__entry->nf_file = nf->nf_file;
-		__entry->may_flags = may_flags;
-		__entry->nf_flags = nf->nf_flags;
-		__entry->nf_may = nf->nf_may;
-		__entry->nf_ref = refcount_read(&nf->nf_ref);
-		__entry->xid = be32_to_cpu(rqstp->rq_xid);
-	),
-
-	TP_printk("xid=0x%x inode=%p may_flags=%s ref=%u nf_flags=%s nf_may=%s nf_file=%p",
-		__entry->xid, __entry->nf_inode,
-		show_nfsd_may_flags(__entry->may_flags),
-		__entry->nf_ref, show_nf_flags(__entry->nf_flags),
-		show_nfsd_may_flags(__entry->nf_may), __entry->nf_file
-	)
-);
-
 TRACE_EVENT(nfsd_file_insert_err,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,
@@ -989,8 +952,8 @@ TRACE_EVENT(nfsd_file_cons_err,
 	)
 );
 
-TRACE_EVENT(nfsd_file_open,
-	TP_PROTO(struct nfsd_file *nf, __be32 status),
+DECLARE_EVENT_CLASS(nfsd_file_open_class,
+	TP_PROTO(const struct nfsd_file *nf, __be32 status),
 	TP_ARGS(nf, status),
 	TP_STRUCT__entry(
 		__field(void *, nf_inode)	/* cannot be dereferenced */
@@ -1014,6 +977,17 @@ TRACE_EVENT(nfsd_file_open,
 		__entry->nf_file)
 )
 
+#define DEFINE_NFSD_FILE_OPEN_EVENT(name)					\
+DEFINE_EVENT(nfsd_file_open_class, name,					\
+	TP_PROTO(							\
+		const struct nfsd_file *nf,				\
+		__be32 status						\
+	),								\
+	TP_ARGS(nf, status))
+
+DEFINE_NFSD_FILE_OPEN_EVENT(nfsd_file_open);
+DEFINE_NFSD_FILE_OPEN_EVENT(nfsd_file_opened);
+
 TRACE_EVENT(nfsd_file_is_cached,
 	TP_PROTO(
 		const struct inode *inode,
-- 
2.43.0




