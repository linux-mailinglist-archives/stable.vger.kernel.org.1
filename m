Return-Path: <stable+bounces-89940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BADF9BDAC2
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 01:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7595CB20C6A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 00:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB9A13D52B;
	Wed,  6 Nov 2024 00:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="p6j21jGC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA1D1534E9;
	Wed,  6 Nov 2024 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854703; cv=none; b=rdIE2qOGmuMTSPdx3yyjMyzyncT/NXSU8aFfpaF3aaFiYUtxlMg3wgvy2wQ7tKoeSHZZcW6YA/DC2+kyGFCd/IZUy9J8sNct8b5BbF+oCl35knagmFKF7UFloeo4LvqtkwlWqx3Hbh11H7GRKGdkiaumA48QEutmPHFLs81BL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854703; c=relaxed/simple;
	bh=kTTgtS/9f6BKFVfrLV56Ux06xHekoBVH6MC6IvAeqTk=;
	h=Date:To:From:Subject:Message-Id; b=jdIrIcdVNDsQiXukj5qJUyq2C0rt85u08nrMynNNSG370OwwDheLRFlION8bCC7nJjZGoQngS1GWdymooinLLquj0Zdw7TjQZopuIa2Hx2jBckHof1bjjwOEg/UiMaq/a1Z+KoNfbenBnuDDacGj+gfYwYvWo2QAtB+x56H36fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=p6j21jGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2C8C4CECF;
	Wed,  6 Nov 2024 00:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730854702;
	bh=kTTgtS/9f6BKFVfrLV56Ux06xHekoBVH6MC6IvAeqTk=;
	h=Date:To:From:Subject:From;
	b=p6j21jGCvMzTanPOkJBqcDN1oHpVPitua4u3i+E/g8KyP5bns76ipqvXSHQB8+Nh3
	 Jcq2t7MafMQgwU+lnU4CU6HMJvDHu+ii/mObhaO9sY0qQL8M1bubV4IhpIcvcEFyzg
	 vUP7l3YIATGUHG+FPqHKSs21TbsH9gmdU5LY8uPY=
Date: Tue, 05 Nov 2024 16:58:22 -0800
To: mm-commits@vger.kernel.org,vincenzo.frascino@arm.com,urezki@gmail.com,sunjw10@lenovo.com,stable@vger.kernel.org,ryabinin.a.a@gmail.com,hch@infradead.org,glider@google.com,dvyukov@google.com,bhe@redhat.com,andreyknvl@gmail.com,ahuang12@lenovo.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] mm-vmalloc-combine-all-tlb-flush-operations-of-kasan-shadow-virtual-address-into-one-operation.patch removed from -mm tree
Message-Id: <20241106005822.9F2C8C4CECF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm/vmalloc: combine all TLB flush operations of KASAN shadow virtual address into one operation
has been removed from the -mm tree.  Its filename was
     mm-vmalloc-combine-all-tlb-flush-operations-of-kasan-shadow-virtual-address-into-one-operation.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Adrian Huang <ahuang12@lenovo.com>
Subject: mm/vmalloc: combine all TLB flush operations of KASAN shadow virtual address into one operation
Date: Sat, 27 Jul 2024 00:52:46 +0800

When compiling kernel source 'make -j $(nproc)' with the up-and-running
KASAN-enabled kernel on a 256-core machine, the following soft lockup is
shown:

