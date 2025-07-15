Return-Path: <stable+bounces-162567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19EDB05E67
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137A117719F
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB672EA75C;
	Tue, 15 Jul 2025 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RRd4EJ4/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80F2E54CC;
	Tue, 15 Jul 2025 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586896; cv=none; b=cm23JswZ1n09bF1iT6CCvDd23mDcb4m/8bRNdAoNmqprkVts+E8eJdqZt9cE0J/giINwTHQ4ffUEYks+iOATD5Z0Y6rnv3pI3F+6cVkrxAgbZ6NWXlhHO0W3dSUl37l9B3DBmBHbM2TKKEi2QnmasJzEtC4oCuFm+t156AKSDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586896; c=relaxed/simple;
	bh=H5eKrXrFlQCM7QRF8EPi/VShB0XuwvDj95LPjPDJR8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofJf79qfuMTd1KePm3J8YYWbK3jVMZaGk5+bjMj86GZcoskQiRj1hgFrQB2SjCbgJTFSqdhn3TgWKeNZ3cLXdALmAnLyz81DAPJNT0YM8njAFZhrvO6LDG+FpjUS3GKRbV/EtVuGKuYiqHDwOxmpgtkFKpK8wA/PFFkUxxAU96Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RRd4EJ4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5199AC4CEE3;
	Tue, 15 Jul 2025 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586896;
	bh=H5eKrXrFlQCM7QRF8EPi/VShB0XuwvDj95LPjPDJR8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RRd4EJ4/PaxbEpzv1nG3PtCNiDaXhLKtt2C0Q/t1p/ByX01H4CuDZODFWGYkZWmCS
	 axIf5NbLkIpGezk64bZJLkoVuDR2pV0qiVkxhJmMHF7tDneU9RdUWktOFShcUbR05d
	 9OcaQ4tJ/uU0VZosTg/d5eM9aGyRojMhDJmAjCjI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Potapenko <glider@google.com>,
	James Houghton <jthoughton@google.com>,
	Peter Gonda <pgonda@google.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.15 059/192] KVM: SVM: Reject SEV{-ES} intra host migration if vCPU creation is in-flight
Date: Tue, 15 Jul 2025 15:12:34 +0200
Message-ID: <20250715130817.207124759@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit ecf371f8b02d5e31b9aa1da7f159f1b2107bdb01 upstream.

Reject migration of SEV{-ES} state if either the source or destination VM
is actively creating a vCPU, i.e. if kvm_vm_ioctl_create_vcpu() is in the
section between incrementing created_vcpus and online_vcpus.  The bulk of
vCPU creation runs _outside_ of kvm->lock to allow creating multiple vCPUs
in parallel, and so sev_info.es_active can get toggled from false=>true in
the destination VM after (or during) svm_vcpu_create(), resulting in an
SEV{-ES} VM effectively having a non-SEV{-ES} vCPU.

