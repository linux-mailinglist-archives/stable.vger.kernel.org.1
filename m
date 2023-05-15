Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D446E703773
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244020AbjEORVT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244075AbjEORVD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:21:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3947712EAA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:18:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A080621F0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFC6C433D2;
        Mon, 15 May 2023 17:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171134;
        bh=Y+w30pJKtWGAnRmDY6vHttfs1LLqjtgvgMI7JVb7v/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8wBUuuW91i4sx7xUNT9G5rq3fefT5YTLI5Nuv227MrBOUR+CVKMT/fhM3TvrSQHW
         ilaQc7zWYZVSKHzPnNopzt4B7vMmrUzjjAtv+u9kDcM0l9jbXAn8CmCinkUK3TVY0i
         NbDSlWhZ6LuHL3uQ9R2CX9gt5XB3rknJ27a05bT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 112/242] KVM: x86/mmu: Change tdp_mmu to a read-only parameter
Date:   Mon, 15 May 2023 18:27:18 +0200
Message-Id: <20230515161725.268129156@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: David Matlack <dmatlack@google.com>

[ Upstream commit 3af15ff47c4df3af7b36ea8315f43c6b0af49253 ]

Change tdp_mmu to a read-only parameter and drop the per-vm
tdp_mmu_enabled. For 32-bit KVM, make tdp_mmu_enabled a macro that is
always false so that the compiler can continue omitting cals to the TDP
MMU.

The TDP MMU was introduced in 5.10 and has been enabled by default since
5.15. At this point there are no known functionality gaps between the
TDP MMU and the shadow MMU, and the TDP MMU uses less memory and scales
better with the number of vCPUs. In other words, there is no good reason
to disable the TDP MMU on a live system.

Purposely do not drop tdp_mmu=N support (i.e. do not force 64-bit KVM to
always use the TDP MMU) since tdp_mmu=N is still used to get test
coverage of KVM's shadow MMU TDP support, which is used in 32-bit KVM.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20220921173546.2674386-2-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: edbdb43fc96b ("KVM: x86: Preserve TDP MMU roots until they are explicitly invalidated")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h | 13 ++-------
 arch/x86/kvm/mmu.h              |  6 ++--
 arch/x86/kvm/mmu/mmu.c          | 51 ++++++++++++++++++++++-----------
 arch/x86/kvm/mmu/tdp_mmu.c      |  9 ++----
 4 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 24480b4f1c575..adc3149c833a9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1342,21 +1342,12 @@ struct kvm_arch {
 	struct task_struct *nx_huge_page_recovery_thread;
 
 #ifdef CONFIG_X86_64
-	/*
-	 * Whether the TDP MMU is enabled for this VM. This contains a
-	 * snapshot of the TDP MMU module parameter from when the VM was
-	 * created and remains unchanged for the life of the VM. If this is
-	 * true, TDP MMU handler functions will run for various MMU
-	 * operations.
-	 */
-	bool tdp_mmu_enabled;
-
 	/* The number of TDP MMU pages across all roots. */
 	atomic64_t tdp_mmu_pages;
 
 	/*
-	 * List of kvm_mmu_page structs being used as roots.
-	 * All kvm_mmu_page structs in the list should have
+	 * List of struct kvm_mmu_pages being used as roots.
+	 * All struct kvm_mmu_pages in the list should have
 	 * tdp_mmu_page set.
 	 *
 	 * For reads, this list is protected by:
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 59804be91b5b0..0f38b78ab04b7 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -254,14 +254,14 @@ static inline bool kvm_shadow_root_allocated(struct kvm *kvm)
 }
 
 #ifdef CONFIG_X86_64
-static inline bool is_tdp_mmu_enabled(struct kvm *kvm) { return kvm->arch.tdp_mmu_enabled; }
+extern bool tdp_mmu_enabled;
 #else
-static inline bool is_tdp_mmu_enabled(struct kvm *kvm) { return false; }
+#define tdp_mmu_enabled false
 #endif
 
 static inline bool kvm_memslots_have_rmaps(struct kvm *kvm)
 {
-	return !is_tdp_mmu_enabled(kvm) || kvm_shadow_root_allocated(kvm);
+	return !tdp_mmu_enabled || kvm_shadow_root_allocated(kvm);
 }
 
 static inline gfn_t gfn_to_index(gfn_t gfn, gfn_t base_gfn, int level)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ce135539145fd..583979755bd4f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -99,6 +99,13 @@ module_param_named(flush_on_reuse, force_flush_and_sync_on_reuse, bool, 0644);
  */
 bool tdp_enabled = false;
 
+bool __ro_after_init tdp_mmu_allowed;
+
+#ifdef CONFIG_X86_64
+bool __read_mostly tdp_mmu_enabled = true;
+module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0444);
+#endif
+
 static int max_huge_page_level __read_mostly;
 static int tdp_root_level __read_mostly;
 static int max_tdp_level __read_mostly;
