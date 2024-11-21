Return-Path: <stable+bounces-94531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FD69D4F5D
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 16:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C3A2822D4
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAF81D88AD;
	Thu, 21 Nov 2024 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0xJC/QE"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007321CB9F4
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201446; cv=none; b=sCvd3DQkO3UxR3TBHwl6MoA/CvbZbxcsUw1sO/JNpAp1l4QUtx+JrXn0Qcaa6vq7VAXMlVbTmQSpzPOffA4rekIoXn2rf7arQ8EVvS427elUBES3H1q4sQnMqrBqep4JnsmW5+gNBUH+10bx9VHYlxXjYinacJus0UYdoUGH6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201446; c=relaxed/simple;
	bh=LvugFqv0+1oVUNNvPP6LVxXhYO5adO0euxo/LpdT6LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pnxte79YTEmTIecjuJOg6XFNGJtbUbaCZESNsMPnS7M09+Hx+cXGCloancUSTmyJRCjLYaL1bW0xZKGYurlRP1smzgZ/RxTPutHU3QkDBbX0uJC7n8/mWZairD7b770ASNBCNVA8xlASAxUkvro8Jb/4xGvbc0sLoa52yJCnX8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0xJC/QE; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d41eeca2d6so6976156d6.1
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 07:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732201443; x=1732806243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZMJoGG/5mTMLqmC3CQAavSeszAwcZkn5VJ43qJAjVU=;
        b=S0xJC/QEsr09RQrelNU3cdH6dlz6dQYprxql9aVSmjky8efFVugkShqfhk1qAuoi4z
         R1K22tDqF47/qbx2HHb0OiYmJBU3zc1RnPmxqLHBEy8NdZrWWeeF7aK8D8Wz6c7wfgzw
         9cs1bzpFNDMd4VkxL4uYuYIU2SaS+958XWvQk48aa/H0OzudnD7tJdWN/CR+o8oUHlXz
         ijrEemqNlrLmGQONSu0/MEJcaRPVP/SiYy4Koji8cGZYK/IDif6JeLaPsXsuP3NFD2zk
         EIuCEAW+n5nm/MBgux74NazcSvbCTiWWJH1ABhwKymEikTsB8BRiQXWssNGgMBEl8NjJ
         zjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732201443; x=1732806243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZMJoGG/5mTMLqmC3CQAavSeszAwcZkn5VJ43qJAjVU=;
        b=IjsMfmOW797OK7Ry5UjwR++bsFgXGh7xB9Cmai+E/yXuJWQ5o4cXPbDgIBqHAW1uq5
         1Lftq+ND8GidczBrCZbNIK5gs3S+ypAcu2g0M2gqAbEUTVY9D38y3NupjMuoDibfumXL
         OCj9SHQ6/M07OzkTlBHg8oV/8Po/mXSKhpv7uvqmpprPrDjkKJY0t9CCPSQ7mvkcd/ge
         BHlZo0S6J8og9qpCGD7SWfq3Md8eqmf9q3bBz43KprpChatT3m9xX3DAOO0he76G18Tg
         h1+oDdxA+aJhdOlCh7GUnpGKr/go1hY06nBSD2bSgemBYtNtjYUFOofu6Eyl7N41YsS9
         8Q7Q==
X-Gm-Message-State: AOJu0YzXIlsa21KrDayEWyaDaf4toMAla0A3rsZf5S1TRuHGX6Bl/06E
	Q5Lta0yxNzCB3CsPHcQRpenXE+kzr04zWaS2Gw5pWrAX5HdQbnq6yKYx
X-Gm-Gg: ASbGncs8rzuSNeaydoYilQadTvpRcoGuQ1iCDj6+wdmmXI9jwcSiojwYSlqEH3HeRS5
	XEqgJX0eUA+BVgRs5aFZU70/EkAwh1l3zIpJlOXF1wxj7BDyrIGUvNMtNfMEy655egXZr85sRR6
	IE+EkM2vfSj060zLYkihWK+PdUl5dxKZU+u2dVaGIx1uMycngtrRaEIxm/cXquaBSJu3UnwIiXa
	iX7r1kJvgR7c5x2YYyvqu8V5pwmREU=
X-Google-Smtp-Source: AGHT+IHMSNTN6R+z8dDFOFqzYTdlxNJN1W6I6pGThetpZIHmD8TiPpvSmVy8VGW/EcG+LHi/kbNa5Q==
X-Received: by 2002:ad4:5969:0:b0:6cb:fa1c:87da with SMTP id 6a1803df08f44-6d4378283a8mr74930496d6.38.1732201443370;
        Thu, 21 Nov 2024 07:04:03 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d438133cfasm24327246d6.100.2024.11.21.07.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:04:02 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.1.y] x86/stackprotector: Work around strict Clang TLS symbol requirements
