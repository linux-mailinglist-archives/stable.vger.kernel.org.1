Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E07742C5D
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjF2SsJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjF2Srx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:47:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A6335A3
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:47:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DF22615C8
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D57C433C8;
        Thu, 29 Jun 2023 18:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064471;
        bh=ASLn+QCzKWd4tsFWKXJGFpq1cv2XSOR+4e12OdBoAmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5fnG89y76M04pF3wr4wR6yPTrgtYsosCEISxWlpn0R5//VyF4n5WwA+0STCfuZQw
         fXs8iiV9afuawTGOchgpgLRuyX76/u3J/DK0DaaXHHtzocl4TRawl5b1qLvZeHRZef
         u0TpXmvmp6KQMXXb0SP2IYi+OH1g/eSbV3BnNlok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Hutchings <ben@decadent.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.4 14/28] mips/mm: Convert to using lock_mm_and_find_vma()
Date:   Thu, 29 Jun 2023 20:44:02 +0200
Message-ID: <20230629184152.450468738@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.888604958@linuxfoundation.org>
References: <20230629184151.888604958@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -91,6 +91,7 @@ config MIPS
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


