Return-Path: <stable+bounces-143166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5B1AB330E
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642B23BD487
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CD525B67A;
	Mon, 12 May 2025 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rFZxxf0B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B025B67D
	for <stable@vger.kernel.org>; Mon, 12 May 2025 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041683; cv=none; b=uoUn0BChK1Xwq8ZpwD5+VKFhdXMb9ypacLiUOVZ13GJK1gdk4LrGX2rsUoMlhDl7oA/PcGswgGulyqky3BWu1G2XnPuCc0zMn3adbSJZghT0gLcIm9s/Cr7R3srnMkbwhVrvttyANaS5C/FIbKzUCMJMu0tnfMYDKPz9vaI8UyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041683; c=relaxed/simple;
	bh=1Pst9//J++lT4vNBSEC/lidN8RYIh8IViSk7wOr2v24=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jEtJOF13hVgDCYME00sUaAb0uK2g+4RAlWPOB/geYVQo9WjwwJ1x5SSlkHDzs0feGtgUPz8HYT5N3Px2zJsK/pGtB6UYx92FsIfHhhNuhS8WPOnf4w9b7TlSbM2+7ZjRq860k36YOJefl7ljERroUGpQdr65T03Tm6e1NfPGAJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rFZxxf0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5BEC4CEE7;
	Mon, 12 May 2025 09:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747041680;
	bh=1Pst9//J++lT4vNBSEC/lidN8RYIh8IViSk7wOr2v24=;
	h=Subject:To:Cc:From:Date:From;
	b=rFZxxf0ByHCRgLK1+ZZizQMLM6MbREAeHUqL1Xz3iFpDapQMcMerYu7tQNkl6hj/s
	 MxHMSVGCE9qSs3I7Ja5jAbd7xSfh/BSF9o6JhDKZ59+3JobaQ1H/sDcTJ7qsW6WMiL
	 Q74g2j6uNMpUj89tzTmVN520bh5py4EEoFVCD1Yc=
Subject: FAILED: patch "[PATCH] KVM: x86/mmu: Prevent installing hugepages when mem" failed to apply to 6.12-stable tree
To: seanjc@google.com,michael.roth@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 11:21:17 +0200
Message-ID: <2025051217-botch-sloped-8d28@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9129633d568edd36aa22bf703b12835153cec985
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051217-botch-sloped-8d28@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9129633d568edd36aa22bf703b12835153cec985 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Apr 2025 15:09:54 -0700
Subject: [PATCH] KVM: x86/mmu: Prevent installing hugepages when mem
 attributes are changing

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

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 387464ebe8e8..8d1b632e33d2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7670,32 +7670,6 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
 }
 
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
-					struct kvm_gfn_range *range)
-{
-	/*
-	 * Zap SPTEs even if the slot can't be mapped PRIVATE.  KVM x86 only
-	 * supports KVM_MEMORY_ATTRIBUTE_PRIVATE, and so it *seems* like KVM
-	 * can simply ignore such slots.  But if userspace is making memory
-	 * PRIVATE, then KVM must prevent the guest from accessing the memory
-	 * as shared.  And if userspace is making memory SHARED and this point
-	 * is reached, then at least one page within the range was previously
-	 * PRIVATE, i.e. the slot's possible hugepage ranges are changing.
-	 * Zapping SPTEs in this case ensures KVM will reassess whether or not
-	 * a hugepage can be used for affected ranges.
-	 */
-	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
-		return false;
-
-	/* Unmap the old attribute page. */
-	if (range->arg.attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)
-		range->attr_filter = KVM_FILTER_SHARED;
-	else
-		range->attr_filter = KVM_FILTER_PRIVATE;
-
-	return kvm_unmap_gfn_range(kvm, range);
-}
-
 static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
 				int level)
 {
@@ -7714,6 +7688,69 @@ static void hugepage_set_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
 	lpage_info_slot(gfn, slot, level)->disallow_lpage |= KVM_LPAGE_MIXED_FLAG;
 }
 
+bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
+					struct kvm_gfn_range *range)
+{
+	struct kvm_memory_slot *slot = range->slot;
+	int level;
+
+	/*
+	 * Zap SPTEs even if the slot can't be mapped PRIVATE.  KVM x86 only
+	 * supports KVM_MEMORY_ATTRIBUTE_PRIVATE, and so it *seems* like KVM
+	 * can simply ignore such slots.  But if userspace is making memory
+	 * PRIVATE, then KVM must prevent the guest from accessing the memory
+	 * as shared.  And if userspace is making memory SHARED and this point
+	 * is reached, then at least one page within the range was previously
+	 * PRIVATE, i.e. the slot's possible hugepage ranges are changing.
+	 * Zapping SPTEs in this case ensures KVM will reassess whether or not
+	 * a hugepage can be used for affected ranges.
+	 */
+	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
+		return false;
+
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
+	/* Unmap the old attribute page. */
+	if (range->arg.attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)
+		range->attr_filter = KVM_FILTER_SHARED;
+	else
+		range->attr_filter = KVM_FILTER_PRIVATE;
+
+	return kvm_unmap_gfn_range(kvm, range);
+}
+
+
+
 static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
 			       gfn_t gfn, int level, unsigned long attrs)
 {


