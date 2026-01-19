Return-Path: <stable+bounces-210368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75792D3AEFF
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 16:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7602530056EE
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E631079B;
	Mon, 19 Jan 2026 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXOgSPhS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02531A552
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836508; cv=none; b=L5zQsQihUQ5k6YCkPv1m+RH1Y5BX5W+G3El6mzuJsAJI5hZAiElgdtIWRgLCsvU/z8msB/9wiPXzBMaNG0u53U6UBQCQ6wocwrspJV4RICZa9c1E0YQeec+sb8Lk4mD+l2uhCpkKFyixsb+B31SlUqiUIViNvSorgRxmsb/UZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836508; c=relaxed/simple;
	bh=3ay87AB2gZrWRPOoadEwgctZtTkxgqVtYA7IWc6thVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQ96CdOPua1N9yAMm+4GpijAy4c66JpIQbNFKiYVWlg3tixW1tUio6juFIyKX4zVyo6rB+za4Idia2/+NdjgwIryh/3catENu1D//+Vb4n+LrizHJNRjZHdpehWdN+WvPfYKAElkpdmyHqLx7/p1kI5vgZZOSGXn0mrddJKkhgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXOgSPhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE5AC116C6;
	Mon, 19 Jan 2026 15:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768836508;
	bh=3ay87AB2gZrWRPOoadEwgctZtTkxgqVtYA7IWc6thVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXOgSPhSOEu+Tfa2AHQr/Kj3ZZqZEvfVMYCf/5IssgWvVtvupXWM0CGwI/xyn0gm/
	 2TVUaY3b3OoE132A9+9AuYa/3AnmAl48nOxiujrYxyTG8m9X4IB435kRbdoxNbUUio
	 TVUssfOpgv0CgDoa3GjP4LX88PZOlKFjUIe7oFxh3+tcrbZx+YCn13ydRjaP1Q/ev6
	 ShBmi1rjR2LC1EuoR06mx+fMNwMq4yRtPFk2V5tMoEFa5gPKhIkGJs5rY+cgBmlf16
	 EK7/RfDSiRRLdH3jwl/EXG39HgBGV0CKbYf38DCvtLNj8AyiJx0ZyV90kN8CFCBfhi
	 EVWnFtxXSVBNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] x86/fpu: Clear XSTATE_BV[i] in guest XSAVE state whenever XFD[i]=1
Date: Mon, 19 Jan 2026 10:28:25 -0500
Message-ID: <20260119152825.3011564-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026011917-record-decorated-9020@gregkh>
References: <2026011917-record-decorated-9020@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit b45f721775947a84996deb5c661602254ce25ce6 ]

When loading guest XSAVE state via KVM_SET_XSAVE, and when updating XFD in
response to a guest WRMSR, clear XFD-disabled features in the saved (or to
be restored) XSTATE_BV to ensure KVM doesn't attempt to load state for
features that are disabled via the guest's XFD.  Because the kernel
executes XRSTOR with the guest's XFD, saving XSTATE_BV[i]=1 with XFD[i]=1
will cause XRSTOR to #NM and panic the kernel.

E.g. if fpu_update_guest_xfd() sets XFD without clearing XSTATE_BV:

  ------------[ cut here ]------------
  WARNING: arch/x86/kernel/traps.c:1524 at exc_device_not_available+0x101/0x110, CPU#29: amx_test/848
  Modules linked in: kvm_intel kvm irqbypass
  CPU: 29 UID: 1000 PID: 848 Comm: amx_test Not tainted 6.19.0-rc2-ffa07f7fd437-x86_amx_nm_xfd_non_init-vm #171 NONE
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:exc_device_not_available+0x101/0x110
  Call Trace:
   <TASK>
   asm_exc_device_not_available+0x1a/0x20
  RIP: 0010:restore_fpregs_from_fpstate+0x36/0x90
   switch_fpu_return+0x4a/0xb0
   kvm_arch_vcpu_ioctl_run+0x1245/0x1e40 [kvm]
   kvm_vcpu_ioctl+0x2c3/0x8f0 [kvm]
   __x64_sys_ioctl+0x8f/0xd0
   do_syscall_64+0x62/0x940
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>
  ---[ end trace 0000000000000000 ]---

This can happen if the guest executes WRMSR(MSR_IA32_XFD) to set XFD[18] = 1,
and a host IRQ triggers kernel_fpu_begin() prior to the vmexit handler's
call to fpu_update_guest_xfd().

and if userspace stuffs XSTATE_BV[i]=1 via KVM_SET_XSAVE:

  ------------[ cut here ]------------
  WARNING: arch/x86/kernel/traps.c:1524 at exc_device_not_available+0x101/0x110, CPU#14: amx_test/867
  Modules linked in: kvm_intel kvm irqbypass
  CPU: 14 UID: 1000 PID: 867 Comm: amx_test Not tainted 6.19.0-rc2-2dace9faccd6-x86_amx_nm_xfd_non_init-vm #168 NONE
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:exc_device_not_available+0x101/0x110
  Call Trace:
   <TASK>
   asm_exc_device_not_available+0x1a/0x20
  RIP: 0010:restore_fpregs_from_fpstate+0x36/0x90
   fpu_swap_kvm_fpstate+0x6b/0x120
   kvm_load_guest_fpu+0x30/0x80 [kvm]
   kvm_arch_vcpu_ioctl_run+0x85/0x1e40 [kvm]
   kvm_vcpu_ioctl+0x2c3/0x8f0 [kvm]
   __x64_sys_ioctl+0x8f/0xd0
   do_syscall_64+0x62/0x940
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>
  ---[ end trace 0000000000000000 ]---

