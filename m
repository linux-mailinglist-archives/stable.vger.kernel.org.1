Return-Path: <stable+bounces-185491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ACBBD59B4
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 19:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C413B6561
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0640523AB90;
	Mon, 13 Oct 2025 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBphuOda"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB6C2BB1D
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377909; cv=none; b=p11FdUKKvA2YDEuejDIeu212siPGZnpNExiDG8dUcqckUAPm3fy7lIh0gxZzKyVtJ5BpCjwiqLZfNlohlOaz5YnRAqcQojJHx93UBsTRgiYq+qfS8eXCgdQXX7OLavAQkI0kdqFFWSs59Fy9eP20u8NLniX9RRY+cgiWl10PerM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377909; c=relaxed/simple;
	bh=1D3qHC8rhZtArQFDabNBJy1Afyi9Rh9uZNyEESAwpNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPdrPOpCFtmVzdFoTWUJ5mumjzgwtNf+xX/OsKAPWrI1HzbbpIYOEpCZS2FHYJZo7l1p7eVuGKZmvCCo6Ql4kQwItZNXJIHjvQsvEX0xxz9ZNiHQkBDWnjeV7aVEsMmvb0dffuzi2mmS397b/JJ5CmFYeVgiuRSVhhX3AxhKql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBphuOda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD144C4CEE7;
	Mon, 13 Oct 2025 17:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377909;
	bh=1D3qHC8rhZtArQFDabNBJy1Afyi9Rh9uZNyEESAwpNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBphuOdaU1qMB1GeOR/qqfKoL3m9uQU5ih/8Xsy2YAF4KPXl07q3O2XxUgz2rE5fq
	 0ORdzpFCTeixhNsApm/KTDRjxCMh6tjN5xf8gR8bNmpBvbJHKpI8Czng0vRwV6fN1W
	 8I2g8KOO/M7W/tsDxgkVzRO1MziqwxMW72nYLR+u4sUjfqaNDHZxNPdZQWpbG6WdZV
	 ffz7udFPxNMpvSSHSg87i6P9Fw+EZ2audsACI+h8Q5nexvEOJYi2EHA+8rMMYop44L
	 c0N5N9ENsJBP0UmELeVvYnWZGNf1hoY5O36XmWvDn29sWaum6er7P3PhdhYi8yMDJB
	 Ujk9UoSkjAgTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	syzbot+cc2032ba16cc2018ca25@syzkaller.appspotmail.com,
	Jim Mattson <jmattson@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KVM: x86: Don't (re)check L1 intercepts when completing userspace I/O
Date: Mon, 13 Oct 2025 13:51:46 -0400
Message-ID: <20251013175146.3408710-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101007-proving-plating-9bc7@gregkh>
References: <2025101007-proving-plating-9bc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit e750f85391286a4c8100275516973324b621a269 ]

When completing emulation of instruction that generated a userspace exit
for I/O, don't recheck L1 intercepts as KVM has already finished that
phase of instruction execution, i.e. has already committed to allowing L2
to perform I/O.  If L1 (or host userspace) modifies the I/O permission
bitmaps during the exit to userspace,  KVM will treat the access as being
intercepted despite already having emulated the I/O access.

Pivot on EMULTYPE_NO_DECODE to detect that KVM is completing emulation.
Of the three users of EMULTYPE_NO_DECODE, only complete_emulated_io() (the
intended "recipient") can reach the code in question.  gp_interception()'s
use is mutually exclusive with is_guest_mode(), and
complete_emulated_insn_gp() unconditionally pairs EMULTYPE_NO_DECODE with
EMULTYPE_SKIP.

The bad behavior was detected by a syzkaller program that toggles port I/O
interception during the userspace I/O exit, ultimately resulting in a WARN
on vcpu->arch.pio.count being non-zero due to KVM no completing emulation
of the I/O instruction.

  WARNING: CPU: 23 PID: 1083 at arch/x86/kvm/x86.c:8039 emulator_pio_in_out+0x154/0x170 [kvm]
  Modules linked in: kvm_intel kvm irqbypass
  CPU: 23 UID: 1000 PID: 1083 Comm: repro Not tainted 6.16.0-rc5-c1610d2d66b1-next-vm #74 NONE
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:emulator_pio_in_out+0x154/0x170 [kvm]
  PKRU: 55555554
  Call Trace:
   <TASK>
   kvm_fast_pio+0xd6/0x1d0 [kvm]
   vmx_handle_exit+0x149/0x610 [kvm_intel]
   kvm_arch_vcpu_ioctl_run+0xda8/0x1ac0 [kvm]
   kvm_vcpu_ioctl+0x244/0x8c0 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0x5d/0xc60
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>

