Return-Path: <stable+bounces-73859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3199706A1
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DF41C20BD3
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 10:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FE714D70F;
	Sun,  8 Sep 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a0BSzqJ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769961DDC9
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725791882; cv=none; b=Z3jMXG7kf4VMtLV1KF4EYiX3XKiZYF15R0OfBVNz5PZ820rJiHs98LdZFkkLFb6dOMfVeqFEUa+Qyb+z6GrZ07qpVTxC9vV6J9ev1dbCL9qULjE7x1etiz/SouLPnajT4QVuf5+XSUJgg1MloZDz8EdtN7zZrkChM7VdWqVjmpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725791882; c=relaxed/simple;
	bh=jvHeRechxj2xn/cwqW8YduPdXl1ZV01eF0eVfbKgi7E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KcP9W2TWiH7DWVdBZFB8AvsqIhug3olyfppcbcVpfxjzMLYj6bjSQoe2a3s1PbDdG6skgP3H8qlQdZxIhFHdzci52E4qdgT8JlXLu2be1CsU4pySZGzuUCO5D0zpi8v5XeISggm59WAhLBg0F6hztOv5JzIKcBgEP+LV8BnmMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a0BSzqJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EE7C4CEC3;
	Sun,  8 Sep 2024 10:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725791881;
	bh=jvHeRechxj2xn/cwqW8YduPdXl1ZV01eF0eVfbKgi7E=;
	h=Subject:To:Cc:From:Date:From;
	b=a0BSzqJ0WtsdhGkBMPvIGFBVbmsvpcBL9VOAmZ+Q0OlIiLYCRu2NYJqUQtOhOWkES
	 mr8VbjxZ90HYbdX5/kIyKrnVTChvRn9u+dvL/32IHR5xKA1CDWxb3ZXvcDCptfYWur
	 gLMSLDECouX9X5NBnfNF82VOR4Dt9+0WyTBSbGFo=
Subject: FAILED: patch "[PATCH] KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS" failed to apply to 5.15-stable tree
To: seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 12:37:51 +0200
Message-ID: <2024090850-handrail-battering-849f@gregkh>
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
git cherry-pick -x 4bcdd831d9d01e0fb64faea50732b59b2ee88da1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090850-handrail-battering-849f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

4bcdd831d9d0 ("KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4bcdd831d9d01e0fb64faea50732b59b2ee88da1 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 23 Jul 2024 16:20:55 -0700
Subject: [PATCH] KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS

Grab kvm->srcu when processing KVM_SET_VCPU_EVENTS, as KVM will forcibly
leave nested VMX/SVM if SMM mode is being toggled, and leaving nested VMX
reads guest memory.

Note, kvm_vcpu_ioctl_x86_set_vcpu_events() can also be called from KVM_RUN
via sync_regs(), which already holds SRCU.  I.e. trying to precisely use
kvm_vcpu_srcu_read_lock() around the problematic SMM code would cause
problems.  Acquiring SRCU isn't all that expensive, so for simplicity,
grab it unconditionally for KVM_SET_VCPU_EVENTS.

 =============================
 WARNING: suspicious RCU usage
 6.10.0-rc7-332d2c1d713e-next-vm #552 Not tainted
 -----------------------------
 include/linux/kvm_host.h:1027 suspicious rcu_dereference_check() usage!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 1 lock held by repro/1071:
  #0: ffff88811e424430 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x7d/0x970 [kvm]

 stack backtrace:
 CPU: 15 PID: 1071 Comm: repro Not tainted 6.10.0-rc7-332d2c1d713e-next-vm #552
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Call Trace:
  <TASK>
  dump_stack_lvl+0x7f/0x90
  lockdep_rcu_suspicious+0x13f/0x1a0
  kvm_vcpu_gfn_to_memslot+0x168/0x190 [kvm]
  kvm_vcpu_read_guest+0x3e/0x90 [kvm]
  nested_vmx_load_msr+0x6b/0x1d0 [kvm_intel]
  load_vmcs12_host_state+0x432/0xb40 [kvm_intel]
  vmx_leave_nested+0x30/0x40 [kvm_intel]
  kvm_vcpu_ioctl_x86_set_vcpu_events+0x15d/0x2b0 [kvm]
  kvm_arch_vcpu_ioctl+0x1107/0x1750 [kvm]
  ? mark_held_locks+0x49/0x70
  ? kvm_vcpu_ioctl+0x7d/0x970 [kvm]
  ? kvm_vcpu_ioctl+0x497/0x970 [kvm]
  kvm_vcpu_ioctl+0x497/0x970 [kvm]
  ? lock_acquire+0xba/0x2d0
  ? find_held_lock+0x2b/0x80
  ? do_user_addr_fault+0x40c/0x6f0
  ? lock_release+0xb7/0x270
  __x64_sys_ioctl+0x82/0xb0
  do_syscall_64+0x6c/0x170
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7ff11eb1b539
  </TASK>

Fixes: f7e570780efc ("KVM: x86: Forcibly leave nested virt when SMM state is toggled")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240723232055.3643811-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 70219e406987..2c7327ef0f0d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6040,7 +6040,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (copy_from_user(&events, argp, sizeof(struct kvm_vcpu_events)))
 			break;
 
+		kvm_vcpu_srcu_read_lock(vcpu);
 		r = kvm_vcpu_ioctl_x86_set_vcpu_events(vcpu, &events);
+		kvm_vcpu_srcu_read_unlock(vcpu);
 		break;
 	}
 	case KVM_GET_DEBUGREGS: {


