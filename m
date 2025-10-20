Return-Path: <stable+bounces-188243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61218BF3751
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2BB18A6717
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 20:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3472D73A7;
	Mon, 20 Oct 2025 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSdjaavz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C34928489B
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992426; cv=none; b=X0Qj3nM1KKeMY2OeNjq32qMu8vBjlsIVi7njaKkpln/bIuvXskWxnuHTMmszDZ/tqppOyH4lmCrRD8GCSxufckSTQX01LxYGiq2myE5yOggaEEjZx4LGU9r12yMw5TpFipptur51YHa83uZgkSLF9/P6cAsYfPns+ugGtmb/jyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992426; c=relaxed/simple;
	bh=PPvRKpWCaQyKOprPK2IMrnNKSJPhN6Ay06ASWAsn+MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o89xze82IFf1Ot220dkn2+GMzql4a/uiziyBL32fxW0Ku9CMHObOpo91Y82Rd7CceN5A/UeGEpUBdibnxzHAe2Mab36hiDRmpcJ/4SDlh54bMkZUcLranHIJJ1tnzGv8WcOOvqsGN1W18ZZD+CQaifWFMSM1l08j0qcrd8JtEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSdjaavz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436BDC113D0;
	Mon, 20 Oct 2025 20:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760992425;
	bh=PPvRKpWCaQyKOprPK2IMrnNKSJPhN6Ay06ASWAsn+MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSdjaavzCHZ6vJ9gwCcFowKUJVD90NN3Crk9f2kfv/FmiZt3zGcMqc2I0m0DsMyR8
	 ORfJakdvQe/ON3uTFQD+k6CiaAxx3Epih8M80S9HgqMXBWJ/IFHJhA66Z+89MvYGx8
	 srXBnrBKSvBmMePR1FRxSQHuBsjAXSjA5edDh/vnCv/j/kPwAGarh/WwfIrBz7XR/n
	 I/2cPeBxoS2dCBaU95wiDAMCn3OUiLGZXUusrqkJn7urG84t5ET/uDN6A4IoCqh6xF
	 VwpU1xTFeCZJxATCoJlJoNBZB3C2DQFnSgiedBxx8D0JgamoJxfx84GDGaAQL0IWjx
	 yyutK7DgBtAJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] nfsd: Use correct error code when decoding extents
Date: Mon, 20 Oct 2025 16:33:39 -0400
Message-ID: <20251020203343.1907954-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102008-childlike-sneezing-5892@gregkh>
References: <2025102008-childlike-sneezing-5892@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Bashirov <sergeybashirov@gmail.com>

[ Upstream commit 26d05e1c37d276905bc921384b5a75158fca284b ]

Update error codes in decoding functions of block and scsi layout
drivers to match the core nfsd code. NFS4ERR_EINVAL means that the
server was able to decode the request, but the decoded values are
invalid. Use NFS4ERR_BADXDR instead to indicate a decoding error.
And ENOMEM is changed to nfs code NFS4ERR_DELAY.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 4b47a8601b71 ("NFSD: Define a proc_layoutcommit for the FlexFiles layout type")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/blocklayout.c    | 20 ++++++-----
 fs/nfsd/blocklayoutxdr.c | 71 +++++++++++++++++++++++++++++++---------
 fs/nfsd/blocklayoutxdr.h |  8 ++---
 fs/nfsd/nfsd.h           |  1 +
 4 files changed, 73 insertions(+), 27 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 08a20e5bcf7fe..19078a043e85c 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -178,11 +178,13 @@ nfsd4_block_proc_layoutcommit(struct inode *inode,
 {
 	struct iomap *iomaps;
 	int nr_iomaps;
+	__be32 nfserr;
 
-	nr_iomaps = nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
-			lcp->lc_up_len, &iomaps, i_blocksize(inode));
-	if (nr_iomaps < 0)
-		return nfserrno(nr_iomaps);
+	nfserr = nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
+			lcp->lc_up_len, &iomaps, &nr_iomaps,
+			i_blocksize(inode));
+	if (nfserr != nfs_ok)
+		return nfserr;
 
 	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
 }
@@ -316,11 +318,13 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
 {
 	struct iomap *iomaps;
 	int nr_iomaps;
+	__be32 nfserr;
 
-	nr_iomaps = nfsd4_scsi_decode_layoutupdate(lcp->lc_up_layout,
-			lcp->lc_up_len, &iomaps, i_blocksize(inode));
-	if (nr_iomaps < 0)
-		return nfserrno(nr_iomaps);
+	nfserr = nfsd4_scsi_decode_layoutupdate(lcp->lc_up_layout,
+			lcp->lc_up_len, &iomaps, &nr_iomaps,
+			i_blocksize(inode));
+	if (nfserr != nfs_ok)
+		return nfserr;
 
 	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
 }
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index ce78f74715eea..669ff8e6e966e 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -112,34 +112,54 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 	return 0;
 }
 
-int
+/**
+ * nfsd4_block_decode_layoutupdate - decode the block layout extent array
+ * @p: pointer to the xdr data
+ * @len: number of bytes to decode
+ * @iomapp: pointer to store the decoded extent array
+ * @nr_iomapsp: pointer to store the number of extents
+ * @block_size: alignment of extent offset and length
+ *
+ * This function decodes the opaque field of the layoutupdate4 structure
+ * in a layoutcommit request for the block layout driver. The field is
+ * actually an array of extents sent by the client. It also checks that
+ * the file offset, storage offset and length of each extent are aligned
+ * by @block_size.
+ *
+ * Return values:
+ *   %nfs_ok: Successful decoding, @iomapp and @nr_iomapsp are valid
+ *   %nfserr_bad_xdr: The encoded array in @p is invalid
+ *   %nfserr_inval: An unaligned extent found
+ *   %nfserr_delay: Failed to allocate memory for @iomapp
+ */
+__be32
 nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
