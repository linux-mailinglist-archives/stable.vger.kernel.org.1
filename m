Return-Path: <stable+bounces-53513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B84E90D35A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 16:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310D3B21BF8
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E2E15920B;
	Tue, 18 Jun 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wnanlBMu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8913792B;
	Tue, 18 Jun 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716552; cv=none; b=mvfU4SPnYY4n2Umnkj2mfAkZPzQXCEnc9NpEceGfKktj9yTYmlAibCbacgQwoVIrAmYmkQRpzrmE/htKsMTPaX9+n1n1Y8S2ugV2vjLuTx0qFWwifEc9YUGR3pDAlP6ZzmrCIBvsY/2/A6SJkzFuCUCJRHryfz4dLUFexVFwSa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716552; c=relaxed/simple;
	bh=HAGjRGPRY7SiT3+A0IBb1oH1oVSCMyeZJvmurcOml/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hESGAyaN5fSH1H81wceWauutsHRGk8sqp7exqT/9EtRjEgX5yaMYKoQAnN0iWZ+M0u3AcO1HkqyRRStu6wy6c+XAJjuKUPsh1AzYfallua+q3BPyPQZPp41gxTDbmXVSSogENRrrmU9kF27Rp6UeKFRMn5l9t+e/6GrHRoOiU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wnanlBMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3204C3277B;
	Tue, 18 Jun 2024 13:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716552;
	bh=HAGjRGPRY7SiT3+A0IBb1oH1oVSCMyeZJvmurcOml/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wnanlBMuAG9pNh1EQQge+13Cet+aoS9JEy/ejrTWz2ET2CRK7r/EKam1DPDX4bYEw
	 0Q4PDjA+hv3KgXoPOPEBneAJ0vhaztMk/YIUdAePOZcuOnHhjk0nAkQDvU2ZsJc9EX
	 78QhjuJ4gV3XQW9gm9deXl69HJcJy9URm60Qw/jI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 682/770] NFSD: Simplify READ_PLUS
Date: Tue, 18 Jun 2024 14:38:55 +0200
Message-ID: <20240618123433.605399795@linuxfoundation.org>
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

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

[ Upstream commit eeadcb75794516839078c28b3730132aeb700ce6 ]

Chuck had suggested reverting READ_PLUS so it returns a single DATA
segment covering the requested read range. This prepares the server for
a future "sparse read" function so support can easily be added without
needing to rip out the old READ_PLUS code at the same time.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 139 +++++++++++-----------------------------------
 1 file changed, 32 insertions(+), 107 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index fc587381cd087..27b38ce6f8c6e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4775,79 +4775,37 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
-			    struct nfsd4_read *read,
-			    unsigned long *maxcount, u32 *eof,
-			    loff_t *pos)
+			    struct nfsd4_read *read)
 {
-	struct xdr_stream *xdr = resp->xdr;
+	bool splice_ok = test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
 	struct file *file = read->rd_nf->nf_file;
-	int starting_len = xdr->buf->len;
-	loff_t hole_pos;
-	__be32 nfserr;
-	__be32 *p, tmp;
-	__be64 tmp64;
-
-	hole_pos = pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_HOLE);
-	if (hole_pos > read->rd_offset)
-		*maxcount = min_t(unsigned long, *maxcount, hole_pos - read->rd_offset);
-	*maxcount = min_t(unsigned long, *maxcount, (xdr->buf->buflen - xdr->buf->len));
+	struct xdr_stream *xdr = resp->xdr;
+	unsigned long maxcount;
+	__be32 nfserr, *p;
 
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(xdr, 4 + 8 + 4);
 	if (!p)
-		return nfserr_resource;
+		return nfserr_io;
+	if (resp->xdr->buf->page_len && splice_ok) {
+		WARN_ON_ONCE(splice_ok);
+		return nfserr_serverfault;
+	}
 
-	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxcount);
-	if (read->rd_vlen < 0)
-		return nfserr_resource;
+	maxcount = min_t(unsigned long, read->rd_length,
+			 (xdr->buf->buflen - xdr->buf->len));
 
-	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
-			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
+	if (file->f_op->splice_read && splice_ok)
+		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
+	else
+		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
 	if (nfserr)
 		return nfserr;
