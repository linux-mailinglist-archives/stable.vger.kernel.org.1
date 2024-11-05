Return-Path: <stable+bounces-89853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E61059BD13E
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B8D1F21DD5
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 15:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304831547D7;
	Tue,  5 Nov 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/AdAzqC"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD61384B3;
	Tue,  5 Nov 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822298; cv=none; b=Yne7bSzBbpD88N46pppSMdWFhUM8cgr2WS0YJWV/5rCU6dT6evID6VLSFDH5eO41KQKAMF17ICbwwUCRYSIRHh+yONb4zamuSsi5iiJn6zb+79Fg7DLfLumDfTRxBmav6uBbBWZnt+Z3loosOg8bxANhoU6PSFL5OGg6PP0yIDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822298; c=relaxed/simple;
	bh=NX7H3MvTsW9DRuBwQkrInDdn6GS/Et44Ott+QFyFoiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ui5geVrytqfh+h8MXtuqiG66lBcA8WQrDD2oVIeRcncNBJxSWXUC1ZHKXeSx/2DO3Qi7nWTZ5TC1dLc5q4ip0HKK2P38lS4YrDjsT95EG6qqlZRC32beMJKFpimU0gI1mrYqSTosM0vGHV2xsuEyfGhJqJL4GXyW3xzaoDTf98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/AdAzqC; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b15467f383so395769485a.3;
        Tue, 05 Nov 2024 07:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822296; x=1731427096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSGF9RIONMCy+lm6lwN/0OP9d1KIw8FJWDz+4Vvo1qE=;
        b=J/AdAzqCnJ9qVn4IyYKBuJ2T4Dwx/RQzrWNuRjCi5uJ1l4D3nYrUqOYA2KBBm8zxVF
         KZJsgud7N5bX0CVwHZ8+AsHCHECa4QAgpSgNecWCq2obK+t4gHGF/14/bowyWy9PgbSQ
         LR5NkqT9UCNul0Pn2gs2h0M1DVATvYqQIabjioQz1oYdfZPtRVbhFKVHbqpJVHfRhKX9
         Kao3lCrh82HO3VEeRanjIk0Gz7kzLZk/Z7VmRyg7L7tKIsBLzad3KtUJnTx1EJq9H4yB
         9xuvViseKSTb5zxVegbx6jdErxvRAzfzxWsiqaoonGw4XTkFZohBy3S0OiGTB6jGhtf5
         rqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822296; x=1731427096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSGF9RIONMCy+lm6lwN/0OP9d1KIw8FJWDz+4Vvo1qE=;
        b=Bg293YVBCncqblGq7fNkft9zxH4iW7RPHXg7ZArlRiRs7GLiIyVSqD6TtflniKS7vW
         AMrnGdZE4FAnkH6yqwps6F4U2ZpBov1tOpzOMlKLbQSyQWjRghLHNp2gxeBM+zBT5ald
         SnRJFK07bWhSMxF+1OKGFa0Etlql4FBno4eODsOnI3+N7BJlelqOLiq5IqhiJUyb3Wxy
         4dOwsgyw41MgYaJg93uhdiShZQIiIHvU5Lt86doq+CFlo44guWlpOcjzTmiUndXAp0QU
         Apy2+Lm2qXQ8hnO6r/Z8mAIA04e62xoz6pBLfraia1iFDVS8qNlvEuEeyB5Yo8SJZTCE
         x24w==
X-Forwarded-Encrypted: i=1; AJvYcCU0lz5n4CFmSbXZB9aKBn67l2btMc+2ANqzqKOLLl1inQyZGToDSHRmFwDuO6LwJRd/cIwbgxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEeunP4KFuVDw/Xn4eqn/ZtjdbPqvPhsLEdLayxwTbvNNOXDVd
	OR0R/neoO2K48yYodrN9NOepjtzqRPz3wwk12AIm7Kx718v4dE54P9kI
