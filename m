Return-Path: <stable+bounces-87431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A48E59A654E
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE3CB30125
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FECF1E908D;
	Mon, 21 Oct 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y5X27mkM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063211E884F;
	Mon, 21 Oct 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507586; cv=none; b=ZhXmyH5stRVFRK854MPCyAzzYnOrw/giZ5lQ33cZvjIDhlcJ+xBEIeovQkXZUFxbDSqF1vTKxh3sUTnmqteId4kg0rB0hhmooBlVLzheOOcaA5Utbmq2Bxmm/D6/yRrTs4pehFSMAgTRrpIaBZoUcf2pkP+dLqV83ABwiIohl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507586; c=relaxed/simple;
	bh=C3RtUO8TBHaJUp9AGPGXsdlPM5zRX9wzb0kMsGi/MOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDJPZtX24UQ7Xla0HrkE0y8juJso9Gg+DroukcVa6qAwhVYyl68Ie5z+ybWPm2U9HTT3BIrBcE3yMENtqN0f02lP2wnvVb66ql0ny5bKWlq75X/mhy6FhxQCqYQ7JORAoMueVUNjEJFPinqpUnCeoVJ7UcfEHbFMypqnzds2qQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y5X27mkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC09C4CEC3;
	Mon, 21 Oct 2024 10:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507585;
	bh=C3RtUO8TBHaJUp9AGPGXsdlPM5zRX9wzb0kMsGi/MOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y5X27mkMgNnORgO7UCF6VBn86H8npIpan1VePC+Q0YiLQvuk+Ed1aPRH3h7ZaZtdE
	 W6fDzkrnmYgjoOqp5wwNW+lKdh0ZpYlsEMz8abY6D1N0xkYvXsNh8ZVJwvpl1aKjBN
	 TjtMDiweQ7suDPu6PdNPudnfh7Ipb7YDUbI6FVcs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Sean Christopherson <seanjc@google.com>,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Subject: [PATCH 5.15 34/82] KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu_on_spin()
Date: Mon, 21 Oct 2024 12:25:15 +0200
Message-ID: <20241021102248.592688087@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102247.209765070@linuxfoundation.org>
References: <20241021102247.209765070@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

commit 49f683b41f28918df3e51ddc0d928cb2e934ccdb upstream.

Use {READ,WRITE}_ONCE() to access kvm->last_boosted_vcpu to ensure the
loads and stores are atomic.  In the extremely unlikely scenario the
compiler tears the stores, it's theoretically possible for KVM to attempt
to get a vCPU using an out-of-bounds index, e.g. if the write is split
into multiple 8-bit stores, and is paired with a 32-bit load on a VM with
257 vCPUs:

  CPU0                              CPU1
  last_boosted_vcpu = 0xff;

                                    (last_boosted_vcpu = 0x100)
                                    last_boosted_vcpu[15:8] = 0x01;
  i = (last_boosted_vcpu = 0x1ff)
                                    last_boosted_vcpu[7:0] = 0x00;

  vcpu = kvm->vcpu_array[0x1ff];

As detected by KCSAN:

  BUG: KCSAN: data-race in kvm_vcpu_on_spin [kvm] / kvm_vcpu_on_spin [kvm]

  write to 0xffffc90025a92344 of 4 bytes by task 4340 on cpu 16:
  kvm_vcpu_on_spin (arch/x86/kvm/../../../virt/kvm/kvm_main.c:4112) kvm
  handle_pause (arch/x86/kvm/vmx/vmx.c:5929) kvm_intel
  vmx_handle_exit (arch/x86/kvm/vmx/vmx.c:?
		 arch/x86/kvm/vmx/vmx.c:6606) kvm_intel
  vcpu_run (arch/x86/kvm/x86.c:11107 arch/x86/kvm/x86.c:11211) kvm
  kvm_arch_vcpu_ioctl_run (arch/x86/kvm/x86.c:?) kvm
  kvm_vcpu_ioctl (arch/x86/kvm/../../../virt/kvm/kvm_main.c:?) kvm
  __se_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:904 fs/ioctl.c:890)
  __x64_sys_ioctl (fs/ioctl.c:890)
  x64_sys_call (arch/x86/entry/syscall_64.c:33)
  do_syscall_64 (arch/x86/entry/common.c:?)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

  read to 0xffffc90025a92344 of 4 bytes by task 4342 on cpu 4:
  kvm_vcpu_on_spin (arch/x86/kvm/../../../virt/kvm/kvm_main.c:4069) kvm
  handle_pause (arch/x86/kvm/vmx/vmx.c:5929) kvm_intel
  vmx_handle_exit (arch/x86/kvm/vmx/vmx.c:?
			arch/x86/kvm/vmx/vmx.c:6606) kvm_intel
  vcpu_run (arch/x86/kvm/x86.c:11107 arch/x86/kvm/x86.c:11211) kvm
  kvm_arch_vcpu_ioctl_run (arch/x86/kvm/x86.c:?) kvm
  kvm_vcpu_ioctl (arch/x86/kvm/../../../virt/kvm/kvm_main.c:?) kvm
  __se_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:904 fs/ioctl.c:890)
  __x64_sys_ioctl (fs/ioctl.c:890)
  x64_sys_call (arch/x86/entry/syscall_64.c:33)
  do_syscall_64 (arch/x86/entry/common.c:?)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

  value changed: 0x00000012 -> 0x00000000

Fixes: 217ece6129f2 ("KVM: use yield_to instead of sleep in kvm_vcpu_on_spin")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/r/20240510092353.2261824-1-leitao@debian.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/kvm_main.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3528,12 +3528,13 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *m
 {
 	struct kvm *kvm = me->kvm;
 	struct kvm_vcpu *vcpu;
-	int last_boosted_vcpu = me->kvm->last_boosted_vcpu;
+	int last_boosted_vcpu;
 	int yielded = 0;
 	int try = 3;
 	int pass;
 	int i;
 
+	last_boosted_vcpu = READ_ONCE(kvm->last_boosted_vcpu);
 	kvm_vcpu_set_in_spin_loop(me, true);
 	/*
 	 * We boost the priority of a VCPU that is runnable but not
@@ -3565,7 +3566,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *m
 
 			yielded = kvm_vcpu_yield_to(vcpu);
 			if (yielded > 0) {
-				kvm->last_boosted_vcpu = i;
+				WRITE_ONCE(kvm->last_boosted_vcpu, i);
 				break;
 			} else if (yielded < 0) {
 				try--;



