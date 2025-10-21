Return-Path: <stable+bounces-188675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCC6BF88FF
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 22:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1DB3AC45B
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE8E275B1A;
	Tue, 21 Oct 2025 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gDqm0JER"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4B24A047;
	Tue, 21 Oct 2025 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077161; cv=none; b=prNbUxkUjwQryXQQcoXDuony0yDD4EoCO0ZcJS+rQj2Vxbz0K77jI70y26GMrrTGxYO+HlWiPQC+mdJ38+tUWkEH+E8XHsiSy/jaJPNHgCRcRcMao4ZgRu958qRF1oow3O43bxoAIt17pm1c79GJsR6xevB1OQKxQ7+XIDdDr8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077161; c=relaxed/simple;
	bh=f4Zr7FeIm2c0siCCGP8SCLaAlC5HLIukXa9PnCiqUM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prx3GBNHkNtwA/GXhHvWDDBXURI7gzGQ6SFEyBI5J1jNDk3HnSHaCzUszSsVQQrPprIUXC+yQp0RLAfOZP/RkMqt1XwRn6Fug64HtqVUCosbTskZX7LF1z1muDI28rrbmfQ1zhbt15NUs+m9NNbTRTkT/3CaPuB0vFeKY0Y6cFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gDqm0JER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB023C4CEF1;
	Tue, 21 Oct 2025 20:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761077161;
	bh=f4Zr7FeIm2c0siCCGP8SCLaAlC5HLIukXa9PnCiqUM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDqm0JERzXiaJy3yVF2r745WuVsIOsZudWpSuF92LFJsc3nn1Wx4AS9xRF1svkLEk
	 pvmZ8qT54M/R8/eDBvE4ytmL2IcxehCV0ngGFRLbWkaqfvvc6Gu7aXpf+YSItFcodQ
	 0tBgjJ6BLDORdI+2FnTF7quL6G19yyoT4+QxVrMI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.17 019/159] KVM: arm64: Prevent access to vCPU events before init
Date: Tue, 21 Oct 2025 21:49:56 +0200
Message-ID: <20251021195043.648609618@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021195043.182511864@linuxfoundation.org>
References: <20251021195043.182511864@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Upton <oliver.upton@linux.dev>

commit 0aa1b76fe1429629215a7c79820e4b96233ac4a3 upstream.

Another day, another syzkaller bug. KVM erroneously allows userspace to
pend vCPU events for a vCPU that hasn't been initialized yet, leading to
KVM interpreting a bunch of uninitialized garbage for routing /
injecting the exception.

In one case the injection code and the hyp disagree on whether the vCPU
has a 32bit EL1 and put the vCPU into an illegal mode for AArch64,
tripping the BUG() in exception_target_el() during the next injection:

  kernel BUG at arch/arm64/kvm/inject_fault.c:40!
  Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
  CPU: 3 UID: 0 PID: 318 Comm: repro Not tainted 6.17.0-rc4-00104-g10fd0285305d #6 PREEMPT
  Hardware name: linux,dummy-virt (DT)
  pstate: 21402009 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
  pc : exception_target_el+0x88/0x8c
  lr : pend_serror_exception+0x18/0x13c
  sp : ffff800082f03a10
  x29: ffff800082f03a10 x28: ffff0000cb132280 x27: 0000000000000000
  x26: 0000000000000000 x25: ffff0000c2a99c20 x24: 0000000000000000
  x23: 0000000000008000 x22: 0000000000000002 x21: 0000000000000004
  x20: 0000000000008000 x19: ffff0000c2a99c20 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000 x15: 00000000200000c0
  x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
  x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
  x8 : ffff800082f03af8 x7 : 0000000000000000 x6 : 0000000000000000
  x5 : ffff800080f621f0 x4 : 0000000000000000 x3 : 0000000000000000
  x2 : 000000000040009b x1 : 0000000000000003 x0 : ffff0000c2a99c20
  Call trace:
   exception_target_el+0x88/0x8c (P)
   kvm_inject_serror_esr+0x40/0x3b4
   __kvm_arm_vcpu_set_events+0xf0/0x100
   kvm_arch_vcpu_ioctl+0x180/0x9d4
   kvm_vcpu_ioctl+0x60c/0x9f4
   __arm64_sys_ioctl+0xac/0x104
   invoke_syscall+0x48/0x110
   el0_svc_common.constprop.0+0x40/0xe0
   do_el0_svc+0x1c/0x28
   el0_svc+0x34/0xf0
   el0t_64_sync_handler+0xa0/0xe4
   el0t_64_sync+0x198/0x19c
  Code: f946bc01 b4fffe61 9101e020 17fffff2 (d4210000)

Reject the ioctls outright as no sane VMM would call these before
KVM_ARM_VCPU_INIT anyway. Even if it did the exception would've been
thrown away by the eventual reset of the vCPU's state.

Cc: stable@vger.kernel.org # 6.17
Fixes: b7b27facc7b5 ("arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/arm.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1789,6 +1789,9 @@ long kvm_arch_vcpu_ioctl(struct file *fi
 	case KVM_GET_VCPU_EVENTS: {
 		struct kvm_vcpu_events events;
 
+		if (!kvm_vcpu_initialized(vcpu))
+			return -ENOEXEC;
+
 		if (kvm_arm_vcpu_get_events(vcpu, &events))
 			return -EINVAL;
 
@@ -1800,6 +1803,9 @@ long kvm_arch_vcpu_ioctl(struct file *fi
 	case KVM_SET_VCPU_EVENTS: {
 		struct kvm_vcpu_events events;
 
+		if (!kvm_vcpu_initialized(vcpu))
+			return -ENOEXEC;
+
 		if (copy_from_user(&events, argp, sizeof(events)))
 			return -EFAULT;
 



