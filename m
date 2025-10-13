Return-Path: <stable+bounces-184872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C74BD443E
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A483188257C
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369E730AD10;
	Mon, 13 Oct 2025 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="17Y6RYod"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1826F2B6;
	Mon, 13 Oct 2025 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368678; cv=none; b=TP1g+ETFu1rk6OiaMRJX83vOgE7d4EG+2UCHJolL4Zv519xVJPhAVF1YHUWOmXZH2mfDpeb5BkBwP+DZJwhcVcBErccLCFzqiMOjQ3BkosHmkiUqMk3I08PCxlDdF93Z5N1YrcpA3aRiE2pvJ9Ur/Or37ere7InrWot9uYx0eRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368678; c=relaxed/simple;
	bh=2bTBrIJJ46mdcT2DGtbFI6VGcKZZyFMkC26EU8pZckI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIF0432nVrHxYrf2xJaSEhtw7p1mvMLk3Wnvm7hFZb/TBNPXs7XSek8ihv0OXPg3oWJeA6BKwRvetnnEvFfUcsn40GGcofrZSvGJTEePYVqKLNoLu2aIjH8gHOO0nVfAUim99KZ3JNsCKRWAkxH1WTn/OTeFhviiTwapssJbfiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=17Y6RYod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBFEC4CEFE;
	Mon, 13 Oct 2025 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368677;
	bh=2bTBrIJJ46mdcT2DGtbFI6VGcKZZyFMkC26EU8pZckI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=17Y6RYodPx8avSqcbI9FKzl6g7oCedYNCKVY3QyrV+AAkEL16QzzgXq8a8qU+hH05
	 hMRw6kae7ptKx9jAJAwuDNDciPEYtHQoFISUJ0vZt6gj3JZFcxN3WaRMd9GMNNzkDC
	 lcuCxyAyG+yicr/o4sKJWHDkMswHDCUUPl7P3LI8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.12 243/262] KVM: SVM: Skip fastpath emulation on VM-Exit if next RIP isnt valid
Date: Mon, 13 Oct 2025 16:46:25 +0200
Message-ID: <20251013144334.988919932@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 0910dd7c9ad45a2605c45fd2bf3d1bcac087687c upstream.

Skip the WRMSR and HLT fastpaths in SVM's VM-Exit handler if the next RIP
isn't valid, e.g. because KVM is running with nrips=false.  SVM must
decode and emulate to skip the instruction if the CPU doesn't provide the
next RIP, and getting the instruction bytes to decode requires reading
guest memory.  Reading guest memory through the emulator can fault, i.e.
can sleep, which is disallowed since the fastpath handlers run with IRQs
disabled.

 BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:106
 in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 32611, name: qemu
 preempt_count: 1, expected: 0
 INFO: lockdep is turned off.
 irq event stamp: 30580
 hardirqs last  enabled at (30579): [<ffffffffc08b2527>] vcpu_run+0x1787/0x1db0 [kvm]
 hardirqs last disabled at (30580): [<ffffffffb4f62e32>] __schedule+0x1e2/0xed0
 softirqs last  enabled at (30570): [<ffffffffb4247a64>] fpu_swap_kvm_fpstate+0x44/0x210
 softirqs last disabled at (30568): [<ffffffffb4247a64>] fpu_swap_kvm_fpstate+0x44/0x210
 CPU: 298 UID: 0 PID: 32611 Comm: qemu Tainted: G     U              6.16.0-smp--e6c618b51cfe-sleep #782 NONE
 Tainted: [U]=USER
 Hardware name: Google Astoria-Turin/astoria, BIOS 0.20241223.2-0 01/17/2025
 Call Trace:
  <TASK>
  dump_stack_lvl+0x7d/0xb0
  __might_resched+0x271/0x290
  __might_fault+0x28/0x80
  kvm_vcpu_read_guest_page+0x8d/0xc0 [kvm]
  kvm_fetch_guest_virt+0x92/0xc0 [kvm]
  __do_insn_fetch_bytes+0xf3/0x1e0 [kvm]
  x86_decode_insn+0xd1/0x1010 [kvm]
  x86_emulate_instruction+0x105/0x810 [kvm]
  __svm_skip_emulated_instruction+0xc4/0x140 [kvm_amd]
  handle_fastpath_invd+0xc4/0x1a0 [kvm]
  vcpu_run+0x11a1/0x1db0 [kvm]
  kvm_arch_vcpu_ioctl_run+0x5cc/0x730 [kvm]
  kvm_vcpu_ioctl+0x578/0x6a0 [kvm]
  __se_sys_ioctl+0x6d/0xb0
  do_syscall_64+0x8a/0x2c0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7f479d57a94b
  </TASK>

Note, this is essentially a reapply of commit 5c30e8101e8d ("KVM: SVM:
Skip WRMSR fastpath on VM-Exit if next RIP isn't valid"), but with
different justification (KVM now grabs SRCU when skipping the instruction
for other reasons).

Fixes: b439eb8ab578 ("Revert "KVM: SVM: Skip WRMSR fastpath on VM-Exit if next RIP isn't valid"")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250805190526.1453366-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/svm.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4237,13 +4237,21 @@ static int svm_vcpu_pre_run(struct kvm_v
 static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb_control_area *control = &svm->vmcb->control;
+
+	/*
+	 * Next RIP must be provided as IRQs are disabled, and accessing guest
+	 * memory to decode the instruction might fault, i.e. might sleep.
+	 */
+	if (!nrips || !control->next_rip)
+		return EXIT_FASTPATH_NONE;
 
 	if (is_guest_mode(vcpu))
 		return EXIT_FASTPATH_NONE;
 
-	switch (svm->vmcb->control.exit_code) {
+	switch (control->exit_code) {
 	case SVM_EXIT_MSR:
-		if (!svm->vmcb->control.exit_info_1)
+		if (!control->exit_info_1)
 			break;
 		return handle_fastpath_set_msr_irqoff(vcpu);
 	case SVM_EXIT_HLT:



