Return-Path: <stable+bounces-92853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565129C6477
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 23:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1552128482B
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61321A717;
	Tue, 12 Nov 2024 22:48:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433C219E5C
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451712; cv=none; b=VC8AhbKfLCjzaAtSZfRhQpurvpfHznO+ieV0+i/cRPgy5pkyPXS6I3+wK2fcT4kCbeZoYMZZi/eAqKCj4UmCGUjE7ASkf84Hni3bERtZfmuIopOZiKA8XBDMQAA6Q3LRQ3gqq5DZcxnjUlx2E0KhYUOsckdpVrFb/MqepYg0Fqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451712; c=relaxed/simple;
	bh=VveB5UZdAqnQaHKsiYO58GK4CG02+DJeLutWVIymkxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uP1dxj7I6e32Xf0SuLkcQvilRl2ai6aUvjp3iw5oyAuALSj9Y4rtX4qTcga0rAameiAmryGwVptzLbYBLYrcQoiI6fQNN4sCF37NAK7L/9FeybiICv4eYQ90PvHeg0dHDM8XAFjFl64jtdm0ApnyQLsHs+5wGZD5SeNwIwaxcDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id D0862233DC;
	Wed, 13 Nov 2024 01:42:30 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: lvc-patches@linuxtesting.org,
	nickel@altlinux.org,
	dutyrok@altlinux.org,
	gerben@altlinux.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10/5.15/6.1 4/5] x86/mm: Randomize per-cpu entry area
Date: Wed, 13 Nov 2024 01:42:00 +0300
Message-Id: <20241112224201.289285-5-kovalev@altlinux.org>
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

From: Peter Zijlstra <peterz@infradead.org>

commit 97e3d26b5e5f371b3ee223d94dd123e6c442ba80 upstream.

Seth found that the CPU-entry-area; the piece of per-cpu data that is
mapped into the userspace page-tables for kPTI is not subject to any
randomization -- irrespective of kASLR settings.

On x86_64 a whole P4D (512 GB) of virtual address space is reserved for
this structure, which is plenty large enough to randomize things a
little.

As such, use a straight forward randomization scheme that avoids
duplicates to spread the existing CPUs over the available space.

  [ bp: Fix le build. ]

Reported-by: Seth Jenkins <sethjenkins@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 arch/x86/include/asm/cpu_entry_area.h |  4 ---
 arch/x86/include/asm/pgtable_areas.h  |  8 ++++-
 arch/x86/kernel/hw_breakpoint.c       |  2 +-
 arch/x86/mm/cpu_entry_area.c          | 47 ++++++++++++++++++++++++---
 4 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 75efc4c6f0766..462fc34f13176 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -130,10 +130,6 @@ struct cpu_entry_area {
 };
 
 #define CPU_ENTRY_AREA_SIZE		(sizeof(struct cpu_entry_area))
-#define CPU_ENTRY_AREA_ARRAY_SIZE	(CPU_ENTRY_AREA_SIZE * NR_CPUS)
-
-/* Total size includes the readonly IDT mapping page as well: */
-#define CPU_ENTRY_AREA_TOTAL_SIZE	(CPU_ENTRY_AREA_ARRAY_SIZE + PAGE_SIZE)
 
 DECLARE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
 DECLARE_PER_CPU(struct cea_exception_stacks *, cea_exception_stacks);
diff --git a/arch/x86/include/asm/pgtable_areas.h b/arch/x86/include/asm/pgtable_areas.h
index d34cce1b995cf..4f056fb88174b 100644
--- a/arch/x86/include/asm/pgtable_areas.h
+++ b/arch/x86/include/asm/pgtable_areas.h
@@ -11,6 +11,12 @@
 
 #define CPU_ENTRY_AREA_RO_IDT_VADDR	((void *)CPU_ENTRY_AREA_RO_IDT)
 
