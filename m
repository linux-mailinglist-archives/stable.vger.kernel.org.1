Return-Path: <stable+bounces-114531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDA0A2ED2A
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23407A2F01
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1301E22333A;
	Mon, 10 Feb 2025 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ipdZZmZt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9B223327
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739192691; cv=none; b=d9XoA76Z4MJxO2McXhZomE7533vtZlMEAHkdI4Iczb5rx7ue4Bv/MiNCdNO4CUs4V7ti8KvWBuL4jhCWWwR+7fMO4+oB7OSCKHSL6Z+YAlzsxQHOliTyZmcNduGK3mybf2I9lfkwu/w6heCLLplNI8zjfeqhkeou5vNPC56XtdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739192691; c=relaxed/simple;
	bh=fthDXNR9rnn9rZYPm6QlVLPaZtC0uG5MEAXN1HQTvxA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qhHGq5BG2umRpjzRiBd0Y38dM7V8k4wLAfbaHhC1xK5xumcd6GF2ywBZ3hkQNfOSyf0gKqnIXqdej/CVH7vmBodxMHXgCc7J4LaQ3cd1c+o/ia7WZnXl326aOzLifyM+JHXxBbfSwVbNf8RJVC64swG0DLmHc0+MxVJxo5WFLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ipdZZmZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF339C4CEDF;
	Mon, 10 Feb 2025 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739192691;
	bh=fthDXNR9rnn9rZYPm6QlVLPaZtC0uG5MEAXN1HQTvxA=;
	h=Subject:To:Cc:From:Date:From;
	b=ipdZZmZtsZaPR+xIGGw1gQFXdVR4+2oHadMCpn75quAqpRSWCYBxR5MtNQ028Fn59
	 dWPGtUSMxDogQyX29VHnhDn0qQOCCJWn9X85255pFh90g0+HtkIjp51vzrd3k149bV
	 Mw6nI6oUla45N0+cJKGy2qhwFlH1iJIm1VqrxYA4=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Defer SVI update to vmcs01 on EOI when L2 is" failed to apply to 6.12-stable tree
To: chao.gao@intel.com,janne.karhunen@gmail.com,mankku@gmail.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:04:48 +0100
Message-ID: <2025021048-giggly-device-2286@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 04bc93cf49d16d01753b95ddb5d4f230b809a991
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021048-giggly-device-2286@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 04bc93cf49d16d01753b95ddb5d4f230b809a991 Mon Sep 17 00:00:00 2001
From: Chao Gao <chao.gao@intel.com>
Date: Wed, 27 Nov 2024 16:00:10 -0800
Subject: [PATCH] KVM: nVMX: Defer SVI update to vmcs01 on EOI when L2 is
 active w/o VID
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If KVM emulates an EOI for L1's virtual APIC while L2 is active, defer
updating GUEST_INTERUPT_STATUS.SVI, i.e. the VMCS's cache of the highest
in-service IRQ, until L1 is active, as vmcs01, not vmcs02, needs to track
vISR.  The missed SVI update for vmcs01 can result in L1 interrupts being
incorrectly blocked, e.g. if there is a pending interrupt with lower
priority than the interrupt that was EOI'd.

This bug only affects use cases where L1's vAPIC is effectively passed
through to L2, e.g. in a pKVM scenario where L2 is L1's depriveleged host,
as KVM will only emulate an EOI for L1's vAPIC if Virtual Interrupt
Delivery (VID) is disabled in vmc12, and L1 isn't intercepting L2 accesses
to its (virtual) APIC page (or if x2APIC is enabled, the EOI MSR).

WARN() if KVM updates L1's ISR while L2 is active with VID enabled, as an
EOI from L2 is supposed to affect L2's vAPIC, but still defer the update,
to try to keep L1 alive.  Specifically, KVM forwards all APICv-related
VM-Exits to L1 via nested_vmx_l1_wants_exit():

	case EXIT_REASON_APIC_ACCESS:
	case EXIT_REASON_APIC_WRITE:
	case EXIT_REASON_EOI_INDUCED:
		/*
		 * The controls for "virtualize APIC accesses," "APIC-
		 * register virtualization," and "virtual-interrupt
		 * delivery" only come from vmcs12.
		 */
		return true;

