Return-Path: <stable+bounces-166723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97759B1C9AB
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5113C628342
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEC928A41C;
	Wed,  6 Aug 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXEqasqX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1741289369
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497217; cv=none; b=MTG44YDks1ziPg2/sH18JG4VCq5UslyW0wVEJJE+wAj2Irt/NL/AEbC6zhCY/yCwdgBsoimSZlhyDRrLRG1H5cwQTjZ41s9nPz5Iwr9uP0o0oHiwFQwIk4/kWg67ef/6HLrfrxbOy3h+VkCvpDK/QWUZ9eUHOZcrYV+eCpqcR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497217; c=relaxed/simple;
	bh=qEs0Y4yAMiwA4qJ64VMwFzUThRugcZpQH7v7RjFjgwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lb2QPzZzidSEYzJll/o1gSdY/5NaNuGS2STvBNt+fPd6v4SeDWyts3z/9H4mdhECVxM+QQ14qFLSGeLDHsltPsJ/CWNiaJHwq3+xV5vvRQc0b9IANFW5hBCEQRCKjO/gl2Hh07x5X/pBcsYQttpsaF+EDDacpyD2bkxwKsExL7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXEqasqX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bef13c254so101018b3a.0
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754497213; x=1755102013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NptZ1FmxrPNazhMUvzQyczuWbF6alVJnwo0dEO8fyfw=;
        b=WXEqasqXvdsQb5bIR66/SwzxvcV4UPEWbOp0KANB21HJfYoaIAAJ5bbL07Ek46Bgzl
         KdMllRW8fKeg6gRN8aI6gb90Q0blL0z8Xr3Bh6ufIdFBHgy7XJFRMFg4uFmEYPJugp7o
         oeVWx48sbs/vR1wnYZTYKPkeZNQivLEbPVkUXywwjDrxuIGPAGOwl4nzGt2kjFAaIIwi
         6bSXuseljGzBMmUG7PEKDR0zNetOaZ0CoUXa4UYXP6fVcNdwPD6sGPMtm+rcY4jqE83w
         K8uw/W4yAWOUrxR8ilPKRqRY6UnCFNvcYapycBoYdxV/Y/0FhiVLmVylt9GpRz97MHTe
         rb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497213; x=1755102013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NptZ1FmxrPNazhMUvzQyczuWbF6alVJnwo0dEO8fyfw=;
        b=bKAMY9mJG/BisgZ7wLKsQpgVQhTKhOL/cdI7E3JG7qnqsE08+Ij4CrT6nJL0ggcS7w
         r7kSXfxfvfFXa+BtmvNOmdfG5QShAXP46JKqqelVH4RdGiUbmrbm4qY/w7w0C9CeIeX1
         Uf1Q1V/V1sGVUnOyB6SS32qk2pl0i/5ehptWknfxA2hiQx1tliCTjrzwXUsm2S2RbFA+
         9IJRb866RIudHKM8qkdZ/VcEF9ghc2ClTCzIH0Ho4KxL+P++WJWfLI2ghLaDo31aMjnM
         tWuy5DIv2s5VX+VHDVZ4RPIhaYZBH2rpsUTSufVTJB1PH+R4C14lkXYr3BNgTc7rM8TH
         5F5A==
X-Gm-Message-State: AOJu0Yw3cyzMltv+q3r3Vf6jybt9LkJmyheYuY8bSFtokC9/wrNLT/A7
	Mosqnl5MouDskQ/tuoxegJbs93heGYblsBlphmGRwwEzue4QwLEYL0VXqt2qjXlUsLzU0s67nUG
	vw3lbcaCMGDZLDTQQsnYE1h6V23nnlI5D2lJLdzAGp9L3MIBnMyoCQh6/KvbrxftHyaWpVqTSdI
	8cbHAoYgLZebTbDpxfpWrhS0KIiw9t02xIpIR/2jZrhitd4QbQXHuG
X-Google-Smtp-Source: AGHT+IG9MQdGzeR8GIIl63wIbOZV3qdjtC6otoK4peUH48aH7ZJzxVsi4cFZqoCNeoE788py+9E5+BCnFQ7NVpQ=
X-Received: from pgbct10.prod.google.com ([2002:a05:6a02:210a:b0:b2e:c3f7:2536])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3393:b0:1f3:31fe:c1da with SMTP id adf61e73a8af0-2404124e89emr220772637.11.1754497213005;
 Wed, 06 Aug 2025 09:20:13 -0700 (PDT)
Date: Wed,  6 Aug 2025 16:19:59 +0000
In-Reply-To: <20250806162003.1134886-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806162003.1134886-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806162003.1134886-4-jtoantran@google.com>
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


