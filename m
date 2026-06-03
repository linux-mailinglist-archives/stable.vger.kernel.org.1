Return-Path: <stable+bounces-260041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JNIsEkYNIGp3vAAAu9opvQ
	(envelope-from <stable+bounces-260041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:17:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6740636F2D
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:17:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=Twj3dJDJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260041-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260041-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1CEB335E913
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520833B2D0B;
	Wed,  3 Jun 2026 11:07:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959DA335BA8
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:07:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484825; cv=none; b=KSXKGg5ID+vwzvofeY8Mb28rj5DnTgBiKixlmlpCsoRZdb7E7wrtCVE0UXS1sxAs/63RzRkomHWFfpHk0CiCpcEYMdY+Sx9O/mfBAJ22xDeL4pXuTpQjJVHwUjKXjpEA6B4YlQS3tL13bn8UYDJtA4QSUgBWeWdOOM8f3H06zkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484825; c=relaxed/simple;
	bh=1eQhgk72nu4iO7OJFT9TavJ4ZsTC0pyfvUy/bYwcXkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qcwIjlIagcKWyA//ClhkJD5XIA4WrsPZ15cEEv+Em3WJIgQaSxfnNw3Wuxas6bJxOtoIbYkennHTNXWOQtfx7Pg3IeAnStYY+HyhlTuA+nZpEvlhEkePZr6vZeqaFLwz/krQAyM087j4T9InRO4PLIYfimYaJd5KC9tUSWMdjSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Twj3dJDJ; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4396749FF;
	Wed,  3 Jun 2026 04:06:58 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6BBB93F86F;
	Wed,  3 Jun 2026 04:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484823; bh=1eQhgk72nu4iO7OJFT9TavJ4ZsTC0pyfvUy/bYwcXkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Twj3dJDJe/y8J5qBgH+0VOC30PNsTizjTwQ777dzjw0n++8GzDSTi3eVY6Am6n+sb
	 DWw3/GodMxNFMOBFnAKj2RFWqVcitQb54Wj347QpAmfRsrNCte4kAY0MoP7Q0to1xT
	 c2SV+fxf45EmdyPI8+ETuFenYBANOiEviO4nveQw=
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
Subject: [PATCH v4 10/20] arm64: fpsimd: Use assembler for baseline SME instructions
Date: Wed,  3 Jun 2026 12:06:20 +0100
Message-Id: <20260603110630.1027435-11-mark.rutland@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-260041-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:mid,arm.com:dkim,arm.com:from_mime,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6740636F2D

We currently support assemblers which do not support SME instructions,
and have macros to manually encode SME instructions. This was
necessary historically as SME support was developed before assembler
support was widely available, but things have changed:

* All currently supported versions of LLVM support baseline SME
  instructions. Building the kernel requires LLVM 15+, while LLVM 13+
  supports SME.

* GNU binutils has supported baseline SME instructions since 2.38, which
  was released on 09 February 2022. Toolchains using this or later are
  widely available. For example Debian 12 (released on 10 June 2023)
  provides binutils 2.40. Toolchains provided kernel.org provide
  binutils 2.38+ since the GCC 12.1.0 release (released between 06 May
  2022 and 17 August 2022).

* For various reasons, SME support was marked as BROKEN, and re-enabled
  in v6.16 (released on 27 July 2025). The earliest support LTS kernel
  with SME support is v6.18.y, v6.18 was tagged on 30 November 2025, and
  contemporary toolchains (GCC 15.2 and binutils 2.45) supported
  baseline SME instructions.

* Any distribution which intends to support SME will presumably have a
  toolchain that supports baseline SME instructions such that userspace
  can be built.

Considering the above, there's no practical benefit to allowing SME to
be built when the toolchain doesn't support baseline SME instructions.

Make CONFIG_ARM64_SME depend on assembler support for SME, and remove
the manual encoding of SME instructions. The various _sme_<insn> macros
are kept for now, and will be cleaned up in subsequent patches.

A couple of SME2 instructions require a more recent toolchain, and are
left as-is for now. I've looked through releases of binutils and LLVM to
find when support was added, and noted this in a comment.

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
 arch/arm64/Kconfig                    |  5 ++++
 arch/arm64/include/asm/fpsimdmacros.h | 38 +++++++++++----------------
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fe60738e5943b..378e50fef247a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2247,10 +2247,15 @@ config ARM64_SVE
 	  booting the kernel.  If unsure and you are not observing these
 	  symptoms, you should assume that it is safe to say Y.
 
+config AS_HAS_SME
+	# Supported by LLVM 13+ and binutils 2.38+
+	def_bool $(as-instr,.arch_extension sme)
+
 config ARM64_SME
 	bool "ARM Scalable Matrix Extension support"
 	default y
 	depends on ARM64_SVE
+	depends on AS_HAS_SME
 	help
 	  The Scalable Matrix Extension (SME) is an extension to the AArch64
 	  execution state which utilises a substantial subset of the SVE
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 4ba23e493cb69..4a9bf46e52913 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -149,46 +149,38 @@
 	pfalse	p\np\().b
 .endm
 
-/* SME instruction encodings for non-SME-capable assemblers */
-/* (pre binutils 2.38/LLVM 13) */
+/* Deprecated macros for SME instructions */
 
 /* RDSVL X\nx, #\imm */
 .macro _sme_rdsvl nx, imm
-	_check_general_reg \nx
-	_check_num (\imm), -0x20, 0x1f
-	.inst	0x04bf5800			\
-		| (\nx)				\
-		| (((\imm) & 0x3f) << 5)
+	.arch_extension sme
+	rdsvl x\nx, #\imm
 .endm
 
 /*
  * STR (vector from ZA array):
- *	STR ZA[\nw, #\offset], [X\nxbase, #\offset, MUL VL]
+ *	STR ZA[W\nw, #\offset], [X\nxbase, #\offset, MUL VL]
  */
 .macro _sme_str_zav nw, nxbase, offset=0
-	_sme_check_wv \nw
-	_check_general_reg \nxbase
-	_check_num (\offset), -0x100, 0xff
-	.inst	0xe1200000			\
-		| (((\nw) & 3) << 13)		\
-		| ((\nxbase) << 5)		\
-		| ((\offset) & 7)
+	.arch_extension sme
+	str	za[w\nw, #\offset], [x\nxbase, #\offset, MUL VL]
 .endm
 
 /*
  * LDR (vector to ZA array):
- *	LDR ZA[\nw, #\offset], [X\nxbase, #\offset, MUL VL]
+ *	LDR ZA[w\nw, #\offset], [X\nxbase, #\offset, MUL VL]
  */
 .macro _sme_ldr_zav nw, nxbase, offset=0
-	_sme_check_wv \nw
-	_check_general_reg \nxbase
-	_check_num (\offset), -0x100, 0xff
-	.inst	0xe1000000			\
-		| (((\nw) & 3) << 13)		\
-		| ((\nxbase) << 5)		\
-		| ((\offset) & 7)
+	.arch_extension sme
+	ldr	za[w\nw, #\offset], [x\nxbase, #\offset, MUL VL]
 .endm
 
+/*
+ * SME2 instruction encodings for older assemblers.
+ * Supported by binutils 2.41+.
+ * Supported by LLVM 16+
+ */
+
 /*
  * LDR (ZT0)
  *
-- 
2.30.2


