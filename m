Return-Path: <stable+bounces-200318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D27CCABF42
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 04:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3B37300AC3B
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 03:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDC7238C0A;
	Mon,  8 Dec 2025 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LIfRHaZe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5514D1B6CE9
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765164125; cv=none; b=Q6nrZzjkQeQOOSiUYvCvD3eXsnIhce1Glok9FrXYQsh80Yvo/xCAKJUqzqjkahzkogmbL3kJY0Uow7iHQWxk7foImP/vEK609fPgagFNN7JiqzCGZDn0ejvNZ4vuJPPAu4J3mFfD8+Eum6/Eqmewi3CD+b1Ejh7BUZpekXj4tDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765164125; c=relaxed/simple;
	bh=8UkgDsqdqfqT0K334V99aB0rVlX8tsosb66DacbxtK0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r3u59nQA0Qt2fIl+XNwHN6x5q8QnGfRYujOSvJQGY4vIU8jnTFMiEYa4TByJnfqaI2WjD9UQYjt+1TN7eaHS4GXLDdXX76+JavKp/Fgpr6tqFZa053LW+ubMJ/zsrOGDV1a3b7TtDFP/kvqaFB5BIjPgX1Wgv1Ql0aIiSPxIAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LIfRHaZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EA3C4CEFB;
	Mon,  8 Dec 2025 03:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765164124;
	bh=8UkgDsqdqfqT0K334V99aB0rVlX8tsosb66DacbxtK0=;
	h=Subject:To:Cc:From:Date:From;
	b=LIfRHaZeJTnKGph5wVnbuCxlqcIoGGjRsJ5yBEn5s5+XTYwZBDtxyp2FwX8IXKRxZ
	 uJfYNQtzXBlHOgDdtYPgPRoYsLUtipxFS3gEXw+eIimSpsGiNsZYZJJuGwTKwD7TpA
	 Cu1S/grQHOmlicjaD5QWT7ahSPpX5wYv7eQaAPnM=
Subject: FAILED: patch "[PATCH] KVM: SVM: Don't skip unrelated instruction if INT3/INTO is" failed to apply to 6.1-stable tree
To: osandov@fb.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Dec 2025 12:22:02 +0900
Message-ID: <2025120802-remedy-glimmer-fc9d@gregkh>
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
git cherry-pick -x 4da3768e1820cf15cced390242d8789aed34f54d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120802-remedy-glimmer-fc9d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4da3768e1820cf15cced390242d8789aed34f54d Mon Sep 17 00:00:00 2001
From: Omar Sandoval <osandov@fb.com>
Date: Tue, 4 Nov 2025 09:55:26 -0800
Subject: [PATCH] KVM: SVM: Don't skip unrelated instruction if INT3/INTO is
 replaced

When re-injecting a soft interrupt from an INT3, INT0, or (select) INTn
instruction, discard the exception and retry the instruction if the code
stream is changed (e.g. by a different vCPU) between when the CPU
executes the instruction and when KVM decodes the instruction to get the
next RIP.

