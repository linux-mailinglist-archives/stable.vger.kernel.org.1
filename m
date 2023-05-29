Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0C1714CE3
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 17:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjE2PUI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 11:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjE2PUI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 11:20:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD97C4
        for <stable@vger.kernel.org>; Mon, 29 May 2023 08:20:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C3B4615F0
        for <stable@vger.kernel.org>; Mon, 29 May 2023 15:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6EFC433EF;
        Mon, 29 May 2023 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685373605;
        bh=h9tJAJnproQuDZcvwq4om2ArE2Plhkd9lflhYBc59Vo=;
        h=Subject:To:From:Date:From;
        b=YujnV2/p889LZqA9FbSmmDPlHYKZe1Ta00dEiBYng6ZEAwW6BUdOv1rtKnVTDE1GW
         o5PRz41LIVjYOt29ONk7jeb1+vUiwakt7dO34RKUAM/yCKAv00JtwvOC6htFcGtCh5
         /Ab4J2UbDcpily+CV2PBC/9zMduAT8hoyScRVT3M=
Subject: patch "mm: page_table_check: Ensure user pages are not slab pages" added to usb-linus
To:     lrh2000@pku.edu.cn, gregkh@linuxfoundation.org,
        pasha.tatashin@soleen.com, stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 29 May 2023 16:19:52 +0100
Message-ID: <2023052952-tripping-denial-8786@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


This is a note to let you know that I've just added the patch titled

    mm: page_table_check: Ensure user pages are not slab pages

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 44d0fb387b53e56c8a050bac5c7d460e21eb226f Mon Sep 17 00:00:00 2001
From: Ruihan Li <lrh2000@pku.edu.cn>
Date: Mon, 15 May 2023 21:09:58 +0800
Subject: mm: page_table_check: Ensure user pages are not slab pages

The current uses of PageAnon in page table check functions can lead to
type confusion bugs between struct page and slab [1], if slab pages are
accidentally mapped into the user space. This is because slab reuses the
bits in struct page to store its internal states, which renders PageAnon
ineffective on slab pages.

Since slab pages are not expected to be mapped into the user space, this
patch adds BUG_ON(PageSlab(page)) checks to make sure that slab pages
are not inadvertently mapped. Otherwise, there must be some bugs in the
kernel.

Reported-by: syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000258e5e05fae79fc1@google.com/ [1]
Fixes: df4e817b7108 ("mm: page table check")
Cc: <stable@vger.kernel.org> # 5.17
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Link: https://lore.kernel.org/r/20230515130958.32471-5-lrh2000@pku.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/page-flags.h | 6 ++++++
 mm/page_table_check.c      | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1c68d67b832f..92a2063a0a23 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -617,6 +617,12 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * Please note that, confusingly, "page_mapping" refers to the inode
  * address_space which maps the page from disk; whereas "page_mapped"
  * refers to user virtual address space into which the page is mapped.
+ *
+ * For slab pages, since slab reuses the bits in struct page to store its
+ * internal states, the page->mapping does not exist as such, nor do these
+ * flags below.  So in order to avoid testing non-existent bits, please
+ * make sure that PageSlab(page) actually evaluates to false before calling
+ * the following functions (e.g., PageAnon).  See mm/slab.h.
  */
 #define PAGE_MAPPING_ANON	0x1
 #define PAGE_MAPPING_MOVABLE	0x2
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 25d8610c0042..f2baf97d5f38 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -71,6 +71,8 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
 
 	page = pfn_to_page(pfn);
 	page_ext = page_ext_get(page);
+
+	BUG_ON(PageSlab(page));
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
@@ -107,6 +109,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 
 	page = pfn_to_page(pfn);
 	page_ext = page_ext_get(page);
+
+	BUG_ON(PageSlab(page));
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
@@ -133,6 +137,8 @@ void __page_table_check_zero(struct page *page, unsigned int order)
 	struct page_ext *page_ext;
 	unsigned long i;
 
+	BUG_ON(PageSlab(page));
+
 	page_ext = page_ext_get(page);
 	BUG_ON(!page_ext);
 	for (i = 0; i < (1ul << order); i++) {
-- 
2.40.1


