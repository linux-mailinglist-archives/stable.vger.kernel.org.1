Return-Path: <stable+bounces-195397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D49E6C76003
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id EEB9F2915F
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6B1368DF3;
	Thu, 20 Nov 2025 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQwpKyFK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998D368DEF
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665632; cv=none; b=WaO9HWVg3+Fvj1PYUgJ1Bts5yWPOEbU0nGSt0DMWDh4Hs13GcGmflROeSX79DSuPxzq2mjEIDnRGIOJOS9mUa2r+6k97fD1c/Hy6ANaBuxGZxxuP3CiW26DM2wBhCThZIKOX0eE4M7uj6EawVpawymtGEcWYsN5q5cvIObaoC+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665632; c=relaxed/simple;
	bh=epueMM9R6gWJI4ZlzKOWTn74vNXZitAK18N7PRgVdgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3/S6QuF7cbodJ3pCJ7BgYo4KLnp+3kDS83gSINdxBI0uTgoP6B8hzNM8eaHNFjQSgiEh8EZ8jBza6Jih3gdgvF6QCNSanhMI1xFYKQKXCpqqalGkNJngsLJc9rrS4BtxGR8ytCVf32+Gkdut7DY/R2eH8GXSjsWT6p7bDK9CUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQwpKyFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F691C116B1;
	Thu, 20 Nov 2025 19:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763665632;
	bh=epueMM9R6gWJI4ZlzKOWTn74vNXZitAK18N7PRgVdgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQwpKyFK5TNTbVADFsoy4Ygn5DH9isMPHZSNB9U7nebX5QZC9idiBXcRVmwh6Xayl
	 H5trtqgx7J/qFCbEpXz/Df51scqTgAn3KSnoV+2mTZ+GdSJFGHHy1x91Hs/wp6SUyD
	 tdZ+hZBUYX7Ro5KDui1mPp71Mfspw3f5wrNEnapoPdevSZhf7nGxUQ+RSY2SQk0N9r
	 XqUyNHUs7r2/fwFiYU/0+qmYMAcf43X9odhqd/spMioI9N7VAQgwFJUU3VwKDhDGEP
	 SUd/nwYW7OrKTUWmv1wuSSNkLY25kENKwViMZ7vLFRwkR2qBOu4p+Y5jrsPsEPr14D
	 WhlQdZh+r7nBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xin Li <xin@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/3] KVM: x86: Add support for RDMSR/WRMSRNS w/ immediate on Intel
Date: Thu, 20 Nov 2025 14:07:06 -0500
Message-ID: <20251120190708.2275081-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120190708.2275081-1-sashal@kernel.org>
References: <2025112027-ranch-retool-efaa@gregkh>
 <20251120190708.2275081-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Li <xin@zytor.com>

[ Upstream commit 885df2d2109a60f84d84639ce6d95a91045f6c45 ]

Add support for the immediate forms of RDMSR and WRMSRNS (currently
Intel-only).  The immediate variants are only valid in 64-bit mode, and
use a single general purpose register for the data (the register is also
encoded in the instruction, i.e. not implicit like regular RDMSR/WRMSR).

The immediate variants are primarily motivated by performance, not code
size: by having the MSR index in an immediate, it is available *much*
earlier in the CPU pipeline, which allows hardware much more leeway about
how a particular MSR is handled.

Intel VMX support for the immediate forms of MSR accesses communicates
exit information to the host as follows:

  1) The immediate form of RDMSR uses VM-Exit Reason 84.

  2) The immediate form of WRMSRNS uses VM-Exit Reason 85.

  3) For both VM-Exit reasons 84 and 85, the Exit Qualification field is
     set to the MSR index that triggered the VM-Exit.

  4) Bits 3 ~ 6 of the VM-Exit Instruction Information field are set to
     the register encoding used by the immediate form of the instruction,
     i.e. the destination register for RDMSR, and the source for WRMSRNS.

  5) The VM-Exit Instruction Length field records the size of the
     immediate form of the MSR instruction.

