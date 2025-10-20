Return-Path: <stable+bounces-188066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB345BF159A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64C544EE87E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C9D3126B1;
	Mon, 20 Oct 2025 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UutrRwnU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD22304BA6
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964790; cv=none; b=EIcGyCfFzLsYDjUWBX8RtG9j/yQLX+OYwRBO/kPB+LSbLpW4SAHd5uTN6K9AmPLCOSgT7fnDWbyEgpJp+vZBZ9/0JYDaS+sz3n5YowVyy7jb8ZAZ9Oacr7whcZUqTo9AvbVrlzAvb0D1ljFNHLQBwR9NAmA61KkPRQPmBML3OVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964790; c=relaxed/simple;
	bh=PkTJ9D5bO+LtN4EEsPcGKaKArw2JM536vT1EqcygGuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzmRPJQK3dCtJleQZ+GRBlw97ltlUtoSiS67MTeDtctYhs5DcYbEXcymReUT7dpCMZltLL3CvA/CoPw6B2THVCru2F/ekbvoFgT+kL8LKuaXmkktYpYn0KLFes4HvTXvnfhpxVfNXWLh1qp2zoYCM7SrNKyap2HdRvmsgyrgM/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UutrRwnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F02C113D0;
	Mon, 20 Oct 2025 12:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964789;
	bh=PkTJ9D5bO+LtN4EEsPcGKaKArw2JM536vT1EqcygGuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UutrRwnUBJmBPS9nyVEyte6FMLl+saHkqTfiiKNZl+b0chP86DPlsiSeHRKkIYXfx
	 DCxrOiRMGrxkui874hUn9yn9mM6pu6mlMveGaESKeMxwMbcS/tbO0lrBM7BcKxDkl7
	 fXWQ0bDSVUIUpZf10+YIeFoq5uebvfDIgC5n5IZKMzFNoCwjjNxBZLTZJbGv3X88ma
	 jU6o+4yp+SMliEzJQnEER/+9EguUCm+NmDxeD4LemrYrUNqSF0kwTM33ForR6y+6/V
	 LDh9YftYm70zdOZBmhtP6HMpWFaJKbqzkklfAFG+K6d376CVJnQ9nm+kvusRbyv+q3
	 FI14auNfVG4TQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/7] nfsd: Drop dprintk in blocklayout xdr functions
Date: Mon, 20 Oct 2025 08:53:00 -0400
Message-ID: <20251020125305.1760219-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020125305.1760219-1-sashal@kernel.org>
References: <2025101657-preseason-garnish-c1e0@gregkh>
 <20251020125305.1760219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Bashirov <sergeybashirov@gmail.com>

[ Upstream commit e339967eecf1305557f7c697e1bc10b5cc495454 ]

Minor clean up. Instead of dprintk there are appropriate error codes.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: d68886bae76a ("NFSD: Fix last write offset handling in layoutcommit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/blocklayoutxdr.c | 40 +++++++---------------------------------
 1 file changed, 7 insertions(+), 33 deletions(-)

diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 669ff8e6e966e..bcf21fde91207 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -139,28 +139,19 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	struct iomap *iomaps;
 	u32 nr_iomaps, i;
 
-	if (len < sizeof(u32)) {
-		dprintk("%s: extent array too small: %u\n", __func__, len);
+	if (len < sizeof(u32))
 		return nfserr_bad_xdr;
-	}
 	len -= sizeof(u32);
-	if (len % PNFS_BLOCK_EXTENT_SIZE) {
-		dprintk("%s: extent array invalid: %u\n", __func__, len);
+	if (len % PNFS_BLOCK_EXTENT_SIZE)
 		return nfserr_bad_xdr;
-	}
 
 	nr_iomaps = be32_to_cpup(p++);
-	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE) {
-		dprintk("%s: extent array size mismatch: %u/%u\n",
-			__func__, len, nr_iomaps);
+	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE)
 		return nfserr_bad_xdr;
-	}
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
-	if (!iomaps) {
-		dprintk("%s: failed to allocate extent array\n", __func__);
+	if (!iomaps)
 		return nfserr_delay;
-	}
 
 	for (i = 0; i < nr_iomaps; i++) {
 		struct pnfs_block_extent bex;
@@ -170,26 +161,18 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 
 		p = xdr_decode_hyper(p, &bex.foff);
 		if (bex.foff & (block_size - 1)) {
-			dprintk("%s: unaligned offset 0x%llx\n",
-				__func__, bex.foff);
 			goto fail;
 		}
 		p = xdr_decode_hyper(p, &bex.len);
 		if (bex.len & (block_size - 1)) {
-			dprintk("%s: unaligned length 0x%llx\n",
-				__func__, bex.foff);
 			goto fail;
 		}
 		p = xdr_decode_hyper(p, &bex.soff);
 		if (bex.soff & (block_size - 1)) {
-			dprintk("%s: unaligned disk offset 0x%llx\n",
-				__func__, bex.soff);
 			goto fail;
 		}
 		bex.es = be32_to_cpup(p++);
 		if (bex.es != PNFS_BLOCK_READWRITE_DATA) {
-			dprintk("%s: incorrect extent state %d\n",
-				__func__, bex.es);
 			goto fail;
 		}
 
@@ -231,38 +214,29 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	struct iomap *iomaps;
 	u32 nr_iomaps, expected, i;
 
-	if (len < sizeof(u32)) {
-		dprintk("%s: extent array too small: %u\n", __func__, len);
+	if (len < sizeof(u32))
 		return nfserr_bad_xdr;
-	}
 
 	nr_iomaps = be32_to_cpup(p++);
 	expected = sizeof(__be32) + nr_iomaps * PNFS_SCSI_RANGE_SIZE;
-	if (len != expected) {
-		dprintk("%s: extent array size mismatch: %u/%u\n",
-			__func__, len, expected);
+	if (len != expected)
 		return nfserr_bad_xdr;
-	}
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
-	if (!iomaps) {
-		dprintk("%s: failed to allocate extent array\n", __func__);
+	if (!iomaps)
 		return nfserr_delay;
-	}
 
 	for (i = 0; i < nr_iomaps; i++) {
 		u64 val;
 
 		p = xdr_decode_hyper(p, &val);
 		if (val & (block_size - 1)) {
-			dprintk("%s: unaligned offset 0x%llx\n", __func__, val);
 			goto fail;
 		}
 		iomaps[i].offset = val;
 
 		p = xdr_decode_hyper(p, &val);
 		if (val & (block_size - 1)) {
-			dprintk("%s: unaligned length 0x%llx\n", __func__, val);
 			goto fail;
 		}
 		iomaps[i].length = val;
-- 
2.51.0


