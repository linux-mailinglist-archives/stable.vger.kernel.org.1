Return-Path: <stable+bounces-139336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0186AAA6237
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AB71BA1A39
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F53B20E026;
	Thu,  1 May 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BshbQ4E7"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f202.google.com (mail-vk1-f202.google.com [209.85.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B342080C8
	for <stable@vger.kernel.org>; Thu,  1 May 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746119843; cv=none; b=mpGrQrCYMRMQokywLdgL7BvL/2U7PTEtMuxEWmQJrp/HfulIDO65L8f+EISu8ixQqZM8K+xHSrb33oEGo0woFKilwqeECItzi3hZOsCGAGzAGkUzhtXk3JEDwbcvhHk+cP6KaNdcFhDdC/jFLjnuQPOBWC3e36vV4hWwQWhHJ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746119843; c=relaxed/simple;
	bh=kQKZ64Im4NUhmzxHi+kVHX/NIu2bAP/+AHGsptdh64U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ht4fd4UtP/LHoYxgGzM0YEJNP8gN0JH2qPTGTH78UbgEBtgRg40IJk90f4lTkp8TrNN+Cssg+6kUtpXbgbvhQcjc4QvWRzU7mpZvCXH29s4JRILXmc+ZwIlB6m1JX8pcSgGGQ/8m2pWnrGP/Wxnp/D0yc7xeGyhGTY4TC6+0YFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BshbQ4E7; arc=none smtp.client-ip=209.85.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-vk1-f202.google.com with SMTP id 71dfb90a1353d-523efd77006so273358e0c.1
        for <stable@vger.kernel.org>; Thu, 01 May 2025 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746119840; x=1746724640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZBeEPkhAcUiLcRQWOBiW3pX6wIsGvuXthICf6gumz4=;
        b=BshbQ4E7HwXfiLyn2e0hnLsyI6+eY1xu0czIqydXqIpxpzj3AFMI14QPt60B+JyXQ5
         Pk4N2eV7pcx/46FgBCZOOgW10/IV3nFy0btU3NCN7rF+YCaUBCbc9ffnRs07omYQBsIp
         rbqFaK7B4EX/19rGtCIOa/A816XPHU4iQltGiBzsbbH0snzZ6ecVvwQ39inHEjw2rb4I
         nWAUsRNFmUThAKVVIvr2C4ocEalRW3drlb80yt7V+iN/rcsp9htl8IiPewj388tPruGE
         Xkh1k2XuBztrFEWxoIaiREQ/hKFe2Pg6I92i7+4W8SrCadDv+Bw/wv+WsKpxgF5XUuCs
         FDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746119840; x=1746724640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZBeEPkhAcUiLcRQWOBiW3pX6wIsGvuXthICf6gumz4=;
        b=MUuYdr0kFnFaULP/MusupdnGjMbRDhofzaOg+3pjbO+MjH9x8zXbYmgcA9x6QEJGkq
         r/575YkNSdYdl/pZJ8lcb92HOyOMR9w5n49Fy8sLgiqxnFtQzFufzZSA4lg8sWrpQwVE
         sqQ2t9Jg4kRjKTCXRhccWlPeJ58R+55NUzAJC7jlp0iyVBc1pdSnvoxohnDmfKHkQjNL
         kf4iKNSjccZr7H2uVwt3Bnv/Bl/by+QHnLsbfLDJ+U/qbScErnXFC0N4cXkSy7jiq7+Z
         yoeUJa0sgzUZGCsjVzh/pNKdakPWBsV9hboUKbyRL/QfRG9A/bezDS8gYAVQinmyNM5d
         PGdQ==
X-Gm-Message-State: AOJu0Yw0FgqRRtI1bDUBt5oIr4N+cqPS8qSlLqCUzkgS3iMJ5Z5qySYm
	OXRx5IVyiHHzQFxaot1M+sGgj3ZfStU24/4irg8yoFLMaihXKizMbjljaC+0OimH8aKVCH46I6f
	0Ftma0w/uo1MjQ83kwZr+3Que+uWQt3YoQNYOe6h6hJColti+Zz8zU8COATQvkaSZ+k6RNqIvA6
	awad++7tx3/eB4x6fjZDvWAiXfWLn4gmEP14LGVMktvfAYmh4uUZjIQg==
