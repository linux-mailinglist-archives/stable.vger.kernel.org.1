Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9671B7A3AEC
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbjIQUKp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbjIQUK0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:10:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A56186
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:10:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CC7C433C7;
        Sun, 17 Sep 2023 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981414;
        bh=/NgG5ofWnNWIzekaGa3pCRph48HEiC5xiwlMpLYiKgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2HEFjRu/ONqX/P5Fa6vQdkQ+CaHyi7nViez90ZaVgvOl0hkW9UMcgbjoHQKPGS1k
         aB1hPaXh3WSsLSjZzXCFjYzpzHxpZsuEmRHkuKTfJORY/4xhhgDzhl8vXvGpoxsKNl
         5t2obnuZiasNvwAPRl5Etuy9dKrGy+SZfFnGmsz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Joey Gouly <joey.gouly@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, John Hsu <John.Hsu@mediatek.com>
Subject: [PATCH 5.15 050/511] arm64: lib: Import latest version of Arm Optimized Routines strncmp
Date:   Sun, 17 Sep 2023 21:07:57 +0200
Message-ID: <20230917191115.084670917@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joey Gouly <joey.gouly@arm.com>

commit 387d828adffcf1eb949f3141079c479793c59aac upstream.

Import the latest version of the Arm Optimized Routines strncmp function based
on the upstream code of string/aarch64/strncmp.S at commit 189dfefe37d5 from:
  https://github.com/ARM-software/optimized-routines

This latest version includes MTE support.

Note that for simplicity Arm have chosen to contribute this code to Linux under
GPLv2 rather than the original MIT OR Apache-2.0 WITH LLVM-exception license.
Arm is the sole copyright holder for this code.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20220301101435.19327-3-joey.gouly@arm.com
Fixes: 020b199bc70d ("arm64: Import latest version of Cortex Strings' strncmp")
Reported-by: John Hsu <John.Hsu@mediatek.com>
Link: https://lore.kernel.org/all/e9f30f7d5b7d72a3521da31ab2002b49a26f542e.camel@mediatek.com/
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/lib/strncmp.S |  236 ++++++++++++++++++++++++++++-------------------
 1 file changed, 142 insertions(+), 94 deletions(-)

--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2013-2021, Arm Limited.
+ * Copyright (c) 2013-2022, Arm Limited.
  *
  * Adapted from the original at:
- * https://github.com/ARM-software/optimized-routines/blob/e823e3abf5f89ecb/string/aarch64/strncmp.S
+ * https://github.com/ARM-software/optimized-routines/blob/189dfefe37d54c5b/string/aarch64/strncmp.S
  */
 
 #include <linux/linkage.h>
@@ -11,14 +11,14 @@
 
 /* Assumptions:
  *
- * ARMv8-a, AArch64
+ * ARMv8-a, AArch64.
+ * MTE compatible.
  */
 
 #define L(label) .L ## label
 
 #define REP8_01 0x0101010101010101
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
-#define REP8_80 0x8080808080808080
 
 /* Parameters and result.  */
 #define src1		x0
@@ -39,10 +39,24 @@
 #define tmp3		x10
 #define zeroones	x11
 #define pos		x12
-#define limit_wd	x13
-#define mask		x14
-#define endloop		x15
+#define mask		x13
+#define endloop		x14
 #define count		mask
+#define offset		pos
+#define neg_offset	x15
+
+/* Define endian dependent shift operations.
+   On big-endian early bytes are at MSB and on little-endian LSB.
+   LS_FW means shifting towards early bytes.
+   LS_BK means shifting towards later bytes.
+   */
+#ifdef __AARCH64EB__
+#define LS_FW lsl
+#define LS_BK lsr
+#else
+#define LS_FW lsr
+#define LS_BK lsl
+#endif
 
 SYM_FUNC_START_WEAK_PI(strncmp)
 	cbz	limit, L(ret0)
@@ -52,9 +66,6 @@ SYM_FUNC_START_WEAK_PI(strncmp)
 	and	count, src1, #7
 	b.ne	L(misaligned8)
 	cbnz	count, L(mutual_align)
-	/* Calculate the number of full and partial words -1.  */
-	sub	limit_wd, limit, #1	/* limit != 0, so no underflow.  */
-	lsr	limit_wd, limit_wd, #3	/* Convert to Dwords.  */
 
 	/* NUL detection works on the principle that (X - 1) & (~X) & 0x80
 	   (=> (X - 1) & ~(X | 0x7f)) is non-zero iff a byte is zero, and
@@ -64,56 +75,52 @@ L(loop_aligned):
 	ldr	data1, [src1], #8
 	ldr	data2, [src2], #8
 L(start_realigned):
-	subs	limit_wd, limit_wd, #1
+	subs	limit, limit, #8
 	sub	tmp1, data1, zeroones
 	orr	tmp2, data1, #REP8_7f
 	eor	diff, data1, data2	/* Non-zero if differences found.  */
-	csinv	endloop, diff, xzr, pl	/* Last Dword or differences.  */
+	csinv	endloop, diff, xzr, hi	/* Last Dword or differences.  */
 	bics	has_nul, tmp1, tmp2	/* Non-zero if NUL terminator.  */
 	ccmp	endloop, #0, #0, eq
 	b.eq	L(loop_aligned)
 	/* End of main loop */
 
-	/* Not reached the limit, must have found the end or a diff.  */
-	tbz	limit_wd, #63, L(not_limit)
-
-	/* Limit % 8 == 0 => all bytes significant.  */
-	ands	limit, limit, #7
-	b.eq	L(not_limit)
-
-	lsl	limit, limit, #3	/* Bits -> bytes.  */
-	mov	mask, #~0
-#ifdef __AARCH64EB__
-	lsr	mask, mask, limit
-#else
-	lsl	mask, mask, limit
-#endif
-	bic	data1, data1, mask
-	bic	data2, data2, mask
-
-	/* Make sure that the NUL byte is marked in the syndrome.  */
-	orr	has_nul, has_nul, mask
-
-L(not_limit):
+L(full_check):
+#ifndef __AARCH64EB__
 	orr	syndrome, diff, has_nul
-
-#ifndef	__AARCH64EB__
+	add	limit, limit, 8	/* Rewind limit to before last subs. */
+L(syndrome_check):
+	/* Limit was reached. Check if the NUL byte or the difference
+	   is before the limit. */
 	rev	syndrome, syndrome
 	rev	data1, data1
-	/* The MS-non-zero bit of the syndrome marks either the first bit
-	   that is different, or the top bit of the first zero byte.
-	   Shifting left now will bring the critical information into the
-	   top bits.  */
 	clz	pos, syndrome
 	rev	data2, data2
 	lsl	data1, data1, pos
+	cmp	limit, pos, lsr #3
 	lsl	data2, data2, pos
 	/* But we need to zero-extend (char is unsigned) the value and then
 	   perform a signed 32-bit subtraction.  */
 	lsr	data1, data1, #56
 	sub	result, data1, data2, lsr #56
+	csel result, result, xzr, hi
 	ret
 #else
+	/* Not reached the limit, must have found the end or a diff.  */
+	tbz	limit, #63, L(not_limit)
+	add	tmp1, limit, 8
+	cbz	limit, L(not_limit)
+
+	lsl	limit, tmp1, #3	/* Bits -> bytes.  */
+	mov	mask, #~0
+	lsr	mask, mask, limit
+	bic	data1, data1, mask
+	bic	data2, data2, mask
+
+	/* Make sure that the NUL byte is marked in the syndrome.  */
+	orr	has_nul, has_nul, mask
+
+L(not_limit):
 	/* For big-endian we cannot use the trick with the syndrome value
 	   as carry-propagation can corrupt the upper bits if the trailing
 	   bytes in the string contain 0x01.  */
@@ -134,10 +141,11 @@ L(not_limit):
 	rev	has_nul, has_nul
 	orr	syndrome, diff, has_nul
 	clz	pos, syndrome
-	/* The MS-non-zero bit of the syndrome marks either the first bit
-	   that is different, or the top bit of the first zero byte.
+	/* The most-significant-non-zero bit of the syndrome marks either the
+	   first bit that is different, or the top bit of the first zero byte.
 	   Shifting left now will bring the critical information into the
 	   top bits.  */
