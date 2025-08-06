Return-Path: <stable+bounces-166722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF51CB1C9AA
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CB756237B
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5972E22F767;
	Wed,  6 Aug 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tBUfe4kp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBF82566F5
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497217; cv=none; b=D11d7BOHQwgjtnNy39wO28qITxy7XtohN3pbBchyzChS0Y/wpQTN01TLjRvUXuf2g4Gr5XfSdr/KD48GnvTJOh0ljScIFwKxm6NZoME0CSzqO0vYdUbxnEfl4ypn+ntFUuenj9ktYGRFKmDfAd2EvMZZV6ae4GUtMRjReAiX1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497217; c=relaxed/simple;
	bh=EML81W3qpD/lQ1eThrHjlEsT2peBi+sbJT9L271mo78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rki66WCkcDNwf9vFxoiQDWUIwuF2alFSH6G8+lJi9tLJugZGQLS6wGzNRKGlAKBhUIhGIV80aDYryUv7pnKLBQ/EhM+b6klo0NBJHunMMhPfHANfIs/xE8Tu1l0c6afP9zaJ18NYdCPqc054pbaJ+DdP2VszW5uqgkX6tf4Zk2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tBUfe4kp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23ff7d61fb7so9873015ad.1
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754497215; x=1755102015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuzvsF/oaJYTc+aj6Vmn1mDowEdZYCD9kds1Df74zdA=;
        b=tBUfe4kpSWvaxvd9pd4gN75Ne/Q6ajIPE5cRCCQu4qRM4ouwbv2xdSV4WdD8e+H1za
         6vuXvuQL9gci7I8uC0VFmbg25nOIQoFaK74faDCheAU6RVTcsO3NuCXMYn5losIPRUku
         pys8bTEGEWvF7LVuGltIyYRVicYUPcFRsjsmEQzoCyVXV84pvqlOizHbVsL5J8WLsXEW
         sMeh3GmS1ayYNYjtrXoK+YHCyrEXXNpiyw1SaUdzlmQ+RXwaM2uBO3nbWJwJuS3/ulCR
         iWzOG+jhnh4Uxngn5ut8S7TaxbMrShABHu3puoi/0kxt6l+F5wSrBUOQePJNO+LerwHN
         H8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497215; x=1755102015;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RuzvsF/oaJYTc+aj6Vmn1mDowEdZYCD9kds1Df74zdA=;
        b=qheFbVeoFGuBOho+MgNtkYbeCWorgbKTUUMskmqQP1/EXmEavFcv/iHCMpCd93pK3q
         hV8EhqRFFWMCkeBBtRB7MQncVqUDmXkaOlTrdb35sgYT7KZ1oQfyWgVnH9eqdeTny0Ne
         uw03eagK7P3WuY/uSBd6rduz0FuwS6f9bP/nUl9ghNVkrPK+tPRHbJhk4Pf8vN5RdbWH
         2t+75Q7WBZEEAdGk3STMC3w81076jcYM9vxlnTNmET6KKwS9XDBg2FxI+G5t+WQjmuC1
         z7Q8yTX/EzfqeetbgH4QUGOymLyQK99cdIGXGAmX8ic/wYeatET0Y7ja6uKU7dYfUOgo
         Km7w==
X-Gm-Message-State: AOJu0YyKeWdVrbhEwY0dwftRVbDyjEtmevoOiP0JuhuQfmMtL6uoD3kz
	WAIYLRY5NqJLYjfxyuErJOPjtMJ/1CTylECfEtrxFFvVlh1B30SwRc7TB9lFl/1vflYoNbx5vid
	202SA0/KkI2FmPSUoSvGZkYKkbXQHQZinXlJSIPi1tfUm8x9MTI59mPpp1p+HNxuy3KSLbGaKrf
	9B+hbTl0E6ySy6Txa8NZyVaivz8rD7lapmFhq6dRgS3dgfEPDUwkoQ
X-Google-Smtp-Source: AGHT+IHTCB6XjaRa8eu0qEzWzmW3X2kRVh+EyI3y6dVkGLTM9RphjoqigMBCjaSR/+cdmM5Q6m5FAQ2eKUYMFsI=
X-Received: from pjm15.prod.google.com ([2002:a17:90b:2fcf:b0:313:246f:8d54])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1acb:b0:23f:c5ba:8168 with SMTP id d9443c01a7336-242b0466eb6mr2995715ad.0.1754497214654;
 Wed, 06 Aug 2025 09:20:14 -0700 (PDT)
