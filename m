Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2F7F174D
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 16:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjKTPaN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 10:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjKTPaM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 10:30:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6EFA7
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 07:30:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DE9C433C8;
        Mon, 20 Nov 2023 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700494207;
        bh=5Q4Kxq0Mc+/PiIfLhpYsYKrycacP6FUiU3xGvC0vhmA=;
        h=Subject:To:Cc:From:Date:From;
        b=xwoZ42V1+Vq66JhNcMC++4vASvfnxgJmZ+MvETNRCFRe0WOpAE1mSOLZqA+SKsx7Z
         Ke0g/3bAceKsXxnCD/VrNS0r4NZcqecDy8lGwuSa/BW2fnS8uHhhOWIkJc+i1eB3ur
         h97iHVyt2HBhUoY0dsUA11rqj6zsAvR4M2zd2e8k=
Subject: FAILED: patch "[PATCH] KVM: x86: Fix lapic timer interrupt lost after loading a" failed to apply to 5.15-stable tree
To:     hshan@google.com, seanjc@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 20 Nov 2023 16:29:56 +0100
Message-ID: <2023112056-opposing-bobbing-e37e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9cfec6d097c607e36199cf0cfbb8cf5acbd8e9b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112056-opposing-bobbing-e37e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

9cfec6d097c6 ("KVM: x86: Fix lapic timer interrupt lost after loading a snapshot.")
b3f257a84696 ("KVM: x86: Track required APICv inhibits with variable, not callback")
9a364857ab4f ("KVM: SVM: Inhibit AVIC if vCPUs are aliased in logical mode")
5063c41bebac ("KVM: x86: Inhibit APICv/AVIC if the optimized physical map is disabled")
2008fab34530 ("KVM: x86: Inhibit APIC memslot if x2APIC and AVIC are enabled")
c482f2cebe2d ("KVM: x86: Move APIC access page helper to common x86 code")
f651a0089548 ("KVM: x86: Don't inhibit APICv/AVIC if xAPIC ID mismatch is due to 32-bit ID")
0e311d33bfbe ("KVM: SVM: Introduce hybrid-AVIC mode")
4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
d2fe6bf5b881 ("KVM: SVM: Update max number of vCPUs supported for x2AVIC mode")
ec1d7e6ab9ff ("KVM: SVM: Drop unused AVIC / kvm_x86_ops declarations")
5bdae49fc2f6 ("KVM: SEV: fix misplaced closing parenthesis")
3743c2f02517 ("KVM: x86: inhibit APICv/AVIC on changes to APIC ID or APIC base")
a9603ae0e4ee ("KVM: x86: document AVIC/APICv inhibit reasons")
a4cfff3f0f8c ("Merge branch 'kvm-older-features' into HEAD")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9cfec6d097c607e36199cf0cfbb8cf5acbd8e9b2 Mon Sep 17 00:00:00 2001
From: Haitao Shan <hshan@google.com>
Date: Tue, 12 Sep 2023 16:55:45 -0700
Subject: [PATCH] KVM: x86: Fix lapic timer interrupt lost after loading a
 snapshot.

When running android emulator (which is based on QEMU 2.12) on
certain Intel hosts with kernel version 6.3-rc1 or above, guest
will freeze after loading a snapshot. This is almost 100%
reproducible. By default, the android emulator will use snapshot
to speed up the next launching of the same android guest. So
this breaks the android emulator badly.

I tested QEMU 8.0.4 from Debian 12 with an Ubuntu 22.04 guest by
running command "loadvm" after "savevm". The same issue is
observed. At the same time, none of our AMD platforms is impacted.
More experiments show that loading the KVM module with
"enable_apicv=false" can workaround it.

