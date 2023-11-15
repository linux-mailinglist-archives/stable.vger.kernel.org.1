Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C0C7E2412
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjKFNRs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjKFNRr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:17:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB5DBF
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:17:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D0CC433C7;
        Mon,  6 Nov 2023 13:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276664;
        bh=qvFH7sPEQCgoshMpUe/7A2B9AtdW8r9wvQpR43rEj10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ii2WjHr7+ssy2u6G7Pr1h0IiKrOvc9gXBCsNRjJuhXBx8F5w3gCak66PqKKFtnvSs
         uhZPQJo7PKZ+/2BArH6BUopcauOGlvdFwNMzuQ9FTezn3t90XG4Y+5IvBSM1vlGb+0
         bjmlmScr8beEvOdug7/ZVTsR4cZB86GUv7dh3maE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Erhard Furtner <erhard_f@mailbox.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 57/88] powerpc/mm: Fix boot crash with FLATMEM
Date:   Mon,  6 Nov 2023 14:03:51 +0100
Message-ID: <20231106130307.906828554@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit daa9ada2093ed23d52b4c1fe6e13cf78f55cc85f ]

Erhard reported that his G5 was crashing with v6.6-rc kernels:

  mpic: Setting up HT PICs workarounds for U3/U4
  BUG: Unable to handle kernel data access at 0xfeffbb62ffec65fe
  Faulting instruction address: 0xc00000000005dc40
  Oops: Kernel access of bad area, sig: 11 [#1]
  BE PAGE_SIZE=4K MMU=Hash SMP NR_CPUS=2 PowerMac
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                T  6.6.0-rc3-PMacGS #1
  Hardware name: PowerMac11,2 PPC970MP 0x440101 PowerMac
  NIP:  c00000000005dc40 LR: c000000000066660 CTR: c000000000007730
  REGS: c0000000022bf510 TRAP: 0380   Tainted: G                T (6.6.0-rc3-PMacGS)
  MSR:  9000000000001032 <SF,HV,ME,IR,DR,RI>  CR: 44004242  XER: 00000000
  IRQMASK: 3
  GPR00: 0000000000000000 c0000000022bf7b0 c0000000010c0b00 00000000000001ac
  GPR04: 0000000003c80000 0000000000000300 c0000000f20001ae 0000000000000300
  GPR08: 0000000000000006 feffbb62ffec65ff 0000000000000001 0000000000000000
  GPR12: 9000000000001032 c000000002362000 c000000000f76b80 000000000349ecd8
  GPR16: 0000000002367ba8 0000000002367f08 0000000000000006 0000000000000000
  GPR20: 00000000000001ac c000000000f6f920 c0000000022cd985 000000000000000c
  GPR24: 0000000000000300 00000003b0a3691d c0003e008030000e 0000000000000000
  GPR28: c00000000000000c c0000000f20001ee feffbb62ffec65fe 00000000000001ac
  NIP hash_page_do_lazy_icache+0x50/0x100
  LR  __hash_page_4K+0x420/0x590
  Call Trace:
    hash_page_mm+0x364/0x6f0
    do_hash_fault+0x114/0x2b0
    data_access_common_virt+0x198/0x1f0
  --- interrupt: 300 at mpic_init+0x4bc/0x10c4
  NIP:  c000000002020a5c LR: c000000002020a04 CTR: 0000000000000000
  REGS: c0000000022bf9f0 TRAP: 0300   Tainted: G                T (6.6.0-rc3-PMacGS)
  MSR:  9000000000001032 <SF,HV,ME,IR,DR,RI>  CR: 24004248  XER: 00000000
  DAR: c0003e008030000e DSISR: 40000000 IRQMASK: 1
  ...
  NIP mpic_init+0x4bc/0x10c4
  LR  mpic_init+0x464/0x10c4
  --- interrupt: 300
    pmac_setup_one_mpic+0x258/0x2dc
    pmac_pic_init+0x28c/0x3d8
    init_IRQ+0x90/0x140
    start_kernel+0x57c/0x78c
    start_here_common+0x1c/0x20

A bisect pointed to the breakage beginning with commit 9fee28baa601 ("powerpc:
implement the new page table range API").

Analysis of the oops pointed to a struct page with a corrupted
compound_head being loaded via page_folio() -> _compound_head() in
hash_page_do_lazy_icache().

The access by the mpic code is to an MMIO address, so the expectation
is that the struct page for that address would be initialised by
init_unavailable_range(), as pointed out by Aneesh.

Instrumentation showed that was not the case, which eventually lead to
the realisation that pfn_valid() was returning false for that address,
causing the struct page to not be initialised.

Because the system is using FLATMEM, the version of pfn_valid() in
memory_model.h is used:

static inline int pfn_valid(unsigned long pfn)
{
	...
	return pfn >= pfn_offset && (pfn - pfn_offset) < max_mapnr;
}

Which relies on max_mapnr being initialised. Early in boot max_mapnr is
zero meaning no PFNs are valid.

max_mapnr is initialised in mem_init() called via:

  start_kernel()
    mm_core_init()  # init/main.c:928
      mem_init()

But that is too late for the usage in init_unavailable_range() called via:

  start_kernel()
    setup_arch()    # init/main.c:893
      paging_init()
        free_area_init()
          init_unavailable_range()

Although max_mapnr is currently set in mem_init(), the value is actually
already available much earlier, as soon as mem_topology_setup() has
completed, which is also before paging_init() is called. So move the
initialisation there, which causes paging_init() to correctly initialise
the struct page and fixes the bug.

This bug seems to have been lurking for years, but went unnoticed
because the pre-folio code was inspecting the uninitialised page->flags
but not dereferencing it.

Thanks to Erhard and Aneesh for help debugging.

Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Closes: https://lore.kernel.org/all/20230929132750.3cd98452@yea/
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231023112500.1550208-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/setup-common.c | 2 ++
 arch/powerpc/mm/mem.c              | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index d2a446216444f..d35ba3ac218bf 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -948,6 +948,8 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Parse memory topology */
 	mem_topology_setup();
+	/* Set max_mapnr before paging_init() */
+	set_max_mapnr(max_pfn);
 
 	/*
 	 * Release secondary cpus out of their spinloops at 0x60 now that
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 8b121df7b08f8..07e8f4f1e07f8 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -288,7 +288,6 @@ void __init mem_init(void)
 #endif
 
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
-	set_max_mapnr(max_pfn);
 
 	kasan_late_init();
 
-- 
2.42.0



