Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BA575E4E7
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 22:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjGWUk5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 16:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWUk5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 16:40:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E54FE49
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 13:40:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E141C60E9B
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 20:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4258C433C8;
        Sun, 23 Jul 2023 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690144854;
        bh=je1grgWWZGugvPhnAkDHcalQvI6pZWHT8sR2o5An/94=;
        h=Subject:To:Cc:From:Date:From;
        b=Xy9xa9XnALsQZJdOfimAfFRdDImiSoangr/U9fqDZsx1isgzX4rxFcPTho94eULN/
         FKKZ7a5uT2cHR5XrZYYpYFCYzFjPRGuIlgP1F3PplyysB2rokctqp0Dvc3581uO56k
         +Nr1PYCLueEIJBjG7D0NnnELZTwokZgVMsRds1/Y=
Subject: FAILED: patch "[PATCH] KVM: arm64: Correctly handle page aging notifiers for" failed to apply to 6.1-stable tree
To:     oliver.upton@linux.dev, maz@kernel.org, reijiw@google.com,
        shahuang@redhat.com, yuzhao@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 22:40:51 +0200
Message-ID: <2023072351-slackness-unlearned-6f45@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x df6556adf27b7372cfcd97e1c0afb0d516c8279f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072351-slackness-unlearned-6f45@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

df6556adf27b ("KVM: arm64: Correctly handle page aging notifiers for unaligned memslot")
ca5de2448c3b ("KVM: arm64: Atomically update stage 2 leaf attributes in parallel walks")
6b91b8f95cad ("KVM: arm64: Use an opaque type for pteps")
fa002e8e79b3 ("KVM: arm64: Don't pass kvm_pgtable through kvm_pgtable_walk_data")
2a611c7f87f2 ("KVM: arm64: Pass mm_ops through the visitor context")
83844a2317ec ("KVM: arm64: Stash observed pte value in visitor context")
dfc7a7769ab7 ("KVM: arm64: Combine visitor arguments into a context structure")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From df6556adf27b7372cfcd97e1c0afb0d516c8279f Mon Sep 17 00:00:00 2001
From: Oliver Upton <oliver.upton@linux.dev>
Date: Tue, 27 Jun 2023 23:54:05 +0000
Subject: [PATCH] KVM: arm64: Correctly handle page aging notifiers for
 unaligned memslot

Userspace is allowed to select any PAGE_SIZE aligned hva to back guest
memory. This is even the case with hugepages, although it is a rather
suboptimal configuration as PTE level mappings are used at stage-2.

The arm64 page aging handlers have an assumption that the specified
range is exactly one page/block of memory, which in the aforementioned
case is not necessarily true. All together this leads to the WARN() in
kvm_age_gfn() firing.

However, the WARN is only part of the issue as the table walkers visit
at most a single leaf PTE. For hugepage-backed memory in a memslot that
isn't hugepage-aligned, page aging entirely misses accesses to the
hugepage beyond the first page in the memslot.

Add a new walker dedicated to handling page aging MMU notifiers capable
of walking a range of PTEs. Convert kvm(_test)_age_gfn() over to the new
walker and drop the WARN that caught the issue in the first place. The
implementation of this walker was inspired by the test_clear_young()
implementation by Yu Zhao [*], but repurposed to address a bug in the
existing aging implementation.

Cc: stable@vger.kernel.org # v5.15
Fixes: 056aad67f836 ("kvm: arm/arm64: Rework gpa callback handlers")
Link: https://lore.kernel.org/kvmarm/20230526234435.662652-6-yuzhao@google.com/
Co-developed-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: Reiji Watanabe <reijiw@google.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Link: https://lore.kernel.org/r/20230627235405.4069823-1-oliver.upton@linux.dev
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 8294a9a7e566..929d355eae0a 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -608,22 +608,26 @@ int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size);
 kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr);
 
 /**
- * kvm_pgtable_stage2_mkold() - Clear the access flag in a page-table entry.
+ * kvm_pgtable_stage2_test_clear_young() - Test and optionally clear the access
+ *					   flag in a page-table entry.
  * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
  * @addr:	Intermediate physical address to identify the page-table entry.
+ * @size:	Size of the address range to visit.
+ * @mkold:	True if the access flag should be cleared.
  *
  * The offset of @addr within a page is ignored.
  *
- * If there is a valid, leaf page-table entry used to translate @addr, then
- * clear the access flag in that entry.
+ * Tests and conditionally clears the access flag for every valid, leaf
+ * page-table entry used to translate the range [@addr, @addr + @size).
  *
  * Note that it is the caller's responsibility to invalidate the TLB after
  * calling this function to ensure that the updated permissions are visible
  * to the CPUs.
  *
- * Return: The old page-table entry prior to clearing the flag, 0 on failure.
+ * Return: True if any of the visited PTEs had the access flag set.
  */
-kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr);
+bool kvm_pgtable_stage2_test_clear_young(struct kvm_pgtable *pgt, u64 addr,
+					 u64 size, bool mkold);
 
 /**
  * kvm_pgtable_stage2_relax_perms() - Relax the permissions enforced by a
@@ -645,18 +649,6 @@ kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr);
 int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 				   enum kvm_pgtable_prot prot);
 
-/**
- * kvm_pgtable_stage2_is_young() - Test whether a page-table entry has the
- *				   access flag set.
- * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
- * @addr:	Intermediate physical address to identify the page-table entry.
- *
- * The offset of @addr within a page is ignored.
- *
- * Return: True if the page-table entry has the access flag set, false otherwise.
- */
-bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr);
-
 /**
  * kvm_pgtable_stage2_flush_range() - Clean and invalidate data cache to Point
  * 				      of Coherency for guest stage-2 address
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index aa740a974e02..f7a93ef29250 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1195,25 +1195,54 @@ kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr)
 	return pte;
 }
 
-kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr)
+struct stage2_age_data {
+	bool	mkold;
+	bool	young;
+};
+
+static int stage2_age_walker(const struct kvm_pgtable_visit_ctx *ctx,
+			     enum kvm_pgtable_walk_flags visit)
 {
-	kvm_pte_t pte = 0;
-	stage2_update_leaf_attrs(pgt, addr, 1, 0, KVM_PTE_LEAF_ATTR_LO_S2_AF,
-				 &pte, NULL, 0);
+	kvm_pte_t new = ctx->old & ~KVM_PTE_LEAF_ATTR_LO_S2_AF;
+	struct stage2_age_data *data = ctx->arg;
+
+	if (!kvm_pte_valid(ctx->old) || new == ctx->old)
+		return 0;
+
+	data->young = true;
+
+	/*
+	 * stage2_age_walker() is always called while holding the MMU lock for
+	 * write, so this will always succeed. Nonetheless, this deliberately
+	 * follows the race detection pattern of the other stage-2 walkers in
+	 * case the locking mechanics of the MMU notifiers is ever changed.
+	 */
+	if (data->mkold && !stage2_try_set_pte(ctx, new))
+		return -EAGAIN;
+
 	/*
 	 * "But where's the TLBI?!", you scream.
 	 * "Over in the core code", I sigh.
 	 *
 	 * See the '->clear_flush_young()' callback on the KVM mmu notifier.
 	 */
-	return pte;
+	return 0;
 }
 
-bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr)
+bool kvm_pgtable_stage2_test_clear_young(struct kvm_pgtable *pgt, u64 addr,
+					 u64 size, bool mkold)
 {
-	kvm_pte_t pte = 0;
-	stage2_update_leaf_attrs(pgt, addr, 1, 0, 0, &pte, NULL, 0);
-	return pte & KVM_PTE_LEAF_ATTR_LO_S2_AF;
+	struct stage2_age_data data = {
+		.mkold		= mkold,
+	};
+	struct kvm_pgtable_walker walker = {
+		.cb		= stage2_age_walker,
+		.arg		= &data,
+		.flags		= KVM_PGTABLE_WALK_LEAF,
+	};
+
+	WARN_ON(kvm_pgtable_walk(pgt, addr, size, &walker));
+	return data.young;
 }
 
 int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 6db9ef288ec3..d3b4feed460c 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1756,27 +1756,25 @@ bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	u64 size = (range->end - range->start) << PAGE_SHIFT;
-	kvm_pte_t kpte;
-	pte_t pte;
 
 	if (!kvm->arch.mmu.pgt)
 		return false;
 
-	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
-
-	kpte = kvm_pgtable_stage2_mkold(kvm->arch.mmu.pgt,
-					range->start << PAGE_SHIFT);
-	pte = __pte(kpte);
-	return pte_valid(pte) && pte_young(pte);
+	return kvm_pgtable_stage2_test_clear_young(kvm->arch.mmu.pgt,
+						   range->start << PAGE_SHIFT,
+						   size, true);
 }
 
 bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
+	u64 size = (range->end - range->start) << PAGE_SHIFT;
+
 	if (!kvm->arch.mmu.pgt)
 		return false;
 
-	return kvm_pgtable_stage2_is_young(kvm->arch.mmu.pgt,
-					   range->start << PAGE_SHIFT);
+	return kvm_pgtable_stage2_test_clear_young(kvm->arch.mmu.pgt,
+						   range->start << PAGE_SHIFT,
+						   size, false);
 }
 
 phys_addr_t kvm_mmu_get_httbr(void)

