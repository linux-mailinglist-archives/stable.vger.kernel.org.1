Return-Path: <stable+bounces-143169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD4BAB331B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCF9189D9C0
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2731E25B69A;
	Mon, 12 May 2025 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fRA2em8i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18925B1FA
	for <stable@vger.kernel.org>; Mon, 12 May 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041702; cv=none; b=KLofanOd/hr6OtuNm2JnLytRyWZJJ1W8bsvN7BKLrhLE/V+4EoeREgkXbGfCjfc5+c1hfNsuBYGxKtQd4Du9L5guwTdGQz79TvZCfDrTQzuwzkn2og0+sDAhOLOD7TsmbimCxLNoKCz3TkUjJc3+j5LBzw5/NIE2xzsLxuOJlQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041702; c=relaxed/simple;
	bh=6ybE+07orvOmNn8hR396ZlvynxXPBsmLg4H9dP5E+uo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZWCAk2FuOSQaefqyTLpZQmTxthKrklVHa3531/GmTz2RzrasmxfOl1qF/kpFwefoxYuiXMHLxjD02cCzJac96CsIMCE4SUso3wmxahPol+eg7ss3FTlRxeBddroU2y1B1lkYIJvWLe8gkmlKPDFgr5cDz4foo3uNiftbnLGYOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fRA2em8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638FBC4CEE9;
	Mon, 12 May 2025 09:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747041702;
	bh=6ybE+07orvOmNn8hR396ZlvynxXPBsmLg4H9dP5E+uo=;
	h=Subject:To:Cc:From:Date:From;
	b=fRA2em8iACsX9CLfxOfTg9R0klnrD5pUY/kcrzDNz8Lo/JofbeGZhCWHj/avPc5vU
	 okkuMiijHsCdu2sT0SB7QNqsnA4BMYjpJgctFRxO+pIzNzvkWJEX+PqSUjMMBXULGW
	 taI2dXR37/3uSW6q2yhfYaBcSYtYYTNK3wizay5g=
Subject: FAILED: patch "[PATCH] KVM: SVM: Forcibly leave SMM mode on SHUTDOWN interception" failed to apply to 6.1-stable tree
To: m.lobanov@rosa.ru,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 11:21:32 +0200
Message-ID: <2025051231-surpass-scone-a484@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a2620f8932fa9fdabc3d78ed6efb004ca409019f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051231-surpass-scone-a484@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2620f8932fa9fdabc3d78ed6efb004ca409019f Mon Sep 17 00:00:00 2001
From: Mikhail Lobanov <m.lobanov@rosa.ru>
Date: Mon, 14 Apr 2025 20:12:06 +0300
Subject: [PATCH] KVM: SVM: Forcibly leave SMM mode on SHUTDOWN interception

Previously, commit ed129ec9057f ("KVM: x86: forcibly leave nested mode
on vCPU reset") addressed an issue where a triple fault occurring in
nested mode could lead to use-after-free scenarios. However, the commit
did not handle the analogous situation for System Management Mode (SMM).

This omission results in triggering a WARN when KVM forces a vCPU INIT
after SHUTDOWN interception while the vCPU is in SMM. This situation was
reprodused using Syzkaller by:

  1) Creating a KVM VM and vCPU
  2) Sending a KVM_SMI ioctl to explicitly enter SMM
  3) Executing invalid instructions causing consecutive exceptions and
     eventually a triple fault

The issue manifests as follows:

  WARNING: CPU: 0 PID: 25506 at arch/x86/kvm/x86.c:12112
  kvm_vcpu_reset+0x1d2/0x1530 arch/x86/kvm/x86.c:12112
  Modules linked in:
  CPU: 0 PID: 25506 Comm: syz-executor.0 Not tainted
  6.1.130-syzkaller-00157-g164fe5dde9b6 #0
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
  BIOS 1.12.0-1 04/01/2014
  RIP: 0010:kvm_vcpu_reset+0x1d2/0x1530 arch/x86/kvm/x86.c:12112
  Call Trace:
   <TASK>
   shutdown_interception+0x66/0xb0 arch/x86/kvm/svm/svm.c:2136
   svm_invoke_exit_handler+0x110/0x530 arch/x86/kvm/svm/svm.c:3395
   svm_handle_exit+0x424/0x920 arch/x86/kvm/svm/svm.c:3457
   vcpu_enter_guest arch/x86/kvm/x86.c:10959 [inline]
   vcpu_run+0x2c43/0x5a90 arch/x86/kvm/x86.c:11062
   kvm_arch_vcpu_ioctl_run+0x50f/0x1cf0 arch/x86/kvm/x86.c:11283
   kvm_vcpu_ioctl+0x570/0xf00 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4122
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:870 [inline]
   __se_sys_ioctl fs/ioctl.c:856 [inline]
   __x64_sys_ioctl+0x19a/0x210 fs/ioctl.c:856
   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
   do_syscall_64+0x35/0x80 arch/x86/entry/common.c:81
   entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Architecturally, INIT is blocked when the CPU is in SMM, hence KVM's WARN()
in kvm_vcpu_reset() to guard against KVM bugs, e.g. to detect improper
emulation of INIT.  SHUTDOWN on SVM is a weird edge case where KVM needs to
do _something_ sane with the VMCB, since it's technically undefined, and
INIT is the least awful choice given KVM's ABI.

So, double down on stuffing INIT on SHUTDOWN, and force the vCPU out of
SMM to avoid any weirdness (and the WARN).

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: ed129ec9057f ("KVM: x86: forcibly leave nested mode on vCPU reset")
Cc: stable@vger.kernel.org
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
Link: https://lore.kernel.org/r/20250414171207.155121-1-m.lobanov@rosa.ru
[sean: massage changelog, make it clear this isn't architectural behavior]
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 699e551ec93b..9864c057187d 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -131,6 +131,7 @@ void kvm_smm_changed(struct kvm_vcpu *vcpu, bool entering_smm)
 
 	kvm_mmu_reset_context(vcpu);
 }
+EXPORT_SYMBOL_GPL(kvm_smm_changed);
 
 void process_smi(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d5d0c5c3300b..c5470d842aed 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2231,6 +2231,10 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
 	 */
 	if (!sev_es_guest(vcpu->kvm)) {
 		clear_page(svm->vmcb);
+#ifdef CONFIG_KVM_SMM
+		if (is_smm(vcpu))
+			kvm_smm_changed(vcpu, false);
+#endif
 		kvm_vcpu_reset(vcpu, true);
 	}
 


