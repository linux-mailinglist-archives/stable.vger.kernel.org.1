Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDB273B376
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFWJZW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFWJZV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C415D1FF5
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:25:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F76E619E0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66009C433C8;
        Fri, 23 Jun 2023 09:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687512318;
        bh=wBy+zfhXys2+vLzxr2qonHpvhZ4mbNkOtgp3LSz1EJ4=;
        h=Subject:To:Cc:From:Date:From;
        b=kZ1x26nSvxePrYrfsd6JkLbk7rWKS9w5Hhl46Rnj+h4xM1C2yLlAadjMbajFUdLcP
         zO0uj+SQvrymBXLCpAZFMA822TDxwhoGoEh0q1O9nTkKkebo96M5/tTiif+DYiOGOU
         4blE6lso9YdgmoAMWpiTaCjvxSrVXzqOfB1zybuo=
Subject: FAILED: patch "[PATCH] KVM: Avoid illegal stage2 mapping on invalid memory slot" failed to apply to 5.4-stable tree
To:     gshan@redhat.com, david@redhat.com, hshuai@redhat.com,
        oliver.upton@linux.dev, pbonzini@redhat.com, peterx@redhat.com,
        seanjc@google.com, shahuang@redhat.com, zhenyzha@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 23 Jun 2023 11:25:13 +0200
Message-ID: <2023062312-ranch-brought-bb16@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2230f9e1171a2e9731422a14d1bbc313c0b719d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062312-ranch-brought-bb16@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2230f9e1171a2e9731422a14d1bbc313c0b719d1 Mon Sep 17 00:00:00 2001
From: Gavin Shan <gshan@redhat.com>
Date: Thu, 15 Jun 2023 15:42:59 +1000
Subject: [PATCH] KVM: Avoid illegal stage2 mapping on invalid memory slot

We run into guest hang in edk2 firmware when KSM is kept as running on
the host. The edk2 firmware is waiting for status 0x80 from QEMU's pflash
device (TYPE_PFLASH_CFI01) during the operation of sector erasing or
buffered write. The status is returned by reading the memory region of
the pflash device and the read request should have been forwarded to QEMU
and emulated by it. Unfortunately, the read request is covered by an
illegal stage2 mapping when the guest hang issue occurs. The read request
is completed with QEMU bypassed and wrong status is fetched. The edk2
firmware runs into an infinite loop with the wrong status.

The illegal stage2 mapping is populated due to same page sharing by KSM
at (C) even the associated memory slot has been marked as invalid at (B)
when the memory slot is requested to be deleted. It's notable that the
active and inactive memory slots can't be swapped when we're in the middle
of kvm_mmu_notifier_change_pte() because kvm->mn_active_invalidate_count
is elevated, and kvm_swap_active_memslots() will busy loop until it reaches
to zero again. Besides, the swapping from the active to the inactive memory
slots is also avoided by holding &kvm->srcu in __kvm_handle_hva_range(),
corresponding to synchronize_srcu_expedited() in kvm_swap_active_memslots().

  CPU-A                    CPU-B
  -----                    -----
                           ioctl(kvm_fd, KVM_SET_USER_MEMORY_REGION)
                           kvm_vm_ioctl_set_memory_region
                           kvm_set_memory_region
                           __kvm_set_memory_region
                           kvm_set_memslot(kvm, old, NULL, KVM_MR_DELETE)
                             kvm_invalidate_memslot
                               kvm_copy_memslot
                               kvm_replace_memslot
                               kvm_swap_active_memslots        (A)
                               kvm_arch_flush_shadow_memslot   (B)
  same page sharing by KSM
  kvm_mmu_notifier_invalidate_range_start
        :
  kvm_mmu_notifier_change_pte
    kvm_handle_hva_range
    __kvm_handle_hva_range
    kvm_set_spte_gfn            (C)
        :
  kvm_mmu_notifier_invalidate_range_end

Fix the issue by skipping the invalid memory slot at (C) to avoid the
illegal stage2 mapping so that the read request for the pflash's status
is forwarded to QEMU and emulated by it. In this way, the correct pflash's
status can be returned from QEMU to break the infinite loop in the edk2
firmware.

We tried a git-bisect and the first problematic commit is cd4c71835228 ("
KVM: arm64: Convert to the gfn-based MMU notifier callbacks"). With this,
clean_dcache_guest_page() is called after the memory slots are iterated
in kvm_mmu_notifier_change_pte(). clean_dcache_guest_page() is called
before the iteration on the memory slots before this commit. This change
literally enlarges the racy window between kvm_mmu_notifier_change_pte()
and memory slot removal so that we're able to reproduce the issue in a
practical test case. However, the issue exists since commit d5d8184d35c9
("KVM: ARM: Memory virtualization setup").

Cc: stable@vger.kernel.org # v3.9+
Fixes: d5d8184d35c9 ("KVM: ARM: Memory virtualization setup")
Reported-by: Shuai Hu <hshuai@redhat.com>
Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Message-Id: <20230615054259.14911-1-gshan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 479802a892d4..65f94f592ff8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -686,6 +686,24 @@ static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn
 
 	return __kvm_handle_hva_range(kvm, &range);
 }
+
+static bool kvm_change_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	/*
+	 * Skipping invalid memslots is correct if and only change_pte() is
+	 * surrounded by invalidate_range_{start,end}(), which is currently
+	 * guaranteed by the primary MMU.  If that ever changes, KVM needs to
+	 * unmap the memslot instead of skipping the memslot to ensure that KVM
+	 * doesn't hold references to the old PFN.
+	 */
+	WARN_ON_ONCE(!READ_ONCE(kvm->mn_active_invalidate_count));
+
+	if (range->slot->flags & KVM_MEMSLOT_INVALID)
+		return false;
+
+	return kvm_set_spte_gfn(kvm, range);
+}
+
 static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 					struct mm_struct *mm,
 					unsigned long address,
@@ -707,7 +725,7 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 	if (!READ_ONCE(kvm->mmu_invalidate_in_progress))
 		return;
 
-	kvm_handle_hva_range(mn, address, address + 1, pte, kvm_set_spte_gfn);
+	kvm_handle_hva_range(mn, address, address + 1, pte, kvm_change_spte_gfn);
 }
 
 void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,

