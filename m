Return-Path: <stable+bounces-195375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC523C75C35
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81CED3466EB
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E332874F5;
	Thu, 20 Nov 2025 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pm6sCvl4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC336D4EC
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660196; cv=none; b=gUxJ4MpM2Y3uaF04HKdGkajnXEGQZPGtCphpqWflq6AcO1nPdwllTZi6KBH3KVShaQ5CvurggUmxGLPcJYAdUWeQsKsfJ+flY1JzN2r5531ltMthGgwJb8Yz8DrwMHKd9T1c5G3Qx+FJ2AaPtGe3AXVbjvzGYlDSe3Zilt7azeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660196; c=relaxed/simple;
	bh=2P77Z/nzgOlHr13GCPHJgLrL3qTLlug33FyrqTw1GR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbtIAsFrUYjSPguk0CZI0rb7uOY8GpayZwRoHdYb74zuP0brqMaUwq6kJoSAeVbtZM6MWJ31WBB7NKfc9cjV46CV2pztGAJJ9ilN/RC2NQAS7By2ASjiSucQdGHh4ZrccOK/maGOgYPT6OK+YBGwANcrNLuhfABt+mo2W0MpoR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pm6sCvl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCAEC4CEF1;
	Thu, 20 Nov 2025 17:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763660195;
	bh=2P77Z/nzgOlHr13GCPHJgLrL3qTLlug33FyrqTw1GR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pm6sCvl4fCVapRKrLiE9H0GWOJZoNEfFYWiJK9srHYHJbiTXEM+lHD4+o935IH4mD
	 rdjLbcGnwy0pTSW481oXeLtaWAx5NPt6lSlPH5AlpIM45f1qKFNuh6oUvi8vPuJsyS
	 y/ZiBA+y+82GSl6DmNeUXg1mrSsPDExqmzcJybbRd8An+cxWd6TOCV5x5egSAR9jAq
	 AHS2pKpYnqW/LbiJkW3T57GmKi7ln8tvEZEA4jVQZZqc+gxMrARafd8lqY2uCZGgOj
	 mST+jlCzg92s4kC/SmLmECZdYTRpMRGe+4B7l+/9zrWP6RyWxUZ+gPZjJHvpJwJFby
	 4XkhQ/qwtg6vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com,
	Hillf Danton <hdanton@sina.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] KVM: guest_memfd: Remove bindings on memslot deletion when gmem is dying
Date: Thu, 20 Nov 2025 12:36:31 -0500
Message-ID: <20251120173631.1905381-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120173631.1905381-1-sashal@kernel.org>
References: <2025112009-getaway-overplay-a36a@gregkh>
 <20251120173631.1905381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit ae431059e75d36170a5ae6b44cc4d06d43613215 ]

When unbinding a memslot from a guest_memfd instance, remove the bindings
even if the guest_memfd file is dying, i.e. even if its file refcount has
gone to zero.  If the memslot is freed before the file is fully released,
nullifying the memslot side of the binding in kvm_gmem_release() will
write to freed memory, as detected by syzbot+KASAN:

  ==================================================================
  BUG: KASAN: slab-use-after-free in kvm_gmem_release+0x176/0x440 virt/kvm/guest_memfd.c:353
  Write of size 8 at addr ffff88807befa508 by task syz.0.17/6022

  CPU: 0 UID: 0 PID: 6022 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
  Call Trace:
   <TASK>
   dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
   print_address_description mm/kasan/report.c:378 [inline]
   print_report+0xca/0x240 mm/kasan/report.c:482
   kasan_report+0x118/0x150 mm/kasan/report.c:595
   kvm_gmem_release+0x176/0x440 virt/kvm/guest_memfd.c:353
   __fput+0x44c/0xa70 fs/file_table.c:468
   task_work_run+0x1d4/0x260 kernel/task_work.c:227
   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
   exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
   exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
   syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
   syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
   do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7fbeeff8efc9
   </TASK>

  Allocated by task 6023:
   kasan_save_stack mm/kasan/common.c:56 [inline]
   kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
   poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
   __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
   kasan_kmalloc include/linux/kasan.h:262 [inline]
   __kmalloc_cache_noprof+0x3e2/0x700 mm/slub.c:5758
   kmalloc_noprof include/linux/slab.h:957 [inline]
   kzalloc_noprof include/linux/slab.h:1094 [inline]
   kvm_set_memory_region+0x747/0xb90 virt/kvm/kvm_main.c:2104
   kvm_vm_ioctl_set_memory_region+0x6f/0xd0 virt/kvm/kvm_main.c:2154
   kvm_vm_ioctl+0x957/0xc60 virt/kvm/kvm_main.c:5201
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:597 [inline]
   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Freed by task 6023:
   kasan_save_stack mm/kasan/common.c:56 [inline]
   kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
   kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
   poison_slab_object mm/kasan/common.c:252 [inline]
   __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
   kasan_slab_free include/linux/kasan.h:234 [inline]
   slab_free_hook mm/slub.c:2533 [inline]
   slab_free mm/slub.c:6622 [inline]
   kfree+0x19a/0x6d0 mm/slub.c:6829
   kvm_set_memory_region+0x9c4/0xb90 virt/kvm/kvm_main.c:2130
   kvm_vm_ioctl_set_memory_region+0x6f/0xd0 virt/kvm/kvm_main.c:2154
   kvm_vm_ioctl+0x957/0xc60 virt/kvm/kvm_main.c:5201
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:597 [inline]
   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Deliberately don't acquire filemap invalid lock when the file is dying as