-#define CPU_ENTRY_AREA_MAP_SIZE		(CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_ARRAY_SIZE - CPU_ENTRY_AREA_BASE)
+#ifdef CONFIG_X86_32
+#define CPU_ENTRY_AREA_MAP_SIZE		(CPU_ENTRY_AREA_PER_CPU +		\
+					 (CPU_ENTRY_AREA_SIZE * NR_CPUS) -	\
+					 CPU_ENTRY_AREA_BASE)
+#else
+#define CPU_ENTRY_AREA_MAP_SIZE		P4D_SIZE
+#endif
 
 #endif /* _ASM_X86_PGTABLE_AREAS_H */
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 668a4a6533d92..bbb0f737aab19 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -266,7 +266,7 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
 
 	/* CPU entry erea is always used for CPU entry */
 	if (within_area(addr, end, CPU_ENTRY_AREA_BASE,
-			CPU_ENTRY_AREA_TOTAL_SIZE))
+			CPU_ENTRY_AREA_MAP_SIZE))
 		return true;
 
 	/*
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 5990797113c2e..350868f181116 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -5,6 +5,7 @@
 #include <linux/kallsyms.h>
 #include <linux/kcore.h>
 #include <linux/pgtable.h>
+#include <linux/prandom.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/fixmap.h>
@@ -16,16 +17,53 @@ static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage)
 #ifdef CONFIG_X86_64
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct exception_stacks, exception_stacks);
 DEFINE_PER_CPU(struct cea_exception_stacks*, cea_exception_stacks);
-#endif
 
-#ifdef CONFIG_X86_32
+static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, _cea_offset);
+
+static __always_inline unsigned int cea_offset(unsigned int cpu)
+{
+	return per_cpu(_cea_offset, cpu);
+}
+
+static __init void init_cea_offsets(void)
+{
+	unsigned int max_cea;
+	unsigned int i, j;
+
+	max_cea = (CPU_ENTRY_AREA_MAP_SIZE - PAGE_SIZE) / CPU_ENTRY_AREA_SIZE;
+
+	/* O(sodding terrible) */
+	for_each_possible_cpu(i) {
+		unsigned int cea;
+
+again:
+		cea = prandom_u32_max(max_cea);
+
+		for_each_possible_cpu(j) {
+			if (cea_offset(j) == cea)
+				goto again;
+
+			if (i == j)
+				break;
+		}
+
+		per_cpu(_cea_offset, i) = cea;
+	}
+}
+#else /* !X86_64 */
 DECLARE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack);
+
+static __always_inline unsigned int cea_offset(unsigned int cpu)
+{
+	return cpu;
+}
+static inline void init_cea_offsets(void) { }
 #endif
 
 /* Is called from entry code, so must be noinstr */
 noinstr struct cpu_entry_area *get_cpu_entry_area(int cpu)
 {
-	unsigned long va = CPU_ENTRY_AREA_PER_CPU + cpu * CPU_ENTRY_AREA_SIZE;
+	unsigned long va = CPU_ENTRY_AREA_PER_CPU + cea_offset(cpu) * CPU_ENTRY_AREA_SIZE;
 	BUILD_BUG_ON(sizeof(struct cpu_entry_area) % PAGE_SIZE != 0);
 
 	return (struct cpu_entry_area *) va;
@@ -209,7 +247,6 @@ static __init void setup_cpu_entry_area_ptes(void)
 
 	/* The +1 is for the readonly IDT: */
 	BUILD_BUG_ON((CPU_ENTRY_AREA_PAGES+1)*PAGE_SIZE != CPU_ENTRY_AREA_MAP_SIZE);
-	BUILD_BUG_ON(CPU_ENTRY_AREA_TOTAL_SIZE != CPU_ENTRY_AREA_MAP_SIZE);
 	BUG_ON(CPU_ENTRY_AREA_BASE & ~PMD_MASK);
 
 	start = CPU_ENTRY_AREA_BASE;
@@ -225,6 +262,8 @@ void __init setup_cpu_entry_areas(void)
 {
 	unsigned int cpu;
 
+	init_cea_offsets();
+
 	setup_cpu_entry_area_ptes();
 
 	for_each_possible_cpu(cpu)
-- 
2.33.8


