Return-Path: <stable+bounces-15330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30438838570
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC35B25A2F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4244D76913;
	Tue, 23 Jan 2024 02:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fCDG6vUh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40EA74E23;
	Tue, 23 Jan 2024 02:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975495; cv=none; b=ugg7BVqmDPpOCFkR4IF8RfqiG0CtxSX3XyygEbFcYxWirqbYFlic2Po2xL6h4nIrPsdmfOq/mxPIes+i0Ya3JalxkJWaCIxOpGHCfExigrJgEl02zuP+VbImHx5t55a3LiVeuWOrnhy9kAoUoMieKgEbmSdEWjFZT9RlCwg+co8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975495; c=relaxed/simple;
	bh=ZvHcSKp9/mbQFrZZdNdIRXx48UaKO7wuod20Yhp/xJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlDzc1fInlvdw2BTJ+smnfukUWp4bvu2W5mWD1zUMiJVZQjNuYOUbLA97+LLyLp8oyRqAc0zDXaLsFPzPzagCUFbxRfjtZqD99j3DaZaouDp+FR8UxDhemTanoLND+wELKjqymdlnsUo4ANvtadXYz+EzHSvfbRJBK4iGySIShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fCDG6vUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90EBC43390;
	Tue, 23 Jan 2024 02:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975494;
	bh=ZvHcSKp9/mbQFrZZdNdIRXx48UaKO7wuod20Yhp/xJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCDG6vUhHgmXfcpMF3O5o9XXc5qzQNUdUlBr5H12CuItgiH5H4wrUn0TIgN5KrHmE
	 948yylMHgdxy96RAiweTkB1PKVf4jqvmMTx7tve+0uYI8lCw4jWKQ1M0WXcm9kdICB
	 OAZeSlbu7aWBGB2aXN1u5AWRWsng2hJWPsdjgXhg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 449/583] riscv: Check if the code to patch lies in the exit section
Date: Mon, 22 Jan 2024 15:58:20 -0800
Message-ID: <20240122235825.718102658@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

From: Alexandre Ghiti <alexghiti@rivosinc.com>

[ Upstream commit 420370f3ae3d3b883813fd3051a38805160b2b9f ]

Otherwise we fall through to vmalloc_to_page() which panics since the
address does not lie in the vmalloc region.

Fixes: 043cb41a85de ("riscv: introduce interfaces to patch kernel code")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Link: https://lore.kernel.org/r/20231214091926.203439-1-alexghiti@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/sections.h   |  1 +
 arch/riscv/kernel/patch.c           | 11 ++++++++++-
 arch/riscv/kernel/vmlinux-xip.lds.S |  2 ++
 arch/riscv/kernel/vmlinux.lds.S     |  2 ++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
index 32336e8a17cb..a393d5035c54 100644
--- a/arch/riscv/include/asm/sections.h
+++ b/arch/riscv/include/asm/sections.h
@@ -13,6 +13,7 @@ extern char _start_kernel[];
 extern char __init_data_begin[], __init_data_end[];
 extern char __init_text_begin[], __init_text_end[];
 extern char __alt_start[], __alt_end[];
+extern char __exittext_begin[], __exittext_end[];
 
 static inline bool is_va_kernel_text(uintptr_t va)
 {
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 13ee7bf589a1..37e87fdcf6a0 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -14,6 +14,7 @@
 #include <asm/fixmap.h>
 #include <asm/ftrace.h>
 #include <asm/patch.h>
+#include <asm/sections.h>
 
 struct patch_insn {
 	void *addr;
@@ -25,6 +26,14 @@ struct patch_insn {
 int riscv_patch_in_stop_machine = false;
 
 #ifdef CONFIG_MMU
+
+static inline bool is_kernel_exittext(uintptr_t addr)
+{
+	return system_state < SYSTEM_RUNNING &&
+		addr >= (uintptr_t)__exittext_begin &&
+		addr < (uintptr_t)__exittext_end;
+}
+
 /*
  * The fix_to_virt(, idx) needs a const value (not a dynamic variable of
  * reg-a0) or BUILD_BUG_ON failed with "idx >= __end_of_fixed_addresses".
@@ -35,7 +44,7 @@ static __always_inline void *patch_map(void *addr, const unsigned int fixmap)
 	uintptr_t uintaddr = (uintptr_t) addr;
 	struct page *page;
 
-	if (core_kernel_text(uintaddr))
+	if (core_kernel_text(uintaddr) || is_kernel_exittext(uintaddr))
 		page = phys_to_page(__pa_symbol(addr));
 	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
 		page = vmalloc_to_page(addr);
diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
index 50767647fbc6..8c3daa1b0531 100644
--- a/arch/riscv/kernel/vmlinux-xip.lds.S
+++ b/arch/riscv/kernel/vmlinux-xip.lds.S
@@ -29,10 +29,12 @@ SECTIONS
 	HEAD_TEXT_SECTION
 	INIT_TEXT_SECTION(PAGE_SIZE)
 	/* we have to discard exit text and such at runtime, not link time */
+	__exittext_begin = .;
 	.exit.text :
 	{
 		EXIT_TEXT
 	}
+	__exittext_end = .;
 
 	.text : {
 		_text = .;
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 492dd4b8f3d6..002ca58dd998 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -69,10 +69,12 @@ SECTIONS
 		__soc_builtin_dtb_table_end = .;
 	}
 	/* we have to discard exit text and such at runtime, not link time */
+	__exittext_begin = .;
 	.exit.text :
 	{
 		EXIT_TEXT
 	}
+	__exittext_end = .;
 
 	__init_text_end = .;
 	. = ALIGN(SECTION_ALIGN);
-- 
2.43.0