Date: Wed,  6 Aug 2025 16:20:00 +0000
In-Reply-To: <20250806162003.1134886-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806162003.1134886-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806162003.1134886-5-jtoantran@google.com>
Subject: [PATCH v2 4/7] arm64: add 'runtime constant' support
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
Content-Transfer-Encoding: quoted-printable

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 94a2bc0f611cd9fa4d26e4679bf7ea4b01b12d56 upstream.

This implements the runtime constant infrastructure for arm64, allowing
the dcache d_hash() function to be generated using as a constant for
hash table address followed by shift by a constant of the hash index.

[ Fixed up to deal with the big-endian case as per Mark Rutland ]

Cc: <stable@vger.kernel.org> # 6.10.x: e60cc61: vfs: dcache: move hashlen_h=
ash() from callers into d_hash()
Cc: <stable@vger.kernel.org> # 6.10.x: e782985: runtime constants:=C2=A0add=
 default dummy infrastructure
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jimmy Tran <jtoantran@google.com>
---
 arch/arm64/include/asm/runtime-const.h | 92 ++++++++++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S        |  3 +
 2 files changed, 95 insertions(+)
 create mode 100644 arch/arm64/include/asm/runtime-const.h

diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/as=
m/runtime-const.h
new file mode 100644
index 0000000000000..81faccb54e95d
--- /dev/null
+++ b/arch/arm64/include/asm/runtime-const.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RUNTIME_CONST_H
+#define _ASM_RUNTIME_CONST_H
+
+#include <asm/cacheflush.h>
+
+/* Sigh. You can still run arm64 in BE mode */
+#include <asm/byteorder.h>
+
+#define runtime_const_ptr(sym) ({				\
+	typeof(sym) __ret;					\
+	asm_inline("1:\t"					\
+		"movz %0, #0xcdef\n\t"				\
+		"movk %0, #0x89ab, lsl #16\n\t"			\
+		"movk %0, #0x4567, lsl #32\n\t"			\
+		"movk %0, #0x0123, lsl #48\n\t"			\
+		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
+		".long 1b - .\n\t"				\
+		".popsection"					\
+		 : "=3Dr" (__ret));					\
+	__ret; })
+
+#define runtime_const_shift_right_32(val, sym) ({		\
+	unsigned long __ret;					\
+	asm_inline("1:\t"					\
+		"lsr %w0,%w1,#12\n\t"				\
+		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
+		".long 1b - .\n\t"				\
+		".popsection"					\
+		 : "=3Dr" (__ret)					\
+		 : "r" (0u+(val)));				\
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
+/* 16-bit immediate for wide move (movz and movk) in bits 5..20 */
+static inline void __runtime_fixup_16(__le32 *p, unsigned int val)
+{
+	u32 insn =3D le32_to_cpu(*p);
+
+	insn &=3D 0xffe0001f;
+	insn |=3D (val & 0xffff) << 5;
+	*p =3D cpu_to_le32(insn);
+}
+
+static inline void __runtime_fixup_caches(void *where, unsigned int insns)
+{
+	unsigned long va =3D (unsigned long)where;
+
+	caches_clean_inval_pou(va, va + 4*insns);
+}
+
+static inline void __runtime_fixup_ptr(void *where, unsigned long val)
+{
+	__le32 *p =3D lm_alias(where);
+
+	__runtime_fixup_16(p, val);
+	__runtime_fixup_16(p+1, val >> 16);
+	__runtime_fixup_16(p+2, val >> 32);
+	__runtime_fixup_16(p+3, val >> 48);
+	__runtime_fixup_caches(where, 4);
+}
+
+/* Immediate value is 6 bits starting at bit #16 */
+static inline void __runtime_fixup_shift(void *where, unsigned long val)
+{
+	__le32 *p =3D lm_alias(where);
+	u32 insn =3D le32_to_cpu(*p);
+
+	insn &=3D 0xffc0ffff;
+	insn |=3D (val & 63) << 16;
+	*p =3D cpu_to_le32(insn);
+	__runtime_fixup_caches(where, 1);
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
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.ld=
s.S
index d4353741f331e..f1719116592da 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -265,6 +265,9 @@ SECTIONS
 		EXIT_DATA
 	}
=20
+	RUNTIME_CONST(shift, d_hash_shift)
+	RUNTIME_CONST(ptr, dentry_hashtable)
+
 	PERCPU_SECTION(L1_CACHE_BYTES)
 	HYPERVISOR_PERCPU_SECTION
=20
--=20
2.50.1.470.g6ba607880d-goog


