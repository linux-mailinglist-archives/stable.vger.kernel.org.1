Return-Path: <stable+bounces-62486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C258293F36B
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E921C21F4D
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A5E1459FE;
	Mon, 29 Jul 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l03ARkFE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C971459F1
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250707; cv=none; b=mFqu5jRBz+osHKShQLnPlThVsQQY66oikJTJJAMFwOr7NGaB6m29nvxdgi8hpepjWH61gY+vkw3jmcvDvife4FOEiT++odcT9PoDB19B97Tx901BAipY2FhQxx2xFqX/ojBxramNwh4MHvdgdh2vEtl8G0+/zvGs+DZKaggNVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250707; c=relaxed/simple;
	bh=c2fvjHMXQpmyzIb4xUlLQ40zDlRerGa5ut+67zVmlnU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FMRfJZ2BqieFZo6BrUhhuq7SrZW/Rg813HWiDdO5/L2xS8sleDKLITPav+lQ7hs5uKe7COhrqn06ZFGsoGJQfokbJTVNezOIdzxbcqh0Y2A87B2bLiR/wYrX5qvha2j8SwR0L4/5EPy+1l3udWNHGLoxQ3kzw0CTW4PFxpvtE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l03ARkFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E055AC4AF0B;
	Mon, 29 Jul 2024 10:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722250707;
	bh=c2fvjHMXQpmyzIb4xUlLQ40zDlRerGa5ut+67zVmlnU=;
	h=Subject:To:Cc:From:Date:From;
	b=l03ARkFEDddEvpJohnQ+1+hlL1h08J6bvLOUjZPqT7i8r52C4Ut0FmttoWFv9ntX/
	 5X1ZUw3tv9rQrT1k6h/F5iSLtfPc77mY2K320hsoVDEfcHSbcZ/yOzK8SM51w4Zf2h
	 /BPhVdiT15DkKSYurI2RxoHVRpuaA/N3DI0i2BxQ=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Fold requested virtual interrupt check into" failed to apply to 6.6-stable tree
To: seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:58:24 +0200
Message-ID: <2024072924-negate-external-8f62@gregkh>
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
git cherry-pick -x 321ef62b0c5f6f57bb8500a2ca5986052675abbf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072924-negate-external-8f62@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

321ef62b0c5f ("KVM: nVMX: Fold requested virtual interrupt check into has_nested_events()")
27c4fa42b11a ("KVM: nVMX: Check for pending posted interrupts when looking for nested events")
e366f92ea99e ("KVM: SEV: Support SEV-SNP AP Creation NAE event")
c63cf135cc99 ("KVM: SEV: Add support to handle RMP nested page faults")
9b54e248d264 ("KVM: SEV: Add support to handle Page State Change VMGEXIT")
d46b7b6a5f9e ("KVM: SEV: Add support to handle MSR based Page State Change VMGEXIT")
0c76b1d08280 ("KVM: SEV: Add support to handle GHCB GPA register VMGEXIT")
1dfe571c12cf ("KVM: SEV: Add initial SEV-SNP support")
bbe10a5cc0c7 ("Merge branch 'kvm-sev-es-ghcbv2' into HEAD")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 321ef62b0c5f6f57bb8500a2ca5986052675abbf Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 7 Jun 2024 10:26:08 -0700
Subject: [PATCH] KVM: nVMX: Fold requested virtual interrupt check into
 has_nested_events()

Check for a Requested Virtual Interrupt, i.e. a virtual interrupt that is
pending delivery, in vmx_has_nested_events() and drop the one-off
kvm_x86_ops.guest_apic_has_interrupt() hook.

In addition to dropping a superfluous hook, this fixes a bug where KVM
would incorrectly treat virtual interrupts _for L2_ as always enabled due
to kvm_arch_interrupt_allowed(), by way of vmx_interrupt_blocked(),
treating IRQs as enabled if L2 is active and vmcs12 is configured to exit
on IRQs, i.e. KVM would treat a virtual interrupt for L2 as a valid wake
event based on L1's IRQ blocking status.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240607172609.3205077-6-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 566d19b02483..f91d413d7de1 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -85,7 +85,6 @@ KVM_X86_OP_OPTIONAL(update_cr8_intercept)
 KVM_X86_OP(refresh_apicv_exec_ctrl)
 KVM_X86_OP_OPTIONAL(hwapic_irr_update)
 KVM_X86_OP_OPTIONAL(hwapic_isr_update)
