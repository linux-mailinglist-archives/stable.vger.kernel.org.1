Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A4F703774
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbjEORVW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244044AbjEORVF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:21:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5DF13285
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:18:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 025E762386
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1ECC433EF;
        Mon, 15 May 2023 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171137;
        bh=WWm1e4X6FZkoCIAqPMw3RQVHBSQtlnzoJPRmGDNyKEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghvmeAo0E0EDSsRCvWRETUV/p+s2Va/4q08z1Drye35B5SkLed5OQWToZhW2plxO4
         oQSYO+Vrlre+pCnnkwSVp/ysmePis+mgqLbvaV+Tz9ugpIPlsbQZzLNgC1jz5ViqOk
         mqR3SRDx+/74csZQIzCntrsI9K6XEhbjeMz5fxLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Matlack <dmatlack@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 113/242] KVM: x86/mmu: Move TDP MMU VM init/uninit behind tdp_mmu_enabled
Date:   Mon, 15 May 2023 18:27:19 +0200
Message-Id: <20230515161725.296901564@linuxfoundation.org>
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

[ Upstream commit 991c8047b740f192a057d5f22df2f91f087cdb72 ]

Move kvm_mmu_{init,uninit}_tdp_mmu() behind tdp_mmu_enabled. This makes
these functions consistent with the rest of the calls into the TDP MMU
from mmu.c, and which is now possible since tdp_mmu_enabled is only
modified when the x86 vendor module is loaded. i.e. It will never change
during the lifetime of a VM.

This change also enabled removing the stub definitions for 32-bit KVM,
as the compiler will just optimize the calls out like it does for all
the other TDP MMU functions.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20220921173546.2674386-3-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: edbdb43fc96b ("KVM: x86: Preserve TDP MMU roots until they are explicitly invalidated")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c     | 11 +++++++----
 arch/x86/kvm/mmu/tdp_mmu.c |  6 ------
 arch/x86/kvm/mmu/tdp_mmu.h |  7 +++----
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 583979755bd4f..8666e8ff48a6e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6051,9 +6051,11 @@ int kvm_mmu_init_vm(struct kvm *kvm)
 	INIT_LIST_HEAD(&kvm->arch.possible_nx_huge_pages);
 	spin_lock_init(&kvm->arch.mmu_unsync_pages_lock);
 
-	r = kvm_mmu_init_tdp_mmu(kvm);
-	if (r < 0)
-		return r;
+	if (tdp_mmu_enabled) {
+		r = kvm_mmu_init_tdp_mmu(kvm);
+		if (r < 0)
+			return r;
+	}
 
 	node->track_write = kvm_mmu_pte_write;
 	node->track_flush_slot = kvm_mmu_invalidate_zap_pages_in_memslot;
@@ -6083,7 +6085,8 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
 
 	kvm_page_track_unregister_notifier(kvm, node);
 
-	kvm_mmu_uninit_tdp_mmu(kvm);
+	if (tdp_mmu_enabled)
+		kvm_mmu_uninit_tdp_mmu(kvm);
 
 	mmu_free_vm_memory_caches(kvm);
 }
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 03511e83050fa..7e5952e95d3bf 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -15,9 +15,6 @@ int kvm_mmu_init_tdp_mmu(struct kvm *kvm)
 {
 	struct workqueue_struct *wq;
 
-	if (!tdp_mmu_enabled)
-		return 0;
-
 	wq = alloc_workqueue("kvm", WQ_UNBOUND|WQ_MEM_RECLAIM|WQ_CPU_INTENSIVE, 0);
 	if (!wq)
 		return -ENOMEM;
@@ -42,9 +39,6 @@ static __always_inline bool kvm_lockdep_assert_mmu_lock_held(struct kvm *kvm,
 
 void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
 {
-	if (!tdp_mmu_enabled)
-		return;
-
 	/* Also waits for any queued work items.  */
 	destroy_workqueue(kvm->arch.tdp_mmu_zap_wq);
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index d3714200b932a..e4ab2dac269d6 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -7,6 +7,9 @@
 
 #include "spte.h"
 
+int kvm_mmu_init_tdp_mmu(struct kvm *kvm);
+void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm);
+
 hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu);
 
 __must_check static inline bool kvm_tdp_mmu_get_root(struct kvm_mmu_page *root)
@@ -68,8 +71,6 @@ u64 *kvm_tdp_mmu_fast_pf_get_last_sptep(struct kvm_vcpu *vcpu, u64 addr,
 					u64 *spte);
 
 #ifdef CONFIG_X86_64
-int kvm_mmu_init_tdp_mmu(struct kvm *kvm);
-void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm);
 static inline bool is_tdp_mmu_page(struct kvm_mmu_page *sp) { return sp->tdp_mmu_page; }
 
 static inline bool is_tdp_mmu(struct kvm_mmu *mmu)
@@ -89,8 +90,6 @@ static inline bool is_tdp_mmu(struct kvm_mmu *mmu)
 	return sp && is_tdp_mmu_page(sp) && sp->root_count;
 }
 #else
-static inline int kvm_mmu_init_tdp_mmu(struct kvm *kvm) { return 0; }
-static inline void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm) {}
 static inline bool is_tdp_mmu_page(struct kvm_mmu_page *sp) { return false; }
 static inline bool is_tdp_mmu(struct kvm_mmu *mmu) { return false; }
 #endif
-- 
2.39.2



