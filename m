Return-Path: <stable+bounces-169591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ED7B26C3B
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2174A188987A
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC38B1ADFFB;
	Thu, 14 Aug 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8SI7xB5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D0C32144D
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187935; cv=none; b=nZZHqVdzD0qfReqPW8/7JGdAX0VrZZDb97zmP/IGf+P5xtYB976EpUEuJCb9qqWN6EkS35nGAZsA4xm77QevDA/cQoLWLNJfQodl5nmkb3YdmtOs/it8j8rMscD+9kXTf3RHk2WcGAViWrzj4easiwz5wt5jQAWgqR298Z7UQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187935; c=relaxed/simple;
	bh=OTb/evqKJ6AB/2g3EfNJNM1rRM0V1acmfrv9iZc89uA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZXrmXg8+9QAkEnhsbIlETIYFbw4MDkwWz6rbO2oCpq4DBiGwuM3g9cEVu5okj9nRygHvzt1LLJQ2B5bBwKs/jlUJ8TAXQUXXC00SmXWutXc6pqGWfqSD7OpUKOMsrznRZpPKTW1swaZHXLfYfW5zVIHeWpDoAgszpBRZYADwkAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8SI7xB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746C7C4CEED;
	Thu, 14 Aug 2025 16:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755187934;
	bh=OTb/evqKJ6AB/2g3EfNJNM1rRM0V1acmfrv9iZc89uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8SI7xB5mXK8mlliTAMmHFVtXZUg7oq/rDjrPnZr/BTUD1Ev9bD2LVsE/Q4va53rW
	 y87AsDuE6h76MT5n/x3J7etGN9F1WWYFYxnKDDJRtqcuMTMiHLjGiEejzmjl3ALAhC
	 F7NoMYMesk2CYXhwORA9yZfLK6iyZzcdki8aITpaWDr6Rc/udR8zJ0VndDpMmmIibH
	 jLOQeyXEIQPRj0Drce80zz1hMWBe0luF09BBMO1j+6J7CJc0ZRCdOLhJi+YLkrb6hp
	 l9J3DecYA8Hmy7kNgxvBVZwsXA4HZy5ruQIFeksGhAhf7j9rmOe3lcK049o6Icwyl6
	 vXadw3xou4YKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/6] KVM: x86: Convert vcpu_run()'s immediate exit param into a generic bitmap
Date: Thu, 14 Aug 2025 12:12:07 -0400
Message-Id: <20250814161212.2107674-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081231-vengeful-creasing-d789@gregkh>
References: <2025081231-vengeful-creasing-d789@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 2478b1b220c49d25cb1c3f061ec4f9b351d9a131 ]

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
Stable-dep-of: 6b1dd26544d0 ("KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while running the guest")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  6 +++++-
 arch/x86/kvm/svm/svm.c          |  4 ++--
 arch/x86/kvm/vmx/main.c         |  6 +++---
 arch/x86/kvm/vmx/tdx.c          | 18 +++++++++---------
 arch/x86/kvm/vmx/vmx.c          |  3 ++-
 arch/x86/kvm/vmx/x86_ops.h      |  4 ++--
 arch/x86/kvm/x86.c              | 11 ++++++++---
 7 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f7af967aa16f..b44f74fed1ac 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1680,6 +1680,10 @@ static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
 	return dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
 }
 
+enum kvm_x86_run_flags {
+	KVM_RUN_FORCE_IMMEDIATE_EXIT	= BIT(0),
+};
+
 struct kvm_x86_ops {
 	const char *name;
 
@@ -1761,7 +1765,7 @@ struct kvm_x86_ops {
 
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
index ec79aacc446f..d584c0e28692 100644
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
index 191a9ed0da22..ff33e79f8415 100644
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
index 93636f77c42d..d0e11b5efcf4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10785,6 +10785,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		dm_request_for_irq_injection(vcpu) &&
 		kvm_cpu_accept_dm_intr(vcpu);
 	fastpath_t exit_fastpath;
+	u64 run_flags;
 
 	bool req_immediate_exit = false;
 
@@ -11029,8 +11030,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
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
@@ -11067,8 +11071,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		WARN_ON_ONCE((kvm_vcpu_apicv_activated(vcpu) != kvm_vcpu_apicv_active(vcpu)) &&
 			     (kvm_get_apic_mode(vcpu) != LAPIC_MODE_DISABLED));
 
-		exit_fastpath = kvm_x86_call(vcpu_run)(vcpu,
-						       req_immediate_exit);
+		exit_fastpath = kvm_x86_call(vcpu_run)(vcpu, run_flags);
 		if (likely(exit_fastpath != EXIT_FASTPATH_REENTER_GUEST))
 			break;
 
@@ -11080,6 +11083,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			break;
 		}
 
+		run_flags = 0;
+
 		/* Note, VM-Exits that go down the "slow" path are accounted below. */
 		++vcpu->stat.exits;
 	}
-- 
2.39.5


