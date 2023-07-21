Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D138D75D2B7
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjGUTDD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjGUTCv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:02:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDA930DD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A83661D85
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C502C433C9;
        Fri, 21 Jul 2023 19:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966168;
        bh=VvjP+SsueJyhbLhEaOGB9Vx+vHLtuRzXlKqIkyXvPVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Vsb2+ExkIE2JxfYlYQkpdgJLw8QnEfWpzMC877IlLp+BDZ/5AQefYhEdFVNMHyja
         LOAvvwNeNVDkggtr/xCNBut4VajbLCWRxGHsB4/bXlAr9kt38dugM9zku3TZ3kjJyg
         CiB9fKk/Hmpk/rEbkcoMhSKOYpn56q673+c6yVig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liu Shixin <liushixin2@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 248/532] bootmem: remove the vmemmap pages from kmemleak in free_bootmem_page
Date:   Fri, 21 Jul 2023 18:02:32 +0200
Message-ID: <20230721160627.804155350@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Liu Shixin <liushixin2@huawei.com>

commit 028725e73375a1ff080bbdf9fb503306d0116f28 upstream.

commit dd0ff4d12dd2 ("bootmem: remove the vmemmap pages from kmemleak in
put_page_bootmem") fix an overlaps existing problem of kmemleak.  But the
problem still existed when HAVE_BOOTMEM_INFO_NODE is disabled, because in
this case, free_bootmem_page() will call free_reserved_page() directly.

Fix the problem by adding kmemleak_free_part() in free_bootmem_page() when
HAVE_BOOTMEM_INFO_NODE is disabled.

Link: https://lkml.kernel.org/r/20230704101942.2819426-1-liushixin2@huawei.com
Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Acked-by: Muchun Song <songmuchun@bytedance.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/bootmem_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index cc35d010fa94..e1a3c9c9754c 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -3,6 +3,7 @@
 #define __LINUX_BOOTMEM_INFO_H
 
 #include <linux/mm.h>
+#include <linux/kmemleak.h>
 
 /*
  * Types for free bootmem stored in page->lru.next. These have to be in
@@ -59,6 +60,7 @@ static inline void get_page_bootmem(unsigned long info, struct page *page,
 
 static inline void free_bootmem_page(struct page *page)
 {
+	kmemleak_free_part(page_to_virt(page), PAGE_SIZE);
 	free_reserved_page(page);
 }
 #endif
-- 
2.41.0



