Return-Path: <stable+bounces-83064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444369953E7
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039FD286F39
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D801DFE00;
	Tue,  8 Oct 2024 15:59:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87B41E0B70
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403150; cv=none; b=qf5OhGSWwozyoLqtdcXZ2Fa01Qyy6eEK4qJ1ipGeB7jJJlazwTfIMjGsuk/EP4bQqOPBZ2XKe+xGJu4e8q07eAsWQYwafZKcFiyH9KtxESBu6P5JjSAJAQ8PKysyrLy1Wl7esSgMYwB4CUwy5+4teAWQTqfORTQEBWP/+OCzPFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403150; c=relaxed/simple;
	bh=scHOXN+0VRms3u9nmPGZD98vMx1hFpKbYIL6EgVogz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QWgPnqJ0BJxMyhhv88EsuJ25PTmcSdwoO6GiAVunG9Y4oRQXXHk/t/A1RQvXyxAJfpojc8Apt5ZB8J7AUPATTg3YwG7LVP1Hj2ui07HtG+n0b0D1nJ8MpnAtFfLGjh7br9roYXGUFnMckrM3vuNkeWttNjNa+A5mFjEklhc/Jec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAEDA113E;
	Tue,  8 Oct 2024 08:59:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 607673F73F;
	Tue,  8 Oct 2024 08:59:07 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	catalin.marnias@arm.com,
	mark.rutland@arm.com,
	stable@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 6/6] arm64: probes: Remove probe_opcode_t
Date: Tue,  8 Oct 2024 16:58:51 +0100
Message-Id: <20241008155851.801546-7-mark.rutland@arm.com>
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

The probe_opcode_t typedef for u32 isn't necessary, and is a source of
confusion as it is easily confused with kprobe_opcode_t, which is a
typedef for __le32.

The typedef is only used within arch/arm64, and all of arm64's commn
insn code uses u32 for the endian-agnostic value of an instruction, so
it'd be clearer to use u32 consistently.

Remove probe_opcode_t and use u32 directly.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marnias@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/probes.h        | 1 -
 arch/arm64/kernel/probes/decode-insn.c | 4 ++--
 arch/arm64/kernel/probes/decode-insn.h | 2 +-
 arch/arm64/kernel/probes/uprobes.c     | 4 ++--
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
index 11e809733b7d9..d493688863094 100644
--- a/arch/arm64/include/asm/probes.h
+++ b/arch/arm64/include/asm/probes.h
@@ -9,7 +9,6 @@
 
 #include <asm/insn.h>
 
-typedef u32 probe_opcode_t;
 typedef void (probes_handler_t) (u32 opcode, long addr, struct pt_regs *);
 
 struct arch_probe_insn {
diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index 147d6ddf3a4c9..41b100bcb041d 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -73,7 +73,7 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
  *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
  */
 enum probe_insn __kprobes
-arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api)
+arm_probe_decode_insn(u32 insn, struct arch_probe_insn *api)
 {
 	/*
 	 * Instructions reading or modifying the PC won't work from the XOL
@@ -133,7 +133,7 @@ enum probe_insn __kprobes
 arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
 {
 	enum probe_insn decoded;
-	probe_opcode_t insn = le32_to_cpu(*addr);
+	u32 insn = le32_to_cpu(*addr);
 	kprobe_opcode_t *scan_end = NULL;
 	unsigned long size = 0, offset = 0;
 	struct arch_probe_insn *api = &asi->api;
diff --git a/arch/arm64/kernel/probes/decode-insn.h b/arch/arm64/kernel/probes/decode-insn.h
index 8b758c5a20622..0e4195de82061 100644
--- a/arch/arm64/kernel/probes/decode-insn.h
+++ b/arch/arm64/kernel/probes/decode-insn.h
@@ -28,6 +28,6 @@ enum probe_insn __kprobes
 arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi);
 #endif
 enum probe_insn __kprobes
-arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *asi);
+arm_probe_decode_insn(u32 insn, struct arch_probe_insn *asi);
 
 #endif /* _ARM_KERNEL_KPROBES_ARM64_H */
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index a2f137a595fc1..fa0b7941d204c 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -34,7 +34,7 @@ unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
 int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		unsigned long addr)
 {
-	probe_opcode_t insn;
+	u32 insn;
 
 	/* TODO: Currently we do not support AARCH32 instruction probing */
 	if (mm->context.flags & MMCF_AARCH32)
@@ -102,7 +102,7 @@ bool arch_uprobe_xol_was_trapped(struct task_struct *t)
 
 bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
-	probe_opcode_t insn;
+	u32 insn;
 	unsigned long addr;
 
 	if (!auprobe->simulate)
-- 
2.30.2


