Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641FD6FA4B6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjEHKCu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjEHKCs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:02:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB372E6A2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:02:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F39A8622D1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F087C433D2;
        Mon,  8 May 2023 10:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540121;
        bh=r9rVlrFQalbmFX0ikKC9X3IMuLWqoQn1Chk96hqHVwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBPCZ9FfS8AaruhxOBZasdIH5lscIoAJFQME9NcehhmDfTn6/1G1qrfXt94pWInSb
         prD4PKkzMLmaLEaeIX9y8NCQjIqm07gFTqzmcO1etXIuIftpQh5bzicm2d3Cbjknoq
         dJp1KnyiHnFct/LUKNSXMyoEfHAul1q8hLdJefAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 215/611] drm/ttm/pool: Fix ttm_pool_alloc error path
Date:   Mon,  8 May 2023 11:40:57 +0200
Message-Id: <20230508094429.383709974@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

[ Upstream commit 379989e7cbdc7aa7496a00ee286ec146c7599cf0 ]

When hitting an error, the error path forgot to unmap dma mappings and
could call set_pages_wb() on already uncached pages.

Fix this by introducing a common ttm_pool_free_range() function that
does the right thing.

v2:
- Simplify that common function (Christian König)
v3:
- Rename that common function to ttm_pool_free_range() (Christian König)

Fixes: d099fc8f540a ("drm/ttm: new TT backend allocation pool v3")
Cc: Christian König <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230404200650.11043-2-thomas.hellstrom@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 81 +++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 9f6764bf3b15d..86affe987a1cb 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -366,6 +366,43 @@ static int ttm_pool_page_allocated(struct ttm_pool *pool, unsigned int order,
 	return 0;
 }
 
+/**
+ * ttm_pool_free_range() - Free a range of TTM pages
+ * @pool: The pool used for allocating.
+ * @tt: The struct ttm_tt holding the page pointers.
+ * @caching: The page caching mode used by the range.
+ * @start_page: index for first page to free.
+ * @end_page: index for last page to free + 1.
+ *
+ * During allocation the ttm_tt page-vector may be populated with ranges of
+ * pages with different attributes if allocation hit an error without being
+ * able to completely fulfill the allocation. This function can be used
+ * to free these individual ranges.
+ */
+static void ttm_pool_free_range(struct ttm_pool *pool, struct ttm_tt *tt,
+				enum ttm_caching caching,
+				pgoff_t start_page, pgoff_t end_page)
+{
+	struct page **pages = tt->pages;
+	unsigned int order;
+	pgoff_t i, nr;
+
+	for (i = start_page; i < end_page; i += nr, pages += nr) {
+		struct ttm_pool_type *pt = NULL;
+
+		order = ttm_pool_page_order(pool, *pages);
+		nr = (1UL << order);
+		if (tt->dma_address)
+			ttm_pool_unmap(pool, tt->dma_address[i], nr);
+
+		pt = ttm_pool_select_type(pool, caching, order);
+		if (pt)
+			ttm_pool_type_give(pt, *pages);
+		else
+			ttm_pool_free_page(pool, caching, order, *pages);
+	}
+}
+
 /**
  * ttm_pool_alloc - Fill a ttm_tt object
  *
@@ -381,12 +418,14 @@ static int ttm_pool_page_allocated(struct ttm_pool *pool, unsigned int order,
 int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		   struct ttm_operation_ctx *ctx)
 {
-	unsigned long num_pages = tt->num_pages;
+	pgoff_t num_pages = tt->num_pages;
 	dma_addr_t *dma_addr = tt->dma_address;
 	struct page **caching = tt->pages;
 	struct page **pages = tt->pages;
+	enum ttm_caching page_caching;
 	gfp_t gfp_flags = GFP_USER;
-	unsigned int i, order;
+	pgoff_t caching_divide;
+	unsigned int order;
 	struct page *p;
 	int r;
 
@@ -409,6 +448,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	     order = min_t(unsigned int, order, __fls(num_pages))) {
 		struct ttm_pool_type *pt;
 
+		page_caching = tt->caching;
 		pt = ttm_pool_select_type(pool, tt->caching, order);
 		p = pt ? ttm_pool_type_take(pt) : NULL;
 		if (p) {
@@ -417,6 +457,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			if (r)
 				goto error_free_page;
 
+			caching = pages;
 			do {
 				r = ttm_pool_page_allocated(pool, order, p,
 							    &dma_addr,
@@ -425,14 +466,15 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 				if (r)
 					goto error_free_page;
 
+				caching = pages;
 				if (num_pages < (1 << order))
 					break;
 
 				p = ttm_pool_type_take(pt);
 			} while (p);
-			caching = pages;
 		}
 
+		page_caching = ttm_cached;
 		while (num_pages >= (1 << order) &&
 		       (p = ttm_pool_alloc_page(pool, gfp_flags, order))) {
 
@@ -441,6 +483,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 							   tt->caching);
 				if (r)
 					goto error_free_page;
+				caching = pages;
 			}
 			r = ttm_pool_page_allocated(pool, order, p, &dma_addr,
 						    &num_pages, &pages);
@@ -467,15 +510,13 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	return 0;
 
 error_free_page:
-	ttm_pool_free_page(pool, tt->caching, order, p);
+	ttm_pool_free_page(pool, page_caching, order, p);
 
 error_free_all:
 	num_pages = tt->num_pages - num_pages;
-	for (i = 0; i < num_pages; ) {
-		order = ttm_pool_page_order(pool, tt->pages[i]);
-		ttm_pool_free_page(pool, tt->caching, order, tt->pages[i]);
-		i += 1 << order;
-	}
+	caching_divide = caching - tt->pages;
+	ttm_pool_free_range(pool, tt, tt->caching, 0, caching_divide);
+	ttm_pool_free_range(pool, tt, ttm_cached, caching_divide, num_pages);
 
 	return r;
 }
@@ -491,27 +532,7 @@ EXPORT_SYMBOL(ttm_pool_alloc);
  */
 void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt)
 {
-	unsigned int i;
-
-	for (i = 0; i < tt->num_pages; ) {
-		struct page *p = tt->pages[i];
-		unsigned int order, num_pages;
-		struct ttm_pool_type *pt;
-
-		order = ttm_pool_page_order(pool, p);
-		num_pages = 1ULL << order;
-		if (tt->dma_address)
-			ttm_pool_unmap(pool, tt->dma_address[i], num_pages);
-
-		pt = ttm_pool_select_type(pool, tt->caching, order);
-		if (pt)
-			ttm_pool_type_give(pt, tt->pages[i]);
-		else
-			ttm_pool_free_page(pool, tt->caching, order,
-					   tt->pages[i]);
-
-		i += num_pages;
-	}
+	ttm_pool_free_range(pool, tt, tt->caching, 0, tt->num_pages);
 
 	while (atomic_long_read(&allocated_pages) > page_pool_size)
 		ttm_pool_shrink();
-- 
2.39.2



