Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40592753000
	for <lists+stable@lfdr.de>; Fri, 14 Jul 2023 05:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjGNDeC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 13 Jul 2023 23:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjGNDeB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 13 Jul 2023 23:34:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB4626A5
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 20:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689305640; x=1720841640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TXRup18vHiNmiVUtXp5b5mn/ui+rIVoYItGrEuKZ45E=;
  b=U4FGGynvCX0waJ0Msahb94vhl1diNrtyS5jxfT22R+UKdwSCCnJjacy2
   WK/5TLF+ucyJbVXB4QhDhmpql+WYFIoYkLyk31rP9eEvVlPR/HXqezTnK
   9wlta2wPsQnubGRYDzFRwsEovyb2rmtZOyalEe3ce9p90WUl3GBsyJAFE
   sXknv4Q6a+nWrrQnECuQaFbjNn8NHbkKzyfSfRu9BVb/KLvOkFiLakSib
   S3gal9UDyp385EZRiwCOnMWC8EJnbV/M1xlR4exJQiS3jrmuaJJrtTejo
   Q/KlNQfW8UBXa92/f0NmE5AoV9PVgAyZAOf+BWIXUf9328I4qL9UPRvaA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="451743285"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="451743285"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:33:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="846313088"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="846313088"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2023 20:33:51 -0700
From:   tien.sung.ang@intel.com
To:     tien.sung.ang@intel.com
Cc:     Gavin Shan <gshan@redhat.com>, stable@vger.kernel.org,
        Shuai Hu <hshuai@redhat.com>,
        Zhenyu Zhang <zhenyzha@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Shaoqin Huang <shahuang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/2] KVM: Avoid illegal stage2 mapping on invalid memory slot
Date:   Fri, 14 Jul 2023 11:32:46 +0800
Message-Id: <20230714033247.3791879-2-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230714033247.3791879-1-tien.sung.ang@intel.com>
References: <20230714033247.3791879-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gavin Shan <gshan@redhat.com>

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
---
 virt/kvm/kvm_main.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

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
-- 
2.25.1

