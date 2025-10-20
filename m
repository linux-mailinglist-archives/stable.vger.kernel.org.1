Return-Path: <stable+bounces-188244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1E7BF3754
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EDD64F03E3
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 20:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7368F2DA742;
	Mon, 20 Oct 2025 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwG/F+oT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C212D8DA6
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992428; cv=none; b=ZJ9U/xnWv1UoAIoHP/sCIXpPi1XvN3aBf/VS2kNdTs65R+ESfXrpIlMrftOXHWH1iVPsj1hd8lMiddf213Zbx3IAzbWRbTILMIr+4BW4i0q3Al31bmDv7D372F8OHUzEwSAw9uBcnGQBar8YrU7UjYzHI3OaLSJgeOhe2ODxHIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992428; c=relaxed/simple;
	bh=mByV+Nrzy52+vuSuGBZJVaZKx9nJywSiRB2NNaj41dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i36MmFyEoWEdkLWLrrmaj9TWNdEWJGSCafwKPaIeuL05LubJNX9Ns/Dli7YQ7O8QTZnqOCv/gJOM4ymO4YXqUjqAejFxFTjyvmsk1ugXPjhSuUbPDQLK8VDqIzoV3S/ZBPDht4Gqa0XuqgGqyfCkV2IYr6wHpCeLIdm877sSs4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwG/F+oT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355B1C116D0;
	Mon, 20 Oct 2025 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760992426;
	bh=mByV+Nrzy52+vuSuGBZJVaZKx9nJywSiRB2NNaj41dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwG/F+oTDzLmP9VgjnjdTFxzBc9MDEIN52m3e+53GeXnheJGY4Xy8R+SM/ibwgGFm
	 Co3kge/vtY20/9H9OsaIBE7NwGbqpQjPVs6wn7Ou8w+ekEoqM2cJZcs8IgvJgCi7gs
	 lPnGdvcFvm5UAtw4la1G58PoygAD+rz4z+J7jsgY19jVzTYT3AW/JMVmwVKMpK4UHA
	 b4JMh3+ivtuvqBtz1wXHSzVHfsEEnIxrVygjxOjNdJsTysNr4JUbfTJ3uiUgAsEQz9
	 vAPDLVo1Iqwy6x85qPUk7viBvyNqmXuRX8iTUeTAkjE94OYbyuoW4+B/cqjBzI1emQ
	 TT9nTfZlHziSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] nfsd: Drop dprintk in blocklayout xdr functions
Date: Mon, 20 Oct 2025 16:33:40 -0400
Message-ID: <20251020203343.1907954-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020203343.1907954-1-sashal@kernel.org>
References: <2025102008-childlike-sneezing-5892@gregkh>
 <20251020203343.1907954-1-sashal@kernel.org>
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
Stable-dep-of: 4b47a8601b71 ("NFSD: Define a proc_layoutcommit for the FlexFiles layout type")
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


