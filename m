Return-Path: <stable+bounces-43803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050DC8C4FB3
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 12:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA183282F5D
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C24A12EBDC;
	Tue, 14 May 2024 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YW2BhRYg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65C433D8;
	Tue, 14 May 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682341; cv=none; b=adyu0V+3xYDQf4DPKJZDpLzOmaXC9lbsg8oK695JMY7EkUu9JTXOuX3wOL+Yu4eCYr4HugmpCQQRRqeg6ecNCXbSP7ycei0MdHVl4mHOTSt7HrP2QiOsFfGU+i1QRfRDyacxKdutiIpsJ1GOzislbFQ40utZ7OZ9RG0ox2M+b2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682341; c=relaxed/simple;
	bh=39yi8/Yh8M7NmQQbRhhJ1dnZFRPImMAjJ+vYrIjvJyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZdDkqCbGetkr8v3kyBgYsrIP/+RVld7V9JPQvT/2MmWIxcmF3m45CMhgFiZXxxFDVDTBhMf8aeenhKUY6f/KMvoS78gbNs6RsMkkfoPSl+BovsvVEBlbkbmqFBvyo3OGmW99SqpfAtok4ylOSQ99XB+vtuL3AYpNyo7SqRzXeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YW2BhRYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1382CC2BD10;
	Tue, 14 May 2024 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715682340;
	bh=39yi8/Yh8M7NmQQbRhhJ1dnZFRPImMAjJ+vYrIjvJyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YW2BhRYgyVjD+cGywKY1E5jityAngUwjBBT8XOouFBEtWXm0Q4Bd1H1pniP101r7R
	 7WHN2qG+0TP8z+eW2g0mCXallAQdOuyFFf1Y0gWBHajbS9IVvBKYYkKfjHdY9W1MiK
	 hkaNM/cR3a2aLVMLnqoCp3JJj9CnWrWjYctSMBgo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+186522670e6722692d86@syzkaller.appspotmail.com,
	Puranjay Mohan <puranjay@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 040/336] arm32, bpf: Reimplement sign-extension mov instruction
Date: Tue, 14 May 2024 12:14:04 +0200
Message-ID: <20240514101040.122558925@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Puranjay Mohan <puranjay@kernel.org>

[ Upstream commit c6f48506ba30c722dd9d89aa6a40eb1926277dff ]

The current implementation of the mov instruction with sign extension has the
following problems:

  1. It clobbers the source register if it is not stacked because it
     sign extends the source and then moves it to the destination.
  2. If the dst_reg is stacked, the current code doesn't write the value
     back in case of 64-bit mov.
  3. There is room for improvement by emitting fewer instructions.

The steps for fixing this and the instructions emitted by the JIT are explained
below with examples in all combinations:

