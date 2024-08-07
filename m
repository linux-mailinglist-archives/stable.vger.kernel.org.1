Return-Path: <stable+bounces-65655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D3F94AB4B
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AAE2817E2
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BAB12EBE7;
	Wed,  7 Aug 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xcQY+Oz4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAE512D773;
	Wed,  7 Aug 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043051; cv=none; b=D5gIHmnpuj0827Ny+mDHB+HFctP02tWNXVKIRKFZ5U6jlhCAjDGc72q+tYBpRu5FncthkFZFR2h56db9HlvEQRCt2km2yhVhWUfv0BFxmIU8IbS+UVEYbWjQQ5++gTHz2FpvhRYWCMEdRVHf9/TSZivLJO+PxcXKMupR+AfYDhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043051; c=relaxed/simple;
	bh=nGv3eJ8StJB1YGzdUHoo3F3+z1pR1idae4e6QKWB5Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8gdVg0zt+O+hjkwLWJ247UNbKWT9ZlHljTUu23bYKR2fbF38ZIuwvc7tQgyiCabUR1bIjq24hLQu0qidmtCL1Kd8RG3/BLqHSJXnGYM0Ej9M32FGw7A1XtKOvISy9Gcgv/Vui/Ahq56KNqpAEMS+i/9HG4tBCRAB1Jt9BwkP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xcQY+Oz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E751C32781;
	Wed,  7 Aug 2024 15:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043051;
	bh=nGv3eJ8StJB1YGzdUHoo3F3+z1pR1idae4e6QKWB5Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xcQY+Oz4Dc7bS66ZYWjXDtl7VIpN6npP51zCtGZxgnQmvQSF82Zh/lkyhnQbr/CDt
	 5CfD//ixVQyIIH+A7YzOKesUTCDbNuBVENX7t0vFX6kLsU0h5CjXHkS8M2WmrjWgJ1
	 oSbbfUqmJPcONGh5clFrQ7weJU9uUmvEtuXDsJZ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stuart Menefy <stuart.menefy@codasip.com>,
	David McKay <david.mckay@codasip.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 073/123] riscv: Fix linear mapping checks for non-contiguous memory regions
Date: Wed,  7 Aug 2024 16:59:52 +0200
Message-ID: <20240807150023.163517080@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>
References: <20240807150020.790615758@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stuart Menefy <stuart.menefy@codasip.com>

[ Upstream commit 3b6564427aea83b7a35a15ca278291d50a1edcfc ]

The RISC-V kernel already has checks to ensure that memory which would
lie outside of the linear mapping is not used. However those checks
use memory_limit, which is used to implement the mem= kernel command
line option (to limit the total amount of memory, not its address
range). When memory is made up of two or more non-contiguous memory
banks this check is incorrect.

Two changes are made here:
 - add a call in setup_bootmem() to memblock_cap_memory_range() which
   will cause any memory which falls outside the linear mapping to be
   removed from the memory regions.
 - remove the check in create_linear_mapping_page_table() which was
   intended to remove memory which is outside the liner mapping based
   on memory_limit, as it is no longer needed. Note a check for
   mapping more memory than memory_limit (to implement mem=) is
   unnecessary because of the existing call to
   memblock_enforce_memory_limit().

This issue was seen when booting on a SV39 platform with two memory
banks:
  0x00,80000000 1GiB
  0x20,00000000 32GiB
This memory range is 158GiB from top to bottom, but the linear mapping
is limited to 128GiB, so the lower block of RAM will be mapped at
PAGE_OFFSET, and the upper block straddles the top of the linear
mapping.

