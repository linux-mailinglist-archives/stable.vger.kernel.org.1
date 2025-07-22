Return-Path: <stable+bounces-163687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EDBB0D6DC
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BF05497E9
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 10:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50C32E7F11;
	Tue, 22 Jul 2025 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oWrN6AWa"
X-Original-To: stable@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAC42E7658;
	Tue, 22 Jul 2025 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178450; cv=none; b=qKtXpuIOscotJRWdFCgtkTyJBk/Ye7RJBcmWiTmoKFQ3ssVgeCcgLhQhIwWbf3SKh+VSxenIVZnKfGsDCITexU0mUM1EgWc4+c/ZhvJSAvwji1WRv3sKo7ZS1nwre6Gf1KwmFzerng1vHxtxbNVXfLA1VToCpq0aATPrDisuOUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178450; c=relaxed/simple;
	bh=9KKGtC/eAQdmsyrYbT5A3KhgXOXNHvoyazeOTg7og3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZVX247aqYJ5L8+pVuuurKS773wV6I3+I1rO+iaWcj7qCxh5b7d+VV+oVVgy6t6Jsnwn1yUstasnwE/LkhGIiw0GYfEB276UZ9EqbcEBUGlL7KRES3IJmo9UP5wvyPxQwVxY9PhOZfqu6oNh6qLd/DefWB2Phdv+VEuya1X4gCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oWrN6AWa; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753178439; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=peBcjQkGGRXveCOODLAnQs8d0uMvJgOnnZ+JapebP7o=;
	b=oWrN6AWaS1Q+ccRGyflLeYjsw2ADe9ARCuZqTrHGEUbt0eQsyUTwPsCXA71SBHToSZZSte0V7k3kvGNNZ6am9AgnE303ZgSabHn6RCwdHCd7/CIJlkSeucSASmUYN5p4EPJ9xps7cceOIDtam7+mSWSG07Y7gggb3tpulLw7Sqc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjVvTqv_1753178437 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 18:00:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yue Hu <huyue2@coolpad.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 6.1.y 3/5] erofs: drop z_erofs_page_mark_eio()
Date: Tue, 22 Jul 2025 18:00:27 +0800
Message-ID: <20250722100029.3052177-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
References: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 9a05c6a8bc26138d34e87b39e6a815603bc2a66c upstream.

It can be folded into z_erofs_onlinepage_endio() to simplify the code.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230817082813.81180-5-hsiangkao@linux.alibaba.com
---
 fs/erofs/zdata.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5c0f855ab18d..b05ca443cfdf 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -144,22 +144,17 @@ static inline void z_erofs_onlinepage_split(struct page *page)
 	atomic_inc((atomic_t *)&page->private);
 }
 
-static inline void z_erofs_page_mark_eio(struct page *page)
+static void z_erofs_onlinepage_endio(struct page *page, int err)
 {
-	int orig;
+	int orig, v;
+
+	DBG_BUGON(!PagePrivate(page));
 
 	do {
 		orig = atomic_read((atomic_t *)&page->private);
-	} while (atomic_cmpxchg((atomic_t *)&page->private, orig,
-				orig | Z_EROFS_PAGE_EIO) != orig);
-}
-
-static inline void z_erofs_onlinepage_endio(struct page *page)
-{
-	unsigned int v;
+		v = (orig - 1) | (err ? Z_EROFS_PAGE_EIO : 0);
+	} while (atomic_cmpxchg((atomic_t *)&page->private, orig, v) != orig);
 
-	DBG_BUGON(!PagePrivate(page));
-	v = atomic_dec_return((atomic_t *)&page->private);
 	if (!(v & ~Z_EROFS_PAGE_EIO)) {
 		set_page_private(page, 0);
 		ClearPagePrivate(page);
@@ -930,9 +925,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto repeat;
 
 out:
-	if (err)
-		z_erofs_page_mark_eio(page);
-	z_erofs_onlinepage_endio(page);
+	z_erofs_onlinepage_endio(page, err);
 	return err;
 }
 
@@ -1035,9 +1028,7 @@ static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
 			cur += len;
 		}
 		kunmap_local(dst);
-		if (err)
-			z_erofs_page_mark_eio(bvi->bvec.page);
-		z_erofs_onlinepage_endio(bvi->bvec.page);
+		z_erofs_onlinepage_endio(bvi->bvec.page, err);
 		list_del(p);
 		kfree(bvi);
 	}
@@ -1205,9 +1196,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		/* recycle all individual short-lived pages */
 		if (z_erofs_put_shortlivedpage(be->pagepool, page))
 			continue;
-		if (err)
-			z_erofs_page_mark_eio(page);
-		z_erofs_onlinepage_endio(page);
+		z_erofs_onlinepage_endio(page, err);
 	}
 
 	if (be->decompressed_pages != be->onstack_pages)
-- 
2.43.5


