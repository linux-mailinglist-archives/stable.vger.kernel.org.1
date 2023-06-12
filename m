Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A8C72C126
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjFLK4r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbjFLK43 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:56:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C17AA87B
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:44:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17CF061ABD
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE50C433EF;
        Mon, 12 Jun 2023 10:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566650;
        bh=kyu1WU7nvNAR+c0NzljfB4PJigdtj0IlZOiSPt4rdaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fa46t72/ZcATWuC7Mbeb73rHcCj0QqzQb3F+1j3W9IJGE1e0AiUlcY/CjNj/7ZVoC
         /7cFoKL5MhYev5q5IzqH48pqV4UCKy76LHFvKFDToSYXcytr8Ol3NP/NRL4f2wW62i
         f0iry/3FZIAVajh2U18aq+dVzuPIc0HBOyyWsynY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH 6.1 100/132] mm: page_table_check: Ensure user pages are not slab pages
Date:   Mon, 12 Jun 2023 12:27:14 +0200
Message-ID: <20230612101714.856536643@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Ruihan Li <lrh2000@pku.edu.cn>

commit 44d0fb387b53e56c8a050bac5c7d460e21eb226f upstream.

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
 include/linux/page-flags.h |    6 ++++++
 mm/page_table_check.c      |    6 ++++++
 2 files changed, 12 insertions(+)

--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -631,6 +631,12 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemma
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
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -69,6 +69,8 @@ static void page_table_check_clear(struc
 
 	page = pfn_to_page(pfn);
 	page_ext = page_ext_get(page);
+
+	BUG_ON(PageSlab(page));
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
@@ -105,6 +107,8 @@ static void page_table_check_set(struct
 
 	page = pfn_to_page(pfn);
 	page_ext = page_ext_get(page);
+
+	BUG_ON(PageSlab(page));
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
@@ -131,6 +135,8 @@ void __page_table_check_zero(struct page
 	struct page_ext *page_ext;
 	unsigned long i;
 
+	BUG_ON(PageSlab(page));
+
 	page_ext = page_ext_get(page);
 	BUG_ON(!page_ext);
 	for (i = 0; i < (1ul << order); i++) {


