Return-Path: <stable+bounces-96079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C503F9E0641
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9992814E5
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D9A2040A7;
	Mon,  2 Dec 2024 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YGQIAqXv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BC61D545
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151979; cv=none; b=bPQKsF1YCfdvq5jUZ4I5TpMI9Ye+IM3NyTnQ9RNgYjMhAQO/KlLq784Ftb91sPytaNaE4s22/s8OZiaEv+PqA8vzDUipHKfktSfkpLDDKQH5mW4QIBSzPjY2sNxzqW6ibq0ZByCJXfiev6xjdHo3vzKOGRDOiTFdwQD6UMPxfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151979; c=relaxed/simple;
	bh=kt/au7if1j2wxE+aH/e3X+cOHJ4aamTIiaU2l8r5jH0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HO6znR6p9KtChKJyA78nFYSJfzpQeJBO3/dJiHRt6w6VErEqlyAUN9gScpF0dgsiK1Fal8LAQpGX0gdeg2lLjhvpW0w/+e7Pkm7H8SNycz7UPCJ9ohua69Q4R+GkUMRs9cLlGnvRbmnsEh3ZQjDb17q5yRaN1wc+ZYOrPoj8d4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YGQIAqXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C841C4CED1;
	Mon,  2 Dec 2024 15:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733151979;
	bh=kt/au7if1j2wxE+aH/e3X+cOHJ4aamTIiaU2l8r5jH0=;
	h=Subject:To:Cc:From:Date:From;
	b=YGQIAqXvVS4N1haIcafjuMKgdLow2jekg9ABbQXc3QneRiE8lb2Usi+zlz6IVYD7y
	 VDNPcRuFf0cgrDHhx2Z31AKKpKQMDq3TCjOrRtqPGLcf7KTvVoaaOagpNNWyjkwn6L
	 UPW1fnbwR8K4isAEqunfihb6YL22Vvd7IdAJ6RxA=
Subject: FAILED: patch "[PATCH] KVM: arm64: Don't retire aborted MMIO instruction" failed to apply to 6.1-stable tree
To: oliver.upton@linux.dev,glider@google.com,maz@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 16:06:07 +0100
Message-ID: <2024120207-banker-blast-f652@gregkh>
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
git cherry-pick -x e735a5da64420a86be370b216c269b5dd8e830e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120207-banker-blast-f652@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e735a5da64420a86be370b216c269b5dd8e830e2 Mon Sep 17 00:00:00 2001
From: Oliver Upton <oliver.upton@linux.dev>
Date: Fri, 25 Oct 2024 20:31:03 +0000
Subject: [PATCH] KVM: arm64: Don't retire aborted MMIO instruction

Returning an abort to the guest for an unsupported MMIO access is a
documented feature of the KVM UAPI. Nevertheless, it's clear that this
plumbing has seen limited testing, since userspace can trivially cause a
WARN in the MMIO return:

  WARNING: CPU: 0 PID: 30558 at arch/arm64/include/asm/kvm_emulate.h:536 kvm_handle_mmio_return+0x46c/0x5c4 arch/arm64/include/asm/kvm_emulate.h:536
  Call trace:
   kvm_handle_mmio_return+0x46c/0x5c4 arch/arm64/include/asm/kvm_emulate.h:536
   kvm_arch_vcpu_ioctl_run+0x98/0x15b4 arch/arm64/kvm/arm.c:1133
   kvm_vcpu_ioctl+0x75c/0xa78 virt/kvm/kvm_main.c:4487
   __do_sys_ioctl fs/ioctl.c:51 [inline]
   __se_sys_ioctl fs/ioctl.c:893 [inline]
   __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:893
   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
   invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
   el0_svc_common+0x1e0/0x23c arch/arm64/kernel/syscall.c:132
   do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
   el0_svc+0x38/0x68 arch/arm64/kernel/entry-common.c:712
   el0t_64_sync_handler+0x90/0xfc arch/arm64/kernel/entry-common.c:730
   el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

The splat is complaining that KVM is advancing PC while an exception is
pending, i.e. that KVM is retiring the MMIO instruction despite a
pending synchronous external abort. Womp womp.

Fix the glaring UAPI bug by skipping over all the MMIO emulation in
case there is a pending synchronous exception. Note that while userspace
is capable of pending an asynchronous exception (SError, IRQ, or FIQ),
it is still safe to retire the MMIO instruction in this case as (1) they
are by definition asynchronous, and (2) KVM relies on hardware support
for pending/delivering these exceptions instead of the software state
machine for advancing PC.

Cc: stable@vger.kernel.org
Fixes: da345174ceca ("KVM: arm/arm64: Allow user injection of external data aborts")
Reported-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20241025203106.3529261-2-oliver.upton@linux.dev
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
index cd6b7b83e2c3..ab365e839874 100644
--- a/arch/arm64/kvm/mmio.c
+++ b/arch/arm64/kvm/mmio.c
@@ -72,6 +72,31 @@ unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len)
 	return data;
 }
 
+static bool kvm_pending_sync_exception(struct kvm_vcpu *vcpu)
+{
+	if (!vcpu_get_flag(vcpu, PENDING_EXCEPTION))
+		return false;
+
+	if (vcpu_el1_is_32bit(vcpu)) {
+		switch (vcpu_get_flag(vcpu, EXCEPT_MASK)) {
+		case unpack_vcpu_flag(EXCEPT_AA32_UND):
+		case unpack_vcpu_flag(EXCEPT_AA32_IABT):
+		case unpack_vcpu_flag(EXCEPT_AA32_DABT):
+			return true;
+		default:
+			return false;
+		}
+	} else {
+		switch (vcpu_get_flag(vcpu, EXCEPT_MASK)) {
+		case unpack_vcpu_flag(EXCEPT_AA64_EL1_SYNC):
+		case unpack_vcpu_flag(EXCEPT_AA64_EL2_SYNC):
+			return true;
+		default:
+			return false;
+		}
+	}
+}
+
 /**
  * kvm_handle_mmio_return -- Handle MMIO loads after user space emulation
  *			     or in-kernel IO emulation
@@ -84,8 +109,11 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
 	unsigned int len;
 	int mask;
 
-	/* Detect an already handled MMIO return */
-	if (unlikely(!vcpu->mmio_needed))
+	/*
+	 * Detect if the MMIO return was already handled or if userspace aborted
+	 * the MMIO access.
+	 */
+	if (unlikely(!vcpu->mmio_needed || kvm_pending_sync_exception(vcpu)))
 		return 1;
 
 	vcpu->mmio_needed = 0;


