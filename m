Return-Path: <stable+bounces-53433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF02890D198
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6501F26ED2
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D2C18EFC2;
	Tue, 18 Jun 2024 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K1xxIzPt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC413C821;
	Tue, 18 Jun 2024 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716311; cv=none; b=GaLULYnfU/9kz6F4zx4uFe6cPtZnTMS7S3JMBFRLDyy1q6VodliYZ7XsoowkG5VLdIP2ndJnKnIsqR8FAlv4B9Y5EBA1oWqcV5MMTga11uVhJrIX8bsqnzYPg8zEbSicIbnDzKrPVuckzX0TNw3lYDk5HqcZgm1hc5RX0uDS1X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716311; c=relaxed/simple;
	bh=OMNZWdFLM2dIXYtlURb+GIxsyEFEkFifwD/U+3lkSOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIQAQyBAY/P5FJ1gc3aLJvLeXIuOW8I943AtQv/8eRupUeAVsfuIyaJslksZqjShKN0juL1+5ivDw2awiJJ3fW8XLvaqKRx/APaRtLaZqVUqSE3dT8NY902EsjQisVWCbgkegMqbvTi6aoyu/O7v8NsoefYtT7trMuhC2UcFhd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K1xxIzPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC9DC3277B;
	Tue, 18 Jun 2024 13:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716311;
	bh=OMNZWdFLM2dIXYtlURb+GIxsyEFEkFifwD/U+3lkSOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K1xxIzPtsn/Kqo1Ma7KWG5IHn/lFY0yjciICRM+eV1IkyK4v4Ns83jhdh+h2/JhJ1
	 prrHSAflIFTl7lB/XiCAqje/9HHZSIECWLiFn0E3pXG8uqL0R8fSnBP0C6GXw6kMOp
	 Byk7Rgw1S0LQyjFTLg44vekFDGxOIjCaof2HF5MQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 603/770] NFSD: Replace boolean fields in struct nfsd4_copy
Date: Tue, 18 Jun 2024 14:37:36 +0200
Message-ID: <20240618123430.565335501@linuxfoundation.org>
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

[ Upstream commit 1913cdf56cb5bfbc8170873728d13598cbecda23 ]

Clean up: saves 8 bytes, and we can replace check_and_set_stop_copy()
with an atomic bitop.

[ cel: adjusted to apply to v5.10.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c | 49 +++++++++++++++++-----------------------------
 fs/nfsd/nfs4xdr.c  | 12 ++++++------
 fs/nfsd/xdr4.h     | 33 ++++++++++++++++++++++++++-----
 3 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 64879350ccbda..a4bc096e509d4 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1295,23 +1295,9 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
 	kfree(copy);
 }
 
-static bool
-check_and_set_stop_copy(struct nfsd4_copy *copy)
-{
-	bool value;
-
-	spin_lock(&copy->cp_clp->async_lock);
-	value = copy->stopped;
-	if (!copy->stopped)
-		copy->stopped = true;
-	spin_unlock(&copy->cp_clp->async_lock);
-	return value;
-}
-
 static void nfsd4_stop_copy(struct nfsd4_copy *copy)
 {
-	/* only 1 thread should stop the copy */
-	if (!check_and_set_stop_copy(copy))
+	if (!test_and_set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags))
 		kthread_stop(copy->copy_task);
 	nfs4_put_copy(copy);
 }
@@ -1668,8 +1654,9 @@ static const struct nfsd4_callback_ops nfsd4_cb_offload_ops = {
 static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
 {
 	copy->cp_res.wr_stable_how =
-		copy->committed ? NFS_FILE_SYNC : NFS_UNSTABLE;
-	copy->cp_synchronous = sync;
+		test_bit(NFSD4_COPY_F_COMMITTED, &copy->cp_flags) ?
+			NFS_FILE_SYNC : NFS_UNSTABLE;
+	nfsd4_copy_set_sync(copy, sync);
 	gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
 }
 
@@ -1698,16 +1685,16 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 		copy->cp_res.wr_bytes_written += bytes_copied;
 		src_pos += bytes_copied;
 		dst_pos += bytes_copied;
-	} while (bytes_total > 0 && !copy->cp_synchronous);
+	} while (bytes_total > 0 && nfsd4_copy_is_async(copy));
 	/* for a non-zero asynchronous copy do a commit of data */
