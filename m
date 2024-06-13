Return-Path: <stable+bounces-51204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1435906ED1
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD65B24797
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50679144306;
	Thu, 13 Jun 2024 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RwcdhWsD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8426EB56;
	Thu, 13 Jun 2024 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280612; cv=none; b=tfAVUFMlF/kg0AAeefdFafDy99hwxgu4S+ERXW63i0dHhNOImzT+xCL4Mydf/7J+sS5ak+MZxc36G9BlIQYGWYL5hUnIQgGCsXriqwPNu7U+LfzfLiCOd3vAcIx7saZ+4YWgHG9BHMma/Imof3pDpD3rji/uElN1ttmXOp12oCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280612; c=relaxed/simple;
	bh=7VtDmbdM+ObCENOkh8EeF6swZvrsRH//oCvw79rp/g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzM8ij6xWHtEOt41G90k/u5uVjjC5mnNDusm2MigsgH7aP2IrBeCVVIV5MU2HSOhlUf+p3Y/E/9SBNH0KYbJY3Ivv4E71a8EGg1a32HF/Ba3XFfDqNbIPvsRaEElrdb8SH2qq7yiCRB6Am/HrRQXOWrrBewxl5PMlbCj47I5fdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RwcdhWsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8978DC32786;
	Thu, 13 Jun 2024 12:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280611;
	bh=7VtDmbdM+ObCENOkh8EeF6swZvrsRH//oCvw79rp/g0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RwcdhWsDTfzPVCZ8fLziIOgN3FBU7g81vt92djpYv12ItnA8gUQReQDVHTlAobxrK
	 UuN0SUGaZTtZ1Ew1syo+aAet7ry+oUXG4/v1DJRYJK5/qBhSfRRS+KCxVOXyzz6Tij
	 kBTLYJ2AwTz2PApKV5Y3R6qN+8dnlpP1R9X9SmxA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Hong <elsk@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6.6 072/137] kbuild: Remove support for Clangs ThinLTO caching
Date: Thu, 13 Jun 2024 13:34:12 +0200
Message-ID: <20240613113226.090206213@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -951,7 +951,6 @@ endif
 ifdef CONFIG_LTO_CLANG
 ifdef CONFIG_LTO_CLANG_THIN
 CC_FLAGS_LTO	:= -flto=thin -fsplit-lto-unit
-KBUILD_LDFLAGS	+= --thinlto-cache-dir=$(extmod_prefix).thinlto-cache
 else
 CC_FLAGS_LTO	:= -flto
 endif
@@ -1482,7 +1481,7 @@ endif # CONFIG_MODULES
 # Directories & files removed with 'make clean'
 CLEAN_FILES += vmlinux.symvers modules-only.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
-	       compile_commands.json .thinlto-cache rust/test \
+	       compile_commands.json rust/test \
 	       rust-project.json .vmlinux.objs .vmlinux.export.c
 
 # Directories & files removed with 'make mrproper'
@@ -1786,7 +1785,7 @@ PHONY += compile_commands.json
 
 clean-dirs := $(KBUILD_EXTMOD)
 clean: rm-files := $(KBUILD_EXTMOD)/Module.symvers $(KBUILD_EXTMOD)/modules.nsdeps \
-	$(KBUILD_EXTMOD)/compile_commands.json $(KBUILD_EXTMOD)/.thinlto-cache
+	$(KBUILD_EXTMOD)/compile_commands.json
 
 PHONY += prepare
 # now expand this into a simple variable to reduce the cost of shell evaluations



