Return-Path: <stable+bounces-164487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7F7B0F82D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CDB3AA2A2
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138371F4C87;
	Wed, 23 Jul 2025 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="em1lXKBw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C51F4285
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288342; cv=none; b=LFxw3URzChePN+0X7oVu3jmHucWB2J+7ONdM5Fn06zctWYxvXgGtfCo3t9ezCIEFajKccqXuLtQxUCN/MWYrh21GzTetnN4Hs8W0IKMCWuZOahQ9zDAob5oS7+N4C39SFIfzO1kypShIXNF7MirFeKEFKR6hd9hmxGFY4RCF3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288342; c=relaxed/simple;
	bh=+QxboLgcstXpa+qQeicgE+sE9nYpfEnNUhORheSCMwE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YgBqyyW8KXL9/errd2u/LyovXyBNXU57CZm0DeqWcay87JjrMXu0NMDshJeUL5XV70rZYhAOHCnoWJ4yjVIyjC0ap0/H3+LOufPxw1PAXw8Eo68iIOucghFDFf0kGtX8KgtRmB3FkfXmgHD/3e/AJUDjnrUMaNQosYEs+QL+UaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=em1lXKBw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138e64b3f1so31471a91.3
        for <stable@vger.kernel.org>; Wed, 23 Jul 2025 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753288341; x=1753893141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjuRLLqM45ZNopaAxOVcMoyG3XDhbGmGcTV6UFDlTX4=;
        b=em1lXKBw0BXE4jw1Io548P1bCx6/uJ4Qbbm+98c+n+o5TQ04KHe9A1xG6lpR9jbiuM
         /C/P+92U8a3X8MT1tYed0aKCUUJTvJ54FsDKcWoz3LCkHZIkd3+eZ0BBcPEuIgMj0eB2
         Kyu/ist75y5nOXkyLGe0JZLU01QJMsVEvIwiWB9zRs5k/sRUGahpfGs4aT0YBOkvRNZD
         wao9QYI1ZPB6H383rJ5czhlAwigA3iPY1m1Ci30honCb+ddlPN4cnYX+RSMAb/ts6QJc
         s87r0SRmVNWt7XGVsVktMfy+z+OtyzcDgoP9nwSDguM9rEdYbTus9dltip5a6ChU4JJj
         Vi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288341; x=1753893141;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HjuRLLqM45ZNopaAxOVcMoyG3XDhbGmGcTV6UFDlTX4=;
        b=XAtERhFXxjD4LNGm7gpt4bUe+tmkZVeSNm2klgpp8f+bqmDnkpq0seVh9p+La/EpOk
         yrfGcy8Dw35PTJXtafaCQB+LQouBZ/eH+Go3xPNwW/TausNHsC18rKnLIVfbzVBx7xDr
         iyNwOkRmeOeOGNX12Q9G5ky4dGwOKW5ZeNmkVXdNklVmc7mqLbYS15vlmHHs6ZucNy6X
         iCt5SKeq+/AbyYwz4TurHXGXAsHp8URvQ4iKGyHjSod6MUqQYaYBDzlu8Y+faZyIfhRn
         8jf4CguGIWuOOvg+WcWN3CVA3OjIpJceQY1ZRNUTXVMuwqBD1Po7FnIwQzmO6ivwkfEn
         5dKw==
X-Gm-Message-State: AOJu0YynzXNhCRi/ww5CmkIKw2E/lvdWNlrgHubuaZHbSTaXJNYm38jh
	mmdeS0lytG2VhRqLlwZvpIBUpTGx5X6UmULHF2AEsiM+I9a1fDWjc2l7lQ+x8k0f0X8pkTEJb7j
	IaaXTUNTB2BxOHZkOM7vp/xYv51gGV3QqLUCjGJYXEmyj28FOrCHGh+qaQDrRy68NBGNl0dVHqG
	3D9lMXKXqJJzlmR5Z92rTIwB2mOJ4jkDbtWquUUXJvigX5zdeJXzS+
X-Google-Smtp-Source: AGHT+IH30yEzqtKem+XvOXAEalNt1sjn2wa44AlHM1fd52cKv/NS6oQzZ/BMUyDddD55HASg/OPpRUjYUW3e2aY=
X-Received: from pjn16.prod.google.com ([2002:a17:90b:5710:b0:311:ff32:a85d])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5483:b0:311:cc4e:516f with SMTP id 98e67ed59e1d1-31e507fdbe5mr5652785a91.31.1753288340614;
 Wed, 23 Jul 2025 09:32:20 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:32:07 +0000
In-Reply-To: <20250723163209.1929303-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723163209.1929303-5-jtoantran@google.com>
Subject: [PATCH v1 4/6] arm64: add 'runtime constant' support
From: Jimmy Tran <jtoantran@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight@aculab.com>, x86@kernel.org, 
	Andrei Vagin <avagin@gmail.com>, Jimmy Tran <jtoantran@google.com>
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
2.50.0.727.gbf7dc18ff4-goog