To deal with userspace RDMSR exits, stash the destination register in a
new kvm_vcpu_arch field, similar to cui_linear_rip, pio, etc.
Alternatively, the register could be saved in kvm_run.msr or re-retrieved
from the VMCS, but the former would require sanitizing the value to ensure
userspace doesn't clobber the value to an out-of-bounds index, and the
latter would require a new one-off kvm_x86_ops hook.

Don't bother adding support for the instructions in KVM's emulator, as the
only way for RDMSR/WRMSR to be encountered is if KVM is emulating large
swaths of code due to invalid guest state, and a vCPU cannot have invalid
guest state while in 64-bit mode.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
[sean: minor tweaks, massage and expand changelog]
Link: https://lore.kernel.org/r/20250805202224.1475590-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: 9d7dfb95da2c ("KVM: VMX: Inject #UD if guest tries to execute SEAMCALL or TDCALL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  3 ++
 arch/x86/include/uapi/asm/vmx.h |  6 +++-
 arch/x86/kvm/vmx/nested.c       | 13 ++++++--
 arch/x86/kvm/vmx/vmx.c          | 21 +++++++++++++
 arch/x86/kvm/vmx/vmx.h          |  5 +++
 arch/x86/kvm/x86.c              | 55 +++++++++++++++++++++++++++------
 6 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a35ee44ec70ad..7e87e7d9ba5ae 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -926,6 +926,7 @@ struct kvm_vcpu_arch {
 	bool emulate_regs_need_sync_from_vcpu;
 	int (*complete_userspace_io)(struct kvm_vcpu *vcpu);
 	unsigned long cui_linear_rip;
+	int cui_rdmsr_imm_reg;
 
 	gpa_t time;
 	s8  pvclock_tsc_shift;
@@ -2155,7 +2156,9 @@ int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data, bool host_initiat
 int kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data);
 int kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data);
 int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu);
+int kvm_emulate_rdmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
 int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu);
