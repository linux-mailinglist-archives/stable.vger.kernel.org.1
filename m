Return-Path: <stable+bounces-167183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D924B22D01
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572C7165307
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DB827932F;
	Tue, 12 Aug 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pPcMTdjQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258D305E08
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015225; cv=none; b=nkb0d3zx3TZ9Au2+kCi80f681bVOFS+xYQWMhhKcAy8fiaG6GQZiCvSjJluxQlMD59xXwjvw/NhQHx61aQB8WXDZJFBxFeQ7I3t08xk6gxWwko2lFK5bBI77S3dBlODzVNVNot2o0JvMEdQYuX/PDMfydHxfbk6qVFkZkqS/E8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015225; c=relaxed/simple;
	bh=ZUnDSmbC4WdYxCyEDN4zpiCEfOuALlwska0vdu13xb4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GvKrgk+HdcciRLYUSwhzujy/i8Wj3NKfjAcSQURfglj59BgvNPg93WaOcfUxUDEr6VSlhNje72+qKWqQmpfwR/4W+UnMJnxxt6jN3pK/AwS3adirBxZ/5BqdntzVBR8oAu7eez5fp2QqRqy/Ev5ITjgsQnDG3NC5R7wVzjA5sBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pPcMTdjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADD4C4CEF0;
	Tue, 12 Aug 2025 16:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015225;
	bh=ZUnDSmbC4WdYxCyEDN4zpiCEfOuALlwska0vdu13xb4=;
	h=Subject:To:Cc:From:Date:From;
	b=pPcMTdjQVXjizA6QsukAjO6Avdjq9Zz8tKq/w+C9EXr/Uxu2wrK4q1Kid+UefkW8H
	 YtnYboKovLAYXQHOL61nshvuHTnEDiXziVai/lwDvlG5owxM1jnHQElpw1AbASs3HS
	 raVEaf1PeWForMCV4HPOgLxVJRSWKdOjGh03MSYM=
Subject: FAILED: patch "[PATCH] KVM: x86: Drop kvm_x86_ops.set_dr6() in favor of a new" failed to apply to 6.15-stable tree
To: seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:13:42 +0200
Message-ID: <2025081242-polygon-exploring-2a87@gregkh>
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
git cherry-pick -x 80c64c7afea1da6a93ebe88d3d29d8a60377ef80
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081242-polygon-exploring-2a87@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 80c64c7afea1da6a93ebe88d3d29d8a60377ef80 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Jun 2025 16:20:05 -0700
Subject: [PATCH] KVM: x86: Drop kvm_x86_ops.set_dr6() in favor of a new
 KVM_RUN flag

Instruct vendor code to load the guest's DR6 into hardware via a new
KVM_RUN flag, and remove kvm_x86_ops.set_dr6(), whose sole purpose was to
load vcpu->arch.dr6 into hardware when DR6 can be read/written directly
by the guest.

Note, TDX already WARNs on any run_flag being set, i.e. will yell if KVM
thinks DR6 needs to be reloaded.  TDX vCPUs force KVM_DEBUGREG_AUTO_SWITCH
and never clear the flag, i.e. should never observe KVM_RUN_LOAD_GUEST_DR6.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250610232010.162191-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 8d50e3e0a19b..9e0c37ea267e 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -49,7 +49,6 @@ KVM_X86_OP(set_idt)
 KVM_X86_OP(get_gdt)
 KVM_X86_OP(set_gdt)
 KVM_X86_OP(sync_dirty_debug_regs)
