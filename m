Return-Path: <stable+bounces-178711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78594B47FC2
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F8C1B21AED
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4CD2139C9;
	Sun,  7 Sep 2025 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SmID/3K3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E84315A;
	Sun,  7 Sep 2025 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277713; cv=none; b=uUR7j5lmf143Nek6IKGNyNUFTgf1o+/nJdmGQiHCfBCBIBYoIAAPInUBWUAQNfRLUPpwUBoAX83LKGLlzHtOc6lFYA7HvL+rURpnw2nY8/LzKxc8TPgZwYXTx/QXj/djCkntskFTYVnaqCUj47D2X3Dn5OAU5kU1/9CouhCT4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277713; c=relaxed/simple;
	bh=XBLDfctorflYFSe+mAMljFF3D/SxtNOB2hq7qYgjQfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NL03Q5e+KZvaX2alJ//vbTpFZ0sXMOgOcqyGFd76DiJKDXB04eFFDBcWoELC9UyN9Pq9P1Tec3B2COlDn5n9ACVFZDK3LHhR3meySuW2X1ofvItaM3GsUcWmWUVNCY4S9dsouQ2Tf6UE0rBT3g3/Fmh3Es2VanHXAa6z5KoKYWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SmID/3K3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C993EC4CEF0;
	Sun,  7 Sep 2025 20:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277713;
	bh=XBLDfctorflYFSe+mAMljFF3D/SxtNOB2hq7qYgjQfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmID/3K3FJU7WuVCGdzS3NgwlVsBbiap1HGTmxUDpkW5imqSJBHPPuyKt3EPdg3C9
	 lmZ3pSvlTJzGjetXqwNW12tYWF7fx6Cn4BOfGqzCXNp7rbFRDYBTcLv/lkhSpR6Ytw
	 rb3iVU4oVLOJ+mN5f9srakdhOOL0WukNBoyV32wU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	panfan <panfan@qti.qualcomm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.16 099/183] arm64: ftrace: fix unreachable PLT for ftrace_caller in init_module with CONFIG_DYNAMIC_FTRACE
Date: Sun,  7 Sep 2025 21:58:46 +0200
Message-ID: <20250907195618.139035460@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: panfan <panfan@qti.qualcomm.com>

commit a7ed7b9d0ebb038db9963d574da0311cab0b666a upstream.

On arm64, it has been possible for a module's sections to be placed more
than 128M away from each other since commit:

  commit 3e35d303ab7d ("arm64: module: rework module VA range selection")

Due to this, an ftrace callsite in a module's .init.text section can be
out of branch range for the module's ftrace PLT entry (in the module's
.text section). Any attempt to enable tracing of that callsite will
result in a BRK being patched into the callsite, resulting in a fatal
exception when the callsite is later executed.

Fix this by adding an additional trampoline for .init.text, which will
be within range.

No additional trampolines are necessary due to the way a given
module's executable sections are packed together. Any executable
section beginning with ".init" will be placed in MOD_INIT_TEXT,
and any other executable section, including those beginning with ".exit",
 will be placed in MOD_TEXT.

Fixes: 3e35d303ab7d ("arm64: module: rework module VA range selection")
Cc: <stable@vger.kernel.org> # 6.5.x
Signed-off-by: panfan <panfan@qti.qualcomm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250905032236.3220885-1-panfan@qti.qualcomm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/module.h     |    1 +
 arch/arm64/include/asm/module.lds.h |    1 +
 arch/arm64/kernel/ftrace.c          |   13 ++++++++++---
 arch/arm64/kernel/module-plts.c     |   12 +++++++++++-
 arch/arm64/kernel/module.c          |   11 +++++++++++
 5 files changed, 34 insertions(+), 4 deletions(-)

--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -19,6 +19,7 @@ struct mod_arch_specific {
 
 	/* for CONFIG_DYNAMIC_FTRACE */
 	struct plt_entry	*ftrace_trampolines;
+	struct plt_entry	*init_ftrace_trampolines;
 };
 
 u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
--- a/arch/arm64/include/asm/module.lds.h
+++ b/arch/arm64/include/asm/module.lds.h
@@ -2,6 +2,7 @@ SECTIONS {
 	.plt 0 : { BYTE(0) }
 	.init.plt 0 : { BYTE(0) }
 	.text.ftrace_trampoline 0 : { BYTE(0) }
+	.init.text.ftrace_trampoline 0 : { BYTE(0) }
 
 #ifdef CONFIG_KASAN_SW_TAGS
 	/*
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -258,10 +258,17 @@ int ftrace_update_ftrace_func(ftrace_fun
 	return ftrace_modify_code(pc, 0, new, false);
 }
 
-static struct plt_entry *get_ftrace_plt(struct module *mod)
+static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
 {
 #ifdef CONFIG_MODULES
-	struct plt_entry *plt = mod->arch.ftrace_trampolines;
+	struct plt_entry *plt = NULL;
+
+	if (within_module_mem_type(addr, mod, MOD_INIT_TEXT))
+		plt = mod->arch.init_ftrace_trampolines;
+	else if (within_module_mem_type(addr, mod, MOD_TEXT))
+		plt = mod->arch.ftrace_trampolines;
+	else
+		return NULL;
 
 	return &plt[FTRACE_PLT_IDX];
 #else
@@ -332,7 +339,7 @@ static bool ftrace_find_callable_addr(st
 	if (WARN_ON(!mod))
 		return false;
 
-	plt = get_ftrace_plt(mod);
+	plt = get_ftrace_plt(mod, pc);
 	if (!plt) {
 		pr_err("ftrace: no module PLT for %ps\n", (void *)*addr);
 		return false;
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -283,7 +283,7 @@ int module_frob_arch_sections(Elf_Ehdr *
 	unsigned long core_plts = 0;
 	unsigned long init_plts = 0;
 	Elf64_Sym *syms = NULL;
-	Elf_Shdr *pltsec, *tramp = NULL;
+	Elf_Shdr *pltsec, *tramp = NULL, *init_tramp = NULL;
 	int i;
 
 	/*
@@ -298,6 +298,9 @@ int module_frob_arch_sections(Elf_Ehdr *
 		else if (!strcmp(secstrings + sechdrs[i].sh_name,
 				 ".text.ftrace_trampoline"))
 			tramp = sechdrs + i;
+		else if (!strcmp(secstrings + sechdrs[i].sh_name,
+				 ".init.text.ftrace_trampoline"))
+			init_tramp = sechdrs + i;
 		else if (sechdrs[i].sh_type == SHT_SYMTAB)
 			syms = (Elf64_Sym *)sechdrs[i].sh_addr;
 	}
@@ -363,5 +366,12 @@ int module_frob_arch_sections(Elf_Ehdr *
 		tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
 	}
 
+	if (init_tramp) {
+		init_tramp->sh_type = SHT_NOBITS;
+		init_tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+		init_tramp->sh_addralign = __alignof__(struct plt_entry);
+		init_tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
+	}
+
 	return 0;
 }
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -453,6 +453,17 @@ static int module_init_ftrace_plt(const
 	__init_plt(&plts[FTRACE_PLT_IDX], FTRACE_ADDR);
 
 	mod->arch.ftrace_trampolines = plts;
+
+	s = find_section(hdr, sechdrs, ".init.text.ftrace_trampoline");
+	if (!s)
+		return -ENOEXEC;
+
+	plts = (void *)s->sh_addr;
+
+	__init_plt(&plts[FTRACE_PLT_IDX], FTRACE_ADDR);
+
+	mod->arch.init_ftrace_trampolines = plts;
+
 #endif
 	return 0;
 }



