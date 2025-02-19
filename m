Return-Path: <stable+bounces-117396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D5EA3B637
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A177C17C988
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74F61DFE30;
	Wed, 19 Feb 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BJebpZVp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744451C4A20;
	Wed, 19 Feb 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955148; cv=none; b=gbCjC1DKiIcLhlI7QXNNUFMk5X9kVoAK08HmaDE+dbn+TsTld7VJMKB5iFeHqlb11ACeq0wHhKT/smEWhdFuMxNL5gwvQyg75fzTtw4ywj4EmX2AyL1ELYzoLUJukrpHtP5Qax79WGwcWF2asfwTx1EW8Umkh5AXkC+1vuaz8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955148; c=relaxed/simple;
	bh=Qou3JCgK6hkxzvDz6K5v7CrNhJuYYOH4R3d6BJzn6ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHt1/sW2ZHj755uaHhi23sB6WkXOEchPQfjsJjzyHkO57xsGPqZF23lDpZWHKnnBbB7TgKArp2Q+tQijq08ykFN8e+OtqBEbeVH8Pmf+it1eQG04MJaBefkibHUa2eAxjDp45Kl2QJX5OP9ZazFWp52drZW5uudYA3RzXqyJK+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BJebpZVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940DBC4CED1;
	Wed, 19 Feb 2025 08:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955148;
	bh=Qou3JCgK6hkxzvDz6K5v7CrNhJuYYOH4R3d6BJzn6ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJebpZVpJ/FeKgCxu9OwqD3c5UXUzeXpk7ZlzvI8w8OyIDNlO1jWhEfiBX3AdZYvY
	 ewR+iWIXLNB1lMdc/A3l7THX/swEL+7BBeGbeygQ72pfBh8+us9Q1Ku3J8xJ3Ibtof
	 Jxn0x/QN3OSwdPFruP6TrsRw9KiWVRdBxxwbqMoQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Ivan Kokshaysky <ink@unseen.parts>
Subject: [PATCH 6.12 147/230] alpha: align stack for page fault and user unaligned trap handlers
Date: Wed, 19 Feb 2025 09:27:44 +0100
Message-ID: <20250219082607.436168890@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Kokshaysky <ink@unseen.parts>

commit 3b35a171060f846b08b48646b38c30b5d57d17ff upstream.

do_page_fault() and do_entUna() are special because they use
non-standard stack frame layout. Fix them manually.

Cc: stable@vger.kernel.org
Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>
Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Ivan Kokshaysky <ink@unseen.parts>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/alpha/kernel/entry.S |   20 ++++++++++----------
 arch/alpha/kernel/traps.c |    2 +-
 arch/alpha/mm/fault.c     |    4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

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
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -78,8 +78,8 @@ __load_new_mm_context(struct mm_struct *
 
 /* Macro for exception fixup code to access integer registers.  */
 #define dpf_reg(r)							\
-	(((unsigned long *)regs)[(r) <= 8 ? (r) : (r) <= 15 ? (r)-16 :	\
-				 (r) <= 18 ? (r)+10 : (r)-10])
+	(((unsigned long *)regs)[(r) <= 8 ? (r) : (r) <= 15 ? (r)-17 :	\
+				 (r) <= 18 ? (r)+11 : (r)-10])
 
 asmlinkage void
 do_page_fault(unsigned long address, unsigned long mmcsr,



