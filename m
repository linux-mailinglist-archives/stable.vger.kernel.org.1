Return-Path: <stable+bounces-196768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C5DC81DCA
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 18:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87E5E348E43
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 17:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D6E3A1D2;
	Mon, 24 Nov 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpDgOrzQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663821D3D2
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004641; cv=none; b=UWfo2X6lBevoCjhW6QoL8GZEC9/mq5ZDanSH6LBxnvp8osf6iAsCPSz/ihA6zOWr6Bj6nYeOXgLrDaiUogzyT9PAWbfx2arDVVkgxxsJgyoIqIumpJf0qRUVSKMYKR2S3dEn2El4Dn07BuuwZDhP4iA00si6tT0qyqinAZT8qkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004641; c=relaxed/simple;
	bh=zcrIguOwt5QFDDBFtiDFFmxvnROnvX6zzGfyeAbHd9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KruNEbH0z09QQha6qLFgPCB9zol9SwCbqSWCF+7d2GanBji9rg48GtO0nHR76tZB81d0TwuW26/uSpwZJtAoHTpZpuzZf6JleK5ytErGytn4xKD1fiXOhhrD1Wr+yrPGckpjX0x3U3EYb9NciwEIH804RBnRisZC6Bj2ZUi8NYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpDgOrzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF9FC4CEF1;
	Mon, 24 Nov 2025 17:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764004641;
	bh=zcrIguOwt5QFDDBFtiDFFmxvnROnvX6zzGfyeAbHd9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GpDgOrzQ3GmZdqZc9RUUoDVsb7eW71u6gtbMoFno1d28t23RmwH4jWX06Xxh/GvN1
	 IQck28tb0PHfxPk7SRNiWbCARbXMsst+w7KRhkJac4q+urUrP1ofG+thsCAnjrxoqo
	 PKeNbQarbHxY9oFUmU16UKu4CnafmijJDvbEIZ1pHW4Tv/Ct2wTbbncGbJJAvhotNV
	 uVP1HvlRM0kLpOxzfAGW28N328IbvkbfLUiMqjx2+q4aji2a25FxrY0SzKeHpQXlA9
	 J+bFkmI17sKQGxbspxz0tKU1XkLe4rUJnYFc9gVpt7AUCouIGI2kZ8MCej0NClMN1T
	 IisEUr2GBZrXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] s390/cpufeature: Convert MACHINE_HAS_SEQ_INSN to cpu_has_seq_insn()
Date: Mon, 24 Nov 2025 12:17:17 -0500
Message-ID: <20251124171719.4158053-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112418-impish-remix-d936@gregkh>
References: <2025112418-impish-remix-d936@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 679b110bb662fc107f38ebd5088af56a156dd82f ]

Convert MACHINE_HAS_... to cpu_has_...() which uses test_facility() instead
of testing the machine_flags lowcore member if the feature is present.

test_facility() generates better code since it results in a static branch
without accessing memory. The branch is patched via alternatives by the
decompressor depending on the availability of the required facility.

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Stable-dep-of: 31475b88110c ("s390/mm: Fix __ptep_rdp() inline assembly")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/cpufeature.h |  4 ++++
 arch/s390/include/asm/setup.h      |  2 --
 arch/s390/kernel/early.c           |  2 --
 arch/s390/kernel/ftrace.c          | 11 ++++++-----
 arch/s390/kernel/kprobes.c         |  5 +++--
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/cpufeature.h b/arch/s390/include/asm/cpufeature.h
index 9312046137531..496d0758b902f 100644
--- a/arch/s390/include/asm/cpufeature.h
+++ b/arch/s390/include/asm/cpufeature.h
@@ -9,6 +9,8 @@
 #ifndef __ASM_S390_CPUFEATURE_H
 #define __ASM_S390_CPUFEATURE_H
 
