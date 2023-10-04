Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052F97B8A6B
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244415AbjJDSfQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244095AbjJDSfO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:35:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352BBAB
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:35:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0EDC433C7;
        Wed,  4 Oct 2023 18:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444509;
        bh=3huDI3tt96Z8WmadV9KidBQTt/RqMRY8c0PkPR9H10Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TxCdWtxKqU48hE/Ub5eWUoTOAsyoMleE5ej2EOaZhen8I9XjbUcQAyq2XGNaPGGTi
         ghHn9wZgIJWk9eRUa+wiBsQRkkmVtt3TkidscOa3cYr98et7S37b6SgHNJc92IRNLF
         5aRypSUMG5ikL9ty9metcnU5mTAHJG4KT4pi5Sf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pattara Teerapong <pteerapong@google.com>,
        David Stevens <stevensd@google.com>,
        Yiwei Zhang <zzyiwei@google.com>,
        Paul Hsia <paulhsia@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.5 247/321] KVM: x86/mmu: Stop zapping invalidated TDP MMU roots asynchronously
Date:   Wed,  4 Oct 2023 19:56:32 +0200
Message-ID: <20231004175240.706857863@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 0df9dab891ff0d9b646d82e4fe038229e4c02451 upstream.

Stop zapping invalidate TDP MMU roots via work queue now that KVM
preserves TDP MMU roots until they are explicitly invalidated.  Zapping
roots asynchronously was effectively a workaround to avoid stalling a vCPU
for an extended during if a vCPU unloaded a root, which at the time
happened whenever the guest toggled CR0.WP (a frequent operation for some
guest kernels).

While a clever hack, zapping roots via an unbound worker had subtle,
unintended consequences on host scheduling, especially when zapping
multiple roots, e.g. as part of a memslot.  Because the work of zapping a
root is no longer bound to the task that initiated the zap, things like
the CPU affinity and priority of the original task get lost.  Losing the
affinity and priority can be especially problematic if unbound workqueues
aren't affined to a small number of CPUs, as zapping multiple roots can
cause KVM to heavily utilize the majority of CPUs in the system, *beyond*
the CPUs KVM is already using to run vCPUs.

When deleting a memslot via KVM_SET_USER_MEMORY_REGION, the async root
zap can result in KVM occupying all logical CPUs for ~8ms, and result in
high priority tasks not being scheduled in in a timely manner.  In v5.15,
which doesn't preserve unloaded roots, the issues were even more noticeable
as KVM would zap roots more frequently and could occupy all CPUs for 50ms+.

Consuming all CPUs for an extended duration can lead to significant jitter
throughout the system, e.g. on ChromeOS with virtio-gpu, deleting memslots
is a semi-frequent operation as memslots are deleted and recreated with
different host virtual addresses to react to host GPU drivers allocating
and freeing GPU blobs.  On ChromeOS, the jitter manifests as audio blips
during games due to the audio server's tasks not getting scheduled in
promptly, despite the tasks having a high realtime priority.

Deleting memslots isn't exactly a fast path and should be avoided when
possible, and ChromeOS is working towards utilizing MAP_FIXED to avoid the
memslot shenanigans, but KVM is squarely in the wrong.  Not to mention
that removing the async zapping eliminates a non-trivial amount of
complexity.

Note, one of the subtle behaviors hidden behind the async zapping is that
KVM would zap invalidated roots only once (ignoring partial zaps from
things like mmu_notifier events).  Preserve this behavior by adding a flag
to identify roots that are scheduled to be zapped versus roots that have
already been zapped but not yet freed.

Add a comment calling out why kvm_tdp_mmu_invalidate_all_roots() can
encounter invalid roots, as it's not at all obvious why zapping
invalidated roots shouldn't simply zap all invalid roots.

