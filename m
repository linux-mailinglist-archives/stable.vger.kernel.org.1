Return-Path: <stable+bounces-94529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA069D4F1A
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 15:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EC9280F13
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 14:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560FB1E1C33;
	Thu, 21 Nov 2024 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcEVUWq3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3208D1E1A3E
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200265; cv=none; b=Rn9mqJTgCkLm6otCSVdmIWs7CbFicLu5ekCvBZq5ndrIEF4+JCSdMyCCQURK2Lic8MHqQLMonIcrfOh5Vv5Mq+goWBGizwAM28oQL5mrVjO5b9N95FcW5YekmXVWibl937lwT4EPpSwS7VP2E3p3EeBmwyvvkrJggvz7M72mBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200265; c=relaxed/simple;
	bh=h2LubFAKVLo+zmNruMTv15zxKSBqH4BSN9eJ8pEiXnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6vgsvw2IUmg1/2ZwqOurJRA6Z9R+juOH5bVSWDG17ou+ijYT72fyN84HrMi/vDmtj5hsWzjCd5ZY7ILifiMBjMlO/rnUV2oB6ruJ7OcgsgXqPVoKllLFYFUEzssCZ2v7SGam6swJ3rwt8G3QBZb50vSNgVWO4RFyVopstwF8DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcEVUWq3; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b1b224f6c6so62918785a.3
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 06:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732200262; x=1732805062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDOrQbm1R4JuLI2d5IX/F/F3/7FDqPUiQgMfFyQdfCE=;
        b=PcEVUWq3v1LP02G7wjECRIBxZUBZXCmfjFS3x+0uTT3oF3j0XQ6aj8Xs+nPsjikULe
         loKDDvcsUnKy1AGJLy14N0M3RzhZLlon49ZQ2eR+CfyZQfjXZfYNm1TfMQh766za6qPE
         cCNbLBZwkYid4HNkLHG1GEJsVGQS4XqOzDKIPS3HSuCuZ2tF5A0TUqS3jiEbw4XS/cLY
         OdifYUbpe29r0ZHZ2Ww5u5+OwfdKFZN7U515Rm0G1s3yOTnDQ28DnJBYM9I7HHP+MPyF
         Q0kkNXn8k+due0glUi4SIIDSCC35sQpLXVkpBk+Fmm2BSJxjUAnarvbqk8hfZ28s0ox6
         9e9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732200262; x=1732805062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDOrQbm1R4JuLI2d5IX/F/F3/7FDqPUiQgMfFyQdfCE=;
        b=tUZp+soxdMhL/JXg3ia4M1wphOAfhrCN2lnC2yxhtM4dMHBbYscsAjXhORqGMdB8kh
         ngmdmdp/7J1/jPyT3HXh/N/TAplRPfpwkAXvE5YW3Z7osX+jXRErtY5iW6TH/O9RaVSk
         FxpfskItmjtfZa5Xs/AxDVLxDXmJz49oqhyJJDFlzwTt/tR3WFRgHVHUXw8yX1R9I9p1
         htkPOO3c4AhA68gpeF9tchyUjJBiAHxGpfUnV8bcUKfIR2ZgFJ0YfXImIBTOgrX+acGk
         HGhTXdKlNrizJcxyY+aEoJEIHwkLYzCRIV4+9ceG0ZYwGD/HSKEaPjGf7QfzVCqhkKAm
         ENRQ==
X-Gm-Message-State: AOJu0YxFIqkr5wRfWQhE+QRZMW8lG35jlNyqRWDVdnha3mdNtcfYkbsU
	J6osb6rK2Q2wmXMg3ld4aL3OZ3QtAztsbq+iQh34e2M2YVATMLseu44S
X-Gm-Gg: ASbGnct7kpIJvyrk5e4vA97pR2q/8ldYHMXJ+V7Fe/lwX2sU79OtrFSpkPeZgx2T0ha
	tsiEFDb2nR2XCsCZWm+ahWvo/AjrIgtHsxzyN/TEoK3JUkvczeZznZtRAPBahmkqpySDF/FyJjr
	8xLVE6OBiW4MyL/PSQ4ooTRQk+DYNfsOjDWm8jfNFReFQiAv4YSech1R02w+B0qO35oKf0vM2H2
	fq7A43/37GMpAuZW/dZwkyi85sJKac=
X-Google-Smtp-Source: AGHT+IG29t2BAa4/LYzFJcqU4gwwSF/r1K4eWlP5YFAipoDHYS55vuBr0SxXYLCsv4uFBCeLOiFgmw==
X-Received: by 2002:a05:620a:4153:b0:7b1:5070:ca94 with SMTP id af79cd13be357-7b42327fd5bmr931588185a.1.1732200261741;
        Thu, 21 Nov 2024 06:44:21 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b479d2dc5bsm218018585a.24.2024.11.21.06.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 06:44:21 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.15.y] x86/stackprotector: Work around strict Clang TLS symbol requirements
Date: Thu, 21 Nov 2024 09:44:14 -0500
Message-ID: <20241121144414.3607863-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111737-undead-acutely-d4b1@gregkh>
References: <2024111737-undead-acutely-d4b1@gregkh>
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
index 9c09bbd390ce..f8a7d2a65434 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -81,7 +81,8 @@ ifeq ($(CONFIG_X86_32),y)
 
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
index f0cc4c616ceb..5db433cfaaa7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2000,8 +2000,10 @@ EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
 
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+#ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
+#endif
 
 #endif	/* CONFIG_X86_64 */
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 351c604de263..ab36dacb4cc5 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -490,6 +490,9 @@ SECTIONS
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
 
+/* needed for Clang - see arch/x86/entry/entry.S */
+PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
+
 /*
  * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
  */

base-commit: 0a51d2d4527b43c5e467ffa6897deefeaf499358
-- 
2.47.0


