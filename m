Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181C66FA4B5
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjEHKCt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjEHKCr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9375D2D43E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:02:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19515622CA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF67C433EF;
        Mon,  8 May 2023 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540118;
        bh=pjT5jrG7GQGcfsSZRUbSOSt1cFbvKDlhUKPXkhs6Ss0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnTSWbCvJq3TU2TwVQwsb3LNEW4GDfKMB1w0hByIMXfc216Psh4PdSQkkrUPfXATt
         NgKYhOyc8trniPboVQdzatIqmTJhx5qZjOhMvcwKWnUDFJZ4tzR9VMUFkI/yEjFNK/
         +T7qkD+lKXqmGtuXAbFsYJ9cLYQ/gWr0MDuo9M4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 214/611] drm/ttm: optimize pool allocations a bit v2
Date:   Mon,  8 May 2023 11:40:56 +0200
Message-Id: <20230508094429.353254878@linuxfoundation.org>
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

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 735c466465eba51deaee3012d8403c10fc7c8c03 ]

If we got a page pool use it as much as possible.

If we can't get more pages from the pool allocate as much as possible.

Only if that still doesn't work reduce the order and try again.

v2: minor cleanups

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20221107195808.1873-1-christian.koenig@amd.com
Stable-dep-of: 379989e7cbdc ("drm/ttm/pool: Fix ttm_pool_alloc error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 82 ++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 21b61631f73a1..9f6764bf3b15d 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -344,6 +344,28 @@ static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
 	return p->private;
 }
 
+/* Called when we got a page, either from a pool or newly allocated */
+static int ttm_pool_page_allocated(struct ttm_pool *pool, unsigned int order,
+				   struct page *p, dma_addr_t **dma_addr,
+				   unsigned long *num_pages,
+				   struct page ***pages)
+{
+	unsigned int i;
+	int r;
+
+	if (*dma_addr) {
+		r = ttm_pool_map(pool, order, p, dma_addr);
+		if (r)
+			return r;
+	}
+
+	*num_pages -= 1 << order;
+	for (i = 1 << order; i; --i, ++(*pages), ++p)
+		**pages = p;
+
+	return 0;
+}
+
 /**
  * ttm_pool_alloc - Fill a ttm_tt object
  *
@@ -385,45 +407,57 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	for (order = min_t(unsigned int, MAX_ORDER - 1, __fls(num_pages));
 	     num_pages;
 	     order = min_t(unsigned int, order, __fls(num_pages))) {
-		bool apply_caching = false;
 		struct ttm_pool_type *pt;
 
 		pt = ttm_pool_select_type(pool, tt->caching, order);
 		p = pt ? ttm_pool_type_take(pt) : NULL;
 		if (p) {
-			apply_caching = true;
-		} else {
-			p = ttm_pool_alloc_page(pool, gfp_flags, order);
-			if (p && PageHighMem(p))
-				apply_caching = true;
-		}
-
-		if (!p) {
-			if (order) {
-				--order;
-				continue;
-			}
-			r = -ENOMEM;
-			goto error_free_all;
-		}
-
-		if (apply_caching) {
 			r = ttm_pool_apply_caching(caching, pages,
 						   tt->caching);
 			if (r)
 				goto error_free_page;
-			caching = pages + (1 << order);
+
+			do {
+				r = ttm_pool_page_allocated(pool, order, p,
+							    &dma_addr,
+							    &num_pages,
+							    &pages);
+				if (r)
+					goto error_free_page;
+
+				if (num_pages < (1 << order))
+					break;
+
+				p = ttm_pool_type_take(pt);
+			} while (p);
+			caching = pages;
 		}
 
-		if (dma_addr) {
-			r = ttm_pool_map(pool, order, p, &dma_addr);
+		while (num_pages >= (1 << order) &&
+		       (p = ttm_pool_alloc_page(pool, gfp_flags, order))) {
+
+			if (PageHighMem(p)) {
+				r = ttm_pool_apply_caching(caching, pages,
+							   tt->caching);
+				if (r)
+					goto error_free_page;
+			}
+			r = ttm_pool_page_allocated(pool, order, p, &dma_addr,
+						    &num_pages, &pages);
 			if (r)
 				goto error_free_page;
+			if (PageHighMem(p))
+				caching = pages;
 		}
 
-		num_pages -= 1 << order;
-		for (i = 1 << order; i; --i)
-			*(pages++) = p++;
+		if (!p) {
+			if (order) {
+				--order;
+				continue;
+			}
+			r = -ENOMEM;
+			goto error_free_all;
+		}
 	}
 
 	r = ttm_pool_apply_caching(caching, pages, tt->caching);
-- 
2.39.2



