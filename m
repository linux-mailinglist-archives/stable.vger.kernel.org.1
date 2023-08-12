Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3F5779D8B
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 08:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjHLGLg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 02:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjHLGLf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 02:11:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282E8129
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 23:11:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B729F63A41
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46B0C433C7;
        Sat, 12 Aug 2023 06:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691820694;
        bh=zZ/SGjm4ibXQyyhm4Tu7Dd69fJRVPJETTqEUrl3eT9s=;
        h=Subject:To:Cc:From:Date:From;
        b=l+EOdrO+ncX/mHdZ+5OASw6cIRbNcUr+c/cSX6z38D8UtCAKihpk3rsZr2KyGF9AU
         eDIGXs3eNY4RbbALoSYSpNEOS7MYbDRGYEF1WHQUsgRGYyhpj5SpzL2i4I0gFRsGvu
         4ua7baWbhcwi0tJ/WBPOhQHhriq8j+xX+uydR/DI=
Subject: FAILED: patch "[PATCH] mm: memory-failure: avoid false hwpoison page mapped error" failed to apply to 5.15-stable tree
To:     linmiaohe@huawei.com, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, stable@vger.kernel.org,
        wangkefeng.wang@huawei.com, willy@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 08:11:29 +0200
Message-ID: <2023081229-culinary-gliding-61fd@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x faeb2ff2c1c5cb60ce0da193580b256c941f99ca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081229-culinary-gliding-61fd@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

faeb2ff2c1c5 ("mm: memory-failure: avoid false hwpoison page mapped error info")
f29623e4a599 ("mm: memory-failure: fix potential unexpected return value from unpoison_memory()")
a6fddef49eef ("mm/memory-failure: convert unpoison_memory() to folios")
9637d7dfb19c ("mm/memory-failure: convert free_raw_hwp_pages() to folios")
2ff6cecee669 ("mm/memory-failure: convert hugetlb_clear_page_hwpoison to folios")
bc1cfde19467 ("mm/memory-failure: convert try_memory_failure_hugetlb() to folios")
911565b82853 ("mm/hugetlb: convert destroy_compound_gigantic_page() to folios")
e0ff42804233 ("mm/memory-failure.c: cleanup in unpoison_memory")
cb67f4282bf9 ("mm,thp,rmap: simplify compound page mapcount handling")
dad6a5eb5556 ("mm,hugetlb: use folio fields in second tail page")
f074732d599e ("mm/hugetlb_cgroup: convert hugetlb_cgroup_from_page() to folios")
a098c977722c ("mm/hugetlb_cgroup: convert __set_hugetlb_cgroup() to folios")
5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
a46c9304b4bb ("mm/hwpoison: pass pfn to num_poisoned_pages_*()")
d027122d8363 ("mm/hwpoison: move definitions of num_poisoned_pages_* to memory-failure.c")
e591ef7d96d6 ("mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage")
b66d00dfebe7 ("mm: memory-failure: make action_result() return int")
4781593d5dba ("mm/hugetlb: unify clearing of RestoreReserve for private pages")
149562f75094 ("mm/hugetlb: add hugetlb_folio_subpool() helpers")
d340625f4849 ("mm: add private field of first tail to struct page and struct folio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From faeb2ff2c1c5cb60ce0da193580b256c941f99ca Mon Sep 17 00:00:00 2001
From: Miaohe Lin <linmiaohe@huawei.com>
Date: Thu, 27 Jul 2023 19:56:42 +0800
Subject: [PATCH] mm: memory-failure: avoid false hwpoison page mapped error
 info

folio->_mapcount is overloaded in SLAB, so folio_mapped() has to be done
after folio_test_slab() is checked. Otherwise slab folio might be treated
as a mapped folio leading to false 'Someone maps the hwpoison page' error
info.

Link: https://lkml.kernel.org/r/20230727115643.639741-4-linmiaohe@huawei.com
Fixes: 230ac719c500 ("mm/hwpoison: don't try to unpoison containment-failed pages")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b32d370b5d43..9a285038d765 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2499,6 +2499,13 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
+	if (folio_test_slab(folio) || PageTable(&folio->page) || folio_test_reserved(folio))
+		goto unlock_mutex;
+
+	/*
+	 * Note that folio->_mapcount is overloaded in SLAB, so the simple test
+	 * in folio_mapped() has to be done after folio_test_slab() is checked.
+	 */
 	if (folio_mapped(folio)) {
 		unpoison_pr_info("Unpoison: Someone maps the hwpoison page %#lx\n",
 				 pfn, &unpoison_rs);
@@ -2511,9 +2518,6 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	if (folio_test_slab(folio) || PageTable(&folio->page) || folio_test_reserved(folio))
-		goto unlock_mutex;
-
 	ghp = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ghp) {
 		if (PageHuge(p)) {