Reported-by: syzbot+cc2032ba16cc2018ca25@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68790db4.a00a0220.3af5df.0020.GAE@google.com
Fixes: 8a76d7f25f8f ("KVM: x86: Add x86 callback for intercept check")
Cc: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Link: https://lore.kernel.org/r/20250715190638.1899116-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ is_guest_mode() was open coded ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/emulate.c     | 11 ++++-------
 arch/x86/kvm/kvm_emulate.h |  2 +-
 arch/x86/kvm/x86.c         |  9 ++++++++-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 56750febf4604..b828c0c8a74ba 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5544,12 +5544,11 @@ void init_decode_cache(struct x86_emulate_ctxt *ctxt)
 	ctxt->mem_read.end = 0;
 }
 
-int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
+int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts)
 {
 	const struct x86_emulate_ops *ops = ctxt->ops;
 	int rc = X86EMUL_CONTINUE;
 	int saved_dst_type = ctxt->dst.type;
-	unsigned emul_flags;
 
 	ctxt->mem_read.pos = 0;
 
@@ -5563,8 +5562,6 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 		rc = emulate_ud(ctxt);
 		goto done;
 	}
-
-	emul_flags = ctxt->ops->get_hflags(ctxt);
 	if (unlikely(ctxt->d &
 		     (No64|Undefined|Sse|Mmx|Intercept|CheckPerm|Priv|Prot|String))) {
 		if ((ctxt->mode == X86EMUL_MODE_PROT64 && (ctxt->d & No64)) ||
@@ -5598,7 +5595,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 				fetch_possible_mmx_operand(&ctxt->dst);
 		}
 
-		if (unlikely(emul_flags & X86EMUL_GUEST_MASK) && ctxt->intercept) {
+		if (unlikely(check_intercepts) && ctxt->intercept) {
 			rc = emulator_check_intercept(ctxt, ctxt->intercept,
 						      X86_ICPT_PRE_EXCEPT);
 			if (rc != X86EMUL_CONTINUE)
@@ -5627,7 +5624,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 				goto done;
 		}
 
-		if (unlikely(emul_flags & X86EMUL_GUEST_MASK) && (ctxt->d & Intercept)) {
+		if (unlikely(check_intercepts) && (ctxt->d & Intercept)) {
 			rc = emulator_check_intercept(ctxt, ctxt->intercept,
 						      X86_ICPT_POST_EXCEPT);
 			if (rc != X86EMUL_CONTINUE)
@@ -5681,7 +5678,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 
 special_insn:
 
-	if (unlikely(emul_flags & X86EMUL_GUEST_MASK) && (ctxt->d & Intercept)) {
+	if (unlikely(check_intercepts) && (ctxt->d & Intercept)) {
 		rc = emulator_check_intercept(ctxt, ctxt->intercept,
 					      X86_ICPT_POST_MEMACCESS);
 		if (rc != X86EMUL_CONTINUE)
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index aeed6da60e0c7..8435baa936ad5 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -499,7 +499,7 @@ bool x86_page_table_writing_insn(struct x86_emulate_ctxt *ctxt);
 #define EMULATION_RESTART 1
 #define EMULATION_INTERCEPTED 2
 void init_decode_cache(struct x86_emulate_ctxt *ctxt);
-int x86_emulate_insn(struct x86_emulate_ctxt *ctxt);
+int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts);
 int emulator_task_switch(struct x86_emulate_ctxt *ctxt,
 			 u16 tss_selector, int idt_index, int reason,
 			 bool has_error_code, u32 error_code);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4150dfe421c1f..f82c4653800de 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7668,7 +7668,14 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		ctxt->exception.address = 0;
 	}
 
-	r = x86_emulate_insn(ctxt);
+	/*
+	 * Check L1's instruction intercepts when emulating instructions for
+	 * L2, unless KVM is re-emulating a previously decoded instruction,
+	 * e.g. to complete userspace I/O, in which case KVM has already
+	 * checked the intercepts.
+	 */
+	r = x86_emulate_insn(ctxt, is_guest_mode(vcpu) &&
+				   !(emulation_type & EMULTYPE_NO_DECODE));
 
 	if (r == EMULATION_INTERCEPTED)
 		return 1;
-- 
2.51.0


