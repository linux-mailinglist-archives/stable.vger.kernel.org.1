Return-Path: <stable+bounces-204123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAA2CE7F61
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 19:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3A9E3021FA6
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 18:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E8B3321C1;
	Mon, 29 Dec 2025 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL9dmHaj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5BB285CA9
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767034475; cv=none; b=dQ05hEpYM0mh48LkpDsVadch8PvPGkdR4waRjp3K24+DjO9gQQiBBmfMZBUocKChl0dp0N4ALv7Az3CRlTaDGt5etA+6iDmXGXUBvPw7FbgTiMnesj+7vTX/IIiw5sMMhlRdgBixl6GWAPUUF359yVuf81x/+aaEOZ3bpHmsNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767034475; c=relaxed/simple;
	bh=kLFVQ/OqEDKsbTjq/JibHHXBb3V2B4O4f6d0H8YcYUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R28Zyj/ocPmOJziCfBmprxmFNJxzl/dqQxXcfUtBD9KaYTlZHrvyD8M95fO//jKcVQoCy8EjIJ0tteVCeC13oZuh5yO5aQOZ5b0sF6jYF8yVm/A6cawEOkk85dGHsXn/MvGBoWOtMNLkIUNisFKVV7b0Iaof8KKvvxpN/q1xaJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL9dmHaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A397DC16AAE;
	Mon, 29 Dec 2025 18:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767034475;
	bh=kLFVQ/OqEDKsbTjq/JibHHXBb3V2B4O4f6d0H8YcYUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LL9dmHajlkPtuTG5syPvay+0mdCKxX6ALRp/ThMhmI0g6QmuKOR7UHE8++7zuXcXu
	 zbQr1TF15snrDVuBXkc9rMewCqhrDpoR4kcf2D1+nNVp2eEwr0k5kTbTEMJWWur5cF
	 DUmPFjvB6OcVJyExYztpw0PlUAN0utTFrk048SKFOqXQo6mHL66kSHfyjO+hFnYf28
	 7Y151G7Mb0QXK3Nkh86i7vdkVzt67EHdar5BHUt7NetPkDPQr5ds1QNBLPMDIRTvFV
	 8C5F4m1xhZoy5KlY7jOfwFrirkbCHi1Bv/sN0O9HFWjX8fibzNsTNbab7jYcHGuova
	 rfdH25mbdV4tQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junbeom Yeom <junbeom.yeom@samsung.com>,
	Jaewook Kim <jw5454.kim@samsung.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] erofs: fix unexpected EIO under memory pressure
Date: Mon, 29 Dec 2025 13:54:32 -0500
Message-ID: <20251229185432.1616355-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229185432.1616355-1-sashal@kernel.org>
References: <2025122915-kitchen-june-49ec@gregkh>
 <20251229185432.1616355-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zdata.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 461a929e0825..c23e0278c373 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1262,7 +1262,7 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_backend *be, bool *overlapped)
 	return err;
 }
 
-static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
+static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, bool eio)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
@@ -1270,7 +1270,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 	const struct z_erofs_decompressor *alg =
 				z_erofs_decomp[pcl->algorithmformat];
 	bool try_free = true;
-	int i, j, jtop, err2;
+	int i, j, jtop, err2, err = eio ? -EIO : 0;
 	struct page *page;
 	bool overlapped;
 	const char *reason;
@@ -1413,12 +1413,12 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
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


