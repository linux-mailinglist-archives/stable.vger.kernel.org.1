Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888EC7DE051
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 12:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbjKAL2h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 07:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjKAL2g (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 07:28:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01502109
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 04:28:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172C0C433C8;
        Wed,  1 Nov 2023 11:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698838110;
        bh=OCd6wJrw5WsMjBIP7ypVHOmY7pQrYbw+2A8PZup3l9c=;
        h=Subject:To:Cc:From:Date:From;
        b=MnZLLjun7xwZfFQYhcVn2YKEblsT2HtOvabPNKX7ueTG5CZEFCWQT7LG4hwCmmQnG
         QGpUgTAPPce0bZtgN9ItgzuD2OPXa5LQ83WbUFqRW6rShhu2u7PvcEg5R403QVtf9H
         ZikTL9wu35a78RZkhbPLOl2xJJvFMooQlvnnk60U=
Subject: FAILED: patch "[PATCH] riscv: fix set_huge_pte_at() for NAPOT mappings when a swap" failed to apply to 6.5-stable tree
To:     alexghiti@rivosinc.com, ajones@ventanamicro.com,
        akpm@linux-foundation.org, aou@eecs.berkeley.edu, conor@kernel.org,
        palmer@dabbelt.com, panqinglin2020@iscas.ac.cn,
        paul.walmsley@sifive.com, ryan.roberts@arm.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 01 Nov 2023 12:28:27 +0100
Message-ID: <2023110127-chip-surfacing-4583@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 1de195dd0e05d9cba43dec16f83d4ee32af94dd2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023110127-chip-surfacing-4583@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

1de195dd0e05 ("riscv: fix set_huge_pte_at() for NAPOT mappings when a swap entry is set")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1de195dd0e05d9cba43dec16f83d4ee32af94dd2 Mon Sep 17 00:00:00 2001
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 28 Sep 2023 17:18:46 +0200
Subject: [PATCH] riscv: fix set_huge_pte_at() for NAPOT mappings when a swap
 entry is set

We used to determine the number of page table entries to set for a NAPOT
hugepage by using the pte value which actually fails when the pte to set
is a swap entry.

So take advantage of a recent fix for arm64 reported in [1] which
introduces the size of the mapping as an argument of set_huge_pte_at(): we
can then use this size to compute the number of page table entries to set
for a NAPOT region.

Link: https://lkml.kernel.org/r/20230928151846.8229-3-alexghiti@rivosinc.com
Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lore.kernel.org/linux-arm-kernel/20230922115804.2043771-1-ryan.roberts@arm.com/ [1]
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Qinglin Pan <panqinglin2020@iscas.ac.cn>
Cc: Conor Dooley <conor@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index e4a2ace92dbe..b52f0210481f 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -183,15 +183,22 @@ void set_huge_pte_at(struct mm_struct *mm,
 		     pte_t pte,
 		     unsigned long sz)
 {
+	unsigned long hugepage_shift;
 	int i, pte_num;
 
-	if (!pte_napot(pte)) {
-		set_pte_at(mm, addr, ptep, pte);
-		return;
-	}
+	if (sz >= PGDIR_SIZE)
+		hugepage_shift = PGDIR_SHIFT;
+	else if (sz >= P4D_SIZE)
+		hugepage_shift = P4D_SHIFT;
+	else if (sz >= PUD_SIZE)
+		hugepage_shift = PUD_SHIFT;
+	else if (sz >= PMD_SIZE)
+		hugepage_shift = PMD_SHIFT;
+	else
+		hugepage_shift = PAGE_SHIFT;
 
-	pte_num = napot_pte_num(napot_cont_order(pte));
-	for (i = 0; i < pte_num; i++, ptep++, addr += PAGE_SIZE)
+	pte_num = sz >> hugepage_shift;
+	for (i = 0; i < pte_num; i++, ptep++, addr += (1 << hugepage_shift))
 		set_pte_at(mm, addr, ptep, pte);
 }
 