The issue started to show up after commit 8e6ed96cdd50 ("KVM: x86:
fire timer when it is migrated and expired, and in oneshot mode").
However, as is pointed out by Sean Christopherson, it is introduced
by commit 967235d32032 ("KVM: vmx: clear pending interrupts on
KVM_SET_LAPIC"). commit 8e6ed96cdd50 ("KVM: x86: fire timer when
it is migrated and expired, and in oneshot mode") just makes it
easier to hit the issue.

Having both commits, the oneshot lapic timer gets fired immediately
inside the KVM_SET_LAPIC call when loading the snapshot. On Intel
platforms with APIC virtualization and posted interrupt processing,
this eventually leads to setting the corresponding PIR bit. However,
the whole PIR bits get cleared later in the same KVM_SET_LAPIC call
by apicv_post_state_restore. This leads to timer interrupt lost.

The fix is to move vmx_apicv_post_state_restore to the beginning of
the KVM_SET_LAPIC call and rename to vmx_apicv_pre_state_restore.
What vmx_apicv_post_state_restore does is actually clearing any
former apicv state and this behavior is more suitable to carry out
in the beginning.

Fixes: 967235d32032 ("KVM: vmx: clear pending interrupts on KVM_SET_LAPIC")
Cc: stable@vger.kernel.org
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Haitao Shan <hshan@google.com>
Link: https://lore.kernel.org/r/20230913000215.478387-1-hshan@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index e3054e3e46d5..9b419f0de713 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -108,6 +108,7 @@ KVM_X86_OP_OPTIONAL(vcpu_blocking)
 KVM_X86_OP_OPTIONAL(vcpu_unblocking)
 KVM_X86_OP_OPTIONAL(pi_update_irte)
 KVM_X86_OP_OPTIONAL(pi_start_assignment)
+KVM_X86_OP_OPTIONAL(apicv_pre_state_restore)
 KVM_X86_OP_OPTIONAL(apicv_post_state_restore)
 KVM_X86_OP_OPTIONAL_RET0(dy_apicv_has_pending_interrupt)
 KVM_X86_OP_OPTIONAL(set_hv_timer)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 17715cb8731d..f77568c6a326 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1709,6 +1709,7 @@ struct kvm_x86_ops {
 	int (*pi_update_irte)(struct kvm *kvm, unsigned int host_irq,
 			      uint32_t guest_irq, bool set);
 	void (*pi_start_assignment)(struct kvm *kvm);
+	void (*apicv_pre_state_restore)(struct kvm_vcpu *vcpu);
 	void (*apicv_post_state_restore)(struct kvm_vcpu *vcpu);
 	bool (*dy_apicv_has_pending_interrupt)(struct kvm_vcpu *vcpu);
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index dcd60b39e794..c6a5a5945021 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2670,6 +2670,8 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 	u64 msr_val;
 	int i;
 
+	static_call_cond(kvm_x86_apicv_pre_state_restore)(vcpu);
+
 	if (!init_event) {
 		msr_val = APIC_DEFAULT_PHYS_BASE | MSR_IA32_APICBASE_ENABLE;
 		if (kvm_vcpu_is_reset_bsp(vcpu))
@@ -2977,6 +2979,8 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	int r;
 
+	static_call_cond(kvm_x86_apicv_pre_state_restore)(vcpu);
+
 	kvm_lapic_set_base(vcpu, vcpu->arch.apic_base);
 	/* set SPIV separately to get count of SW disabled APICs right */
 	apic_set_spiv(apic, *((u32 *)(s->regs + APIC_SPIV)));
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 72e3943f3693..9bba5352582c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6912,7 +6912,7 @@ static void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 	vmcs_write64(EOI_EXIT_BITMAP3, eoi_exit_bitmap[3]);
 }
 
-static void vmx_apicv_post_state_restore(struct kvm_vcpu *vcpu)
+static void vmx_apicv_pre_state_restore(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -8286,7 +8286,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.set_apic_access_page_addr = vmx_set_apic_access_page_addr,
 	.refresh_apicv_exec_ctrl = vmx_refresh_apicv_exec_ctrl,
 	.load_eoi_exitmap = vmx_load_eoi_exitmap,
-	.apicv_post_state_restore = vmx_apicv_post_state_restore,
+	.apicv_pre_state_restore = vmx_apicv_pre_state_restore,
 	.required_apicv_inhibits = VMX_REQUIRED_APICV_INHIBITS,
 	.hwapic_irr_update = vmx_hwapic_irr_update,
 	.hwapic_isr_update = vmx_hwapic_isr_update,

