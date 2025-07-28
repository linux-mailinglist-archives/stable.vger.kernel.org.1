Return-Path: <stable+bounces-165006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E367B141A9
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 20:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1A6163DB6
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 18:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315622798F5;
	Mon, 28 Jul 2025 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sR0CX7B2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F1275AE4
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725451; cv=none; b=Po2UViGqGPw7dDI64JDf05J/c5J+GVhT+coPFZm5zosFssejE16x8PM/16milgrgzlNYDJF5ibAMD1UrKDi7g/VqicXAlPt6ukEM6CC5MSwcJaiFYD/CHI7X7b2oLajrQT2VX3zh4WSEFyYLpBo0sOEFzkgii/c7Apku5chgzNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725451; c=relaxed/simple;
	bh=EML81W3qpD/lQ1eThrHjlEsT2peBi+sbJT9L271mo78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u8tX4s3EiiwVDAIBItY2YSV5WsUgshaZQy615Mq11gmZ9OWLdG/LNmllD7BgVS0WrWYXSsaR7O6HX9kmwZwe93YplECiGaU8CIaWBDQr+KOySExFIWwTngMaGmrI0qjoYOwPH7pQqQL9NZJ2WitUJr+HwULH/LFN+AV38WYzLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sR0CX7B2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74ea83a6c1bso2067971b3a.0
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725449; x=1754330249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuzvsF/oaJYTc+aj6Vmn1mDowEdZYCD9kds1Df74zdA=;
        b=sR0CX7B2+CbKXesuyRCSBZ1f+f0PQ3kp+1ichfSnh6qACoVLxIWZkXMb9BpRWZrfvf
         sF2kW9kdfyG4TlbvqSR29FqNdYC+LStg5km9JS9JselO/pVVLxHHbqzqfpO7zrCQiScI
         AVdWhxFLUHLcEr+2IJEcjxHxhXgQOl2Kdvvb98QyZ1KouKn6aeJfwnCPO1B0h1RVMl3q
         SbVUwQ/QuQ5b5uDD6jufr6m0+cTsYP2tIYdcSWPO0+1zYvdwflMG7zDanmgtvQUQxFNz
         PPyK9IsNhQ88Tt9MqnLDwBta9osxdWUFmJlfi1diremd3ax5FBJ9uUh84JXO7KT10TGu
         PzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725449; x=1754330249;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RuzvsF/oaJYTc+aj6Vmn1mDowEdZYCD9kds1Df74zdA=;
        b=V2eHZcN5KH7jdSWZ1agoa7ZzD2Az+mAK+boLcBTf63/MdUrFvakEeZeMA5LHAwk6wf
         Gz7Fpq2Ru91FHChGuXrJ8DP4woMJVJOVCPXmwNCYlThHWYoMgA/9vWAOtKa5g/ujU0bN
         HbbKFHX8DGW2PSrpuwkM5srhD1Y7P+yFlQGad/MrDgy8SNVzfxBowHrR6QkKJXbdqRBy
         H22UMm2w6vHMGf9lFklMmP6vYjTMo2V6MRnN5iD5/IG/+F/lXUlBx7siSTiq0FIa818W
         ltTb/v+6Px83H+CFuTOeu5P95gBj6fXpQXhRpp/tZ4jR1udRJ6mrCtnpWWKAh81kBN2x
         2Zcg==
X-Gm-Message-State: AOJu0YzdkJsCYqnhnk7aV+12KqNvrLcPvilIKVGmBaoFiulu7lGT8cW1
	FtUXIYpCe7YaWiyv3VuTm2ywN1aTFrw0u3cSyFzqAX4AIRzq1LZ1d765ESu+cqacOguVqaZU7yF
	MLdEXoywH6QLbzXkO+ombfWo/xZHw/7K+5EytGdVYYeSo1DTafeJBsQ8M0S5Ev0XgOUMP0GEy4h
	3HJ5VyWOiSJ1EqAdjMLtUq67mTHqbEql91roXCTFy+lF5xKeiLfFqU
X-Google-Smtp-Source: AGHT+IFs7wWTVoW2l9Dj6Mm/J9+B73nF0EsmqQLCbOhhxWPOeQzQcKEKad5SwqAZJiw2buXctdgri6B8rtwRy10=
X-Received: from pfbli5.prod.google.com ([2002:a05:6a00:7185:b0:74b:41c0:e916])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a1d:b0:748:e1e4:71ec with SMTP id d2e1a72fcca58-763386bea35mr18167812b3a.12.1753725448548;
 Mon, 28 Jul 2025 10:57:28 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:56:57 +0000
In-Reply-To: <20250728175701.3286764-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com> <20250728175701.3286764-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175701.3286764-5-jtoantran@google.com>
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


