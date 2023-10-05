Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE2D7BA363
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 17:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbjJEP5M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 11:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbjJEP4d (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 11:56:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0719F27B28
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XkXYv0qtERSa0qejiN1gJtR8t1z/x7cXnvEqa++mIHU=; b=KsahgL/nupfly0BYiIb7b5nf9x
        gN6RgIjanwCX6FlS9cB7SlQXupmYFGSEoqR/dExl9KcBPfp0GGwAjAGQEaXi5RI7Zq88OdgEtPWBv
        PtgWTREjQ8gdkb0FQJQ6gAlQWIiBU6g3vf7IRo0o5mf7WnhfWVs+Q/438RrqHT6lQsksh+7OlKmYu
        W656DaV4gRPH3hJ1z7vMsPmKu56j1RBgJE2DB9X0PmAulfOi+jIZcVTg+6zwwXKxoGS0ArrQul+2b
        CaFmwqxVO6VZX8JhDpiidczovkaGeVOy5nahk1nNmhndqCyrG3pOQuSh7ceEU3+wblmHEg6ESuCi9
        lx4q8bqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qoOqV-009iqI-Hc; Thu, 05 Oct 2023 13:56:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        stable@vger.kernel.org
Subject: [PATCH] drm: Do not overrun array in drm_gem_get_pages()
Date:   Thu,  5 Oct 2023 14:56:47 +0100
Message-Id: <20231005135648.2317298-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

If the shared memory object is larger than the DRM object that it backs,
we can overrun the page array.  Limit the number of pages we install
from each folio to prevent this.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Link: https://lore.kernel.org/lkml/13360591.uLZWGnKmhe@natalenko.name/
Fixes: 3291e09a4638 ("drm: convert drm_gem_put_pages() to use a folio_batch")
Cc: stable@vger.kernel.org # 6.5.x
---
 drivers/gpu/drm/drm_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 6129b89bb366..44a948b80ee1 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -540,7 +540,7 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj)
 	struct page **pages;
 	struct folio *folio;
 	struct folio_batch fbatch;
-	int i, j, npages;
+	long i, j, npages;
 
 	if (WARN_ON(!obj->filp))
 		return ERR_PTR(-EINVAL);
@@ -564,11 +564,13 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj)
 
 	i = 0;
 	while (i < npages) {
+		long nr;
 		folio = shmem_read_folio_gfp(mapping, i,
 				mapping_gfp_mask(mapping));
 		if (IS_ERR(folio))
 			goto fail;
-		for (j = 0; j < folio_nr_pages(folio); j++, i++)
+		nr = min(npages - i, folio_nr_pages(folio));
+		for (j = 0; j < nr; j++, i++)
 			pages[i] = folio_file_page(folio, i);
 
 		/* Make sure shmem keeps __GFP_DMA32 allocated pages in the
-- 
2.40.1

