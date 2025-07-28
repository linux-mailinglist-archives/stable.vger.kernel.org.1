Return-Path: <stable+bounces-165009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5BDB141AA
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 20:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F43175C37
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 18:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFE9279910;
	Mon, 28 Jul 2025 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXBMTVze"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626492798EB
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725460; cv=none; b=QFLLbfN/b+0peuJ95vis2TA9Eex38npGcmbdnjiD0JVj/ZP4Yj4kMS1lkqnNLEgde68tHTO4+ovU/FKZXdwpcuts/W9IacGCjH4Ix0b9sy757wC/Ip2ssvT4QMZp7mz4krpI93edlMRmPotOIqYEojJqKl9Mh+wt1I90Nm6Cu9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725460; c=relaxed/simple;
	bh=Igymf+wo2cKjoancO07p07/mpVPMA5Hf68yAso8scZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H+z9IS6VpbkGjF0nxePkYarapugW/LywfZri0HCl0qir7d+xn8m19tPI5Omun/Q1vaW4+3fTP2Eu42OTA9d1DmPrlTYahB3AaXFDqzaMTiwLCTCVl6hhMi4uKfsaPttXS6Y2+eJW4KRf1QczOHODRiT1Ke00tOJAfaQaXkiL184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXBMTVze; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so3459606a12.2
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725457; x=1754330257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgvyoWXE6pqkV9EGc/q1G6vaEqjOxNVRB2tBqLmp7E8=;
        b=YXBMTVze0zTjz1eVGXtw/2u/sAtiv+WFSVerXftv66UCr0InGjX3SIkYhbSPrdnZTD
         8bVjyHbuZn2t/KqygRNUNaGi1l5K1VsaSmbQ8kMDOucgwYyKACgkZWuOECIJb/adL9Zd
         DB83UlCp1UKfRPC6M4kx9F43prk2svq4/Ac3mi5O8+z/rM0uB7M+pS4aR5JfsI8FIWZQ
         tfFf98YOcX4r4IDeo4P/qeaiZnfBPLERU1hG9Ixr9vyKPMMt6dilP1v3Vtzm/S30/Caa
         D29q3QJGVJIbXuxL5Xy/t8Dxq0pmPV9MZG+JO8SqZw/JEoY1V49SZnJqbgdm3vymY6WF
         cGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725457; x=1754330257;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SgvyoWXE6pqkV9EGc/q1G6vaEqjOxNVRB2tBqLmp7E8=;
        b=cDUBNjBS/Yn3/k1xjwU4IwmBLJx5a2MmwmSAlXWzAVOJUarJRpTMsMV2BdI69Q1ggK
         yphpgPcNI2/75NmzCvfd88ebhE/ulWKznIttG8IkD/MkGi5z3kBKdwL89wrfwQ+2k/er
         GuZpM+n7GtuigePhj3/uVYnPurr1b0+iKfFqel+OUl5+0v9atMI4ECjpeWqskkKnCyqc
         pIti7xehf2W/5DBL+zegxa33Yr1xiYRZbO7HvIery/9k5CprdlGOP7JhT7PLyuEkGI7x
         ZrIOu3xeznL9uO0FtFDtiCak0bd0ccptsu8u8Rm3gsBDWs234+t0zdCWJOw4SWDwTo1j
         4iGA==
X-Gm-Message-State: AOJu0Yyb46SG0lTzEer6tcj2GAGCxl47jtUzzhmGlbIqi5z4uzFJAmRC
	deKyFyECRPoBp34OMz1dCsiyrkF1tE1bICU1tsVoxkMQiud6Hbhi/tsPB5A2OVLAPLOQW8G/PPN
	sEDZxFs/Np62H2+UHciBdXL6yTHCXUobcyNE1ERy8u4Pl12D6nHKsWl1DH6LNq1mRKMQFn3baoC
	bKIziGOOGY+5iQYqiCNDWOFGmsT83S/lAaLAFAEMPZ8dB+tYLvqAST
X-Google-Smtp-Source: AGHT+IHUJHacAT0DD7dx5JDIVl9c0I9bor53DxxrizZouh5Bm/UN0IU4+EHfHLFmhRSWGBTfV98ovrBgox3NdsA=
X-Received: from pjboi14.prod.google.com ([2002:a17:90b:3a0e:b0:31c:2fe4:33b6])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d8b:b0:311:e8cc:424c with SMTP id 98e67ed59e1d1-31e779fce5amr16511254a91.25.1753725457287;
 Mon, 28 Jul 2025 10:57:37 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:57:00 +0000