-	xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxcount));
-
-	tmp = htonl(NFS4_CONTENT_DATA);
-	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
-	tmp64 = cpu_to_be64(read->rd_offset);
-	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
-	tmp = htonl(*maxcount);
-	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
-
-	tmp = xdr_zero;
-	write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 + *maxcount, &tmp,
-			       xdr_pad_size(*maxcount));
-	return nfs_ok;
-}
-
-static __be32
-nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
-			    struct nfsd4_read *read,
-			    unsigned long *maxcount, u32 *eof)
-{
-	struct file *file = read->rd_nf->nf_file;
-	loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
-	loff_t f_size = i_size_read(file_inode(file));
-	unsigned long count;
-	__be32 *p;
-
-	if (data_pos == -ENXIO)
-		data_pos = f_size;
-	else if (data_pos <= read->rd_offset || (data_pos < f_size && data_pos % PAGE_SIZE))
-		return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size);
-	count = data_pos - read->rd_offset;
 
-	/* Content type, offset, byte count */
-	p = xdr_reserve_space(resp->xdr, 4 + 8 + 8);
-	if (!p)
-		return nfserr_resource;
-
-	*p++ = htonl(NFS4_CONTENT_HOLE);
+	*p++ = cpu_to_be32(NFS4_CONTENT_DATA);
 	p = xdr_encode_hyper(p, read->rd_offset);
-	p = xdr_encode_hyper(p, count);
+	*p = cpu_to_be32(read->rd_length);
 
-	*eof = (read->rd_offset + count) >= f_size;
-	*maxcount = min_t(unsigned long, count, *maxcount);
 	return nfs_ok;
 }
 
@@ -4855,69 +4813,36 @@ static __be32
 nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		       struct nfsd4_read *read)
 {
-	unsigned long maxcount, count;
+	struct file *file = read->rd_nf->nf_file;
 	struct xdr_stream *xdr = resp->xdr;
-	struct file *file;
 	int starting_len = xdr->buf->len;
-	int last_segment = xdr->buf->len;
-	int segments = 0;
-	__be32 *p, tmp;
-	bool is_data;
-	loff_t pos;
-	u32 eof;
+	u32 segments = 0;
+	__be32 *p;
 
 	if (nfserr)
 		return nfserr;
-	file = read->rd_nf->nf_file;
 
 	/* eof flag, segment count */
 	p = xdr_reserve_space(xdr, 4 + 4);
 	if (!p)
-		return nfserr_resource;
+		return nfserr_io;
 	xdr_commit_encode(xdr);
 
-	maxcount = min_t(unsigned long, read->rd_length,
-			 (xdr->buf->buflen - xdr->buf->len));
-	count    = maxcount;
-
-	eof = read->rd_offset >= i_size_read(file_inode(file));
-	if (eof)
+	read->rd_eof = read->rd_offset >= i_size_read(file_inode(file));
+	if (read->rd_eof)
 		goto out;
 
-	pos = vfs_llseek(file, read->rd_offset, SEEK_HOLE);
-	is_data = pos > read->rd_offset;
-
-	while (count > 0 && !eof) {
-		maxcount = count;
-		if (is_data)
-			nfserr = nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof,
-						segments == 0 ? &pos : NULL);
-		else
-			nfserr = nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
-		if (nfserr)
-			goto out;
-		count -= maxcount;
-		read->rd_offset += maxcount;
-		is_data = !is_data;
-		last_segment = xdr->buf->len;
-		segments++;
-	}
-
-out:
-	if (nfserr && segments == 0)
+	nfserr = nfsd4_encode_read_plus_data(resp, read);
+	if (nfserr) {
 		xdr_truncate_encode(xdr, starting_len);
-	else {
-		if (nfserr) {
-			xdr_truncate_encode(xdr, last_segment);
-			nfserr = nfs_ok;
-			eof = 0;
-		}
-		tmp = htonl(eof);
-		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
-		tmp = htonl(segments);
-		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
+		return nfserr;
 	}
 
+	segments++;
+
+out:
+	p = xdr_encode_bool(p, read->rd_eof);
+	*p = cpu_to_be32(segments);
 	return nfserr;
 }
 
-- 
2.43.0




