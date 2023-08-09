Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E980775D77
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjHILhv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjHILhv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:37:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA856E3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:37:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67E7463583
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A10FC433C8;
        Wed,  9 Aug 2023 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581069;
        bh=yEvXydHl2jTUvjIB/gRwlyi4tzjAXV64TMTvqRAUTe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OD7bj24+h9dJw2Jafk3euZV5sWkB8noxlqySRTMLjBBEE2XKcZLt5shTTOnLoU9y7
         14/PowdcarJ8xF3tUPnDC4Umg7N+wnag/o9HQtd/oJpeYV1LrCTfXwItqkydDpMvBQ
         Hq3y5Co4pa7VfR7F3wW//Jq53m9yG+jbjcd8oALM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 095/201] KVM: VMX: Fold ept_update_paging_mode_cr0() back into vmx_set_cr0()
Date:   Wed,  9 Aug 2023 12:41:37 +0200
Message-ID: <20230809103647.001726655@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit c834fd7fc1308a0e0429d203a6c3af528cd902fa ]

Move the CR0/CR3/CR4 shenanigans for EPT without unrestricted guest back
into vmx_set_cr0().  This will allow a future patch to eliminate the
rather gross stuffing of vcpu->arch.cr0 in the paging transition cases
by snapshotting the old CR0.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210713163324.627647-24-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: c4abd7352023 ("KVM: VMX: Don't fudge CR0 and CR4 for restricted L2 guest")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/vmx.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 574acfa98fa9b..b9abe08c9d590 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3063,27 +3063,6 @@ void ept_save_pdptrs(struct kvm_vcpu *vcpu)
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
 }
 
-static void ept_update_paging_mode_cr0(unsigned long cr0, struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-
-	if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
-		vmx_cache_reg(vcpu, VCPU_EXREG_CR3);
-	if (!(cr0 & X86_CR0_PG)) {
-		/* From paging/starting to nonpaging */
-		exec_controls_setbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
-					  CPU_BASED_CR3_STORE_EXITING);
-		vcpu->arch.cr0 = cr0;
-		vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
-	} else if (!is_paging(vcpu)) {
-		/* From nonpaging to paging */
-		exec_controls_clearbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
-					    CPU_BASED_CR3_STORE_EXITING);
-		vcpu->arch.cr0 = cr0;
-		vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
-	}
-}
-
 void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -3113,8 +3092,23 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	}
 #endif
 
-	if (enable_ept && !is_unrestricted_guest(vcpu))
-		ept_update_paging_mode_cr0(cr0, vcpu);
+	if (enable_ept && !is_unrestricted_guest(vcpu)) {
+		if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
+			vmx_cache_reg(vcpu, VCPU_EXREG_CR3);
+		if (!(cr0 & X86_CR0_PG)) {
+			/* From paging/starting to nonpaging */
+			exec_controls_setbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
+						  CPU_BASED_CR3_STORE_EXITING);
+			vcpu->arch.cr0 = cr0;
+			vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
+		} else if (!is_paging(vcpu)) {
+			/* From nonpaging to paging */
+			exec_controls_clearbit(vmx, CPU_BASED_CR3_LOAD_EXITING |
+						    CPU_BASED_CR3_STORE_EXITING);
+			vcpu->arch.cr0 = cr0;
+			vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
+		}
+	}
 
 	vmcs_writel(CR0_READ_SHADOW, cr0);
 	vmcs_writel(GUEST_CR0, hw_cr0);
-- 
2.40.1



