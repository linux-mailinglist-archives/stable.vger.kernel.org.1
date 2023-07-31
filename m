Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507CD769584
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 14:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjGaMEy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 08:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjGaMEw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 08:04:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B999210F5
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 05:04:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ECC861089
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47758C433C7;
        Mon, 31 Jul 2023 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690805084;
        bh=2KIDjcD8+595f7rrbIUlEdXaDd+O0LHr3sNx5jUsslo=;
        h=Subject:To:Cc:From:Date:From;
        b=Ty591Z8S1zcDwndyq9zA0JDI3H1APY1tuTyhLY11xpjz6UVvqvxgXEfs7p66wKfkI
         qLt0tAfQ29Oe/sMrF9VnUGq50kOklUaCuYbRO2nhhiToRbmVhpvENbtWdljeWY51dU
         ptCPD9eVFN4t3F37tVV7i3YdiUYKFBb6sJtaoW44=
Subject: FAILED: patch "[PATCH] KVM: VMX: Don't fudge CR0 and CR4 for restricted L2 guest" failed to apply to 5.10-stable tree
To:     seanjc@google.com, jmattson@google.com, pbonzini@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 31 Jul 2023 14:03:38 +0200
Message-ID: <2023073138-mortify-prozac-63fc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c4abd7352023aa96114915a0bb2b88016a425cda
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023073138-mortify-prozac-63fc@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

c4abd7352023 ("KVM: VMX: Don't fudge CR0 and CR4 for restricted L2 guest")
470750b34255 ("KVM: nVMX: Do not clear CR3 load/store exiting bits if L1 wants 'em")
c834fd7fc130 ("KVM: VMX: Fold ept_update_paging_mode_cr0() back into vmx_set_cr0()")
ee5a5584cba3 ("KVM: VMX: Invert handling of CR0.WP for EPT without unrestricted guest")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c4abd7352023aa96114915a0bb2b88016a425cda Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 13 Jun 2023 13:30:36 -0700
Subject: [PATCH] KVM: VMX: Don't fudge CR0 and CR4 for restricted L2 guest

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

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3d011d62d969..df461f387e20 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1513,6 +1513,11 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
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
@@ -3265,7 +3270,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	old_cr0_pg = kvm_read_cr0_bits(vcpu, X86_CR0_PG);
 
 	hw_cr0 = (cr0 & ~KVM_VM_CR0_ALWAYS_OFF);
-	if (is_unrestricted_guest(vcpu))
+	if (enable_unrestricted_guest)
 		hw_cr0 |= KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST;
 	else {
 		hw_cr0 |= KVM_VM_CR0_ALWAYS_ON;
@@ -3293,7 +3298,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	}
 #endif
 
-	if (enable_ept && !is_unrestricted_guest(vcpu)) {
+	if (enable_ept && !enable_unrestricted_guest) {
 		/*
 		 * Ensure KVM has an up-to-date snapshot of the guest's CR3.  If
 		 * the below code _enables_ CR3 exiting, vmx_cache_reg() will
@@ -3424,7 +3429,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	 * this bit, even if host CR4.MCE == 0.
 	 */
 	hw_cr4 = (cr4_read_shadow() & X86_CR4_MCE) | (cr4 & ~X86_CR4_MCE);
-	if (is_unrestricted_guest(vcpu))
+	if (enable_unrestricted_guest)
 		hw_cr4 |= KVM_VM_CR4_ALWAYS_ON_UNRESTRICTED_GUEST;
 	else if (vmx->rmode.vm86_active)
 		hw_cr4 |= KVM_RMODE_VM_CR4_ALWAYS_ON;
@@ -3444,7 +3449,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	vcpu->arch.cr4 = cr4;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR4);
 
-	if (!is_unrestricted_guest(vcpu)) {
+	if (!enable_unrestricted_guest) {
 		if (enable_ept) {
 			if (!is_paging(vcpu)) {
 				hw_cr4 &= ~X86_CR4_PAE;

