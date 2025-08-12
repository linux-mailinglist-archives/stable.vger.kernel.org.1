Return-Path: <stable+bounces-167182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AC0B22CDB
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9804A7A4F0D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB8285C87;
	Tue, 12 Aug 2025 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pMP0XdLf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F21305E08
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015212; cv=none; b=QPpPr/xZC5dSRqribrjwxVLHkmFyR/w/JboYa60LByGsPvmomQ1pHs2ztD9CuIlcyuQUc+ysKfwDrOkCpKx453wSJ8BD1NWf/7+kcm/yEGEmC242G6Q5XYSYPp11djqcTOPGWtu5UmH+cWvB5uv7byGXtPsXgwHwDhxaxLWWzYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015212; c=relaxed/simple;
	bh=NgOfJwjimyolFtPx84V29tZj9PBIxZjAjouq/h3vSdA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jc2Ag8RLyISaQXeRdnC8Sm/kFnIpcOEm9IOCpfAG1+3nocwLJ5P3v4OcOCYxm0/iTTI1E19uOKJLXs1ZguInIr5y6h9nYwa9M0os0ID96ZcUeN70MoQyU3Pb9Up+34qP25NI/eAXkRoQgbxhSu9RUC7PGadVt7w3lH63iqZ22wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pMP0XdLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4352DC4CEF0;
	Tue, 12 Aug 2025 16:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015211;
	bh=NgOfJwjimyolFtPx84V29tZj9PBIxZjAjouq/h3vSdA=;
	h=Subject:To:Cc:From:Date:From;
	b=pMP0XdLfLY/dwLl/Z3bTRGbXWELbFb5yTkOSCHeyzszgkyMwNwDmkylmq3T/KZrwT
	 n/xF5/ALuBMtOSaXAnuVpD9kZlnljofJrZRGpCItmUW2Uajs1yDxgk9VPywbVp0CwS
	 NJ666zVF+RbIE6fbQNgV473RRQcQYJZ99Y58lWyY=
Subject: FAILED: patch "[PATCH] KVM: x86: Convert vcpu_run()'s immediate exit param into a" failed to apply to 6.15-stable tree
To: seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:13:28 +0200
Message-ID: <2025081228-outthink-finisher-2a2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2478b1b220c49d25cb1c3f061ec4f9b351d9a131
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081228-outthink-finisher-2a2a@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2478b1b220c49d25cb1c3f061ec4f9b351d9a131 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Jun 2025 16:20:04 -0700
Subject: [PATCH] KVM: x86: Convert vcpu_run()'s immediate exit param into a
 generic bitmap

Convert kvm_x86_ops.vcpu_run()'s "force_immediate_exit" boolean parameter
into an a generic bitmap so that similar "take action" information can be
passed to vendor code without creating a pile of boolean parameters.

This will allow dropping kvm_x86_ops.set_dr6() in favor of a new flag, and
will also allow for adding similar functionality for re-loading debugctl
in the active VMCS.

Opportunistically massage the TDX WARN and comment to prepare for adding
more run_flags, all of which are expected to be mutually exclusive with
TDX, i.e. should be WARNed on.

No functional change intended.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250610232010.162191-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b4a391929cdb..8d81684fa15d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1674,6 +1674,10 @@ static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
 	return dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
 }
 
+enum kvm_x86_run_flags {
+	KVM_RUN_FORCE_IMMEDIATE_EXIT	= BIT(0),
+};
+
 struct kvm_x86_ops {
 	const char *name;
 
@@ -1755,7 +1759,7 @@ struct kvm_x86_ops {
 
 	int (*vcpu_pre_run)(struct kvm_vcpu *vcpu);
 	enum exit_fastpath_completion (*vcpu_run)(struct kvm_vcpu *vcpu,
-						  bool force_immediate_exit);
+						  u64 run_flags);
 	int (*handle_exit)(struct kvm_vcpu *vcpu,
 		enum exit_fastpath_completion exit_fastpath);
 	int (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ab9b947dbf4f..83d1b62130b1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4389,9 +4389,9 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 	guest_state_exit_irqoff();
 }
 
-static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
-					  bool force_immediate_exit)
+static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 {
+	bool force_immediate_exit = run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	bool spec_ctrl_intercepted = msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL);
 
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index d1e02e567b57..fef3e3803707 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -175,12 +175,12 @@ static int vt_vcpu_pre_run(struct kvm_vcpu *vcpu)
 	return vmx_vcpu_pre_run(vcpu);
 }
 
