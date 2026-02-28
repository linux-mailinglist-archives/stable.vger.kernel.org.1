Return-Path: <stable+bounces-220152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEJ6Axcto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:59:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE31C54D8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 747AF30F224E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3A234F279;
	Sat, 28 Feb 2026 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBzKjERW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08194921A2;
	Sat, 28 Feb 2026 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300060; cv=none; b=B0DLVZOycdFw4cgcYPfsHfeAT5gu+cChFjzdKkt9jsdELz6G15Pj2zRMvvlOFpKuvzBfO1Rq5WqUh12ckSmEl5yUgMKY410lTE4VQUlltJds/ZhmtYiz5pwLIt6Uz5N+5VByMTBiNBKUYol56onLBRyl1aHBBchSk5yzuMmYagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300060; c=relaxed/simple;
	bh=iPHL5fHDNkD0s+OK8W08RPRr3MyV1q3fjkFPa2mlYxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uickTqyPr8LFXfz6fcAeDLzJgjIaC2EnUMV6wh9QIniugWfVYn/oK/7wDkrAuQ21JqvVPuOFRMeCYAiPa0843f1TIOBvtWR03q0tr318egsVfSTPRDv8OVJ7xyPOf8+dj6AIHwZecDF1zCNFPZXxI+G5Rx6gpV5O1//h9skXGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBzKjERW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8A1C19423;
	Sat, 28 Feb 2026 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300060;
	bh=iPHL5fHDNkD0s+OK8W08RPRr3MyV1q3fjkFPa2mlYxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBzKjERWsBY3e9hhJUq6Sl5JU9scrdKdUyP7EjGixqgUcN3a7dJlA4sWSsIa5gwNh
	 7vcgBt9t06UaN1S+PNLZaZgsypAssoBjfNZ3JYHVxpx00oHKcoaDNQW1hBwcoCiV+j
	 jgWpswmuom3U20IXj/p94DPFUeEKBIl5tfMNkl53GAfkZlKGF1Yd7prH0ok4XOdzfz
	 Rjl/8zClSBIbnuEgE67e9HL9R5ziIjc8NOoYaVfwilKDyjuDYfQ0MvumPQbfst/Kq3
	 VUr048RR8uTWJf8sPT+zVal3Q8D48O5tbfhDwfJGJfgvF/4rheGEVH9lF1A25F0WJX
	 gmt5d4iGlC2OA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Magnus Lindholm <linmag7@gmail.com>,
	Ivan Kokshaysky <ink@unseen.parts>,
	Matoro Mahri <matoro_mailinglist_kernel@matoro.tk>,
	Michael Cree <mcree@orcon.net.nz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 074/844] alpha: fix user-space corruption during memory compaction
Date: Sat, 28 Feb 2026 12:19:47 -0500
Message-ID: <20260228173244.1509663-75-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,unseen.parts,matoro.tk,orcon.net.nz,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220152-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,unseen.parts:email,orcon.net.nz:email,matoro.tk:email]
X-Rspamd-Queue-Id: 1CEE31C54D8
X-Rspamd-Action: no action

From: Magnus Lindholm <linmag7@gmail.com>

[ Upstream commit dd5712f3379cfe760267cdd28ff957d9ab4e51c7 ]

Alpha systems can suffer sporadic user-space crashes and heap
corruption when memory compaction is enabled.

