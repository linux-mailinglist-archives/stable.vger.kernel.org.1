Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867B9779D89
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 08:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjHLGLT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 02:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjHLGLT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 02:11:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007F2129
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 23:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 746F7614D8
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A444C433C8;
        Sat, 12 Aug 2023 06:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691820677;
        bh=zH3qTtiBNr4tus1mN7fOSEJNyUC2dnOXdUR+8MFskcw=;
        h=Subject:To:Cc:From:Date:From;
        b=ZkmA/ZNOy6aTYIo7hcLMEvClDF1YFGRu7yB/p9AiWJu6RIPfL/4q0Nw1MKxATcCEi
         lj2qYPUjTajTR2cg8ujtklLScYGMWeOu0+wsX7cSscZ5MAx6WqjF6f3brzAMrTgtt0
         kCy1MvWH7tWIlwrbRoLu/qihz1Nx1j+YsgTevTJE=
Subject: FAILED: patch "[PATCH] mm: memory-failure: fix potential unexpected return value" failed to apply to 6.1-stable tree
To:     linmiaohe@huawei.com, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, stable@vger.kernel.org,
        wangkefeng.wang@huawei.com, willy@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 08:11:15 +0200
Message-ID: <2023081215-deduce-elective-a3f6@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f29623e4a599c295cc8f518c8e4bb7848581a14d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081215-deduce-elective-a3f6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

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

From f29623e4a599c295cc8f518c8e4bb7848581a14d Mon Sep 17 00:00:00 2001
From: Miaohe Lin <linmiaohe@huawei.com>
Date: Thu, 27 Jul 2023 19:56:41 +0800
Subject: [PATCH] mm: memory-failure: fix potential unexpected return value
 from unpoison_memory()

If unpoison_memory() fails to clear page hwpoisoned flag, return value ret
is expected to be -EBUSY.  But when get_hwpoison_page() returns 1 and
fails to clear page hwpoisoned flag due to races, return value will be
unexpected 1 leading to users being confused.  And there's a code smell
that the variable "ret" is used not only to save the return value of
unpoison_memory(), but also the return value from get_hwpoison_page().
Make a further cleanup by using another auto-variable solely to save the
return value of get_hwpoison_page() as suggested by Naoya.

Link: https://lkml.kernel.org/r/20230727115643.639741-3-linmiaohe@huawei.com
Fixes: bf181c582588 ("mm/hwpoison: fix unpoison_memory()")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ece5d481b5ff..b32d370b5d43 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2466,7 +2466,7 @@ int unpoison_memory(unsigned long pfn)
 {
 	struct folio *folio;
 	struct page *p;
-	int ret = -EBUSY;
+	int ret = -EBUSY, ghp;
 	unsigned long count = 1;
 	bool huge = false;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
@@ -2514,29 +2514,28 @@ int unpoison_memory(unsigned long pfn)
 	if (folio_test_slab(folio) || PageTable(&folio->page) || folio_test_reserved(folio))
 		goto unlock_mutex;
 
-	ret = get_hwpoison_page(p, MF_UNPOISON);
-	if (!ret) {
+	ghp = get_hwpoison_page(p, MF_UNPOISON);
+	if (!ghp) {
 		if (PageHuge(p)) {
 			huge = true;
 			count = folio_free_raw_hwp(folio, false);
-			if (count == 0) {
-				ret = -EBUSY;
+			if (count == 0)
 				goto unlock_mutex;
-			}
 		}
 		ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
-	} else if (ret < 0) {
-		if (ret == -EHWPOISON) {
+	} else if (ghp < 0) {
+		if (ghp == -EHWPOISON) {
 			ret = put_page_back_buddy(p) ? 0 : -EBUSY;
-		} else
+		} else {
+			ret = ghp;
 			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
 					 pfn, &unpoison_rs);
+		}
 	} else {
 		if (PageHuge(p)) {
 			huge = true;
 			count = folio_free_raw_hwp(folio, false);
 			if (count == 0) {
-				ret = -EBUSY;
 				folio_put(folio);
 				goto unlock_mutex;
 			}

