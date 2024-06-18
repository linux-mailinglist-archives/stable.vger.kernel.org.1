Return-Path: <stable+bounces-53401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C89590D179
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A791F265E5
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09581A08AA;
	Tue, 18 Jun 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U1faMLOL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2A813C807;
	Tue, 18 Jun 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716216; cv=none; b=YbysB5ttckQAFvWVYYX2WkmfwnKxrhcLWkyMvy5DNTZK+qrLQK2UVVakbxgORgTvp5/k/yQ/dxn4VxllZwatbYnL+EfXYvRsZ+FzTi3FfK8GqUACUeEndgAG2QVDtqM2yOtCPkE7Zyybnvgl1Jv2JM9Thvj8liLPmj1WygXbPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716216; c=relaxed/simple;
	bh=lLGrQgY9R9vjWAzP2f98GVrcJWkSmy05aGUmpxiOm0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqCXnPg5MaxCNpqZcZioY8EQ0YSEsUqqwe86wHTE7vT8OgXuAPTPZHGJ/Kt+Wg9/GzUAsgjUzagXGHz49NMJ7xfaRpWKZ45ghyCA+3udufPCb0YAPsljivIArxoZVDnYR9XVjyCqRSYuuy05ZQyT4w4NWvVrvyliV+2fZdpLTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U1faMLOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A041C3277B;
	Tue, 18 Jun 2024 13:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716216;
	bh=lLGrQgY9R9vjWAzP2f98GVrcJWkSmy05aGUmpxiOm0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1faMLOLhqPMaQRuSp9j3+9Jrwf2KaLNtX/KXpWk7lA4CpCM6nswbgVp86Fhy9H/G
	 +rdgoW7rYQsk/YlDnrl75e3Vme77C7j2B1OyLfH0cc+xlzgiCuG7Oe7RkpLW11u+Em
	 EigE3CsofFHJILERZH6vwTebJ1lPdfGhmrMNmFHk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 571/770] NFSD: No longer record nf_hashval in the trace log
Date: Tue, 18 Jun 2024 14:37:04 +0200
Message-ID: <20240618123429.337994549@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 54f7df7094b329ca35d9f9808692bb16c48b13e9 ]

I'm about to replace nfsd_file_hashtbl with an rhashtable. The
individual hash values will no longer be visible or relevant, so
remove them from the tracepoints.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 15 ++++++++-------
 fs/nfsd/trace.h     | 45 +++++++++++++++++++++------------------------
 2 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 7a02ff11b9ec1..2d013a88e3565 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -588,7 +588,7 @@ nfsd_file_close_inode_sync(struct inode *inode)
 	LIST_HEAD(dispose);
 
 	__nfsd_file_close_inode(inode, hashval, &dispose);
-	trace_nfsd_file_close_inode_sync(inode, hashval, !list_empty(&dispose));
+	trace_nfsd_file_close_inode_sync(inode, !list_empty(&dispose));
 	nfsd_file_dispose_list_sync(&dispose);
 }
 
@@ -608,7 +608,7 @@ nfsd_file_close_inode(struct inode *inode)
 	LIST_HEAD(dispose);
 
 	__nfsd_file_close_inode(inode, hashval, &dispose);
-	trace_nfsd_file_close_inode(inode, hashval, !list_empty(&dispose));
+	trace_nfsd_file_close_inode(inode, !list_empty(&dispose));
 	nfsd_file_dispose_list_delayed(&dispose);
 }
 
@@ -962,7 +962,7 @@ nfsd_file_is_cached(struct inode *inode)
 		}
 	}
 	rcu_read_unlock();
-	trace_nfsd_file_is_cached(inode, hashval, (int)ret);
+	trace_nfsd_file_is_cached(inode, (int)ret);
 	return ret;
 }
 
@@ -994,9 +994,8 @@ nfsd_do_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	new = nfsd_file_alloc(inode, may_flags, hashval, net);
 	if (!new) {
-		trace_nfsd_file_acquire(rqstp, hashval, inode, may_flags,
-					NULL, nfserr_jukebox);
-		return nfserr_jukebox;
+		status = nfserr_jukebox;
+		goto out_status;
 	}
 
 	spin_lock(&nfsd_file_hashtbl[hashval].nfb_lock);
@@ -1034,8 +1033,10 @@ nfsd_do_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		nf = NULL;
 	}
 
-	trace_nfsd_file_acquire(rqstp, hashval, inode, may_flags, nf, status);
+out_status:
+	trace_nfsd_file_acquire(rqstp, inode, may_flags, nf, status);
 	return status;