Reported-by: Pattara Teerapong <pteerapong@google.com>
Cc: David Stevens <stevensd@google.com>
Cc: Yiwei Zhang<zzyiwei@google.com>
Cc: Paul Hsia <paulhsia@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20230916003916.2545000-4-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kvm_host.h |    3 
 arch/x86/kvm/mmu/mmu.c          |   12 ---
 arch/x86/kvm/mmu/mmu_internal.h |   15 ++--
 arch/x86/kvm/mmu/tdp_mmu.c      |  133 ++++++++++++++++------------------------
 arch/x86/kvm/mmu/tdp_mmu.h      |    2 
 arch/x86/kvm/x86.c              |    5 -
 6 files changed, 68 insertions(+), 102 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1400,7 +1400,6 @@ struct kvm_arch {
 	 * the thread holds the MMU lock in write mode.
 	 */
 	spinlock_t tdp_mmu_pages_lock;
-	struct workqueue_struct *tdp_mmu_zap_wq;
 #endif /* CONFIG_X86_64 */
 
 	/*
@@ -1814,7 +1813,7 @@ void kvm_mmu_vendor_module_exit(void);
 
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_mmu_create(struct kvm_vcpu *vcpu);
-int kvm_mmu_init_vm(struct kvm *kvm);
+void kvm_mmu_init_vm(struct kvm *kvm);
 void kvm_mmu_uninit_vm(struct kvm *kvm);
 
 void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu);
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6206,21 +6206,17 @@ static void kvm_mmu_invalidate_zap_pages
 	kvm_mmu_zap_all_fast(kvm);
 }
 
-int kvm_mmu_init_vm(struct kvm *kvm)
+void kvm_mmu_init_vm(struct kvm *kvm)
 {
 	struct kvm_page_track_notifier_node *node = &kvm->arch.mmu_sp_tracker;
-	int r;
 
 	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
 	INIT_LIST_HEAD(&kvm->arch.zapped_obsolete_pages);
 	INIT_LIST_HEAD(&kvm->arch.possible_nx_huge_pages);
 	spin_lock_init(&kvm->arch.mmu_unsync_pages_lock);
 
-	if (tdp_mmu_enabled) {
-		r = kvm_mmu_init_tdp_mmu(kvm);
-		if (r < 0)
-			return r;
-	}
+	if (tdp_mmu_enabled)
+		kvm_mmu_init_tdp_mmu(kvm);
 
 	node->track_write = kvm_mmu_pte_write;
 	node->track_flush_slot = kvm_mmu_invalidate_zap_pages_in_memslot;
@@ -6233,8 +6229,6 @@ int kvm_mmu_init_vm(struct kvm *kvm)
 
 	kvm->arch.split_desc_cache.kmem_cache = pte_list_desc_cache;
 	kvm->arch.split_desc_cache.gfp_zero = __GFP_ZERO;
-
-	return 0;
 }
 
 static void mmu_free_vm_memory_caches(struct kvm *kvm)
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -56,7 +56,12 @@ struct kvm_mmu_page {
 
 	bool tdp_mmu_page;
 	bool unsync;
-	u8 mmu_valid_gen;
+	union {
+		u8 mmu_valid_gen;
+
+		/* Only accessed under slots_lock.  */
+		bool tdp_mmu_scheduled_root_to_zap;
+	};
 
 	 /*
 	  * The shadow page can't be replaced by an equivalent huge page
@@ -98,13 +103,7 @@ struct kvm_mmu_page {
 		struct kvm_rmap_head parent_ptes; /* rmap pointers to parent sptes */
 		tdp_ptep_t ptep;
 	};
-	union {
-		DECLARE_BITMAP(unsync_child_bitmap, 512);
-		struct {
-			struct work_struct tdp_mmu_async_work;
-			void *tdp_mmu_async_data;
-		};
-	};
+	DECLARE_BITMAP(unsync_child_bitmap, 512);
 
 	/*
 	 * Tracks shadow pages that, if zapped, would allow KVM to create an NX
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -12,18 +12,10 @@
 #include <trace/events/kvm.h>
 
 /* Initializes the TDP MMU for the VM, if enabled. */
-int kvm_mmu_init_tdp_mmu(struct kvm *kvm)
+void kvm_mmu_init_tdp_mmu(struct kvm *kvm)
 {
-	struct workqueue_struct *wq;
-
-	wq = alloc_workqueue("kvm", WQ_UNBOUND|WQ_MEM_RECLAIM|WQ_CPU_INTENSIVE, 0);
-	if (!wq)
-		return -ENOMEM;
-
 	INIT_LIST_HEAD(&kvm->arch.tdp_mmu_roots);
 	spin_lock_init(&kvm->arch.tdp_mmu_pages_lock);
-	kvm->arch.tdp_mmu_zap_wq = wq;
-	return 1;
 }
 
 /* Arbitrarily returns true so that this may be used in if statements. */
@@ -46,20 +38,15 @@ void kvm_mmu_uninit_tdp_mmu(struct kvm *
 	 * ultimately frees all roots.
 	 */
 	kvm_tdp_mmu_invalidate_all_roots(kvm);
-
-	/*
-	 * Destroying a workqueue also first flushes the workqueue, i.e. no
-	 * need to invoke kvm_tdp_mmu_zap_invalidated_roots().
-	 */
-	destroy_workqueue(kvm->arch.tdp_mmu_zap_wq);
+	kvm_tdp_mmu_zap_invalidated_roots(kvm);
 
 	WARN_ON(atomic64_read(&kvm->arch.tdp_mmu_pages));
 	WARN_ON(!list_empty(&kvm->arch.tdp_mmu_roots));
 
 	/*
 	 * Ensure that all the outstanding RCU callbacks to free shadow pages
-	 * can run before the VM is torn down.  Work items on tdp_mmu_zap_wq
-	 * can call kvm_tdp_mmu_put_root and create new callbacks.
+	 * can run before the VM is torn down.  Putting the last reference to
+	 * zapped roots will create new callbacks.
 	 */
 	rcu_barrier();
 }
