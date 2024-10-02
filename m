Return-Path: <stable+bounces-80266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAA298DCB4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DB01F2830C
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3151D2B07;
	Wed,  2 Oct 2024 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NBajU73s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC6E1D0BBE;
	Wed,  2 Oct 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879866; cv=none; b=ZnvKVbx2XbTMJHHI+e0P0Zh/BoyeRj+TGrTn+Dqa80Yny4jzziw4qOuh+d5WVXyFqfokEGK6S0pRbLtb5g6eTP7E/r4vmZPp3d04Z0rh8PPhDXU2TDvm+rtSHS7Wz7tJmOz+SInSxS79vRyOHtjbZLRGJX/jAFxDL1oIOVl10vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879866; c=relaxed/simple;
	bh=EEhFjyHHS9QdDV5onpObc3Y7gL/wNZ/EHDHy14QLlPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfqPBv3keltF0J5YxSgophxS9Srb6WtC8c6iGZOK3dtLZCcW/mjP+aCtrqamwOhFx91dYMUbVds0CORzB5kZJewQoNzUJQQlThZD4jOVK4Q86E5ctV2GN5gCaYFJwW5TaStxo4czA/YzQU/pwIixVUE/eNwLR0oFYLLe73uFuo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NBajU73s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FEDC4CEC2;
	Wed,  2 Oct 2024 14:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879866;
	bh=EEhFjyHHS9QdDV5onpObc3Y7gL/wNZ/EHDHy14QLlPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBajU73sZDL3KNi4M/E0VjvloEJod6pJSAglA6xgSFoFyB7O2fmvELfLv4faSaten
	 6yYeh9/181XpRmukTH5u97Ir/sYp/HagUZZBI3+rHOEO5UBbZjPY1bWOD4jC50plMj
	 405bsQ69o6ddcMsB38g5a/NY1yrvaGV3jp3WAkMo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mel Gorman <mgorman@techsingularity.net>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 234/538] sched/numa: Trace decisions related to skipping VMAs
Date: Wed,  2 Oct 2024 14:57:53 +0200
Message-ID: <20241002125801.488916740@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mel Gorman <mgorman@techsingularity.net>

[ Upstream commit ed2da8b725b932b1e2b2f4835bb664d47ed03031 ]

NUMA balancing skips or scans VMAs for a variety of reasons. In preparation
for completing scans of VMAs regardless of PID access, trace the reasons
why a VMA was skipped. In a later patch, the tracing will be used to track
if a VMA was forcibly scanned.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231010083143.19593-4-mgorman@techsingularity.net
Stable-dep-of: f22cde4371f3 ("sched/numa: Fix the vma scan starving issue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched/numa_balancing.h |  8 +++++
 include/trace/events/sched.h         | 50 ++++++++++++++++++++++++++++
 kernel/sched/fair.c                  | 17 +++++++---
 3 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 3988762efe15c..c127a1509e2fa 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -15,6 +15,14 @@
 #define TNF_FAULT_LOCAL	0x08
 #define TNF_MIGRATE_FAIL 0x10
 
+enum numa_vmaskip_reason {
+	NUMAB_SKIP_UNSUITABLE,
+	NUMAB_SKIP_SHARED_RO,
+	NUMAB_SKIP_INACCESSIBLE,
+	NUMAB_SKIP_SCAN_DELAY,
+	NUMAB_SKIP_PID_INACTIVE,
+};
+
 #ifdef CONFIG_NUMA_BALANCING
 extern void task_numa_fault(int last_node, int node, int pages, int flags);
 extern pid_t task_numa_group_id(struct task_struct *p);
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714c..b0d0dbf491ea6 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -664,6 +664,56 @@ DEFINE_EVENT(sched_numa_pair_template, sched_swap_numa,
 	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu)
 );
 
+#ifdef CONFIG_NUMA_BALANCING
+#define NUMAB_SKIP_REASON					\
+	EM( NUMAB_SKIP_UNSUITABLE,		"unsuitable" )	\
+	EM( NUMAB_SKIP_SHARED_RO,		"shared_ro" )	\
+	EM( NUMAB_SKIP_INACCESSIBLE,		"inaccessible" )	\
+	EM( NUMAB_SKIP_SCAN_DELAY,		"scan_delay" )	\
+	EMe(NUMAB_SKIP_PID_INACTIVE,		"pid_inactive" )
+
+/* Redefine for export. */
+#undef EM
+#undef EMe
+#define EM(a, b)	TRACE_DEFINE_ENUM(a);
+#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
+
+NUMAB_SKIP_REASON
+
+/* Redefine for symbolic printing. */
+#undef EM
+#undef EMe
+#define EM(a, b)	{ a, b },
+#define EMe(a, b)	{ a, b }
+
+TRACE_EVENT(sched_skip_vma_numa,
+
+	TP_PROTO(struct mm_struct *mm, struct vm_area_struct *vma,
+		 enum numa_vmaskip_reason reason),
+
+	TP_ARGS(mm, vma, reason),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, numa_scan_offset)
+		__field(unsigned long, vm_start)
+		__field(unsigned long, vm_end)
+		__field(enum numa_vmaskip_reason, reason)
+	),
+
+	TP_fast_assign(
+		__entry->numa_scan_offset	= mm->numa_scan_offset;
+		__entry->vm_start		= vma->vm_start;
+		__entry->vm_end			= vma->vm_end;
+		__entry->reason			= reason;
+	),
+
+	TP_printk("numa_scan_offset=%lX vm_start=%lX vm_end=%lX reason=%s",
+		  __entry->numa_scan_offset,
+		  __entry->vm_start,
+		  __entry->vm_end,
+		  __print_symbolic(__entry->reason, NUMAB_SKIP_REASON))
+);
+#endif /* CONFIG_NUMA_BALANCING */
 
 /*
  * Tracepoint for waking a polling cpu without an IPI.
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d07fb0a0da808..7c5f6e94b3cdc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3285,6 +3285,7 @@ static void task_numa_work(struct callback_head *work)
 	do {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UNSUITABLE);
 			continue;
 		}
 
@@ -3295,15 +3296,19 @@ static void task_numa_work(struct callback_head *work)
 		 * as migrating the pages will be of marginal benefit.
 		 */
 		if (!vma->vm_mm ||
-		    (vma->vm_file && (vma->vm_flags & (VM_READ|VM_WRITE)) == (VM_READ)))
+		    (vma->vm_file && (vma->vm_flags & (VM_READ|VM_WRITE)) == (VM_READ))) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SHARED_RO);
 			continue;
+		}
 
 		/*
 		 * Skip inaccessible VMAs to avoid any confusion between
 		 * PROT_NONE and NUMA hinting ptes
 		 */
-		if (!vma_is_accessible(vma))
+		if (!vma_is_accessible(vma)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_INACCESSIBLE);
 			continue;
+		}
 
 		/* Initialise new per-VMA NUMAB state. */
 		if (!vma->numab_state) {
@@ -3325,12 +3330,16 @@ static void task_numa_work(struct callback_head *work)
 		 * delay the scan for new VMAs.
 		 */
 		if (mm->numa_scan_seq && time_before(jiffies,
-						vma->numab_state->next_scan))
+						vma->numab_state->next_scan)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SCAN_DELAY);
 			continue;
+		}
 
 		/* Do not scan the VMA if task has not accessed */
-		if (!vma_is_accessed(vma))
+		if (!vma_is_accessed(vma)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
 			continue;
+		}
 
 		/*
 		 * RESET access PIDs regularly for old VMAs. Resetting after checking
-- 
2.43.0




