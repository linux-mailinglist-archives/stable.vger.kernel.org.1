Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0033742C5C
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjF2SsI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjF2Srw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:47:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F89035A0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 671EA615E4
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B13BC433C8;
        Thu, 29 Jun 2023 18:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064467;
        bh=c9o5a26qAg1Kw9O761dNdydSXSFSxUQxl82xdwgqIlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mv+7OT/rHy8PwF4QxW1nKJWeydW41LJ3ecsU+jF6P4/wXXogP/zI3qu2qr43sGKn1
         3EPasvowvtxJjS7pzYkRqAkvCJHJdH5++cGv+QtX668j4k2YQYoNh2LN/pMsCvejPj
         UKRJY23A+yB5H7Ifx72m7OTFqHY3HWZ1MK9LiTVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.4 13/28] powerpc/mm: Convert to using lock_mm_and_find_vma()
Date:   Thu, 29 Jun 2023 20:44:01 +0200
Message-ID: <20230629184152.412128972@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.888604958@linuxfoundation.org>
References: <20230629184151.888604958@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>

commit e6fe228c4ffafdfc970cf6d46883a1f481baf7ea upstream.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/Kconfig    |    1 +
 arch/powerpc/mm/fault.c |   41 ++++-------------------------------------
 2 files changed, 5 insertions(+), 37 deletions(-)

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -278,6 +278,7 @@ config PPC
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select KASAN_VMALLOC			if KASAN && MODULES
+	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_PAGE_SIZE
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -84,11 +84,6 @@ static int __bad_area(struct pt_regs *re
 	return __bad_area_nosemaphore(regs, address, si_code);
 }
 
-static noinline int bad_area(struct pt_regs *regs, unsigned long address)
-{
-	return __bad_area(regs, address, SEGV_MAPERR);
-}
-
 static noinline int bad_access_pkey(struct pt_regs *regs, unsigned long address,
 				    struct vm_area_struct *vma)
 {
@@ -515,40 +510,12 @@ lock_mmap:
 	 * we will deadlock attempting to validate the fault against the
 	 * address space.  Luckily the kernel only validly references user
 	 * space from well defined areas of code, which are listed in the
-	 * exceptions table.
-	 *
-	 * As the vast majority of faults will be valid we will only perform
-	 * the source reference check when there is a possibility of a deadlock.
-	 * Attempt to lock the address space, if we cannot we then validate the
-	 * source.  If this is invalid we can skip the address space check,
-	 * thus avoiding the deadlock.
-	 */
-	if (unlikely(!mmap_read_trylock(mm))) {
-		if (!is_user && !search_exception_tables(regs->nip))
-			return bad_area_nosemaphore(regs, address);
-
+	 * exceptions table. lock_mm_and_find_vma() handles that logic.
+	 */
 retry:
-		mmap_read_lock(mm);
-	} else {
-		/*
-		 * The above down_read_trylock() might have succeeded in
-		 * which case we'll have missed the might_sleep() from
-		 * down_read():
-		 */
-		might_sleep();
-	}
-
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (unlikely(!vma))
-		return bad_area(regs, address);
-
-	if (unlikely(vma->vm_start > address)) {
-		if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
-			return bad_area(regs, address);
-
-		if (unlikely(expand_stack(vma, address)))
-			return bad_area(regs, address);
-	}
+		return bad_area_nosemaphore(regs, address);
 
 	if (unlikely(access_pkey_error(is_write, is_exec,
 				       (error_code & DSISR_KEYFAULT), vma)))