This causes the following Oops:
[    0.000000] Linux version 6.10.0-rc2-gd3b8dd5b51dd-dirty (stuart.menefy@codasip.com) (riscv64-codasip-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41.0.20231213) #20 SMP Sat Jun 22 11:34:22 BST 2024
[    0.000000] memblock_add: [0x0000000080000000-0x00000000bfffffff] early_init_dt_add_memory_arch+0x4a/0x52
[    0.000000] memblock_add: [0x0000002000000000-0x00000027ffffffff] early_init_dt_add_memory_arch+0x4a/0x52
...
[    0.000000] memblock_alloc_try_nid: 23724 bytes align=0x8 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 early_init_dt_alloc_memory_arch+0x1e/0x48
[    0.000000] memblock_reserve: [0x00000027ffff5350-0x00000027ffffaffb] memblock_alloc_range_nid+0xb8/0x132
[    0.000000] Unable to handle kernel paging request at virtual address fffffffe7fff5350
[    0.000000] Oops [#1]
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.10.0-rc2-gd3b8dd5b51dd-dirty #20
[    0.000000] Hardware name: codasip,a70x (DT)
[    0.000000] epc : __memset+0x8c/0x104
[    0.000000]  ra : memblock_alloc_try_nid+0x74/0x84
[    0.000000] epc : ffffffff805e88c8 ra : ffffffff806148f6 sp : ffffffff80e03d50
[    0.000000]  gp : ffffffff80ec4158 tp : ffffffff80e0bec0 t0 : fffffffe7fff52f8
[    0.000000]  t1 : 00000027ffffb000 t2 : 5f6b636f6c626d65 s0 : ffffffff80e03d90
[    0.000000]  s1 : 0000000000005cac a0 : fffffffe7fff5350 a1 : 0000000000000000
[    0.000000]  a2 : 0000000000005cac a3 : fffffffe7fffaff8 a4 : 000000000000002c
[    0.000000]  a5 : ffffffff805e88c8 a6 : 0000000000005cac a7 : 0000000000000030
[    0.000000]  s2 : fffffffe7fff5350 s3 : ffffffffffffffff s4 : 0000000000000000
[    0.000000]  s5 : ffffffff8062347e s6 : 0000000000000000 s7 : 0000000000000001
[    0.000000]  s8 : 0000000000002000 s9 : 00000000800226d0 s10: 0000000000000000
[    0.000000]  s11: 0000000000000000 t3 : ffffffff8080a928 t4 : ffffffff8080a928
[    0.000000]  t5 : ffffffff8080a928 t6 : ffffffff8080a940
[    0.000000] status: 0000000200000100 badaddr: fffffffe7fff5350 cause: 000000000000000f
[    0.000000] [<ffffffff805e88c8>] __memset+0x8c/0x104
[    0.000000] [<ffffffff8062349c>] early_init_dt_alloc_memory_arch+0x1e/0x48
[    0.000000] [<ffffffff8043e892>] __unflatten_device_tree+0x52/0x114
[    0.000000] [<ffffffff8062441e>] unflatten_device_tree+0x9e/0xb8
[    0.000000] [<ffffffff806046fe>] setup_arch+0xd4/0x5bc
[    0.000000] [<ffffffff806007aa>] start_kernel+0x76/0x81a
[    0.000000] Code: b823 02b2 bc23 02b2 b023 04b2 b423 04b2 b823 04b2 (bc23) 04b2
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

The problem is that memblock (unaware that some physical memory cannot
be used) has allocated memory from the top of memory but which is
outside the linear mapping region.

Signed-off-by: Stuart Menefy <stuart.menefy@codasip.com>
Fixes: c99127c45248 ("riscv: Make sure the linear mapping does not use the kernel mapping")
Reviewed-by: David McKay <david.mckay@codasip.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20240622114217.2158495-1-stuart.menefy@codasip.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/init.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e3405e4b99af5..7e25606f858aa 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -233,8 +233,6 @@ static void __init setup_bootmem(void)
 	 */
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
-	phys_ram_end = memblock_end_of_DRAM();
-
 	/*
 	 * Make sure we align the start of the memory on a PMD boundary so that
 	 * at worst, we map the linear mapping with PMD mappings.
@@ -249,6 +247,16 @@ static void __init setup_bootmem(void)
 	if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_MMU))
 		kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
 
+	/*
+	 * The size of the linear page mapping may restrict the amount of
+	 * usable RAM.
+	 */
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		max_mapped_addr = __pa(PAGE_OFFSET) + KERN_VIRT_SIZE;
+		memblock_cap_memory_range(phys_ram_base,
+					  max_mapped_addr - phys_ram_base);
+	}
+
 	/*
 	 * Reserve physical address space that would be mapped to virtual
 	 * addresses greater than (void *)(-PAGE_SIZE) because:
@@ -265,6 +273,7 @@ static void __init setup_bootmem(void)
 		memblock_reserve(max_mapped_addr, (phys_addr_t)-max_mapped_addr);
 	}
 
+	phys_ram_end = memblock_end_of_DRAM();
 	min_low_pfn = PFN_UP(phys_ram_base);
 	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
 	high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
@@ -1289,8 +1298,6 @@ static void __init create_linear_mapping_page_table(void)
 		if (start <= __pa(PAGE_OFFSET) &&
 		    __pa(PAGE_OFFSET) < end)
 			start = __pa(PAGE_OFFSET);
-		if (end >= __pa(PAGE_OFFSET) + memory_limit)
-			end = __pa(PAGE_OFFSET) + memory_limit;
 
 		create_linear_mapping_range(start, end, 0);
 	}
-- 
2.43.0