X-Google-Smtp-Source: AGHT+IHvUWEPepGaEj3VbSGKLMB3n8FX8OdKFDo1MLpqaeNzWhKZ6WSsFoLDK5gnk9SR0r45GM9tjp726EjJIn51
X-Received: from vkbcp8.prod.google.com ([2002:a05:6122:4308:b0:529:bad:8a8d])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6122:1d9e:b0:525:bf40:e628 with SMTP id 71dfb90a1353d-52ade3a4bedmr2459367e0c.6.1746119840073;
 Thu, 01 May 2025 10:17:20 -0700 (PDT)
Date: Thu,  1 May 2025 17:17:18 +0000
In-Reply-To: <2025021815-protract-greasily-cdea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025021815-protract-greasily-cdea@gregkh>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250501171718.1267642-1-jthoughton@google.com>
Subject: [PATCH 5.15.y] KVM: x86: Load DR6 with guest value only before
 entering .vcpu_run() loop
From: James Houghton <jthoughton@google.com>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, John Stultz <jstultz@google.com>, 
	Jim Mattson <jmattson@google.com>, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit c2fee09fc167c74a64adb08656cb993ea475197e ]

Move the conditional loading of hardware DR6 with the guest's DR6 value
out of the core .vcpu_run() loop to fix a bug where KVM can load hardware
with a stale vcpu->arch.dr6.

When the guest accesses a DR and host userspace isn't debugging the guest,
KVM disables DR interception and loads the guest's values into hardware on
VM-Enter and saves them on VM-Exit.  This allows the guest to access DRs
at will, e.g. so that a sequence of DR accesses to configure a breakpoint
only generates one VM-Exit.

For DR0-DR3, the logic/behavior is identical between VMX and SVM, and also
identical between KVM_DEBUGREG_BP_ENABLED (userspace debugging the guest)
and KVM_DEBUGREG_WONT_EXIT (guest using DRs), and so KVM handles loading
DR0-DR3 in common code, _outside_ of the core kvm_x86_ops.vcpu_run() loop.

But for DR6, the guest's value doesn't need to be loaded into hardware for
KVM_DEBUGREG_BP_ENABLED, and SVM provides a dedicated VMCB field whereas
VMX requires software to manually load the guest value, and so loading the
guest's value into DR6 is handled by {svm,vmx}_vcpu_run(), i.e. is done
_inside_ the core run loop.

Unfortunately, saving the guest values on VM-Exit is initiated by common
x86, again outside of the core run loop.  If the guest modifies DR6 (in
hardware, when DR interception is disabled), and then the next VM-Exit is
a fastpath VM-Exit, KVM will reload hardware DR6 with vcpu->arch.dr6 and
clobber the guest's actual value.