+
 open_file:
 	nf = new;
 	/* Take reference for the hashtable */
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 5919cdcf137b8..8b34f2a5ad296 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -713,7 +713,6 @@ DECLARE_EVENT_CLASS(nfsd_file_class,
 	TP_PROTO(struct nfsd_file *nf),
 	TP_ARGS(nf),
 	TP_STRUCT__entry(
-		__field(unsigned int, nf_hashval)
 		__field(void *, nf_inode)
 		__field(int, nf_ref)
 		__field(unsigned long, nf_flags)
@@ -721,15 +720,13 @@ DECLARE_EVENT_CLASS(nfsd_file_class,
 		__field(struct file *, nf_file)
 	),
 	TP_fast_assign(
-		__entry->nf_hashval = nf->nf_hashval;
 		__entry->nf_inode = nf->nf_inode;
 		__entry->nf_ref = refcount_read(&nf->nf_ref);
 		__entry->nf_flags = nf->nf_flags;
 		__entry->nf_may = nf->nf_may;
 		__entry->nf_file = nf->nf_file;
 	),
-	TP_printk("hash=0x%x inode=%p ref=%d flags=%s may=%s file=%p",
-		__entry->nf_hashval,
+	TP_printk("inode=%p ref=%d flags=%s may=%s nf_file=%p",
 		__entry->nf_inode,
 		__entry->nf_ref,
 		show_nf_flags(__entry->nf_flags),
@@ -749,15 +746,18 @@ DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
 DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_release_locked);
 
 TRACE_EVENT(nfsd_file_acquire,
-	TP_PROTO(struct svc_rqst *rqstp, unsigned int hash,
-		 struct inode *inode, unsigned int may_flags,
-		 struct nfsd_file *nf, __be32 status),
+	TP_PROTO(
+		struct svc_rqst *rqstp,
+		struct inode *inode,
+		unsigned int may_flags,
+		struct nfsd_file *nf,
+		__be32 status
+	),
 
-	TP_ARGS(rqstp, hash, inode, may_flags, nf, status),
+	TP_ARGS(rqstp, inode, may_flags, nf, status),
 
 	TP_STRUCT__entry(
 		__field(u32, xid)
-		__field(unsigned int, hash)
 		__field(void *, inode)
 		__field(unsigned long, may_flags)
 		__field(int, nf_ref)
@@ -769,7 +769,6 @@ TRACE_EVENT(nfsd_file_acquire,
 
 	TP_fast_assign(
 		__entry->xid = be32_to_cpu(rqstp->rq_xid);
-		__entry->hash = hash;
 		__entry->inode = inode;
 		__entry->may_flags = may_flags;
 		__entry->nf_ref = nf ? refcount_read(&nf->nf_ref) : 0;
@@ -779,8 +778,8 @@ TRACE_EVENT(nfsd_file_acquire,
 		__entry->status = be32_to_cpu(status);
 	),
 
-	TP_printk("xid=0x%x hash=0x%x inode=%p may_flags=%s ref=%d nf_flags=%s nf_may=%s nf_file=%p status=%u",
-			__entry->xid, __entry->hash, __entry->inode,
+	TP_printk("xid=0x%x inode=%p may_flags=%s ref=%d nf_flags=%s nf_may=%s nf_file=%p status=%u",
+			__entry->xid, __entry->inode,
 			show_nfsd_may_flags(__entry->may_flags),
 			__entry->nf_ref, show_nf_flags(__entry->nf_flags),
 			show_nfsd_may_flags(__entry->nf_may),
@@ -791,7 +790,6 @@ TRACE_EVENT(nfsd_file_open,
 	TP_PROTO(struct nfsd_file *nf, __be32 status),
 	TP_ARGS(nf, status),
 	TP_STRUCT__entry(
-		__field(unsigned int, nf_hashval)
 		__field(void *, nf_inode)	/* cannot be dereferenced */
 		__field(int, nf_ref)
 		__field(unsigned long, nf_flags)
@@ -799,15 +797,13 @@ TRACE_EVENT(nfsd_file_open,
 		__field(void *, nf_file)	/* cannot be dereferenced */
 	),
 	TP_fast_assign(
-		__entry->nf_hashval = nf->nf_hashval;
 		__entry->nf_inode = nf->nf_inode;
 		__entry->nf_ref = refcount_read(&nf->nf_ref);
 		__entry->nf_flags = nf->nf_flags;
 		__entry->nf_may = nf->nf_may;
 		__entry->nf_file = nf->nf_file;
 	),
-	TP_printk("hash=0x%x inode=%p ref=%d flags=%s may=%s file=%p",
-		__entry->nf_hashval,
+	TP_printk("inode=%p ref=%d flags=%s may=%s file=%p",
 		__entry->nf_inode,
 		__entry->nf_ref,
 		show_nf_flags(__entry->nf_flags),
@@ -816,26 +812,27 @@ TRACE_EVENT(nfsd_file_open,
 )
 
 DECLARE_EVENT_CLASS(nfsd_file_search_class,
-	TP_PROTO(struct inode *inode, unsigned int hash, int found),
-	TP_ARGS(inode, hash, found),
+	TP_PROTO(
+		struct inode *inode,
+		int found
+	),
+	TP_ARGS(inode, found),
 	TP_STRUCT__entry(
 		__field(struct inode *, inode)
-		__field(unsigned int, hash)
 		__field(int, found)
 	),
 	TP_fast_assign(
 		__entry->inode = inode;
-		__entry->hash = hash;
 		__entry->found = found;
 	),
-	TP_printk("hash=0x%x inode=%p found=%d", __entry->hash,
-			__entry->inode, __entry->found)
+	TP_printk("inode=%p found=%d",
+		__entry->inode, __entry->found)
 );
 
 #define DEFINE_NFSD_FILE_SEARCH_EVENT(name)				\
 DEFINE_EVENT(nfsd_file_search_class, name,				\
-	TP_PROTO(struct inode *inode, unsigned int hash, int found),	\
-	TP_ARGS(inode, hash, found))
+	TP_PROTO(struct inode *inode, int found),			\
+	TP_ARGS(inode, found))
 
 DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_close_inode_sync);
 DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_close_inode);
-- 
2.43.0




