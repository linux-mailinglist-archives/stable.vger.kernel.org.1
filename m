Return-Path: <stable+bounces-121684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36F6A5911E
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC1B3A473C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FAC22652D;
	Mon, 10 Mar 2025 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sR5UY0ZE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7F225797
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602446; cv=none; b=tK83pTKCGNU2e3LwC9PnDEiz7tPeFC0//1vZ/wQPgzZcshb4I0J91Yx7ickmlTtCReCPJ8tsK5y1zIpG+ETsDVh/b71W0iBEUpqrZ/pTewm9DE6lQDTyGnKDEBuJqWWeR05Mr2Vo7/9t+EnvIOXrIUaOFkIzQo9grk/DUCvri5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602446; c=relaxed/simple;
	bh=Yc1B7yL7BS3cp7BnnU7K5zVeciWQCXDZY9whPTDunvk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qrb4+ZOZ7b4eFxG+I1haiGY0Dadg4Q5KUHw4SPQxDarIa1f7HTBDIHqsx4a6EpyTKr0gEDCCs5kYOiRprpQ4OGIe44q61cfJb/FcXUIziCYChSOwTFl1ozV3iXvzOFH/0H8f5cwke+JfRAp1cgyktYTpwvN41anp5KE0YP1jJyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sR5UY0ZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C525C4CEE5;
	Mon, 10 Mar 2025 10:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741602445;
	bh=Yc1B7yL7BS3cp7BnnU7K5zVeciWQCXDZY9whPTDunvk=;
	h=Subject:To:Cc:From:Date:From;
	b=sR5UY0ZEHbSUqWMrene9js6VCMxHu8AVAr4fW+ijjGGDtMCPYfb6fGhQk9jV5KkWY
	 REVUB9HijgHwHtmiPcA+cwh+4q3G9DzYmMeibk0vPSjL6hn+ZP8Q6a/HDnway2Ewpu
	 M6g71B7FrG0qegfLuvVQ4p9A3n4FAKzWcGL04Ves=
Subject: FAILED: patch "[PATCH] KVM: SVM: Set RFLAGS.IF=1 in C code, to get VMRUN out of the" failed to apply to 6.6-stable tree
To: seanjc@google.com,doug.covelli@broadcom.com,jmattson@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Mar 2025 11:27:22 +0100
Message-ID: <2025031022-debunk-winner-e8fe@gregkh>
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
git cherry-pick -x be45bc4eff33d9a7dae84a2150f242a91a617402
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031022-debunk-winner-e8fe@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From be45bc4eff33d9a7dae84a2150f242a91a617402 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 24 Feb 2025 08:54:41 -0800
Subject: [PATCH] KVM: SVM: Set RFLAGS.IF=1 in C code, to get VMRUN out of the
 STI shadow

Enable/disable local IRQs, i.e. set/clear RFLAGS.IF, in the common
svm_vcpu_enter_exit() just after/before guest_state_{enter,exit}_irqoff()
so that VMRUN is not executed in an STI shadow.  AMD CPUs have a quirk
(some would say "bug"), where the STI shadow bleeds into the guest's
intr_state field if a #VMEXIT occurs during injection of an event, i.e. if
the VMRUN doesn't complete before the subsequent #VMEXIT.

The spurious "interrupts masked" state is relatively benign, as it only
occurs during event injection and is transient.  Because KVM is already
injecting an event, the guest can't be in HLT, and if KVM is querying IRQ
blocking for injection, then KVM would need to force an immediate exit
anyways since injecting multiple events is impossible.

However, because KVM copies int_state verbatim from vmcb02 to vmcb12, the
spurious STI shadow is visible to L1 when running a nested VM, which can
trip sanity checks, e.g. in VMware's VMM.

Hoist the STI+CLI all the way to C code, as the aforementioned calls to
guest_state_{enter,exit}_irqoff() already inform lockdep that IRQs are
enabled/disabled, and taking a fault on VMRUN with RFLAGS.IF=1 is already
possible.  I.e. if there's kernel code that is confused by running with
RFLAGS.IF=1, then it's already a problem.  In practice, since GIF=0 also
blocks NMIs, the only change in exposure to non-KVM code (relative to
surrounding VMRUN with STI+CLI) is exception handling code, and except for
the kvm_rebooting=1 case, all exception in the core VM-Enter/VM-Exit path
are fatal.

Use the "raw" variants to enable/disable IRQs to avoid tracing in the
"no instrumentation" code; the guest state helpers also take care of
tracing IRQ state.

Oppurtunstically document why KVM needs to do STI in the first place.

Reported-by: Doug Covelli <doug.covelli@broadcom.com>
Closes: https://lore.kernel.org/all/CADH9ctBs1YPmE4aCfGPNBwA10cA8RuAk2gO7542DjMZgs4uzJQ@mail.gmail.com
Fixes: f14eec0a3203 ("KVM: SVM: move more vmentry code to assembly")
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Link: https://lore.kernel.org/r/20250224165442.2338294-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a713c803a3a3..0d299f3f921e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4189,6 +4189,18 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 
 	guest_state_enter_irqoff();
 
+	/*
+	 * Set RFLAGS.IF prior to VMRUN, as the host's RFLAGS.IF at the time of
+	 * VMRUN controls whether or not physical IRQs are masked (KVM always
+	 * runs with V_INTR_MASKING_MASK).  Toggle RFLAGS.IF here to avoid the
+	 * temptation to do STI+VMRUN+CLI, as AMD CPUs bleed the STI shadow
+	 * into guest state if delivery of an event during VMRUN triggers a
+	 * #VMEXIT, and the guest_state transitions already tell lockdep that
+	 * IRQs are being enabled/disabled.  Note!  GIF=0 for the entirety of
+	 * this path, so IRQs aren't actually unmasked while running host code.
+	 */
+	raw_local_irq_enable();
+
 	amd_clear_divider();
 
 	if (sev_es_guest(vcpu->kvm))
@@ -4197,6 +4209,8 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 	else
 		__svm_vcpu_run(svm, spec_ctrl_intercepted);
 
+	raw_local_irq_disable();
+
 	guest_state_exit_irqoff();
 }
 
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 2ed80aea3bb1..0c61153b275f 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -170,12 +170,8 @@ SYM_FUNC_START(__svm_vcpu_run)
 	mov VCPU_RDI(%_ASM_DI), %_ASM_DI
 
 	/* Enter guest mode */
-	sti
-
 3:	vmrun %_ASM_AX
 4:
-	cli
-
 	/* Pop @svm to RAX while it's the only available register. */
 	pop %_ASM_AX
 
@@ -340,12 +336,8 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	mov KVM_VMCB_pa(%rax), %rax
 
 	/* Enter guest mode */
-	sti
-
 1:	vmrun %rax
-
-2:	cli
-
+2:
 	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
 	FILL_RETURN_BUFFER %rax, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VMEXIT
 