+L(end_quick):
 	lsl	data1, data1, pos
 	lsl	data2, data2, pos
 	/* But we need to zero-extend (char is unsigned) the value and then
@@ -159,22 +167,12 @@ L(mutual_align):
 	neg	tmp3, count, lsl #3	/* 64 - bits(bytes beyond align). */
 	ldr	data2, [src2], #8
 	mov	tmp2, #~0
-	sub	limit_wd, limit, #1	/* limit != 0, so no underflow.  */
-#ifdef __AARCH64EB__
-	/* Big-endian.  Early bytes are at MSB.  */
-	lsl	tmp2, tmp2, tmp3	/* Shift (count & 63).  */
-#else
-	/* Little-endian.  Early bytes are at LSB.  */
-	lsr	tmp2, tmp2, tmp3	/* Shift (count & 63).  */
-#endif
-	and	tmp3, limit_wd, #7
-	lsr	limit_wd, limit_wd, #3
-	/* Adjust the limit. Only low 3 bits used, so overflow irrelevant.  */
-	add	limit, limit, count
-	add	tmp3, tmp3, count
+	LS_FW	tmp2, tmp2, tmp3	/* Shift (count & 63).  */
+	/* Adjust the limit and ensure it doesn't overflow.  */
+	adds	limit, limit, count
+	csinv	limit, limit, xzr, lo
 	orr	data1, data1, tmp2
 	orr	data2, data2, tmp2
-	add	limit_wd, limit_wd, tmp3, lsr #3
 	b	L(start_realigned)
 
 	.p2align 4
@@ -197,13 +195,11 @@ L(done):
 	/* Align the SRC1 to a dword by doing a bytewise compare and then do
 	   the dword loop.  */
 L(try_misaligned_words):
-	lsr	limit_wd, limit, #3
-	cbz	count, L(do_misaligned)
+	cbz	count, L(src1_aligned)
 
 	neg	count, count
 	and	count, count, #7
 	sub	limit, limit, count
-	lsr	limit_wd, limit, #3
 
 L(page_end_loop):
 	ldrb	data1w, [src1], #1
@@ -214,48 +210,100 @@ L(page_end_loop):
 	subs	count, count, #1
 	b.hi	L(page_end_loop)
 
-L(do_misaligned):
-	/* Prepare ourselves for the next page crossing.  Unlike the aligned
-	   loop, we fetch 1 less dword because we risk crossing bounds on
-	   SRC2.  */
-	mov	count, #8
-	subs	limit_wd, limit_wd, #1
-	b.lo	L(done_loop)
+	/* The following diagram explains the comparison of misaligned strings.
+	   The bytes are shown in natural order. For little-endian, it is
+	   reversed in the registers. The "x" bytes are before the string.
+	   The "|" separates data that is loaded at one time.
+	   src1     | a a a a a a a a | b b b c c c c c | . . .
+	   src2     | x x x x x a a a   a a a a a b b b | c c c c c . . .
+
+	   After shifting in each step, the data looks like this:
+	                STEP_A              STEP_B              STEP_C
+	   data1    a a a a a a a a     b b b c c c c c     b b b c c c c c
+	   data2    a a a a a a a a     b b b 0 0 0 0 0     0 0 0 c c c c c
+
+	   The bytes with "0" are eliminated from the syndrome via mask.
+
+	   Align SRC2 down to 16 bytes. This way we can read 16 bytes at a
+	   time from SRC2. The comparison happens in 3 steps. After each step
+	   the loop can exit, or read from SRC1 or SRC2. */
+L(src1_aligned):
+	/* Calculate offset from 8 byte alignment to string start in bits. No
+	   need to mask offset since shifts are ignoring upper bits. */
+	lsl	offset, src2, #3
+	bic	src2, src2, #0xf
+	mov	mask, -1
+	neg	neg_offset, offset
+	ldr	data1, [src1], #8
+	ldp	tmp1, tmp2, [src2], #16
+	LS_BK	mask, mask, neg_offset
+	and	neg_offset, neg_offset, #63	/* Need actual value for cmp later. */
+	/* Skip the first compare if data in tmp1 is irrelevant. */
+	tbnz	offset, 6, L(misaligned_mid_loop)
+
 L(loop_misaligned):