As effectively predicted by commit 6ef88d6e36c2 ("KVM: SVM: Re-inject
INT3/INTO instead of retrying the instruction"), failure to verify that
the correct INTn instruction was decoded can effectively clobber guest
state due to decoding the wrong instruction and thus specifying the
wrong next RIP.

The bug most often manifests as "Oops: int3" panics on static branch
checks in Linux guests.  Enabling or disabling a static branch in Linux
uses the kernel's "text poke" code patching mechanism.  To modify code
while other CPUs may be executing that code, Linux (temporarily)
replaces the first byte of the original instruction with an int3 (opcode
0xcc), then patches in the new code stream except for the first byte,
and finally replaces the int3 with the first byte of the new code
stream.  If a CPU hits the int3, i.e. executes the code while it's being
modified, then the guest kernel must look up the RIP to determine how to
handle the #BP, e.g. by emulating the new instruction.  If the RIP is
incorrect, then this lookup fails and the guest kernel panics.

The bug reproduces almost instantly by hacking the guest kernel to
repeatedly check a static branch[1] while running a drgn script[2] on
the host to constantly swap out the memory containing the guest's TSS.

[1]: https://gist.github.com/osandov/44d17c51c28c0ac998ea0334edf90b5a
[2]: https://gist.github.com/osandov/10e45e45afa29b11e0c7209247afc00b

Fixes: 6ef88d6e36c2 ("KVM: SVM: Re-inject INT3/INTO instead of retrying the instruction")
Cc: stable@vger.kernel.org
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Link: https://patch.msgid.link/1cc6dcdf36e3add7ee7c8d90ad58414eeb6c3d34.1762278762.git.osandov@fb.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 48598d017d6f..974d64bf0a4d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2143,6 +2143,11 @@ u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
  *			     the gfn, i.e. retrying the instruction will hit a
  *			     !PRESENT fault, which results in a new shadow page
  *			     and sends KVM back to square one.
+ *
+ * EMULTYPE_SKIP_SOFT_INT - Set in combination with EMULTYPE_SKIP to only skip
+ *                          an instruction if it could generate a given software
+ *                          interrupt, which must be encoded via
+ *                          EMULTYPE_SET_SOFT_INT_VECTOR().
  */
 #define EMULTYPE_NO_DECODE	    (1 << 0)
 #define EMULTYPE_TRAP_UD	    (1 << 1)
@@ -2153,6 +2158,10 @@ u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
 #define EMULTYPE_PF		    (1 << 6)
 #define EMULTYPE_COMPLETE_USER_EXIT (1 << 7)
 #define EMULTYPE_WRITE_PF_TO_SP	    (1 << 8)
+#define EMULTYPE_SKIP_SOFT_INT	    (1 << 9)
+
+#define EMULTYPE_SET_SOFT_INT_VECTOR(v)	((u32)((v) & 0xff) << 16)
+#define EMULTYPE_GET_SOFT_INT_VECTOR(e)	(((e) >> 16) & 0xff)
 
 static inline bool kvm_can_emulate_event_vectoring(int emul_type)
 {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 1ae7b3c5a7c5..459db8154929 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -272,6 +272,7 @@ static void svm_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
 }
 
 static int __svm_skip_emulated_instruction(struct kvm_vcpu *vcpu,
+					   int emul_type,
 					   bool commit_side_effects)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -293,7 +294,7 @@ static int __svm_skip_emulated_instruction(struct kvm_vcpu *vcpu,
 		if (unlikely(!commit_side_effects))
 			old_rflags = svm->vmcb->save.rflags;
 
-		if (!kvm_emulate_instruction(vcpu, EMULTYPE_SKIP))
+		if (!kvm_emulate_instruction(vcpu, emul_type))
 			return 0;
 
 		if (unlikely(!commit_side_effects))
@@ -311,11 +312,13 @@ static int __svm_skip_emulated_instruction(struct kvm_vcpu *vcpu,
 
 static int svm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
-	return __svm_skip_emulated_instruction(vcpu, true);
+	return __svm_skip_emulated_instruction(vcpu, EMULTYPE_SKIP, true);
 }
 
-static int svm_update_soft_interrupt_rip(struct kvm_vcpu *vcpu)
+static int svm_update_soft_interrupt_rip(struct kvm_vcpu *vcpu, u8 vector)
 {
+	const int emul_type = EMULTYPE_SKIP | EMULTYPE_SKIP_SOFT_INT |
+			      EMULTYPE_SET_SOFT_INT_VECTOR(vector);
 	unsigned long rip, old_rip = kvm_rip_read(vcpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -331,7 +334,7 @@ static int svm_update_soft_interrupt_rip(struct kvm_vcpu *vcpu)
 	 * in use, the skip must not commit any side effects such as clearing
 	 * the interrupt shadow or RFLAGS.RF.
 	 */
-	if (!__svm_skip_emulated_instruction(vcpu, !nrips))
+	if (!__svm_skip_emulated_instruction(vcpu, emul_type, !nrips))
 		return -EIO;
 
 	rip = kvm_rip_read(vcpu);
@@ -367,7 +370,7 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
 	kvm_deliver_exception_payload(vcpu, ex);
 
 	if (kvm_exception_is_soft(ex->vector) &&
-	    svm_update_soft_interrupt_rip(vcpu))
+	    svm_update_soft_interrupt_rip(vcpu, ex->vector))
 		return;
 
 	svm->vmcb->control.event_inj = ex->vector
@@ -3642,11 +3645,12 @@ static bool svm_set_vnmi_pending(struct kvm_vcpu *vcpu)
 
 static void svm_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
 {
+	struct kvm_queued_interrupt *intr = &vcpu->arch.interrupt;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 type;
 
-	if (vcpu->arch.interrupt.soft) {
-		if (svm_update_soft_interrupt_rip(vcpu))
+	if (intr->soft) {
+		if (svm_update_soft_interrupt_rip(vcpu, intr->nr))
 			return;
 
 		type = SVM_EVTINJ_TYPE_SOFT;
@@ -3654,12 +3658,10 @@ static void svm_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
 		type = SVM_EVTINJ_TYPE_INTR;
 	}
 
-	trace_kvm_inj_virq(vcpu->arch.interrupt.nr,
-			   vcpu->arch.interrupt.soft, reinjected);
+	trace_kvm_inj_virq(intr->nr, intr->soft, reinjected);
 	++vcpu->stat.irq_injections;
 
-	svm->vmcb->control.event_inj = vcpu->arch.interrupt.nr |
-				       SVM_EVTINJ_VALID | type;
+	svm->vmcb->control.event_inj = intr->nr | SVM_EVTINJ_VALID | type;
 }
 
 void svm_complete_interrupt_delivery(struct kvm_vcpu *vcpu, int delivery_mode,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 42ecd093bb4c..8e14c0292809 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9338,6 +9338,23 @@ static bool is_vmware_backdoor_opcode(struct x86_emulate_ctxt *ctxt)
 	return false;
 }
 
+static bool is_soft_int_instruction(struct x86_emulate_ctxt *ctxt,
+				    int emulation_type)
+{
+	u8 vector = EMULTYPE_GET_SOFT_INT_VECTOR(emulation_type);
+
+	switch (ctxt->b) {
+	case 0xcc:
+		return vector == BP_VECTOR;
+	case 0xcd:
+		return vector == ctxt->src.val;
+	case 0xce:
+		return vector == OF_VECTOR;
+	default:
+		return false;
+	}
+}
+
 /*
  * Decode an instruction for emulation.  The caller is responsible for handling
  * code breakpoints.  Note, manually detecting code breakpoints is unnecessary
@@ -9448,6 +9465,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	 * injecting single-step #DBs.
 	 */
 	if (emulation_type & EMULTYPE_SKIP) {
+		if (emulation_type & EMULTYPE_SKIP_SOFT_INT &&
+		    !is_soft_int_instruction(ctxt, emulation_type))
+			return 0;
+
 		if (ctxt->mode != X86EMUL_MODE_PROT64)
 			ctxt->eip = (u32)ctxt->_eip;
 		else


