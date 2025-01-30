Return-Path: <stable+bounces-111244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17073A2272F
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 01:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563051885BEB
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 00:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9F29475;
	Thu, 30 Jan 2025 00:28:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D620328
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 00:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738196893; cv=none; b=HeXoLV+WXyJRuofDl1KfqNpI6WF/kiHHXOkyuuUfFBiFWPynoZe4kTlbBgOgr1/nbcDUqxEDh7p67B/HBaDm/wREt8AsNlPrnUFDXsLJxVlcLg5VcFK0aTlu3GKF7jUr3j8lO3ZEf1ihRwZotfx7TckZKhZ2fzlwnavOoIgxE14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738196893; c=relaxed/simple;
	bh=8Qd3LSR/v1Gpooq3yXly01B5i3pD++4woKuftvf7Mso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ts5YIZSXb4Py4TIKW7gpRqmE5lGkvjavM/EqC3zgUWuw7gdlOj8C3jjZnSfojvzN7XvnWOQUqfWFheY73W89cS+dtSXPgf0x6Mzb7XNESUwVK+Iue7lgev/VZ03aV89pCP0FhwVEs1qWKi8Xidf7RRm3O5hjnNP7cvAp410b06A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id D422B233B4;
	Thu, 30 Jan 2025 03:28:01 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH v2 5.10/5.15/6.1 1/5] x86/kasan: Map shadow for percpu pages on demand
Date: Thu, 30 Jan 2025 03:27:37 +0300
Message-Id: <20250130002741.66796-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20250130002741.66796-1-kovalev@altlinux.org>
References: <20250130002741.66796-1-kovalev@altlinux.org>
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
index 13e70da38bedaa..de75306b932efd 100644
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
index 6c2f1b76a0b610..d7081b1accca64 100644
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
index 1a50434c8a4dab..18d574af30efbc 100644
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


