Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002FC74C2B8
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjGILX4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjGILXz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:23:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF0B13D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A31A60BD8
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CA8C433C8;
        Sun,  9 Jul 2023 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901833;
        bh=LZtVAwtME7iP+q2uqEAfoqIyf7Iti8DPLXHXcXXzCPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u42OVnNuM3TgW3VOAisVGY2y/Cn4VU0sshi6OhJQsFy21Yw27ER5tNK69JxqgQKHv
         igXAtE1GoFhYuDIQebllQQt3EsD9Yqmj/KDpu7jqbHmz7l9pGiUP9vMHIZ+dBfdG3t
         Fs4f8U8M/UfIt6S4qAJ1zBaCfGY+XHYZopUYdjo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liu Shixin <liushixin2@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.3 161/431] bootmem: remove the vmemmap pages from kmemleak in free_bootmem_page
Date:   Sun,  9 Jul 2023 13:11:49 +0200
Message-ID: <20230709111454.948463588@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/bootmem_info.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -3,6 +3,7 @@
 #define __LINUX_BOOTMEM_INFO_H
 
 #include <linux/mm.h>
+#include <linux/kmemleak.h>
 
 /*
  * Types for free bootmem stored in page->lru.next. These have to be in
@@ -59,6 +60,7 @@ static inline void get_page_bootmem(unsi
 
 static inline void free_bootmem_page(struct page *page)
 {
+	kmemleak_free_part(page_to_virt(page), PAGE_SIZE);
 	free_reserved_page(page);
 }
 #endif


