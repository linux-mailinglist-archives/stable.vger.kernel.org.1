Return-Path: <stable+bounces-56661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F14992456E
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EE41F21DBB
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF00F16B394;
	Tue,  2 Jul 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IgRreSC7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28C14293;
	Tue,  2 Jul 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940929; cv=none; b=n5x9VOmytwiG1LkaoWLjv19XxzQOVVy1TyMY0c7ipfihDFJpFCWU17qE4+vPvokzE/TmuG0eujJ1/lbtQCu0PszpdbjNrh8xlIK+OUQSS24F7WOoINSoLECRzAhBBvJH/Nz6iJxB6LtfTZu93CVn9JoAWZwT5Ze8VQb6Ny6zy5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940929; c=relaxed/simple;
	bh=Vd6WQPlXtEqfYTBYxfs3b6dlhm7ijnhrIHIBjbEskMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkVDVj+1cN2gCkdmoxFEgsmoly0gJhj+9YO/8Oe1o+iAve2J64pztZI0HL+uu+dVcIVq16nYgSWkjf+Vynfdn4X8K48E9rlwvxFsB6A6Gya8kPp7k1KrBUJAIjz1os8IUpxcNKLQ+64ncWR8ghxG7jg+RR4959LFoU8nLnom58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IgRreSC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174E4C116B1;
	Tue,  2 Jul 2024 17:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940929;
	bh=Vd6WQPlXtEqfYTBYxfs3b6dlhm7ijnhrIHIBjbEskMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IgRreSC7OxGezKjl24SnnkLseIbUERNP/U27E3vADitYDQ7LfXAgM3hXp/Bep4sS2
	 M7/7STf8C+Mebwg95YDhCLKOpACG9MdBZekPpXfp8y/9ssDLt6pBmUAoX7IszfInmH
	 R+vk/SwfPtQGsGgfEFIAqErsM45lrQG6mCTXUEa8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Helge Deller <deller@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 079/163] parisc: use generic sys_fanotify_mark implementation
Date: Tue,  2 Jul 2024 19:03:13 +0200
Message-ID: <20240702170236.052358221@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
References: <20240702170233.048122282@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 403f17a330732a666ae793f3b15bc75bb5540524 ]

The sys_fanotify_mark() syscall on parisc uses the reverse word order
for the two halves of the 64-bit argument compared to all syscalls on
all 32-bit architectures. As far as I can tell, the problem is that
the function arguments on parisc are sorted backwards (26, 25, 24, 23,
...) compared to everyone else, so the calling conventions of using an
even/odd register pair in native word order result in the lower word
coming first in function arguments, matching the expected behavior
on little-endian architectures. The system call conventions however
ended up matching what the other 32-bit architectures do.

A glibc cleanup in 2020 changed the userspace behavior in a way that
handles all architectures consistently, but this inadvertently broke
parisc32 by changing to the same method as everyone else.

The change made it into glibc-2.35 and subsequently into debian 12
(bookworm), which is the latest stable release. This means we
need to choose between reverting the glibc change or changing the
kernel to match it again, but either hange will leave some systems
broken.

Pick the option that is more likely to help current and future
users and change the kernel to match current glibc. This also
means the behavior is now consistent across architectures, but
it breaks running new kernels with old glibc builds before 2.35.

Link: https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=d150181d73d9
Link: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/arch/parisc/kernel/sys_parisc.c?h=57b1dfbd5b4a39d
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Tested-by: Helge Deller <deller@gmx.de>
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I found this through code inspection, please double-check to make
sure I got the bug and the fix right.

The alternative is to fix this by reverting glibc back to the
unusual behavior.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/Kconfig                     | 1 +
 arch/parisc/kernel/sys_parisc32.c       | 9 ---------
 arch/parisc/kernel/syscalls/syscall.tbl | 2 +-
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 4adeb73d5885c..722e83edad282 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -14,6 +14,7 @@ config PARISC
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_NO_SG_CHAIN
+	select ARCH_SPLIT_ARG64 if !64BIT
 	select ARCH_SUPPORTS_HUGETLBFS if PA20
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_STACKWALK
diff --git a/arch/parisc/kernel/sys_parisc32.c b/arch/parisc/kernel/sys_parisc32.c
index 2a12a547b447b..826c8e51b5853 100644
--- a/arch/parisc/kernel/sys_parisc32.c
+++ b/arch/parisc/kernel/sys_parisc32.c
@@ -23,12 +23,3 @@ asmlinkage long sys32_unimplemented(int r26, int r25, int r24, int r23,
     	current->comm, current->pid, r20);
     return -ENOSYS;
 }
-
-asmlinkage long sys32_fanotify_mark(compat_int_t fanotify_fd, compat_uint_t flags,
-	compat_uint_t mask0, compat_uint_t mask1, compat_int_t dfd,
-	const char  __user * pathname)
-{
-	return sys_fanotify_mark(fanotify_fd, flags,
-			((__u64)mask1 << 32) | mask0,
-			 dfd, pathname);
-}
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 47b3bb90080de..73f560e309573 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -364,7 +364,7 @@
 320	common	accept4			sys_accept4
 321	common	prlimit64		sys_prlimit64
 322	common	fanotify_init		sys_fanotify_init
-323	common	fanotify_mark		sys_fanotify_mark		sys32_fanotify_mark
+323	common	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
 324	32	clock_adjtime		sys_clock_adjtime32
 324	64	clock_adjtime		sys_clock_adjtime
 325	common	name_to_handle_at	sys_name_to_handle_at
-- 
2.43.0