-	if (!copy->cp_synchronous && copy->cp_res.wr_bytes_written > 0) {
+	if (nfsd4_copy_is_async(copy) && copy->cp_res.wr_bytes_written > 0) {
 		since = READ_ONCE(dst->f_wb_err);
 		status = vfs_fsync_range(dst, copy->cp_dst_pos,
 					 copy->cp_res.wr_bytes_written, 0);
 		if (!status)
 			status = filemap_check_wb_err(dst->f_mapping, since);
 		if (!status)
-			copy->committed = true;
+			set_bit(NFSD4_COPY_F_COMMITTED, &copy->cp_flags);
 	}
 	return bytes_copied;
 }
@@ -1728,7 +1715,7 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
 		status = nfs_ok;
 	}
 
-	if (!copy->cp_intra) /* Inter server SSC */
+	if (nfsd4_ssc_is_inter(copy))
 		nfsd4_cleanup_inter_ssc(copy->ss_mnt, copy->nf_src,
 					copy->nf_dst);
 	else
@@ -1742,13 +1729,13 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
 	dst->cp_src_pos = src->cp_src_pos;
 	dst->cp_dst_pos = src->cp_dst_pos;
 	dst->cp_count = src->cp_count;
-	dst->cp_synchronous = src->cp_synchronous;
+	dst->cp_flags = src->cp_flags;
 	memcpy(&dst->cp_res, &src->cp_res, sizeof(src->cp_res));
 	memcpy(&dst->fh, &src->fh, sizeof(src->fh));
 	dst->cp_clp = src->cp_clp;
 	dst->nf_dst = nfsd_file_get(src->nf_dst);
-	dst->cp_intra = src->cp_intra;
-	if (src->cp_intra) /* for inter, file_src doesn't exist yet */
+	/* for inter, nf_src doesn't exist yet */
+	if (!nfsd4_ssc_is_inter(src))
 		dst->nf_src = nfsd_file_get(src->nf_src);
 
 	memcpy(&dst->cp_stateid, &src->cp_stateid, sizeof(src->cp_stateid));