X-Google-Smtp-Source: AGHT+IF72m9JE3C6mYCC457d4K6hcqs2XKMqtnJi7ytPhEDIUKBZ/dL5xKmqM82I1eo3ZS58f4hvyw==
X-Received: by 2002:a05:6214:2c10:b0:6d3:452d:e1a1 with SMTP id 6a1803df08f44-6d351ad3f37mr263141716d6.31.1730822295721;
        Tue, 05 Nov 2024 07:58:15 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:15 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>,
	Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v5 01/16] x86/stackprotector: Work around strict Clang TLS symbol requirements
Date: Tue,  5 Nov 2024 10:57:46 -0500
Message-ID: <20241105155801.1779119-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ard Biesheuvel <ardb@kernel.org>

GCC and Clang both implement stack protector support based on Thread
Local Storage (TLS) variables, and this is used in the kernel to
implement per-task stack cookies, by copying a task's stack cookie into
a per-CPU variable every time it is scheduled in.

Both now also implement -mstack-protector-guard-symbol=, which permits
the TLS variable to be specified directly. This is useful because it
will allow us to move away from using a fixed offset of 40 bytes into
the per-CPU area on x86_64, which requires a lot of special handling in
the per-CPU code and the runtime relocation code.

However, while GCC is rather lax in its implementation of this command
line option, Clang actually requires that the provided symbol name
refers to a TLS variable (i.e., one declared with __thread), although it
also permits the variable to be undeclared entirely, in which case it
will use an implicit declaration of the right type.

The upshot of this is that Clang will emit the correct references to the
stack cookie variable in most cases, e.g.,

   10d:       64 a1 00 00 00 00       mov    %fs:0x0,%eax
                      10f: R_386_32   __stack_chk_guard

However, if a non-TLS definition of the symbol in question is visible in
the same compilation unit (which amounts to the whole of vmlinux if LTO
is enabled), it will drop the per-CPU prefix and emit a load from a
bogus address.

Work around this by using a symbol name that never occurs in C code, and
emit it as an alias in the linker script.

Fixes: 3fb0fdb3bbe7 ("x86/stackprotector/32: Make the canary into a regular percpu variable")
Cc: <stable@vger.kernel.org>
Cc: Fangrui Song <i@maskray.me>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://github.com/ClangBuiltLinux/linux/issues/1854
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Makefile                     |  5 +++--
 arch/x86/entry/entry.S                | 16 ++++++++++++++++
 arch/x86/include/asm/asm-prototypes.h |  3 +++
 arch/x86/kernel/cpu/common.c          |  2 ++
 arch/x86/kernel/vmlinux.lds.S         |  3 +++
 5 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index cd75e78a06c1..5b773b34768d 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -142,9 +142,10 @@ ifeq ($(CONFIG_X86_32),y)
 
     ifeq ($(CONFIG_STACKPROTECTOR),y)
         ifeq ($(CONFIG_SMP),y)
-			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
+            KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
+                             -mstack-protector-guard-symbol=__ref_stack_chk_guard
         else
-			KBUILD_CFLAGS += -mstack-protector-guard=global
+            KBUILD_CFLAGS += -mstack-protector-guard=global
         endif
     endif
 else
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index 324686bca368..b7ea3e8e9ecc 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -51,3 +51,19 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
 .popsection
 
 THUNK warn_thunk_thunk, __warn_thunk
+
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
index 25466c4d2134..3674006e3974 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -20,3 +20,6 @@
 extern void cmpxchg8b_emu(void);
 #endif
 
+#if defined(__GENKSYMS__) && defined(CONFIG_STACKPROTECTOR)
+extern unsigned long __ref_stack_chk_guard;
+#endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8f41ab219cf1..9d42bd15e06c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2091,8 +2091,10 @@ void syscall_init(void)
 
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+#ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
+#endif
 
 #endif	/* CONFIG_X86_64 */
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 410546bacc0f..d61c3584f3e6 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -468,6 +468,9 @@ SECTIONS
 . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
 
+/* needed for Clang - see arch/x86/entry/entry.S */
+PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
+
 #ifdef CONFIG_X86_64
 /*
  * Per-cpu symbols which need to be offset from __per_cpu_load
-- 
2.47.0


