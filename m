Return-Path: <stable+bounces-50396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67C09064A6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25440B211D6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD95E13792E;
	Thu, 13 Jun 2024 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cI6GacCn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30C12CD9D
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718262764; cv=none; b=uMGI18jcpNFb5J3z/HJ5kyWpFlO5Kz6yj87HvcTZEnFWGnLCGr8nIhN/W0h+aFbphG00zKldUt9PUp4TLNOkATsR40dKQK9aM0BmVbWMHVz9cAijBaqcZ3kZiSq/uWTo1S2QkXeXTtN+Ew3GnBA8EC+8B60w+pY1HngQ9pJ6J0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718262764; c=relaxed/simple;
	bh=afMlHH3EftLHf09WrS1m/PR1dKE5mZ4RxqY7r72UYxM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jv4+n4Kvot17WQ6r0wi4HKhJVWPa+xZ3/UzfBLOkaEE7s0+r5Ri3HVbu0wBaMk5b3XEfOlsDx3t2OO7UISJTRGJwyh6d2D2wfwE2ffciJ5m6NdogSCv84EfDYGinFBOqn0OlNoCrHlCk/ZapudgHWUr4thl9yqHwsizCMLpLkHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cI6GacCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8B8C2BBFC;
	Thu, 13 Jun 2024 07:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718262764;
	bh=afMlHH3EftLHf09WrS1m/PR1dKE5mZ4RxqY7r72UYxM=;
	h=Subject:To:Cc:From:Date:From;
	b=cI6GacCnDHhgZ3F0Z9U7hdz/z4EekJQoeDA7ylXP0PkaIHG1dBFeNWszFKcfYGv1+
	 TpZ9De63lSKWV/awJy+DQvmx46VP92nLvKIjHEfWRliJjP2osMNTNvHgyiuz62fBYe
	 KTe84GWX/rGjdTbQKAePNwwN83tDgoq6tmFbqSAY=
Subject: FAILED: patch "[PATCH] kbuild: Remove support for Clang's ThinLTO caching" failed to apply to 6.1-stable tree
To: nathan@kernel.org,elsk@google.com,masahiroy@kernel.org,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:12:41 +0200
Message-ID: <2024061340-troubling-automated-9989@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x aba091547ef6159d52471f42a3ef531b7b660ed8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061340-troubling-automated-9989@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

aba091547ef6 ("kbuild: Remove support for Clang's ThinLTO caching")
1db773da58df ("kbuild: remove old Rust docs output path")
7ea01d3169a2 ("rust: delete rust-project.json when running make clean")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aba091547ef6159d52471f42a3ef531b7b660ed8 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 1 May 2024 15:55:25 -0700
Subject: [PATCH] kbuild: Remove support for Clang's ThinLTO caching
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is an issue in clang's ThinLTO caching (enabled for the kernel via
'--thinlto-cache-dir') with .incbin, which the kernel occasionally uses
to include data within the kernel, such as the .config file for
/proc/config.gz. For example, when changing the .config and rebuilding
vmlinux, the copy of .config in vmlinux does not match the copy of
.config in the build folder:

  $ echo 'CONFIG_LTO_NONE=n
  CONFIG_LTO_CLANG_THIN=y
  CONFIG_IKCONFIG=y
  CONFIG_HEADERS_INSTALL=y' >kernel/configs/repro.config

  $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 clean defconfig repro.config vmlinux
  ...

  $ grep CONFIG_HEADERS_INSTALL .config
  CONFIG_HEADERS_INSTALL=y

  $ scripts/extract-ikconfig vmlinux | grep CONFIG_HEADERS_INSTALL
  CONFIG_HEADERS_INSTALL=y

  $ scripts/config -d HEADERS_INSTALL

  $ make -kj"$(nproc)" ARCH=x86_64 LLVM=1 vmlinux
  ...
    UPD     kernel/config_data
    GZIP    kernel/config_data.gz
    CC      kernel/configs.o
  ...
    LD      vmlinux
  ...

  $ grep CONFIG_HEADERS_INSTALL .config
  # CONFIG_HEADERS_INSTALL is not set

  $ scripts/extract-ikconfig vmlinux | grep CONFIG_HEADERS_INSTALL
  CONFIG_HEADERS_INSTALL=y