Case A: offset == 32:
=====================

  Case A.1: src and dst are stacked registers:
  --------------------------------------------
    1. Load src_lo into tmp_lo
    2. Store tmp_lo into dst_lo
    3. Sign extend tmp_lo into tmp_hi
    4. Store tmp_hi to dst_hi

    Example: r3 = (s32)r3
	r3 is a stacked register

	ldr     r6, [r11, #-16]	// Load r3_lo into tmp_lo
	// str to dst_lo is not emitted because src_lo == dst_lo
	asr     r7, r6, #31	// Sign extend tmp_lo into tmp_hi
	str     r7, [r11, #-12] // Store tmp_hi into r3_hi

  Case A.2: src is stacked but dst is not:
  ----------------------------------------
    1. Load src_lo into dst_lo
    2. Sign extend dst_lo into dst_hi

    Example: r6 = (s32)r3
	r6 maps to {ARM_R5, ARM_R4} and r3 is stacked

	ldr     r4, [r11, #-16] // Load r3_lo into r6_lo
	asr     r5, r4, #31	// Sign extend r6_lo into r6_hi

  Case A.3: src is not stacked but dst is stacked:
  ------------------------------------------------
    1. Store src_lo into dst_lo
    2. Sign extend src_lo into tmp_hi
    3. Store tmp_hi to dst_hi

    Example: r3 = (s32)r6
	r3 is stacked and r6 maps to {ARM_R5, ARM_R4}

	str     r4, [r11, #-16] // Store r6_lo to r3_lo
	asr     r7, r4, #31	// Sign extend r6_lo into tmp_hi
	str     r7, [r11, #-12]	// Store tmp_hi to dest_hi

  Case A.4: Both src and dst are not stacked:
  -------------------------------------------
    1. Mov src_lo into dst_lo
    2. Sign extend src_lo into dst_hi

    Example: (bf) r6 = (s32)r6
	r6 maps to {ARM_R5, ARM_R4}

	// Mov not emitted because dst == src
	asr     r5, r4, #31 // Sign extend r6_lo into r6_hi

Case B: offset != 32:
=====================

  Case B.1: src and dst are stacked registers:
  --------------------------------------------
    1. Load src_lo into tmp_lo
    2. Sign extend tmp_lo according to offset.
    3. Store tmp_lo into dst_lo
    4. Sign extend tmp_lo into tmp_hi
    5. Store tmp_hi to dst_hi

    Example: r9 = (s8)r3
	r9 and r3 are both stacked registers

	ldr     r6, [r11, #-16] // Load r3_lo into tmp_lo
	lsl     r6, r6, #24	// Sign extend tmp_lo
	asr     r6, r6, #24	// ..
	str     r6, [r11, #-56] // Store tmp_lo to r9_lo
	asr     r7, r6, #31	// Sign extend tmp_lo to tmp_hi
	str     r7, [r11, #-52] // Store tmp_hi to r9_hi

  Case B.2: src is stacked but dst is not:
  ----------------------------------------
    1. Load src_lo into dst_lo
    2. Sign extend dst_lo according to offset.
    3. Sign extend tmp_lo into dst_hi

    Example: r6 = (s8)r3
	r6 maps to {ARM_R5, ARM_R4} and r3 is stacked

	ldr     r4, [r11, #-16] // Load r3_lo to r6_lo
	lsl     r4, r4, #24	// Sign extend r6_lo
	asr     r4, r4, #24	// ..
	asr     r5, r4, #31	// Sign extend r6_lo into r6_hi

  Case B.3: src is not stacked but dst is stacked:
  ------------------------------------------------
    1. Sign extend src_lo into tmp_lo according to offset.
    2. Store tmp_lo into dst_lo.
    3. Sign extend src_lo into tmp_hi.
    4. Store tmp_hi to dst_hi.

    Example: r3 = (s8)r1
	r3 is stacked and r1 maps to {ARM_R3, ARM_R2}

	lsl     r6, r2, #24 	// Sign extend r1_lo to tmp_lo
	asr     r6, r6, #24	// ..
	str     r6, [r11, #-16] // Store tmp_lo to r3_lo
	asr     r7, r6, #31	// Sign extend tmp_lo to tmp_hi
	str     r7, [r11, #-12] // Store tmp_hi to r3_hi

  Case B.4: Both src and dst are not stacked:
  -------------------------------------------
    1. Sign extend src_lo into dst_lo according to offset.
    2. Sign extend dst_lo into dst_hi.

    Example: r6 = (s8)r1
	r6 maps to {ARM_R5, ARM_R4} and r1 maps to {ARM_R3, ARM_R2}

	lsl     r4, r2, #24	// Sign extend r1_lo to r6_lo
	asr     r4, r4, #24	// ..
	asr     r5, r4, #31	// Sign extend r6_lo to r6_hi

Fixes: fc832653fa0d ("arm32, bpf: add support for sign-extension mov instruction")
Reported-by: syzbot+186522670e6722692d86@syzkaller.appspotmail.com
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Closes: https://lore.kernel.org/all/000000000000e9a8d80615163f2a@google.com
Link: https://lore.kernel.org/bpf/20240419182832.27707-1-puranjay@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/net/bpf_jit_32.c | 56 ++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 1d672457d02ff..72b5cd697f5d9 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -871,16 +871,11 @@ static inline void emit_a32_alu_r64(const bool is64, const s8 dst[],
 }
 
 /* dst = src (4 bytes)*/
-static inline void emit_a32_mov_r(const s8 dst, const s8 src, const u8 off,
-				  struct jit_ctx *ctx) {
+static inline void emit_a32_mov_r(const s8 dst, const s8 src, struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	s8 rt;
 
 	rt = arm_bpf_get_reg32(src, tmp[0], ctx);
-	if (off && off != 32) {
-		emit(ARM_LSL_I(rt, rt, 32 - off), ctx);
-		emit(ARM_ASR_I(rt, rt, 32 - off), ctx);
-	}
 	arm_bpf_put_reg32(dst, rt, ctx);
 }
 
@@ -889,15 +884,15 @@ static inline void emit_a32_mov_r64(const bool is64, const s8 dst[],
 				  const s8 src[],
 				  struct jit_ctx *ctx) {
 	if (!is64) {
-		emit_a32_mov_r(dst_lo, src_lo, 0, ctx);
+		emit_a32_mov_r(dst_lo, src_lo, ctx);
 		if (!ctx->prog->aux->verifier_zext)
 			/* Zero out high 4 bytes */
 			emit_a32_mov_i(dst_hi, 0, ctx);
 	} else if (__LINUX_ARM_ARCH__ < 6 &&
 		   ctx->cpu_architecture < CPU_ARCH_ARMv5TE) {
 		/* complete 8 byte move */
-		emit_a32_mov_r(dst_lo, src_lo, 0, ctx);
-		emit_a32_mov_r(dst_hi, src_hi, 0, ctx);
+		emit_a32_mov_r(dst_lo, src_lo, ctx);
+		emit_a32_mov_r(dst_hi, src_hi, ctx);
 	} else if (is_stacked(src_lo) && is_stacked(dst_lo)) {
 		const u8 *tmp = bpf2a32[TMP_REG_1];
 
@@ -917,17 +912,52 @@ static inline void emit_a32_mov_r64(const bool is64, const s8 dst[],
 static inline void emit_a32_movsx_r64(const bool is64, const u8 off, const s8 dst[], const s8 src[],
 				      struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	const s8 *rt;
+	s8 rs;
+	s8 rd;
 
-	rt = arm_bpf_get_reg64(dst, tmp, ctx);
+	if (is_stacked(dst_lo))
+		rd = tmp[1];
+	else
+		rd = dst_lo;
+	rs = arm_bpf_get_reg32(src_lo, rd, ctx);
+	/* rs may be one of src[1], dst[1], or tmp[1] */
+
+	/* Sign extend rs if needed. If off == 32, lower 32-bits of src are moved to dst and sign
+	 * extension only happens in the upper 64 bits.
+	 */
+	if (off != 32) {
+		/* Sign extend rs into rd */
+		emit(ARM_LSL_I(rd, rs, 32 - off), ctx);
+		emit(ARM_ASR_I(rd, rd, 32 - off), ctx);
+	} else {
+		rd = rs;
+	}
+
+	/* Write rd to dst_lo
+	 *
+	 * Optimization:
+	 * Assume:
+	 * 1. dst == src and stacked.
+	 * 2. off == 32
+	 *
+	 * In this case src_lo was loaded into rd(tmp[1]) but rd was not sign extended as off==32.
+	 * So, we don't need to write rd back to dst_lo as they have the same value.
+	 * This saves us one str instruction.
+	 */
+	if (dst_lo != src_lo || off != 32)
+		arm_bpf_put_reg32(dst_lo, rd, ctx);
 
-	emit_a32_mov_r(dst_lo, src_lo, off, ctx);
 	if (!is64) {
 		if (!ctx->prog->aux->verifier_zext)
 			/* Zero out high 4 bytes */
 			emit_a32_mov_i(dst_hi, 0, ctx);
 	} else {
-		emit(ARM_ASR_I(rt[0], rt[1], 31), ctx);
+		if (is_stacked(dst_hi)) {
+			emit(ARM_ASR_I(tmp[0], rd, 31), ctx);
+			arm_bpf_put_reg32(dst_hi, tmp[0], ctx);
+		} else {
+			emit(ARM_ASR_I(dst_hi, rd, 31), ctx);
+		}
 	}
 }
 
-- 
2.43.0