Date: Thu, 21 Nov 2024 10:03:37 -0500
Message-ID: <20241121150337.3667598-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111736-handshake-thesaurus-43e6@gregkh>
References: <2024111736-handshake-thesaurus-43e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ard Biesheuvel <ardb@kernel.org>

GCC and Clang both implement stack protector support based on Thread Local
Storage (TLS) variables, and this is used in the kernel to implement per-task
stack cookies, by copying a task's stack cookie into a per-CPU variable every
time it is scheduled in.

Both now also implement -mstack-protector-guard-symbol=, which permits the TLS
variable to be specified directly. This is useful because it will allow to
move away from using a fixed offset of 40 bytes into the per-CPU area on
x86_64, which requires a lot of special handling in the per-CPU code and the
runtime relocation code.

However, while GCC is rather lax in its implementation of this command line
option, Clang actually requires that the provided symbol name refers to a TLS
variable (i.e., one declared with __thread), although it also permits the
variable to be undeclared entirely, in which case it will use an implicit
declaration of the right type.

The upshot of this is that Clang will emit the correct references to the stack
cookie variable in most cases, e.g.,

  10d:       64 a1 00 00 00 00       mov    %fs:0x0,%eax
                     10f: R_386_32   __stack_chk_guard

However, if a non-TLS definition of the symbol in question is visible in the
same compilation unit (which amounts to the whole of vmlinux if LTO is
enabled), it will drop the per-CPU prefix and emit a load from a bogus
address.

Work around this by using a symbol name that never occurs in C code, and emit
it as an alias in the linker script.

Fixes: 3fb0fdb3bbe7 ("x86/stackprotector/32: Make the canary into a regular percpu variable")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org
Link: https://github.com/ClangBuiltLinux/linux/issues/1854
Link: https://lore.kernel.org/r/20241105155801.1779119-2-brgerst@gmail.com
(cherry picked from commit 577c134d311b9b94598d7a0c86be1f431f823003)
---
 arch/x86/Makefile                     |  3 ++-
 arch/x86/entry/entry.S                | 15 +++++++++++++++
 arch/x86/include/asm/asm-prototypes.h |  3 +++
 arch/x86/kernel/cpu/common.c          |  2 ++
 arch/x86/kernel/vmlinux.lds.S         |  3 +++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 3419ffa2a350..a88eede6e7db 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -113,7 +113,8 @@ ifeq ($(CONFIG_X86_32),y)
 
 	ifeq ($(CONFIG_STACKPROTECTOR),y)
 		ifeq ($(CONFIG_SMP),y)
-			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
+			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
+					 -mstack-protector-guard-symbol=__ref_stack_chk_guard
 		else
 			KBUILD_CFLAGS += -mstack-protector-guard=global
 		endif
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index f4419afc7147..23f9efbe9d70 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -48,3 +48,18 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
 
 .popsection
 
+#ifndef CONFIG_X86_64
+/*
+ * Clang's implementation of TLS stack cookies requires the variable in
+ * question to be a TLS variable. If the variable happens to be defined as an
+ * ordinary variable with external linkage in the same compilation unit (which
+ * amounts to the whole of vmlinux with LTO enabled), Clang will drop the
+ * segment register prefix from the references, resulting in broken code. Work
+ * around this by avoiding the symbol used in -mstack-protector-guard-symbol=
+ * entirely in the C code, and use an alias emitted by the linker script
+ * instead.
+ */
+#ifdef CONFIG_STACKPROTECTOR
+EXPORT_SYMBOL(__ref_stack_chk_guard);
+#endif
+#endif
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 5cdccea45554..390b13db24b8 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -18,3 +18,6 @@
 extern void cmpxchg8b_emu(void);
 #endif
 
+#if defined(__GENKSYMS__) && defined(CONFIG_STACKPROTECTOR)
+extern unsigned long __ref_stack_chk_guard;
+#endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7f922a359ccc..b4e999048e9a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2158,8 +2158,10 @@ EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
 
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+#ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
+#endif
 
 #endif	/* CONFIG_X86_64 */
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 78ccb5ec3c0e..c1e776ed71b0 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -486,6 +486,9 @@ SECTIONS
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
 
+/* needed for Clang - see arch/x86/entry/entry.S */
+PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
+
 /*
  * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
  */

base-commit: b67dc5c9ade9dc354b790eb64aa6a665d0a54ecd
-- 
2.47.0