Without '--thinlto-cache-dir' or when using full LTO, this issue does
not occur.

Benchmarking incremental builds on a few different machines with and
without the cache shows a 20% increase in incremental build time without
the cache when measured by touching init/main.c and running 'make all'.

ARCH=arm64 defconfig + CONFIG_LTO_CLANG_THIN=y on an arm64 host:

  Benchmark 1: With ThinLTO cache
    Time (mean ± σ):     56.347 s ±  0.163 s    [User: 83.768 s, System: 24.661 s]
    Range (min … max):   56.109 s … 56.594 s    10 runs

  Benchmark 2: Without ThinLTO cache
    Time (mean ± σ):     67.740 s ±  0.479 s    [User: 718.458 s, System: 31.797 s]
    Range (min … max):   67.059 s … 68.556 s    10 runs

  Summary
    With ThinLTO cache ran
      1.20 ± 0.01 times faster than Without ThinLTO cache

ARCH=x86_64 defconfig + CONFIG_LTO_CLANG_THIN=y on an x86_64 host:

  Benchmark 1: With ThinLTO cache
    Time (mean ± σ):     85.772 s ±  0.252 s    [User: 91.505 s, System: 8.408 s]
    Range (min … max):   85.447 s … 86.244 s    10 runs

  Benchmark 2: Without ThinLTO cache
    Time (mean ± σ):     103.833 s ±  0.288 s    [User: 232.058 s, System: 8.569 s]
    Range (min … max):   103.286 s … 104.124 s    10 runs

  Summary
    With ThinLTO cache ran
      1.21 ± 0.00 times faster than Without ThinLTO cache

While it is unfortunate to take this performance improvement off the
table, correctness is more important. If/when this is fixed in LLVM, it
can potentially be brought back in a conditional manner. Alternatively,
a developer can just disable LTO if doing incremental compiles quickly
is important, as a full compile cycle can still take over a minute even
with the cache and it is unlikely that LTO will result in functional
differences for a kernel change.

Cc: stable@vger.kernel.org
Fixes: dc5723b02e52 ("kbuild: add support for Clang LTO")
Reported-by: Yifan Hong <elsk@google.com>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2021
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Closes: https://lore.kernel.org/r/20220327115526.cc4b0ff55fc53c97683c3e4d@kernel.org/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

diff --git a/Makefile b/Makefile
index 026971f9f6bc..12e1a792b8de 100644
--- a/Makefile
+++ b/Makefile
@@ -942,7 +942,6 @@ endif
 ifdef CONFIG_LTO_CLANG
 ifdef CONFIG_LTO_CLANG_THIN
 CC_FLAGS_LTO	:= -flto=thin -fsplit-lto-unit
-KBUILD_LDFLAGS	+= --thinlto-cache-dir=$(extmod_prefix).thinlto-cache
 else
 CC_FLAGS_LTO	:= -flto
 endif
@@ -1480,7 +1479,7 @@ endif # CONFIG_MODULES
 # Directories & files removed with 'make clean'
 CLEAN_FILES += vmlinux.symvers modules-only.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
-	       compile_commands.json .thinlto-cache rust/test \
+	       compile_commands.json rust/test \
 	       rust-project.json .vmlinux.objs .vmlinux.export.c
 
 # Directories & files removed with 'make mrproper'
@@ -1787,7 +1786,7 @@ PHONY += compile_commands.json
 
 clean-dirs := $(KBUILD_EXTMOD)
 clean: rm-files := $(KBUILD_EXTMOD)/Module.symvers $(KBUILD_EXTMOD)/modules.nsdeps \
-	$(KBUILD_EXTMOD)/compile_commands.json $(KBUILD_EXTMOD)/.thinlto-cache
+	$(KBUILD_EXTMOD)/compile_commands.json
 
 PHONY += prepare
 # now expand this into a simple variable to reduce the cost of shell evaluations


