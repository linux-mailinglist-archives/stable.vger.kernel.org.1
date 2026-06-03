Return-Path: <stable+bounces-260049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5+k6CKIMIGpGvAAAu9opvQ
	(envelope-from <stable+bounces-260049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:14:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C1F636EAC
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:14:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=Fm5XspJc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260049-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260049-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07D6230BF3CD
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BD9402427;
	Wed,  3 Jun 2026 11:07:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E35E450902
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:07:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484841; cv=none; b=PWAho3l+srk2LyU2IjWua2sT2wrTSLQVqhYtlQzzDoTtLPBjtDzxZK5jRGpgoGalCXDzvG3WbEnQtOoUD6rDgIy1IirEwnpDowaHFeY2IqfNa39fwlVCWBoJgUR39xcIrKI5Qn7zaeptvEGgjoYYKfxD6RSYgqlVd3hTKuflpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484841; c=relaxed/simple;
	bh=wI68yc1Q70swWj48fpOlxiWQla8Pc9mTBYmKEg16hCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/pEL+piMSKPqqVqaQL9grS+ZdriUjO0s0RY8pO6FX2YyoiGVXnkiTlDFBYLnx9yxLOCmQnFNsuiqwF3t31q6WiQJESySa+96F2auu+REGLeMCCUID483zXpwOdVG1UoT4fEs+vv6o8XgmS7LvdqFZCw+jKLUKctIOmltY1BHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Fm5XspJc; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E048F49FF;
	Wed,  3 Jun 2026 04:07:14 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 12CB83F86F;
	Wed,  3 Jun 2026 04:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484839; bh=wI68yc1Q70swWj48fpOlxiWQla8Pc9mTBYmKEg16hCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fm5XspJcAg9jNpNOKpX/Yi5eLhe8jj7DFZDj2knp0P/j69LyDGRGd1a2EuwHLYyM1
	 +nUugCuFMe3cRFM+vlK8W85nzogz1rHHeqj8q8XwjwleWr1CEldZPSsNoD9XnmxL+O
	 1smAOmJaIwiZABh2ZNFpl1dvVSSWmaP9UEMTSaFs=
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	stable@vger.kernel.org,
	tabba@google.com,
	vladimir.murzin@arm.com,
	will@kernel.org
Subject: [PATCH v4 18/20] arm64: fpsimd: Move sve_flush_live() inline
Date: Wed,  3 Jun 2026 12:06:28 +0100
Message-Id: <20260603110630.1027435-19-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260603110630.1027435-1-mark.rutland@arm.com>
References: <20260603110630.1027435-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-260049-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:broonie@kernel.org,m:catalin.marinas@arm.com,m:james.morse@arm.com,m:mark.rutland@arm.com,m:maz@kernel.org,m:oupton@kernel.org,m:stable@vger.kernel.org,m:tabba@google.com,m:vladimir.murzin@arm.com,m:will@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arm.com:mid,arm.com:dkim,arm.com:from_mime,arm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3C1F636EAC

Currently sve_flush_live() is written in out-of-line assembly. It would
be nice if we could move it inline such that control flow can be written
more clearly in C, and to permit the removal of otherwise unused
assembly macros.

The 'flush_ffr' argument is redundant as sve_flush_live() is always
called from non-streaming mode, and all callers pass 'true'. Remove the
argument and make it a requirement that the function is called from
non-streaming mode.

The 'vq_minus_1' argument is unnecessary, as sve_flush_live() can read
the live VL directly using the RDVL instruction (wrapped by the
sve_get_vl() helper function).

Move the function to C, with the simplifications above.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h       | 25 +++++++++++++++++++++-
 arch/arm64/include/asm/fpsimdmacros.h | 30 ---------------------------
 arch/arm64/kernel/entry-common.c      |  8 ++-----
 arch/arm64/kernel/entry-fpsimd.S      | 22 --------------------
 arch/arm64/kernel/fpsimd.c            |  2 +-
 5 files changed, 27 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 8f1b844f000fa..9dfe53204ebfb 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -332,7 +332,30 @@ static inline void sve_load_state(const struct arm64_sve_state *state, bool ffr)
 	__sve_load_p(state, vl, ffr);
 }
 
-extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
+/*
+ * Zero all SVE registers except for the first 128 bits of each vector.
+ *
+ * The caller must ensure that the VL has been configured and the CPU must be
+ * in non-streaming mode.
+ */
+static inline void sve_flush_live(void)
+{
+	unsigned long vl = sve_get_vl();
+
+	if (vl > sizeof(__uint128_t)) {
+		asm volatile(
+		__FPSIMD_PREAMBLE
+		FOR_EACH_Z_REG("n", "mov	v\\n\\().16b, v\\n\\().16b")
+		);
+	}
+
+	asm volatile(
+	__SVE_PREAMBLE
+	FOR_EACH_P_REG("n", "pfalse	p\\n\\().b")
+	"	wrffr	p0.b\n"
+	);
+}
+
 extern void sme_save_state(struct arm64_sme_state *state, int zt);
 extern void sme_load_state(const struct arm64_sme_state *state, int zt);
 
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 5f03fe51d0bff..9e352b5c6b764 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -40,20 +40,6 @@
 	.endif
 .endm
 
-/* Deprecated macros for SVE instructions */
-
-/* WRFFR P\np.B */
-.macro _sve_wrffr np
-	.arch_extension sve
-	wrffr p\np\().b
-.endm
-
-/* PFALSE P\np.B */
-.macro _sve_pfalse np
-	.arch_extension sve
-	pfalse	p\np\().b
-.endm
-
 /* Deprecated macros for SME instructions */
 
 /* RDSVL X\nx, #\imm */
@@ -131,22 +117,6 @@
 	.purgem _for__body
 .endm
 
-/* Preserve the first 128-bits of Znz and zero the rest. */
-.macro _sve_flush_z nz
-	_sve_check_zreg \nz
-	mov	v\nz\().16b, v\nz\().16b
-.endm
-
-.macro sve_flush_z
- _for n, 0, 31, _sve_flush_z	\n
-.endm
-.macro sve_flush_p
- _for n, 0, 15, _sve_pfalse	\n
-.endm
-.macro sve_flush_ffr
-		_sve_wrffr	0
-.endm
-
 .macro sme_save_za nxbase, xvl, nw
 	mov	w\nw, #0
 
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index cb54335465f66..2352297330e12 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -237,12 +237,8 @@ static inline void fpsimd_syscall_enter(void)
 	if (!system_supports_sve())
 		return;
 
-	if (test_thread_flag(TIF_SVE)) {
-		unsigned int sve_vq_minus_one;
-
-		sve_vq_minus_one = sve_vq_from_vl(task_get_sve_vl(current)) - 1;
-		sve_flush_live(true, sve_vq_minus_one);
-	}
+	if (test_thread_flag(TIF_SVE))
+		sve_flush_live();
 
 	/*
 	 * Any live non-FPSIMD SVE state has been zeroed. Allow
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index f957536356255..2a4755113b99a 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -11,28 +11,6 @@
 #include <asm/assembler.h>
 #include <asm/fpsimdmacros.h>
 
-#ifdef CONFIG_ARM64_SVE
-
-/*
- * Zero all SVE registers but the first 128-bits of each vector
- *
- * VQ must already be configured by caller, any further updates of VQ
- * will need to ensure that the register state remains valid.
- *
- * x0 = include FFR?
- * x1 = VQ - 1
- */
-SYM_FUNC_START(sve_flush_live)
-	cbz		x1, 1f	// A VQ-1 of 0 is 128 bits so no extra Z state
-	sve_flush_z
-1:	sve_flush_p
-	tbz		x0, #0, 2f
-	sve_flush_ffr
-2:	ret
-SYM_FUNC_END(sve_flush_live)
-
-#endif /* CONFIG_ARM64_SVE */
-
 #ifdef CONFIG_ARM64_SME
 
 /*
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index b9506422d29c6..25dc5afe9ba0c 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1338,7 +1338,7 @@ void do_sve_acc(unsigned long esr, struct pt_regs *regs)
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		unsigned long vq = sve_vq_from_vl(task_get_sve_vl(current));
 		sysreg_clear_set_s(SYS_ZCR_EL1, ZCR_ELx_LEN, vq - 1);
-		sve_flush_live(true, vq - 1);
+		sve_flush_live();
 		fpsimd_bind_task_to_cpu();
 	} else {
 		fpsimd_to_sve(current);
-- 
2.30.2