Symptoms include SIGSEGV, glibc allocator failures (e.g. "unaligned
tcache chunk"), and compiler internal errors. The failures disappear
when compaction is disabled or when using global TLB invalidation.

The root cause is insufficient TLB shootdown during page migration.
Alpha relies on ASN-based MM context rollover for instruction cache
coherency, but this alone is not sufficient to prevent stale data or
instruction translations from surviving migration.

Fix this by introducing a migration-specific helper that combines:
  - MM context invalidation (ASN rollover),
  - immediate per-CPU TLB invalidation (TBI),
  - synchronous cross-CPU shootdown when required.

The helper is used only by migration/compaction paths to avoid changing
global TLB semantics.

Additionally, update flush_tlb_other(), pte_clear(), to use
READ_ONCE()/WRITE_ONCE() for correct SMP memory ordering.

This fixes observed crashes on both UP and SMP Alpha systems.

Reviewed-by: Ivan Kokshaysky <ink@unseen.parts>
Tested-by: Matoro Mahri <matoro_mailinglist_kernel@matoro.tk>
Tested-by: Michael Cree <mcree@orcon.net.nz>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Link: https://lore.kernel.org/r/20260102173603.18247-2-linmag7@gmail.com
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/alpha/include/asm/pgtable.h  |  33 ++++++++-
 arch/alpha/include/asm/tlbflush.h |   4 +-
 arch/alpha/mm/Makefile            |   2 +-
 arch/alpha/mm/tlbflush.c          | 112 ++++++++++++++++++++++++++++++
 4 files changed, 148 insertions(+), 3 deletions(-)
 create mode 100644 arch/alpha/mm/tlbflush.c

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 90e7a95391022..c9508ec37efc4 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -17,6 +17,7 @@
 #include <asm/processor.h>	/* For TASK_SIZE */
 #include <asm/machvec.h>
 #include <asm/setup.h>
+#include <linux/page_table_check.h>
 
 struct mm_struct;
 struct vm_area_struct;
@@ -183,6 +184,9 @@ extern inline void pud_set(pud_t * pudp, pmd_t * pmdp)
 { pud_val(*pudp) = _PAGE_TABLE | ((((unsigned long) pmdp) - PAGE_OFFSET) << (32-PAGE_SHIFT)); }
 
 
+extern void migrate_flush_tlb_page(struct vm_area_struct *vma,
+					unsigned long addr);
+
 extern inline unsigned long
 pmd_page_vaddr(pmd_t pmd)
 {
@@ -202,7 +206,7 @@ extern inline int pte_none(pte_t pte)		{ return !pte_val(pte); }
 extern inline int pte_present(pte_t pte)	{ return pte_val(pte) & _PAGE_VALID; }
 extern inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	pte_val(*ptep) = 0;
+	WRITE_ONCE(pte_val(*ptep), 0);
 }
 
 extern inline int pmd_none(pmd_t pmd)		{ return !pmd_val(pmd); }
@@ -264,6 +268,33 @@ extern inline pte_t * pte_offset_kernel(pmd_t * dir, unsigned long address)
 
 extern pgd_t swapper_pg_dir[1024];
 
+#ifdef CONFIG_COMPACTION
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
+					unsigned long address,
+					pte_t *ptep)
+{
+	pte_t pte = READ_ONCE(*ptep);
+
+	pte_clear(mm, address, ptep);
+	return pte;
+}
+
+#define __HAVE_ARCH_PTEP_CLEAR_FLUSH
+
+static inline pte_t ptep_clear_flush(struct vm_area_struct *vma,
+				unsigned long addr, pte_t *ptep)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pte_t pte = ptep_get_and_clear(mm, addr, ptep);
+
+	page_table_check_pte_clear(mm, pte);
+	migrate_flush_tlb_page(vma, addr);
+	return pte;
+}
+
+#endif
 /*
  * The Alpha doesn't have any external MMU info:  the kernel page
  * tables contain all the necessary information.
diff --git a/arch/alpha/include/asm/tlbflush.h b/arch/alpha/include/asm/tlbflush.h
index ba4b359d6c395..0c8529997f54e 100644
--- a/arch/alpha/include/asm/tlbflush.h
+++ b/arch/alpha/include/asm/tlbflush.h
@@ -58,7 +58,9 @@ flush_tlb_other(struct mm_struct *mm)
 	unsigned long *mmc = &mm->context[smp_processor_id()];
 	/* Check it's not zero first to avoid cacheline ping pong
 	   when possible.  */
-	if (*mmc) *mmc = 0;
+
+	if (READ_ONCE(*mmc))
+		WRITE_ONCE(*mmc, 0);
 }
 
 #ifndef CONFIG_SMP
diff --git a/arch/alpha/mm/Makefile b/arch/alpha/mm/Makefile
index 101dbd06b4ceb..2d05664058f64 100644
--- a/arch/alpha/mm/Makefile
+++ b/arch/alpha/mm/Makefile
@@ -3,4 +3,4 @@
 # Makefile for the linux alpha-specific parts of the memory manager.
 #
 
