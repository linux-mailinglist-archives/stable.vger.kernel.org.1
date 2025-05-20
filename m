Return-Path: <stable+bounces-145382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5166ABDB30
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F057AEDA0
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CDE2F37;
	Tue, 20 May 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XUmG2KAq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8262F2472AB;
	Tue, 20 May 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750015; cv=none; b=ScvQDjjK9T3baYgebuslQEebsPAJ6v017lWjNPN1QHFHbSe8ClwcwDDBvWHp6Sc726wQDmkHpv6g0FLbSeU/I+2i+p6eSyWcOSD4yhmBvm+ZKzSoIMV4oJdfGgmop91niINSmnWgblp0KSnADF1GnvydxPZMaiJhsgg0fqDIP3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750015; c=relaxed/simple;
	bh=7URMDdW2CmOLsVIhjytDL1gqe3H2VIqALY7KMjWSuis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brSOBN/XsPEjr+Voq9dgwvIZ1ozn4cfET7TX9yTcJDcz2R8FLFtMtGv0REEGED5t4LDz8KTAFdJENLZSgGWqZsyZiLCZRGr93CvTjudODaADmleEJpmHL6MAWquD/RLdX0Wz8xTs+NOSltXdHnOvEUO/BTreCDlyljhBy3x6Pus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XUmG2KAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A801C4CEE9;
	Tue, 20 May 2025 14:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747750014;
	bh=7URMDdW2CmOLsVIhjytDL1gqe3H2VIqALY7KMjWSuis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XUmG2KAqg+AS3J7q5gvpSUgY2zViKB7w/HmBYat9tDfVgiai41PIGUFznSM/g1WR1
	 Xw1MlQNfUuKPuWGb7L5JwrSEGMpH+8mUc8lmS++CCC4ZKedwtaxEfpUBqO6LQ/a4iM
	 4173YS9nz0/ruuLb0dJOX8uwvpKrJ4bup94h5J1I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Roth <michael.roth@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 015/143] KVM: x86/mmu: Prevent installing hugepages when mem attributes are changing
Date: Tue, 20 May 2025 15:49:30 +0200
Message-ID: <20250520125810.660748724@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
References: <20250520125810.036375422@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 9129633d568edd36aa22bf703b12835153cec985 ]

When changing memory attributes on a subset of a potential hugepage, add
the hugepage to the invalidation range tracking to prevent installing a
hugepage until the attributes are fully updated.  Like the actual hugepage
tracking updates in kvm_arch_post_set_memory_attributes(), process only
the head and tail pages, as any potential hugepages that are entirely
covered by the range will already be tracked.

Note, only hugepage chunks whose current attributes are NOT mixed need to
be added to the invalidation set, as mixed attributes already prevent
installing a hugepage, and it's perfectly safe to install a smaller
mapping for a gfn whose attributes aren't changing.

Fixes: 8dd2eee9d526 ("KVM: x86/mmu: Handle page fault for private memory")
Cc: stable@vger.kernel.org
Reported-by: Michael Roth <michael.roth@amd.com>
Tested-by: Michael Roth <michael.roth@amd.com>
Link: https://lore.kernel.org/r/20250430220954.522672-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 69 ++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4943732e07cd7..4607610ef0628 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7616,9 +7616,30 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
 }
 
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
+				int level)
+{
+	return lpage_info_slot(gfn, slot, level)->disallow_lpage & KVM_LPAGE_MIXED_FLAG;
+}
+
+static void hugepage_clear_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
+				 int level)
+{
+	lpage_info_slot(gfn, slot, level)->disallow_lpage &= ~KVM_LPAGE_MIXED_FLAG;
+}
+
+static void hugepage_set_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
+			       int level)
+{
+	lpage_info_slot(gfn, slot, level)->disallow_lpage |= KVM_LPAGE_MIXED_FLAG;
+}
+
 bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range)
 {
+	struct kvm_memory_slot *slot = range->slot;
+	int level;
+
 	/*
 	 * Zap SPTEs even if the slot can't be mapped PRIVATE.  KVM x86 only
 	 * supports KVM_MEMORY_ATTRIBUTE_PRIVATE, and so it *seems* like KVM
@@ -7633,6 +7654,38 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
 		return false;
 
+	if (WARN_ON_ONCE(range->end <= range->start))
+		return false;
+
+	/*
+	 * If the head and tail pages of the range currently allow a hugepage,
+	 * i.e. reside fully in the slot and don't have mixed attributes, then
+	 * add each corresponding hugepage range to the ongoing invalidation,
+	 * e.g. to prevent KVM from creating a hugepage in response to a fault
+	 * for a gfn whose attributes aren't changing.  Note, only the range
+	 * of gfns whose attributes are being modified needs to be explicitly
+	 * unmapped, as that will unmap any existing hugepages.
+	 */
+	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
+		gfn_t start = gfn_round_for_level(range->start, level);
+		gfn_t end = gfn_round_for_level(range->end - 1, level);
+		gfn_t nr_pages = KVM_PAGES_PER_HPAGE(level);
+
+		if ((start != range->start || start + nr_pages > range->end) &&
+		    start >= slot->base_gfn &&
+		    start + nr_pages <= slot->base_gfn + slot->npages &&
+		    !hugepage_test_mixed(slot, start, level))
+			kvm_mmu_invalidate_range_add(kvm, start, start + nr_pages);
+
+		if (end == start)
+			continue;
+
+		if ((end + nr_pages) > range->end &&
+		    (end + nr_pages) <= (slot->base_gfn + slot->npages) &&
+		    !hugepage_test_mixed(slot, end, level))
+			kvm_mmu_invalidate_range_add(kvm, end, end + nr_pages);
+	}
+
 	/* Unmap the old attribute page. */
 	if (range->arg.attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)
 		range->attr_filter = KVM_FILTER_SHARED;
@@ -7642,23 +7695,7 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 	return kvm_unmap_gfn_range(kvm, range);
 }
 
-static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
-				int level)
-{
-	return lpage_info_slot(gfn, slot, level)->disallow_lpage & KVM_LPAGE_MIXED_FLAG;
-}
-
-static void hugepage_clear_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
-				 int level)
-{
-	lpage_info_slot(gfn, slot, level)->disallow_lpage &= ~KVM_LPAGE_MIXED_FLAG;
-}
 
-static void hugepage_set_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
-			       int level)
-{
-	lpage_info_slot(gfn, slot, level)->disallow_lpage |= KVM_LPAGE_MIXED_FLAG;
-}
 
 static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
 			       gfn_t gfn, int level, unsigned long attrs)
-- 
2.39.5




