Return-Path: <stable+bounces-62512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262E93F4FA
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F8E282AF4
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426721448F4;
	Mon, 29 Jul 2024 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kuMxWpOC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DB8768EE
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255325; cv=none; b=ik9YQb7uwm94UZ55DhWI8gocRvyeoba7B12h4ND9gflk6lO4NmInROoqz1AwJvwoRbwrc3kNSzV1qEpmOXZgLlNopIadIdL/JWESy6rZ8rB0uXP+RMsYA9d2LrFAME6rhr1JcMDWky5Vpuu9tmiPZL1S2esWy9UU74eP/dW7FpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255325; c=relaxed/simple;
	bh=xwhjovAl2C+8Yw4Z4ERLVZOy71/HyGlegKSmJLDgIz4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lj4qvcajqve5x1Nj17O7czwTQEqONpQr9u7VoQDxXC/1ZaJB/RBotU0ZGMEloTAHXU2XJtaQsncWgV1biekEB9Tjs2LbIkZ14MmXIECRPNNYKHfS5REtosSyH/A3kDdMm516O6PhycA2KSea6RWpYxVqcwvXA0HmQFGC9g/NXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kuMxWpOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16788C32786;
	Mon, 29 Jul 2024 12:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722255324;
	bh=xwhjovAl2C+8Yw4Z4ERLVZOy71/HyGlegKSmJLDgIz4=;
	h=Subject:To:Cc:From:Date:From;
	b=kuMxWpOCunxkFUy33jTwV3vtfvOvHcnixeySn8n6r/tRhoPqL+zsjZxijNxay5ZtI
	 QSSSsk0X/dqTp2rQSyRPASg8c6azPa72yPaJBR31rFofBKg8d1RiouvuyHCi9J9gFr
	 FYTAhKGEOJ2jVRvK1xrMkchAhw1nr/pZ54vBtyRk=
Subject: FAILED: patch "[PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h" failed to apply to 6.10-stable tree
To: chenhuacai@kernel.org,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:15:21 +0200
Message-ID: <2024072921-props-yam-bb2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7697a0fe0154468f5df35c23ebd7aa48994c2cdc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072921-props-yam-bb2b@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

7697a0fe0154 ("LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h")
26a3b85bac08 ("loongarch: convert to generic syscall table")
505d66d1abfb ("clone3: drop __ARCH_WANT_SYS_CLONE3 macro")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7697a0fe0154468f5df35c23ebd7aa48994c2cdc Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 20 Jul 2024 22:40:58 +0800
Subject: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h

Chromium sandbox apparently wants to deny statx [1] so it could properly
inspect arguments after the sandboxed process later falls back to fstat.
Because there's currently not a "fd-only" version of statx, so that the
sandbox has no way to ensure the path argument is empty without being
able to peek into the sandboxed process's memory. For architectures able
to do newfstatat though, glibc falls back to newfstatat after getting
-ENOSYS for statx, then the respective SIGSYS handler [2] takes care of
inspecting the path argument, transforming allowed newfstatat's into
fstat instead which is allowed and has the same type of return value.

But, as LoongArch is the first architecture to not have fstat nor
newfstatat, the LoongArch glibc does not attempt falling back at all
when it gets -ENOSYS for statx -- and you see the problem there!

Actually, back when the LoongArch port was under review, people were
aware of the same problem with sandboxing clone3 [3], so clone was
eventually kept. Unfortunately it seemed at that time no one had noticed
statx, so besides restoring fstat/newfstatat to LoongArch uapi (and
postponing the problem further), it seems inevitable that we would need
to tackle seccomp deep argument inspection.

However, this is obviously a decision that shouldn't be taken lightly,
so we just restore fstat/newfstatat by defining __ARCH_WANT_NEW_STAT
in unistd.h. This is the simplest solution for now, and so we hope the
community will tackle the long-standing problem of seccomp deep argument
inspection in the future [4][5].

Also add "newstat" to syscall_abis_64 in Makefile.syscalls due to
upstream asm-generic changes.

More infomation please reading this thread [6].

[1] https://chromium-review.googlesource.com/c/chromium/src/+/2823150
[2] https://chromium.googlesource.com/chromium/src/sandbox/+/c085b51940bd/linux/seccomp-bpf-helpers/sigsys_handlers.cc#355
[3] https://lore.kernel.org/linux-arch/20220511211231.GG7074@brightrain.aerifal.cx/
[4] https://lwn.net/Articles/799557/
[5] https://lpc.events/event/4/contributions/560/attachments/397/640/deep-arg-inspection.pdf
[6] https://lore.kernel.org/loongarch/20240226-granit-seilschaft-eccc2433014d@brauner/T/#t

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/include/asm/unistd.h b/arch/loongarch/include/asm/unistd.h
index fc0a481a7416..e2c0f3d86c7b 100644
--- a/arch/loongarch/include/asm/unistd.h
+++ b/arch/loongarch/include/asm/unistd.h
@@ -8,6 +8,7 @@
 
 #include <uapi/asm/unistd.h>
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_CLONE
 
 #define NR_syscalls (__NR_syscalls)
diff --git a/arch/loongarch/kernel/Makefile.syscalls b/arch/loongarch/kernel/Makefile.syscalls
index ab7d9baa2915..523bb411a3bc 100644
--- a/arch/loongarch/kernel/Makefile.syscalls
+++ b/arch/loongarch/kernel/Makefile.syscalls
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-# No special ABIs on loongarch so far
-syscall_abis_64 +=
+syscall_abis_64 += newstat


