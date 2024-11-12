Return-Path: <stable+bounces-92850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E08139C6495
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 23:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE7EB277B3
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 22:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0B21A71D;
	Tue, 12 Nov 2024 22:48:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D8218956
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451711; cv=none; b=UznvLI3Xjf2F+mGpIguuKY1NQ48ov+TrtdXE9YB625QsQZvxIm7u4lVjCm7kXQfpxUnzVV3aFv5VzZ4q6d8ZL/hzrxQ74xxpDDfwO88evR6pIvFU+8Z1BWuv4b4wkbRhTaZk08NIe/uaWF71/WaWt2i97rNPCqR3F/K6pG9SVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451711; c=relaxed/simple;
	bh=qhsNHIRZNTZ++y4zSMSW0xPvYBTEncuVJB93Ov65UY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d9oeCl+HO4sDzUEEn4+5OT5hfcKBjxbCxuq+0e4ugkHoo+mPMR8zZKxI1ZstMBpnHhiKX1LlR+0IDyhGgiFbwqdlKf+Fx7mtNbTiILjHy5+XB2eqQqN8d9vsEuSXzMyv3Jl1NpBYwyr1RGcT4LFVJXJ636Ge2ZklAhHLbc5xgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id BFEC0233C9;
	Wed, 13 Nov 2024 01:42:27 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: lvc-patches@linuxtesting.org,
	nickel@altlinux.org,
	dutyrok@altlinux.org,
	gerben@altlinux.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10/5.15/6.1 1/5] x86/kasan: Map shadow for percpu pages on demand
Date: Wed, 13 Nov 2024 01:41:57 +0300
Message-Id: <20241112224201.289285-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20241112224201.289285-1-kovalev@altlinux.org>
References: <20241112224201.289285-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrey Ryabinin <ryabinin.a.a@gmail.com>

commit 3f148f3318140035e87decc1214795ff0755757b upstream.

KASAN maps shadow for the entire CPU-entry-area:
  [CPU_ENTRY_AREA_BASE, CPU_ENTRY_AREA_BASE + CPU_ENTRY_AREA_MAP_SIZE]

This will explode once the per-cpu entry areas are randomized since it
will increase CPU_ENTRY_AREA_MAP_SIZE to 512 GB and KASAN fails to
allocate shadow for such big area.

Fix this by allocating KASAN shadow only for really used cpu entry area
addresses mapped by cea_map_percpu_pages()

Thanks to the 0day folks for finding and reporting this to be an issue.

[ dhansen: tweak changelog since this will get committed before peterz's
	   actual cpu-entry-area randomization ]

Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Yujie Liu <yujie.liu@intel.com>
Cc: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/r/202210241508.2e203c3d-yujie.liu@intel.com
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 arch/x86/include/asm/kasan.h |  3 +++
 arch/x86/mm/cpu_entry_area.c |  8 +++++++-
 arch/x86/mm/kasan_init_64.c  | 15 ++++++++++++---
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index 13e70da38beda..de75306b932ef 100644
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -28,9 +28,12 @@
 #ifdef CONFIG_KASAN
 void __init kasan_early_init(void);
 void __init kasan_init(void);
+void __init kasan_populate_shadow_for_vaddr(void *va, size_t size, int nid);
 #else
 static inline void kasan_early_init(void) { }
 static inline void kasan_init(void) { }
+static inline void kasan_populate_shadow_for_vaddr(void *va, size_t size,
+						   int nid) { }
 #endif
 
 #endif
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 6c2f1b76a0b61..d7081b1accca6 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -9,6 +9,7 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/fixmap.h>
 #include <asm/desc.h>
+#include <asm/kasan.h>
 
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage);
 
@@ -53,8 +54,13 @@ void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
 static void __init
 cea_map_percpu_pages(void *cea_vaddr, void *ptr, int pages, pgprot_t prot)
 {
+	phys_addr_t pa = per_cpu_ptr_to_phys(ptr);
+
+	kasan_populate_shadow_for_vaddr(cea_vaddr, pages * PAGE_SIZE,
+					early_pfn_to_nid(PFN_DOWN(pa)));
+
 	for ( ; pages; pages--, cea_vaddr+= PAGE_SIZE, ptr += PAGE_SIZE)
-		cea_set_pte(cea_vaddr, per_cpu_ptr_to_phys(ptr), prot);
+		cea_set_pte(cea_vaddr, pa, prot);
 }
 
 static void __init percpu_setup_debug_store(unsigned int cpu)
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 1a50434c8a4da..18d574af30efb 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -318,6 +318,18 @@ void __init kasan_early_init(void)
 	kasan_map_early_shadow(init_top_pgt);
 }
 
+void __init kasan_populate_shadow_for_vaddr(void *va, size_t size, int nid)
+{
+	unsigned long shadow_start, shadow_end;
+
+	shadow_start = (unsigned long)kasan_mem_to_shadow(va);
+	shadow_start = round_down(shadow_start, PAGE_SIZE);
+	shadow_end = (unsigned long)kasan_mem_to_shadow(va + size);
+	shadow_end = round_up(shadow_end, PAGE_SIZE);
+
+	kasan_populate_shadow(shadow_start, shadow_end, nid);
+}
+
 void __init kasan_init(void)
 {
 	int i;
@@ -395,9 +407,6 @@ void __init kasan_init(void)
 		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
 		shadow_cpu_entry_begin);
 
-	kasan_populate_shadow((unsigned long)shadow_cpu_entry_begin,
-			      (unsigned long)shadow_cpu_entry_end, 0);
-
 	kasan_populate_early_shadow(shadow_cpu_entry_end,
 			kasan_mem_to_shadow((void *)__START_KERNEL_map));
 
-- 
2.33.8