In-Reply-To: <20250728175701.3286764-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com> <20250728175701.3286764-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175701.3286764-8-jtoantran@google.com>
Subject: [PATCH v2 7/7] x86: use cmov for user address masking
From: Jimmy Tran <jtoantran@google.com>
To: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	David Laight <david.laight@aculab.com>, Andrei Vagin <avagin@gmail.com>, 
	David Laight <David.Laight@aculab.com>, Jimmy Tran <jtoantran@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 91309a70829d94c735c8bb1cc383e78c96127a16 upstream

This was a suggestion by David Laight, and while I was slightly worried
that some micro-architecture would predict cmov like a conditional
branch, there is little reason to actually believe any core would be
that broken.

Intel documents that their existing cores treat CMOVcc as a data
dependency that will constrain speculation in their "Speculative
Execution Side Channel Mitigations" whitepaper:

  "Other instructions such as CMOVcc, AND, ADC, SBB and SETcc can also
   be used to prevent bounds check bypass by constraining speculative
   execution on current family 6 processors (Intel=C2=AE Core=E2=84=A2, Int=
el=C2=AE Atom=E2=84=A2,
   Intel=C2=AE Xeon=C2=AE and Intel=C2=AE Xeon Phi=E2=84=A2 processors)"

and while that leaves the future uarch issues open, that's certainly
true of our traditional SBB usage too.

Any core that predicts CMOV will be unusable for various crypto
algorithms that need data-independent timing stability, so let's just
treat CMOV as the safe choice that simplifies the address masking by
avoiding an extra instruction and doesn't need a temporary register.

Cc: <stable@vger.kernel.org> # 6.12.x: 573f45a: x86: x86: fix off-by-one in=
 access_ok()
Cc: <stable@vger.kernel.org> # 6.12.x: 86e6b15: x86: fix user address maski=
ng non-canonical speculation issue
Cc: <stable@vger.kernel.org> # 6.10.x: e60cc61: vfs: dcache: move hashlen_h=
ash() from callers into d_hash()
Cc: <stable@vger.kernel.org> # 6.10.x: e782985: runtime constants: add defa=
ult dummy infrastructure
Cc: <stable@vger.kernel.org> # 6.10.x: e3c92e8: runtime constants: add x86 =
architecture support
Suggested-by: David Laight <David.Laight@aculab.com>
Link: https://www.intel.com/content/dam/develop/external/us/en/documents/33=
6996-speculative-execution-side-channel-mitigations.pdf
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jimmy Tran <jtoantran@google.com>
---
 arch/x86/include/asm/uaccess_64.h | 13 ++++++-------
 arch/x86/lib/getuser.S            |  5 ++---
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uacce=
ss_64.h
index e68eded5ee490..123d36c89722f 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -66,14 +66,13 @@ static inline unsigned long __untagged_addr_remote(stru=
ct mm_struct *mm,
  */
 static inline void __user *mask_user_address(const void __user *ptr)
 {
-	unsigned long mask;
-
+	void __user *ret;
 	asm("cmp %1,%0\n\t"
-	    "sbb %0,%0"
-		 : "=3Dr" (mask)
-		 : "r" (ptr),
-		 "0" (runtime_const_ptr(USER_PTR_MAX)));
-	return (__force void __user *)(mask | (__force unsigned long)ptr);
+	    "cmova %1,%0"
+		:"=3Dr" (ret)
+		:"r" (runtime_const_ptr(USER_PTR_MAX)),
+		 "0" (ptr));
+	return ret;
 }
=20
 /*
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index ffa3fff259578..0f7f58f20b068 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -44,9 +44,8 @@
   .pushsection runtime_ptr_USER_PTR_MAX,"a"
 	.long 1b - 8 - .
   .popsection
-	cmp %rax, %rdx
-	sbb %rdx, %rdx
-	or %rdx, %rax
+	cmp %rdx, %rax
+	cmova %rdx, %rax
 .else
 	cmp $TASK_SIZE_MAX-\size+1, %eax
 .if \size !=3D 8
--=20
2.50.1.470.g6ba607880d-goog


