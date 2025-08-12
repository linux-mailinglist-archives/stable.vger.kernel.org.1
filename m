Return-Path: <stable+bounces-167210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E76DB22D54
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15674622ECD
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8692F83B6;
	Tue, 12 Aug 2025 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IINZmn+D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6E8285C87
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015381; cv=none; b=oMo1jX+ncJDFrUwDJ6qpy9QCZyXZbFz/hvbeOj3eMuNrdLdPDHYhXFgVrgxN4cRv/pqo3DiuCTM9Ek7agn06ZAJrgtkhZPIRqN2aMhBX6FxLfL+2txLcyKStfmI3q1g8GBkzQpOXarjP6LfsjuAon8R4YMl8VaCfCAIvlwjbcEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015381; c=relaxed/simple;
	bh=qh2WICEhL1gVeatWw7es5to4RiTLUWguRO0QzvHEqYw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AImu5+k1LVJXif03M9FAYsU0griRBJ78ycTyBT3MGuZUWgnskBM0+R4ZwB1o8EYl1NEOVEO/CvlHsHQNDJ9/hRsKBNSKo8VH+R+g5jQjzdQqlXOtz4eOutNB8HAYtxIwE+31VUaTJboFdjpgBj/zgmbOLYEuq1qxxKxH+f2inGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IINZmn+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58100C4CEF1;
	Tue, 12 Aug 2025 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015381;
	bh=qh2WICEhL1gVeatWw7es5to4RiTLUWguRO0QzvHEqYw=;
	h=Subject:To:Cc:From:Date:From;
	b=IINZmn+DUIe9SopBcyJGCMQpMGoQSOpCJTM7uYGClwV61wxDvQ16PGQH0+ho2/4He
	 xQlQOgJCXVDxNThpgNU9fCD0dTDm5O2eRjM0dWI8IQYUFbnShhn1tBLPKorQnBj5yN
	 pkMvmLtSUHWuTXVd3KjksXJgu4jZSuSXgdI/dN9E=
Subject: FAILED: patch "[PATCH] KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while" failed to apply to 6.6-stable tree
To: mlevitsk@redhat.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:15:34 +0200
Message-ID: <2025081234-labrador-unturned-2c21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6b1dd26544d045f6a79e8c73572c0c0db3ef3c1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081234-labrador-unturned-2c21@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b1dd26544d045f6a79e8c73572c0c0db3ef3c1a Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <mlevitsk@redhat.com>
Date: Tue, 10 Jun 2025 16:20:10 -0700
Subject: [PATCH] KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while
 running the guest

Set/clear DEBUGCTLMSR_FREEZE_IN_SMM in GUEST_IA32_DEBUGCTL based on the
host's pre-VM-Enter value, i.e. preserve the host's FREEZE_IN_SMM setting
while running the guest.  When running with the "default treatment of SMIs"
in effect (the only mode KVM supports), SMIs do not generate a VM-Exit that
is visible to host (non-SMM) software, and instead transitions directly
from VMX non-root to SMM.  And critically, DEBUGCTL isn't context switched
by hardware on SMI or RSM, i.e. SMM will run with whatever value was
resident in hardware at the time of the SMI.

Failure to preserve FREEZE_IN_SMM results in the PMU unexpectedly counting
events while the CPU is executing in SMM, which can pollute profiling and
potentially leak information into the guest.

Check for changes in FREEZE_IN_SMM prior to every entry into KVM's inner
run loop, as the bit can be toggled in IRQ context via IPI callback (SMP
function call), by way of /sys/devices/cpu/freeze_on_smi.

Add a field in kvm_x86_ops to communicate which DEBUGCTL bits need to be
preserved, as FREEZE_IN_SMM is only supported and defined for Intel CPUs,
i.e. explicitly checking FREEZE_IN_SMM in common x86 is at best weird, and
at worst could lead to undesirable behavior in the future if AMD CPUs ever
happened to pick up a collision with the bit.

Exempt TDX vCPUs, i.e. protected guests, from the check, as the TDX Module
owns and controls GUEST_IA32_DEBUGCTL.

WARN in SVM if KVM_RUN_LOAD_DEBUGCTL is set, mostly to document that the
lack of handling isn't a KVM bug (TDX already WARNs on any run_flag).

Lastly, explicitly reload GUEST_IA32_DEBUGCTL on a VM-Fail that is missed
by KVM but detected by hardware, i.e. in nested_vmx_restore_host_state().
Doing so avoids the need to track host_debugctl on a per-VMCS basis, as
GUEST_IA32_DEBUGCTL is unconditionally written by prepare_vmcs02() and
load_vmcs12_host_state().  For the VM-Fail case, even though KVM won't
have actually entered the guest, vcpu_enter_guest() will have run with
vmcs02 active and thus could result in vmcs01 being run with a stale value.

