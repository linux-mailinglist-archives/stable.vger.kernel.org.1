Return-Path: <stable+bounces-163679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EFCB0D63B
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 11:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8A0AA4346
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 09:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0BD2DD5E2;
	Tue, 22 Jul 2025 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c0ch38LC"
X-Original-To: stable@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D02DC34C;
	Tue, 22 Jul 2025 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177506; cv=none; b=S8b0vnrvytJwj/8mig40edCbaRG7sehO/0XsKTuEX7ZW6HCeZv4HDkqCACND5cEJo8N5CAmTBq3WvKvtEe0+gh/DTeUYwvK8cg2+HDsPYiuvJIGBoD5myJW6vKVra9E1gBN1mDCC3DksXVI1l5TMh6wEIjMbOR8Wrrug80lM1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177506; c=relaxed/simple;
	bh=r9oXuVbFRVKmHJJp2OQCjO0e+dxd8XlKIXwlPOtksDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/d5yepTFvJBQUunyzuRBv3FYmotjzmDA9cN/OukRrPpW6lpQctU/m7LqWsT2RXgPS/CZ1GSHq8ISmLG4CzhAW1klcb3ClENsTk7UyNl2pEBDkNFCEzVr8y2b3WaaIrGnylwzU6PMJTV7z0wVPR1IsJeL+bqg395U+YEE2zrmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c0ch38LC; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753177494; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1cXlaQuqCs1uV+qE0zIs8uhrxULjZFWlQ9DRk2BEc2k=;
	b=c0ch38LCpMRAIepZmw9UzhENMxEgYOVW1rVmFZqogfXM6eJStxTT/V2vTQegpyS/4XYJFLwvNMM13zz7ZVALmTl9qeIhsuc+g7t9/YfLVE5Bs8GBQXUYEWC6Osvp85/U38mFzmkSyPZwqm4MvXFdwBPrA24iXSPrPA9MiRsC5P0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjVoKhE_1753177490 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 17:44:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6.6.y] erofs: address D-cache aliasing
Date: Tue, 22 Jul 2025 17:44:49 +0800
Message-ID: <20250722094449.2950654-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 27917e8194f91dffd8b4825350c63cb68e98ce58 upstream.

Flush the D-cache before unlocking folios for compressed inodes, as
they are dirtied during decompression.

Avoid calling flush_dcache_folio() on every CPU write, since it's more
like playing whack-a-mole without real benefit.

It has no impact on x86 and arm64/risc-v: on x86, flush_dcache_folio()
is a no-op, and on arm64/risc-v, PG_dcache_clean (PG_arch_1) is clear
for new page cache folios.  However, certain ARM boards are affected,
as reported.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Closes: https://lore.kernel.org/r/c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de
Closes: https://lore.kernel.org/r/38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com
Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
Tested-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Link: https://lore.kernel.org/r/20250709034614.2780117-2-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Hi Jan & Stefan,
Please help confirm this 6.6 fix backport if possible.

Thanks,
Gao Xiang

 fs/erofs/decompressor.c |  6 ++----
 fs/erofs/zdata.c        | 32 +++++++++++++++++++-------------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index aa59788a61e6..86e088fd386e 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -342,14 +342,12 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 
 	if (outpages > inpages) {
 		DBG_BUGON(!rq->out[outpages - 1]);
-		if (rq->out[outpages - 1] != rq->in[inpages - 1]) {
+		if (rq->out[outpages - 1] != rq->in[inpages - 1])
 			memcpy_to_page(rq->out[outpages - 1], 0, src +
 					(interlaced_offset ? 0 : righthalf),
 				       lefthalf);
-		} else if (!interlaced_offset) {
+		else if (!interlaced_offset)
 			memmove(src, src + righthalf, lefthalf);
-			flush_dcache_page(rq->in[inpages - 1]);
-		}
 	}
 	kunmap_local(src);
 	return 0;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 496e4c7c52a4..d852b43ac43e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -122,9 +122,11 @@ static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
 
 /*
  * bit 30: I/O error occurred on this page
+ * bit 29: CPU has dirty data in D-cache (needs aliasing handling);
  * bit 0 - 29: remaining parts to complete this page
  */
-#define Z_EROFS_PAGE_EIO			(1 << 30)
+#define Z_EROFS_ONLINEPAGE_EIO		30
+#define Z_EROFS_ONLINEPAGE_DIRTY	29
 
 static inline void z_erofs_onlinepage_init(struct page *page)
 {
@@ -143,7 +145,7 @@ static inline void z_erofs_onlinepage_split(struct page *page)
 	atomic_inc((atomic_t *)&page->private);
 }
 
-static void z_erofs_onlinepage_endio(struct page *page, int err)
+static void z_erofs_onlinepage_end(struct page *page, int err, bool dirty)
 {
 	int orig, v;
 
@@ -151,16 +153,20 @@ static void z_erofs_onlinepage_endio(struct page *page, int err)
 
 	do {
 		orig = atomic_read((atomic_t *)&page->private);
-		v = (orig - 1) | (err ? Z_EROFS_PAGE_EIO : 0);
+		DBG_BUGON(orig <= 0);
+		v = dirty << Z_EROFS_ONLINEPAGE_DIRTY;
+		v |= (orig - 1) | (!!err << Z_EROFS_ONLINEPAGE_EIO);
 	} while (atomic_cmpxchg((atomic_t *)&page->private, orig, v) != orig);
 
-	if (!(v & ~Z_EROFS_PAGE_EIO)) {
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		if (!(v & Z_EROFS_PAGE_EIO))
-			SetPageUptodate(page);
-		unlock_page(page);
-	}
+	if (v & (BIT(Z_EROFS_ONLINEPAGE_DIRTY) - 1))
+		return;
+	set_page_private(page, 0);
+	ClearPagePrivate(page);
+	if (v & BIT(Z_EROFS_ONLINEPAGE_DIRTY))
+		flush_dcache_page(page);
+	if (!(v & BIT(Z_EROFS_ONLINEPAGE_EIO)))
+		SetPageUptodate(page);
+	unlock_page(page);
 }
 
 #define Z_EROFS_ONSTACK_PAGES		32
@@ -1060,7 +1066,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto repeat;
 
 out:
-	z_erofs_onlinepage_endio(page, err);
+	z_erofs_onlinepage_end(page, err, false);
 	return err;
 }
 
@@ -1163,7 +1169,7 @@ static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
 			cur += len;
 		}
 		kunmap_local(dst);
-		z_erofs_onlinepage_endio(bvi->bvec.page, err);
+		z_erofs_onlinepage_end(bvi->bvec.page, err, true);
 		list_del(p);
 		kfree(bvi);
 	}
@@ -1333,7 +1339,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		/* recycle all individual short-lived pages */
 		if (z_erofs_put_shortlivedpage(be->pagepool, page))
 			continue;
-		z_erofs_onlinepage_endio(page, err);
+		z_erofs_onlinepage_end(page, err, true);
 	}
 
 	if (be->decompressed_pages != be->onstack_pages)
-- 
2.43.5


