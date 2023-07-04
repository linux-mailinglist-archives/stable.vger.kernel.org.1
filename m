Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6769F746C27
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 10:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjGDIk2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 04:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjGDIkY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 04:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01299CA
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 01:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 895DB61191
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 08:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBDDC433C8;
        Tue,  4 Jul 2023 08:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688460023;
        bh=fWaU8gTgD/D/SVVZLZpbkYBO5upSmdwxi8VWQQhUdKA=;
        h=Subject:To:Cc:From:Date:From;
        b=HClzBiGBz1XKhWuOkBGmqQnUNbPpgd3DictzWRGUn5pM6aeaimMfllzbmvvSpCsZ7
         BgRwkpfD40RhQNgRkCvI53/n6i1k26alF3LMpkoaqZDM21vMSkrb55TTFp93k/UA50
         xYYIfPtjA691LtEtH2ERKyzAwSV6UJWxuTE+WHlI=
Subject: FAILED: patch "[PATCH] hugetlb: revert use of page_cache_next_miss()" failed to apply to 6.3-stable tree
To:     mike.kravetz@oracle.com, ackerleytng@google.com,
        akpm@linux-foundation.org, dan.carpenter@linaro.org,
        erdemaktas@google.com, gregkh@linuxfoundation.org,
        sidhartha.kumar@oracle.com, songmuchun@bytedance.com,
        vannapurve@google.com, willy@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 04 Jul 2023 09:40:20 +0100
Message-ID: <2023070420-fraction-such-da8d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x fd4aed8d985a3236d0877ff6d0c80ad39d4ce81a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023070420-fraction-such-da8d@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd4aed8d985a3236d0877ff6d0c80ad39d4ce81a Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Wed, 21 Jun 2023 14:24:03 -0700
Subject: [PATCH] hugetlb: revert use of page_cache_next_miss()

Ackerley Tng reported an issue with hugetlbfs fallocate as noted in the
Closes tag.  The issue showed up after the conversion of hugetlb page
cache lookup code to use page_cache_next_miss.  User visible effects are:

- hugetlbfs fallocate incorrectly returns -EEXIST if pages are presnet
  in the file.
- hugetlb pages will not be included in core dumps if they need to be
  brought in via GUP.
- userfaultfd UFFDIO_COPY will not notice pages already present in the
  cache.  It may try to allocate a new page and potentially return
  ENOMEM as opposed to EEXIST.

Revert the use page_cache_next_miss() in hugetlb code.

IMPORTANT NOTE FOR STABLE BACKPORTS:
This patch will apply cleanly to v6.3.  However, due to the change of
filemap_get_folio() return values, it will not function correctly.  This
patch must be modified for stable backports.

[dan.carpenter@linaro.org: fix hugetlbfs_pagecache_present()]
  Link: https://lkml.kernel.org/r/efa86091-6a2c-4064-8f55-9b44e1313015@moroto.mountain
Link: https://lkml.kernel.org/r/20230621212403.174710-2-mike.kravetz@oracle.com
Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reported-by: Ackerley Tng <ackerleytng@google.com>
Closes: https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Erdem Aktas <erdemaktas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 90361a922cec..7b17ccfa039d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -821,7 +821,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 */
 		struct folio *folio;
 		unsigned long addr;
-		bool present;
 
 		cond_resched();
 
@@ -842,10 +841,9 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
-		rcu_read_lock();
-		present = page_cache_next_miss(mapping, index, 1) != index;
-		rcu_read_unlock();
-		if (present) {
+		folio = filemap_get_folio(mapping, index);
+		if (!IS_ERR(folio)) {
+			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			continue;
 		}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d76574425da3..bce28cca73a1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5728,13 +5728,13 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	pgoff_t idx = vma_hugecache_offset(h, vma, address);
-	bool present;
-
-	rcu_read_lock();
-	present = page_cache_next_miss(mapping, idx, 1) != idx;
-	rcu_read_unlock();
+	struct folio *folio;
 
-	return present;
+	folio = filemap_get_folio(mapping, idx);
+	if (IS_ERR(folio))
+		return false;
+	folio_put(folio);
+	return true;
 }
 
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,

