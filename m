Return-Path: <stable+bounces-185787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF0FBDE0DA
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 12:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37DDE50358E
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6045E311C36;
	Wed, 15 Oct 2025 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YzXdfPps"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4662FBE1C
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524731; cv=none; b=VQilPxHU/6G/iubyPxGGPnOKbq9o2438S/8U+YnRdwezWTxhHcThaQm+W3F3dnVGUs07cFmqYGDB2HAQhI/GCzIoXs1ix2IvxUdCxCXGMghzQEDib9v47d5LYKJeQXMjUS6RfnM/4McjhvMrT69CVTTCsnzV4K7r+gyJTJJEDYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524731; c=relaxed/simple;
	bh=+ELVn4vyy+Q9AGK7PrbN71Pbgda79V9Vg1Fxymrt5Fo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NoEWpe1X6suOgiwBuEhM008lVTX3t9O84vFewX3eJjIrVQIcUSCeTagaFAMw2dTEfHdrhgQZImL1VKW7A41RvGK/0o7yicYKs+bhGWDkCvkpfEzKLNYjlpbND6tKBk+LSOm0x/41dnsbGbHBxuY12H8i6ceOGLNNommajMhR3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YzXdfPps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0A4C4CEF8;
	Wed, 15 Oct 2025 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760524730;
	bh=+ELVn4vyy+Q9AGK7PrbN71Pbgda79V9Vg1Fxymrt5Fo=;
	h=Subject:To:Cc:From:Date:From;
	b=YzXdfPpsnhebrIBeUBObDzZ/DuniANLQTSX8278tPcw44B+UVkgodRt78RpqFTiKg
	 q8Bqjjy7Zudi/AMsvkRX0wLkbh7CX0CLOJHnOT4+xw/Fn7nxe4+cbh6L++NFnkTdoN
	 5QJdAsChtvYtclvutDeo92qDamMYpOF1UM78/XRY=
Subject: FAILED: patch "[PATCH] arm64: map [_text, _stext) virtual address range" failed to apply to 6.6-stable tree
To: osandov@fb.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Oct 2025 12:38:48 +0200
Message-ID: <2025101548-stiffly-eagle-d9a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5973a62efa34c80c9a4e5eac1fca6f6209b902af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101548-stiffly-eagle-d9a5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5973a62efa34c80c9a4e5eac1fca6f6209b902af Mon Sep 17 00:00:00 2001
From: Omar Sandoval <osandov@fb.com>
Date: Fri, 19 Sep 2025 14:27:51 -0700
Subject: [PATCH] arm64: map [_text, _stext) virtual address range
 non-executable+read-only

Since the referenced fixes commit, the kernel's .text section is only
mapped starting from _stext; the region [_text, _stext) is omitted. As a
result, other vmalloc/vmap allocations may use the virtual addresses
nominally in the range [_text, _stext). This address reuse confuses
multiple things:

1. crash_prepare_elf64_headers() sets up a segment in /proc/vmcore
   mapping the entire range [_text, _end) to
   [__pa_symbol(_text), __pa_symbol(_end)). Reading an address in
   [_text, _stext) from /proc/vmcore therefore gives the incorrect
   result.
2. Tools doing symbolization (either by reading /proc/kallsyms or based
   on the vmlinux ELF file) will incorrectly identify vmalloc/vmap
   allocations in [_text, _stext) as kernel symbols.

In practice, both of these issues affect the drgn debugger.
Specifically, there were cases where the vmap IRQ stacks for some CPUs
were allocated in [_text, _stext). As a result, drgn could not get the
stack trace for a crash in an IRQ handler because the core dump
contained invalid data for the IRQ stack address. The stack addresses
were also symbolized as being in the _text symbol.

Fix this by bringing back the mapping of [_text, _stext), but now make
it non-executable and read-only. This prevents other allocations from
using it while still achieving the original goal of not mapping
unpredictable data as executable. Other than the changed protection,
this is effectively a revert of the fixes commit.

Fixes: e2a073dde921 ("arm64: omit [_text, _stext) from permanent kernel mapping")
Cc: stable@vger.kernel.org
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index e6d35eff1486..e8ddbde31a83 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -78,6 +78,12 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 	twopass |= enable_scs;
 	prot = twopass ? data_prot : text_prot;
 
