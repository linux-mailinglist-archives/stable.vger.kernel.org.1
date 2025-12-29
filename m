Return-Path: <stable+bounces-204131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D325CE820A
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 21:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B1F43016990
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 20:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DD8242D70;
	Mon, 29 Dec 2025 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cb6+eBu/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C41FF7C8
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767039705; cv=none; b=AciVUXuK2TIeeBnPkgmZsFdp2bIX3Q8X36C/zECyJaXvdCjZpAAiiaN78ynoWBDKALp44bLlOtVkshlxWMg/N2j420qEysF1gfsBDmJ5LjdS2tWPPkimhswNeh520sfX52w85KFllXlIwtBIbQt1R2RuTcBquOPCTiLLfF3gQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767039705; c=relaxed/simple;
	bh=F14w/lqk40fgUkFdJcrXHBQH5gRwrQD6Md3DIBdY82k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MU7nebpeMiJwpAPM1fE24l3K2e7jtz9gYH/+1H3wB/ug0d9I1B6UMUs68i2es8rq6LhsnC3JjbMEypN07RWXYlkN4C8Vt2JOzSx6wJgPCWS/sUlWcCrZEC8I2XZLn1VO+eaAuIN57qvZTRw1KbDmVDjxvmrUn2ilIbGRNY5VlaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cb6+eBu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB90C4CEF7;
	Mon, 29 Dec 2025 20:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767039705;
	bh=F14w/lqk40fgUkFdJcrXHBQH5gRwrQD6Md3DIBdY82k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cb6+eBu/HleGPnqvgmztEPf3u21dNb+yzpcDVL8DxW1z/Z7oVnxHmC3muPCwRHPBi
	 hkcPs0gn8PrKCgfYz6mCt05fd9caVWCOeUarE4TJ5JlVG+fkn57F7LzZDOd36qXskM
	 PRGM0V0K2Deg3oLR/bfqw3VCqVv3rTY8UuCsU40wZYr5P2dK3XqD4uPVvVvtgUYN/V
	 XFeLALUuhYUqBQeeDqboY5RcfGTMgnL07aVAF3xxIbGXdsTz6yz3pj7MK0/lBtPTPv
	 F+VCtV+j1X06f6dPXM6w7Rb/vE0uby06RyWLovC4+2Ic7dvdQwkwT+REdGVrJGnzWA
	 qzEwlaqTEYFwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junbeom Yeom <junbeom.yeom@samsung.com>,
	Jaewook Kim <jw5454.kim@samsung.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] erofs: fix unexpected EIO under memory pressure
Date: Mon, 29 Dec 2025 15:21:42 -0500
Message-ID: <20251229202143.1682446-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122916-blimp-ladle-4239@gregkh>
References: <2025122916-blimp-ladle-4239@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junbeom Yeom <junbeom.yeom@samsung.com>

[ Upstream commit 4012d78562193ef5eb613bad4b0c0fa187637cfe ]

erofs readahead could fail with ENOMEM under the memory pressure because
it tries to alloc_page with GFP_NOWAIT | GFP_NORETRY, while GFP_KERNEL
for a regular read. And if readahead fails (with non-uptodate folios),
the original request will then fall back to synchronous read, and
`.read_folio()` should return appropriate errnos.

However, in scenarios where readahead and read operations compete,
read operation could return an unintended EIO because of an incorrect
error propagation.

To resolve this, this patch modifies the behavior so that, when the
PCL is for read(which means pcl.besteffort is true), it attempts actual
decompression instead of propagating the privios error except initial EIO.

- Page size: 4K
- The original size of FileA: 16K
- Compress-ratio per PCL: 50% (Uncompressed 8K -> Compressed 4K)
[page0, page1] [page2, page3]
[PCL0]---------[PCL1]

- functions declaration:
  . pread(fd, buf, count, offset)
  . readahead(fd, offset, count)
- Thread A tries to read the last 4K
- Thread B tries to do readahead 8K from 4K
- RA, besteffort == false
- R, besteffort == true

        <process A>                   <process B>

pread(FileA, buf, 4K, 12K)
  do readahead(page3) // failed with ENOMEM
  wait_lock(page3)
    if (!uptodate(page3))
      goto do_read
                               readahead(FileA, 4K, 8K)
                               // Here create PCL-chain like below:
                               // [null, page1] [page2, null]
                               //   [PCL0:RA]-----[PCL1:RA]
...
  do read(page3)        // found [PCL1:RA] and add page3 into it,
                        // and then, change PCL1 from RA to R
...
                               // Now, PCL-chain is as below:
                               // [null, page1] [page2, page3]
                               //   [PCL0:RA]-----[PCL1:R]

                                 // try to decompress PCL-chain...
                                 z_erofs_decompress_queue
                                   err = 0;

                                   // failed with ENOMEM, so page 1
                                   // only for RA will not be uptodated.
                                   // it's okay.
                                   err = decompress([PCL0:RA], err)

                                   // However, ENOMEM propagated to next
                                   // PCL, even though PCL is not only
                                   // for RA but also for R. As a result,
                                   // it just failed with ENOMEM without
                                   // trying any decompression, so page2
                                   // and page3 will not be uptodated.
                ** BUG HERE ** --> err = decompress([PCL1:R], err)

                                   return err as ENOMEM
...
    wait_lock(page3)
      if (!uptodate(page3))
        return EIO      <-- Return an unexpected EIO!
...

Fixes: 2349d2fa02db ("erofs: sunset unneeded NOFAILs")
Cc: stable@vger.kernel.org
Reviewed-by: Jaewook Kim <jw5454.kim@samsung.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zdata.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 63acd91d15aa..7116f20a7fbe 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1244,14 +1244,14 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_backend *be, bool *overlapped)
 	return err;
 }
 
-static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
+static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, bool eio)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	const struct z_erofs_decompressor *decomp =
 				z_erofs_decomp[pcl->algorithmformat];
-	int i, j, jtop, err2;
+	int i, j, jtop, err2, err = eio ? -EIO : 0;
 	struct page *page;
 	bool overlapped;
 	bool try_free = true;
@@ -1381,12 +1381,12 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		.pcl = io->head,
 	};
 	struct z_erofs_pcluster *next;
-	int err = io->eio ? -EIO : 0;
+	int err = 0;
 
 	for (; be.pcl != Z_EROFS_PCLUSTER_TAIL; be.pcl = next) {
 		DBG_BUGON(!be.pcl);
 		next = READ_ONCE(be.pcl->next);
-		err = z_erofs_decompress_pcluster(&be, err) ?: err;
+		err = z_erofs_decompress_pcluster(&be, io->eio) ?: err;
 	}
 	return err;
 }
-- 
2.51.0


