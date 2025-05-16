Return-Path: <stable+bounces-144624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E7FABA2BD
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 20:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B746C7AAAA6
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 18:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63D627C144;
	Fri, 16 May 2025 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWe7OIQQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E327B4F2
	for <stable@vger.kernel.org>; Fri, 16 May 2025 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420007; cv=none; b=emD9xrxf4kyWk1OkU+oqorw/cDKX5zDh979GcV+Ev6Ktv4mu6x4Lgs9t+/656LGL2ybP5/CT0YDex0ZiRe8tohMnMpbrrGubCkVInTxuVl553wY/6hcv2odGHnnUXEoCL4CxiPPYh6NGVlaZAdj+FqlbR+f8AqGeF84if8uSpiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420007; c=relaxed/simple;
	bh=MuIf324VV6Rl83Q3Cq+Fryr7Mo/LwWrY3exmHbugTh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1c9DhnsdCD8Uda1Vv7Ot5lamLnUd6F6/PXplmiu2xEnuWZL/p3sP9m6ugqMZcH2WOySD4dg9RT0Gn8WJ3JBHBIiz7VurUVbtU28czoi/Qd5HCoEts0xcFi9gF//VDb8xSVNln4g4JOCZGnj1m6JyVEK4N4RfUS8Jsx5FWqtMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWe7OIQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02E0C4CEE4;
	Fri, 16 May 2025 18:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747420007;
	bh=MuIf324VV6Rl83Q3Cq+Fryr7Mo/LwWrY3exmHbugTh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hWe7OIQQ5HGKbQ5EmRkwBaaYqN72LjP9tGtZGp0LBCLca8ofFmgBc5hMZD74/TvaZ
	 YEYodO/SWMiVDU3dqeiwfRouSRZV4gOqyQdTadLRTz4dKHH6y6rWHcj3zYa8f14NFj
	 1uOi7dXbdnHt4HsPLWksExIjpoIRFDjdernzk5TWZALN9AlmAfnYyCLM/g9ljPUuJe
	 nApw+nOcNSJW5VjOZY9LksONm3AtFTb4B9VTBuz1z2jTzKGekMijxv6uOdq/JNIFNS
	 KJlgKkiLdH72GW3pGszfmDQt0LDZhEHn9seWvhFtz1SJYpH5rDcIWp126F83E5W/wT
	 Pv9gWuS/BkaZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Li <lizy04@hust.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] riscv: mm: Fix the out of bound issue of vmemmap address
Date: Fri, 16 May 2025 14:26:45 -0400
Message-Id: <20250516114313-e753086f6a134f63@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516064945.448213-1-lizy04@hust.edu.cn>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: f754f27e98f88428aaf6be6e00f5cbce97f62d4b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhaoyang Li<lizy04@hust.edu.cn>
Commit author: Xu Lu<luxu.kernel@bytedance.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: d2bd51954ac8)
6.6.y | Present (different SHA1: a4a7ac3d2660)

Note: The patch differs from the upstream commit:
---
1:  f754f27e98f88 ! 1:  0281b720e72e4 riscv: mm: Fix the out of bound issue of vmemmap address
    @@ Metadata
      ## Commit message ##
         riscv: mm: Fix the out of bound issue of vmemmap address
     
    +    [ Upstream commit f754f27e98f88428aaf6be6e00f5cbce97f62d4b ]
    +
         In sparse vmemmap model, the virtual address of vmemmap is calculated as:
         ((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT)).
         And the struct page's va can be calculated with an offset:
    @@ Commit message
         Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
         Link: https://lore.kernel.org/r/20241209122617.53341-1-luxu.kernel@bytedance.com
         Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
    +    Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
     
      ## arch/riscv/include/asm/page.h ##
     @@ arch/riscv/include/asm/page.h: struct kernel_mapping {
    @@ arch/riscv/include/asm/pgtable.h
     
      ## arch/riscv/mm/init.c ##
     @@
    - #include <asm/pgtable.h>
    - #include <asm/sections.h>
    - #include <asm/soc.h>
    + #include <linux/hugetlb.h>
    + 
    + #include <asm/fixmap.h>
     +#include <asm/sparsemem.h>
      #include <asm/tlbflush.h>
    - 
    - #include "../kernel/head.h"
    + #include <asm/sections.h>
    + #include <asm/soc.h>
     @@ arch/riscv/mm/init.c: EXPORT_SYMBOL(pgtable_l5_enabled);
      phys_addr_t phys_ram_base __ro_after_init;
      EXPORT_SYMBOL(phys_ram_base);
    @@ arch/riscv/mm/init.c: EXPORT_SYMBOL(pgtable_l5_enabled);
      							__page_aligned_bss;
      EXPORT_SYMBOL(empty_zero_page);
     @@ arch/riscv/mm/init.c: static void __init setup_bootmem(void)
    - 	 * Make sure we align the start of the memory on a PMD boundary so that
    - 	 * at worst, we map the linear mapping with PMD mappings.
    - 	 */
    + 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
    + 
    + 	phys_ram_end = memblock_end_of_DRAM();
     -	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
     +	if (!IS_ENABLED(CONFIG_XIP_KERNEL)) {
    - 		phys_ram_base = memblock_start_of_DRAM() & PMD_MASK;
    + 		phys_ram_base = memblock_start_of_DRAM();
     +#ifdef CONFIG_SPARSEMEM_VMEMMAP
     +		vmemmap_start_pfn = round_down(phys_ram_base, VMEMMAP_ADDR_ALIGN) >> PAGE_SHIFT;
     +#endif
    -+	}
    - 
    ++}
      	/*
    - 	 * In 64-bit, any use of __va/__pa before this point is wrong as we
    + 	 * Reserve physical address space that would be mapped to virtual
    + 	 * addresses greater than (void *)(-PAGE_SIZE) because:
     @@ arch/riscv/mm/init.c: asmlinkage void __init setup_vm(uintptr_t dtb_pa)
      	kernel_map.xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

