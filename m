Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336CB742C35
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjF2Sqg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjF2Sqc (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:46:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CA82D56
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13D1E61600
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2478FC433C9;
        Thu, 29 Jun 2023 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064389;
        bh=4Z+ZFfJYnu670Elbo/rlN4C03wQzQkNKrdg+GbtIfzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nc2w9x+k3VYysptWjT5UfhitBaOpMF9AjZnEvtjeZvgKgj0Kt3aYEs1WvDbg+uUn+
         OJtwGToND1Re1jbcwZy5P87kLe1V4aGqED1Ck5vdWNRORbefQukxRjJzl00HcFd+tp
         mMhv0zyYJjFIsmMdOZdiaWWUfdXmCr5N5tY9OExs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Hutchings <ben@decadent.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.3 16/29] mips/mm: Convert to using lock_mm_and_find_vma()
Date:   Thu, 29 Jun 2023 20:43:46 +0200
Message-ID: <20230629184152.387459495@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.705870770@linuxfoundation.org>
References: <20230629184151.705870770@linuxfoundation.org>
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

From: Ben Hutchings <ben@decadent.org.uk>

commit 4bce37a68ff884e821a02a731897a8119e0c37b7 upstream.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/Kconfig    |    1 +
 arch/mips/mm/fault.c |   12 ++----------
 2 files changed, 3 insertions(+), 10 deletions(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -94,6 +94,7 @@ config MIPS
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
 	select IRQ_FORCED_THREADING
 	select ISA if EISA
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_REL if MODULES
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select PERF_USE_VMALLOC
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -99,21 +99,13 @@ static void __do_page_fault(struct pt_re
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
+		goto bad_area_nosemaphore;
 /*
  * Ok, we have a good vm_area for this memory access, so
  * we can handle it..
  */
-good_area:
 	si_code = SEGV_ACCERR;
 
 	if (write) {