the lifecycle of f_mapping is outside the purview of KVM.  Dereferencing
the mapping is *probably* fine, but there's no need to invalidate anything
as memslot deletion is responsible for zapping SPTEs, and the only code
that can access the dying file is kvm_gmem_release(), whose core code is
mutually exclusive with unbinding.

Note, the mutual exclusivity is also what makes it safe to access the
bindings on a dying gmem instance.  Unbinding either runs with slots_lock
held, or after the last reference to the owning "struct kvm" is put, and
kvm_gmem_release() nullifies the slot pointer under slots_lock, and puts
its reference to the VM after that is done.

Reported-by: syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68fa7a22.a70a0220.3bf6c6.008b.GAE@google.com
Tested-by: syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com
Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Cc: stable@vger.kernel.org
Cc: Hillf Danton <hdanton@sina.com>
Reviewed-By: Vishal Annapurve <vannapurve@google.com>
Link: https://patch.msgid.link/20251104011205.3853541-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/guest_memfd.c | 45 ++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 343ed456b89b0..e2c7e3d918406 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -534,31 +534,50 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return r;
 }
 
-void kvm_gmem_unbind(struct kvm_memory_slot *slot)
+static void __kvm_gmem_unbind(struct kvm_memory_slot *slot, struct kvm_gmem *gmem)
 {
 	unsigned long start = slot->gmem.pgoff;
 	unsigned long end = start + slot->npages;
-	struct kvm_gmem *gmem;
+
+	xa_store_range(&gmem->bindings, start, end - 1, NULL, GFP_KERNEL);
+
+	/*
+	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
+	 * cannot see this memslot.
+	 */
+	WRITE_ONCE(slot->gmem.file, NULL);
+}
+
+void kvm_gmem_unbind(struct kvm_memory_slot *slot)
+{
 	struct file *file;
 
 	/*
-	 * Nothing to do if the underlying file was already closed (or is being
-	 * closed right now), kvm_gmem_release() invalidates all bindings.
+	 * Nothing to do if the underlying file was _already_ closed, as
+	 * kvm_gmem_release() invalidates and nullifies all bindings.
 	 */
-	file = kvm_gmem_get_file(slot);
-	if (!file)
+	if (!slot->gmem.file)
 		return;
 
-	gmem = file->private_data;
-
-	filemap_invalidate_lock(file->f_mapping);
-	xa_store_range(&gmem->bindings, start, end - 1, NULL, GFP_KERNEL);
+	file = kvm_gmem_get_file(slot);
 
 	/*
-	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
-	 * cannot see this memslot.
+	 * However, if the file is _being_ closed, then the bindings need to be
+	 * removed as kvm_gmem_release() might not run until after the memslot
+	 * is freed.  Note, modifying the bindings is safe even though the file
+	 * is dying as kvm_gmem_release() nullifies slot->gmem.file under
+	 * slots_lock, and only puts its reference to KVM after destroying all
+	 * bindings.  I.e. reaching this point means kvm_gmem_release() hasn't
+	 * yet destroyed the bindings or freed the gmem_file, and can't do so
+	 * until the caller drops slots_lock.
 	 */
-	WRITE_ONCE(slot->gmem.file, NULL);
+	if (!file) {
+		__kvm_gmem_unbind(slot, slot->gmem.file->private_data);
+		return;
+	}
+
+	filemap_invalidate_lock(file->f_mapping);
+	__kvm_gmem_unbind(slot, file->private_data);
 	filemap_invalidate_unlock(file->f_mapping);
 
 	fput(file);
-- 
2.51.0


