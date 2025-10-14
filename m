Return-Path: <stable+bounces-185687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55972BDA228
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 16:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0355F4EEDDA
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489C72F99AD;
	Tue, 14 Oct 2025 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd/2qPLw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0562585260
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453334; cv=none; b=Hnv+pjd5seZ0NeNw0fyhK4NnjP+U1LOOTkjtaahKqH3dJmbTvIbwwJuz8ZJ5MdBFm1XKasNcd9yrFohvV3hz3wClepKPzOBDVbI+U+7Z3JyJbkNHI54Va28iCSagv6oHIzbm7MvrfpPxrVb9o3bCQgvmaitpbzhtUlyDAozmXK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453334; c=relaxed/simple;
	bh=LFuZpYBQ50U0IvLcJ8sX1Y5NqtpuzTIS4lbRyyErb0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODnUJjxoUKwF81ASerAXSI6SFmVng/+TpM2j97+apSgAZn4J3B/8Fa1+vRp0xq13I3yjoWK33kX6nrWwlaIM96Jq2CuEDLLk1C7ycWVVhHMxpUVujLHTM2Un2ubOdSG7a6/8yO83EHCWgTEXct7/DITjer+nBia3SDAV1wjcsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd/2qPLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDEAC4CEE7;
	Tue, 14 Oct 2025 14:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760453333;
	bh=LFuZpYBQ50U0IvLcJ8sX1Y5NqtpuzTIS4lbRyyErb0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nd/2qPLw9IAEmAnt0hbpyAOO/d6pDx44V5r6vpmQzePUArZcHIYHZieA3wC94jQsz
	 ayKaqpJy4X7XFopVTnolJyxl2wxq9CWM+3AI2A/U319LBq5quwM8qFf+TxltmH+7/B
	 Gax1lGxJv2aV5bkepFo5pmKhwkcXbOsH9mYsQeNm5e861o3khbX4EOZ8ER3gOZuYS3
	 dI6mAa3HFedTgF8CV8/GVkBDWiE5kz1UNq/4AjASudfBK0S9Yw21Da3JwzxHEyw1gQ
	 o8LyGc7KDeohDRWdNx3zeihKM75mISKiuCWbcPcRqVagMSxge9IWVseuQ6+p4BMzwV
	 IkzgUiu7aJVyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] KVM: SVM: Skip fastpath emulation on VM-Exit if next RIP isn't valid
Date: Tue, 14 Oct 2025 10:48:51 -0400
Message-ID: <20251014144851.94249-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101348-gigahertz-cauterize-0303@gregkh>
References: <2025101348-gigahertz-cauterize-0303@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 0910dd7c9ad45a2605c45fd2bf3d1bcac087687c ]

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
[ adapted switch-based MSR/HLT fastpath to if-based MSR-only check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 29566e457ec4b..0833f2c1a9d68 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4156,11 +4156,20 @@ static int svm_vcpu_pre_run(struct kvm_vcpu *vcpu)
 
 static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	/*
+	 * Next RIP must be provided as IRQs are disabled, and accessing guest
+	 * memory to decode the instruction might fault, i.e. might sleep.
+	 */
+	if (!nrips || !svm->vmcb->control.next_rip)
+		return EXIT_FASTPATH_NONE;
+
 	if (is_guest_mode(vcpu))
 		return EXIT_FASTPATH_NONE;
 
-	if (to_svm(vcpu)->vmcb->control.exit_code == SVM_EXIT_MSR &&
-	    to_svm(vcpu)->vmcb->control.exit_info_1)
+	if (svm->vmcb->control.exit_code == SVM_EXIT_MSR &&
+	    svm->vmcb->control.exit_info_1)
 		return handle_fastpath_set_msr_irqoff(vcpu);
 
 	return EXIT_FASTPATH_NONE;
-- 
2.51.0