@@ -1293,7 +1300,7 @@ static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
 {
 	struct kvm_rmap_head *rmap_head;
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		kvm_tdp_mmu_clear_dirty_pt_masked(kvm, slot,
 				slot->base_gfn + gfn_offset, mask, true);
 
@@ -1326,7 +1333,7 @@ static void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 {
 	struct kvm_rmap_head *rmap_head;
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		kvm_tdp_mmu_clear_dirty_pt_masked(kvm, slot,
 				slot->base_gfn + gfn_offset, mask, false);
 
@@ -1409,7 +1416,7 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 		}
 	}
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		write_protected |=
 			kvm_tdp_mmu_write_protect_gfn(kvm, slot, gfn, min_level);
 
@@ -1572,7 +1579,7 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 	if (kvm_memslots_have_rmaps(kvm))
 		flush = kvm_handle_gfn_range(kvm, range, kvm_zap_rmap);
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		flush = kvm_tdp_mmu_unmap_gfn_range(kvm, range, flush);
 
 	return flush;
@@ -1585,7 +1592,7 @@ bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	if (kvm_memslots_have_rmaps(kvm))
 		flush = kvm_handle_gfn_range(kvm, range, kvm_set_pte_rmap);
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		flush |= kvm_tdp_mmu_set_spte_gfn(kvm, range);
 
 	return flush;
@@ -1660,7 +1667,7 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	if (kvm_memslots_have_rmaps(kvm))
 		young = kvm_handle_gfn_range(kvm, range, kvm_age_rmap);
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		young |= kvm_tdp_mmu_age_gfn_range(kvm, range);
 
 	return young;
@@ -1673,7 +1680,7 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	if (kvm_memslots_have_rmaps(kvm))
 		young = kvm_handle_gfn_range(kvm, range, kvm_test_age_rmap);
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		young |= kvm_tdp_mmu_test_age_gfn(kvm, range);
 
 	return young;
@@ -3610,7 +3617,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 	if (r < 0)
 		goto out_unlock;
 
-	if (is_tdp_mmu_enabled(vcpu->kvm)) {
+	if (tdp_mmu_enabled) {
 		root = kvm_tdp_mmu_get_vcpu_root_hpa(vcpu);
 		mmu->root.hpa = root;
 	} else if (shadow_root_level >= PT64_ROOT_4LEVEL) {
@@ -5743,6 +5750,9 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
 	tdp_root_level = tdp_forced_root_level;
 	max_tdp_level = tdp_max_root_level;
 
+#ifdef CONFIG_X86_64
+	tdp_mmu_enabled = tdp_mmu_allowed && tdp_enabled;
+#endif
 	/*
 	 * max_huge_page_level reflects KVM's MMU capabilities irrespective
 	 * of kernel support, e.g. KVM may be capable of using 1GB pages when
@@ -5990,7 +6000,7 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 	 * write and in the same critical section as making the reload request,
 	 * e.g. before kvm_zap_obsolete_pages() could drop mmu_lock and yield.
 	 */
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		kvm_tdp_mmu_invalidate_all_roots(kvm);
 
 	/*
@@ -6015,7 +6025,7 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 	 * Deferring the zap until the final reference to the root is put would
 	 * lead to use-after-free.
 	 */
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		kvm_tdp_mmu_zap_invalidated_roots(kvm);
 }
 
@@ -6127,7 +6137,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 
 	flush = kvm_rmap_zap_gfn_range(kvm, gfn_start, gfn_end);
 
-	if (is_tdp_mmu_enabled(kvm)) {
+	if (tdp_mmu_enabled) {
 		for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
 			flush = kvm_tdp_mmu_zap_leafs(kvm, i, gfn_start,
 						      gfn_end, true, flush);
@@ -6160,7 +6170,7 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 		write_unlock(&kvm->mmu_lock);
 	}
 
-	if (is_tdp_mmu_enabled(kvm)) {
+	if (tdp_mmu_enabled) {
 		read_lock(&kvm->mmu_lock);
 		kvm_tdp_mmu_wrprot_slot(kvm, memslot, start_level);
 		read_unlock(&kvm->mmu_lock);
@@ -6403,7 +6413,7 @@ void kvm_mmu_try_split_huge_pages(struct kvm *kvm,
 				   u64 start, u64 end,
 				   int target_level)
 {
-	if (!is_tdp_mmu_enabled(kvm))
+	if (!tdp_mmu_enabled)
 		return;
 
 	if (kvm_memslots_have_rmaps(kvm))
@@ -6424,7 +6434,7 @@ void kvm_mmu_slot_try_split_huge_pages(struct kvm *kvm,
 	u64 start = memslot->base_gfn;
 	u64 end = start + memslot->npages;
 
-	if (!is_tdp_mmu_enabled(kvm))
+	if (!tdp_mmu_enabled)
 		return;
 
 	if (kvm_memslots_have_rmaps(kvm)) {
@@ -6507,7 +6517,7 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 		write_unlock(&kvm->mmu_lock);
 	}
 
-	if (is_tdp_mmu_enabled(kvm)) {
+	if (tdp_mmu_enabled) {
 		read_lock(&kvm->mmu_lock);
 		kvm_tdp_mmu_zap_collapsible_sptes(kvm, slot);
 		read_unlock(&kvm->mmu_lock);
@@ -6542,7 +6552,7 @@ void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
 		write_unlock(&kvm->mmu_lock);
 	}
 
-	if (is_tdp_mmu_enabled(kvm)) {
+	if (tdp_mmu_enabled) {
 		read_lock(&kvm->mmu_lock);
 		kvm_tdp_mmu_clear_dirty_slot(kvm, memslot);
 		read_unlock(&kvm->mmu_lock);
@@ -6577,7 +6587,7 @@ void kvm_mmu_zap_all(struct kvm *kvm)
 
 	kvm_mmu_commit_zap_page(kvm, &invalid_list);
 
-	if (is_tdp_mmu_enabled(kvm))
+	if (tdp_mmu_enabled)
 		kvm_tdp_mmu_zap_all(kvm);
 
 	write_unlock(&kvm->mmu_lock);
@@ -6742,6 +6752,13 @@ void __init kvm_mmu_x86_module_init(void)
 	if (nx_huge_pages == -1)
 		__set_nx_huge_pages(get_nx_auto_mode());
 
+	/*
+	 * Snapshot userspace's desire to enable the TDP MMU. Whether or not the
+	 * TDP MMU is actually enabled is determined in kvm_configure_mmu()
+	 * when the vendor module is loaded.
+	 */
+	tdp_mmu_allowed = tdp_mmu_enabled;
+
 	kvm_mmu_spte_module_init();
 }
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index d6df38d371a00..03511e83050fa 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -10,23 +10,18 @@
 #include <asm/cmpxchg.h>
 #include <trace/events/kvm.h>
 
-static bool __read_mostly tdp_mmu_enabled = true;
-module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0644);
-
 /* Initializes the TDP MMU for the VM, if enabled. */
 int kvm_mmu_init_tdp_mmu(struct kvm *kvm)
 {
 	struct workqueue_struct *wq;
 
-	if (!tdp_enabled || !READ_ONCE(tdp_mmu_enabled))
+	if (!tdp_mmu_enabled)
 		return 0;
 
 	wq = alloc_workqueue("kvm", WQ_UNBOUND|WQ_MEM_RECLAIM|WQ_CPU_INTENSIVE, 0);
 	if (!wq)
 		return -ENOMEM;
 
-	/* This should not be changed for the lifetime of the VM. */
-	kvm->arch.tdp_mmu_enabled = true;
 	INIT_LIST_HEAD(&kvm->arch.tdp_mmu_roots);
 	spin_lock_init(&kvm->arch.tdp_mmu_pages_lock);
 	kvm->arch.tdp_mmu_zap_wq = wq;
@@ -47,7 +42,7 @@ static __always_inline bool kvm_lockdep_assert_mmu_lock_held(struct kvm *kvm,
 
 void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
 {
-	if (!kvm->arch.tdp_mmu_enabled)
+	if (!tdp_mmu_enabled)
 		return;
 
 	/* Also waits for any queued work items.  */
-- 
2.39.2



