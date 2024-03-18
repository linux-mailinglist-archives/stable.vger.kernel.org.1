Return-Path: <stable+bounces-28389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9771987F3D1
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 00:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D56928272A
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 23:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8055CDD5;
	Mon, 18 Mar 2024 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lScFXXwV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C495CDCD
	for <stable@vger.kernel.org>; Mon, 18 Mar 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803435; cv=none; b=bFoJKkooDi3BotuqbtEJsre0tSvj7RXab8m31WrfNP0+yh17OhmbfZ+YlUdsgfmdZb3JM5oxF9W6+nnO6QPp3V38h9vaxXMteYEVqP//m6qURKaGEXM6W/8N8hc03DiC0b/7LDFo6sR115Nt2pg1lHj4jMU+H5YGdYi3S2weBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803435; c=relaxed/simple;
	bh=3QfwHntJQMgvU6AuyLnxDRBkYhBLtNLtAuixY4b/WFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HdbxdKr675GjxBryvqCRWdK3jpLy2cpehCOxanJK81L/plbYVahW6mlwOWIV33Jm1D+M+IUufWz9vIlraO+/cFwpp7Y5v6/YGrQVc96DiWyg4X565zEgJkKssGQx3khKQW0/x3PgvDMDAjgc1T4VKm6SsADUCJdkC2CSKjl4+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--acdunlap.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lScFXXwV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--acdunlap.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd073522cso96015137b3.1
        for <stable@vger.kernel.org>; Mon, 18 Mar 2024 16:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710803432; x=1711408232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=101Rc15yJZ5dhEo4PySV2SOSqW3Lu8UuBq5uPa6A6n4=;
        b=lScFXXwVh9jyBAvXdZSwvt7N53pk2nhnTVWJDQPn6PKBamPad/W8RaRd+srPnDm4wx
         QExPf4WkCimbu2FtXiuT9kjat+6i4tFIElWiPXVPQawVC8Xp+RCgebbY4j6+5u0C23AL
         pL7Jc3hShyBTGdw0wtOocblUSR54eBJZfmNJHwZXfBCXR7B0f2K0kcN6SdxFoIfjQFi9
         36cvwMHb7LGtdr6Q4eHv1yLihO8wIskbRwLqAC7OTWUB+lzTYYy8B3N9k+vFbBAJBRyI
         sgC9iW665TvLCTcMQJV0TcESOmmQNOFn4S6piT0BVN/BTtnrDtuYIa7FG6XLl3yDpKW9
         Su2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710803432; x=1711408232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=101Rc15yJZ5dhEo4PySV2SOSqW3Lu8UuBq5uPa6A6n4=;
        b=vZdhV2vA622N2QAZC9ehAnZk+Eyta7TrXYHquyL2XHzMWh8Q/Z6TL9xbgtDISeCNZI
         Y5BWCg7SznsOT95qN3IY0tVQNfpCkh8o73YB6BxPlUmzMGgiXgjzoGbl1jBYDXAQKEGR
         9Kk8Wi8jWhBdPIzoyWXytV+BLueVJvKWAYU4Jb6HqiJ3u7dVkAlDLesEYThy14ba15kP
         /Nha2+0F8mPbj228I6SWXNW5ANVofcJRaXZPMWcS7j3LcaxWvKmmOuYDeX5pW2uZ+xVb
         9AnZswQnd78Zz+Z13dMIaprliAZkbk+nCZJthQk9DaAzVwu0/HFnSG9Dh3eV/7ho1V/a
         OHDg==
X-Forwarded-Encrypted: i=1; AJvYcCXclRemhEbXk5EcYjjzeGYADcG4q5NvKmyRp/I2VUTY7rQP871N5PVoRbblmoreoWO6xMSN89Kn9YSaUbG11tG1dWaWzrLl
X-Gm-Message-State: AOJu0YwohhNq04JYNyQnOEfmcOHMyEk/KoFEvzSiMObqXxul1m8WIaSP
	GLdGxyeA1/m+91dr3blZHceNOj12C2ZFlR6wm28LimefQi3ndUE/R/tA5AAx9ro+qMEGSpA8rYw
	tJC9mWN2eQA==