-	and	tmp2, src2, #0xff8
-	eor	tmp2, tmp2, #0xff8
-	cbz	tmp2, L(page_end_loop)
+	/* STEP_A: Compare full 8 bytes when there is enough data from SRC2.*/
+	LS_FW	data2, tmp1, offset
+	LS_BK	tmp1, tmp2, neg_offset
+	subs	limit, limit, #8
+	orr	data2, data2, tmp1	/* 8 bytes from SRC2 combined from two regs.*/
+	sub	has_nul, data1, zeroones
+	eor	diff, data1, data2	/* Non-zero if differences found.  */
+	orr	tmp3, data1, #REP8_7f
+	csinv	endloop, diff, xzr, hi	/* If limit, set to all ones. */
+	bic	has_nul, has_nul, tmp3	/* Non-zero if NUL byte found in SRC1. */
+	orr	tmp3, endloop, has_nul
+	cbnz	tmp3, L(full_check)
 
 	ldr	data1, [src1], #8
-	ldr	data2, [src2], #8
-	sub	tmp1, data1, zeroones
-	orr	tmp2, data1, #REP8_7f
-	eor	diff, data1, data2	/* Non-zero if differences found.  */
-	bics	has_nul, tmp1, tmp2	/* Non-zero if NUL terminator.  */
-	ccmp	diff, #0, #0, eq
-	b.ne	L(not_limit)
-	subs	limit_wd, limit_wd, #1
-	b.pl	L(loop_misaligned)
-
-L(done_loop):
-	/* We found a difference or a NULL before the limit was reached.  */
-	and	limit, limit, #7
-	cbz	limit, L(not_limit)
-	/* Read the last word.  */
-	sub	src1, src1, 8
-	sub	src2, src2, 8
-	ldr	data1, [src1, limit]
-	ldr	data2, [src2, limit]
-	sub	tmp1, data1, zeroones
-	orr	tmp2, data1, #REP8_7f
-	eor	diff, data1, data2	/* Non-zero if differences found.  */
-	bics	has_nul, tmp1, tmp2	/* Non-zero if NUL terminator.  */
-	ccmp	diff, #0, #0, eq
-	b.ne	L(not_limit)
+L(misaligned_mid_loop):
+	/* STEP_B: Compare first part of data1 to second part of tmp2. */
+	LS_FW	data2, tmp2, offset
+#ifdef __AARCH64EB__
+	/* For big-endian we do a byte reverse to avoid carry-propagation
+	problem described above. This way we can reuse the has_nul in the
+	next step and also use syndrome value trick at the end. */
+	rev	tmp3, data1
+	#define data1_fixed tmp3
+#else
+	#define data1_fixed data1
+#endif
+	sub	has_nul, data1_fixed, zeroones
+	orr	tmp3, data1_fixed, #REP8_7f
+	eor	diff, data2, data1	/* Non-zero if differences found.  */
+	bic	has_nul, has_nul, tmp3	/* Non-zero if NUL terminator.  */
+#ifdef __AARCH64EB__
+	rev	has_nul, has_nul
+#endif
+	cmp	limit, neg_offset, lsr #3
+	orr	syndrome, diff, has_nul
+	bic	syndrome, syndrome, mask	/* Ignore later bytes. */
+	csinv	tmp3, syndrome, xzr, hi	/* If limit, set to all ones. */
+	cbnz	tmp3, L(syndrome_check)
+
+	/* STEP_C: Compare second part of data1 to first part of tmp1. */
+	ldp	tmp1, tmp2, [src2], #16
+	cmp	limit, #8
+	LS_BK	data2, tmp1, neg_offset
+	eor	diff, data2, data1	/* Non-zero if differences found.  */
+	orr	syndrome, diff, has_nul
+	and	syndrome, syndrome, mask	/* Ignore earlier bytes. */
+	csinv	tmp3, syndrome, xzr, hi	/* If limit, set to all ones. */
+	cbnz	tmp3, L(syndrome_check)
+
+	ldr	data1, [src1], #8
+	sub	limit, limit, #8
+	b	L(loop_misaligned)
+
+#ifdef	__AARCH64EB__
+L(syndrome_check):
+	clz	pos, syndrome
+	cmp	pos, limit, lsl #3
+	b.lo	L(end_quick)
+#endif
 
 L(ret0):
 	mov	result, #0
 	ret
-
 SYM_FUNC_END_PI(strncmp)
 EXPORT_SYMBOL_NOHWKASAN(strncmp)


