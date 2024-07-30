Return-Path: <stable+bounces-62660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F6C940D23
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FF63B2A8E4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E911922D9;
	Tue, 30 Jul 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IPCjt+j2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B84D442C
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330253; cv=none; b=gMyvj7HDqGZWwPPXhAxfeQ7uuf9g6nl0r3UObnV4ktWGtNSL1keRD/bMjjIsOxh5AGfpNRRwz+e0hyV8VkHBzZftBnANY1JeBL855lwZiCiJloLZJ1suGOr1c4ItYK0LC02T9MRHSqKkSrxx0p0ZPFE9CdSIPxPNMfZWSxndpGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330253; c=relaxed/simple;
	bh=FEqjVGZSOUuZFicjlY42v8i0rCmV4Bjw0prIYYwTP8w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iWHHYLi8uZ0jh5/lEM8iCpTzlEGf2lVH4hFlPLzeqVR0QGjGHU6jMcj6DT93htK01Ky+PmTPxKHyacqk2ootYE/zWsi5Qt7g+htroq1/NpeIqGiYpxghIX2rQwQEps3WHq6HNEl9EJqmQfrvO/SVTkDnM59kOVYAq2ZQ2Zar2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IPCjt+j2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F26FC4AF0C;
	Tue, 30 Jul 2024 09:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722330253;
	bh=FEqjVGZSOUuZFicjlY42v8i0rCmV4Bjw0prIYYwTP8w=;
	h=Subject:To:Cc:From:Date:From;
	b=IPCjt+j28hL4SVxD1jgzAOYnrIXGCC1R2D7zyNVSuUCv+otoBkIXIdmt4YMZet5j7
	 OoCyp6DdRdgoDELou5c1QQcuM20v3HjL56NgMtddRwdP2o6c6IDwCBNG1NeW/N/vv8
	 BLHqmhVavo4HuTvJlpc+z8dQr0HV6rJksKbgSHpM=
Subject: FAILED: patch "[PATCH] kbuild: Fix '-S -c' in x86 stack protector scripts" failed to apply to 4.19-stable tree
To: nathan@kernel.org,masahiroy@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:04:01 +0200
Message-ID: <2024073001-unaudited-uncooked-cfe3@gregkh>
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
git cherry-pick -x 3415b10a03945b0da4a635e146750dfe5ce0f448
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073001-unaudited-uncooked-cfe3@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

3415b10a0394 ("kbuild: Fix '-S -c' in x86 stack protector scripts")
3fb0fdb3bbe7 ("x86/stackprotector/32: Make the canary into a regular percpu variable")
c9a1ff316bc9 ("x86/stackprotector: Pre-initialize canary for secondary CPUs")
dc4e0021b00b ("x86/doublefault/32: Move #DF stack and TSS to cpu_entry_area")
e99b6f46ee5c ("x86/doublefault/32: Rename doublefault.c to doublefault_32.c")
93efbde2c331 ("x86/traps: Disentangle the 32-bit and 64-bit doublefault code")
ab851d49f6bf ("Merge branch 'x86-iopl-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3415b10a03945b0da4a635e146750dfe5ce0f448 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 26 Jul 2024 11:05:00 -0700
Subject: [PATCH] kbuild: Fix '-S -c' in x86 stack protector scripts

After a recent change in clang to stop consuming all instances of '-S'
and '-c' [1], the stack protector scripts break due to the kernel's use
of -Werror=unused-command-line-argument to catch cases where flags are
not being properly consumed by the compiler driver:

  $ echo | clang -o - -x c - -S -c -Werror=unused-command-line-argument
  clang: error: argument unused during compilation: '-c' [-Werror,-Wunused-command-line-argument]

This results in CONFIG_STACKPROTECTOR getting disabled because
CONFIG_CC_HAS_SANE_STACKPROTECTOR is no longer set.

'-c' and '-S' both instruct the compiler to stop at different stages of
the pipeline ('-S' after compiling, '-c' after assembling), so having
them present together in the same command makes little sense. In this
case, the test wants to stop before assembling because it is looking at
the textual assembly output of the compiler for either '%fs' or '%gs',
so remove '-c' from the list of arguments to resolve the error.

All versions of GCC continue to work after this change, along with
versions of clang that do or do not contain the change mentioned above.

Cc: stable@vger.kernel.org
Fixes: 4f7fd4d7a791 ("[PATCH] Add the -fstack-protector option to the CFLAGS")
Fixes: 60a5317ff0f4 ("x86: implement x86_32 stack protector")
Link: https://github.com/llvm/llvm-project/commit/6461e537815f7fa68cef06842505353cf5600e9c [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
index 825c75c5b715..9459ca4f0f11 100755
--- a/scripts/gcc-x86_32-has-stack-protector.sh
+++ b/scripts/gcc-x86_32-has-stack-protector.sh
@@ -5,4 +5,4 @@
 # -mstack-protector-guard-reg, added by
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708
 
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
+echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -m32 -O0 -fstack-protector -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
index 75e4e22b986a..f680bb01aeeb 100755
--- a/scripts/gcc-x86_64-has-stack-protector.sh
+++ b/scripts/gcc-x86_64-has-stack-protector.sh
@@ -1,4 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
+echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"


