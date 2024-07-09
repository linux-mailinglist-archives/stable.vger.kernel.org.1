Return-Path: <stable+bounces-58878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C3F92C10A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11371F21D3F
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A589B19345C;
	Tue,  9 Jul 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gD0A4CgY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9219345B;
	Tue,  9 Jul 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542356; cv=none; b=UqzBLygcNdCFxkag/Befa6FAD+tA8VLIJmYA54BAm5+XMsDsjJFXSCejAOG6kozwvb4Aq3me384AEwiEo2YrSUwsH2C4qgyMHvnoZNEp1wv0nnGSi3KWOFPEv2bA6+tIseoXxeULTn2EWLpHHVk7PbFAXDt+Mq14NL1SZfAWSRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542356; c=relaxed/simple;
	bh=7+REd7TLLDWI7/+BAEjcZ2XC1OXTaggmxl8DSrYZ1ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTPZrU7wfmH2uMUz8yf5dYQ4vV5biRznKdq4zmuSxUpyIwuFMUNeDNupL9DfFIvPlPIFIN+nHHEZcBdmez8kLn9je9978P98uWXD54s7/9khorh6oHVzCogxteZGaU9vnG4LigO4N/tc39PwTGg4o2ctSlTY04h1hQVa9pB9HQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gD0A4CgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47313C3277B;
	Tue,  9 Jul 2024 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542355;
	bh=7+REd7TLLDWI7/+BAEjcZ2XC1OXTaggmxl8DSrYZ1ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gD0A4CgY6H1crwAYf9+s58PrQu1TWKntjvpQksS8p+fmcodwf10/M40ZOysaDXQFS
	 KM0QK4QYxskumURz5+McOHDoLCwGMRacqwhVxdJsP/sHhZLvIwnjgBHXojD7J4RFdS
	 Md/JOZqJ1LYjQBQNuiZEl2ykridE6U+I1mC/NeHc58Jp+pEgSBeuAveeWipsdnLSVy
	 t6Ph2SxmBzAKCc8CHOw5WFdnvsKjo5cWiXkptyiKLEwjBohir+MGELLQDW9QfDCsQp
	 HgxQGbjfIyIg2GJnTLUgZheTxTBaOYJoclrulQxlDvGIjSYT7hPPGd0ZtjopIczkt1
	 yQZ7YrmM33ypA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	geert@linux-m68k.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	sohil.mehta@intel.com,
	casey@schaufler-ca.com,
	jeffxu@chromium.org,
	mszeredi@redhat.com,
	linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 16/17] parisc: use generic sys_fanotify_mark implementation
Date: Tue,  9 Jul 2024 12:25:00 -0400
Message-ID: <20240709162517.32584-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162517.32584-1-sashal@kernel.org>
References: <20240709162517.32584-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.162
Content-Transfer-Encoding: 8bit

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
index 117b0f882750a..6ac0c4b98e281 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -12,6 +12,7 @@ config PARISC
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_NO_SG_CHAIN
+	select ARCH_SPLIT_ARG64 if !64BIT
 	select ARCH_SUPPORTS_HUGETLBFS if PA20
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select DMA_OPS
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
index 50c759f11c25d..d47f7f8accaf5 100644
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


