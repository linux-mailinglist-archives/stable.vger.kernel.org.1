Return-Path: <stable+bounces-188063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A7BBF1582
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BE4E34CEC2
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A46313523;
	Mon, 20 Oct 2025 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPSPNgYk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2BA3126A9
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964751; cv=none; b=SW4y5C7fiDhLmlBifol5jegHHVeJudzhJYBJ0vYTQp7ja+RFmceVLSeBYMZi2x7ItXVECAqh6fQWo/xFN59ayxmqlY1pi8edvxboZTLjnpL/wdeHauzwPtFSpZUZ46RllamhBfmHGHC5rtblvwMlAZ190WME8nlXUJ4wYge+vzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964751; c=relaxed/simple;
	bh=KSGHOUFcxrX15twiHD6xcIK2oosEteo/jhbKi3kVw9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TL4vykElUjtV4vxz9dsa5aR+56iceXZLDfDdTfY5d5vFNRTkSmQbl3Y23E5TW0oMfK7ddEXOVFJT6L9yvv3b9eLnD37eMqeLz4MqrKCuup7ZWS/T55BoEb0lB6ZL1gWLwtLsNiM5tAVyGBZiSHHNr94tpWgGzqgsVbam3VHfnzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPSPNgYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A45EC116D0;
	Mon, 20 Oct 2025 12:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964751;
	bh=KSGHOUFcxrX15twiHD6xcIK2oosEteo/jhbKi3kVw9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RPSPNgYkEfl6Zd23FVSUiU1+OSwwUH0/gIQ7Jk0BixLOglIzkTp7v92EFoLMu/Rmb
	 sPqPnlkeahw0flh2whtn8ftYLwjMF1d/aSC2eqmh2aHgtBA1OsvZbbxF84uIRT21aB
	 iFR1+f8voLTjHkf3hYBo5nngH6+xr5V2FRTFMyqe6nc/8fN3IYYQDl3LtdtlWgTw55
	 wqN16bPfYPA1l8zI08+H9Te0X6y6Nj9Tw5keErW9yC1kGPskYIdCw+kAdx6mL6+inC
	 Zvge0WZv6qJMlMfA2x7THdK4zdS1VJfEqj1Y4l4lpljvnrq3HlPp8xys8Rk8iVbMly
	 DGcHOfGgiUzyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 3/4] NFSD: Implement large extent array support in pNFS
Date: Mon, 20 Oct 2025 08:52:24 -0400
Message-ID: <20251020125226.1759978-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020125226.1759978-1-sashal@kernel.org>
References: <2025101656-unfrosted-rasping-f7dc@gregkh>
 <20251020125226.1759978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Bashirov <sergeybashirov@gmail.com>

[ Upstream commit f963cf2b91a30b5614c514f3ad53ca124cb65280 ]

When pNFS client in the block or scsi layout mode sends layoutcommit
to MDS, a variable length array of modified extents is supplied within
the request. This patch allows the server to accept such extent arrays
if they do not fit within single memory page.