X-Google-Smtp-Source: AGHT+IH++3SMmZzNlMzKHz9FwHgWagIFoME8NVVi0QvZI89J+nCx6d7zWk0UM9APt0/6zAQC/gddneHi6BEO1w==
X-Received: from anticipation.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4517])
 (user=acdunlap job=sendgmr) by 2002:a0d:d5cd:0:b0:60a:267c:87bc with SMTP id
 x196-20020a0dd5cd000000b0060a267c87bcmr259907ywd.6.1710803432480; Mon, 18 Mar
 2024 16:10:32 -0700 (PDT)
Date: Mon, 18 Mar 2024 16:09:27 -0700
In-Reply-To: <87frwrjc0i.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87frwrjc0i.ffs@tglx>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240318230927.2191933-1-acdunlap@google.com>
Subject: [PATCH v4] x86/asm: Force native_apic_mem_read() to use the MOV instruction
From: Adam Dunlap <acdunlap@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Arjan van de Ven <arjan@linux.intel.com>, Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Jacob Xu <jacobhxu@google.com>, Alper Gun <alpergun@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Peter Gonda <pgonda@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>
Cc: Adam Dunlap <acdunlap@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When done from a virtual machine, instructions that touch APIC memory
must be emulated. By convention, MMIO access are typically performed via
io.h helpers such as 'readl()' or 'writeq()' to simplify instruction
emulation/decoding (ex: in KVM hosts and SEV guests) [0].

Currently, native_apic_mem_read() does not follow this convention,
allowing the compiler to emit instructions other than the MOV
instruction generated by readl(). In particular, when compiled with
clang and run as a SEV-ES or SEV-SNP guest, the compiler would emit a
TESTL instruction which is not supported by the SEV-ES emulator, causing
a boot failure in that environment. It is likely the same problem would
happen in a TDX guest as that uses the same instruction emulator as
SEV-ES.

To make sure all emulators can emulate APIC memory reads via MOV, use
the readl() function in native_apic_mem_read(). It is expected that any
emulator would support MOV in any addressing mode it is the most generic
and is what is ususally emitted currently.

The TESTL instruction is emitted when native_apic_mem_read() is inlined
into apic_mem_wait_icr_idle(). The emulator comes from insn_decode_mmio
in arch/x86/lib/insn-eval.c. It's not worth it to extend
insn_decode_mmio to support more instructions since, in theory, the
compiler could choose to output nearly any instruction for such reads
which would bloat the emulator beyond reason.

[0] https://lore.kernel.org/all/20220405232939.73860-12-kirill.shutemov@linux.intel.com/

Signed-off-by: Adam Dunlap <acdunlap@google.com>
Tested-by: Kevin Loughlin <kevinloughlin@google.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org

---

An alterative to this approach would be to use inline assembly instead
of the readl() helper, as that is what native_apic_mem_write() does. I
consider using readl() to be cleaner since it is documented to be a simple
wrapper and inline assembly is less readable. native_apic_mem_write()
cannot be trivially updated to use writel since it appears to use custom
asm to workaround for a processor-specific bug.

Patch changelog:
V1 -> V2: Replaced asm with readl function which does the same thing
V2 -> V3: Updated commit message to show more motivation and
justification
V3 -> V4: Fixed nits in commit message

Link to v2 discussion: https://lore.kernel.org/all/20220908170456.3177635-1-acdunlap@google.com/

 arch/x86/include/asm/apic.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9d159b771dc8..dddd3fc195ef 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -13,6 +13,7 @@
 #include <asm/mpspec.h>
 #include <asm/msr.h>
 #include <asm/hardirq.h>
+#include <asm/io.h>
 
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
@@ -96,7 +97,7 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
 
 static inline u32 native_apic_mem_read(u32 reg)
 {
-	return *((volatile u32 *)(APIC_BASE + reg));
+	return readl((void __iomem *)(APIC_BASE + reg));
 }
 
 static inline void native_apic_mem_eoi(void)
-- 
2.43.0.594.gd9cf4e227d-goog


