Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A367A719D98
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjFANYm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjFANYf (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:24:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7ECE74
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:24:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D79C64481
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ED2C4339C;
        Thu,  1 Jun 2023 13:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625855;
        bh=ZSvC1kB0VU9E5dBB6PvCczUyuXalCIGudJdlx9Pzttc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZmDPwyIUyQ0DMkCZoHfwEQr5u8DoaTPb2VEprMWIm04HZ7kLsavgV3r++qjmvjre
         dYjZlNwJ0KY4MX8kyDvAdJHaBm/R6jdou2NpqLnLDjNWdjhnKMoa1SVQauWV4tfsK1
         C9ShR3vI4RI36vMgaKPUBhWuTO6GXvuOAVqPkxQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 20/42] KVM: s390: fix race in gmap_make_secure()
Date:   Thu,  1 Jun 2023 14:21:07 +0100
Message-Id: <20230601131937.629922352@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131936.699199833@linuxfoundation.org>
References: <20230601131936.699199833@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

[ Upstream commit c148dc8e2fa403be501612ee409db866eeed35c0 ]

Fix a potential race in gmap_make_secure() and remove the last user of
follow_page() without FOLL_GET.

The old code is locking something it doesn't have a reference to, and
as explained by Jason and David in this discussion:
https://lore.kernel.org/linux-mm/Y9J4P%2FRNvY1Ztn0Q@nvidia.com/
it can lead to all kind of bad things, including the page getting
unmapped (MADV_DONTNEED), freed, reallocated as a larger folio and the
unlock_page() would target the wrong bit.
There is also another race with the FOLL_WRITE, which could race
between the follow_page() and the get_locked_pte().

The main point is to remove the last use of follow_page() without
FOLL_GET or FOLL_PIN, removing the races can be considered a nice
bonus.

Link: https://lore.kernel.org/linux-mm/Y9J4P%2FRNvY1Ztn0Q@nvidia.com/
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: 214d9bbcd3a6 ("s390/mm: provide memory management functions for protected KVM guests")
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-Id: <20230428092753.27913-2-imbrenda@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/uv.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 7d7961c7b1281..66d1248c8c923 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -160,21 +160,10 @@ static int expected_page_refs(struct page *page)
 	return res;
 }
 
-static int make_secure_pte(pte_t *ptep, unsigned long addr,
-			   struct page *exp_page, struct uv_cb_header *uvcb)
+static int make_page_secure(struct page *page, struct uv_cb_header *uvcb)
 {
-	pte_t entry = READ_ONCE(*ptep);
-	struct page *page;
 	int expected, rc = 0;
 
-	if (!pte_present(entry))
-		return -ENXIO;
-	if (pte_val(entry) & _PAGE_INVALID)
-		return -ENXIO;
-
-	page = pte_page(entry);
-	if (page != exp_page)
-		return -ENXIO;
 	if (PageWriteback(page))
 		return -EAGAIN;
 	expected = expected_page_refs(page);
@@ -252,17 +241,18 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 		goto out;
 
 	rc = -ENXIO;
-	page = follow_page(vma, uaddr, FOLL_WRITE);
-	if (IS_ERR_OR_NULL(page))
-		goto out;
-
-	lock_page(page);
 	ptep = get_locked_pte(gmap->mm, uaddr, &ptelock);
-	if (should_export_before_import(uvcb, gmap->mm))
-		uv_convert_from_secure(page_to_phys(page));
-	rc = make_secure_pte(ptep, uaddr, page, uvcb);
+	if (pte_present(*ptep) && !(pte_val(*ptep) & _PAGE_INVALID) && pte_write(*ptep)) {
+		page = pte_page(*ptep);
+		rc = -EAGAIN;
+		if (trylock_page(page)) {
+			if (should_export_before_import(uvcb, gmap->mm))
+				uv_convert_from_secure(page_to_phys(page));
+			rc = make_page_secure(page, uvcb);
+			unlock_page(page);
+		}
+	}
 	pte_unmap_unlock(ptep, ptelock);
-	unlock_page(page);
 out:
 	mmap_read_unlock(gmap->mm);
 
-- 
2.39.2



