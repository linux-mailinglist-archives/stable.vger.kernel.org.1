Return-Path: <stable+bounces-56245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646B691E254
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F38128817A
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50921EB5E;
	Mon,  1 Jul 2024 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QMx99OIy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966DD15F31F
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843871; cv=none; b=JGpmebpOp+oY+mEUZfau1Em5ejMV2leWsZfpMmdAcFsMo1OvyaQlqpZONwCNV89PlqdRVIQqpNtxV0iXkq6W2qxuAsqp1xUM7f8Dk67/xV97Rv7jDa16UKG4A33YAZAj3+LDBT8mcaKU7DbHF1WAynJrP6Lxub7LQ0SlhCn71CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843871; c=relaxed/simple;
	bh=8kF/RsDAuQSZop0s7Htefz2FbJ/YMIvdqqplchDE3cs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t5NkesdYeivE3uA7tFxW+85rxdrRNtN7OHQkNR51/QRyc3WNj5r56+/rgbpu7AxoqebhFB5YW9BlO2h4MTSrFK1owZGpZo84tCBginwWo1lQLFT7OxO76LIQu4oxsY/RBOuCxIHzOEcwUi4Nw3O+9bI3tlEz6mmuOadpyWYGi8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QMx99OIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0564DC116B1;
	Mon,  1 Jul 2024 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719843871;
	bh=8kF/RsDAuQSZop0s7Htefz2FbJ/YMIvdqqplchDE3cs=;
	h=Subject:To:Cc:From:Date:From;
	b=QMx99OIywdvrgtKHRDCm/d/L6x+tte/eW3+2e0HPiI9ixNGUtSLzQ8RpHUwmzUVJo
	 s2Tw+xH4Ar4aCB4pjVA/A2+ARYKXkAZk6JuBGPOhSJ6vWPXJ0y5Wc+qXUNvSUBtQtT
	 taeTRbTvvcDA4BLuPWR9idFU2yotV8M2DuPuwJHs=
Subject: FAILED: patch "[PATCH] sh: rework sync_file_range ABI" failed to apply to 4.19-stable tree
To: arnd@arndb.de,glaubitz@physik.fu-berlin.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 16:24:28 +0200
Message-ID: <2024070128-hermit-trash-cc15@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 30766f1105d6d2459c3b9fe34a3e52b637a72950
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070128-hermit-trash-cc15@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

30766f1105d6 ("sh: rework sync_file_range ABI")
b41c51c8e194 ("arch: add pkey and rseq syscall numbers everywhere")
0d6040d46817 ("arch: add split IPC system calls where needed")
d25a122afd43 ("sh: add statx system call")
09ac12603bf0 ("m68k: assign syscall number for seccomp")
d012d1325ba5 ("alpha: wire up io_pgetevents system call")
acce2f71779c ("ia64: assign syscall numbers for perf and seccomp")
7349ee3a97ed ("ia64: add statx and io_pgetevents syscalls")
90856087daca ("s390: remove compat_wrapper.c")
aa0d6e70d3b3 ("s390: autogenerate compat syscall wrappers")
fef747bab3c0 ("s390: use generic UID16 implementation")
d9a7fa67b4bf ("Merge branch 'next-seccomp' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30766f1105d6d2459c3b9fe34a3e52b637a72950 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Jun 2024 22:12:43 +0200
Subject: [PATCH] sh: rework sync_file_range ABI

The unusual function calling conventions on SuperH ended up causing
sync_file_range to have the wrong argument order, with the 'flags'
argument getting sorted before 'nbytes' by the compiler.

In userspace, I found that musl, glibc, uclibc and strace all expect the
normal calling conventions with 'nbytes' last, so changing the kernel
to match them should make all of those work.

In order to be able to also fix libc implementations to work with existing
kernels, they need to be able to tell which ABI is used. An easy way
to do this is to add yet another system call using the sync_file_range2
ABI that works the same on all architectures.

Old user binaries can now work on new kernels, and new binaries can
try the new sync_file_range2() to work with new kernels or fall back
to the old sync_file_range() version if that doesn't exist.

Cc: stable@vger.kernel.org
Fixes: 75c92acdd5b1 ("sh: Wire up new syscalls.")
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/sh/kernel/sys_sh32.c b/arch/sh/kernel/sys_sh32.c
index 9dca568509a5..d6f4afcb0e87 100644
--- a/arch/sh/kernel/sys_sh32.c
+++ b/arch/sh/kernel/sys_sh32.c
@@ -59,3 +59,14 @@ asmlinkage int sys_fadvise64_64_wrapper(int fd, u32 offset0, u32 offset1,
 				 (u64)len0 << 32 | len1, advice);
 #endif
 }
+
+/*
+ * swap the arguments the way that libc wants them instead of
+ * moving flags ahead of the 64-bit nbytes argument
+ */
+SYSCALL_DEFINE6(sh_sync_file_range6, int, fd, SC_ARG64(offset),
+                SC_ARG64(nbytes), unsigned int, flags)
+{
+        return ksys_sync_file_range(fd, SC_VAL64(loff_t, offset),
+                                    SC_VAL64(loff_t, nbytes), flags);
+}
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index bbf83a2db986..c55fd7696d40 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -321,7 +321,7 @@
 311	common	set_robust_list			sys_set_robust_list
 312	common	get_robust_list			sys_get_robust_list
 313	common	splice				sys_splice
-314	common	sync_file_range			sys_sync_file_range
+314	common	sync_file_range			sys_sh_sync_file_range6
 315	common	tee				sys_tee
 316	common	vmsplice			sys_vmsplice
 317	common	move_pages			sys_move_pages
@@ -395,6 +395,7 @@
 385	common	pkey_alloc			sys_pkey_alloc
 386	common	pkey_free			sys_pkey_free
 387	common	rseq				sys_rseq
+388	common	sync_file_range2		sys_sync_file_range2
 # room for arch specific syscalls
 393	common	semget				sys_semget
 394	common	semctl				sys_semctl


