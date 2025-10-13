Return-Path: <stable+bounces-184741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0788CBD4A6D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68C305015C9
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F3F30C610;
	Mon, 13 Oct 2025 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uO/8wLJ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2410A2FF642
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368303; cv=none; b=Jn2zPVeAqChsGlClGzf8OzulOn3868x3IaQzbgI2pvLBDz5u9XW8vFp6YA/CQ/RI6WRnb30vhU5+2mo5OsH6lH3pD0lD8xJNgIzRCHe5AM0PUGTL3H8YYXC3JT0ot9Sd1PSFYA81ksdYKLPp7o75KoQq2/xhSj0jSIpjZCr4oPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368303; c=relaxed/simple;
	bh=Vm1mwbp59LdzZ9OFbFKl+sLTDRpySWkcCDczY030Uws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sT/CQ/XEcKmlb0r4HtvcwffftIBhsYQr0esQRTRXnqSZk6uZ+Pp2Uh2xXlgjALUg+kuHeSMsD0cIdesK2GAmHCy7BZocq5u4CBDzkHYZO4hTvKjeuMDy6g1sqg8m82fS7s2SVBtGPkwunDnt2xlhZYxxbnlzCUAmH+stbhCGLS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uO/8wLJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C2AC4CEFE;
	Mon, 13 Oct 2025 15:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760368302;
	bh=Vm1mwbp59LdzZ9OFbFKl+sLTDRpySWkcCDczY030Uws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uO/8wLJ4p3kCOOsHSRvP1RzwBGn1ZwbXG3EQ5TWBbgJTqhm9HVFVaijy1Vc+iKgRO
	 O3fV56JvvoVos3QlWVUVX5pu0wrtDDP2/davwwzKH7MqnRkp8pgOPFM44P9HPNlF4N
	 rr8ocrtYYEApUH2HLOJWmgxoGZspGV9GzOfWL5ltCrPvqZOWn6cR/dOzLlzzYhkmpg
	 gBoUklzkWGXVVkFu5DZ+LR3cxK6LC7pWqsIA78L+UKq5KIoiIaNnSDX+Mb/PuzeB9w
	 G5gBcdh/hBvrEe3txPG5hyk20tUXOX9CjAPNkBym4/M8mVbZtcqJUP0IHRUvAI8C72
	 mQduXo7a/YfFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	syzbot+cc2032ba16cc2018ca25@syzkaller.appspotmail.com,
	Jim Mattson <jmattson@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: x86: Don't (re)check L1 intercepts when completing userspace I/O
Date: Mon, 13 Oct 2025 11:11:40 -0400
Message-ID: <20251013151140.3383954-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101005-married-company-a3fc@gregkh>
References: <2025101005-married-company-a3fc@gregkh>
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
index 4a43261d25a2a..0cb97e570f63e 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5478,12 +5478,11 @@ void init_decode_cache(struct x86_emulate_ctxt *ctxt)
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
 
@@ -5497,8 +5496,6 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 		rc = emulate_ud(ctxt);
 		goto done;
 	}
-
-	emul_flags = ctxt->ops->get_hflags(ctxt);
 	if (unlikely(ctxt->d &
 		     (No64|Undefined|Sse|Mmx|Intercept|CheckPerm|Priv|Prot|String))) {
 		if ((ctxt->mode == X86EMUL_MODE_PROT64 && (ctxt->d & No64)) ||
@@ -5532,7 +5529,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 				fetch_possible_mmx_operand(&ctxt->dst);
 		}
 
-		if (unlikely(emul_flags & X86EMUL_GUEST_MASK) && ctxt->intercept) {
+		if (unlikely(check_intercepts) && ctxt->intercept) {
 			rc = emulator_check_intercept(ctxt, ctxt->intercept,
 						      X86_ICPT_PRE_EXCEPT);
 			if (rc != X86EMUL_CONTINUE)
@@ -5561,7 +5558,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 				goto done;
 		}
 
-		if (unlikely(emul_flags & X86EMUL_GUEST_MASK) && (ctxt->d & Intercept)) {
+		if (unlikely(check_intercepts) && (ctxt->d & Intercept)) {
 			rc = emulator_check_intercept(ctxt, ctxt->intercept,
 						      X86_ICPT_POST_EXCEPT);
 			if (rc != X86EMUL_CONTINUE)
@@ -5615,7 +5612,7 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 
 special_insn:
 
-	if (unlikely(emul_flags & X86EMUL_GUEST_MASK) && (ctxt->d & Intercept)) {
+	if (unlikely(check_intercepts) && (ctxt->d & Intercept)) {
 		rc = emulator_check_intercept(ctxt, ctxt->intercept,
 					      X86_ICPT_POST_MEMACCESS);
 		if (rc != X86EMUL_CONTINUE)
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 89246446d6aa9..034cafba2cc62 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -517,7 +517,7 @@ bool x86_page_table_writing_insn(struct x86_emulate_ctxt *ctxt);
 #define EMULATION_RESTART 1
 #define EMULATION_INTERCEPTED 2
 void init_decode_cache(struct x86_emulate_ctxt *ctxt);
-int x86_emulate_insn(struct x86_emulate_ctxt *ctxt);
+int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts);
 int emulator_task_switch(struct x86_emulate_ctxt *ctxt,
 			 u16 tss_selector, int idt_index, int reason,
 			 bool has_error_code, u32 error_code);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 11ca05d830e72..b349e1fbf9dbc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8976,7 +8976,14 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
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