The issue manifests most visibly as a crash when trying to free a vCPU's
NULL VMSA page in an SEV-ES VM, but any number of things can go wrong.

  BUG: unable to handle page fault for address: ffffebde00000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  CPU: 227 UID: 0 PID: 64063 Comm: syz.5.60023 Tainted: G     U     O        6.15.0-smp-DEV #2 NONE
  Tainted: [U]=USER, [O]=OOT_MODULE
  Hardware name: Google, Inc. Arcadia_IT_80/Arcadia_IT_80, BIOS 12.52.0-0 10/28/2024
  RIP: 0010:constant_test_bit arch/x86/include/asm/bitops.h:206 [inline]
  RIP: 0010:arch_test_bit arch/x86/include/asm/bitops.h:238 [inline]
  RIP: 0010:_test_bit include/asm-generic/bitops/instrumented-non-atomic.h:142 [inline]
  RIP: 0010:PageHead include/linux/page-flags.h:866 [inline]
  RIP: 0010:___free_pages+0x3e/0x120 mm/page_alloc.c:5067
  Code: <49> f7 06 40 00 00 00 75 05 45 31 ff eb 0c 66 90 4c 89 f0 4c 39 f0
  RSP: 0018:ffff8984551978d0 EFLAGS: 00010246
  RAX: 0000777f80000001 RBX: 0000000000000000 RCX: ffffffff918aeb98
  RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffebde00000000
  RBP: 0000000000000000 R08: ffffebde00000007 R09: 1ffffd7bc0000000
  R10: dffffc0000000000 R11: fffff97bc0000001 R12: dffffc0000000000
  R13: ffff8983e19751a8 R14: ffffebde00000000 R15: 1ffffd7bc0000000
  FS:  0000000000000000(0000) GS:ffff89ee661d3000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffebde00000000 CR3: 000000793ceaa000 CR4: 0000000000350ef0
  DR0: 0000000000000000 DR1: 0000000000000b5f DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   sev_free_vcpu+0x413/0x630 arch/x86/kvm/svm/sev.c:3169
   svm_vcpu_free+0x13a/0x2a0 arch/x86/kvm/svm/svm.c:1515
   kvm_arch_vcpu_destroy+0x6a/0x1d0 arch/x86/kvm/x86.c:12396
   kvm_vcpu_destroy virt/kvm/kvm_main.c:470 [inline]
   kvm_destroy_vcpus+0xd1/0x300 virt/kvm/kvm_main.c:490
   kvm_arch_destroy_vm+0x636/0x820 arch/x86/kvm/x86.c:12895
   kvm_put_kvm+0xb8e/0xfb0 virt/kvm/kvm_main.c:1310
   kvm_vm_release+0x48/0x60 virt/kvm/kvm_main.c:1369
   __fput+0x3e4/0x9e0 fs/file_table.c:465
   task_work_run+0x1a9/0x220 kernel/task_work.c:227
   exit_task_work include/linux/task_work.h:40 [inline]
   do_exit+0x7f0/0x25b0 kernel/exit.c:953
   do_group_exit+0x203/0x2d0 kernel/exit.c:1102
   get_signal+0x1357/0x1480 kernel/signal.c:3034
   arch_do_signal_or_restart+0x40/0x690 arch/x86/kernel/signal.c:337
   exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
   syscall_exit_to_user_mode+0x67/0xb0 kernel/entry/common.c:218
   do_syscall_64+0x7c/0x150 arch/x86/entry/syscall_64.c:100
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f87a898e969
   </TASK>
  Modules linked in: gq(O)
  gsmi: Log Shutdown Reason 0x03
  CR2: ffffebde00000000
  ---[ end trace 0000000000000000 ]---

Deliberately don't check for a NULL VMSA when freeing the vCPU, as crashing
the host is likely desirable due to the VMSA being consumed by hardware.
E.g. if KVM manages to allow VMRUN on the vCPU, hardware may read/write a
bogus VMSA page.  Accessing PFN 0 is "fine"-ish now that it's sequestered
away thanks to L1TF, but panicking in this scenario is preferable to
potentially running with corrupted state.

Reported-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Fixes: 0b020f5af092 ("KVM: SEV: Add support for SEV-ES intra host migration")
Fixes: b56639318bb2 ("KVM: SEV: Add support for SEV intra host migration")
Cc: stable@vger.kernel.org
Cc: James Houghton <jthoughton@google.com>
Cc: Peter Gonda <pgonda@google.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Tested-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: James Houghton <jthoughton@google.com>
Link: https://lore.kernel.org/r/20250602224459.41505-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2032,6 +2032,10 @@ static int sev_check_source_vcpus(struct
 	struct kvm_vcpu *src_vcpu;
 	unsigned long i;
 
+	if (src->created_vcpus != atomic_read(&src->online_vcpus) ||
+	    dst->created_vcpus != atomic_read(&dst->online_vcpus))
+		return -EBUSY;
+
 	if (!sev_es_guest(src))
 		return 0;
 