watchdog: BUG: soft lockup - CPU#28 stuck for 22s! [kworker/28:1:1760]
CPU: 28 PID: 1760 Comm: kworker/28:1 Kdump: loaded Not tainted 6.10.0-rc5 #95
Workqueue: events drain_vmap_area_work
RIP: 0010:smp_call_function_many_cond+0x1d8/0xbb0
Code: 38 c8 7c 08 84 c9 0f 85 49 08 00 00 8b 45 08 a8 01 74 2e 48 89 f1 49 89 f7 48 c1 e9 03 41 83 e7 07 4c 01 e9 41 83 c7 03 f3 90 <0f> b6 01 41 38 c7 7c 08 84 c0 0f 85 d4 06 00 00 8b 45 08 a8 01 75
RSP: 0018:ffffc9000cb3fb60 EFLAGS: 00000202
RAX: 0000000000000011 RBX: ffff8883bc4469c0 RCX: ffffed10776e9949
RDX: 0000000000000002 RSI: ffff8883bb74ca48 RDI: ffffffff8434dc50
RBP: ffff8883bb74ca40 R08: ffff888103585dc0 R09: ffff8884533a1800
R10: 0000000000000004 R11: ffffffffffffffff R12: ffffed1077888d39
R13: dffffc0000000000 R14: ffffed1077888d38 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8883bc400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005577b5c8d158 CR3: 0000000004850000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 ? watchdog_timer_fn+0x2cd/0x390
 ? __pfx_watchdog_timer_fn+0x10/0x10
 ? __hrtimer_run_queues+0x300/0x6d0
 ? sched_clock_cpu+0x69/0x4e0
 ? __pfx___hrtimer_run_queues+0x10/0x10
 ? srso_return_thunk+0x5/0x5f
 ? ktime_get_update_offsets_now+0x7f/0x2a0
 ? srso_return_thunk+0x5/0x5f
 ? srso_return_thunk+0x5/0x5f
 ? hrtimer_interrupt+0x2ca/0x760
 ? __sysvec_apic_timer_interrupt+0x8c/0x2b0
 ? sysvec_apic_timer_interrupt+0x6a/0x90
 </IRQ>
 <TASK>
 ? asm_sysvec_apic_timer_interrupt+0x16/0x20
 ? smp_call_function_many_cond+0x1d8/0xbb0
 ? __pfx_do_kernel_range_flush+0x10/0x10
 on_each_cpu_cond_mask+0x20/0x40
 flush_tlb_kernel_range+0x19b/0x250
 ? srso_return_thunk+0x5/0x5f
 ? kasan_release_vmalloc+0xa7/0xc0
 purge_vmap_node+0x357/0x820
 ? __pfx_purge_vmap_node+0x10/0x10
 __purge_vmap_area_lazy+0x5b8/0xa10
 drain_vmap_area_work+0x21/0x30
 process_one_work+0x661/0x10b0
 worker_thread+0x844/0x10e0
 ? srso_return_thunk+0x5/0x5f
 ? __kthread_parkme+0x82/0x140
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x2a5/0x370
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x30/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Debugging Analysis:

  1. The following ftrace log shows that the lockup CPU spends too much
     time iterating vmap_nodes and flushing TLB when purging vm_area
     structures. (Some info is trimmed).

     kworker: funcgraph_entry:              |  drain_vmap_area_work() {
     kworker: funcgraph_entry:              |   mutex_lock() {
     kworker: funcgraph_entry:  1.092 us    |     __cond_resched();
     kworker: funcgraph_exit:   3.306 us    |   }
     ...                                        ...
     kworker: funcgraph_entry:              |    flush_tlb_kernel_range() {
     ...                                          ...
     kworker: funcgraph_exit: # 7533.649 us |    }
     ...                                         ...
     kworker: funcgraph_entry:  2.344 us    |   mutex_unlock();
     kworker: funcgraph_exit: $ 23871554 us | }

     The drain_vmap_area_work() spends over 23 seconds.

     There are 2805 flush_tlb_kernel_range() calls in the ftrace log.
       * One is called in __purge_vmap_area_lazy().
       * Others are called by purge_vmap_node->kasan_release_vmalloc.
         purge_vmap_node() iteratively releases kasan vmalloc
         allocations and flushes TLB for each vmap_area.
           - [Rough calculation] Each flush_tlb_kernel_range() runs
             about 7.5ms.
               -- 2804 * 7.5ms = 21.03 seconds.
               -- That's why a soft lock is triggered.

  2. Extending the soft lockup time can work around the issue (For example,
     # echo 60 > /proc/sys/kernel/watchdog_thresh). This confirms the
     above-mentioned speculation: drain_vmap_area_work() spends too much
     time.

If we combine all TLB flush operations of the KASAN shadow virtual
address into one operation in the call path
'purge_vmap_node()->kasan_release_vmalloc()', the running time of
drain_vmap_area_work() can be saved greatly. The idea is from the
flush_tlb_kernel_range() call in __purge_vmap_area_lazy(). And, the
soft lockup won't be triggered.

Here is the test result based on 6.10:

[6.10 wo/ the patch]
  1. ftrace latency profiling (record a trace if the latency > 20s).
     echo 20000000 > /sys/kernel/debug/tracing/tracing_thresh
     echo drain_vmap_area_work > /sys/kernel/debug/tracing/set_graph_function
     echo function_graph > /sys/kernel/debug/tracing/current_tracer
     echo 1 > /sys/kernel/debug/tracing/tracing_on

  2. Run `make -j $(nproc)` to compile the kernel source

  3. Once the soft lockup is reproduced, check the ftrace log:
     cat /sys/kernel/debug/tracing/trace
        # tracer: function_graph
        #
        # CPU  DURATION                  FUNCTION CALLS
        # |     |   |                     |   |   |   |
          76) $ 50412985 us |    } /* __purge_vmap_area_lazy */
          76) $ 50412997 us |  } /* drain_vmap_area_work */
          76) $ 29165911 us |    } /* __purge_vmap_area_lazy */
          76) $ 29165926 us |  } /* drain_vmap_area_work */
          91) $ 53629423 us |    } /* __purge_vmap_area_lazy */
          91) $ 53629434 us |  } /* drain_vmap_area_work */
          91) $ 28121014 us |    } /* __purge_vmap_area_lazy */
          91) $ 28121026 us |  } /* drain_vmap_area_work */

