Return-Path: <stable+bounces-51470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60CC907015
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0231C20C97
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF458145B04;
	Thu, 13 Jun 2024 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="knSi6C91"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4B145A05;
	Thu, 13 Jun 2024 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281392; cv=none; b=TOHPOWVgJ7OJfaA/qy/0BeR+yEa2nEn8K435esk1Avi9ZNeXXqyzkpZJkX1CdQjzJSblegK73PzFGASbK67ssBwIx1Gaehe2dsgdJV2AiTuT/qTut7PK42wrX9jypYz2ckIH9b9RPIwzUC6mz2/trhOovuYe+nP8JFuNriETtIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281392; c=relaxed/simple;
	bh=TWD+YP8cK9P0+lb6VuQR20XmtZxiLvis3OIqlB4LOPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILn8mhrkPUcJpVoVcnlj0WWgmpytqt1sX8FVJ7FxKVEqRBDnWicdugz38ZP7foOfbeSYqc18lINQbINt6Cgtt+38mKpaCtMFnlkcICqT5gqOx5eyvzSk6flPo4jIVfLRzAFiWUoGTcmx0ecWILlzIBqPmb8Ii9pMhgVYMV6kIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=knSi6C91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384D4C2BBFC;
	Thu, 13 Jun 2024 12:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281392;
	bh=TWD+YP8cK9P0+lb6VuQR20XmtZxiLvis3OIqlB4LOPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=knSi6C91eXMGnn4AGm+2FHy77VgdsZU45iAxOdJJA9TArK8Kh2jtx3fP/RJEqdUon
	 jNp0UdMKn0R4zMfBRkSOXONjpJ3U6/zF3G5OnNK4Nawea6/wSHy3yjAtfbDeXDAWfF
	 7HdSXlUq/v4XkZMoTH4TdpnQxSs9UXadIj2I6LKI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Bystrin <dev.mbstr@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 240/317] riscv: stacktrace: fixed walk_stackframe()
Date: Thu, 13 Jun 2024 13:34:18 +0200
Message-ID: <20240613113256.833234363@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index ff877ee3fb942..c38b20caad7cc 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -20,6 +20,16 @@ register unsigned long sp_in_global __asm__("sp");
 
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
 			     bool (*fn)(unsigned long, void *), void *arg)
 {
@@ -42,21 +52,19 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 	}
 
 	for (;;) {
-		unsigned long low, high;
 		struct stackframe *frame;
 
 		if (unlikely(!__kernel_text_address(pc) || fn(pc, arg)))
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




