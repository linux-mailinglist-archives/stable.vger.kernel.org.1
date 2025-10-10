Return-Path: <stable+bounces-183967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0D6BCD2F3
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3FF74FDAE6
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26FC2F5A01;
	Fri, 10 Oct 2025 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dx+0/Vy1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF132F5473;
	Fri, 10 Oct 2025 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102496; cv=none; b=psolYt9Ff59v+RuvAlAOQc+GSBR6lM1I5Wlju56WnanV1luDRZZn4aids3+4ZyDBDuJzFlad+/VAo13xgYaIhHpfEJyLqiMlzeWpD/7QAR8rlJd08lfyF6SDUcipA9sFs/3a6h4fSswD6LJD7D+a2jYyHgevgtdXAcUmO9eJQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102496; c=relaxed/simple;
	bh=iNUCna3f8ZDM0uPrnDRbyRP/mONY6qbBxRKDWtQ5COc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHMYpmAme02PHcAqkl77LsTH0EK1N6EK8r1/EVcyoLhiEjqWzAQQqJwGfFlYgiraDZ81PDLWKIL5f4GpXlJCVtF8VRUvmfv72EGOaDK7hLRI2fmwock+l1RKtj7Aa6H+6RTY+/9QD70hRVVCL5kIoQco3uD75bbPMRjFEWEM1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dx+0/Vy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6803C4CEF1;
	Fri, 10 Oct 2025 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760102496;
	bh=iNUCna3f8ZDM0uPrnDRbyRP/mONY6qbBxRKDWtQ5COc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dx+0/Vy1gt3v1C0B51wHJOmHeGnDP5P+gK3S0/tdD7xrtyrIkLE6EBRRnMvAUjNVX
	 8XH6on9MkNe/do11Q7G2dFmnyQZzFB8aPDo/tv09PmnlftJXgJeoWBnxXlWyTOLU2k
	 5H4V3c1OUGz+xV77dKRzdPBsxYS3XviGEHWD7Se4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+cc2032ba16cc2018ca25@syzkaller.appspotmail.com,
	Jim Mattson <jmattson@google.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.12 35/35] KVM: x86: Dont (re)check L1 intercepts when completing userspace I/O
Date: Fri, 10 Oct 2025 15:16:37 +0200
Message-ID: <20251010131333.053656920@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010131331.785281312@linuxfoundation.org>
References: <20251010131331.785281312@linuxfoundation.org>
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

commit e750f85391286a4c8100275516973324b621a269 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/emulate.c     |    9 ++++-----
 arch/x86/kvm/kvm_emulate.h |    3 +--
 arch/x86/kvm/x86.c         |   15 ++++++++-------
 3 files changed, 13 insertions(+), 14 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5104,12 +5104,11 @@ void init_decode_cache(struct x86_emulat
 	ctxt->mem_read.end = 0;
 }
 
-int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
+int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts)
 {
 	const struct x86_emulate_ops *ops = ctxt->ops;
 	int rc = X86EMUL_CONTINUE;
 	int saved_dst_type = ctxt->dst.type;
-	bool is_guest_mode = ctxt->ops->is_guest_mode(ctxt);
 
 	ctxt->mem_read.pos = 0;
 
@@ -5157,7 +5156,7 @@ int x86_emulate_insn(struct x86_emulate_
 				fetch_possible_mmx_operand(&ctxt->dst);
 		}
 
-		if (unlikely(is_guest_mode) && ctxt->intercept) {
+		if (unlikely(check_intercepts) && ctxt->intercept) {
 			rc = emulator_check_intercept(ctxt, ctxt->intercept,
 						      X86_ICPT_PRE_EXCEPT);
 			if (rc != X86EMUL_CONTINUE)
@@ -5186,7 +5185,7 @@ int x86_emulate_insn(struct x86_emulate_
 				goto done;
 		}
 
-		if (unlikely(is_guest_mode) && (ctxt->d & Intercept)) {
+		if (unlikely(check_intercepts) && (ctxt->d & Intercept)) {
 			rc = emulator_check_intercept(ctxt, ctxt->intercept,
 						      X86_ICPT_POST_EXCEPT);
 			if (rc != X86EMUL_CONTINUE)
@@ -5240,7 +5239,7 @@ int x86_emulate_insn(struct x86_emulate_
 
 special_insn:
 
-	if (unlikely(is_guest_mode) && (ctxt->d & Intercept)) {
+	if (unlikely(check_intercepts) && (ctxt->d & Intercept)) {
 		rc = emulator_check_intercept(ctxt, ctxt->intercept,
 					      X86_ICPT_POST_MEMACCESS);
 		if (rc != X86EMUL_CONTINUE)
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -230,7 +230,6 @@ struct x86_emulate_ops {
 	void (*set_nmi_mask)(struct x86_emulate_ctxt *ctxt, bool masked);
 
 	bool (*is_smm)(struct x86_emulate_ctxt *ctxt);
-	bool (*is_guest_mode)(struct x86_emulate_ctxt *ctxt);
 	int (*leave_smm)(struct x86_emulate_ctxt *ctxt);
 	void (*triple_fault)(struct x86_emulate_ctxt *ctxt);
 	int (*set_xcr)(struct x86_emulate_ctxt *ctxt, u32 index, u64 xcr);
@@ -514,7 +513,7 @@ bool x86_page_table_writing_insn(struct
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
@@ -8567,11 +8567,6 @@ static bool emulator_is_smm(struct x86_e
 	return is_smm(emul_to_vcpu(ctxt));
 }
 
-static bool emulator_is_guest_mode(struct x86_emulate_ctxt *ctxt)
-{
-	return is_guest_mode(emul_to_vcpu(ctxt));
-}
-
 #ifndef CONFIG_KVM_SMM
 static int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 {
@@ -8655,7 +8650,6 @@ static const struct x86_emulate_ops emul
 	.guest_cpuid_is_intel_compatible = emulator_guest_cpuid_is_intel_compatible,
 	.set_nmi_mask        = emulator_set_nmi_mask,
 	.is_smm              = emulator_is_smm,
-	.is_guest_mode       = emulator_is_guest_mode,
 	.leave_smm           = emulator_leave_smm,
 	.triple_fault        = emulator_triple_fault,
 	.set_xcr             = emulator_set_xcr,
@@ -9209,7 +9203,14 @@ restart:
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



