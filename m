Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C076775D79
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjHILh5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjHILh5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69024173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3BD663578
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1068BC433C7;
        Wed,  9 Aug 2023 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581075;
        bh=OZXxHmHGhsPZfKhw6WGIknHj8bu56fsZ+gst+f8YR0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKtUz2EBEgSSenVZtsrVfetQyBnDYBDBmL2v9S9VzE3cDhi/Ih81mbypt08Ic30/E
         I5IyDUcA7Vhpnt4e6aKsYOoNT04x+QHfx8MerY3ouRZUPpxRb6dzvD8IqgnlZxqM5V
         CURybA4xG8lhhXHyZlciRqA8jwi4PKF4CTZOWgoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 097/201] KVM: VMX: Dont fudge CR0 and CR4 for restricted L2 guest
Date:   Wed,  9 Aug 2023 12:41:39 +0200
Message-ID: <20230809103647.061493781@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit c4abd7352023aa96114915a0bb2b88016a425cda ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/vmx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ca51df0df3f94..2445c61038954 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1519,6 +1519,11 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
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
@@ -3073,7 +3078,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	u32 tmp;
 
 	hw_cr0 = (cr0 & ~KVM_VM_CR0_ALWAYS_OFF);
-	if (is_unrestricted_guest(vcpu))
+	if (enable_unrestricted_guest)
 		hw_cr0 |= KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST;
 	else {
 		hw_cr0 |= KVM_VM_CR0_ALWAYS_ON;
@@ -3096,7 +3101,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	}
 #endif
 
-	if (enable_ept && !is_unrestricted_guest(vcpu)) {
+	if (enable_ept && !enable_unrestricted_guest) {
 		/*
 		 * Ensure KVM has an up-to-date snapshot of the guest's CR3.  If
 		 * the below code _enables_ CR3 exiting, vmx_cache_reg() will
@@ -3231,7 +3236,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	unsigned long hw_cr4;
 
 	hw_cr4 = (cr4_read_shadow() & X86_CR4_MCE) | (cr4 & ~X86_CR4_MCE);
-	if (is_unrestricted_guest(vcpu))
+	if (enable_unrestricted_guest)
 		hw_cr4 |= KVM_VM_CR4_ALWAYS_ON_UNRESTRICTED_GUEST;
 	else if (vmx->rmode.vm86_active)
 		hw_cr4 |= KVM_RMODE_VM_CR4_ALWAYS_ON;
@@ -3251,7 +3256,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	vcpu->arch.cr4 = cr4;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR4);
 
-	if (!is_unrestricted_guest(vcpu)) {
+	if (!enable_unrestricted_guest) {
 		if (enable_ept) {
 			if (!is_paging(vcpu)) {
 				hw_cr4 &= ~X86_CR4_PAE;
-- 
2.40.1



