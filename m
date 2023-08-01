Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3259C76AD51
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjHAJ2W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjHAJ1r (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:27:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63D526AD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A55A761508
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EECC433C8;
        Tue,  1 Aug 2023 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882001;
        bh=YO5Xr6Xew+pHeFGfcchE1IpaRZJpl4xSWu0oyU8W8nQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clzosYDTofNT0ealy7DA7t/Mlka3HJy8h1mRdOhkE4bgaL3fUCC/RgnqzlJK2piJn
         Zlabbov+VvDeaMiixsMXlVq1kQJoZ8jvmIOYY5cDuGSFyTuTHSjfdcs4WRl6UFkTNm
         0fgLfZhriY4M0z2lkk2ndBBf5wodMIpVO9mNlRwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.15 105/155] KVM: VMX: Dont fudge CR0 and CR4 for restricted L2 guest
Date:   Tue,  1 Aug 2023 11:20:17 +0200
Message-ID: <20230801091913.985109985@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

commit c4abd7352023aa96114915a0bb2b88016a425cda upstream.

Stuff CR0 and/or CR4 to be compliant with a restricted guest if and only
if KVM itself is not configured to utilize unrestricted guests, i.e. don't
stuff CR0/CR4 for a restricted L2 that is running as the guest of an
unrestricted L1.  Any attempt to VM-Enter a restricted guest with invalid
CR0/CR4 values should fail, i.e. in a nested scenario, KVM (as L0) should
never observe a restricted L2 with incompatible CR0/CR4, since nested
VM-Enter from L1 should have failed.

And if KVM does observe an active, restricted L2 with incompatible state,
e.g. due to a KVM bug, fudging CR0/CR4 instead of letting VM-Enter fail
does more harm than good, as KVM will often neglect to undo the side
effects, e.g. won't clear rmode.vm86_active on nested VM-Exit, and thus
the damage can easily spill over to L1.  On the other hand, letting
VM-Enter fail due to bad guest state is more likely to contain the damage
to L2 as KVM relies on hardware to perform most guest state consistency
checks, i.e. KVM needs to be able to reflect a failed nested VM-Enter into
L1 irrespective of (un)restricted guest behavior.

Cc: Jim Mattson <jmattson@google.com>
Cc: stable@vger.kernel.org
Fixes: bddd82d19e2e ("KVM: nVMX: KVM needs to unset "unrestricted guest" VM-execution control in vmcs02 if vmcs12 doesn't set it")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20230613203037.1968489-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx/vmx.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1416,6 +1416,11 @@ void vmx_set_rflags(struct kvm_vcpu *vcp
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long old_rflags;
 
+	/*
+	 * Unlike CR0 and CR4, RFLAGS handling requires checking if the vCPU
+	 * is an unrestricted guest in order to mark L2 as needing emulation
+	 * if L1 runs L2 as a restricted guest.
+	 */
 	if (is_unrestricted_guest(vcpu)) {
 		kvm_register_mark_available(vcpu, VCPU_EXREG_RFLAGS);
 		vmx->rflags = rflags;
@@ -3088,7 +3093,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu,
 	old_cr0_pg = kvm_read_cr0_bits(vcpu, X86_CR0_PG);
 
 	hw_cr0 = (cr0 & ~KVM_VM_CR0_ALWAYS_OFF);
-	if (is_unrestricted_guest(vcpu))
+	if (enable_unrestricted_guest)
 		hw_cr0 |= KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST;
 	else {
 		hw_cr0 |= KVM_VM_CR0_ALWAYS_ON;
@@ -3116,7 +3121,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu,
 	}
 #endif
 
-	if (enable_ept && !is_unrestricted_guest(vcpu)) {
+	if (enable_ept && !enable_unrestricted_guest) {
 		/*
 		 * Ensure KVM has an up-to-date snapshot of the guest's CR3.  If
 		 * the below code _enables_ CR3 exiting, vmx_cache_reg() will
@@ -3239,7 +3244,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu,
 	unsigned long hw_cr4;
 
 	hw_cr4 = (cr4_read_shadow() & X86_CR4_MCE) | (cr4 & ~X86_CR4_MCE);
-	if (is_unrestricted_guest(vcpu))
+	if (enable_unrestricted_guest)
 		hw_cr4 |= KVM_VM_CR4_ALWAYS_ON_UNRESTRICTED_GUEST;
 	else if (vmx->rmode.vm86_active)
 		hw_cr4 |= KVM_RMODE_VM_CR4_ALWAYS_ON;
@@ -3259,7 +3264,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu,
 	vcpu->arch.cr4 = cr4;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR4);
 
-	if (!is_unrestricted_guest(vcpu)) {
+	if (!enable_unrestricted_guest) {
 		if (enable_ept) {
 			if (!is_paging(vcpu)) {
 				hw_cr4 &= ~X86_CR4_PAE;