The new behavior is consistent with the AMX architecture.  Per Intel's SDM,
XSAVE saves XSTATE_BV as '0' for components that are disabled via XFD
(and non-compacted XSAVE saves the initial configuration of the state
component):

  If XSAVE, XSAVEC, XSAVEOPT, or XSAVES is saving the state component i,
  the instruction does not generate #NM when XCR0[i] = IA32_XFD[i] = 1;
  instead, it operates as if XINUSE[i] = 0 (and the state component was
  in its initial state): it saves bit i of XSTATE_BV field of the XSAVE
  header as 0; in addition, XSAVE saves the initial configuration of the
  state component (the other instructions do not save state component i).

Alternatively, KVM could always do XRSTOR with XFD=0, e.g. by using
a constant XFD based on the set of enabled features when XSAVEing for
a struct fpu_guest.  However, having XSTATE_BV[i]=1 for XFD-disabled
features can only happen in the above interrupt case, or in similar
scenarios involving preemption on preemptible kernels, because
fpu_swap_kvm_fpstate()'s call to save_fpregs_to_fpstate() saves the
outgoing FPU state with the current XFD; and that is (on all but the
first WRMSR to XFD) the guest XFD.

Therefore, XFD can only go out of sync with XSTATE_BV in the above
interrupt case, or in similar scenarios involving preemption on
preemptible kernels, and it we can consider it (de facto) part of KVM
ABI that KVM_GET_XSAVE returns XSTATE_BV[i]=0 for XFD-disabled features.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 820a6ee944e7 ("kvm: x86: Add emulation for IA32_XFD", 2022-01-14)
Signed-off-by: Sean Christopherson <seanjc@google.com>
[Move clearing of XSTATE_BV from fpu_copy_uabi_to_guest_fpstate
 to kvm_vcpu_ioctl_x86_set_xsave. - Paolo]
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/fpu/core.c | 32 +++++++++++++++++++++++++++++---
 arch/x86/kvm/x86.c         |  9 +++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 175c14567cf14..75dad6e3c9840 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -294,10 +294,29 @@ EXPORT_SYMBOL_GPL(fpu_enable_guest_xfd_features);
 #ifdef CONFIG_X86_64
 void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd)
 {
+	struct fpstate *fpstate = guest_fpu->fpstate;
+
 	fpregs_lock();
-	guest_fpu->fpstate->xfd = xfd;
-	if (guest_fpu->fpstate->in_use)
-		xfd_update_state(guest_fpu->fpstate);
+
+	/*
+	 * KVM's guest ABI is that setting XFD[i]=1 *can* immediately revert the
+	 * save state to its initial configuration.  Likewise, KVM_GET_XSAVE does
+	 * the same as XSAVE and returns XSTATE_BV[i]=0 whenever XFD[i]=1.
+	 *
+	 * If the guest's FPU state is in hardware, just update XFD: the XSAVE
+	 * in fpu_swap_kvm_fpstate will clear XSTATE_BV[i] whenever XFD[i]=1.
+	 *
+	 * If however the guest's FPU state is NOT resident in hardware, clear
+	 * disabled components in XSTATE_BV now, or a subsequent XRSTOR will
+	 * attempt to load disabled components and generate #NM _in the host_.
+	 */
+	if (xfd && test_thread_flag(TIF_NEED_FPU_LOAD))
+		fpstate->regs.xsave.header.xfeatures &= ~xfd;
+
+	fpstate->xfd = xfd;
+	if (fpstate->in_use)
+		xfd_update_state(fpstate);
+
 	fpregs_unlock();
 }
 EXPORT_SYMBOL_GPL(fpu_update_guest_xfd);
@@ -405,6 +424,13 @@ int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
 	if (ustate->xsave.header.xfeatures & ~xcr0)
 		return -EINVAL;
 
+	/*
+	 * Disabled features must be in their initial state, otherwise XRSTOR
+	 * causes an exception.
+	 */
+	if (WARN_ON_ONCE(ustate->xsave.header.xfeatures & kstate->xfd))
+		return -EINVAL;
+
 	/*
 	 * Nullify @vpkru to preserve its current value if PKRU's bit isn't set
 	 * in the header.  KVM's odd ABI is to leave PKRU untouched in this
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8acaaa8f17b98..89df215ebf284 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5432,9 +5432,18 @@ static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
 static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 					struct kvm_xsave *guest_xsave)
 {
+	union fpregs_state *xstate = (union fpregs_state *)guest_xsave->region;
+
 	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
 		return 0;
 
+	/*
+	 * For backwards compatibility, do not expect disabled features to be in
+	 * their initial state.  XSTATE_BV[i] must still be cleared whenever
+	 * XFD[i]=1, or XRSTOR would cause a #NM.
+	 */
+	xstate->xsave.header.xfeatures &= ~vcpu->arch.guest_fpu.fpstate->xfd;
+
 	return fpu_copy_uabi_to_guest_fpstate(&vcpu->arch.guest_fpu,
 					      guest_xsave->region,
 					      kvm_caps.supported_xcr0,
-- 
2.51.0