-KVM_X86_OP(set_dr6)
 KVM_X86_OP(set_dr7)
 KVM_X86_OP(cache_reg)
 KVM_X86_OP(get_rflags)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8d81684fa15d..4f7ee2dbf10e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1676,6 +1676,7 @@ static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
 
 enum kvm_x86_run_flags {
 	KVM_RUN_FORCE_IMMEDIATE_EXIT	= BIT(0),
+	KVM_RUN_LOAD_GUEST_DR6		= BIT(1),
 };
 
 struct kvm_x86_ops {
@@ -1728,7 +1729,6 @@ struct kvm_x86_ops {
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*sync_dirty_debug_regs)(struct kvm_vcpu *vcpu);
-	void (*set_dr6)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*set_dr7)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
 	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 83d1b62130b1..be8c43049f4d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4438,10 +4438,13 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	svm_hv_update_vp_id(svm->vmcb, vcpu);
 
 	/*
-	 * Run with all-zero DR6 unless needed, so that we can get the exact cause
-	 * of a #DB.
+	 * Run with all-zero DR6 unless the guest can write DR6 freely, so that
+	 * KVM can get the exact cause of a #DB.  Note, loading guest DR6 from
+	 * KVM's snapshot is only necessary when DR accesses won't exit.
 	 */
-	if (likely(!(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)))
+	if (unlikely(run_flags & KVM_RUN_LOAD_GUEST_DR6))
+		svm_set_dr6(vcpu, vcpu->arch.dr6);
+	else if (likely(!(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)))
 		svm_set_dr6(vcpu, DR6_ACTIVE_LOW);
 
 	clgi();
@@ -5252,7 +5255,6 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_idt = svm_set_idt,
 	.get_gdt = svm_get_gdt,
 	.set_gdt = svm_set_gdt,
-	.set_dr6 = svm_set_dr6,
 	.set_dr7 = svm_set_dr7,
 	.sync_dirty_debug_regs = svm_sync_dirty_debug_regs,
 	.cache_reg = svm_cache_reg,
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index fef3e3803707..c85cbce6d2f6 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -489,14 +489,6 @@ static void vt_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 	vmx_set_gdt(vcpu, dt);
 }
 
-static void vt_set_dr6(struct kvm_vcpu *vcpu, unsigned long val)
-{
-	if (is_td_vcpu(vcpu))
-		return;
-
-	vmx_set_dr6(vcpu, val);
-}
-
 static void vt_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 {
 	if (is_td_vcpu(vcpu))
@@ -943,7 +935,6 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.set_idt = vt_op(set_idt),
 	.get_gdt = vt_op(get_gdt),
 	.set_gdt = vt_op(set_gdt),
-	.set_dr6 = vt_op(set_dr6),
 	.set_dr7 = vt_op(set_dr7),
 	.sync_dirty_debug_regs = vt_op(sync_dirty_debug_regs),
 	.cache_reg = vt_op(cache_reg),
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a61a28944de6..4ee6cc796855 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5606,12 +5606,6 @@ void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 	set_debugreg(DR6_RESERVED, 6);
 }
 
-void vmx_set_dr6(struct kvm_vcpu *vcpu, unsigned long val)
-{
-	lockdep_assert_irqs_disabled();
-	set_debugreg(vcpu->arch.dr6, 6);
-}
-
 void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 {
 	vmcs_writel(GUEST_DR7, val);
@@ -7370,6 +7364,9 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		vmcs_writel(GUEST_RIP, vcpu->arch.regs[VCPU_REGS_RIP]);
 	vcpu->arch.regs_dirty = 0;
 
+	if (run_flags & KVM_RUN_LOAD_GUEST_DR6)
+		set_debugreg(vcpu->arch.dr6, 6);
+
 	/*
 	 * Refresh vmcs.HOST_CR3 if necessary.  This must be done immediately
 	 * prior to VM-Enter, as the kernel may load a new ASID (PCID) any time
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 07ff02eed399..7fe3549bbd93 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11046,7 +11046,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(vcpu->arch.eff_db[3], 3);
 		/* When KVM_DEBUGREG_WONT_EXIT, dr6 is accessible in guest. */
 		if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
-			kvm_x86_call(set_dr6)(vcpu, vcpu->arch.dr6);
+			run_flags |= KVM_RUN_LOAD_GUEST_DR6;
 	} else if (unlikely(hw_breakpoint_active())) {
 		set_debugreg(0, 7);
 	}