-static fastpath_t vt_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
+static fastpath_t vt_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 {
 	if (is_td_vcpu(vcpu))
-		return tdx_vcpu_run(vcpu, force_immediate_exit);
+		return tdx_vcpu_run(vcpu, run_flags);
 
-	return vmx_vcpu_run(vcpu, force_immediate_exit);
+	return vmx_vcpu_run(vcpu, run_flags);
 }
 
 static int vt_handle_exit(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 4d2426ab6747..1c4b4d9a1acb 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1025,20 +1025,20 @@ static void tdx_load_host_xsave_state(struct kvm_vcpu *vcpu)
 				DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI | \
 				DEBUGCTLMSR_FREEZE_IN_SMM)
 
-fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
+fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	struct vcpu_vt *vt = to_vt(vcpu);
 
 	/*
-	 * force_immediate_exit requires vCPU entering for events injection with
-	 * an immediately exit followed. But The TDX module doesn't guarantee
-	 * entry, it's already possible for KVM to _think_ it completely entry
-	 * to the guest without actually having done so.
-	 * Since KVM never needs to force an immediate exit for TDX, and can't
-	 * do direct injection, just warn on force_immediate_exit.
+	 * WARN if KVM wants to force an immediate exit, as the TDX module does
+	 * not guarantee entry into the guest, i.e. it's possible for KVM to
+	 * _think_ it completed entry to the guest and forced an immediate exit
+	 * without actually having done so.  Luckily, KVM never needs to force
+	 * an immediate exit for TDX (KVM can't do direct event injection, so
+	 * just WARN and continue on.
 	 */
-	WARN_ON_ONCE(force_immediate_exit);
+	WARN_ON_ONCE(run_flags);
 
 	/*
 	 * Wait until retry of SEPT-zap-related SEAMCALL completes before
@@ -1048,7 +1048,7 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 	if (unlikely(READ_ONCE(to_kvm_tdx(vcpu->kvm)->wait_for_sept_zap)))
 		return EXIT_FASTPATH_EXIT_HANDLED;
 
-	trace_kvm_entry(vcpu, force_immediate_exit);
+	trace_kvm_entry(vcpu, run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT);
 
 	if (pi_test_on(&vt->pi_desc)) {
 		apic->send_IPI_self(POSTED_INTR_VECTOR);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4953846cb30d..a61a28944de6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7323,8 +7323,9 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	guest_state_exit_irqoff();
 }
 
-fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
+fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 {
+	bool force_immediate_exit = run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long cr3, cr4;
 
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index b4596f651232..0b4f5c5558d0 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -21,7 +21,7 @@ void vmx_vm_destroy(struct kvm *kvm);
 int vmx_vcpu_precreate(struct kvm *kvm);
 int vmx_vcpu_create(struct kvm_vcpu *vcpu);
 int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu);
-fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit);
+fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags);
 void vmx_vcpu_free(struct kvm_vcpu *vcpu);
 void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
@@ -133,7 +133,7 @@ void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 void tdx_vcpu_free(struct kvm_vcpu *vcpu);
 void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 int tdx_vcpu_pre_run(struct kvm_vcpu *vcpu);
-fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit);
+fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags);
 void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
 void tdx_vcpu_put(struct kvm_vcpu *vcpu);
 bool tdx_protected_apic_has_interrupt(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b58a74c1722d..07ff02eed399 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10779,6 +10779,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		dm_request_for_irq_injection(vcpu) &&
 		kvm_cpu_accept_dm_intr(vcpu);
 	fastpath_t exit_fastpath;
+	u64 run_flags;
 
 	bool req_immediate_exit = false;
 
@@ -11023,8 +11024,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		goto cancel_injection;
 	}
 
-	if (req_immediate_exit)
+	run_flags = 0;
+	if (req_immediate_exit) {
+		run_flags |= KVM_RUN_FORCE_IMMEDIATE_EXIT;
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
+	}
 
 	fpregs_assert_state_consistent();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
@@ -11061,8 +11065,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		WARN_ON_ONCE((kvm_vcpu_apicv_activated(vcpu) != kvm_vcpu_apicv_active(vcpu)) &&
 			     (kvm_get_apic_mode(vcpu) != LAPIC_MODE_DISABLED));
 
-		exit_fastpath = kvm_x86_call(vcpu_run)(vcpu,
-						       req_immediate_exit);
+		exit_fastpath = kvm_x86_call(vcpu_run)(vcpu, run_flags);
 		if (likely(exit_fastpath != EXIT_FASTPATH_REENTER_GUEST))
 			break;
 
@@ -11074,6 +11077,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			break;
 		}
 
+		run_flags = 0;
+
 		/* Note, VM-Exits that go down the "slow" path are accounted below. */
 		++vcpu->stat.exits;
 	}


