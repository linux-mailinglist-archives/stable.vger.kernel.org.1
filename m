Return-Path: <stable+bounces-52094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D43907B8D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 20:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE9D1C22173
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447B414EC54;
	Thu, 13 Jun 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2SgGcVf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0517514E2D8
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303684; cv=none; b=FbbHwYI1EK2QoV7VbSolvC321sWFU3sQ8+30saRIyYyYVm99ixsRPHwDhWf/oUaYUP2CA1z/PuZfqf6X8Rakiz/Rs5IDIBBZXa9OiYrFIV6tAVx64etKWWMU4QpyN0xpU6lBZpCBLdxafq4OJMfZXWo73AV+zfobhgwW0j/76jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303684; c=relaxed/simple;
	bh=Txm9mh0/5FDR2ZbpbTweYw6FC848CA8XoG3IhX2bJhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcwSJEap18OzXWvrrz/wkGySqiDYK7Fx0cfpmtpwH11IoSoagXW4Us39pxi7fYh+hCO7cGCPsI5Cc7ndSDXXSJ6cAS4jrMENtkjfcunS2Ro6tVVHBiyzvSinjAsYu/c4J2V+Qm25fr3jT62M1L29j2HsUtXaalS4jIcQzXaKfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2SgGcVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE4CC4AF1C;
	Thu, 13 Jun 2024 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718303683;
	bh=Txm9mh0/5FDR2ZbpbTweYw6FC848CA8XoG3IhX2bJhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c2SgGcVf8b8dB+IDRlEXlQwVJR2ZrTeHkEfeNDZ7KD56f6UwEwnKfg19KnpbuKnfj
	 VmZdJKRXqK4H3LauN1pzqF0ChfY46FyPyhT6CJ+SiifEaARp/GSxoq1qPEgkV8MtsD
	 OX4Ixl95ofbvBfXVhoOPI9uG8LCU9fZfR896b8oRFrgLItYu3599VMUoVMFVeAwDRv
	 Hxnt0jv159VQ/ses6Gi9VjW8H2CVE2UFDF2GDMtZEqDGD8L/YLctQ4Dh9zlQgLgV5V
	 YJySevvW2c03t5ugi/GTdgIdWAqbQiJwFtLZjTXYY2I+T/7XrZZGGkLQvOBbPs8lCO
	 ozOAKyDxHE3pw==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org
Cc: nathan@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y] kbuild: Remove support for Clang's ThinLTO caching
Date: Thu, 13 Jun 2024 11:34:27 -0700
Message-ID: <20240613183427.1088868-1-nathan@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024061342-unimpeded-hardcover-349c@gregkh>
References: <2024061342-unimpeded-hardcover-349c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit aba091547ef6159d52471f42a3ef531b7b660ed8 upstream.

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
[nathan: Address conflict in Makefile]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index bfc863d71978..a9118f982484 100644
--- a/Makefile
+++ b/Makefile
@@ -959,7 +959,6 @@ endif
 ifdef CONFIG_LTO_CLANG
 ifdef CONFIG_LTO_CLANG_THIN
 CC_FLAGS_LTO	:= -flto=thin -fsplit-lto-unit
-KBUILD_LDFLAGS	+= --thinlto-cache-dir=$(extmod_prefix).thinlto-cache
 else
 CC_FLAGS_LTO	:= -flto
 endif
@@ -1560,7 +1559,7 @@ endif # CONFIG_MODULES
 # Directories & files removed with 'make clean'
 CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
-	       compile_commands.json .thinlto-cache
+	       compile_commands.json
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_FILES += include/config include/generated          \
@@ -1788,7 +1787,7 @@ PHONY += compile_commands.json
 
 clean-dirs := $(KBUILD_EXTMOD)
 clean: rm-files := $(KBUILD_EXTMOD)/Module.symvers $(KBUILD_EXTMOD)/modules.nsdeps \
-	$(KBUILD_EXTMOD)/compile_commands.json $(KBUILD_EXTMOD)/.thinlto-cache
+	$(KBUILD_EXTMOD)/compile_commands.json
 
 PHONY += prepare
 # now expand this into a simple variable to reduce the cost of shell evaluations

base-commit: c61bd26ae81a896c8660150b4e356153da30880a
-- 
2.45.2


