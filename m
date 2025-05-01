Return-Path: <stable+bounces-139334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFDEAA621B
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5864E1BC62DA
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFD118DB3D;
	Thu,  1 May 2025 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CnloFNcq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43742A87
	for <stable@vger.kernel.org>; Thu,  1 May 2025 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746119563; cv=none; b=NO9DCNJwZLr9T0mquBwsFnGB8iPEvnpGFLobTdgOBEl1gi4flmJgzzhODLD4timCEO0ReMSi13JdQmEwsqGTz7GRG5r02NJQGvfZhH/V6kKYmVo9DlwCSxHQdeYerzwlNAcd+FnjzuULIkN3y+NGRJTh8P4iQ1Hly9FouAAlKNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746119563; c=relaxed/simple;
	bh=RPgpisjlUhvhWG+PXL4ZyN7AXK/1j3AdOhA4kwGZfDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sZ0EjHGJKx86bNs4rAj4cULUZCOJltWSyF0JZcHbw3b001NeLT4vWEyE5syzgL77JcXokJKvtJjTzDT11s55Tn85rg1Of38r1D3qEN+ccYZj+On2/AgXCCCXcAvsJgqOGDPX0mO/SfhMs8NOoXohcW+QBS8AszSpH04lpWyg9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CnloFNcq; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4768656f608so24403071cf.1
        for <stable@vger.kernel.org>; Thu, 01 May 2025 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746119560; x=1746724360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdgpiH/QnPzn8N4Hh1Y8C5xD9+owYf054zlRsSTMe7U=;
        b=CnloFNcqQwo3BYnoPCdUDFLMfiMTVJV4DnALEfSaj+2snzPwRMH1swImV+V+up2X/7
         zgrzvSTnKhRv+V9cVoWjNLgz7ybPp2sc+WYOQrgcNlvlK23GqUVoxzXfx3xDgfjwlzen
         me89y9D8nBts+OrPjd4ZGPUSOqkkW0imJ9CLVulIVunI2HtJ+KQkRIcWn+FuLJT1ahdg
         uFxtgIKSomOoznmJMyIW455bPhXNw0tL5p5XxRC6MFSsyq1AqIqcYnz2F/o/Ts/YpJ7K
         h9zUh7kW2/aV9EeqdDz192UG1MVVfxb+rxnmdpU7eSSV1oTq47sA/Ot4wB/RUvLKriMD
         3Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746119560; x=1746724360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdgpiH/QnPzn8N4Hh1Y8C5xD9+owYf054zlRsSTMe7U=;
        b=XJOiifQMub9+a5VBWBgznZorpUnWBWQum/X6VRLQcq0KKzqQMJFYkJomd+dVrzixoi
         l0PT/W68gsuheLPamJHT8LQRQVM/c32i/WawoTTI5LuPYoxiLonddxVOL/igz09iCBjU
         GiG4GJP/LTAfQdo6owUuf8Om114U/IpCK/lbJ5PIbpaPKNGWtn3JNt6uYMvxLgy7YX2t
         XhYEl6ucOz8TXD/7xCpmKag5MjRpvd20MCw3gvmwx/lE+3qX21b2TOfznT8GrMry46N9
         PnrZn8n1xDocNxelfuBHj2D/COz7EqjyewZq6m2R1hFtqGCzDEiKaqm8WvxpX0eYE1br
         Ilxg==
X-Gm-Message-State: AOJu0YxPsBdafxU8Rmtvc+K3nFxJHvDcILkWlRrfDOALJXbSzihesLna
	1iqi1DeJdTLjINQiYXcueBiK4x6i0ltEafOV6npSlTUy49GNMWofFotiFZAM8rRGErIYoefrNHU
	1LpMf/oKn0tg3yXLQnhGSAbT22d+fW+0WL5L+VL+WLp+YMQLLA/nPX3bGER5VCtXDU0yl3HyS6s
	X2YzE7rPpn76n3TSXAJlb0Zep0RqPfRLhgVpUPIvxnoyckBnh9ojFtog==
X-Google-Smtp-Source: AGHT+IF9nK5nT6zZ0CPyzeVrn+R2Mryj2MZd0LZ6gYCF1YBGofnl+uSmhK+wKmcI7NCsLFCKNt1pgd4SAd5tSHW2
X-Received: from qtbff27.prod.google.com ([2002:a05:622a:4d9b:b0:47a:ffce:b4b2])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4a88:b0:474:f778:bdae with SMTP id d75a77b69052e-48b2089467amr50716681cf.12.1746119559938;
 Thu, 01 May 2025 10:12:39 -0700 (PDT)
Date: Thu,  1 May 2025 17:12:26 +0000
In-Reply-To: <2025021809-census-mammal-224b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025021809-census-mammal-224b@gregkh>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250501171226.1257503-1-jthoughton@google.com>
Subject: [PATCH 6.6.y] KVM: x86: Load DR6 with guest value only before
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
index 9b419f0de713c..e59ded9761663 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -48,6 +48,7 @@ KVM_X86_OP(set_idt)
 KVM_X86_OP(get_gdt)
 KVM_X86_OP(set_gdt)
 KVM_X86_OP(sync_dirty_debug_regs)
+KVM_X86_OP(set_dr6)
 KVM_X86_OP(set_dr7)
 KVM_X86_OP(cache_reg)
 KVM_X86_OP(get_rflags)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 39672561c6be8..5dfb8cc9616e5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1595,6 +1595,7 @@ struct kvm_x86_ops {
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*sync_dirty_debug_regs)(struct kvm_vcpu *vcpu);
+	void (*set_dr6)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*set_dr7)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
 	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 1d06b8fc15a85..29c1be65cb71a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2014,11 +2014,11 @@ static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
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
@@ -4220,10 +4220,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
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
@@ -5002,6 +5000,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_idt = svm_set_idt,
 	.get_gdt = svm_get_gdt,
 	.set_gdt = svm_set_gdt,
+	.set_dr6 = svm_set_dr6,
 	.set_dr7 = svm_set_dr7,
 	.sync_dirty_debug_regs = svm_sync_dirty_debug_regs,
 	.cache_reg = svm_cache_reg,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 52098844290ad..e5a2c230110ea 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5617,6 +5617,12 @@ static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
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
@@ -7356,10 +7362,6 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		vmx->loaded_vmcs->host_state.cr4 = cr4;
 	}
 
-	/* When KVM_DEBUGREG_WONT_EXIT, dr6 is accessible in guest. */
-	if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
-		set_debugreg(vcpu->arch.dr6, 6);
-
 	/* When single-stepping over STI and MOV SS, we must clear the
 	 * corresponding interruptibility bits in the guest state. Otherwise
 	 * vmentry fails as it then expects bit 14 (BS) in pending debug
@@ -8292,6 +8294,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.set_idt = vmx_set_idt,
 	.get_gdt = vmx_get_gdt,
 	.set_gdt = vmx_set_gdt,
+	.set_dr6 = vmx_set_dr6,
 	.set_dr7 = vmx_set_dr7,
 	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
 	.cache_reg = vmx_cache_reg,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2a2dbeb56897d..0b6a8abc0ae72 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10772,6 +10772,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
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