@@ -86,46 +73,6 @@ static void tdp_mmu_free_sp_rcu_callback
 	tdp_mmu_free_sp(sp);
 }
 
-static void tdp_mmu_zap_root(struct kvm *kvm, struct kvm_mmu_page *root,
-			     bool shared);
-
-static void tdp_mmu_zap_root_work(struct work_struct *work)
-{
-	struct kvm_mmu_page *root = container_of(work, struct kvm_mmu_page,
-						 tdp_mmu_async_work);
-	struct kvm *kvm = root->tdp_mmu_async_data;
-
-	read_lock(&kvm->mmu_lock);
-
-	/*
-	 * A TLB flush is not necessary as KVM performs a local TLB flush when
-	 * allocating a new root (see kvm_mmu_load()), and when migrating vCPU
-	 * to a different pCPU.  Note, the local TLB flush on reuse also
-	 * invalidates any paging-structure-cache entries, i.e. TLB entries for
-	 * intermediate paging structures, that may be zapped, as such entries
-	 * are associated with the ASID on both VMX and SVM.
-	 */
-	tdp_mmu_zap_root(kvm, root, true);
-
-	/*
-	 * Drop the refcount using kvm_tdp_mmu_put_root() to test its logic for
-	 * avoiding an infinite loop.  By design, the root is reachable while
-	 * it's being asynchronously zapped, thus a different task can put its
-	 * last reference, i.e. flowing through kvm_tdp_mmu_put_root() for an
-	 * asynchronously zapped root is unavoidable.
-	 */
-	kvm_tdp_mmu_put_root(kvm, root, true);
-
-	read_unlock(&kvm->mmu_lock);
-}
-
-static void tdp_mmu_schedule_zap_root(struct kvm *kvm, struct kvm_mmu_page *root)
-{
-	root->tdp_mmu_async_data = kvm;
-	INIT_WORK(&root->tdp_mmu_async_work, tdp_mmu_zap_root_work);
-	queue_work(kvm->arch.tdp_mmu_zap_wq, &root->tdp_mmu_async_work);
-}
-
 void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
 			  bool shared)
 {
@@ -211,11 +158,11 @@ static struct kvm_mmu_page *tdp_mmu_next
 #define for_each_valid_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared)	\
 	__for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, true)
 
