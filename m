Return-Path: <stable+bounces-121689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE85FA59129
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336E73AAF7A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06000226559;
	Mon, 10 Mar 2025 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="duTLA+yz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B717F2248AF
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602525; cv=none; b=Bg7FQREPTg8K5uEKwEvsNqqGLQcyCBFrFHgxCa4lQXgiTOeMtHKe86mMpPk1FjEluLgVKuygydSzgn53n4bjJPaQRZPr9tj37AwKaxdHYudZ7makC9uYAJbN1c7H3BJQvySM6SGAey5vOcywnFbeLzfjBPzJjsDBspz3a9tfm40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602525; c=relaxed/simple;
	bh=5hC+7FaR/c6dr8Vxo7jM+RUG5irEp8AbHOLpRZJK5Xg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D3DXcpBs0lDX78jc7iJDXmHBi2+rt+JcQN7W/BHsT3gTN2px1TxrM2OrUwu9xhXuLNPS2EJZIAgvl03cjlVWz5H0DYGkdGvXtVZK4cuxKVkZB1SQAN6FkW5Qp3IlzT5lzNMGNDme3vlPg5NyaDj5gsrSCjdWXA/ChvrcuXdl3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=duTLA+yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC0BC4CEEC;
	Mon, 10 Mar 2025 10:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741602525;
	bh=5hC+7FaR/c6dr8Vxo7jM+RUG5irEp8AbHOLpRZJK5Xg=;
	h=Subject:To:Cc:From:Date:From;
	b=duTLA+yzvV6mBrDiao9h9zSeFXRK5zAkTm+EHRzde/t7CkYZnQGW40TjAlNZx+VwT
	 MgWE2CkwtYv0KrnvvpmuZdlGEESJ++/5O/iqUp4nE+KYnN+IK9AJXYmvyCATWhM+TN
	 mL3K6c9OHzqr7T6eba3HMhdb5/OVLG1nWGuKriXc=
Subject: FAILED: patch "[PATCH] KVM: x86: Snapshot the host's DEBUGCTL in common x86" failed to apply to 6.1-stable tree
To: seanjc@google.com,ravi.bangoria@amd.com,xiaoyao.li@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Mar 2025 11:28:34 +0100
Message-ID: <2025031034-latitude-stinking-09c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fb71c795935652fa20eaf9517ca9547f5af99a76
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031034-latitude-stinking-09c1@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fb71c795935652fa20eaf9517ca9547f5af99a76 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 27 Feb 2025 14:24:08 -0800
Subject: [PATCH] KVM: x86: Snapshot the host's DEBUGCTL in common x86

Move KVM's snapshot of DEBUGCTL to kvm_vcpu_arch and take the snapshot in
common x86, so that SVM can also use the snapshot.

Opportunistically change the field to a u64.  While bits 63:32 are reserved
on AMD, not mentioned at all in Intel's SDM, and managed as an "unsigned
long" by the kernel, DEBUGCTL is an MSR and therefore a 64-bit value.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: stable@vger.kernel.org
Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20250227222411.3490595-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0b7af5902ff7..32ae3aa50c7e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -780,6 +780,7 @@ struct kvm_vcpu_arch {
 	u32 pkru;
 	u32 hflags;
 	u64 efer;
+	u64 host_debugctl;
 	u64 apic_base;
 	struct kvm_lapic *apic;    /* kernel irqchip context */
 	bool load_eoi_exitmap_pending;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6c56d5235f0f..3b92f893b239 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1514,16 +1514,12 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
  */
 void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-
 	if (vcpu->scheduled_out && !kvm_pause_in_guest(vcpu->kvm))
 		shrink_ple_window(vcpu);
 
 	vmx_vcpu_load_vmcs(vcpu, cpu, NULL);
 
 	vmx_vcpu_pi_load(vcpu, cpu);
-
-	vmx->host_debugctlmsr = get_debugctlmsr();
 }
 
 void vmx_vcpu_put(struct kvm_vcpu *vcpu)
@@ -7458,8 +7454,8 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 	}
 
 	/* MSR_IA32_DEBUGCTLMSR is zeroed on vmexit. Restore it if needed */
-	if (vmx->host_debugctlmsr)
-		update_debugctlmsr(vmx->host_debugctlmsr);
+	if (vcpu->arch.host_debugctl)
+		update_debugctlmsr(vcpu->arch.host_debugctl);
 
 #ifndef CONFIG_X86_64
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 8b111ce1087c..951e44dc9d0e 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -340,8 +340,6 @@ struct vcpu_vmx {
 	/* apic deadline value in host tsc */
 	u64 hv_deadline_tsc;
 
-	unsigned long host_debugctlmsr;
-
 	/*
 	 * Only bits masked by msr_ia32_feature_control_valid_bits can be set in
 	 * msr_ia32_feature_control. FEAT_CTL_LOCKED is always included
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 02159c967d29..5c6fd0edc41f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4968,6 +4968,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	/* Save host pkru register if supported */
 	vcpu->arch.host_pkru = read_pkru();
+	vcpu->arch.host_debugctl = get_debugctlmsr();
 
 	/* Apply any externally detected TSC adjustments (due to suspend) */
 	if (unlikely(vcpu->arch.tsc_offset_adjustment)) {