[6.10 w/ the patch]
  1. Repeat step 1-2 in "[6.10 wo/ the patch]"

  2. The soft lockup is not triggered and ftrace log is empty.
     cat /sys/kernel/debug/tracing/trace
     # tracer: function_graph
     #
     # CPU  DURATION                  FUNCTION CALLS
     # |     |   |                     |   |   |   |

  3. Setting 'tracing_thresh' to 10/5 seconds does not get any ftrace
     log.

  4. Setting 'tracing_thresh' to 1 second gets ftrace log.
     cat /sys/kernel/debug/tracing/trace
     # tracer: function_graph
     #
     # CPU  DURATION                  FUNCTION CALLS
     # |     |   |                     |   |   |   |
       23) $ 1074942 us  |    } /* __purge_vmap_area_lazy */
       23) $ 1074950 us  |  } /* drain_vmap_area_work */

  The worst execution time of drain_vmap_area_work() is about 1 second.

Link: https://lore.kernel.org/lkml/ZqFlawuVnOMY2k3E@pc638.lan/
Link: https://lkml.kernel.org/r/20240726165246.31326-1-ahuang12@lenovo.com
Fixes: 282631cb2447 ("mm: vmalloc: remove global purge_vmap_area_root rb-tree")
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Co-developed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Tested-by: Jiwei Sun <sunjw10@lenovo.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/kasan.h |   12 +++++++++---
 mm/kasan/shadow.c     |   14 ++++++++++----
 mm/vmalloc.c          |   34 ++++++++++++++++++++++++++--------
 3 files changed, 45 insertions(+), 15 deletions(-)

--- a/include/linux/kasan.h~mm-vmalloc-combine-all-tlb-flush-operations-of-kasan-shadow-virtual-address-into-one-operation
+++ a/include/linux/kasan.h
@@ -29,6 +29,9 @@ typedef unsigned int __bitwise kasan_vma
 #define KASAN_VMALLOC_VM_ALLOC		((__force kasan_vmalloc_flags_t)0x02u)
 #define KASAN_VMALLOC_PROT_NORMAL	((__force kasan_vmalloc_flags_t)0x04u)
 
+#define KASAN_VMALLOC_PAGE_RANGE 0x1 /* Apply exsiting page range */
+#define KASAN_VMALLOC_TLB_FLUSH  0x2 /* TLB flush */
+
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 #include <linux/pgtable.h>
@@ -564,7 +567,8 @@ void kasan_populate_early_vm_area_shadow
 int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
-			   unsigned long free_region_end);
+			   unsigned long free_region_end,
+			   unsigned long flags);
 
 #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
@@ -579,7 +583,8 @@ static inline int kasan_populate_vmalloc
 static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long end,
 					 unsigned long free_region_start,
-					 unsigned long free_region_end) { }
+					 unsigned long free_region_end,
+					 unsigned long flags) { }
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
@@ -614,7 +619,8 @@ static inline int kasan_populate_vmalloc
 static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long end,
 					 unsigned long free_region_start,
