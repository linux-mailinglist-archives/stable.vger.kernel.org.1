Return-Path: <stable+bounces-100320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F1C9EAB41
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACA2164136
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A571230D3C;
	Tue, 10 Dec 2024 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rzmrC6Z3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2AB230D0D
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821521; cv=none; b=IiqT+fSxEbw8Wuh71AQQ95uftpQrT4cTPlvHDjRfimpj7zFyYZfTiz50KzlgBV2N4svzGqb0dfPUhvpoMIVDZF1//2mrToxYlKNSoOXpVbdLdgICCufXTxRXt2uwF95VEm7YY2T4W9dyoQI5Rer10InmMJMO6rXz/74qIPwc1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821521; c=relaxed/simple;
	bh=WTV1ozft81cROzUHQSn3/xOfcfq9q7HirPUOhWMARxg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HGuMh0ldCKkFW7XlCg5H7g5qegq0MRc5ChfXO4K+lF4Opblr2pPhhHIheNibpEpqc5Jwsvw/BBq9vv/4x8h1B2Sq4MBzOqVhrv3LAptm+cmLDLVS05DdM7LDX0uShAzvf7NmAmHT4buT1CtRJD+uZt4q5JMqoBYUrfoFQDyq1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rzmrC6Z3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C74C4CEE1;
	Tue, 10 Dec 2024 09:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733821521;
	bh=WTV1ozft81cROzUHQSn3/xOfcfq9q7HirPUOhWMARxg=;
	h=Subject:To:Cc:From:Date:From;
	b=rzmrC6Z3mUu9X6jlFcHkF7oKXLhCLrgURrAy9NKCUACpz/mLo/LhPJyonLO7eE0rJ
	 eR82nvJrNsc6D+ewcM8V0TZ6WEJ56apHTggSroAlrbtH6qh04Mh0T1nHQ0W0175fVZ
	 gr7lIlXw8M8bUvzHd5OReA57JTwYqNWh+OCOtItY=
Subject: FAILED: patch "[PATCH] LoongArch: KVM: Protect kvm_io_bus_{read,write}() with SRCU" failed to apply to 5.15-stable tree
To: chenhuacai@kernel.org,chenhuacai@loongson.cn,maobibo@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:04:39 +0100
Message-ID: <2024121039-gout-trillion-3df8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7f71507851fc7764b36a3221839607d3a45c2025
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121039-gout-trillion-3df8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f71507851fc7764b36a3221839607d3a45c2025 Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 3 Dec 2024 19:49:28 +0800
Subject: [PATCH] LoongArch: KVM: Protect kvm_io_bus_{read,write}() with SRCU

When we enable lockdep we get such a warning:

 =============================
 WARNING: suspicious RCU usage
 6.12.0-rc7+ #1891 Tainted: G        W
 -----------------------------
 arch/loongarch/kvm/../../../virt/kvm/kvm_main.c:5945 suspicious rcu_dereference_check() usage!
 other info that might help us debug this:
 rcu_scheduler_active = 2, debug_locks = 1
 1 lock held by qemu-system-loo/948:
  #0: 90000001184a00a8 (&vcpu->mutex){+.+.}-{4:4}, at: kvm_vcpu_ioctl+0xf4/0xe20 [kvm]
 stack backtrace:
 CPU: 2 UID: 0 PID: 948 Comm: qemu-system-loo Tainted: G        W          6.12.0-rc7+ #1891
 Tainted: [W]=WARN
 Hardware name: Loongson Loongson-3A5000-7A1000-1w-CRB/Loongson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.0-prebeta9 10/21/2022
 Stack : 0000000000000089 9000000005a0db9c 90000000071519c8 900000012c578000
         900000012c57b940 0000000000000000 900000012c57b948 9000000007e53788
         900000000815bcc8 900000000815bcc0 900000012c57b7b0 0000000000000001
         0000000000000001 4b031894b9d6b725 0000000005dec000 9000000100427b00
         00000000000003d2 0000000000000001 000000000000002d 0000000000000003
         0000000000000030 00000000000003b4 0000000005dec000 0000000000000000
         900000000806d000 9000000007e53788 00000000000000b4 0000000000000004
         0000000000000004 0000000000000000 0000000000000000 9000000107baf600
         9000000008916000 9000000007e53788 9000000005924778 000000001fe001e5
         00000000000000b0 0000000000000007 0000000000000000 0000000000071c1d
         ...
 Call Trace:
 [<9000000005924778>] show_stack+0x38/0x180
 [<90000000071519c4>] dump_stack_lvl+0x94/0xe4
 [<90000000059eb754>] lockdep_rcu_suspicious+0x194/0x240
 [<ffff80000221f47c>] kvm_io_bus_read+0x19c/0x1e0 [kvm]
 [<ffff800002225118>] kvm_emu_mmio_read+0xd8/0x440 [kvm]
 [<ffff8000022254bc>] kvm_handle_read_fault+0x3c/0xe0 [kvm]
 [<ffff80000222b3c8>] kvm_handle_exit+0x228/0x480 [kvm]

Fix it by protecting kvm_io_bus_{read,write}() with SRCU.