@@ -1762,7 +1749,7 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 {
 	nfs4_free_copy_state(copy);
 	nfsd_file_put(copy->nf_dst);
-	if (copy->cp_intra)
+	if (!nfsd4_ssc_is_inter(copy))
 		nfsd_file_put(copy->nf_src);
 	spin_lock(&copy->cp_clp->async_lock);
 	list_del(&copy->copies);
@@ -1775,7 +1762,7 @@ static int nfsd4_do_async_copy(void *data)
 	struct nfsd4_copy *copy = (struct nfsd4_copy *)data;
 	struct nfsd4_copy *cb_copy;
 
-	if (!copy->cp_intra) { /* Inter server SSC */
+	if (nfsd4_ssc_is_inter(copy)) {
 		copy->nf_src = kzalloc(sizeof(struct nfsd_file), GFP_KERNEL);
 		if (!copy->nf_src) {
 			copy->nfserr = nfserr_serverfault;
@@ -1807,7 +1794,7 @@ static int nfsd4_do_async_copy(void *data)
 			      &copy->fh, copy->cp_count, copy->nfserr);
 	nfsd4_run_cb(&cb_copy->cp_cb);
 out:
-	if (!copy->cp_intra)
+	if (nfsd4_ssc_is_inter(copy))
 		kfree(copy->nf_src);
 	cleanup_async_copy(copy);
 	return 0;
@@ -1821,8 +1808,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd4_copy *async_copy = NULL;
 
-	if (!copy->cp_intra) { /* Inter server SSC */
-		if (!inter_copy_offload_enable || copy->cp_synchronous) {
+	if (nfsd4_ssc_is_inter(copy)) {
+		if (!inter_copy_offload_enable || nfsd4_copy_is_sync(copy)) {
 			status = nfserr_notsupp;
 			goto out;
 		}
@@ -1839,7 +1826,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	copy->cp_clp = cstate->clp;
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
-	if (!copy->cp_synchronous) {
+	if (nfsd4_copy_is_async(copy)) {
 		struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
 		status = nfserrno(-ENOMEM);
@@ -2605,7 +2592,7 @@ check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
 				return;
 			}
 			putfh = (struct nfsd4_putfh *)&saved_op->u;
-			if (!copy->cp_intra)
+			if (nfsd4_ssc_is_inter(copy))
 				putfh->no_verify = true;
 		}
 	}
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 890f1009bd4ca..5476541530ead 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1896,8 +1896,8 @@ static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 static __be32
 nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 {
+	u32 consecutive, i, count, sync;
 	struct nl4_server *ns_dummy;
-	u32 consecutive, i, count;
 	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &copy->cp_src_stateid);
@@ -1915,17 +1915,17 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 	/* ca_consecutive: we always do consecutive copies */
 	if (xdr_stream_decode_u32(argp->xdr, &consecutive) < 0)
 		return nfserr_bad_xdr;
-	if (xdr_stream_decode_u32(argp->xdr, &copy->cp_synchronous) < 0)
+	if (xdr_stream_decode_bool(argp->xdr, &sync) < 0)
 		return nfserr_bad_xdr;
+	nfsd4_copy_set_sync(copy, sync);
 
 	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
 		return nfserr_bad_xdr;
 	copy->cp_src = svcxdr_tmpalloc(argp, sizeof(*copy->cp_src));
 	if (copy->cp_src == NULL)
 		return nfserr_jukebox;
-	copy->cp_intra = false;
 	if (count == 0) { /* intra-server copy */
-		copy->cp_intra = true;
+		__set_bit(NFSD4_COPY_F_INTRA, &copy->cp_flags);
 		return nfs_ok;
 	}
 
@@ -4712,13 +4712,13 @@ nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
 	__be32 *p;
 
 	nfserr = nfsd42_encode_write_res(resp, &copy->cp_res,
-					 !!copy->cp_synchronous);
+					 nfsd4_copy_is_sync(copy));
 	if (nfserr)
 		return nfserr;
 
 	p = xdr_reserve_space(resp->xdr, 4 + 4);
 	*p++ = xdr_one; /* cr_consecutive */
-	*p++ = cpu_to_be32(copy->cp_synchronous);
+	*p = nfsd4_copy_is_sync(copy) ? xdr_one : xdr_zero;
 	return 0;
 }
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 621937fae9acb..1f6ac92bcf856 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -541,10 +541,12 @@ struct nfsd4_copy {
 	u64			cp_dst_pos;
 	u64			cp_count;
 	struct nl4_server	*cp_src;
-	bool			cp_intra;
 
-	/* both */
-	u32			cp_synchronous;
+	unsigned long		cp_flags;
+#define NFSD4_COPY_F_STOPPED		(0)
+#define NFSD4_COPY_F_INTRA		(1)
+#define NFSD4_COPY_F_SYNCHRONOUS	(2)
+#define NFSD4_COPY_F_COMMITTED		(3)
 
 	/* response */
 	struct nfsd42_write_res	cp_res;
@@ -564,14 +566,35 @@ struct nfsd4_copy {
 	struct list_head	copies;
 	struct task_struct	*copy_task;
 	refcount_t		refcount;
-	bool			stopped;
 
 	struct vfsmount		*ss_mnt;
 	struct nfs_fh		c_fh;
 	nfs4_stateid		stateid;
-	bool			committed;
 };
 
+static inline void nfsd4_copy_set_sync(struct nfsd4_copy *copy, bool sync)
+{
+	if (sync)
+		set_bit(NFSD4_COPY_F_SYNCHRONOUS, &copy->cp_flags);
+	else
+		clear_bit(NFSD4_COPY_F_SYNCHRONOUS, &copy->cp_flags);
+}
+
+static inline bool nfsd4_copy_is_sync(const struct nfsd4_copy *copy)
+{
+	return test_bit(NFSD4_COPY_F_SYNCHRONOUS, &copy->cp_flags);
+}
+
+static inline bool nfsd4_copy_is_async(const struct nfsd4_copy *copy)
+{
+	return !test_bit(NFSD4_COPY_F_SYNCHRONOUS, &copy->cp_flags);
+}
+
+static inline bool nfsd4_ssc_is_inter(const struct nfsd4_copy *copy)
+{
+	return !test_bit(NFSD4_COPY_F_INTRA, &copy->cp_flags);
+}
+
 struct nfsd4_seek {
 	/* request */
 	stateid_t	seek_stateid;
-- 
2.43.0




