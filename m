Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7577CAC48
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjJPOwh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjJPOwg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:52:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C695AAB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:52:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15107C433C8;
        Mon, 16 Oct 2023 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467954;
        bh=GjwWMK7Vo5KNp8DTuucbCxWgON1e1BG4gAa/VMg7cfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0s5pU7i2mMVBP5c1u+ecD6kmONdasT/A17IvP+gSBxai7JHsMx6uKtukECDamMxMt
         6/ymRqQjK7k53cKgvxDr+0jCDYiGrXLhAp14XpaLZdBlKcZLTob3kzRENrNx5T/qLU
         elmTOYiny999BG/DGBo5roCYAcmh9K2kzh1BKEfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 6.5 122/191] drm: Do not overrun array in drm_gem_get_pages()
Date:   Mon, 16 Oct 2023 10:41:47 +0200
Message-ID: <20231016084018.227136004@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

commit b7fd68ab1538e3adb665670414bea440f399fda9 upstream.

If the shared memory object is larger than the DRM object that it backs,
we can overrun the page array.  Limit the number of pages we install
from each folio to prevent this.

Signed-off-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Link: https://lore.kernel.org/lkml/13360591.uLZWGnKmhe@natalenko.name/
Fixes: 3291e09a4638 ("drm: convert drm_gem_put_pages() to use a folio_batch")
Cc: stable@vger.kernel.org # 6.5.x
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231005135648.2317298-1-willy@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_gem.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -537,7 +537,7 @@ struct page **drm_gem_get_pages(struct d
 	struct page **pages;
 	struct folio *folio;
 	struct folio_batch fbatch;
-	int i, j, npages;
+	long i, j, npages;
 
 	if (WARN_ON(!obj->filp))
 		return ERR_PTR(-EINVAL);
@@ -561,11 +561,13 @@ struct page **drm_gem_get_pages(struct d
 
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


