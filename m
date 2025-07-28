Return-Path: <stable+bounces-165005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07334B141A5
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 20:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A5918C2FC7
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EBA2798E6;
	Mon, 28 Jul 2025 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y5kbR9fe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06ED2701BD
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725446; cv=none; b=JWPZt8Thnz7xa8JN3I02nr/2h3YoPBLQ99WsZU4ljz6iFgZ2TY6WktOoJInNMRB7u+n0uCbfPINqjD7HopvIrq4Xgbrus2dkKu6rBYE0Ew9PYuivKkqacGT8a+S+rUbMhhHKb79D+wKYJRlTQJ0fmP1/tksN5cbeEoUjrr33tN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725446; c=relaxed/simple;
	bh=qEs0Y4yAMiwA4qJ64VMwFzUThRugcZpQH7v7RjFjgwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OJROEmU/raUAHKYUaphpX9ptodMq2it2LlJKKWe5rkV+KlWSaSwoxBJNWCLqVE1BXdo0sZd/OOfFoisLvjm65PNL3E56MjOva3x0msi7MK9CUua8sZJINqexxL/KeFEyvefJ7Llu13eZmG+GyX058uftqgEASq8eYzqv3tIKpm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y5kbR9fe; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313c3915345so7193986a91.3
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725444; x=1754330244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NptZ1FmxrPNazhMUvzQyczuWbF6alVJnwo0dEO8fyfw=;
        b=y5kbR9fengmtFEeGXmGw84cucNMDMlbUM6mLkUzzbV7NiLKbL57+FxvqFp8Tql5z7S
         e0TIniJYxoIymcN1SqDTqdiPXC/vnqC4ZloFAV2hgqtmc1gGmYEMiEXrglk60IRzna2p
         FEMIelw6YTVWmvuTbOit6CijMPgsYJY03SALfFNsNO/KU+e+1xzqwtkYbvnLoQjzljln
         ZE2inTXd9gYbjRRGzlE2eR+chSNxP8VkiF3vabgPPMZHLZE19PUVi2YtaYeG44C3iEIT
         JkG82bzxSwj3WmIUuR+QD4IZwaDyPtsBDPhFcIyNtlRjzXseDwMX9ZKce39T6y8Hl3xu
         JtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725444; x=1754330244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NptZ1FmxrPNazhMUvzQyczuWbF6alVJnwo0dEO8fyfw=;
        b=Ops/2LaxbqtodclJsOm1Agqjm8/WL6kSo7MS0CPhvevkYMDJFJANMGQg1wEjI8T+78
         wMmI6qkLtg0ZFo/iaQaVQEiU6G/PMNwJk+G4pH9SgA0AVBmW/Jns4nzZpEAIzf7Q1ocQ
         DgP25cWnpvKVKn5/jmUppARVm7QPHLWvDYfdWqgi63Y/OgBOT6zW6CwzLfHDzN9GLMwj
         Q3PqMLZFgsbuwIgzIN7l3AYQojFVBNXCCn5xFTQRqeIA2NmUbdSIbnAOdgk3m4TxNk2y
         tU01/DBIVJTaVxG4sDrFw3okOSPPVdNMQ8OBj+K3G+RIEA61D/9urJsaqV7Lsd8zaJtw
         spJA==
X-Gm-Message-State: AOJu0Yyf4FEgNAneXM7TBQYF9NNN3BP2EZecbGMU/zTXxA1gyBCmcdRe
	DxSRj6TDLJ6Plm692puq5NniCaRR6V4UBuS7HKLddJbS3PpIVAAP/oe2uJTF1V/w+5YDfiXo+8o
	bRTXxJAP9BJjk74rnZxHobyjVHisyDiSvlQGnCtMnLrlg1CUaHv1S1IJSQTwwzqzXX5XwuPQIvh
	E3HA+g4+uyi0onKDPciOKkG/zoWFQJ7ID2/qp9Szl9uUhTWeZDKhCJ
