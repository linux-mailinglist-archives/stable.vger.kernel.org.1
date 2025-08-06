Return-Path: <stable+bounces-166726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FC6B1C9AE
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AFD27AE542
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4B822541B;
	Wed,  6 Aug 2025 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yLB1tz7H"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB9B289808
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497222; cv=none; b=s0rfjz0Jgq3/rijX4m/BTjUP8iu41ejz2iBRu3RDQGmufhXP+tWsB+N6iAgE5GxEPg8Yu2BN8wcRoxraiMvt7B05pQB7SU86AvDr8um4JqwUMtaLJd9EIqwpP5VF9uHmyATqaA46AmP/CU36XNh9pd9kY7uJ+YG7Z5rrlYVv4xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497222; c=relaxed/simple;
	bh=Igymf+wo2cKjoancO07p07/mpVPMA5Hf68yAso8scZc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VB0J6fVXP5tezLw6MJHSAeNxjhrOy7oM3nh1QXhfLOHDCuXokTHWIHC78x+Pk73XF4XSAKYVi2ip74uCLVc/Dka9EHgiUZKr50J2WLDKSHiLD+IPgcm4vJ2Pxl3w6WFLD8i0y2pY57V4CpeJilr6y+ITvoPb+R0s1uqTPie1ny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yLB1tz7H; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b115fb801bcso9500599a12.3
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754497219; x=1755102019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgvyoWXE6pqkV9EGc/q1G6vaEqjOxNVRB2tBqLmp7E8=;
        b=yLB1tz7HNK8z4xXFvf/5psIrrXo6iFFQWDV3onFJX3jWwaaxTZKjG35lYTIOyb55eD
         1ulRNOkFiqE5P5FWHuFgsQDhIrXVA/gBmNEK9ZBQmKd+m+jcVyy7T+j13JtSlxdrWaTC
         p10SzFDkHV6IccoAqb+rBdq/f8BskmOrfeNrz80LHb49BTuyXqU3HWHYOm9/+APWHi3S
         NDzqSxYiRsfswqJSbxBCCtElrLyxWaJif96XsGk7JBFf5B/p0D97C7WZYCSkJr/cdOAj
         XC8DhtMCoPYWMzQo4RKbey50TyiS03450QT3yvhlyJGP3JQOvHiCzgmXA72Ibcz97iHa
         +gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497219; x=1755102019;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SgvyoWXE6pqkV9EGc/q1G6vaEqjOxNVRB2tBqLmp7E8=;
        b=k0gmr2Ca1TOuETgyfOUxh+9vP+lABWvLVv1qAvFhpA4WOru4r1GRT9PxZFDFdwvFKA
         f++hW4Fbg2u7iWl3DaeWQPDZ+o8NVtEp27AzbxSKVEfOrQ5JiFHfeYDumvzdYJ99Ef88
         LD89y7os2oPFm270PhXqq0O4NnMl6TL8h4vqfF0EJEqNRAAqgf659IpvSy1NSpg8Jfwq
         Pi/sMotKLasEKSJ0RU6NQLjjtaXFPdNAE/EtpBlm23p2JlIMdHAvAbK1F+jq7gV9C+1q
         CsOt/q6SdcRLQ9LOD0Rb/AnoN/2Q6OxDHrXn9Hnxma4qZIpP21oOMMeZw9OCIrA68zBY
         T2/A==
X-Gm-Message-State: AOJu0YyqmlsuFrz7Bj1eDp1U7iUma2/4lTZ3zuDeBExKzrnYNl7idFPP
	ngOW8MmrOpNuyj77PCCZUIr0K42ZkTIk5o6+TtaJeWl/LAAQrYmp+zALWabwu84l5o/VEOXFNO4
	SuEBKHJTxdhrfs+/Dv/vOhIk0tcmI5yDHjqwGoX0yzjMEYHKMcdhOM2KqkLAblqM9QM+ivDT0PE
	yIDvwgY5xI4oFA5ksTMJDZ3dPaKSTcOjC1siGsPBm8AUQKXawVKYnB
X-Google-Smtp-Source: AGHT+IFAoIkyDi2Ox1tLn2mY07dTs+hlmjWCImx0B3iB1FB9JNrZXo2HPTuf6wqf8oVTSjvtOWztfYa7HQlNtCU=
X-Received: from plblh11.prod.google.com ([2002:a17:903:290b:b0:240:39eb:1e8c])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ccce:b0:240:96c1:e860 with SMTP id d9443c01a7336-2429f5338famr41935935ad.28.1754497219251;
 Wed, 06 Aug 2025 09:20:19 -0700 (PDT)
Date: Wed,  6 Aug 2025 16:20:03 +0000
In-Reply-To: <20250806162003.1134886-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806162003.1134886-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806162003.1134886-8-jtoantran@google.com>
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


