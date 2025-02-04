Return-Path: <stable+bounces-112253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B18EA27E51
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 23:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B7816471A
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 22:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED69D21B19F;
	Tue,  4 Feb 2025 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="GuLlVvIp"
X-Original-To: stable@vger.kernel.org
Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBE914AD2B;
	Tue,  4 Feb 2025 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738708547; cv=none; b=sN2ox9ifI1BHAXWhig/6p9+1vUXFWdVDkr3bPCWgIfBcfmCr/EFUI8msTtcQk/mOF9f/GSq6ouoY4QZph3y6XBjXp6Lic8myaTrGW+sTSGijn+dVcf1+1/J3cqhk/wkF5OHSFeUv2N7PsUq4G08Q3dja6s5BhFPk+BMBBER1Kcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738708547; c=relaxed/simple;
	bh=Tbu+XRno/u/g1c/g++qeRZlFVrqJuvN/hVBnJ0xt64k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aL2VuNYi4MNjLBO7QZOy+rXc+fQ8lhaBobAN7rdiMNxLLenmYsSvJMYP6wIIybyiQhD5VRjjHN0K2mJg9CYgvy6cZuS0eSQCZVgG8Wq5RkgfXXF//3uimX+fN8y6IUUBN3N9ibQWXL/1EpmRIcrFx9sF7M/Xl9eFNq1cVnNnDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=GuLlVvIp; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eu0uinCL9OMvaWq1Gs/7fRYGHoqa6F3Rj2exh5B37II=; b=GuLlVvIpQdKIiSi/2g1IZRavf+
	XkzWIQOFkDhIaFBcpUw8amudSkCgyOXW29+LYHSpVvswk/aKwbzNT7HFfDJ9c4kLCUTDtqQec7Pbz
	ursqosVy9YBrj+OF7lM4JZ2QgdZTfmj8ZSWap8HsCMNvfylNczh/vV7sG6bGKqU+lBGePfPX1NGpJ
	wzuqpbKQ48RGGnfrye7LBGvEVStssDtHPOSkOs1vnZ09qYs93n73ZybmR3PPM2qpeK01e/ZiQB8CF
	cglSS6qr0QYdx4teAIu0ReZTwViSpyT4I5R0SkcOq3ME2+n1yqmHWa7EYME/pJyh4tNGtCbjr4BN3
	ZUPNwhTg==;
Received: from ink by minute.unseen.parts with local (Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tfRVs-0001cT-1p;
	Tue, 04 Feb 2025 23:35:24 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Magnus Lindholm <linmag7@gmail.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] alpha: align stack for page fault and user unaligned trap handlers
Date: Tue,  4 Feb 2025 23:35:24 +0100
Message-Id: <20250204223524.6207-4-ink@unseen.parts>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250204223524.6207-1-ink@unseen.parts>
References: <20250204223524.6207-1-ink@unseen.parts>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_page_fault() and do_entUna() are special because they use
non-standard stack frame layout. Fix them manually.

Cc: stable@vger.kernel.org
Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Ivan Kokshaysky <ink@unseen.parts>
---
 arch/alpha/kernel/entry.S | 20 ++++++++++----------
 arch/alpha/kernel/traps.c |  2 +-
 arch/alpha/mm/fault.c     |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index 6fb38365539d..f4d41b4538c2 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -194,8 +194,8 @@ CFI_END_OSF_FRAME entArith
 CFI_START_OSF_FRAME entMM
 	SAVE_ALL
 /* save $9 - $15 so the inline exception code can manipulate them.  */
-	subq	$sp, 56, $sp
-	.cfi_adjust_cfa_offset	56
+	subq	$sp, 64, $sp
+	.cfi_adjust_cfa_offset	64
 	stq	$9, 0($sp)
 	stq	$10, 8($sp)
 	stq	$11, 16($sp)
@@ -210,7 +210,7 @@ CFI_START_OSF_FRAME entMM
 	.cfi_rel_offset	$13, 32
 	.cfi_rel_offset	$14, 40
 	.cfi_rel_offset	$15, 48
