Return-Path: <stable+bounces-186479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0354BE9A7E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610BD740627
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13813328F2;
	Fri, 17 Oct 2025 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGvBlgpt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2303328EE;
	Fri, 17 Oct 2025 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713357; cv=none; b=KZxK/uSipCyuzA+cHoDAezQJgEXGcun1DfUANjwf3cGNfcboUASx1TEgSFdzEqpwxrPIcxK2yqG8fIfgh+M26uqazhzCg/QrizvtiqcOMz8JU/KT2/llzztczboHsB0cNPw3g4KNYvC6X9wTIiQm67N+auKbzQiK604tmkAn7IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713357; c=relaxed/simple;
	bh=UPmKGknb+K7BifERug2FX2igtQrkzVmiJACqiRUs7K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbfIYIMUkz4IbpOpjbjOFykVUrx2tnjDYQgBXfYfri/x9+GAUPEKEjR6teD1KZKrk0dL0bpor2NPtGz3bf5DoO5VL64gkWS48Z0Y53RQlUXcrzp408w9/pTMvdoW+HG4py3BdJF7ARdiud7Zemk7GjW7Mbf3wRAXMMGKxYLSE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGvBlgpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FB8C4CEE7;
	Fri, 17 Oct 2025 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713357;
	bh=UPmKGknb+K7BifERug2FX2igtQrkzVmiJACqiRUs7K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGvBlgptboY60Hb6/igyeqPvr2p3rLJlSdYiLpQpkUE2C1+bD9Qxrj2elCc+fdhBJ
	 DWZRdYd32oU42WplHrlOwVFHR28PM/mf5eARt5dKpwzl4mWttB/5VDsxy4lpABLeVX
	 Z3Tu3ecGSi7B783gglA01+MyFkQosJzhATzZdEUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+cc2032ba16cc2018ca25@syzkaller.appspotmail.com,
	Jim Mattson <jmattson@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 138/168] KVM: x86: Dont (re)check L1 intercepts when completing userspace I/O
Date: Fri, 17 Oct 2025 16:53:37 +0200
Message-ID: <20251017145134.113541006@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
References: <20251017145129.000176255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/emulate.c     |   11 ++++-------
 arch/x86/kvm/kvm_emulate.h |    2 +-
 arch/x86/kvm/x86.c         |    9 ++++++++-
 3 files changed, 13 insertions(+), 9 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5478,12 +5478,11 @@ void init_decode_cache(struct x86_emulat
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
 
@@ -5497,8 +5496,6 @@ int x86_emulate_insn(struct x86_emulate_
 		rc = emulate_ud(ctxt);
 		goto done;
 	}
-
-	emul_flags = ctxt->ops->get_hflags(ctxt);
 	if (unlikely(ctxt->d &
 		     (No64|Undefined|Sse|Mmx|Intercept|CheckPerm|Priv|Prot|String))) {
 		if ((ctxt->mode == X86EMUL_MODE_PROT64 && (ctxt->d & No64)) ||
@@ -5532,7 +5529,7 @@ int x86_emulate_insn(struct x86_emulate_
 				fetch_possible_mmx_operand(&ctxt->dst);
 		}
 
-		if (unlikely(emul_flags & X86EMUL_GUEST_MASK) && ctxt->intercept) {
+		if (unlikely(check_intercepts) && ctxt->intercept) {
 			rc = emulator_check_intercept(ctxt, ctxt->intercept,
 						      X86_ICPT_PRE_EXCEPT);
 			if (rc != X86EMUL_CONTINUE)
@@ -5561,7 +5558,7 @@ int x86_emulate_insn(struct x86_emulate_
 				goto done;
 		}
 
-		if (unlikely(emul_flags & X86EMUL_GUEST_MASK) && (ctxt->d & Intercept)) {
+		if (unlikely(check_intercepts) && (ctxt->d & Intercept)) {
 			rc = emulator_check_intercept(ctxt, ctxt->intercept,
 						      X86_ICPT_POST_EXCEPT);
 			if (rc != X86EMUL_CONTINUE)
@@ -5615,7 +5612,7 @@ int x86_emulate_insn(struct x86_emulate_
 
 special_insn:
 
-	if (unlikely(emul_flags & X86EMUL_GUEST_MASK) && (ctxt->d & Intercept)) {
+	if (unlikely(check_intercepts) && (ctxt->d & Intercept)) {
 		rc = emulator_check_intercept(ctxt, ctxt->intercept,
 					      X86_ICPT_POST_MEMACCESS);
 		if (rc != X86EMUL_CONTINUE)
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -517,7 +517,7 @@ bool x86_page_table_writing_insn(struct
 #define EMULATION_RESTART 1
 #define EMULATION_INTERCEPTED 2
 void init_decode_cache(struct x86_emulate_ctxt *ctxt);
-int x86_emulate_insn(struct x86_emulate_ctxt *ctxt);
+int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts);
 int emulator_task_switch(struct x86_emulate_ctxt *ctxt,
 			 u16 tss_selector, int idt_index, int reason,
 			 bool has_error_code, u32 error_code);
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8976,7 +8976,14 @@ restart:
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