The issue can be reproduced when writing to a 1GB file using FIO with
O_DIRECT, 4K block and large I/O depth without preallocation of the
file. In this case, the server returns NFSERR_BADXDR to the client.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: d68886bae76a ("NFSD: Fix last write offset handling in layoutcommit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/blocklayout.c    | 20 ++++++----
 fs/nfsd/blocklayoutxdr.c | 83 +++++++++++++++++++++++++++-------------
 fs/nfsd/blocklayoutxdr.h |  4 +-
 fs/nfsd/nfs4proc.c       |  2 +-
 fs/nfsd/nfs4xdr.c        | 11 +++---
 fs/nfsd/pnfs.h           |  1 +
 fs/nfsd/xdr4.h           |  3 +-
 7 files changed, 78 insertions(+), 46 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 19078a043e85c..4c936132eb440 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -173,16 +173,18 @@ nfsd4_block_proc_getdeviceinfo(struct super_block *sb,
 }
 
 static __be32
-nfsd4_block_proc_layoutcommit(struct inode *inode,
+nfsd4_block_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
 		struct nfsd4_layoutcommit *lcp)
 {
 	struct iomap *iomaps;
 	int nr_iomaps;
 	__be32 nfserr;
 
-	nfserr = nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
-			lcp->lc_up_len, &iomaps, &nr_iomaps,
-			i_blocksize(inode));
+	rqstp->rq_arg = lcp->lc_up_layout;
+	svcxdr_init_decode(rqstp);
+
+	nfserr = nfsd4_block_decode_layoutupdate(&rqstp->rq_arg_stream,
+			&iomaps, &nr_iomaps, i_blocksize(inode));
 	if (nfserr != nfs_ok)
 		return nfserr;
 
@@ -313,16 +315,18 @@ nfsd4_scsi_proc_getdeviceinfo(struct super_block *sb,
 	return nfserrno(nfsd4_block_get_device_info_scsi(sb, clp, gdp));
 }
 static __be32
-nfsd4_scsi_proc_layoutcommit(struct inode *inode,
+nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
 		struct nfsd4_layoutcommit *lcp)
 {
 	struct iomap *iomaps;
 	int nr_iomaps;
 	__be32 nfserr;
 
-	nfserr = nfsd4_scsi_decode_layoutupdate(lcp->lc_up_layout,
-			lcp->lc_up_len, &iomaps, &nr_iomaps,
-			i_blocksize(inode));
+	rqstp->rq_arg = lcp->lc_up_layout;
+	svcxdr_init_decode(rqstp);
+
+	nfserr = nfsd4_scsi_decode_layoutupdate(&rqstp->rq_arg_stream,
+			&iomaps, &nr_iomaps, i_blocksize(inode));
 	if (nfserr != nfs_ok)
 		return nfserr;
 
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 18de37ff28916..e50afe3407371 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -113,8 +113,7 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 
 /**
  * nfsd4_block_decode_layoutupdate - decode the block layout extent array
- * @p: pointer to the xdr data
- * @len: number of bytes to decode
+ * @xdr: subbuf set to the encoded array
  * @iomapp: pointer to store the decoded extent array
  * @nr_iomapsp: pointer to store the number of extents
  * @block_size: alignment of extent offset and length
@@ -127,25 +126,24 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
  *
  * Return values:
  *   %nfs_ok: Successful decoding, @iomapp and @nr_iomapsp are valid
- *   %nfserr_bad_xdr: The encoded array in @p is invalid
+ *   %nfserr_bad_xdr: The encoded array in @xdr is invalid
  *   %nfserr_inval: An unaligned extent found
  *   %nfserr_delay: Failed to allocate memory for @iomapp
  */
 __be32
-nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
+nfsd4_block_decode_layoutupdate(struct xdr_stream *xdr, struct iomap **iomapp,
 		int *nr_iomapsp, u32 block_size)
 {
 	struct iomap *iomaps;
-	u32 nr_iomaps, i;
+	u32 nr_iomaps, expected, len, i;
+	__be32 nfserr;
 
-	if (len < sizeof(u32))
-		return nfserr_bad_xdr;
-	len -= sizeof(u32);
-	if (len % PNFS_BLOCK_EXTENT_SIZE)
+	if (xdr_stream_decode_u32(xdr, &nr_iomaps))
 		return nfserr_bad_xdr;
 
-	nr_iomaps = be32_to_cpup(p++);
-	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE)
+	len = sizeof(__be32) + xdr_stream_remaining(xdr);
+	expected = sizeof(__be32) + nr_iomaps * PNFS_BLOCK_EXTENT_SIZE;
+	if (len != expected)
 		return nfserr_bad_xdr;
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
@@ -155,21 +153,44 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	for (i = 0; i < nr_iomaps; i++) {
 		struct pnfs_block_extent bex;
 
-		p = svcxdr_decode_deviceid4(p, &bex.vol_id);
-		p = xdr_decode_hyper(p, &bex.foff);
+		if (nfsd4_decode_deviceid4(xdr, &bex.vol_id)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
+
+		if (xdr_stream_decode_u64(xdr, &bex.foff)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
 		if (bex.foff & (block_size - 1)) {
+			nfserr = nfserr_inval;
+			goto fail;
+		}
+
+		if (xdr_stream_decode_u64(xdr, &bex.len)) {
+			nfserr = nfserr_bad_xdr;
 			goto fail;
 		}
-		p = xdr_decode_hyper(p, &bex.len);
 		if (bex.len & (block_size - 1)) {
+			nfserr = nfserr_inval;
+			goto fail;
+		}
+
+		if (xdr_stream_decode_u64(xdr, &bex.soff)) {
+			nfserr = nfserr_bad_xdr;
 			goto fail;
 		}
-		p = xdr_decode_hyper(p, &bex.soff);
 		if (bex.soff & (block_size - 1)) {
+			nfserr = nfserr_inval;
+			goto fail;
+		}
+
+		if (xdr_stream_decode_u32(xdr, &bex.es)) {
+			nfserr = nfserr_bad_xdr;
 			goto fail;
 		}
-		bex.es = be32_to_cpup(p++);
 		if (bex.es != PNFS_BLOCK_READWRITE_DATA) {
+			nfserr = nfserr_inval;
 			goto fail;
 		}
 
@@ -182,13 +203,12 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	return nfs_ok;
 fail:
 	kfree(iomaps);
-	return nfserr_inval;
+	return nfserr;
 }
 
 /**
  * nfsd4_scsi_decode_layoutupdate - decode the scsi layout extent array
- * @p: pointer to the xdr data
- * @len: number of bytes to decode
+ * @xdr: subbuf set to the encoded array
  * @iomapp: pointer to store the decoded extent array
  * @nr_iomapsp: pointer to store the number of extents
  * @block_size: alignment of extent offset and length
@@ -200,21 +220,22 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
  *
  * Return values:
  *   %nfs_ok: Successful decoding, @iomapp and @nr_iomapsp are valid
- *   %nfserr_bad_xdr: The encoded array in @p is invalid
+ *   %nfserr_bad_xdr: The encoded array in @xdr is invalid
  *   %nfserr_inval: An unaligned extent found
  *   %nfserr_delay: Failed to allocate memory for @iomapp
  */
 __be32
-nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
+nfsd4_scsi_decode_layoutupdate(struct xdr_stream *xdr, struct iomap **iomapp,
 		int *nr_iomapsp, u32 block_size)
 {
 	struct iomap *iomaps;
-	u32 nr_iomaps, expected, i;
+	u32 nr_iomaps, expected, len, i;
+	__be32 nfserr;
 
-	if (len < sizeof(u32))
+	if (xdr_stream_decode_u32(xdr, &nr_iomaps))
 		return nfserr_bad_xdr;
 
-	nr_iomaps = be32_to_cpup(p++);
+	len = sizeof(__be32) + xdr_stream_remaining(xdr);
 	expected = sizeof(__be32) + nr_iomaps * PNFS_SCSI_RANGE_SIZE;
 	if (len != expected)
 		return nfserr_bad_xdr;
@@ -226,14 +247,22 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	for (i = 0; i < nr_iomaps; i++) {
 		u64 val;
 
-		p = xdr_decode_hyper(p, &val);
+		if (xdr_stream_decode_u64(xdr, &val)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
 		if (val & (block_size - 1)) {
+			nfserr = nfserr_inval;
 			goto fail;
 		}
 		iomaps[i].offset = val;
 
-		p = xdr_decode_hyper(p, &val);
+		if (xdr_stream_decode_u64(xdr, &val)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
 		if (val & (block_size - 1)) {
+			nfserr = nfserr_inval;
 			goto fail;
 		}
 		iomaps[i].length = val;
@@ -244,5 +273,5 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	return nfs_ok;
 fail:
 	kfree(iomaps);
-	return nfserr_inval;
+	return nfserr;
 }
diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
index 15b3569f3d9ad..7d25ef689671f 100644
--- a/fs/nfsd/blocklayoutxdr.h
+++ b/fs/nfsd/blocklayoutxdr.h
@@ -54,9 +54,9 @@ __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 		const struct nfsd4_getdeviceinfo *gdp);
 __be32 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 		const struct nfsd4_layoutget *lgp);
-__be32 nfsd4_block_decode_layoutupdate(__be32 *p, u32 len,
+__be32 nfsd4_block_decode_layoutupdate(struct xdr_stream *xdr,
 		struct iomap **iomapp, int *nr_iomapsp, u32 block_size);
-__be32 nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len,
+__be32 nfsd4_scsi_decode_layoutupdate(struct xdr_stream *xdr,
 		struct iomap **iomapp, int *nr_iomapsp, u32 block_size);
 
 #endif /* _NFSD_BLOCKLAYOUTXDR_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 24f24047d3869..76b2703a23b28 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2549,7 +2549,7 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 		lcp->lc_size_chg = false;
 	}
 
-	nfserr = ops->proc_layoutcommit(inode, lcp);
+	nfserr = ops->proc_layoutcommit(inode, rqstp, lcp);
 	nfs4_put_stid(&ls->ls_stid);
 out:
 	return nfserr;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7df4d5aed6647..89cc970effbce 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -593,6 +593,8 @@ static __be32
 nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
 			   struct nfsd4_layoutcommit *lcp)
 {
+	u32 len;
+
 	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_layout_type) < 0)
 		return nfserr_bad_xdr;
 	if (lcp->lc_layout_type < LAYOUT_NFSV4_1_FILES)
@@ -600,13 +602,10 @@ nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
 	if (lcp->lc_layout_type >= LAYOUT_TYPE_MAX)
 		return nfserr_bad_xdr;
 
-	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_up_len) < 0)
+	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
+		return nfserr_bad_xdr;
+	if (!xdr_stream_subsegment(argp->xdr, &lcp->lc_up_layout, len))
 		return nfserr_bad_xdr;
-	if (lcp->lc_up_len > 0) {
-		lcp->lc_up_layout = xdr_inline_decode(argp->xdr, lcp->lc_up_len);
-		if (!lcp->lc_up_layout)
-			return nfserr_bad_xdr;
-	}
 
 	return nfs_ok;
 }
diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
index 925817f669176..dfd411d1f363f 100644
--- a/fs/nfsd/pnfs.h
+++ b/fs/nfsd/pnfs.h
@@ -35,6 +35,7 @@ struct nfsd4_layout_ops {
 			const struct nfsd4_layoutget *lgp);
 
 	__be32 (*proc_layoutcommit)(struct inode *inode,
+			struct svc_rqst *rqstp,
 			struct nfsd4_layoutcommit *lcp);
 
 	void (*fence_client)(struct nfs4_layout_stateid *ls,
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index e65b552bf5f5a..d4b48602b2b0c 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -664,8 +664,7 @@ struct nfsd4_layoutcommit {
 	u64			lc_last_wr;	/* request */
 	struct timespec64	lc_mtime;	/* request */
 	u32			lc_layout_type;	/* request */
-	u32			lc_up_len;	/* layout length */
-	void			*lc_up_layout;	/* decoded by callback */
+	struct xdr_buf		lc_up_layout;	/* decoded by callback */
 	bool			lc_size_chg;	/* response */
 	u64			lc_newsize;	/* response */
 };
-- 
2.51.0


