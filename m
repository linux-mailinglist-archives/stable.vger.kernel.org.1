Return-Path: <stable+bounces-33750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0057A89233A
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 19:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56835B22112
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 18:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C404B85C7D;
	Fri, 29 Mar 2024 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KvArXdXM"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CC18AF8
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736317; cv=none; b=XlQ4pNP78nVsd7EvCZkJjqUng3O+dYj1acOGUBZxV1Kh8mwA9F7Y60O1xEmw/moLuXyvRMdIG5Uy+bQIc570b8qq2M6l6MfAF0jCvBsC8xWlR7YZdYIJJfggQeAT5DuMpIbON6ArFF6Du0Fpu1tNdIk/MCkX/FvVbI5dKD5rrNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736317; c=relaxed/simple;
	bh=6DIbpxLB0fbnuC7zyKV2FtO/U/eDxScrH0xxnrMy/iE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OeG9Ks0UQgNR8iie2uWKokBSoW5Jpd85XGdC7X87V9/f2kN3jGF7soW4gZXA3lsqk9Gk0AkLu87Z7lfGnX/Tn+R2bV8+IkpivzTQ7LSe0NpkkJbZkXAUkHVmcZnz/Wwt1Gv7rDqx9gGh9so5f4cBsgGVoPStJU+R9B9UytshlYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KvArXdXM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so2758284276.2
        for <stable@vger.kernel.org>; Fri, 29 Mar 2024 11:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711736315; x=1712341115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4IbtfZjO4pa+6IR5sXD2UiwAyZgAWe0Fs1q0AVxLp4=;
        b=KvArXdXM/p5/AyPqGPdQ3jtn9efcQkIMXUS7/IkP5kqRVucAapWfODgXcV1t5VBgqT
         0F9rLQd0GOcTGczH1Uca/27W8EI+ZY83h9JelIc+Riui2ym49rdW6Lhfz24nB45Dc9th
         /ZQhmqq/Zy9PXu5oqQQ2w+Gdt4GnqF6Z+iUoMzAJ7bvPI7omPYiDwWEQwRM8WMqWds71
         HkzjG2/wU6tQ0E334dWhEQr7Chy0mlkc+0o8kn5VWTwMH4auMZZdCFJea4f/kvtkVqin
         UYBV6BEO2qXH8FzHZfBsrJtsWmA9HcO6H3z19MLZi7sItJHNILvgmm5pE/glIYHheEwN
         pJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711736315; x=1712341115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4IbtfZjO4pa+6IR5sXD2UiwAyZgAWe0Fs1q0AVxLp4=;
        b=P+1UwWccfFigjArCIfqDYpS9Rcz7dZAvPRyy7joUXWlvzDaqzmPRh6xcNbgsRuAv8k
         2DOZI53yyUDEEFmdC1f4HwS3U53DJMS8NH+3sgZwuv+fHAP2RpiZ+y8YKrnm3FbGRH1S
         9r9jD7btTgMwmM7v0KWmU5pVSJ9d6UR2wx5lc6q67XfxUUftG0rcevP7divx+TAN0tZS
         twfcUFWRbAOV5uBHephKTBTmfHKk8bHta+2kl6MaYUWbe5QbqsSPWO4IoC/F6x2+i54C
         dsgWqWLoZeIxDxY/KjS3lm8AvwQloRZ+azQ6Br2L0J1GQDzugHSZXVxY2C+znPVDyvEQ
         BDwA==
X-Gm-Message-State: AOJu0YxEMJjodKNgPn1nOd6GF4jB0xd/xcHYHysq3bsYj9Z6oeDv5JyE
	cl+jTpptMBRopiElr8kNcBj0vqfKFgzQWG3dGkt/SYLJEi2/qtRGVXfXSVAGEO6LJqUEQnN2g45
	RMLr+KOQMSGE408O+jQIPhGGC2gAuz1Q1Gl1NdQdyKZHAOCg6c2jiShECOchxnqkloK9iK5nQxQ
	iKp3nSM1YjPyS7PE4EPx2r3Q==
X-Google-Smtp-Source: AGHT+IHgBclKqYIuPSh0ltzOy3Xumqq/Nrt0mAdP10SfOPtKh93dc7xUnmMOpmoXPypv+gCYBUqP4j59
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:218e:b0:dda:f314:7e1f with SMTP id
 dl14-20020a056902218e00b00ddaf3147e1fmr235658ybb.4.1711736314864; Fri, 29 Mar
 2024 11:18:34 -0700 (PDT)
Date: Fri, 29 Mar 2024 19:18:03 +0100
In-Reply-To: <20240329181800.619169-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329181800.619169-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5528; i=ardb@kernel.org;
 h=from:subject; bh=21tah4gsHpsqaWtMdmGOXnJlLkANamSFZCQsB2bOHBM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY2d9bbWke17/5RV8bO01N7uu3LD8cLRQwfSTp0+JOWX6
 5ryoGJjRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIhQ3DP13GI5NUsipO3k+b
 96dp1/HFEx/ZPLUM6Z0R+dF3ztMFR8oY/sp3C4QK2R3aeVv218M9j95l6uVHR/1ceKH36CH7D2+ eL+QAAA==
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329181800.619169-7-ardb+git@google.com>
Subject: [PATCH -stable-6.1 resend 3/4] x86/Kconfig: Remove CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: "Borislav Petkov (AMD)" <bp@alien8.de>

