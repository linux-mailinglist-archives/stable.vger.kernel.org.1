Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC8C779D87
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 08:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjHLGKs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 02:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjHLGKr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 02:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23590D7
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 23:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC2DC614D8
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D05C433C7;
        Sat, 12 Aug 2023 06:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691820646;
        bh=JcahfNMGTI8RkrOwHSslcTHeEQj2NfhT+2gIOzNVJ9A=;
        h=Subject:To:Cc:From:Date:From;
        b=upb9CFM0Qto4pAh6L5ITLbdUC9uigJffER6QQxe7XL0vHivoMxl0aXz8W0zVsIMtz
         iolbvxKMCQgKTglv2bldWewSBWcEn5wZm57MhjWJC+bBF11a4eGkpPu+Xw2LhX71hf
         NEci+EjI+XDZq69+wrLlwgETLBjb63EqchnhvDS4=
Subject: FAILED: patch "[PATCH] mm/swapfile: fix wrong swap entry type for hwpoisoned" failed to apply to 6.4-stable tree
To:     linmiaohe@huawei.com, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, stable@vger.kernel.org,
        wangkefeng.wang@huawei.com, willy@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 08:10:43 +0200
Message-ID: <2023081243-component-eatery-a09a@gregkh>
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


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x f985fc322063c73916a0d5b6b3fcc6db2ba5792c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081243-component-eatery-a09a@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f985fc322063c73916a0d5b6b3fcc6db2ba5792c Mon Sep 17 00:00:00 2001
From: Miaohe Lin <linmiaohe@huawei.com>
Date: Thu, 27 Jul 2023 19:56:40 +0800
Subject: [PATCH] mm/swapfile: fix wrong swap entry type for hwpoisoned
 swapcache page

Patch series "A few fixup patches for mm", v2.

This series contains a few fixup patches to fix potential unexpected
return value, fix wrong swap entry type for hwpoisoned swapcache page and
so on.  More details can be found in the respective changelogs.


This patch (of 3):

Hwpoisoned dirty swap cache page is kept in the swap cache and there's
simple interception code in do_swap_page() to catch it.  But when trying
to swapoff, unuse_pte() will wrongly install a general sense of "future
accesses are invalid" swap entry for hwpoisoned swap cache page due to
unaware of such type of page.  The user will receive SIGBUS signal without
expected BUS_MCEERR_AR payload.  BTW, typo 'hwposioned' is fixed.

Link: https://lkml.kernel.org/r/20230727115643.639741-1-linmiaohe@huawei.com
Link: https://lkml.kernel.org/r/20230727115643.639741-2-linmiaohe@huawei.com
Fixes: 6b970599e807 ("mm: hwpoison: support recovery from ksm_might_need_to_copy()")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/ksm.c b/mm/ksm.c
index ba266359da55..d20d7662419b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2784,6 +2784,8 @@ struct page *ksm_might_need_to_copy(struct page *page,
 			anon_vma->root == vma->anon_vma->root) {
 		return page;		/* still no need to copy it */
 	}
+	if (PageHWPoison(page))
+		return ERR_PTR(-EHWPOISON);
 	if (!PageUptodate(page))
 		return page;		/* let do_swap_page report the error */
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8e6dde68b389..b15112b1f1a8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1746,7 +1746,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	struct page *swapcache;
 	spinlock_t *ptl;
 	pte_t *pte, new_pte, old_pte;
-	bool hwposioned = false;
+	bool hwpoisoned = PageHWPoison(page);
 	int ret = 1;
 
 	swapcache = page;
@@ -1754,7 +1754,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	if (unlikely(!page))
 		return -ENOMEM;
 	else if (unlikely(PTR_ERR(page) == -EHWPOISON))
-		hwposioned = true;
+		hwpoisoned = true;
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	if (unlikely(!pte || !pte_same_as_swp(ptep_get(pte),
@@ -1765,11 +1765,11 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 
 	old_pte = ptep_get(pte);
 
-	if (unlikely(hwposioned || !PageUptodate(page))) {
+	if (unlikely(hwpoisoned || !PageUptodate(page))) {
 		swp_entry_t swp_entry;
 
 		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
-		if (hwposioned) {
+		if (hwpoisoned) {
 			swp_entry = make_hwpoison_entry(swapcache);
 			page = swapcache;
 		} else {