-#define for_each_tdp_mmu_root_yield_safe(_kvm, _root)			\
-	for (_root = tdp_mmu_next_root(_kvm, NULL, false, false);		\
+#define for_each_tdp_mmu_root_yield_safe(_kvm, _root, _shared)			\
+	for (_root = tdp_mmu_next_root(_kvm, NULL, _shared, false);		\
 	     _root;								\
-	     _root = tdp_mmu_next_root(_kvm, _root, false, false))		\
-		if (!kvm_lockdep_assert_mmu_lock_held(_kvm, false)) {		\
+	     _root = tdp_mmu_next_root(_kvm, _root, _shared, false))		\
+		if (!kvm_lockdep_assert_mmu_lock_held(_kvm, _shared)) {		\
 		} else
 
 /*
@@ -296,7 +243,7 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(stru
 	 * by a memslot update or by the destruction of the VM.  Initialize the
 	 * refcount to two; one reference for the vCPU, and one reference for
 	 * the TDP MMU itself, which is held until the root is invalidated and
-	 * is ultimately put by tdp_mmu_zap_root_work().
+	 * is ultimately put by kvm_tdp_mmu_zap_invalidated_roots().
 	 */
 	refcount_set(&root->tdp_mmu_root_count, 2);
 
@@ -885,7 +832,7 @@ bool kvm_tdp_mmu_zap_leafs(struct kvm *k
 {
 	struct kvm_mmu_page *root;
 
-	for_each_tdp_mmu_root_yield_safe(kvm, root)
+	for_each_tdp_mmu_root_yield_safe(kvm, root, false)
 		flush = tdp_mmu_zap_leafs(kvm, root, start, end, true, flush);
 
 	return flush;
@@ -907,7 +854,7 @@ void kvm_tdp_mmu_zap_all(struct kvm *kvm
 	 * is being destroyed or the userspace VMM has exited.  In both cases,
 	 * KVM_RUN is unreachable, i.e. no vCPUs will ever service the request.
 	 */
-	for_each_tdp_mmu_root_yield_safe(kvm, root)
+	for_each_tdp_mmu_root_yield_safe(kvm, root, false)
 		tdp_mmu_zap_root(kvm, root, false);
 }
 
@@ -917,18 +864,47 @@ void kvm_tdp_mmu_zap_all(struct kvm *kvm
  */
 void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm)
 {
-	flush_workqueue(kvm->arch.tdp_mmu_zap_wq);
+	struct kvm_mmu_page *root;
+
+	read_lock(&kvm->mmu_lock);
+
+	for_each_tdp_mmu_root_yield_safe(kvm, root, true) {
+		if (!root->tdp_mmu_scheduled_root_to_zap)
+			continue;
+
+		root->tdp_mmu_scheduled_root_to_zap = false;
+		KVM_BUG_ON(!root->role.invalid, kvm);
+
+		/*
+		 * A TLB flush is not necessary as KVM performs a local TLB
+		 * flush when allocating a new root (see kvm_mmu_load()), and
+		 * when migrating a vCPU to a different pCPU.  Note, the local
+		 * TLB flush on reuse also invalidates paging-structure-cache
+		 * entries, i.e. TLB entries for intermediate paging structures,
+		 * that may be zapped, as such entries are associated with the
+		 * ASID on both VMX and SVM.
+		 */
+		tdp_mmu_zap_root(kvm, root, true);
+
+		/*
+		 * The referenced needs to be put *after* zapping the root, as
+		 * the root must be reachable by mmu_notifiers while it's being
+		 * zapped
+		 */
+		kvm_tdp_mmu_put_root(kvm, root, true);
+	}
+
+	read_unlock(&kvm->mmu_lock);
 }
 
 /*
  * Mark each TDP MMU root as invalid to prevent vCPUs from reusing a root that
  * is about to be zapped, e.g. in response to a memslots update.  The actual
- * zapping is performed asynchronously.  Using a separate workqueue makes it
- * easy to ensure that the destruction is performed before the "fast zap"
- * completes, without keeping a separate list of invalidated roots; the list is
- * effectively the list of work items in the workqueue.
+ * zapping is done separately so that it happens with mmu_lock with read,
+ * whereas invalidating roots must be done with mmu_lock held for write (unless
+ * the VM is being destroyed).
  *
- * Note, the asynchronous worker is gifted the TDP MMU's reference.
+ * Note, kvm_tdp_mmu_zap_invalidated_roots() is gifted the TDP MMU's reference.
  * See kvm_tdp_mmu_get_vcpu_root_hpa().
  */
 void kvm_tdp_mmu_invalidate_all_roots(struct kvm *kvm)
@@ -953,19 +929,20 @@ void kvm_tdp_mmu_invalidate_all_roots(st
 	/*
 	 * As above, mmu_lock isn't held when destroying the VM!  There can't
 	 * be other references to @kvm, i.e. nothing else can invalidate roots
-	 * or be consuming roots, but walking the list of roots does need to be
-	 * guarded against roots being deleted by the asynchronous zap worker.
+	 * or get/put references to roots.
 	 */
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(root, &kvm->arch.tdp_mmu_roots, link) {
+	list_for_each_entry(root, &kvm->arch.tdp_mmu_roots, link) {
+		/*
+		 * Note, invalid roots can outlive a memslot update!  Invalid
+		 * roots must be *zapped* before the memslot update completes,
+		 * but a different task can acquire a reference and keep the
+		 * root alive after its been zapped.
+		 */
 		if (!root->role.invalid) {
+			root->tdp_mmu_scheduled_root_to_zap = true;
 			root->role.invalid = true;
-			tdp_mmu_schedule_zap_root(kvm, root);
 		}
 	}
-
-	rcu_read_unlock();
 }
 
 /*
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -7,7 +7,7 @@
 
 #include "spte.h"
 
-int kvm_mmu_init_tdp_mmu(struct kvm *kvm);
+void kvm_mmu_init_tdp_mmu(struct kvm *kvm);
 void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm);
 
 hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu);
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12302,9 +12302,7 @@ int kvm_arch_init_vm(struct kvm *kvm, un
 	if (ret)
 		goto out;
 
-	ret = kvm_mmu_init_vm(kvm);
-	if (ret)
-		goto out_page_track;
+	kvm_mmu_init_vm(kvm);
 
 	ret = static_call(kvm_x86_vm_init)(kvm);
 	if (ret)
@@ -12349,7 +12347,6 @@ int kvm_arch_init_vm(struct kvm *kvm, un
 
 out_uninit_mmu:
 	kvm_mmu_uninit_vm(kvm);
-out_page_track:
 	kvm_page_track_cleanup(kvm);
 out:
 	return ret;