[ Commit 29956748339aa8757a7e2f927a8679dd08f24bb6 upstream ]

It was meant well at the time but nothing's using it so get rid of it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20240202163510.GDZb0Zvj8qOndvFOiZ@fat_crate.local
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 +---
 Documentation/x86/amd-memory-encryption.rst     | 16 ++++++++--------
 arch/x86/Kconfig                                | 13 -------------
 arch/x86/mm/mem_encrypt_identity.c              | 11 +----------
 4 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2dfe75104e7d..b5cd61774f12 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3206,9 +3206,7 @@
 
 	mem_encrypt=	[X86-64] AMD Secure Memory Encryption (SME) control
 			Valid arguments: on, off
-			Default (depends on kernel configuration option):
-			  on  (CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y)
-			  off (CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=n)
+			Default: off
 			mem_encrypt=on:		Activate SME
 			mem_encrypt=off:	Do not activate SME
 
diff --git a/Documentation/x86/amd-memory-encryption.rst b/Documentation/x86/amd-memory-encryption.rst
index 934310ce7258..bace87cc9ca2 100644
--- a/Documentation/x86/amd-memory-encryption.rst
+++ b/Documentation/x86/amd-memory-encryption.rst
@@ -87,14 +87,14 @@ The state of SME in the Linux kernel can be documented as follows:
 	  kernel is non-zero).
 
 SME can also be enabled and activated in the BIOS. If SME is enabled and
-activated in the BIOS, then all memory accesses will be encrypted and it will
-not be necessary to activate the Linux memory encryption support.  If the BIOS
-merely enables SME (sets bit 23 of the MSR_AMD64_SYSCFG), then Linux can activate
-memory encryption by default (CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y) or
-by supplying mem_encrypt=on on the kernel command line.  However, if BIOS does
-not enable SME, then Linux will not be able to activate memory encryption, even
-if configured to do so by default or the mem_encrypt=on command line parameter
-is specified.
+activated in the BIOS, then all memory accesses will be encrypted and it
+will not be necessary to activate the Linux memory encryption support.
+
+If the BIOS merely enables SME (sets bit 23 of the MSR_AMD64_SYSCFG),
+then memory encryption can be enabled by supplying mem_encrypt=on on the
+kernel command line.  However, if BIOS does not enable SME, then Linux
+will not be able to activate memory encryption, even if configured to do
+so by default or the mem_encrypt=on command line parameter is specified.
 
 Secure Nested Paging (SNP)
 ==========================
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5caa023e9839..bea53385d31e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1553,19 +1553,6 @@ config AMD_MEM_ENCRYPT
 	  This requires an AMD processor that supports Secure Memory
 	  Encryption (SME).
 
-config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
-	bool "Activate AMD Secure Memory Encryption (SME) by default"
-	depends on AMD_MEM_ENCRYPT
-	help
-	  Say yes to have system memory encrypted by default if running on
-	  an AMD processor that supports Secure Memory Encryption (SME).
-
-	  If set to Y, then the encryption of system memory can be
-	  deactivated with the mem_encrypt=off command line option.
-
-	  If set to N, then the encryption of system memory can be
-	  activated with the mem_encrypt=on command line option.
-
 # Common NUMA Features
 config NUMA
 	bool "NUMA Memory Allocation and Scheduler Support"
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 4daeefa011ed..7d96904230af 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -97,7 +97,6 @@ static char sme_workarea[2 * PMD_PAGE_SIZE] __section(".init.scratch");
 
 static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
-static char sme_cmdline_off[] __initdata = "off";
 
 static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
@@ -504,7 +503,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 
 void __init sme_enable(struct boot_params *bp)
 {
-	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
+	const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
 	unsigned long me_mask;
@@ -587,12 +586,6 @@ void __init sme_enable(struct boot_params *bp)
 	asm ("lea sme_cmdline_on(%%rip), %0"
 	     : "=r" (cmdline_on)
 	     : "p" (sme_cmdline_on));
-	asm ("lea sme_cmdline_off(%%rip), %0"
-	     : "=r" (cmdline_off)
-	     : "p" (sme_cmdline_off));
-
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
-		sme_me_mask = me_mask;
 
 	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
 				     ((u64)bp->ext_cmd_line_ptr << 32));
@@ -602,8 +595,6 @@ void __init sme_enable(struct boot_params *bp)
 
 	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
 		sme_me_mask = me_mask;
-	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
-		sme_me_mask = 0;
 
 out:
 	if (sme_me_mask) {
-- 
2.44.0.478.gd926399ef9-goog


