Return-Path: <stable+bounces-88348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A566C9B2588
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C970A1C20A2A
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D4B18D629;
	Mon, 28 Oct 2024 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GZqFve6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21DF15B10D;
	Mon, 28 Oct 2024 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097129; cv=none; b=JxJ234xk3htZcFV2Y+Fc/+24cNX7+4GtmH+CxiMPtVCYl0trzj0oWGF2SFYjtTn4REZM5yYsSz72SwYLqAx8wzItpcfJMlEYR8Uwko/4Ui7Oc+/Y3kWdHTfQSgsEcsEr+Jq0BwU6NUFEg+mpURuYzoRcAOekX2lFd9QJ0J1WP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097129; c=relaxed/simple;
	bh=dfTYDuhMOBdNzIGQg47DKgxzlRM9HR3knvTizRznSlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOpz1/UqbkmdeFpBE+CfjmqMIM2Rjw9TnyL6CkrIuLUOeo3zMCsSffz1Fv4RKIV2gvVWcwDj4JhQvqOn4ovkio8jvnylPk77QnXvPfkKMQrRzC4uziHdqyShRLmaWmpfhi2BFyEPS4eh391+JNfML3QODZ76NOH2Y95cGZrXyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GZqFve6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC78C4CEC7;
	Mon, 28 Oct 2024 06:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097128;
	bh=dfTYDuhMOBdNzIGQg47DKgxzlRM9HR3knvTizRznSlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZqFve6YXo7IR72nuUWdoRNW7ebhcG2O7nD1+iBB3fPfgSN9qZHRtnreCc/8Royt8
	 zebKT4+sRJ/piIs1v+L156IN8mLpA0I2hs7rhmOVWpCKf9FQyvjtzN5I3iYrKD2xBt
	 3nqiy1GG3x3WQN/2nSxp2fDL/t7uMTid5pCxvXoQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 31/80] arm64: probes: Fix uprobes for big-endian kernels
Date: Mon, 28 Oct 2024 07:25:11 +0100
Message-ID: <20241028062253.492228912@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062252.611837461@linuxfoundation.org>
References: <20241028062252.611837461@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 13f8f1e05f1dc36dbba6cba0ae03354c0dafcde7 ]

The arm64 uprobes code is broken for big-endian kernels as it doesn't
convert the in-memory instruction encoding (which is always
little-endian) into the kernel's native endianness before analyzing and
simulating instructions. This may result in a few distinct problems:

* The kernel may may erroneously reject probing an instruction which can
  safely be probed.

* The kernel may erroneously erroneously permit stepping an
  instruction out-of-line when that instruction cannot be stepped
  out-of-line safely.

* The kernel may erroneously simulate instruction incorrectly dur to
  interpretting the byte-swapped encoding.

The endianness mismatch isn't caught by the compiler or sparse because:

* The arch_uprobe::{insn,ixol} fields are encoded as arrays of u8, so
  the compiler and sparse have no idea these contain a little-endian
  32-bit value. The core uprobes code populates these with a memcpy()
  which similarly does not handle endianness.

* While the uprobe_opcode_t type is an alias for __le32, both
  arch_uprobe_analyze_insn() and arch_uprobe_skip_sstep() cast from u8[]
  to the similarly-named probe_opcode_t, which is an alias for u32.
  Hence there is no endianness conversion warning.

Fix this by changing the arch_uprobe::{insn,ixol} fields to __le32 and
adding the appropriate __le32_to_cpu() conversions prior to consuming
the instruction encoding. The core uprobes copies these fields as opaque
ranges of bytes, and so is unaffected by this change.

At the same time, remove MAX_UINSN_BYTES and consistently use
AARCH64_INSN_SIZE for clarity.

Tested with the following:

| #include <stdio.h>
| #include <stdbool.h>
|
| #define noinline __attribute__((noinline))
|
| static noinline void *adrp_self(void)
| {
|         void *addr;
|
|         asm volatile(
|         "       adrp    %x0, adrp_self\n"
|         "       add     %x0, %x0, :lo12:adrp_self\n"
|         : "=r" (addr));
| }
|
|
| int main(int argc, char *argv)
| {
|         void *ptr = adrp_self();
|         bool equal = (ptr == adrp_self);
|
|         printf("adrp_self   => %p\n"
|                "adrp_self() => %p\n"
|                "%s\n",
|                adrp_self, ptr, equal ? "EQUAL" : "NOT EQUAL");
|
|         return 0;
| }

.... where the adrp_self() function was compiled to:

| 00000000004007e0 <adrp_self>:
|   4007e0:       90000000        adrp    x0, 400000 <__ehdr_start>
|   4007e4:       911f8000        add     x0, x0, #0x7e0
|   4007e8:       d65f03c0        ret

Before this patch, the ADRP is not recognized, and is assumed to be
steppable, resulting in corruption of the result:

| # ./adrp-self
| adrp_self   => 0x4007e0
| adrp_self() => 0x4007e0
| EQUAL
| # echo 'p /root/adrp-self:0x007e0' > /sys/kernel/tracing/uprobe_events
| # echo 1 > /sys/kernel/tracing/events/uprobes/enable
| # ./adrp-self
| adrp_self   => 0x4007e0
| adrp_self() => 0xffffffffff7e0
| NOT EQUAL

After this patch, the ADRP is correctly recognized and simulated:

| # ./adrp-self
| adrp_self   => 0x4007e0
| adrp_self() => 0x4007e0
| EQUAL
| #
| # echo 'p /root/adrp-self:0x007e0' > /sys/kernel/tracing/uprobe_events
| # echo 1 > /sys/kernel/tracing/events/uprobes/enable
| # ./adrp-self
| adrp_self   => 0x4007e0
| adrp_self() => 0x4007e0
| EQUAL

Fixes: 9842ceae9fa8 ("arm64: Add uprobe support")
Cc: stable@vger.kernel.org
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20241008155851.801546-4-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/uprobes.h   | 8 +++-----
 arch/arm64/kernel/probes/uprobes.c | 4 ++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/uprobes.h b/arch/arm64/include/asm/uprobes.h
index ba4bff5ca6749..98f29a43bfe89 100644
--- a/arch/arm64/include/asm/uprobes.h
+++ b/arch/arm64/include/asm/uprobes.h
@@ -10,11 +10,9 @@
 #include <asm/insn.h>
 #include <asm/probes.h>
 
-#define MAX_UINSN_BYTES		AARCH64_INSN_SIZE
-
 #define UPROBE_SWBP_INSN	cpu_to_le32(BRK64_OPCODE_UPROBES)
 #define UPROBE_SWBP_INSN_SIZE	AARCH64_INSN_SIZE
-#define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
+#define UPROBE_XOL_SLOT_BYTES	AARCH64_INSN_SIZE
 
 typedef u32 uprobe_opcode_t;
 
@@ -23,8 +21,8 @@ struct arch_uprobe_task {
 
 struct arch_uprobe {
 	union {
-		u8 insn[MAX_UINSN_BYTES];
-		u8 ixol[MAX_UINSN_BYTES];
+		__le32 insn;
+		__le32 ixol;
 	};
 	struct arch_probe_insn api;
 	bool simulate;
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index d49aef2657cdf..a2f137a595fc1 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -42,7 +42,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	else if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
 		return -EINVAL;
 
-	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
+	insn = le32_to_cpu(auprobe->insn);
 
 	switch (arm_probe_decode_insn(insn, &auprobe->api)) {
 	case INSN_REJECTED:
@@ -108,7 +108,7 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 	if (!auprobe->simulate)
 		return false;
 
-	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
+	insn = le32_to_cpu(auprobe->insn);
 	addr = instruction_pointer(regs);
 
 	if (auprobe->api.handler)
-- 
2.43.0




