Return-Path: <stable+bounces-195281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D843C752BB
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BB75358367
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2881E34405D;
	Thu, 20 Nov 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YKKet6cH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC4934A3B0
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653812; cv=none; b=e0Al1nkciN5ecRcKVnpCBCd/FGURL8akJZfHfp3/AMnvnxfp4E8cqr8MLsUANzolrtJA4WorYoiU0T0rbIRD74lSqVjYbsK+efQXSGmRi2Nupc6pKKqqXTTLAZRuTpNAT+L2Lp8+lVMLf+hQ2+7W0UnY+eBGRC0rlt28THwKEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653812; c=relaxed/simple;
	bh=fb0Y/efJ6ESagSE/gZPqY549I6IWs+Ei1mBBN9hbtkk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NlFgFXcr/Nd0Fg7WVZfTGc919gRez/YHsXmwVHYHdSc5bQxoKJolM6OoLMY8e0e57f6WXhNiCd1QLoMTxYXBO8Yhr8fJradbkUxvAXblOgw/JvRl+S0Za2kcQqDFqRxb9GI7erTdaDivYwxM/t/dNRWwQCxGqMUNSyKrc7spYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YKKet6cH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E7AC116C6;
	Thu, 20 Nov 2025 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763653812;
	bh=fb0Y/efJ6ESagSE/gZPqY549I6IWs+Ei1mBBN9hbtkk=;
	h=Subject:To:Cc:From:Date:From;
	b=YKKet6cHJUA3dgubrKouCn08y7OyY6VsE1SWI7PMWt03HA9RXS2uqOiYAXaqC1hAL
	 G2nXIrGgqteVDVap7qgX4LDwsQsNMEj5D0NQGpG141sMZTWP9QrpC10VNb+4tSCKbo
	 0wMCEgDnb4+LktuIALywvs7wgUTxcpXlfW7+4sWA=
Subject: FAILED: patch "[PATCH] KVM: guest_memfd: Remove bindings on memslot deletion when" failed to apply to 6.12-stable tree
To: seanjc@google.com,hdanton@sina.com,vannapurve@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 16:50:09 +0100
Message-ID: <2025112009-getaway-overplay-a36a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ae431059e75d36170a5ae6b44cc4d06d43613215
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112009-getaway-overplay-a36a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ae431059e75d36170a5ae6b44cc4d06d43613215 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 3 Nov 2025 17:12:05 -0800
Subject: [PATCH] KVM: guest_memfd: Remove bindings on memslot deletion when
 gmem is dying

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

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fbca8c0972da..ffadc5ee8e04 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -623,24 +623,11 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return r;
 }
 
-void kvm_gmem_unbind(struct kvm_memory_slot *slot)
+static void __kvm_gmem_unbind(struct kvm_memory_slot *slot, struct kvm_gmem *gmem)
 {
 	unsigned long start = slot->gmem.pgoff;
 	unsigned long end = start + slot->npages;
-	struct kvm_gmem *gmem;
-	struct file *file;
 
-	/*
-	 * Nothing to do if the underlying file was already closed (or is being
-	 * closed right now), kvm_gmem_release() invalidates all bindings.
-	 */
-	file = kvm_gmem_get_file(slot);
-	if (!file)
-		return;
-
-	gmem = file->private_data;
-
-	filemap_invalidate_lock(file->f_mapping);
 	xa_store_range(&gmem->bindings, start, end - 1, NULL, GFP_KERNEL);
 
 	/*
@@ -648,6 +635,38 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 	 * cannot see this memslot.
 	 */
 	WRITE_ONCE(slot->gmem.file, NULL);
+}
+
+void kvm_gmem_unbind(struct kvm_memory_slot *slot)
+{
+	struct file *file;
+
+	/*
+	 * Nothing to do if the underlying file was _already_ closed, as
+	 * kvm_gmem_release() invalidates and nullifies all bindings.
+	 */
+	if (!slot->gmem.file)
+		return;
+
+	file = kvm_gmem_get_file(slot);
+
+	/*
+	 * However, if the file is _being_ closed, then the bindings need to be
+	 * removed as kvm_gmem_release() might not run until after the memslot
+	 * is freed.  Note, modifying the bindings is safe even though the file
+	 * is dying as kvm_gmem_release() nullifies slot->gmem.file under
+	 * slots_lock, and only puts its reference to KVM after destroying all
+	 * bindings.  I.e. reaching this point means kvm_gmem_release() hasn't
+	 * yet destroyed the bindings or freed the gmem_file, and can't do so
+	 * until the caller drops slots_lock.
+	 */
+	if (!file) {
+		__kvm_gmem_unbind(slot, slot->gmem.file->private_data);
+		return;
+	}
+
+	filemap_invalidate_lock(file->f_mapping);
+	__kvm_gmem_unbind(slot, file->private_data);
 	filemap_invalidate_unlock(file->f_mapping);
 
 	fput(file);