-		u32 block_size)
+		int *nr_iomapsp, u32 block_size)
 {
 	struct iomap *iomaps;
 	u32 nr_iomaps, i;
 
 	if (len < sizeof(u32)) {
 		dprintk("%s: extent array too small: %u\n", __func__, len);
-		return -EINVAL;
+		return nfserr_bad_xdr;
 	}
 	len -= sizeof(u32);
 	if (len % PNFS_BLOCK_EXTENT_SIZE) {
 		dprintk("%s: extent array invalid: %u\n", __func__, len);
-		return -EINVAL;
+		return nfserr_bad_xdr;
 	}
 
 	nr_iomaps = be32_to_cpup(p++);
 	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE) {
 		dprintk("%s: extent array size mismatch: %u/%u\n",
 			__func__, len, nr_iomaps);
-		return -EINVAL;
+		return nfserr_bad_xdr;
 	}
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
 	if (!iomaps) {
 		dprintk("%s: failed to allocate extent array\n", __func__);
-		return -ENOMEM;
+		return nfserr_delay;
 	}
 
 	for (i = 0; i < nr_iomaps; i++) {
@@ -178,22 +198,42 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	}
 
 	*iomapp = iomaps;
-	return nr_iomaps;
+	*nr_iomapsp = nr_iomaps;
+	return nfs_ok;
 fail:
 	kfree(iomaps);
-	return -EINVAL;
+	return nfserr_inval;
 }
 
-int
+/**
+ * nfsd4_scsi_decode_layoutupdate - decode the scsi layout extent array
+ * @p: pointer to the xdr data
+ * @len: number of bytes to decode
+ * @iomapp: pointer to store the decoded extent array
+ * @nr_iomapsp: pointer to store the number of extents
+ * @block_size: alignment of extent offset and length
+ *
+ * This function decodes the opaque field of the layoutupdate4 structure
+ * in a layoutcommit request for the scsi layout driver. The field is
+ * actually an array of extents sent by the client. It also checks that
+ * the offset and length of each extent are aligned by @block_size.
+ *
+ * Return values:
+ *   %nfs_ok: Successful decoding, @iomapp and @nr_iomapsp are valid
+ *   %nfserr_bad_xdr: The encoded array in @p is invalid
+ *   %nfserr_inval: An unaligned extent found
+ *   %nfserr_delay: Failed to allocate memory for @iomapp
+ */
+__be32
 nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
-		u32 block_size)
+		int *nr_iomapsp, u32 block_size)
 {
 	struct iomap *iomaps;
 	u32 nr_iomaps, expected, i;
 
 	if (len < sizeof(u32)) {
 		dprintk("%s: extent array too small: %u\n", __func__, len);
-		return -EINVAL;
+		return nfserr_bad_xdr;
 	}
 
 	nr_iomaps = be32_to_cpup(p++);
@@ -201,13 +241,13 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	if (len != expected) {
 		dprintk("%s: extent array size mismatch: %u/%u\n",
 			__func__, len, expected);
-		return -EINVAL;
+		return nfserr_bad_xdr;
 	}
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
 	if (!iomaps) {
 		dprintk("%s: failed to allocate extent array\n", __func__);
-		return -ENOMEM;
+		return nfserr_delay;
 	}
 
 	for (i = 0; i < nr_iomaps; i++) {
@@ -229,8 +269,9 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	}
 
 	*iomapp = iomaps;
-	return nr_iomaps;
+	*nr_iomapsp = nr_iomaps;
+	return nfs_ok;
 fail:
 	kfree(iomaps);
-	return -EINVAL;
+	return nfserr_inval;
 }
diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
index 4e28ac8f11279..15b3569f3d9ad 100644
--- a/fs/nfsd/blocklayoutxdr.h
+++ b/fs/nfsd/blocklayoutxdr.h
@@ -54,9 +54,9 @@ __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 		const struct nfsd4_getdeviceinfo *gdp);
 __be32 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 		const struct nfsd4_layoutget *lgp);
-int nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
-		u32 block_size);
-int nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
-		u32 block_size);
+__be32 nfsd4_block_decode_layoutupdate(__be32 *p, u32 len,
+		struct iomap **iomapp, int *nr_iomapsp, u32 block_size);
+__be32 nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len,
+		struct iomap **iomapp, int *nr_iomapsp, u32 block_size);
 
 #endif /* _NFSD_BLOCKLAYOUTXDR_H */
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4b56ba1e8e48d..ae435444e8b3b 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -286,6 +286,7 @@ void		nfsd_lockd_shutdown(void);
 #define	nfserr_cb_path_down	cpu_to_be32(NFSERR_CB_PATH_DOWN)
 #define	nfserr_locked		cpu_to_be32(NFSERR_LOCKED)
 #define	nfserr_wrongsec		cpu_to_be32(NFSERR_WRONGSEC)
+#define nfserr_delay			cpu_to_be32(NFS4ERR_DELAY)
 #define nfserr_badiomode		cpu_to_be32(NFS4ERR_BADIOMODE)
 #define nfserr_badlayout		cpu_to_be32(NFS4ERR_BADLAYOUT)
 #define nfserr_bad_session_digest	cpu_to_be32(NFS4ERR_BAD_SESSION_DIGEST)
-- 
2.51.0


