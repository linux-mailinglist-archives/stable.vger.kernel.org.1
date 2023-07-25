Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8CC7611B7
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjGYKzP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjGYKya (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73614688
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FEF861682
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3060EC433C8;
        Tue, 25 Jul 2023 10:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282357;
        bh=veh2oKLRNthmVzIwZ0UjRAZRzKtF3ZqYpiCa6d6WDl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2JF2m8AMFQbhEi5Je0AjKbPLZ1+Sf2IQ0YhQwoSamnJNtbrYMtrEEAXnUevGAZuw
         T/Us14+qVnQdJluFfo6IQwZc1TStWrBD+1Y0eEu1zdTozUe2BzvKZVVD5GW4/o9d6S
         FjQrrRzBmx7Gxpexdt50+xdrwGEcaq8+2IKpy6dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Zhao <yuzhao@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Shaoqin Huang <shahuang@redhat.com>,
        Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 6.4 072/227] KVM: arm64: Correctly handle page aging notifiers for unaligned memslot
Date:   Tue, 25 Jul 2023 12:43:59 +0200
Message-ID: <20230725104517.747504997@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Oliver Upton <oliver.upton@linux.dev>

commit df6556adf27b7372cfcd97e1c0afb0d516c8279f upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/kvm_pgtable.h |   26 ++++++-------------
 arch/arm64/kvm/hyp/pgtable.c         |   47 ++++++++++++++++++++++++++++-------
 arch/arm64/kvm/mmu.c                 |   18 +++++--------
 3 files changed, 55 insertions(+), 36 deletions(-)

--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -556,22 +556,26 @@ int kvm_pgtable_stage2_wrprotect(struct
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
@@ -594,18 +598,6 @@ int kvm_pgtable_stage2_relax_perms(struc
 				   enum kvm_pgtable_prot prot);
 
 /**
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
-/**
  * kvm_pgtable_stage2_flush_range() - Clean and invalidate data cache to Point
  * 				      of Coherency for guest stage-2 address
  *				      range.
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1173,25 +1173,54 @@ kvm_pte_t kvm_pgtable_stage2_mkyoung(str
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
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1639,27 +1639,25 @@ bool kvm_set_spte_gfn(struct kvm *kvm, s
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