The bug shows up primarily with nested VMX because KVM handles the VMX
preemption timer in the fastpath, and the window between hardware DR6
being modified (in guest context) and DR6 being read by guest software is
orders of magnitude larger in a nested setup.  E.g. in non-nested, the
VMX preemption timer would need to fire precisely between #DB injection
and the #DB handler's read of DR6, whereas with a KVM-on-KVM setup, the
window where hardware DR6 is "dirty" extends all the way from L1 writing
DR6 to VMRESUME (in L1).

    L1's view:
    ==========
    <L1 disables DR interception>
           CPU 0/KVM-7289    [023] d....  2925.640961: kvm_entry: vcpu 0
 A:  L1 Writes DR6
           CPU 0/KVM-7289    [023] d....  2925.640963: <hack>: Set DRs, DR6 = 0xffff0ff1

 B:        CPU 0/KVM-7289    [023] d....  2925.640967: kvm_exit: vcpu 0 reason EXTERNAL_INTERRUPT intr_info 0x800000ec

 D: L1 reads DR6, arch.dr6 = 0
           CPU 0/KVM-7289    [023] d....  2925.640969: <hack>: Sync DRs, DR6 = 0xffff0ff0

           CPU 0/KVM-7289    [023] d....  2925.640976: kvm_entry: vcpu 0
    L2 reads DR6, L1 disables DR interception
           CPU 0/KVM-7289    [023] d....  2925.640980: kvm_exit: vcpu 0 reason DR_ACCESS info1 0x0000000000000216
           CPU 0/KVM-7289    [023] d....  2925.640983: kvm_entry: vcpu 0

           CPU 0/KVM-7289    [023] d....  2925.640983: <hack>: Set DRs, DR6 = 0xffff0ff0

    L2 detects failure
           CPU 0/KVM-7289    [023] d....  2925.640987: kvm_exit: vcpu 0 reason HLT
    L1 reads DR6 (confirms failure)
           CPU 0/KVM-7289    [023] d....  2925.640990: <hack>: Sync DRs, DR6 = 0xffff0ff0

    L0's view:
    ==========
    L2 reads DR6, arch.dr6 = 0
          CPU 23/KVM-5046    [001] d....  3410.005610: kvm_exit: vcpu 23 reason DR_ACCESS info1 0x0000000000000216
          CPU 23/KVM-5046    [001] .....  3410.005610: kvm_nested_vmexit: vcpu 23 reason DR_ACCESS info1 0x0000000000000216

    L2 => L1 nested VM-Exit
          CPU 23/KVM-5046    [001] .....  3410.005610: kvm_nested_vmexit_inject: reason: DR_ACCESS ext_inf1: 0x0000000000000216

          CPU 23/KVM-5046    [001] d....  3410.005610: kvm_entry: vcpu 23
          CPU 23/KVM-5046    [001] d....  3410.005611: kvm_exit: vcpu 23 reason VMREAD
          CPU 23/KVM-5046    [001] d....  3410.005611: kvm_entry: vcpu 23
          CPU 23/KVM-5046    [001] d....  3410.005612: kvm_exit: vcpu 23 reason VMREAD
          CPU 23/KVM-5046    [001] d....  3410.005612: kvm_entry: vcpu 23

    L1 writes DR7, L0 disables DR interception
          CPU 23/KVM-5046    [001] d....  3410.005612: kvm_exit: vcpu 23 reason DR_ACCESS info1 0x0000000000000007
          CPU 23/KVM-5046    [001] d....  3410.005613: kvm_entry: vcpu 23

    L0 writes DR6 = 0 (arch.dr6)
          CPU 23/KVM-5046    [001] d....  3410.005613: <hack>: Set DRs, DR6 = 0xffff0ff0

 A: <L1 writes DR6 = 1, no interception, arch.dr6 is still '0'>

 B:       CPU 23/KVM-5046    [001] d....  3410.005614: kvm_exit: vcpu 23 reason PREEMPTION_TIMER
          CPU 23/KVM-5046    [001] d....  3410.005614: kvm_entry: vcpu 23

 C: L0 writes DR6 = 0 (arch.dr6)
          CPU 23/KVM-5046    [001] d....  3410.005614: <hack>: Set DRs, DR6 = 0xffff0ff0

    L1 => L2 nested VM-Enter
          CPU 23/KVM-5046    [001] d....  3410.005616: kvm_exit: vcpu 23 reason VMRESUME

    L0 reads DR6, arch.dr6 = 0

Reported-by: John Stultz <jstultz@google.com>
Closes: https://lkml.kernel.org/r/CANDhNCq5_F3HfFYABqFGCA1bPd_%2BxgNj-iDQhH4tDk%2Bwi8iZZg%40mail.gmail.com
Fixes: 375e28ffc0cf ("KVM: X86: Set host DR6 only on VMX and for KVM_DEBUGREG_WONT_EXIT")
Fixes: d67668e9dd76 ("KVM: x86, SVM: isolate vcpu->arch.dr6 from vmcb->save.dr6")
Cc: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Tested-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/20250125011833.3644371-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[jth: Handled conflicts with kvm_x86_ops reshuffle]
Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/svm/svm.c             | 13 ++++++-------
 arch/x86/kvm/vmx/vmx.c             | 11 +++++++----
 arch/x86/kvm/x86.c                 |  3 +++
 5 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 4bdcb91478a51..9e00275576b1f 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -44,6 +44,7 @@ KVM_X86_OP(set_idt)
 KVM_X86_OP(get_gdt)
 KVM_X86_OP(set_gdt)
 KVM_X86_OP(sync_dirty_debug_regs)