+#include <asm/facility.h>
+
 enum {
 	S390_CPU_FEATURE_MSA,
 	S390_CPU_FEATURE_VXRS,
@@ -20,4 +22,6 @@ enum {
 
 int cpu_have_feature(unsigned int nr);
 
+#define cpu_has_seq_insn()	test_facility(85)
+
 #endif /* __ASM_S390_CPUFEATURE_H */
diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 70b920b32827e..50b943f301553 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -34,7 +34,6 @@
 #define MACHINE_FLAG_SCC	BIT(17)
 #define MACHINE_FLAG_PCI_MIO	BIT(18)
 #define MACHINE_FLAG_RDP	BIT(19)
-#define MACHINE_FLAG_SEQ_INSN	BIT(20)
 
 #define LPP_MAGIC		BIT(31)
 #define LPP_PID_MASK		_AC(0xffffffff, UL)
@@ -96,7 +95,6 @@ extern unsigned long mio_wb_bit_mask;
 #define MACHINE_HAS_SCC		(get_lowcore()->machine_flags & MACHINE_FLAG_SCC)
 #define MACHINE_HAS_PCI_MIO	(get_lowcore()->machine_flags & MACHINE_FLAG_PCI_MIO)
 #define MACHINE_HAS_RDP		(get_lowcore()->machine_flags & MACHINE_FLAG_RDP)
-#define MACHINE_HAS_SEQ_INSN	(get_lowcore()->machine_flags & MACHINE_FLAG_SEQ_INSN)
 
 /*
  * Console mode. Override with conmode=
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 0c054e2d1e03e..4d0112adbcaa6 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -269,8 +269,6 @@ static __init void detect_machine_facilities(void)
 	}
 	if (test_facility(194))
 		get_lowcore()->machine_flags |= MACHINE_FLAG_RDP;
-	if (test_facility(85))
-		get_lowcore()->machine_flags |= MACHINE_FLAG_SEQ_INSN;
 }
 
 static inline void save_vector_registers(void)
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 0b6e62d1d8b87..29dae4c4009bd 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/kmsan-checks.h>
+#include <linux/cpufeature.h>
 #include <linux/kprobes.h>
 #include <linux/execmem.h>
 #include <trace/syscall.h>
@@ -69,7 +70,7 @@ static const char *ftrace_shared_hotpatch_trampoline(const char **end)
 
 bool ftrace_need_init_nop(void)
 {
-	return !MACHINE_HAS_SEQ_INSN;
+	return !cpu_has_seq_insn();
 }
 
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
@@ -189,7 +190,7 @@ static int ftrace_modify_trampoline_call(struct dyn_ftrace *rec,
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
 {
-	if (MACHINE_HAS_SEQ_INSN)
+	if (cpu_has_seq_insn())
 		return ftrace_patch_branch_insn(rec->ip, old_addr, addr);
 	else
 		return ftrace_modify_trampoline_call(rec, old_addr, addr);
@@ -213,8 +214,8 @@ static int ftrace_patch_branch_mask(void *addr, u16 expected, bool enable)
 int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
 {
-	/* Expect brcl 0xf,... for the !MACHINE_HAS_SEQ_INSN case */
-	if (MACHINE_HAS_SEQ_INSN)
+	/* Expect brcl 0xf,... for the !cpu_has_seq_insn() case */
+	if (cpu_has_seq_insn())
 		return ftrace_patch_branch_insn(rec->ip, addr, 0);
 	else
 		return ftrace_patch_branch_mask((void *)rec->ip, 0xc0f4, false);
@@ -234,7 +235,7 @@ static int ftrace_make_trampoline_call(struct dyn_ftrace *rec, unsigned long add
 
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
-	if (MACHINE_HAS_SEQ_INSN)
+	if (cpu_has_seq_insn())
 		return ftrace_patch_branch_insn(rec->ip, 0, addr);
 	else
 		return ftrace_make_trampoline_call(rec, addr);
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 8b80ea57125f3..c450120b44749 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -13,6 +13,7 @@
 #include <linux/ptrace.h>
 #include <linux/preempt.h>
 #include <linux/stop_machine.h>
+#include <linux/cpufeature.h>
 #include <linux/kdebug.h>
 #include <linux/uaccess.h>
 #include <linux/extable.h>
@@ -153,7 +154,7 @@ void arch_arm_kprobe(struct kprobe *p)
 {
 	struct swap_insn_args args = {.p = p, .arm_kprobe = 1};
 
-	if (MACHINE_HAS_SEQ_INSN) {
+	if (cpu_has_seq_insn()) {
 		swap_instruction(&args);
 		text_poke_sync();
 	} else {
@@ -166,7 +167,7 @@ void arch_disarm_kprobe(struct kprobe *p)
 {
 	struct swap_insn_args args = {.p = p, .arm_kprobe = 0};
 
-	if (MACHINE_HAS_SEQ_INSN) {
+	if (cpu_has_seq_insn()) {
 		swap_instruction(&args);
 		text_poke_sync();
 	} else {
-- 
2.51.0