Fixes: c7c9c56ca26f ("x86, apicv: add virtual interrupt delivery support")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/kvm/20230312180048.1778187-1-jason.cj.chen@intel.com
Reported-by: Markku Ahvenjärvi <mankku@gmail.com>
Closes: https://lore.kernel.org/all/20240920080012.74405-1-mankku@gmail.com
Cc: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
[sean: drop request, handle in VMX, write changelog]
Tested-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/r/20241128000010.4051275-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 39ae2f5f9866..d0913aceeae4 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -816,6 +816,17 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 	}
 }
 
+void kvm_apic_update_hwapic_isr(struct kvm_vcpu *vcpu)
+{
+	struct kvm_lapic *apic = vcpu->arch.apic;
+
+	if (WARN_ON_ONCE(!lapic_in_kernel(vcpu)) || !apic->apicv_active)
+		return;
+
+	kvm_x86_call(hwapic_isr_update)(vcpu, apic_find_highest_isr(apic));
+}
+EXPORT_SYMBOL_GPL(kvm_apic_update_hwapic_isr);
+
 int kvm_lapic_find_highest_irr(struct kvm_vcpu *vcpu)
 {
 	/* This may race with setting of irr in __apic_accept_irq() and
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 24add38beaf0..1a8553ebdb42 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -118,6 +118,7 @@ void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high);
 int kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value, bool host_initiated);
 int kvm_apic_get_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
 int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
+void kvm_apic_update_hwapic_isr(struct kvm_vcpu *vcpu);
 int kvm_lapic_find_highest_irr(struct kvm_vcpu *vcpu);
 
 u64 kvm_get_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index aa78b6f38dfe..103baa8e4cf8 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5050,6 +5050,11 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
 	}
 
+	if (vmx->nested.update_vmcs01_hwapic_isr) {
+		vmx->nested.update_vmcs01_hwapic_isr = false;
+		kvm_apic_update_hwapic_isr(vcpu);
+	}
+
 	if ((vm_exit_reason != -1) &&
 	    (enable_shadow_vmcs || nested_vmx_is_evmptr12_valid(vmx)))
 		vmx->nested.need_vmcs12_to_shadow_sync = true;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 22cb11ab8709..01abcdcbbf70 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6867,6 +6867,27 @@ void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
 	u16 status;
 	u8 old;
 
+	/*
+	 * If L2 is active, defer the SVI update until vmcs01 is loaded, as SVI
+	 * is only relevant for if and only if Virtual Interrupt Delivery is
+	 * enabled in vmcs12, and if VID is enabled then L2 EOIs affect L2's
+	 * vAPIC, not L1's vAPIC.  KVM must update vmcs01 on the next nested
+	 * VM-Exit, otherwise L1 with run with a stale SVI.
+	 */
+	if (is_guest_mode(vcpu)) {
+		/*
+		 * KVM is supposed to forward intercepted L2 EOIs to L1 if VID
+		 * is enabled in vmcs12; as above, the EOIs affect L2's vAPIC.
+		 * Note, userspace can stuff state while L2 is active; assert
+		 * that VID is disabled if and only if the vCPU is in KVM_RUN
+		 * to avoid false positives if userspace is setting APIC state.
+		 */
+		WARN_ON_ONCE(vcpu->wants_to_run &&
+			     nested_cpu_has_vid(get_vmcs12(vcpu)));
+		to_vmx(vcpu)->nested.update_vmcs01_hwapic_isr = true;
+		return;
+	}
+
 	if (max_isr == -1)
 		max_isr = 0;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 43f573f6ca46..892302022094 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -176,6 +176,7 @@ struct nested_vmx {
 	bool reload_vmcs01_apic_access_page;
 	bool update_vmcs01_cpu_dirty_logging;
 	bool update_vmcs01_apicv_status;
+	bool update_vmcs01_hwapic_isr;
 
 	/*
 	 * Enlightened VMCS has been enabled. It does not mean that L1 has to


