Return-Path: <stable+bounces-48565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4248FE989
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EEA1C22442
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E1D19884A;
	Thu,  6 Jun 2024 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x0BQOljE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C6A19AA7C;
	Thu,  6 Jun 2024 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683036; cv=none; b=dWESGvgIIxLYSJbIafH5KbhmCrE70ETOsHTgARIpIYTAX0pprpFaYonJ9c/nmaflU8z123RqlZ4w+1EE5xk/Y0yvV/Jln0+1y5RBPU9ir+XF0OiQzGL7wBOZBpVlaIXjoPSV5KfmFL4xK9oAnadeOu0X+UyfIuifbxNUoQiQMRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683036; c=relaxed/simple;
	bh=rjoTRT4LGlrQ9wj21eDSj2Lhd122HSOdl1EIGX4fXlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cz0Nwm8i9IJwcn98IszH1pKmY3cn+no2KMuqx2jhtrn/+veHBf0OTZxlAyF/LSAI+v+6iWE18OcyD707fT9uRnfIG6xFrpUzPLiBUxJPVvd9v3qfpoveM6YSmj9LnX9l+0Z8sH9BOdwI2Srcyzt91U0ZVVTHBfuCmSjnTUiFgZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x0BQOljE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A56CC4AF51;
	Thu,  6 Jun 2024 14:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683036;
	bh=rjoTRT4LGlrQ9wj21eDSj2Lhd122HSOdl1EIGX4fXlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x0BQOljErIuvDDSg0iNgkkwZf4mU/gVGGvQ6Yqxg3pxYVNj3jNKblgPXStdAICSdD
	 uggOgss7A+JT1GolfjP9lt8RfLtSg8+uV9olEAt35zUhgm0m1reNJnP255VQo37fTJ
	 Bpi9D89w4HwKM9nihrCeEkaQWSaz9ZjDFETRCvRM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Bystrin <dev.mbstr@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 264/374] riscv: stacktrace: fixed walk_stackframe()
Date: Thu,  6 Jun 2024 16:04:03 +0200
Message-ID: <20240606131700.742002542@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Bystrin <dev.mbstr@gmail.com>

[ Upstream commit a2a4d4a6a0bf5eba66f8b0b32502cc20d82715a0 ]

If the load access fault occures in a leaf function (with
CONFIG_FRAME_POINTER=y), when wrong stack trace will be displayed:

[<ffffffff804853c2>] regmap_mmio_read32le+0xe/0x1c
---[ end trace 0000000000000000 ]---

Registers dump:
    ra     0xffffffff80485758 <regmap_mmio_read+36>
    sp     0xffffffc80200b9a0
    fp     0xffffffc80200b9b0
    pc     0xffffffff804853ba <regmap_mmio_read32le+6>

Stack dump:
    0xffffffc80200b9a0:  0xffffffc80200b9e0  0xffffffc80200b9e0
    0xffffffc80200b9b0:  0xffffffff8116d7e8  0x0000000000000100
    0xffffffc80200b9c0:  0xffffffd8055b9400  0xffffffd8055b9400
    0xffffffc80200b9d0:  0xffffffc80200b9f0  0xffffffff8047c526
    0xffffffc80200b9e0:  0xffffffc80200ba30  0xffffffff8047fe9a

The assembler dump of the function preambula:
    add     sp,sp,-16
    sd      s0,8(sp)
    add     s0,sp,16

In the fist stack frame, where ra is not stored on the stack we can
observe:

        0(sp)                  8(sp)
        .---------------------------------------------.
    sp->|       frame->fp      | frame->ra (saved fp) |
        |---------------------------------------------|
    fp->|         ....         |         ....         |
        |---------------------------------------------|
        |                      |                      |

and in the code check is performed:
	if (regs && (regs->epc == pc) && (frame->fp & 0x7))

I see no reason to check frame->fp value at all, because it is can be
uninitialized value on the stack. A better way is to check frame->ra to
be an address on the stack. After the stacktrace shows as expect:

[<ffffffff804853c2>] regmap_mmio_read32le+0xe/0x1c
[<ffffffff80485758>] regmap_mmio_read+0x24/0x52
[<ffffffff8047c526>] _regmap_bus_reg_read+0x1a/0x22
[<ffffffff8047fe9a>] _regmap_read+0x5c/0xea
[<ffffffff80480376>] _regmap_update_bits+0x76/0xc0
...
---[ end trace 0000000000000000 ]---
As pointed by Samuel Holland it is incorrect to remove check of the stackframe
entirely.

Changes since v2 [2]:
 - Add accidentally forgotten curly brace

Changes since v1 [1]:
 - Instead of just dropping frame->fp check, replace it with validation of
   frame->ra, which should be a stack address.
 - Move frame pointer validation into the separate function.

[1] https://lore.kernel.org/linux-riscv/20240426072701.6463-1-dev.mbstr@gmail.com/
[2] https://lore.kernel.org/linux-riscv/20240521131314.48895-1-dev.mbstr@gmail.com/

Fixes: f766f77a74f5 ("riscv/stacktrace: Fix stack output without ra on the stack top")
Signed-off-by: Matthew Bystrin <dev.mbstr@gmail.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Link: https://lore.kernel.org/r/20240521191727.62012-1-dev.mbstr@gmail.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/stacktrace.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 64a9c093aef93..528ec7cc9a622 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -18,6 +18,16 @@
 
 extern asmlinkage void ret_from_exception(void);
 
+static inline int fp_is_valid(unsigned long fp, unsigned long sp)
+{
+	unsigned long low, high;
+
+	low = sp + sizeof(struct stackframe);
+	high = ALIGN(sp, THREAD_SIZE);
+
+	return !(fp < low || fp > high || fp & 0x07);
+}
+
 void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			     bool (*fn)(void *, unsigned long), void *arg)
 {
@@ -41,21 +51,19 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 	}
 
 	for (;;) {
-		unsigned long low, high;
 		struct stackframe *frame;
 
 		if (unlikely(!__kernel_text_address(pc) || (level++ >= 0 && !fn(arg, pc))))
 			break;
 
-		/* Validate frame pointer */
-		low = sp + sizeof(struct stackframe);
-		high = ALIGN(sp, THREAD_SIZE);
-		if (unlikely(fp < low || fp > high || fp & 0x7))
+		if (unlikely(!fp_is_valid(fp, sp)))
 			break;
+
 		/* Unwind stack frame */
 		frame = (struct stackframe *)fp - 1;
 		sp = fp;
-		if (regs && (regs->epc == pc) && (frame->fp & 0x7)) {
+		if (regs && (regs->epc == pc) && fp_is_valid(frame->ra, sp)) {
+			/* We hit function where ra is not saved on the stack */
 			fp = frame->ra;
 			pc = regs->ra;
 		} else {
-- 
2.43.0