Cc: stable@vger.kernel.org
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index 69f3e3782cc9..a7893bd01e73 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -156,7 +156,7 @@ static int kvm_handle_csr(struct kvm_vcpu *vcpu, larch_inst inst)
 
 int kvm_emu_iocsr(larch_inst inst, struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	int ret;
+	int idx, ret;
 	unsigned long *val;
 	u32 addr, rd, rj, opcode;
 
@@ -167,7 +167,6 @@ int kvm_emu_iocsr(larch_inst inst, struct kvm_run *run, struct kvm_vcpu *vcpu)
 	rj = inst.reg2_format.rj;
 	opcode = inst.reg2_format.opcode;
 	addr = vcpu->arch.gprs[rj];
-	ret = EMULATE_DO_IOCSR;
 	run->iocsr_io.phys_addr = addr;
 	run->iocsr_io.is_write = 0;
 	val = &vcpu->arch.gprs[rd];
@@ -207,20 +206,28 @@ int kvm_emu_iocsr(larch_inst inst, struct kvm_run *run, struct kvm_vcpu *vcpu)
 	}
 
 	if (run->iocsr_io.is_write) {
-		if (!kvm_io_bus_write(vcpu, KVM_IOCSR_BUS, addr, run->iocsr_io.len, val))
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
+		ret = kvm_io_bus_write(vcpu, KVM_IOCSR_BUS, addr, run->iocsr_io.len, val);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
+		if (ret == 0)
 			ret = EMULATE_DONE;
-		else
+		else {
+			ret = EMULATE_DO_IOCSR;
 			/* Save data and let user space to write it */
 			memcpy(run->iocsr_io.data, val, run->iocsr_io.len);
-
+		}
 		trace_kvm_iocsr(KVM_TRACE_IOCSR_WRITE, run->iocsr_io.len, addr, val);
 	} else {
-		if (!kvm_io_bus_read(vcpu, KVM_IOCSR_BUS, addr, run->iocsr_io.len, val))
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
+		ret = kvm_io_bus_read(vcpu, KVM_IOCSR_BUS, addr, run->iocsr_io.len, val);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
+		if (ret == 0)
 			ret = EMULATE_DONE;
-		else
+		else {
+			ret = EMULATE_DO_IOCSR;
 			/* Save register id for iocsr read completion */
 			vcpu->arch.io_gpr = rd;
-
+		}
 		trace_kvm_iocsr(KVM_TRACE_IOCSR_READ, run->iocsr_io.len, addr, NULL);
 	}
 
@@ -359,7 +366,7 @@ static int kvm_handle_gspr(struct kvm_vcpu *vcpu)
 
 int kvm_emu_mmio_read(struct kvm_vcpu *vcpu, larch_inst inst)
 {
-	int ret;
+	int idx, ret;
 	unsigned int op8, opcode, rd;
 	struct kvm_run *run = vcpu->run;
 
@@ -464,8 +471,10 @@ int kvm_emu_mmio_read(struct kvm_vcpu *vcpu, larch_inst inst)
 		 * it need not return to user space to handle the mmio
 		 * exception.
 		 */
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		ret = kvm_io_bus_read(vcpu, KVM_MMIO_BUS, vcpu->arch.badv,
 				      run->mmio.len, &vcpu->arch.gprs[rd]);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		if (!ret) {
 			update_pc(&vcpu->arch);
 			vcpu->mmio_needed = 0;
@@ -531,7 +540,7 @@ int kvm_complete_mmio_read(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 int kvm_emu_mmio_write(struct kvm_vcpu *vcpu, larch_inst inst)
 {
-	int ret;
+	int idx, ret;
 	unsigned int rd, op8, opcode;
 	unsigned long curr_pc, rd_val = 0;
 	struct kvm_run *run = vcpu->run;
@@ -631,7 +640,9 @@ int kvm_emu_mmio_write(struct kvm_vcpu *vcpu, larch_inst inst)
 		 * it need not return to user space to handle the mmio
 		 * exception.
 		 */
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		ret = kvm_io_bus_write(vcpu, KVM_MMIO_BUS, vcpu->arch.badv, run->mmio.len, data);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		if (!ret)
 			return EMULATE_DONE;
 
diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
index a233a323e295..93f4acd44523 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -98,7 +98,7 @@ static void write_mailbox(struct kvm_vcpu *vcpu, int offset, uint64_t data, int
 
 static int send_ipi_data(struct kvm_vcpu *vcpu, gpa_t addr, uint64_t data)
 {
-	int i, ret;
+	int i, idx, ret;
 	uint32_t val = 0, mask = 0;
 
 	/*
@@ -107,7 +107,9 @@ static int send_ipi_data(struct kvm_vcpu *vcpu, gpa_t addr, uint64_t data)
 	 */
 	if ((data >> 27) & 0xf) {
 		/* Read the old val */
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		ret = kvm_io_bus_read(vcpu, KVM_IOCSR_BUS, addr, sizeof(val), &val);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		if (unlikely(ret)) {
 			kvm_err("%s: : read date from addr %llx failed\n", __func__, addr);
 			return ret;
@@ -121,7 +123,9 @@ static int send_ipi_data(struct kvm_vcpu *vcpu, gpa_t addr, uint64_t data)
 		val &= mask;
 	}
 	val |= ((uint32_t)(data >> 32) & ~mask);
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	ret = kvm_io_bus_write(vcpu, KVM_IOCSR_BUS, addr, sizeof(val), &val);
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 	if (unlikely(ret))
 		kvm_err("%s: : write date to addr %llx failed\n", __func__, addr);
 


