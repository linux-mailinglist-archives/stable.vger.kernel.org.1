Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D436170C4D3
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 20:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjEVSCH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 14:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEVSCG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 14:02:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471FD90
        for <stable@vger.kernel.org>; Mon, 22 May 2023 11:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D88E1620D4
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A5CC433D2;
        Mon, 22 May 2023 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684778524;
        bh=WGa9wHQpnIqXpfW7jWh1qvx64uKycRU2BxBp5PH7XM4=;
        h=Subject:To:Cc:From:Date:From;
        b=SWQ1M6EQe7aosky7qiuyds9phoNHgVnio2oYHbNewYjSXgfFemc/nFLGNCmQlQq2g
         rBMUwDlIdclslCyLm72ZPHdsA/Nqw227S0A71NYylvoxCpOqd1r+68PHyRsCqK57CU
         6H1awhaJ2K8WrvlIk/l8UYCrPRtY9KWTWonyHjmo=
Subject: FAILED: patch "[PATCH] powerpc/64s/radix: Fix soft dirty tracking" failed to apply to 4.14-stable tree
To:     mpe@ellerman.id.au, dan@danny.cz
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 19:01:53 +0100
Message-ID: <2023052253-oppressed-blurb-418a@gregkh>
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 66b2ca086210732954a7790d63d35542936fc664
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052253-oppressed-blurb-418a@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

66b2ca086210 ("powerpc/64s/radix: Fix soft dirty tracking")
47d99948eee4 ("powerpc/mm: Move book3s64 specifics in subdirectory mm/book3s64")
fb0b0a73b223 ("powerpc: Enable kcov")
e66c3209c7fd ("powerpc: Move page table dump files in a dedicated subdirectory")
7c91efce1608 ("powerpc/mm: dump block address translation on book3s/32")
0261a508c9fc ("powerpc/mm: dump segment registers on book3s/32")
32ea4c149990 ("powerpc/mm: Extend pte_fragment functionality to PPC32")
a74791dd9833 ("powerpc/mm: add helpers to get/set mm.context->pte_frag")
d09780f3a8d4 ("powerpc/mm: Move pgtable_t into platform headers")
994da93d1968 ("powerpc/mm: move platform specific mmu-xxx.h in platform directories")
a95d133c8643 ("powerpc/mm: Move pte_fragment_alloc() to a common location")
a43ccc4bc499 ("powerpc/book3s32: Remove CONFIG_BOOKE dependent code")
5b3e84fc10dd ("powerpc: change CONFIG_PPC_STD_MMU to CONFIG_PPC_BOOK3S")
68289ae935da ("powerpc: change CONFIG_PPC_STD_MMU_32 to CONFIG_PPC_BOOK3S_32")
9a8dd708d547 ("memblock: rename memblock_alloc{_nid,_try_nid} to memblock_phys_alloc*")
48e7b7695745 ("powerpc/64s/hash: Convert SLB miss handlers to C")
97026b5a5ac2 ("powerpc/mm: Split dump_pagelinuxtables flag_array table")
34eb138ed74d ("powerpc/mm: don't use _PAGE_EXEC for calling hash_preload()")
c766ee72235d ("powerpc: handover page flags with a pgprot_t parameter")
56f3c1413f5c ("powerpc/mm: properly set PAGE_KERNEL flags in ioremap()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 66b2ca086210732954a7790d63d35542936fc664 Mon Sep 17 00:00:00 2001
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 11 May 2023 21:42:24 +1000
Subject: [PATCH] powerpc/64s/radix: Fix soft dirty tracking
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It was reported that soft dirty tracking doesn't work when using the
Radix MMU.

The tracking is supposed to work by clearing the soft dirty bit for a
mapping and then write protecting the PTE. If/when the page is written
to, a page fault occurs and the soft dirty bit is added back via
pte_mkdirty(). For example in wp_page_reuse():

	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
	if (ptep_set_access_flags(vma, vmf->address, vmf->pte, entry, 1))
		update_mmu_cache(vma, vmf->address, vmf->pte);

Unfortunately on radix _PAGE_SOFTDIRTY is being dropped by
radix__ptep_set_access_flags(), called from ptep_set_access_flags(),
meaning the soft dirty bit is not set even though the page has been
written to.

Fix it by adding _PAGE_SOFTDIRTY to the set of bits that are able to be
changed in radix__ptep_set_access_flags().

Fixes: b0b5e9b13047 ("powerpc/mm/radix: Add radix pte #defines")
Cc: stable@vger.kernel.org # v4.7+
Reported-by: Dan Horák <dan@danny.cz>
Link: https://lore.kernel.org/r/20230511095558.56663a50f86bdc4cd97700b7@danny.cz
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230511114224.977423-1-mpe@ellerman.id.au

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 26245aaf12b8..2297aa764ecd 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1040,8 +1040,8 @@ void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
 				  pte_t entry, unsigned long address, int psize)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
-					      _PAGE_RW | _PAGE_EXEC);
+	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_SOFT_DIRTY |
+					      _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
 
 	unsigned long change = pte_val(entry) ^ pte_val(*ptep);
 	/*

