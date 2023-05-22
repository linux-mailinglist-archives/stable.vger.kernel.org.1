Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCB870C4D2
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 20:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjEVSCA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 14:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjEVSB5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 14:01:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A12C6
        for <stable@vger.kernel.org>; Mon, 22 May 2023 11:01:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F107F620D4
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17552C433D2;
        Mon, 22 May 2023 18:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684778515;
        bh=qFO/JxueFZUAJZuXqKy+wcixHdRcDSCLrky1W1I23Ds=;
        h=Subject:To:Cc:From:Date:From;
        b=u5Mhj+UpiEtnXzkPY47APXnvWHzixYApqQnoKmmN9fWN+KOoxm59xdU6nEzDHumW+
         GhIM7qXjtvzn95vDtxWVL4atWJc0JTKscVs6/saZXQnr0A1hIxJGaLV0xpMX/W+SVM
         sY7Z7E83VO4l60LmZ9aZHhzMIivRUf6c6Hl1jrVc=
Subject: FAILED: patch "[PATCH] powerpc/64s/radix: Fix soft dirty tracking" failed to apply to 4.19-stable tree
To:     mpe@ellerman.id.au, dan@danny.cz
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 19:01:52 +0100
Message-ID: <2023052252-favoring-gratuity-348b@gregkh>
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 66b2ca086210732954a7790d63d35542936fc664
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052252-favoring-gratuity-348b@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

66b2ca086210 ("powerpc/64s/radix: Fix soft dirty tracking")

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