-KVM_X86_OP_OPTIONAL_RET0(guest_apic_has_interrupt)
 KVM_X86_OP_OPTIONAL(load_eoi_exitmap)
 KVM_X86_OP_OPTIONAL(set_virtual_apic_mode)
 KVM_X86_OP_OPTIONAL(set_apic_access_page_addr)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b3b796f06801..2715c1d6a4db 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1715,7 +1715,6 @@ struct kvm_x86_ops {
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
 	void (*hwapic_isr_update)(int isr);
-	bool (*guest_apic_has_interrupt)(struct kvm_vcpu *vcpu);
 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
 	void (*set_apic_access_page_addr)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index d4ed681785fd..547fca3709fe 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -97,7 +97,6 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.required_apicv_inhibits = VMX_REQUIRED_APICV_INHIBITS,
 	.hwapic_irr_update = vmx_hwapic_irr_update,
 	.hwapic_isr_update = vmx_hwapic_isr_update,
-	.guest_apic_has_interrupt = vmx_guest_apic_has_interrupt,
 	.sync_pir_to_irr = vmx_sync_pir_to_irr,
 	.deliver_interrupt = vmx_deliver_interrupt,
 	.dy_apicv_has_pending_interrupt = pi_has_pending_interrupt,
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 732340ff3300..7c57d6524f75 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4060,6 +4060,10 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 
 	vppr = *((u32 *)(vapic + APIC_PROCPRI));
 
+	max_irr = vmx_get_rvi();
+	if ((max_irr & 0xf0) > (vppr & 0xf0))
+		return true;
+
 	if (vmx->nested.pi_pending && vmx->nested.pi_desc &&
 	    pi_test_on(vmx->nested.pi_desc)) {
 		max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7efb52328e5d..8ccdba6360aa 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4105,26 +4105,6 @@ void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
 	}
 }
 
-bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	void *vapic_page;
-	u32 vppr;
-	int rvi;
-
-	if (WARN_ON_ONCE(!is_guest_mode(vcpu)) ||
-		!nested_cpu_has_vid(get_vmcs12(vcpu)) ||
-		WARN_ON_ONCE(!vmx->nested.virtual_apic_map.gfn))
-		return false;
-
-	rvi = vmx_get_rvi();
-
-	vapic_page = vmx->nested.virtual_apic_map.hva;
-	vppr = *((u32 *)(vapic_page + APIC_PROCPRI));
-
-	return ((rvi & 0xf0) > (vppr & 0xf0));
-}
-
 void vmx_msr_filter_changed(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 502704596c83..d404227c164d 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -49,7 +49,6 @@ void vmx_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
 bool vmx_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason);
 void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr);
 void vmx_hwapic_isr_update(int max_isr);
-bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu);
 int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu);
 void vmx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 			   int trig_mode, int vector);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8cce76b93d83..cacca83b06aa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13108,12 +13108,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		kvm_arch_free_memslot(kvm, old);
 }
 
-static inline bool kvm_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
-{
-	return (is_guest_mode(vcpu) &&
-		static_call(kvm_x86_guest_apic_has_interrupt)(vcpu));
-}
-
 static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 {
 	if (!list_empty_careful(&vcpu->async_pf.done))
@@ -13147,9 +13141,7 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (kvm_test_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, vcpu))
 		return true;
 
-	if (kvm_arch_interrupt_allowed(vcpu) &&
-	    (kvm_cpu_has_interrupt(vcpu) ||
-	    kvm_guest_apic_has_interrupt(vcpu)))
+	if (kvm_arch_interrupt_allowed(vcpu) && kvm_cpu_has_interrupt(vcpu))
 		return true;
 
 	if (kvm_hv_has_stimer_pending(vcpu))


