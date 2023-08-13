Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77AB77ABD2
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjHMV0G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjHMV0F (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:26:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B76610DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:26:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39B636297D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D6AC433C7;
        Sun, 13 Aug 2023 21:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961966;
        bh=xlPU23jxXPMnbzPzWzz2fH7e0311zWj5oUFeQwawzlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hm9UgzOjnmnhT2lQrYyPfiEjPwuph4+zBOEBZDUtq3OOXnfZ/DIRGep3O0LGawSIZ
         n2JmiYNjzvt1f8lCLQKEOS6LEGutGuPEQ8SzgrcS/MbGMv1z1/zGCzIUGCdHSK478h
         FGvN6BYfejOpINkmcgE5GdSwZDqyegasoQEGQHys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.4 034/206] riscv: mm: fix 2 instances of -Wmissing-variable-declarations
Date:   Sun, 13 Aug 2023 23:16:44 +0200
Message-ID: <20230813211725.979196124@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>

commit d2402048bc8a206a56fde4bc41dd01336c7b5a21 upstream.

I'm looking to enable -Wmissing-variable-declarations behind W=1. 0day
bot spotted the following instance in ARCH=riscv builds:

  arch/riscv/mm/init.c:276:7: warning: no previous extern declaration
  for non-static variable 'trampoline_pg_dir'
  [-Wmissing-variable-declarations]
  276 | pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
      |       ^
  arch/riscv/mm/init.c:276:1: note: declare 'static' if the variable is
  not intended to be used outside of this translation unit
  276 | pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
      | ^
  arch/riscv/mm/init.c:279:7: warning: no previous extern declaration
  for non-static variable 'early_pg_dir'
  [-Wmissing-variable-declarations]
  279 | pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
      |       ^
  arch/riscv/mm/init.c:279:1: note: declare 'static' if the variable is
  not intended to be used outside of this translation unit
  279 | pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
      | ^

These symbols are referenced by more than one translation unit, so make
sure they're both declared and include the correct header for their
declarations. Finally, sort the list of includes to help keep them tidy.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/llvm/202308081000.tTL1ElTr-lkp@intel.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20230808-riscv_static-v2-1-2a1e2d2c7a4f@google.com
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/include/asm/pgtable.h |    2 ++
 arch/riscv/mm/init.c             |    9 +++++----
 arch/riscv/mm/kasan_init.c       |    1 -
 3 files changed, 7 insertions(+), 5 deletions(-)

--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -188,6 +188,8 @@ extern struct pt_alloc_ops pt_ops __init
 #define PAGE_KERNEL_IO		__pgprot(_PAGE_IOREMAP)
 
 extern pgd_t swapper_pg_dir[];
+extern pgd_t trampoline_pg_dir[];
+extern pgd_t early_pg_dir[];
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int pmd_present(pmd_t pmd)
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -26,12 +26,13 @@
 #include <linux/kfence.h>
 
 #include <asm/fixmap.h>
-#include <asm/tlbflush.h>
-#include <asm/sections.h>
-#include <asm/soc.h>
 #include <asm/io.h>
-#include <asm/ptdump.h>
 #include <asm/numa.h>
+#include <asm/pgtable.h>
+#include <asm/ptdump.h>
+#include <asm/sections.h>
+#include <asm/soc.h>
+#include <asm/tlbflush.h>
 
 #include "../kernel/head.h"
 
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -22,7 +22,6 @@
  * region is not and then we have to go down to the PUD level.
  */
 
-extern pgd_t early_pg_dir[PTRS_PER_PGD];
 pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
 pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;