-					 unsigned long free_region_end) { }
+					 unsigned long free_region_end,
+					 unsigned long flags) { }
 
 static inline void *kasan_unpoison_vmalloc(const void *start,
 					   unsigned long size,
--- a/mm/kasan/shadow.c~mm-vmalloc-combine-all-tlb-flush-operations-of-kasan-shadow-virtual-address-into-one-operation
+++ a/mm/kasan/shadow.c
@@ -489,7 +489,8 @@ static int kasan_depopulate_vmalloc_pte(
  */
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
-			   unsigned long free_region_end)
+			   unsigned long free_region_end,
+			   unsigned long flags)
 {
 	void *shadow_start, *shadow_end;
 	unsigned long region_start, region_end;
@@ -522,12 +523,17 @@ void kasan_release_vmalloc(unsigned long
 			__memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
 			return;
 		}
-		apply_to_existing_page_range(&init_mm,
+
+
+		if (flags & KASAN_VMALLOC_PAGE_RANGE)
+			apply_to_existing_page_range(&init_mm,
 					     (unsigned long)shadow_start,
 					     size, kasan_depopulate_vmalloc_pte,
 					     NULL);
-		flush_tlb_kernel_range((unsigned long)shadow_start,
-				       (unsigned long)shadow_end);
+
+		if (flags & KASAN_VMALLOC_TLB_FLUSH)
+			flush_tlb_kernel_range((unsigned long)shadow_start,
+					       (unsigned long)shadow_end);
 	}
 }
 
--- a/mm/vmalloc.c~mm-vmalloc-combine-all-tlb-flush-operations-of-kasan-shadow-virtual-address-into-one-operation
+++ a/mm/vmalloc.c
@@ -2182,6 +2182,25 @@ decay_va_pool_node(struct vmap_node *vn,
 	reclaim_list_global(&decay_list);
 }
 
+static void
+kasan_release_vmalloc_node(struct vmap_node *vn)
+{
+	struct vmap_area *va;
+	unsigned long start, end;
+
+	start = list_first_entry(&vn->purge_list, struct vmap_area, list)->va_start;
+	end = list_last_entry(&vn->purge_list, struct vmap_area, list)->va_end;
+
+	list_for_each_entry(va, &vn->purge_list, list) {
+		if (is_vmalloc_or_module_addr((void *) va->va_start))
+			kasan_release_vmalloc(va->va_start, va->va_end,
+				va->va_start, va->va_end,
+				KASAN_VMALLOC_PAGE_RANGE);
+	}
+
+	kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
+}
+
 static void purge_vmap_node(struct work_struct *work)
 {
 	struct vmap_node *vn = container_of(work,
@@ -2190,20 +2209,17 @@ static void purge_vmap_node(struct work_
 	struct vmap_area *va, *n_va;
 	LIST_HEAD(local_list);
 
+	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
+		kasan_release_vmalloc_node(vn);
+
 	vn->nr_purged = 0;
 
 	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
 		unsigned long nr = va_size(va) >> PAGE_SHIFT;
-		unsigned long orig_start = va->va_start;
-		unsigned long orig_end = va->va_end;
 		unsigned int vn_id = decode_vn_id(va->flags);
 
 		list_del_init(&va->list);
 
-		if (is_vmalloc_or_module_addr((void *)orig_start))
-			kasan_release_vmalloc(orig_start, orig_end,
-					      va->va_start, va->va_end);
-
 		nr_purged_pages += nr;
 		vn->nr_purged++;
 
@@ -4784,7 +4800,8 @@ recovery:
 				&free_vmap_area_list);
 		if (va)
 			kasan_release_vmalloc(orig_start, orig_end,
-				va->va_start, va->va_end);
+				va->va_start, va->va_end,
+				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
 		vas[area] = NULL;
 	}
 
@@ -4834,7 +4851,8 @@ err_free_shadow:
 				&free_vmap_area_list);
 		if (va)
 			kasan_release_vmalloc(orig_start, orig_end,
-				va->va_start, va->va_end);
+				va->va_start, va->va_end,
+				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
 		vas[area] = NULL;
 		kfree(vms[area]);
 	}
_

Patches currently in -mm which might be from ahuang12@lenovo.com are



