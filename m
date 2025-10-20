Return-Path: <stable+bounces-188065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 656DFBF15B1
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB90A34D25A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFE83FFD;
	Mon, 20 Oct 2025 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOsRlMFw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A38231C9F
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964788; cv=none; b=D/iwcawDcagctII6jevqgj3aWsVGyMkUn7dNRpJjdBUGDsdIWu5cOT0QNxQqeru/aTwIEPq+gsPbsIUhUS9gWOVyxFagGYlmrPXpKHpFiiDT6bAbxd+0Gb0sWtRJ02mOH83FpCNsRWX6fgFlcD5I5RzwuD6gcqMLYYZtMZ6ldXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964788; c=relaxed/simple;
	bh=UnwEhKAXGlPCl9Mk+7YuKv9OAo9opaNXI8kPLrfDXZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inJW7A0rAHroRqZjDAr1zVNUhYUcpWOEvFpj979xvX/0+phCi+fFPjQt498slqXMeiK7rv3OYvJ2AX865oYwqzvZqU0vW4XpQA98ERC/dr0o1V8KQEauJ5DaWYh/7q3vKLaJY4zMBI81Xfq6LaQ6XlrvgTsqKhrDMloayUFIb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOsRlMFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74AAC4CEF9;
	Mon, 20 Oct 2025 12:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964788;
	bh=UnwEhKAXGlPCl9Mk+7YuKv9OAo9opaNXI8kPLrfDXZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOsRlMFwQ2qtx1EDXUANF4t7qROn8WmHRox18njjeb6EKhq28meSH9i4qoZz2JeJO
	 zCUuEBwygvAXrDTTpTIvnKtRhR3Tx1HBRvoIlwsqErYuXl5ctlzwfbXXB9PHlDi2Ry
	 WFgtiBM5lanppGnYoJVV75nweBczLYhMpPOI5gLLmyZZO+/+6sUcImqtE3YRnf0f25
	 0NSniq6TXdHb19ZFyTMXdvtXxKX7csrKnSiCTEYc8jL7J5uZQlwCYRq9xRbysr51hd
	 pIU0SROWAhyzBjlUtpSV5OGbz0jPqSg4gs15o8qTqDyW0SGzMDvHCra/mXbZrn5Ep2
	 pqxh1Bf4J7WOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/7] nfsd: Use correct error code when decoding extents
Date: Mon, 20 Oct 2025 08:52:59 -0400
Message-ID: <20251020125305.1760219-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101657-preseason-garnish-c1e0@gregkh>
References: <2025101657-preseason-garnish-c1e0@gregkh>
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
Stable-dep-of: d68886bae76a ("NFSD: Fix last write offset handling in layoutcommit")
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