-obj-y	:= init.o fault.o
+obj-y	:= init.o fault.o tlbflush.o
diff --git a/arch/alpha/mm/tlbflush.c b/arch/alpha/mm/tlbflush.c
new file mode 100644
index 0000000000000..ccbc317b9a348
--- /dev/null
+++ b/arch/alpha/mm/tlbflush.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Alpha TLB shootdown helpers
+ *
+ * Copyright (C) 2025 Magnus Lindholm <linmag7@gmail.com>
+ *
+ * Alpha-specific TLB flush helpers that cannot be expressed purely
+ * as inline functions.
+ *
+ * These helpers provide combined MM context handling (ASN rollover)
+ * and immediate TLB invalidation for page migration and memory
+ * compaction paths, where lazy shootdowns are insufficient.
+ */
+
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <asm/tlbflush.h>
+#include <asm/pal.h>
+#include <asm/mmu_context.h>
+
+#define asn_locked() (cpu_data[smp_processor_id()].asn_lock)
+
+/*
+ * Migration/compaction helper: combine mm context (ASN) handling with an
+ * immediate per-page TLB invalidate and (for exec) an instruction barrier.
+ *
+ * This mirrors the SMP combined IPI handler semantics, but runs locally on UP.
+ */
+#ifndef CONFIG_SMP
+void migrate_flush_tlb_page(struct vm_area_struct *vma,
+					   unsigned long addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int tbi_type = (vma->vm_flags & VM_EXEC) ? 3 : 2;
+
+	/*
+	 * First do the mm-context side:
+	 * If we're currently running this mm, reload a fresh context ASN.
+	 * Otherwise, mark context invalid.
+	 *
+	 * On UP, this is mostly about matching the SMP semantics and ensuring
+	 * exec/i-cache tagging assumptions hold when compaction migrates pages.
+	 */
+	if (mm == current->active_mm)
+		flush_tlb_current(mm);
+	else
+		flush_tlb_other(mm);
+
+	/*
+	 * Then do the immediate translation kill for this VA.
+	 * For exec mappings, order instruction fetch after invalidation.
+	 */
+	tbi(tbi_type, addr);
+}
+
+#else
+struct tlb_mm_and_addr {
+	struct mm_struct *mm;
+	unsigned long addr;
+	int tbi_type;	/* 2 = DTB, 3 = ITB+DTB */
+};
+
+static void ipi_flush_mm_and_page(void *x)
+{
+	struct tlb_mm_and_addr *d = x;
+
+	/* Part 1: mm context side (Alpha uses ASN/context as a key mechanism). */
+	if (d->mm == current->active_mm && !asn_locked())
+		__load_new_mm_context(d->mm);
+	else
+		flush_tlb_other(d->mm);
+
+	/* Part 2: immediate per-VA invalidation on this CPU. */
+	tbi(d->tbi_type, d->addr);
+}
+
+void migrate_flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct tlb_mm_and_addr d = {
+		.mm = mm,
+		.addr = addr,
+		.tbi_type = (vma->vm_flags & VM_EXEC) ? 3 : 2,
+	};
+
+	/*
+	 * One synchronous rendezvous: every CPU runs ipi_flush_mm_and_page().
+	 * This is the "combined" version of flush_tlb_mm + per-page invalidate.
+	 */
+	preempt_disable();
+	on_each_cpu(ipi_flush_mm_and_page, &d, 1);
+
+	/*
+	 * mimic flush_tlb_mm()'s mm_users<=1 optimization.
+	 */
+	if (atomic_read(&mm->mm_users) <= 1) {
+
+		int cpu, this_cpu;
+		this_cpu = smp_processor_id();
+
+		for (cpu = 0; cpu < NR_CPUS; cpu++) {
+			if (!cpu_online(cpu) || cpu == this_cpu)
+				continue;
+			if (READ_ONCE(mm->context[cpu]))
+				WRITE_ONCE(mm->context[cpu], 0);
+		}
+	}
+	preempt_enable();
+}
+
+#endif
-- 
2.51.0


