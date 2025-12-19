Return-Path: <stable+bounces-203083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BC3CCFDA1
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 13:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63E9C3016DCF
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 12:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B5320382;
	Fri, 19 Dec 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uP1LZs4W"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59C1DB54C
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766148056; cv=none; b=gMijoTjXS8EoH4K1qCIZ9Itnohcu3ZQcK2xeAiTtMX0O5maB2Qzf3+tqRS3BiZEN10xv2ZFhhHSvJTm5JwEiQod4nOayyu993z+VlHM6BVvm7lj9bPbDnUTT5ZkAS6FxL1ABV8tzhT6gPhcnCF2U9mlurGRnUFULbIbn43+vK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766148056; c=relaxed/simple;
	bh=9Lbjg60mV6ELzUjAeBc1k0iW0FLYQFX11lyiNpWJAv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=EbpH6qZX4uLnJaat/qRTx52AnDyfxrXzgkJO21Uh4mZ8ZNiaD2ZR9XXaYKNVdeDJU0s8LxPDDh1b4TPc44K0z13lJT6o5j94oP2WQje81TURCNMpm94fzYtlRPDg97gS+pxH466QoJZmnNQrs+PlwURfrM5bK4wIpDYSlqrcIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uP1LZs4W; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251219124045epoutp0318babeed2b1e1f2b8c7b2e9d4d9b2bc5~Cnko-lxqX1357213572epoutp03c
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 12:40:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251219124045epoutp0318babeed2b1e1f2b8c7b2e9d4d9b2bc5~Cnko-lxqX1357213572epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766148045;
	bh=jMDcKQ9i6N+1e+bXvO2dHhPmBoF8oPQlpRZ6OtKYHpE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=uP1LZs4WnnbhlA8C+a3q3yqbvuNDWe3HBAxjgxZsLCatucoI8EkJLVQy8pVf3Y0ww
	 9LfIiGnqk7WjPuKmA3akBWiLbCgbd065UR3s1g7uVxO/bx6MuVv/e6G5ctwWhR42eV
	 mS1o9hpyuoVtCY1FhxY2B/njbDyo02Ism3v3Ch44=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPS id
	20251219124044epcas1p476be6abc6c9af383dbc8890a9d13b57e~CnkoYAh-I0384603846epcas1p4q;
	Fri, 19 Dec 2025 12:40:44 +0000 (GMT)
Received: from epcas1p2.samsung.com (unknown [182.195.38.115]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dXnFS5DRVz3hhT7; Fri, 19 Dec
	2025 12:40:44 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20251219124044epcas1p3df48558b10b0540c2ea1ec65779c261d~Cnknu9BCT2398323983epcas1p3R;
	Fri, 19 Dec 2025 12:40:44 +0000 (GMT)
Received: from junbeom.yeom (unknown [10.253.99.78]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251219124044epsmtip13b608729c8bb9b8f4cdab1cef393a8b7~CnknsFj5O2626826268epsmtip14;
	Fri, 19 Dec 2025 12:40:44 +0000 (GMT)
From: Junbeom Yeom <junbeom.yeom@samsung.com>
To: xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Junbeom Yeom
	<junbeom.yeom@samsung.com>, stable@vger.kernel.org, Jaewook Kim
	<jw5454.kim@samsung.com>, Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH v2] erofs: fix unexpected EIO under memory pressure
Date: Fri, 19 Dec 2025 21:40:31 +0900
Message-Id: <20251219124031.2731710-1-junbeom.yeom@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251219124044epcas1p3df48558b10b0540c2ea1ec65779c261d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251219124044epcas1p3df48558b10b0540c2ea1ec65779c261d
References: <CGME20251219124044epcas1p3df48558b10b0540c2ea1ec65779c261d@epcas1p3.samsung.com>

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
---
v2:
 - If disk I/Os are successful, handle to decompress each pcluster.

 fs/erofs/zdata.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 27b1f44d10ce..70e1597dec8a 100644
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
2.34.1