-	addq	$sp, 56, $19
+	addq	$sp, 64, $19
 /* handle the fault */
 	lda	$8, 0x3fff
 	bic	$sp, $8, $8
@@ -223,7 +223,7 @@ CFI_START_OSF_FRAME entMM
 	ldq	$13, 32($sp)
 	ldq	$14, 40($sp)
 	ldq	$15, 48($sp)
-	addq	$sp, 56, $sp
+	addq	$sp, 64, $sp
 	.cfi_restore	$9
 	.cfi_restore	$10
 	.cfi_restore	$11
@@ -231,7 +231,7 @@ CFI_START_OSF_FRAME entMM
 	.cfi_restore	$13
 	.cfi_restore	$14
 	.cfi_restore	$15
-	.cfi_adjust_cfa_offset	-56
+	.cfi_adjust_cfa_offset	-64
 /* finish up the syscall as normal.  */
 	br	ret_from_sys_call
 CFI_END_OSF_FRAME entMM
@@ -378,8 +378,8 @@ entUnaUser:
 	.cfi_restore	$0
 	.cfi_adjust_cfa_offset	-256
 	SAVE_ALL		/* setup normal kernel stack */
-	lda	$sp, -56($sp)
-	.cfi_adjust_cfa_offset	56
+	lda	$sp, -64($sp)
+	.cfi_adjust_cfa_offset	64
 	stq	$9, 0($sp)
 	stq	$10, 8($sp)
 	stq	$11, 16($sp)
@@ -395,7 +395,7 @@ entUnaUser:
 	.cfi_rel_offset	$14, 40
 	.cfi_rel_offset	$15, 48
 	lda	$8, 0x3fff
-	addq	$sp, 56, $19
+	addq	$sp, 64, $19
 	bic	$sp, $8, $8
 	jsr	$26, do_entUnaUser
 	ldq	$9, 0($sp)
@@ -405,7 +405,7 @@ entUnaUser:
 	ldq	$13, 32($sp)
 	ldq	$14, 40($sp)
 	ldq	$15, 48($sp)
-	lda	$sp, 56($sp)
+	lda	$sp, 64($sp)
 	.cfi_restore	$9
 	.cfi_restore	$10
 	.cfi_restore	$11
@@ -413,7 +413,7 @@ entUnaUser:
 	.cfi_restore	$13
 	.cfi_restore	$14
 	.cfi_restore	$15
-	.cfi_adjust_cfa_offset	-56
+	.cfi_adjust_cfa_offset	-64
 	br	ret_from_sys_call
 CFI_END_OSF_FRAME entUna
 
diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index a9a38c80c4a7..7004397937cf 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -649,7 +649,7 @@ s_reg_to_mem (unsigned long s_reg)
 static int unauser_reg_offsets[32] = {
 	R(r0), R(r1), R(r2), R(r3), R(r4), R(r5), R(r6), R(r7), R(r8),
 	/* r9 ... r15 are stored in front of regs.  */
-	-56, -48, -40, -32, -24, -16, -8,
+	-64, -56, -48, -40, -32, -24, -16,	/* padding at -8 */
 	R(r16), R(r17), R(r18),
 	R(r19), R(r20), R(r21), R(r22), R(r23), R(r24), R(r25), R(r26),
 	R(r27), R(r28), R(gp),
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 8c9850437e67..a9816bbc9f34 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -78,8 +78,8 @@ __load_new_mm_context(struct mm_struct *next_mm)
 
 /* Macro for exception fixup code to access integer registers.  */
 #define dpf_reg(r)							\
-	(((unsigned long *)regs)[(r) <= 8 ? (r) : (r) <= 15 ? (r)-16 :	\
-				 (r) <= 18 ? (r)+10 : (r)-10])
+	(((unsigned long *)regs)[(r) <= 8 ? (r) : (r) <= 15 ? (r)-17 :	\
+				 (r) <= 18 ? (r)+11 : (r)-10])
 
 asmlinkage void
 do_page_fault(unsigned long address, unsigned long mmcsr,
-- 
2.47.2


