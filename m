Return-Path: <stable+bounces-164486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B4DB0F82B
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1A03A9E3A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739BC1F428C;
	Wed, 23 Jul 2025 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tojCH51c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41681F09A8
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288341; cv=none; b=jyynGw+RRuejVJ8P1QunyUX00aAA4HrF2MYpaOIs7NSCNlnD+aeqN1pSp9XoUvTE3o9PsO2PwvGFsbxWj6IXOGQx55z4wVNvwYQ0ivqOJrYkULG7TLEGgeOISGQvum/AAA6YBDGh2X2SKXCkANo4ntAtJMhYLFQ/JpGk1ep6zyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288341; c=relaxed/simple;
	bh=SdZhvagbCML2W0OAKAluXUnQn3l6YzufnDMBsmWGmso=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cohkqe3bTlCom53BMduapEknzq3gIFR/GDttR+GdRc5b9+A76RZYQikUuO9nbDU4AmRMP9XNW/Sm4D6dsmYGr5EqSeLEZjYnssB9J/INXK91xS1fObcyaDRUje/oosxLu/+MX7uoOBM/l/1vfCtnmrc/KrQXgUhyv8/slMusgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tojCH51c; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b34abbcdcf3so71194a12.1
        for <stable@vger.kernel.org>; Wed, 23 Jul 2025 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753288339; x=1753893139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+qLvaz7POc6U1zoe+y0zRKFzMnYr6KCoMfLSysNl9I=;
        b=tojCH51cWVcSCaky5V1TVtQmIUqzBmYVbL2fq6aIwlOagmWnGjsKSnvcvN6NlyIf7J
         9OoN637nk8yeD7oIOqiMF3H1p6Kd3o/8vLC8zc2mso4J6P8z+S4jNHWdOSoH7lK4Nr6L
         gM/8MZ8n32K503Lq1hvmZYdRoY1HIthKH32fbe6IDH8QJTUwuvS/1zz8JJ24IIlkopnO
         b+Akl46CU5CKJfB5sou38o3nbH4ku4PyTsn2KZNiFkC31M0zzh+tXj+wAfZdf6+tYOKU
         hr40BXFFwhDxuZFXVyycVTIpaQpBo6kEVRJ0W+QtWUIkShR2xL6u3YDDJhfURjroQ7OC
         iT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288339; x=1753893139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+qLvaz7POc6U1zoe+y0zRKFzMnYr6KCoMfLSysNl9I=;
        b=DOQcaYL2RMnPMniklsJzS8B9MvE5G9QOnBkTNsjzfLEKuU4m9ZjVgbubNTEXiWzOKv
         ZqIm6oYGU0TjggZdB2F0Y1Wyc5dX01NexEjRlDU6A4SljW/safKAqQuB2OvvhpVEN5hD
         9nYfHUmO/XNQaRIPUFVcWYIO6uSgRd/Dc4XzX8CQH64a77EzRtsSmfxch5KefUxxuSuJ
         MPWaHEimlfizXUkv+/G2QJV1qpCRuNw8wBkcXesHCiG+/dO0sz55ohBQZAeYuPqctZjR
         S0nhzpgruTyWSUoTrf6AUSXZiLjqxk/BEAEMxo2nB1BFpo2DzpfUyuigdiA+NXiNz7c1
         P49w==
X-Gm-Message-State: AOJu0YwBBIVIbkDg8pDGoxTTkdlVrc9aXMQwHwDXVSt/TkY9iVJqVl+a
	TeiCpCIDKrv9IuJ+3Ck/ykTKJRyo2YELzKpsG/NibnR2alviZr0p29iegscscHZXvUQ97XKI8al
	Bb8IEjKaP9HqD5tY2kQVXZnsuM/LqOXyc0zZz2vwwNJxHk+iajAa6MsxwiMpDoc2lgzaQK6ITaz
	dar2jQwoXo2cdZpke0xb5Ni68vu+tL2SyAk7yKee9q8aTPrG+uRlX3
X-Google-Smtp-Source: AGHT+IHgNkp5Ry+p8LC23Kxzj7GttROOiSVhzX11Pf518CUdYFPuoMGo+/HT4NSx49Wi1VuOFYeiAgprX+gMyJ8=
X-Received: from pfbcq12.prod.google.com ([2002:a05:6a00:330c:b0:748:8e9:968e])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7f93:b0:23d:54bd:92e6 with SMTP id adf61e73a8af0-23d54bd92f8mr819134637.29.1753288338900;
 Wed, 23 Jul 2025 09:32:18 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:32:06 +0000
In-Reply-To: <20250723163209.1929303-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723163209.1929303-4-jtoantran@google.com>
Subject: [PATCH v1 3/6] runtime constants: add x86 architecture support
From: Jimmy Tran <jtoantran@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight@aculab.com>, x86@kernel.org, 
	Andrei Vagin <avagin@gmail.com>, Jimmy Tran <jtoantran@google.com>
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
2.50.0.727.gbf7dc18ff4-goog