+int kvm_emulate_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
 int kvm_emulate_as_nop(struct kvm_vcpu *vcpu);
 int kvm_emulate_invd(struct kvm_vcpu *vcpu);
 int kvm_emulate_mwait(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/include/uapi/asm/vmx.h b/arch/x86/include/uapi/asm/vmx.h
index f0f4a4cf84a72..9792e329343e8 100644
--- a/arch/x86/include/uapi/asm/vmx.h
+++ b/arch/x86/include/uapi/asm/vmx.h
@@ -94,6 +94,8 @@
 #define EXIT_REASON_BUS_LOCK            74
 #define EXIT_REASON_NOTIFY              75
 #define EXIT_REASON_TDCALL              77
+#define EXIT_REASON_MSR_READ_IMM        84
+#define EXIT_REASON_MSR_WRITE_IMM       85
 
 #define VMX_EXIT_REASONS \
 	{ EXIT_REASON_EXCEPTION_NMI,         "EXCEPTION_NMI" }, \
@@ -158,7 +160,9 @@
 	{ EXIT_REASON_TPAUSE,                "TPAUSE" }, \
 	{ EXIT_REASON_BUS_LOCK,              "BUS_LOCK" }, \
 	{ EXIT_REASON_NOTIFY,                "NOTIFY" }, \
-	{ EXIT_REASON_TDCALL,                "TDCALL" }
+	{ EXIT_REASON_TDCALL,                "TDCALL" }, \
+	{ EXIT_REASON_MSR_READ_IMM,          "MSR_READ_IMM" }, \
+	{ EXIT_REASON_MSR_WRITE_IMM,         "MSR_WRITE_IMM" }
 
 #define VMX_EXIT_REASON_FLAGS \
 	{ VMX_EXIT_REASONS_FAILED_VMENTRY,	"FAILED_VMENTRY" }
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b8ea1969113df..4e6352ef95201 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6216,19 +6216,26 @@ static bool nested_vmx_exit_handled_msr(struct kvm_vcpu *vcpu,
 					struct vmcs12 *vmcs12,
 					union vmx_exit_reason exit_reason)
 {
-	u32 msr_index = kvm_rcx_read(vcpu);
+	u32 msr_index;
 	gpa_t bitmap;
 
 	if (!nested_cpu_has(vmcs12, CPU_BASED_USE_MSR_BITMAPS))
 		return true;
 
+	if (exit_reason.basic == EXIT_REASON_MSR_READ_IMM ||
+	    exit_reason.basic == EXIT_REASON_MSR_WRITE_IMM)
+		msr_index = vmx_get_exit_qual(vcpu);
+	else
+		msr_index = kvm_rcx_read(vcpu);
+
 	/*
 	 * The MSR_BITMAP page is divided into four 1024-byte bitmaps,
 	 * for the four combinations of read/write and low/high MSR numbers.
 	 * First we need to figure out which of the four to use:
 	 */
 	bitmap = vmcs12->msr_bitmap;
-	if (exit_reason.basic == EXIT_REASON_MSR_WRITE)
+	if (exit_reason.basic == EXIT_REASON_MSR_WRITE ||
+	    exit_reason.basic == EXIT_REASON_MSR_WRITE_IMM)
 		bitmap += 2048;
 	if (msr_index >= 0xc0000000) {
 		msr_index -= 0xc0000000;
@@ -6527,6 +6534,8 @@ static bool nested_vmx_l1_wants_exit(struct kvm_vcpu *vcpu,
 		return nested_cpu_has2(vmcs12, SECONDARY_EXEC_DESC);
 	case EXIT_REASON_MSR_READ:
 	case EXIT_REASON_MSR_WRITE:
+	case EXIT_REASON_MSR_READ_IMM:
+	case EXIT_REASON_MSR_WRITE_IMM:
 		return nested_vmx_exit_handled_msr(vcpu, vmcs12, exit_reason);
 	case EXIT_REASON_INVALID_STATE:
 		return true;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index aa157fe5b7b31..4d1af365f5845 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6003,6 +6003,23 @@ static int handle_notify(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static int vmx_get_msr_imm_reg(struct kvm_vcpu *vcpu)
+{
+	return vmx_get_instr_info_reg(vmcs_read32(VMX_INSTRUCTION_INFO));
+}
+
+static int handle_rdmsr_imm(struct kvm_vcpu *vcpu)
+{
+	return kvm_emulate_rdmsr_imm(vcpu, vmx_get_exit_qual(vcpu),
+				     vmx_get_msr_imm_reg(vcpu));
+}
+
+static int handle_wrmsr_imm(struct kvm_vcpu *vcpu)
+{
+	return kvm_emulate_wrmsr_imm(vcpu, vmx_get_exit_qual(vcpu),
+				     vmx_get_msr_imm_reg(vcpu));
+}
+
 /*
  * The exit handlers return 1 if the exit was handled fully and guest execution
  * may resume.  Otherwise they set the kvm_run parameter to indicate what needs
@@ -6061,6 +6078,8 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[EXIT_REASON_ENCLS]		      = handle_encls,
 	[EXIT_REASON_BUS_LOCK]                = handle_bus_lock_vmexit,
 	[EXIT_REASON_NOTIFY]		      = handle_notify,
+	[EXIT_REASON_MSR_READ_IMM]            = handle_rdmsr_imm,
+	[EXIT_REASON_MSR_WRITE_IMM]           = handle_wrmsr_imm,
 };
 
 static const int kvm_vmx_max_exit_handlers =
@@ -6495,6 +6514,8 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 #ifdef CONFIG_MITIGATION_RETPOLINE
 	if (exit_reason.basic == EXIT_REASON_MSR_WRITE)
 		return kvm_emulate_wrmsr(vcpu);
+	else if (exit_reason.basic == EXIT_REASON_MSR_WRITE_IMM)
+		return handle_wrmsr_imm(vcpu);
 	else if (exit_reason.basic == EXIT_REASON_PREEMPTION_TIMER)
 		return handle_preemption_timer(vcpu);
 	else if (exit_reason.basic == EXIT_REASON_INTERRUPT_WINDOW)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index d3389baf3ab3d..24d65dac5e897 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -706,6 +706,11 @@ static inline bool vmx_guest_state_valid(struct kvm_vcpu *vcpu)
 
 void dump_vmcs(struct kvm_vcpu *vcpu);
 
+static inline int vmx_get_instr_info_reg(u32 vmx_instr_info)
+{
+	return (vmx_instr_info >> 3) & 0xf;
+}
+
 static inline int vmx_get_instr_info_reg2(u32 vmx_instr_info)
 {
 	return (vmx_instr_info >> 28) & 0xf;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f98b801d9efdf..0bfab634c5912 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1997,6 +1997,15 @@ static int complete_fast_rdmsr(struct kvm_vcpu *vcpu)
 	return complete_fast_msr_access(vcpu);
 }
 
+static int complete_fast_rdmsr_imm(struct kvm_vcpu *vcpu)
+{
+	if (!vcpu->run->msr.error)
+		kvm_register_write(vcpu, vcpu->arch.cui_rdmsr_imm_reg,
+				   vcpu->run->msr.data);
+
+	return complete_fast_msr_access(vcpu);
+}
+
 static u64 kvm_msr_reason(int r)
 {
 	switch (r) {
@@ -2031,39 +2040,53 @@ static int kvm_msr_user_space(struct kvm_vcpu *vcpu, u32 index,
 	return 1;
 }
 
-int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
+static int __kvm_emulate_rdmsr(struct kvm_vcpu *vcpu, u32 msr, int reg,
+			       int (*complete_rdmsr)(struct kvm_vcpu *))
 {
-	u32 msr = kvm_rcx_read(vcpu);
 	u64 data;
 	int r;
 
 	r = kvm_get_msr_with_filter(vcpu, msr, &data);
-
 	if (!r) {
 		trace_kvm_msr_read(msr, data);
 
-		kvm_rax_write(vcpu, data & -1u);
-		kvm_rdx_write(vcpu, (data >> 32) & -1u);
+		if (reg < 0) {
+			kvm_rax_write(vcpu, data & -1u);
+			kvm_rdx_write(vcpu, (data >> 32) & -1u);
+		} else {
+			kvm_register_write(vcpu, reg, data);
+		}
 	} else {
 		/* MSR read failed? See if we should ask user space */
 		if (kvm_msr_user_space(vcpu, msr, KVM_EXIT_X86_RDMSR, 0,
-				       complete_fast_rdmsr, r))
+				       complete_rdmsr, r))
 			return 0;
 		trace_kvm_msr_read_ex(msr);
 	}
 
 	return kvm_x86_call(complete_emulated_msr)(vcpu, r);
 }
+
+int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
+{
+	return __kvm_emulate_rdmsr(vcpu, kvm_rcx_read(vcpu), -1,
+				   complete_fast_rdmsr);
+}
 EXPORT_SYMBOL_GPL(kvm_emulate_rdmsr);
 
-int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
+int kvm_emulate_rdmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg)
+{
+	vcpu->arch.cui_rdmsr_imm_reg = reg;
+
+	return __kvm_emulate_rdmsr(vcpu, msr, reg, complete_fast_rdmsr_imm);
+}
+EXPORT_SYMBOL_GPL(kvm_emulate_rdmsr_imm);
+
+static int __kvm_emulate_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
-	u32 msr = kvm_rcx_read(vcpu);
-	u64 data = kvm_read_edx_eax(vcpu);
 	int r;
 
 	r = kvm_set_msr_with_filter(vcpu, msr, data);
-
 	if (!r) {
 		trace_kvm_msr_write(msr, data);
 	} else {
@@ -2079,8 +2102,20 @@ int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
 
 	return kvm_x86_call(complete_emulated_msr)(vcpu, r);
 }
+
+int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
+{
+	return __kvm_emulate_wrmsr(vcpu, kvm_rcx_read(vcpu),
+				   kvm_read_edx_eax(vcpu));
+}
 EXPORT_SYMBOL_GPL(kvm_emulate_wrmsr);
 
+int kvm_emulate_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg)
+{
+	return __kvm_emulate_wrmsr(vcpu, msr, kvm_register_read(vcpu, reg));
+}
+EXPORT_SYMBOL_GPL(kvm_emulate_wrmsr_imm);
+
 int kvm_emulate_as_nop(struct kvm_vcpu *vcpu)
 {
 	return kvm_skip_emulated_instruction(vcpu);
-- 
2.51.0