X-Google-Smtp-Source: AGHT+IE8kLLgtNZt5TNrhDw+ITc0Q+6SbOfYSprB3Uj2gxSIsZR8/mO4XqCMcMqGp1AJ8zPRb+LvLPBZjPVhTGQ=
X-Received: from pjbof7.prod.google.com ([2002:a17:90b:39c7:b0:31f:210e:e35d])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b4b:b0:31f:b51:ef0a with SMTP id 98e67ed59e1d1-31f0b51f08bmr3690715a91.21.1753725443818;
 Mon, 28 Jul 2025 10:57:23 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:56:56 +0000
In-Reply-To: <20250728175701.3286764-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com> <20250728175701.3286764-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175701.3286764-4-jtoantran@google.com>
Subject: [PATCH v2 3/7] runtime constants: add x86 architecture support
From: Jimmy Tran <jtoantran@google.com>
To: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	David Laight <david.laight@aculab.com>, Andrei Vagin <avagin@gmail.com>, 
	Jimmy Tran <jtoantran@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>

commit e3c92e81711d14b46c3121d36bc8e152cb843923 upstream.

This implements the runtime constant infrastructure for x86, allowing
the dcache d_hash() function to be generated using as a constant for
hash table address followed by shift by a constant of the hash index.

Cc: <stable@vger.kernel.org> # 6.10.x: e60cc61: vfs: dcache: move hashlen_hash
Cc: <stable@vger.kernel.org> # 6.10.x: e782985: runtime constants: add default
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jimmy Tran <jtoantran@google.com>
---
 arch/x86/include/asm/runtime-const.h | 61 ++++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S        |  3 ++
 2 files changed, 64 insertions(+)
 create mode 100644 arch/x86/include/asm/runtime-const.h

diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
new file mode 100644
index 0000000000000..76fdeaa0faa3f
--- /dev/null
+++ b/arch/x86/include/asm/runtime-const.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RUNTIME_CONST_H
+#define _ASM_RUNTIME_CONST_H
+
+#define runtime_const_ptr(sym) ({				\
+	typeof(sym) __ret;					\
+	asm_inline("mov %1,%0\n1:\n"				\
+		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
+		".long 1b - %c2 - .\n\t"			\
+		".popsection"					\
+		 : "=r" (__ret)					\
+		 : "i" (0x0123456789abcdefULL),	\
+		 "i" (sizeof(long)));				\
+	__ret; })
+
+// The 'typeof' will create at _least_ a 32-bit type, but
+// will happily also take a bigger type and the 'shrl' will
+// clear the upper bits
+#define runtime_const_shift_right_32(val, sym) ({		\
+	typeof(0u+(val)) __ret = (val);				\
+	asm_inline("shrl $12,%k0\n1:\n"				\
+		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
+		".long 1b - 1 - .\n\t"				\
+		".popsection"					\
+		 : "+r" (__ret));					\
+	__ret; })
+
+#define runtime_const_init(type, sym) do {		\
+	extern s32 __start_runtime_##type##_##sym[];	\
+	extern s32 __stop_runtime_##type##_##sym[];	\
+	runtime_const_fixup(__runtime_fixup_##type,	\
+		(unsigned long)(sym),				\
+		__start_runtime_##type##_##sym,		\
+		__stop_runtime_##type##_##sym);		\
+} while (0)
+
+/*
+ * The text patching is trivial - you can only do this at init time,
+ * when the text section hasn't been marked RO, and before the text
+ * has ever been executed.
+ */
+static inline void __runtime_fixup_ptr(void *where, unsigned long val)
+{
+	*(unsigned long *)where = val;
+}
+
+static inline void __runtime_fixup_shift(void *where, unsigned long val)
+{
+	*(unsigned char *)where = val;
+}
+
+static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
+	unsigned long val, s32 *start, s32 *end)
+{
+	while (start < end) {
+		fn(*start + (void *)start, val);
+		start++;
+	}
+}
+
+#endif
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index c57d5df1abc60..cb5b41480a848 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -371,6 +371,9 @@ SECTIONS
 	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
 #endif
 
+	RUNTIME_CONST(shift, d_hash_shift)
+	RUNTIME_CONST(ptr, dentry_hashtable)
+
 	. = ALIGN(PAGE_SIZE);
 
 	/* freed after init ends here */
-- 
2.50.1.470.g6ba607880d-goog