+KVM_X86_OP(set_dr6)
 KVM_X86_OP(set_dr7)
 KVM_X86_OP(cache_reg)
 KVM_X86_OP(get_rflags)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f779facd82460..710c9c87cdf2e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1344,6 +1344,7 @@ struct kvm_x86_ops {
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*sync_dirty_debug_regs)(struct kvm_vcpu *vcpu);
+	void (*set_dr6)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*set_dr7)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
 	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index bc0958eb83b4b..0d0aea145f2d5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1887,11 +1887,11 @@ static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
 	svm->asid = sd->next_asid++;
 }
 
-static void svm_set_dr6(struct vcpu_svm *svm, unsigned long value)
+static void svm_set_dr6(struct kvm_vcpu *vcpu, unsigned long value)
 {
-	struct vmcb *vmcb = svm->vmcb;
+	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
 
-	if (svm->vcpu.arch.guest_state_protected)
+	if (vcpu->arch.guest_state_protected)
 		return;
 
 	if (unlikely(value != vmcb->save.dr6)) {
@@ -3851,10 +3851,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * Run with all-zero DR6 unless needed, so that we can get the exact cause
 	 * of a #DB.
 	 */
-	if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
-		svm_set_dr6(svm, vcpu->arch.dr6);
-	else
-		svm_set_dr6(svm, DR6_ACTIVE_LOW);
+	if (likely(!(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)))
+		svm_set_dr6(vcpu, DR6_ACTIVE_LOW);
 
 	clgi();
 	kvm_load_guest_xsave_state(vcpu);
@@ -4631,6 +4629,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_idt = svm_set_idt,
 	.get_gdt = svm_get_gdt,
 	.set_gdt = svm_set_gdt,
+	.set_dr6 = svm_set_dr6,
 	.set_dr7 = svm_set_dr7,
 	.sync_dirty_debug_regs = svm_sync_dirty_debug_regs,
 	.cache_reg = svm_cache_reg,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6965cf92bd361..5e3e60bdaa5ee 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5249,6 +5249,12 @@ static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 	set_debugreg(DR6_RESERVED, 6);
 }
 
+static void vmx_set_dr6(struct kvm_vcpu *vcpu, unsigned long val)
+{
+	lockdep_assert_irqs_disabled();
+	set_debugreg(vcpu->arch.dr6, 6);
+}
+
 static void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 {
 	vmcs_writel(GUEST_DR7, val);
@@ -6839,10 +6845,6 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		vmx->loaded_vmcs->host_state.cr4 = cr4;
 	}
 
-	/* When KVM_DEBUGREG_WONT_EXIT, dr6 is accessible in guest. */
-	if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
-		set_debugreg(vcpu->arch.dr6, 6);
-
 	/* When single-stepping over STI and MOV SS, we must clear the
 	 * corresponding interruptibility bits in the guest state. Otherwise
 	 * vmentry fails as it then expects bit 14 (BS) in pending debug
@@ -7777,6 +7779,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.set_idt = vmx_set_idt,
 	.get_gdt = vmx_get_gdt,
 	.set_gdt = vmx_set_gdt,
+	.set_dr6 = vmx_set_dr6,
 	.set_dr7 = vmx_set_dr7,
 	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
 	.cache_reg = vmx_cache_reg,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b9e7457bf2aa2..bf03f3ff896e3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9963,6 +9963,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(vcpu->arch.eff_db[1], 1);
 		set_debugreg(vcpu->arch.eff_db[2], 2);
 		set_debugreg(vcpu->arch.eff_db[3], 3);
+		/* When KVM_DEBUGREG_WONT_EXIT, dr6 is accessible in guest. */
+		if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
+			static_call(kvm_x86_set_dr6)(vcpu, vcpu->arch.dr6);
 	} else if (unlikely(hw_breakpoint_active())) {
 		set_debugreg(0, 7);
 	}
-- 
2.49.0.906.g1f30a19c02-goog