Cc: stable@vger.kernel.org
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20250610232010.162191-9-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4f7ee2dbf10e..5e0415a8ee3f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1677,6 +1677,7 @@ static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
 enum kvm_x86_run_flags {
 	KVM_RUN_FORCE_IMMEDIATE_EXIT	= BIT(0),
 	KVM_RUN_LOAD_GUEST_DR6		= BIT(1),
+	KVM_RUN_LOAD_DEBUGCTL		= BIT(2),
 };
 
 struct kvm_x86_ops {
@@ -1707,6 +1708,12 @@ struct kvm_x86_ops {
 	void (*vcpu_load)(struct kvm_vcpu *vcpu, int cpu);
 	void (*vcpu_put)(struct kvm_vcpu *vcpu);
 
+	/*
+	 * Mask of DEBUGCTL bits that are owned by the host, i.e. that need to
+	 * match the host's value even while the guest is active.
+	 */
+	const u64 HOST_OWNED_DEBUGCTL;
+
 	void (*update_exception_bitmap)(struct kvm_vcpu *vcpu);
 	int (*get_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr);
 	int (*set_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index c85cbce6d2f6..4a6d4460f947 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -915,6 +915,8 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.vcpu_load = vt_op(vcpu_load),
 	.vcpu_put = vt_op(vcpu_put),
 
+	.HOST_OWNED_DEBUGCTL = DEBUGCTLMSR_FREEZE_IN_SMM,
+
 	.update_exception_bitmap = vt_op(update_exception_bitmap),
 	.get_feature_msr = vmx_get_feature_msr,
 	.get_msr = vt_op(get_msr),
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ef20184b8b11..c69df3aba8d1 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4861,6 +4861,9 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 			WARN_ON(kvm_set_dr(vcpu, 7, vmcs_readl(GUEST_DR7)));
 	}
 
+	/* Reload DEBUGCTL to ensure vmcs01 has a fresh FREEZE_IN_SMM value. */
+	vmx_reload_guest_debugctl(vcpu);
+
 	/*
 	 * Note that calling vmx_set_{efer,cr0,cr4} is important as they
 	 * handle a variety of side effects to KVM's software model.
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a77d325fe78b..0db1bd383302 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7377,6 +7377,9 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	if (run_flags & KVM_RUN_LOAD_GUEST_DR6)
 		set_debugreg(vcpu->arch.dr6, 6);
 
+	if (run_flags & KVM_RUN_LOAD_DEBUGCTL)
+		vmx_reload_guest_debugctl(vcpu);
+
 	/*
 	 * Refresh vmcs.HOST_CR3 if necessary.  This must be done immediately
 	 * prior to VM-Enter, as the kernel may load a new ASID (PCID) any time
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index c20a4185d10a..076af78af151 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -419,12 +419,25 @@ bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data, bool host_initiated)
 
 static inline void vmx_guest_debugctl_write(struct kvm_vcpu *vcpu, u64 val)
 {
+	WARN_ON_ONCE(val & DEBUGCTLMSR_FREEZE_IN_SMM);
+
+	val |= vcpu->arch.host_debugctl & DEBUGCTLMSR_FREEZE_IN_SMM;
 	vmcs_write64(GUEST_IA32_DEBUGCTL, val);
 }
 
 static inline u64 vmx_guest_debugctl_read(void)
 {
-	return vmcs_read64(GUEST_IA32_DEBUGCTL);
+	return vmcs_read64(GUEST_IA32_DEBUGCTL) & ~DEBUGCTLMSR_FREEZE_IN_SMM;
+}
+
+static inline void vmx_reload_guest_debugctl(struct kvm_vcpu *vcpu)
+{
+	u64 val = vmcs_read64(GUEST_IA32_DEBUGCTL);
+
+	if (!((val ^ vcpu->arch.host_debugctl) & DEBUGCTLMSR_FREEZE_IN_SMM))
+		return;
+
+	vmx_guest_debugctl_write(vcpu, val & ~DEBUGCTLMSR_FREEZE_IN_SMM);
 }
 
 /*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7fe3549bbd93..179c2c550c8d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10779,7 +10779,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		dm_request_for_irq_injection(vcpu) &&
 		kvm_cpu_accept_dm_intr(vcpu);
 	fastpath_t exit_fastpath;
-	u64 run_flags;
+	u64 run_flags, debug_ctl;
 
 	bool req_immediate_exit = false;
 
@@ -11051,7 +11051,17 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(0, 7);
 	}
 
-	vcpu->arch.host_debugctl = get_debugctlmsr();
+	/*
+	 * Refresh the host DEBUGCTL snapshot after disabling IRQs, as DEBUGCTL
+	 * can be modified in IRQ context, e.g. via SMP function calls.  Inform
+	 * vendor code if any host-owned bits were changed, e.g. so that the
+	 * value loaded into hardware while running the guest can be updated.
+	 */
+	debug_ctl = get_debugctlmsr();
+	if ((debug_ctl ^ vcpu->arch.host_debugctl) & kvm_x86_ops.HOST_OWNED_DEBUGCTL &&
+	    !vcpu->arch.guest_state_protected)
+		run_flags |= KVM_RUN_LOAD_DEBUGCTL;
+	vcpu->arch.host_debugctl = debug_ctl;
 
 	guest_timing_enter_irqoff();
 


