Return-Path: <stable+bounces-53282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DC190D0F5
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA18287D6E
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940018EFFB;
	Tue, 18 Jun 2024 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RWxW6V34"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77443155736;
	Tue, 18 Jun 2024 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715867; cv=none; b=sYQr/rhCDBfrCirzTHt9uT3KNVOeLAKRu3nem4RmAQPQU+LvDe463NFMkD2yk+H1a/2oWH/mmab3VdLHKvbu6QXlIzeGVB96o7h/HV19Lj9VDuzeTw9gnIKqyd/d8qi7piKLuiKrBduELvWcrYhgD+hLCjnbSxfBTFxYgGK51bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715867; c=relaxed/simple;
	bh=6ox0ZHlD37YrvmwgcuwxdJ2o08vBnsKBie8Y80UDp68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rK9lrZxLCwlCe0Tg5WW1uudpXkFcLZtYeI3paOGyRAb+DxCWZH22kS7wIqta/hiNvP+pJyrGFxOSMD0RfdVBTn0X354FCCr4YhstCKCRkGoMtrsNRqbfj/CQ0E44AgOMEx9c9DCQvcj5lEYJczKZuIjfKUsUXS/CybEdKv7MxGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RWxW6V34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EBBC32786;
	Tue, 18 Jun 2024 13:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715867;
	bh=6ox0ZHlD37YrvmwgcuwxdJ2o08vBnsKBie8Y80UDp68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWxW6V34Rx66Ckik6TUhDVm19BadjOQ1Ce2XYUypVlVqxHx4iS1lEn6Q710rCwJ6O
	 PAJjsHT4nRge7Kp8/BedI+F2QoscYEF73dNq09hRCpwabSdhQgBQWvWmzN/Ki3Pgy9
	 L3MHT8T+YU4icNjf/x8wa/SWJRq9HpUE/+XkMS1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 454/770] nfsd: Add a tracepoint for errors in nfsd4_clone_file_range()
Date: Tue, 18 Jun 2024 14:35:07 +0200
Message-ID: <20240618123424.822933933@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit a2f4c3fa4db94ba44d32a72201927cfd132a8e82 ]

Since a clone error commit can cause the boot verifier to change,
we should trace those errors.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ cel: Addressed a checkpatch.pl splat in fs/nfsd/vfs.h ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/trace.h    | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c      | 18 +++++++++++++++--
 fs/nfsd/vfs.h      |  3 ++-
 4 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index eaf2f95d059ca..0f2025b7a6415 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1104,7 +1104,7 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto out;
 
-	status = nfsd4_clone_file_range(src, clone->cl_src_pos,
+	status = nfsd4_clone_file_range(rqstp, src, clone->cl_src_pos,
 			dst, clone->cl_dst_pos, clone->cl_count,
 			EX_ISSYNC(cstate->current_fh.fh_export));
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index cba38e0b204b9..199b485c77179 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -400,6 +400,56 @@ TRACE_EVENT(nfsd_dirent,
 		__entry->len, __get_str(name))
 )
 
+DECLARE_EVENT_CLASS(nfsd_copy_err_class,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh	*src_fhp,
+		 loff_t		src_offset,
+		 struct svc_fh	*dst_fhp,
+		 loff_t		dst_offset,
+		 u64		count,
+		 int		status),
+	TP_ARGS(rqstp, src_fhp, src_offset, dst_fhp, dst_offset, count, status),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, src_fh_hash)
+		__field(loff_t, src_offset)
+		__field(u32, dst_fh_hash)
+		__field(loff_t, dst_offset)
+		__field(u64, count)
+		__field(int, status)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->src_fh_hash = knfsd_fh_hash(&src_fhp->fh_handle);
+		__entry->src_offset = src_offset;
+		__entry->dst_fh_hash = knfsd_fh_hash(&dst_fhp->fh_handle);
+		__entry->dst_offset = dst_offset;
+		__entry->count = count;
+		__entry->status = status;
+	),
+	TP_printk("xid=0x%08x src_fh_hash=0x%08x src_offset=%lld "
+			"dst_fh_hash=0x%08x dst_offset=%lld "
+			"count=%llu status=%d",
+		  __entry->xid, __entry->src_fh_hash, __entry->src_offset,
+		  __entry->dst_fh_hash, __entry->dst_offset,
+		  (unsigned long long)__entry->count,
+		  __entry->status)
+)
+
+#define DEFINE_NFSD_COPY_ERR_EVENT(name)		\
+DEFINE_EVENT(nfsd_copy_err_class, nfsd_##name,		\
+	TP_PROTO(struct svc_rqst	*rqstp,		\
+		 struct svc_fh		*src_fhp,	\
+		 loff_t			src_offset,	\
+		 struct svc_fh		*dst_fhp,	\
+		 loff_t			dst_offset,	\
+		 u64			count,		\
+		 int			status),	\
+	TP_ARGS(rqstp, src_fhp, src_offset, dst_fhp, dst_offset, \
+		count, status))
+
+DEFINE_NFSD_COPY_ERR_EVENT(clone_file_range_err);
+
 #include "state.h"
 #include "filecache.h"
 #include "vfs.h"
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2e3b0bd560fcc..b1ce38c642cde 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -40,6 +40,7 @@
 #include "../internal.h"
 #include "acl.h"
 #include "idmap.h"
+#include "xdr4.h"
 #endif /* CONFIG_NFSD_V4 */
 
 #include "nfsd.h"
@@ -530,8 +531,15 @@ __be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
 }
 #endif
 
-__be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
-		struct nfsd_file *nf_dst, u64 dst_pos, u64 count, bool sync)
+static struct nfsd4_compound_state *nfsd4_get_cstate(struct svc_rqst *rqstp)
+{
+	return &((struct nfsd4_compoundres *)rqstp->rq_resp)->cstate;
+}
+
+__be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
+		struct nfsd_file *nf_src, u64 src_pos,
+		struct nfsd_file *nf_dst, u64 dst_pos,
+		u64 count, bool sync)
 {
 	struct file *src = nf_src->nf_file;
 	struct file *dst = nf_dst->nf_file;
@@ -558,6 +566,12 @@ __be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
 		if (!status)
 			status = commit_inode_metadata(file_inode(src));
 		if (status < 0) {
+			trace_nfsd_clone_file_range_err(rqstp,
+					&nfsd4_get_cstate(rqstp)->save_fh,
+					src_pos,
+					&nfsd4_get_cstate(rqstp)->current_fh,
+					dst_pos,
+					count, status);
 			nfsd_reset_boot_verifier(net_generic(nf_dst->nf_net,
 						 nfsd_net_id));
 			ret = nfserrno(status);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index b21b76e6b9a87..9f56dcb22ff72 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -57,7 +57,8 @@ __be32          nfsd4_set_nfs4_label(struct svc_rqst *, struct svc_fh *,
 		    struct xdr_netobj *);
 __be32		nfsd4_vfs_fallocate(struct svc_rqst *, struct svc_fh *,
 				    struct file *, loff_t, loff_t, int);
-__be32		nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
+__be32		nfsd4_clone_file_range(struct svc_rqst *rqstp,
+				       struct nfsd_file *nf_src, u64 src_pos,
 				       struct nfsd_file *nf_dst, u64 dst_pos,
 				       u64 count, bool sync);
 #endif /* CONFIG_NFSD_V4 */
-- 
2.43.0