+	/*
+	 * [_stext, _text) isn't executed after boot and contains some
+	 * non-executable, unpredictable data, so map it non-executable.
+	 */
+	map_segment(init_pg_dir, &pgdp, va_offset, _text, _stext, data_prot,
+		    false, root_level);
 	map_segment(init_pg_dir, &pgdp, va_offset, _stext, _etext, prot,
 		    !twopass, root_level);
 	map_segment(init_pg_dir, &pgdp, va_offset, __start_rodata,
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 77c7926a4df6..23c05dc7a8f2 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -214,7 +214,7 @@ static void __init request_standard_resources(void)
 	unsigned long i = 0;
 	size_t res_size;
 
-	kernel_code.start   = __pa_symbol(_stext);
+	kernel_code.start   = __pa_symbol(_text);
 	kernel_code.end     = __pa_symbol(__init_begin - 1);
 	kernel_data.start   = __pa_symbol(_sdata);
 	kernel_data.end     = __pa_symbol(_end - 1);
@@ -280,7 +280,7 @@ u64 cpu_logical_map(unsigned int cpu)
 
 void __init __no_sanitize_address setup_arch(char **cmdline_p)
 {
-	setup_initial_init_mm(_stext, _etext, _edata, _end);
+	setup_initial_init_mm(_text, _etext, _edata, _end);
 
 	*cmdline_p = boot_command_line;
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 70c2ca813c18..524d34a0e921 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -279,7 +279,7 @@ void __init arm64_memblock_init(void)
 	 * Register the kernel text, kernel data, initrd, and initial
 	 * pagetables with memblock.
 	 */
-	memblock_reserve(__pa_symbol(_stext), _end - _stext);
+	memblock_reserve(__pa_symbol(_text), _end - _text);
 	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
 		/* the generic initrd code expects virtual addresses */
 		initrd_start = __phys_to_virt(phys_initrd_start);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0ba1a15e7e74..10c258099581 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -965,8 +965,8 @@ void __init mark_linear_text_alias_ro(void)
 	/*
 	 * Remove the write permissions from the linear alias of .text/.rodata
 	 */
-	update_mapping_prot(__pa_symbol(_stext), (unsigned long)lm_alias(_stext),
-			    (unsigned long)__init_begin - (unsigned long)_stext,
+	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
+			    (unsigned long)__init_begin - (unsigned long)_text,
 			    PAGE_KERNEL_RO);
 }
 
@@ -1037,7 +1037,7 @@ static inline bool force_pte_mapping(void)
 static void __init map_mem(pgd_t *pgdp)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
-	phys_addr_t kernel_start = __pa_symbol(_stext);
+	phys_addr_t kernel_start = __pa_symbol(_text);
 	phys_addr_t kernel_end = __pa_symbol(__init_begin);
 	phys_addr_t start, end;
 	phys_addr_t early_kfence_pool;
@@ -1086,7 +1086,7 @@ static void __init map_mem(pgd_t *pgdp)
 	}
 
 	/*
-	 * Map the linear alias of the [_stext, __init_begin) interval
+	 * Map the linear alias of the [_text, __init_begin) interval
 	 * as non-executable now, and remove the write permission in
 	 * mark_linear_text_alias_ro() below (which will be called after
 	 * alternative patching has completed). This makes the contents
@@ -1113,6 +1113,10 @@ void mark_rodata_ro(void)
 	WRITE_ONCE(rodata_is_rw, false);
 	update_mapping_prot(__pa_symbol(__start_rodata), (unsigned long)__start_rodata,
 			    section_size, PAGE_KERNEL_RO);
+	/* mark the range between _text and _stext as read only. */
+	update_mapping_prot(__pa_symbol(_text), (unsigned long)_text,
+			    (unsigned long)_stext - (unsigned long)_text,
+			    PAGE_KERNEL_RO);
 }
 
 static void __init declare_vma(struct vm_struct *vma,
@@ -1183,7 +1187,7 @@ static void __init declare_kernel_vmas(void)
 {
 	static struct vm_struct vmlinux_seg[KERNEL_SEGMENT_COUNT];
 
-	declare_vma(&vmlinux_seg[0], _stext, _etext, VM_NO_GUARD);
+	declare_vma(&vmlinux_seg[0], _text, _etext, VM_NO_GUARD);
 	declare_vma(&vmlinux_seg[1], __start_rodata, __inittext_begin, VM_NO_GUARD);
 	declare_vma(&vmlinux_seg[2], __inittext_begin, __inittext_end, VM_NO_GUARD);
 	declare_vma(&vmlinux_seg[3], __initdata_begin, __initdata_end, VM_NO_GUARD);


