Return-Path: <stable+bounces-144576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 465B0AB9649
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 08:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE774E78EF
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 06:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6621F4621;
	Fri, 16 May 2025 06:50:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE844226545
	for <stable@vger.kernel.org>; Fri, 16 May 2025 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747378235; cv=none; b=Hie1daLV2ovMLtaedmsVZjrTxMYAcK4k0/w1rnRy7hW6/+k8a+m9tvlCjigxRjbngplsPqTIjcz95E0HmzJLHB0kUocOBzhXmXrVz47VUQ74MZVEK0pebxi6VNxuLJOyYUKH+TEPSoL8+LD5XPQuZrRVrdOETr+sK0/CHEpQghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747378235; c=relaxed/simple;
	bh=7pCU5BIlacSojhQHV6azZJsU14HPqY5mopC4jp/Blms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CDlZkYRdmxTPpqVS6ejxMN2aO9Su924W09V1T/FFdQMZbSUeUQ80MY1f2d8buGuEXV3LPbngcsT+GdayEzQeVzJwvA6QACIIhfb1kXn7rmE3QVVgKIvPMS7u1PNz68Ov+QMjm/9Wl3x2O9OnAe23z7E8XFqzSe5VphlCuG86vrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrAD3_xcV4CZodii9CA--.14373S2;
	Fri, 16 May 2025 14:49:57 +0800 (CST)
Received: from ubuntu.localdomain (unknown [10.12.190.56])
	by gateway (Coremail) with SMTP id _____wB35wgM4CZoCXTuAg--.63536S4;
	Fri, 16 May 2025 14:49:48 +0800 (CST)
From: Zhaoyang Li <lizy04@hust.edu.cn>
To: stable@vger.kernel.org
Cc: dzm91@hust.edu.cn,
	Xu Lu <luxu.kernel@bytedance.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Zhaoyang Li <lizy04@hust.edu.cn>
Subject: [PATCH 6.1.y] riscv: mm: Fix the out of bound issue of vmemmap address
Date: Fri, 16 May 2025 14:49:45 +0800
Message-Id: <20250516064945.448213-1-lizy04@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAD3_xcV4CZodii9CA--.14373S2
Authentication-Results: app1; spf=neutral smtp.mail=lizy04@hust.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4DCFyUZFyrZrW5GFyrtFb_yoW7Jr1fpF
	WkWFs5Cr45tFyxW3y7tw1j9ryDJ3Z5K3WagF47Ar9Ivw4YqFy8Xr4qg3W7XrykXaykJa48
	Wrs2kayFk3WjyaDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQSb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUv6pPUUUUU
X-CM-SenderInfo: rpsqjjixsriko6kx23oohg3hdfq/1tbiAQgEB2gmtWEFAAAFsQ

From: Xu Lu <luxu.kernel@bytedance.com>

[ Upstream commit f754f27e98f88428aaf6be6e00f5cbce97f62d4b ]

In sparse vmemmap model, the virtual address of vmemmap is calculated as:
((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT)).
And the struct page's va can be calculated with an offset:
(vmemmap + (pfn)).

However, when initializing struct pages, kernel actually starts from the
first page from the same section that phys_ram_base belongs to. If the
first page's physical address is not (phys_ram_base >> PAGE_SHIFT), then
we get an va below VMEMMAP_START when calculating va for it's struct page.

For example, if phys_ram_base starts from 0x82000000 with pfn 0x82000, the
first page in the same section is actually pfn 0x80000. During
init_unavailable_range(), we will initialize struct page for pfn 0x80000
with virtual address ((struct page *)VMEMMAP_START - 0x2000), which is
below VMEMMAP_START as well as PCI_IO_END.

This commit fixes this bug by introducing a new variable
'vmemmap_start_pfn' which is aligned with memory section size and using
it to calculate vmemmap address instead of phys_ram_base.

Fixes: a11dd49dcb93 ("riscv: Sparse-Memory/vmemmap out-of-bounds fix")
Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20241209122617.53341-1-luxu.kernel@bytedance.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
---
 arch/riscv/include/asm/page.h    |  1 +
 arch/riscv/include/asm/pgtable.h |  2 +-
 arch/riscv/mm/init.c             | 17 ++++++++++++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 86048c60f700..fd861ac47a89 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -115,6 +115,7 @@ struct kernel_mapping {
 
 extern struct kernel_mapping kernel_map;
 extern phys_addr_t phys_ram_base;
+extern unsigned long vmemmap_start_pfn;
 
 #define is_kernel_mapping(x)	\
 	((x) >= kernel_map.virt_addr && (x) < (kernel_map.virt_addr + kernel_map.size))
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7d1688f850c3..bb19a643c5c2 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -79,7 +79,7 @@
  * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if kernel
  * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
  */
-#define vmemmap		((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT))
+#define vmemmap		((struct page *)VMEMMAP_START - vmemmap_start_pfn)
 
 #define PCI_IO_SIZE      SZ_16M
 #define PCI_IO_END       VMEMMAP_START
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index ba2210b553f9..72b3462babbf 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -22,6 +22,7 @@
 #include <linux/hugetlb.h>
 
 #include <asm/fixmap.h>
+#include <asm/sparsemem.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
 #include <asm/soc.h>
@@ -52,6 +53,13 @@ EXPORT_SYMBOL(pgtable_l5_enabled);
 phys_addr_t phys_ram_base __ro_after_init;
 EXPORT_SYMBOL(phys_ram_base);
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#define VMEMMAP_ADDR_ALIGN	(1ULL << SECTION_SIZE_BITS)
+
+unsigned long vmemmap_start_pfn __ro_after_init;
+EXPORT_SYMBOL(vmemmap_start_pfn);
+#endif
+
 unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 							__page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
@@ -210,8 +218,12 @@ static void __init setup_bootmem(void)
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
 	phys_ram_end = memblock_end_of_DRAM();
-	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
+	if (!IS_ENABLED(CONFIG_XIP_KERNEL)) {
 		phys_ram_base = memblock_start_of_DRAM();
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+		vmemmap_start_pfn = round_down(phys_ram_base, VMEMMAP_ADDR_ALIGN) >> PAGE_SHIFT;
+#endif
+}
 	/*
 	 * Reserve physical address space that would be mapped to virtual
 	 * addresses greater than (void *)(-PAGE_SIZE) because:
@@ -946,6 +958,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
 
 	phys_ram_base = CONFIG_PHYS_RAM_BASE;
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	vmemmap_start_pfn = round_down(phys_ram_base, VMEMMAP_ADDR_ALIGN) >> PAGE_SHIFT;
+#endif
 	kernel_map.phys_addr = (uintptr_t)CONFIG_PHYS_RAM_BASE;
 	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
 
-- 
2.25.1


