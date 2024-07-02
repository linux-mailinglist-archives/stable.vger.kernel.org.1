Return-Path: <stable+bounces-56553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2199244EA
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3721F22012
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31E31BE23D;
	Tue,  2 Jul 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s7t5Z8M5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910311BD4E9;
	Tue,  2 Jul 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940567; cv=none; b=E21UZaZspnnGWmbAXgcslinxOiGen200NCJVcnyo8MTmOCYP89VU9CWpagoWMa/ACJalMAOQ2k2NYlkMPl1JUL8cF008begWwnbvFilwZNYbp4kywxSkHmqy0h7tEU8pgSfBgvxn3OSUD5byfbbe7uy3l6OlV1g11eUJW5LXfx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940567; c=relaxed/simple;
	bh=LYxfBVec0qqI74ix3N9k7DL23VGYWCvNwpXsbcfNwMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqNSXoC250Ww7pdlc0f7T0XPoBovTREbK36fpE8dYUpSc1zYWYIFk4JhNkgbZ6+9anPu7w+gZYJcSNu8yky4LfIFXiqEV+Kko2YUc40bI6Uo8sikwZdWpu9zIgnhFaoFfIL0LHEfZGDv9QBnpq52GWJAJOQ8CTW+l2Bp9ERXXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s7t5Z8M5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3115C116B1;
	Tue,  2 Jul 2024 17:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940567;
	bh=LYxfBVec0qqI74ix3N9k7DL23VGYWCvNwpXsbcfNwMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s7t5Z8M57V0z2TIqIxbdO2EcKLgHzKvyau6qMguQB+ZTEOq6zfNa9GLgHjLe1Cjys
	 tq8fwIdXMKj9/LjrwDHfjQd8/Ylg6B9LmsTevLlTvEe9TUcgKJzixEptpjrOKGFoAs
	 /mMKGe0Tm8J+pnezodpzD30XJCR7BxeLK+zazTY8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 6.9 194/222] syscalls: fix compat_sys_io_pgetevents_time64 usage
Date: Tue,  2 Jul 2024 19:03:52 +0200
Message-ID: <20240702170251.400488170@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
References: <20240702170243.963426416@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit d3882564a77c21eb746ba5364f3fa89b88de3d61 upstream.

Using sys_io_pgetevents() as the entry point for compat mode tasks
works almost correctly, but misses the sign extension for the min_nr
and nr arguments.

This was addressed on parisc by switching to
compat_sys_io_pgetevents_time64() in commit 6431e92fc827 ("parisc:
io_pgetevents_time64() needs compat syscall in 32-bit compat mode"),
as well as by using more sophisticated system call wrappers on x86 and
s390. However, arm64, mips, powerpc, sparc and riscv still have the
same bug.

Change all of them over to use compat_sys_io_pgetevents_time64()
like parisc already does. This was clearly the intention when the
function was originally added, but it got hooked up incorrectly in
the tables.

Cc: stable@vger.kernel.org
Fixes: 48166e6ea47d ("y2038: add 64-bit time_t syscalls to all 32-bit architectures")
Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/unistd32.h         |    2 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl |    2 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl |    2 +-
 arch/powerpc/kernel/syscalls/syscall.tbl  |    2 +-
 arch/s390/kernel/syscalls/syscall.tbl     |    2 +-
 arch/sparc/kernel/syscalls/syscall.tbl    |    2 +-
 arch/x86/entry/syscalls/syscall_32.tbl    |    2 +-
 include/uapi/asm-generic/unistd.h         |    2 +-
 kernel/sys_ni.c                           |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -840,7 +840,7 @@ __SYSCALL(__NR_pselect6_time64, compat_s
 #define __NR_ppoll_time64 414
 __SYSCALL(__NR_ppoll_time64, compat_sys_ppoll_time64)
 #define __NR_io_pgetevents_time64 416
-__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+__SYSCALL(__NR_io_pgetevents_time64, compat_sys_io_pgetevents_time64)
 #define __NR_recvmmsg_time64 417
 __SYSCALL(__NR_recvmmsg_time64, compat_sys_recvmmsg_time64)
 #define __NR_mq_timedsend_time64 418
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -354,7 +354,7 @@
 412	n32	utimensat_time64		sys_utimensat
 413	n32	pselect6_time64			compat_sys_pselect6_time64
 414	n32	ppoll_time64			compat_sys_ppoll_time64
-416	n32	io_pgetevents_time64		sys_io_pgetevents
+416	n32	io_pgetevents_time64		compat_sys_io_pgetevents_time64
 417	n32	recvmmsg_time64			compat_sys_recvmmsg_time64
 418	n32	mq_timedsend_time64		sys_mq_timedsend
 419	n32	mq_timedreceive_time64		sys_mq_timedreceive
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -403,7 +403,7 @@
 412	o32	utimensat_time64		sys_utimensat			sys_utimensat
 413	o32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	o32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	o32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	o32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	o32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	o32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	o32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -506,7 +506,7 @@
 412	32	utimensat_time64		sys_utimensat			sys_utimensat
 413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -418,7 +418,7 @@
 412	32	utimensat_time64	-				sys_utimensat
 413	32	pselect6_time64		-				compat_sys_pselect6_time64
 414	32	ppoll_time64		-				compat_sys_ppoll_time64
-416	32	io_pgetevents_time64	-				sys_io_pgetevents
+416	32	io_pgetevents_time64	-				compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64		-				compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64	-				sys_mq_timedsend
 419	32	mq_timedreceive_time64	-				sys_mq_timedreceive
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -461,7 +461,7 @@
 412	32	utimensat_time64		sys_utimensat			sys_utimensat
 413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -420,7 +420,7 @@
 412	i386	utimensat_time64	sys_utimensat
 413	i386	pselect6_time64		sys_pselect6			compat_sys_pselect6_time64
 414	i386	ppoll_time64		sys_ppoll			compat_sys_ppoll_time64
-416	i386	io_pgetevents_time64	sys_io_pgetevents
+416	i386	io_pgetevents_time64	sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	i386	recvmmsg_time64		sys_recvmmsg			compat_sys_recvmmsg_time64
 418	i386	mq_timedsend_time64	sys_mq_timedsend
 419	i386	mq_timedreceive_time64	sys_mq_timedreceive
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -737,7 +737,7 @@ __SC_COMP(__NR_pselect6_time64, sys_psel
 #define __NR_ppoll_time64 414
 __SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
 #define __NR_io_pgetevents_time64 416
-__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+__SC_COMP(__NR_io_pgetevents_time64, sys_io_pgetevents, compat_sys_io_pgetevents_time64)
 #define __NR_recvmmsg_time64 417
 __SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
 #define __NR_mq_timedsend_time64 418
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -46,8 +46,8 @@ COND_SYSCALL(io_getevents_time32);
 COND_SYSCALL(io_getevents);
 COND_SYSCALL(io_pgetevents_time32);
 COND_SYSCALL(io_pgetevents);
-COND_SYSCALL_COMPAT(io_pgetevents_time32);
 COND_SYSCALL_COMPAT(io_pgetevents);
+COND_SYSCALL_COMPAT(io_pgetevents_time64);
 COND_SYSCALL(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
 COND_SYSCALL(io_uring_register);



