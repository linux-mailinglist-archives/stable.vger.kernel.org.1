Return-Path: <stable+bounces-83063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6169953E6
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6C21C24FA4
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80C61E0B64;
	Tue,  8 Oct 2024 15:59:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AD91DFE00
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403148; cv=none; b=XBq4pTKg1JRklwK206CXsmqd4DfyZ2KVVxQ6pBtmxwKYX5Zu45j/lT5ecZL0kxsmALHAxKatLrcItau364WqPO9f6PoXLPbtCMqwcie1LocOWYgEfMVP2bm9X+k769+vgFmhB6s6VwlS2qJDTxzO3o+ojUakhco+i4s52CKjxdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403148; c=relaxed/simple;
	bh=yZUsL6852ECWLZfHGNYHQDfus7Xlaz4NnoK2d+KLDLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rw3iv3sSmqNEYH6kGDhX7xnfSK8HYE583YSM4d12xwD+W1g7B53TPg5HPqUU/5WGltN/vg0wjL0P/3AXk7rUIz6ZnvIdEqrcIFeylg4a40qeFbDXgk/ocbI7PUZCJyYMxyTJQvxT3l2/TwvxHp/1ksu00eJPofpI3h1EpQkaS0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63638DA7;
	Tue,  8 Oct 2024 08:59:36 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD3EC3F73F;
	Tue,  8 Oct 2024 08:59:05 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	catalin.marnias@arm.com,
	mark.rutland@arm.com,
	stable@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 5/6] arm64: probes: Cleanup kprobes endianness conversions
Date: Tue,  8 Oct 2024 16:58:50 +0100
Message-Id: <20241008155851.801546-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241008155851.801546-1-mark.rutland@arm.com>
References: <20241008155851.801546-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core kprobes code uses kprobe_opcode_t for the in-memory
representation of an instruction, using 'kprobe_opcode_t *' for XOL
slots. As arm64 instructions are always little-endian 32-bit values,
kprobes_opcode_t should be __le32, but at the moment kprobe_opcode_t
is typedef'd to u32.

Today there is no functional issue as we convert values via
cpu_to_le32() and le32_to_cpu() where necessary, but these conversions
are inconsistent with the types used, causing sparse warnings:

|   CHECK   arch/arm64/kernel/probes/kprobes.c
| arch/arm64/kernel/probes/kprobes.c:102:21: warning: cast to restricted __le32
|   CHECK   arch/arm64/kernel/probes/decode-insn.c
| arch/arm64/kernel/probes/decode-insn.c:122:46: warning: cast to restricted __le32
| arch/arm64/kernel/probes/decode-insn.c:124:50: warning: cast to restricted __le32
| arch/arm64/kernel/probes/decode-insn.c:136:31: warning: cast to restricted __le32

Improve this by making kprobes_opcode_t a typedef for __le32 and
consistently using this for pointers to executable instructions. With
this change we can rely on the type system to tell us where conversions
are necessary.

Since kprobe::opcode is changed from u32 to __le32, the existing
le32_to_cpu() converion moves from the point this is initialized (in
arch_prepare_kprobe()) to the points this is consumed when passed to
a handler or text patching function. As kprobe::opcode isn't altered or
consumed elsewhere, this shouldn't result in a functional change.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/probes.h        | 4 ++--
 arch/arm64/kernel/probes/decode-insn.c | 2 +-
 arch/arm64/kernel/probes/kprobes.c     | 9 +++++----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
index 4aa54322794da..11e809733b7d9 100644
--- a/arch/arm64/include/asm/probes.h
+++ b/arch/arm64/include/asm/probes.h
@@ -16,10 +16,10 @@ struct arch_probe_insn {
 	probes_handler_t *handler;
 };
 #ifdef CONFIG_KPROBES
-typedef u32 kprobe_opcode_t;
+typedef __le32 kprobe_opcode_t;
 struct arch_specific_insn {
 	struct arch_probe_insn api;
-	probe_opcode_t *xol_insn;
+	kprobe_opcode_t *xol_insn;
 	/* restore address after step xol */
 	unsigned long xol_restore;
 };
diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index 3496d6169e59b..147d6ddf3a4c9 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -134,7 +134,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
 {
 	enum probe_insn decoded;
 	probe_opcode_t insn = le32_to_cpu(*addr);
-	probe_opcode_t *scan_end = NULL;
+	kprobe_opcode_t *scan_end = NULL;
 	unsigned long size = 0, offset = 0;
 	struct arch_probe_insn *api = &asi->api;
 
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 222419a41a400..48d88e07611d4 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -64,7 +64,7 @@ static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 	 * the BRK exception handler, so it is unnecessary to generate
 	 * Contex-Synchronization-Event via ISB again.
 	 */
-	aarch64_insn_patch_text_nosync(addr, p->opcode);
+	aarch64_insn_patch_text_nosync(addr, le32_to_cpu(p->opcode));
 	aarch64_insn_patch_text_nosync(addr + 1, BRK64_OPCODE_KPROBES_SS);
 
 	/*
@@ -85,7 +85,7 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
 	if (p->ainsn.api.handler)
-		p->ainsn.api.handler((u32)p->opcode, (long)p->addr, regs);
+		p->ainsn.api.handler(le32_to_cpu(p->opcode), (long)p->addr, regs);
 
 	/* single step simulated, now go for post processing */
 	post_kprobe_handler(p, kcb, regs);
@@ -99,7 +99,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 		return -EINVAL;
 
 	/* copy instruction */
-	p->opcode = le32_to_cpu(*p->addr);
+	p->opcode = *p->addr;
 
 	if (search_exception_tables(probe_addr))
 		return -EINVAL;
@@ -142,8 +142,9 @@ void __kprobes arch_arm_kprobe(struct kprobe *p)
 void __kprobes arch_disarm_kprobe(struct kprobe *p)
 {
 	void *addr = p->addr;
+	u32 insn = le32_to_cpu(p->opcode);
 
-	aarch64_insn_patch_text(&addr, &p->opcode, 1);
+	aarch64_insn_patch_text(&addr, &insn, 1);
 }
 
 void __kprobes arch_remove_kprobe(struct kprobe *p)
-- 
2.30.2


