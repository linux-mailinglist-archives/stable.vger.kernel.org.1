Return-Path: <stable+bounces-139335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 683CBAA6233
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72241BC7BB4
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11016218845;
	Thu,  1 May 2025 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uD/G7aLM"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C7215779
	for <stable@vger.kernel.org>; Thu,  1 May 2025 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746119705; cv=none; b=Oxt6XXCN9FIaplvYj9hG4iqbqLu1cMTF0C0McIwIwLJkfjVFrFodF0mi3cef+RljIVTifjKVLUVygCxXC9YMysKhOgzDKN5DYNyC1mitm0+DXwWgxv+Nhg5736N7xtKQttNhFlfoB0+/uEmxW8S2765+Qk2/Ho3uU3DxwQ7bA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746119705; c=relaxed/simple;
	bh=tircMbjfQ13nhtxhIVLuRrLAT7kw1FXDutfuvBbRkjE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CuY34mb2cK0r46YR1c2p8L8XPjt9oNEIlcX0tsZfG6hqm8ZxwpIB8JGbNQG3ykDLQ3p2KaB/Gc/P+S4aqaAS5T8w1jjIv8BM+W1lvm+xpOlcKlr2PpLZHJv963Z/G8i25Cj/aFmkQRlfigbivcz0ULmO3lNV6fUnQD/6Edt4fj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uD/G7aLM; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-4c33de03dafso211390137.3
        for <stable@vger.kernel.org>; Thu, 01 May 2025 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746119702; x=1746724502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5lUaR4lSlHe3oschvQ99usW65bPF4QNe9NdWSLy1VQ=;
        b=uD/G7aLMRkf4Aazvrpd8+x7BJVFlm+8q8P2+pj/ItoTPL84Kmnt85NbT5dA7eRaNlL
         +1zxwSOPM0vTpKSJhQscP/ikVrcXBMozGuU72YXvg97N+w/2COiEKStapvFvc118rIDU
         ValBenep4KJc2b8N71IbIoUDVjTdI6+Vp2Q/PZbMyE9dDeooEkGjfY6r1B0HTw8CH37n
         90o/rWqJ3mmUq/vn8GgL/ALu5dLXTVhpKmjxNHOmgGZCb+EWEvqb0pXfsRpATnuKCSr7
         4P/3pyOBD01SIRhiBhh5vboXKxSgGnZC6VSUim9zY4IFY6ysauBXIk6lvFADoKHCuYpV
         Qy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746119702; x=1746724502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5lUaR4lSlHe3oschvQ99usW65bPF4QNe9NdWSLy1VQ=;
        b=W5s3u/rTycB7iQboO7eZE/4usMjC28MDwJq9/Po34SIr+U3YUGPO+SwYX+y2NeV8H5
         xOt4tmkEF9z9vNhdtEejWsqyowzvgeSxp0flB69KYh5wrJVZmvvT/fVSuJnUVMPZrhV+
         1IOhs05KBGWdt1bhYmmljCyvVPoDGD8c88eKHc2WCG/3LkQWxnkmybkIR0adEdYyuNHt
         WO5a0ucPrMb3d07DBIq5QZ+V4oNgqC3bmQYRA13sD4VdF6pXVxXeskkGTpjJZPhekLQ1
         4zaCvJItF8I7GPhqkrmtSbZL4HHOD80YluEf15iAfZSWsIh4O0cKf05iXA9Dn4UproYk
         IUVA==
X-Gm-Message-State: AOJu0Yz2lDHxtT0Uiu2HEN2/4zmmYOoLc6gTilR+QMVlX3P7UyyxrX1B
	P1KOUxAPGas8Jtp2GJqRfeuH0G2giSLI041e61PWPvMpiNhOSZsnouiAaPnqsTBZbb9NBv70Cac
	pw3ccdU5plaTlUitZbafTJk+RIhPWYxj7+eoNqTZYyS9HtywGfg8jIeEVg5rslu40mnQ3vQQbbl
	OkAV9g/uPXTwdcFYJpcpuQV3ZHIkLXg4cDJm4VxuX+bxPMtD92ixv6pA==
X-Google-Smtp-Source: AGHT+IF9l8Zu1wE3wZZZFVitaGgLqjVqKnCakt4hiM5hKEwsqdtFWVAP3Y+KVnhshuk3s9B0IFQ0JcJBkJ5lVDU0
X-Received: from vsvd40.prod.google.com ([2002:a05:6102:14a8:b0:4cd:4412:b53f])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:808d:b0:4c3:64bd:93ba with SMTP id ada2fe7eead31-4dae541b5d3mr3542935137.11.1746119702584;
 Thu, 01 May 2025 10:15:02 -0700 (PDT)
Date: Thu,  1 May 2025 17:14:59 +0000
In-Reply-To: <2025021812-candied-hamper-7f08@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025021812-candied-hamper-7f08@gregkh>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250501171459.1263002-1-jthoughton@google.com>
Subject: [PATCH 6.1.y] KVM: x86: Load DR6 with guest value only before
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
index abc07d0045897..29bef25ac77c9 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -47,6 +47,7 @@ KVM_X86_OP(set_idt)
 KVM_X86_OP(get_gdt)
 KVM_X86_OP(set_gdt)
 KVM_X86_OP(sync_dirty_debug_regs)
+KVM_X86_OP(set_dr6)
 KVM_X86_OP(set_dr7)
 KVM_X86_OP(cache_reg)
 KVM_X86_OP(get_rflags)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9de3db4a32f80..eb06c2f683145 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1499,6 +1499,7 @@ struct kvm_x86_ops {
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*sync_dirty_debug_regs)(struct kvm_vcpu *vcpu);
+	void (*set_dr6)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*set_dr7)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
 	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d7d1b0f7073f2..920e4a3583ab9 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1920,11 +1920,11 @@ static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
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
@@ -4035,10 +4035,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
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
@@ -4807,6 +4805,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_idt = svm_set_idt,
 	.get_gdt = svm_get_gdt,
 	.set_gdt = svm_set_gdt,
+	.set_dr6 = svm_set_dr6,
 	.set_dr7 = svm_set_dr7,
 	.sync_dirty_debug_regs = svm_sync_dirty_debug_regs,
 	.cache_reg = svm_cache_reg,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 460ba48eb66c8..6bd25401bc01e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5536,6 +5536,12 @@ static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
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
@@ -7220,10 +7226,6 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		vmx->loaded_vmcs->host_state.cr4 = cr4;
 	}
 
-	/* When KVM_DEBUGREG_WONT_EXIT, dr6 is accessible in guest. */
-	if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
-		set_debugreg(vcpu->arch.dr6, 6);
-
 	/* When single-stepping over STI and MOV SS, we must clear the
 	 * corresponding interruptibility bits in the guest state. Otherwise
 	 * vmentry fails as it then expects bit 14 (BS) in pending debug
@@ -8168,6 +8170,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.set_idt = vmx_set_idt,
 	.get_gdt = vmx_get_gdt,
 	.set_gdt = vmx_set_gdt,
+	.set_dr6 = vmx_set_dr6,
 	.set_dr7 = vmx_set_dr7,
 	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
 	.cache_reg = vmx_cache_reg,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4d5be4956c483..99c043862c47f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10841,6 +10841,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
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


