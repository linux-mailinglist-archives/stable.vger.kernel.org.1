Return-Path: <stable+bounces-64656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED35941FDA
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 20:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3C42861A8
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0541AA3DB;
	Tue, 30 Jul 2024 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHEUQKKZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1F1AA3C3
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364869; cv=none; b=NspqF2hpRQedtBk9NCJ8YBCVz0x3h7/hOsR4/dMZ0huTP4yPi336sztK2tLlE4u6frjw9kclct5Ol5H6QfFTPEWa3WvJ5i9Eegr/GXBUrOTC4f61Jxm4mkuEx7YCguGYz9DgmGix0CTjbiFSWupNhY0Ngbn0A63fBLASeHQ7NcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364869; c=relaxed/simple;
	bh=kkjbWUhITPAf72kxvWSFwesuO9YPDf6AEx7QFPJrO3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DszGzzXibqwBTUZLRS97tW6BPO53g92sfP/D/GaOCfiuCcyk9EfLnz3Zo/NJwNtHJhQEiKEjGEVOW8Xh82cq1Pz9FBPRzG0Wfo8q43utFiHtMnecY4qXmEyKW4KSz4PgJrk3VzWIMBR+Nw+z+ViaLr7JJZApChP1kdauG5DFAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHEUQKKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597E9C4AF0C;
	Tue, 30 Jul 2024 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722364868;
	bh=kkjbWUhITPAf72kxvWSFwesuO9YPDf6AEx7QFPJrO3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LHEUQKKZ49GOGK4/KyP7S2pbrpKdzyFa0kAPJ9RhDeKt2+SVYUlGSijqxJMoeXSpr
	 JWVlO5vq3yMg/nJKx+UHWj59sN5MHnjL9Q38BHJcSLJTU+d+PoRxlh8frf3AbmTQpI
	 VrN9VGDK4m1wV9/12OjVyv/i9zogy1xoJ/sqEu0vX3XSXGTEoiLY9848TDyCp8fAyv
	 A8WjI8kvmSwUQ34HI9uAmFoGEqk6G5MFKzhGyW+7BGza4iQic4QTUadjlPJSIFHpKl
	 A3CVWCt6YK83zgknNOG4lCmWR1Jn/Pskl7cIS5m7k8slY6gyO9n/E8vi1Imt+JyNiV
	 d2dnzApg9QTsg==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.4 and 4.19] kbuild: Fix '-S -c' in x86 stack protector scripts
Date: Tue, 30 Jul 2024 11:40:54 -0700
Message-ID: <20240730184054.254156-1-nathan@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024073000-polish-wish-b988@gregkh>
References: <2024073000-polish-wish-b988@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 3415b10a03945b0da4a635e146750dfe5ce0f448 upstream.

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
[nathan: Fixed conflict in 32-bit version due to lack of 3fb0fdb3bbe7]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This change applies cleanly with 'patch -p1' on both 5.4 and 4.19.
---
 scripts/gcc-x86_32-has-stack-protector.sh | 2 +-
 scripts/gcc-x86_64-has-stack-protector.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
index f5c119495254..e05020116b37 100755
--- a/scripts/gcc-x86_32-has-stack-protector.sh
+++ b/scripts/gcc-x86_32-has-stack-protector.sh
@@ -1,4 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
+echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -m32 -O0 -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
index 75e4e22b986a..f680bb01aeeb 100755
--- a/scripts/gcc-x86_64-has-stack-protector.sh
+++ b/scripts/gcc-x86_64-has-stack-protector.sh
@@ -1,4 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
+echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
-- 
2.45.2


