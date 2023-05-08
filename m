Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F886FA6BB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjEHKXg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjEHKW5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC0226440
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:22:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95A9162558
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECC8C433D2;
        Mon,  8 May 2023 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541359;
        bh=RYcuv2AKDhgFulErznTiyqNbhpGoncAcv8nfL1/qI+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pa7oev77DAurRRTwd0SWHnskunuCGbHeH4ArBgoWdD51WzJ1ozu0uH+KCCMGW6H5K
         Yk2AzrG4MWnAgT4WCefPTwWYLesKDFcItk76WP67+M6dSlDDKCNZ47Aos9/apTyHEJ
         kP/n2EQXOBr+IAjqrUvouuc67k+DkWrordwW0R34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Matlack <dmatlack@google.com>,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH 6.2 089/663] KVM: RISC-V: Retry fault if vma_lookup() results become invalid
Date:   Mon,  8 May 2023 11:38:35 +0200
Message-Id: <20230508094431.348393115@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: David Matlack <dmatlack@google.com>

commit 2ed90cb0938a45b12eb947af062d12c7af0067b3 upstream.

Read mmu_invalidate_seq before dropping the mmap_lock so that KVM can
detect if the results of vma_lookup() (e.g. vma_shift) become stale
before it acquires kvm->mmu_lock. This fixes a theoretical bug where a
VMA could be changed by userspace after vma_lookup() and before KVM
reads the mmu_invalidate_seq, causing KVM to install page table entries
based on a (possibly) no-longer-valid vma_shift.

Re-order the MMU cache top-up to earlier in user_mem_abort() so that it
is not done after KVM has read mmu_invalidate_seq (i.e. so as to avoid
inducing spurious fault retries).

It's unlikely that any sane userspace currently modifies VMAs in such a
way as to trigger this race. And even with directed testing I was unable
to reproduce it. But a sufficiently motivated host userspace might be
able to exploit this race.

Note KVM/ARM had the same bug and was fixed in a separate, near
identical patch (see Link).

Link: https://lore.kernel.org/kvm/20230313235454.2964067-1-dmatlack@google.com/
Fixes: 9955371cc014 ("RISC-V: KVM: Implement MMU notifiers")
Cc: stable@vger.kernel.org
Signed-off-by: David Matlack <dmatlack@google.com>
Tested-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kvm/mmu.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -628,6 +628,13 @@ int kvm_riscv_gstage_map(struct kvm_vcpu
 			!(memslot->flags & KVM_MEM_READONLY)) ? true : false;
 	unsigned long vma_pagesize, mmu_seq;
 
+	/* We need minimum second+third level pages */
+	ret = kvm_mmu_topup_memory_cache(pcache, gstage_pgd_levels);
+	if (ret) {
+		kvm_err("Failed to topup G-stage cache\n");
+		return ret;
+	}
+
 	mmap_read_lock(current->mm);
 
 	vma = vma_lookup(current->mm, hva);
@@ -648,6 +655,15 @@ int kvm_riscv_gstage_map(struct kvm_vcpu
 	if (vma_pagesize == PMD_SIZE || vma_pagesize == PGDIR_SIZE)
 		gfn = (gpa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
 
+	/*
+	 * Read mmu_invalidate_seq so that KVM can detect if the results of
+	 * vma_lookup() or gfn_to_pfn_prot() become stale priort to acquiring
+	 * kvm->mmu_lock.
+	 *
+	 * Rely on mmap_read_unlock() for an implicit smp_rmb(), which pairs
+	 * with the smp_wmb() in kvm_mmu_invalidate_end().
+	 */
+	mmu_seq = kvm->mmu_invalidate_seq;
 	mmap_read_unlock(current->mm);
 
 	if (vma_pagesize != PGDIR_SIZE &&
@@ -657,15 +673,6 @@ int kvm_riscv_gstage_map(struct kvm_vcpu
 		return -EFAULT;
 	}
 
-	/* We need minimum second+third level pages */
-	ret = kvm_mmu_topup_memory_cache(pcache, gstage_pgd_levels);
-	if (ret) {
-		kvm_err("Failed to topup G-stage cache\n");
-		return ret;
-	}
-
-	mmu_seq = kvm->mmu_invalidate_seq;
-
 	hfn = gfn_to_pfn_prot(kvm, gfn, is_write, &writable);
 	if (hfn == KVM_PFN_ERR_HWPOISON) {
 		send_sig_mceerr(BUS_MCEERR_AR, (void __user *)hva,


