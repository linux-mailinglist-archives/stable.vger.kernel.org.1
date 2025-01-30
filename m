Return-Path: <stable+bounces-111247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EC1A22733
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 01:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0667A1F89
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 00:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824DD2FB;
	Thu, 30 Jan 2025 00:28:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4628C1F
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738196895; cv=none; b=ObqWwIPXxwd7RXWi5YeUA1sUnA+izUYuB9ygwNuQydY/mFTw0ugdh4P2S3TuA9r9qZ+5i3yOvAotE9Kq4k4gE0qhTs1yOWymqU2/AI50LVWYIZxK+DlszJWRgifPdQODi6OfkUw4y0DHJxTwLd2ANtOYiWqwmPyUH0QZ9eG9QJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738196895; c=relaxed/simple;
	bh=cJWiorAy66658FTQPk8vdvVfQeJs+8fSMGtqOoFo5T4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c6w1h1LApfUYFJkY0pdNqcr0hAEK3AOhAA/MHOJZg441VyOQvvhQI4ishFUcotqIF6kct535Lr/z56diiYEpCVDqo32G8g4SCC1Dgjy/Vz2zfXfXxQRy7W7e7nz8mU50jh863gMYQnAXDyKDC6YJfznGwnKka1L0T7KAbmAycFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 93AF1233E0;
	Thu, 30 Jan 2025 03:28:05 +0300 (MSK)
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
Subject: [PATCH v2 5.10/5.15/6.1 4/5] x86/mm: Randomize per-cpu entry area
Date: Thu, 30 Jan 2025 03:27:40 +0300
Message-Id: <20250130002741.66796-5-kovalev@altlinux.org>
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
[kovalev: Replaced the random number generator (prandom -> random)
to prevent regression in kernel booting with configurations
CONFIG_RANDOMIZE_BASE=y and CONFIG_KASAN=y in the absence of commit
d4150779e60f ("random32: use real rng for non-deterministic randomness").]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 arch/x86/include/asm/cpu_entry_area.h |  4 ---
 arch/x86/include/asm/pgtable_areas.h  |  8 ++++-
 arch/x86/kernel/hw_breakpoint.c       |  2 +-
 arch/x86/mm/cpu_entry_area.c          | 47 ++++++++++++++++++++++++---
 4 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 75efc4c6f0766c..462fc34f131766 100644
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
index d34cce1b995cf1..4f056fb88174bb 100644
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
index 668a4a6533d923..bbb0f737aab190 100644
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
index 5990797113c2e0..559d12ecef712a 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -5,6 +5,7 @@
 #include <linux/kallsyms.h>
 #include <linux/kcore.h>
 #include <linux/pgtable.h>
+#include <linux/random.h>
 
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
+		cea = (u32)(((u64) get_random_u32() * max_cea) >> 32);
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


