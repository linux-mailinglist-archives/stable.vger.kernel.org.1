Return-Path: <stable+bounces-143699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E17AB40F6
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407B517716C
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE3295D97;
	Mon, 12 May 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QqTFqunL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5B2505C5;
	Mon, 12 May 2025 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072793; cv=none; b=iglLG5EWSVSJiUY3207Ynue/dp0a6S8WKs/VmVe3ajLbzFdthLuFs+D5HxQI5M7Sb75anXCQiiLoTQPyXdlC2xoGQSnjML7e9ilKE9kjWaJWXKWygD5f6AMrhEHcydqiYFK9dtTqO3/6xjR8ptGRk3QKmIOhM8a6EBOeQydy0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072793; c=relaxed/simple;
	bh=RDEoO7GDq7DSEb+MRcALcwhQaZD4/d3cNqt4hxYWxgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scmZRsdy3QTqmdIaQrJ4oUwvKTbPuPSF83H12weoCnayvXGEM9DmlLZ3i8A+uqgeY7gfIzTanopO0Ue303gTtHusMivNZ1JDJN4J7mNxjHyF28u45LVAH0XMHO26QEh5XCk+7kpc5QDQKUQAC8tH3S4JKnLF/wUIkh6JdGPc34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QqTFqunL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BEEC4CEE7;
	Mon, 12 May 2025 17:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072793;
	bh=RDEoO7GDq7DSEb+MRcALcwhQaZD4/d3cNqt4hxYWxgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QqTFqunLESoFb+6O5jgusDEYTXmehwYLrAq3dUiI0NWiYduuwWkNoc8ArFdzWJmHX
	 w4oBL5LiQJjW6YUJzjYSut3CkbmvEHY3CZOIHdC69jbuVIV/lxZ9dBMG0j95B4ig3K
	 0qg0pIWt3+2kQ5HKlCXyDCZWvmiF6AsL99mObnUo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongbo Li <lihongbo22@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 031/184] erofs: ensure the extra temporary copy is valid for shortened bvecs
Date: Mon, 12 May 2025 19:43:52 +0200
Message-ID: <20250512172042.984844127@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 35076d2223c731f7be75af61e67f90807384d030 ]

When compressed data deduplication is enabled, multiple logical extents
may reference the same compressed physical cluster.

The previous commit 94c43de73521 ("erofs: fix wrong primary bvec
selection on deduplicated extents") already avoids using shortened
bvecs.  However, in such cases, the extra temporary buffers also
need to be preserved for later use in z_erofs_fill_other_copies() to
to prevent data corruption.

IOWs, extra temporary buffers have to be retained not only due to
varying start relative offsets (`pageofs_out`, as indicated by
`pcl->multibases`) but also because of shortened bvecs.

android.hardware.graphics.composer@2.1.so : 270696 bytes
   0:        0..  204185 |  204185 :  628019200.. 628084736 |   65536
-> 1:   204185..  225536 |   21351 :  544063488.. 544129024 |   65536
   2:   225536..  270696 |   45160 :          0..         0 |       0

com.android.vndk.v28.apex : 93814897 bytes
...
   364: 53869896..54095257 |  225361 :  543997952.. 544063488 |   65536
-> 365: 54095257..54309344 |  214087 :  544063488.. 544129024 |   65536
   366: 54309344..54514557 |  205213 :  544129024.. 544194560 |   65536
...

Both 204185 and 54095257 have the same start relative offset of 3481,
but the logical page 55 of `android.hardware.graphics.composer@2.1.so`
ranges from 225280 to 229632, forming a shortened bvec [225280, 225536)
that cannot be used for decompressing the range from 54095257 to
54309344 of `com.android.vndk.v28.apex`.

Since `pcl->multibases` is already meaningless, just mark `be->keepxcpy`
on demand for simplicity.

Again, this issue can only lead to data corruption if `-Ededupe` is on.

Fixes: 94c43de73521 ("erofs: fix wrong primary bvec selection on deduplicated extents")
Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20250506101850.191506-1-hsiangkao@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zdata.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a8fb4b525f544..e5e94afc5af88 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -82,9 +82,6 @@ struct z_erofs_pcluster {
 	/* L: whether partial decompression or not */
 	bool partial;
 
-	/* L: indicate several pageofs_outs or not */
-	bool multibases;
-
 	/* L: whether extra buffer allocations are best-effort */
 	bool besteffort;
 
@@ -1073,8 +1070,6 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 				break;
 
 			erofs_onlinefolio_split(folio);
-			if (f->pcl->pageofs_out != (map->m_la & ~PAGE_MASK))
-				f->pcl->multibases = true;
 			if (f->pcl->length < offset + end - map->m_la) {
 				f->pcl->length = offset + end - map->m_la;
 				f->pcl->pageofs_out = map->m_la & ~PAGE_MASK;
@@ -1120,7 +1115,6 @@ struct z_erofs_decompress_backend {
 	struct page *onstack_pages[Z_EROFS_ONSTACK_PAGES];
 	struct super_block *sb;
 	struct z_erofs_pcluster *pcl;
-
 	/* pages with the longest decompressed length for deduplication */
 	struct page **decompressed_pages;
 	/* pages to keep the compressed data */
@@ -1129,6 +1123,8 @@ struct z_erofs_decompress_backend {
 	struct list_head decompressed_secondary_bvecs;
 	struct page **pagepool;
 	unsigned int onstack_used, nr_pages;
+	/* indicate if temporary copies should be preserved for later use */
+	bool keepxcpy;
 };
 
 struct z_erofs_bvec_item {
@@ -1139,18 +1135,20 @@ struct z_erofs_bvec_item {
 static void z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
 					 struct z_erofs_bvec *bvec)
 {
+	int poff = bvec->offset + be->pcl->pageofs_out;
 	struct z_erofs_bvec_item *item;
-	unsigned int pgnr;
-
-	if (!((bvec->offset + be->pcl->pageofs_out) & ~PAGE_MASK) &&
-	    (bvec->end == PAGE_SIZE ||
-	     bvec->offset + bvec->end == be->pcl->length)) {
-		pgnr = (bvec->offset + be->pcl->pageofs_out) >> PAGE_SHIFT;
-		DBG_BUGON(pgnr >= be->nr_pages);
-		if (!be->decompressed_pages[pgnr]) {
-			be->decompressed_pages[pgnr] = bvec->page;
+	struct page **page;
+
+	if (!(poff & ~PAGE_MASK) && (bvec->end == PAGE_SIZE ||
+			bvec->offset + bvec->end == be->pcl->length)) {
+		DBG_BUGON((poff >> PAGE_SHIFT) >= be->nr_pages);
+		page = be->decompressed_pages + (poff >> PAGE_SHIFT);
+		if (!*page) {
+			*page = bvec->page;
 			return;
 		}
+	} else {
+		be->keepxcpy = true;
 	}
 
 	/* (cold path) one pcluster is requested multiple times */
@@ -1316,7 +1314,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.alg = pcl->algorithmformat,
 					.inplace_io = overlapped,
 					.partial_decoding = pcl->partial,
-					.fillgaps = pcl->multibases,
+					.fillgaps = be->keepxcpy,
 					.gfp = pcl->besteffort ? GFP_KERNEL :
 						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
@@ -1370,7 +1368,6 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 
 	pcl->length = 0;
 	pcl->partial = true;
-	pcl->multibases = false;
 	pcl->besteffort = false;
 	pcl->bvset.nextpage = NULL;
 	pcl->vcnt = 0;
-- 
2.39.5




