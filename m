Return-Path: <stable+bounces-219762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Le2C1Lrn2nYewQAu9opvQ
	(envelope-from <stable+bounces-219762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 07:42:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A46B11A1629
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 07:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7780306A900
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 06:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4B938BF78;
	Thu, 26 Feb 2026 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aKFOud1x"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71545372B52
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088122; cv=none; b=BRk13xhtk0BftBs/8g/CqNW/P4jZn5z7/et69YqSwVbpHiqgnHg0ahou4JDwvmmXEo0VgQkhWjtB6zc0VsFwoQiB7f5qk3k30O5932iVPGSX5RtHEZVxnObjdhfBe7KiVig0/lpZuwaZNKdFsnM9GqhmUw4Bh3Bs5HyEjPICz4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088122; c=relaxed/simple;
	bh=yqrrVgtf2UohmRcSEm7+eGv3FuLyqOX/uyA8qbqUdIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K7VyM5b7xb2ZVcRTjpKWY571Gp965BAhs5jA/T7+K9f4KKNF/GDzzG0/Iou+4eK99HqL2u7A8j+pRgTIt7dhEdkyxcMjeW8Tf/saivSnzKlwutFmh3krlf85C2dByWQq6EfCBQTKbVsqbj/ENnfYA2r9Wn4sRo9PO0iy2FGxn2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aKFOud1x; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mL
	i3RUKlPXGya4i98UBELBZ6+DLLNF+kqmO8L4lqXI8=; b=aKFOud1xHpEKRe3sm7
	l+zrfwO8FTaiilcrkLqR7SWzyC9eIA8a8fcK+ErtusG/j6YO7n+orvRffKThPK1A
	/F9DzNQccDJAViLHAtxLyCxzJ9WHKxx3D5/CyzYBsSoaTL7vHscxEXEO1N9Xocfg
	izeUph+vEerNm1soCC/+VnaLg=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnyO4V659pYC5lQg--.54S2;
	Thu, 26 Feb 2026 14:41:28 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.6.y 1/2] x86/sev: Harden #VC instruction emulation somewhat
Date: Thu, 26 Feb 2026 14:41:11 +0800
Message-Id: <20260226064112.2737715-1-jetlan9@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnyO4V659pYC5lQg--.54S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFW7Jw15Xw1DurykWr1rJFb_yoWrKr47pr
	WUCF48trs5Wa4YyanakF4kAr15Zr10qFW7Gry3Ka1Yyan2q3W5JFy29r1avr1rCrWFg34f
	Kan8u3Wjka4vyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR20PcUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCxBlDDGmf6xldiAAA3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219762-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[alien8.de,amd.com,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A46B11A1629
X-Rspamd-Action: no action

From: "Borislav Petkov (AMD)" <bp@alien8.de>

[ Upstream commit e3ef461af35a8c74f2f4ce6616491ddb355a208f ]

Compare the opcode bytes at rIP for each #VC exit reason to verify the
instruction which raised the #VC exception is actually the right one.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240105101407.11694-1-bp@alien8.de
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 arch/x86/boot/compressed/sev.c |   4 ++
 arch/x86/kernel/sev-shared.c   | 102 ++++++++++++++++++++++++++++++++-
 arch/x86/kernel/sev.c          |   5 +-
 3 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 92c9f8b79f0d..b9f53e38f1e6 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -277,6 +277,10 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	if (result != ES_OK)
 		goto finish;
 
+	result = vc_check_opcode_bytes(&ctxt, exit_code);
+	if (result != ES_OK)
+		goto finish;
+
 	switch (exit_code) {
 	case SVM_EXIT_RDTSC:
 	case SVM_EXIT_RDTSCP:
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b90dfa46ec5b..1dbf114b3365 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -10,11 +10,15 @@
  */
 
 #ifndef __BOOT_COMPRESSED
-#define error(v)	pr_err(v)
-#define has_cpuflag(f)	boot_cpu_has(f)
+#define error(v)			pr_err(v)
+#define has_cpuflag(f)			boot_cpu_has(f)
+#define sev_printk(fmt, ...)		printk(fmt, ##__VA_ARGS__)
+#define sev_printk_rtl(fmt, ...)	printk_ratelimited(fmt, ##__VA_ARGS__)
 #else
 #undef WARN
 #define WARN(condition, format...) (!!(condition))
+#define sev_printk(fmt, ...)
+#define sev_printk_rtl(fmt, ...)
 #endif
 
 /* I/O parameters for CPUID-related helpers */
@@ -570,6 +574,7 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
+	u16 opcode = *(unsigned short *)regs->ip;
 	struct cpuid_leaf leaf;
 	int ret;
 
@@ -577,6 +582,10 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	if (exit_code != SVM_EXIT_CPUID)
 		goto fail;
 
+	/* Is it really a CPUID insn? */
+	if (opcode != 0xa20f)
+		goto fail;
+
 	leaf.fn = fn;
 	leaf.subfn = subfn;
 
@@ -1203,3 +1212,92 @@ static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
 out:
 	return ret;
 }
+
+static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
+					    unsigned long exit_code)
+{
+	unsigned int opcode = (unsigned int)ctxt->insn.opcode.value;
+	u8 modrm = ctxt->insn.modrm.value;
+
+	switch (exit_code) {
+
+	case SVM_EXIT_IOIO:
+	case SVM_EXIT_NPF:
+		/* handled separately */
+		return ES_OK;
+
+	case SVM_EXIT_CPUID:
+		if (opcode == 0xa20f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_INVD:
+		if (opcode == 0x080f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_MONITOR:
+		if (opcode == 0x010f && modrm == 0xc8)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_MWAIT:
+		if (opcode == 0x010f && modrm == 0xc9)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_MSR:
+		/* RDMSR */
+		if (opcode == 0x320f ||
+		/* WRMSR */
+		    opcode == 0x300f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDPMC:
+		if (opcode == 0x330f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDTSC:
+		if (opcode == 0x310f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDTSCP:
+		if (opcode == 0x010f && modrm == 0xf9)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_READ_DR7:
+		if (opcode == 0x210f &&
+		    X86_MODRM_REG(ctxt->insn.modrm.value) == 7)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_VMMCALL:
+		if (opcode == 0x010f && modrm == 0xd9)
+			return ES_OK;
+
+		break;
+
+	case SVM_EXIT_WRITE_DR7:
+		if (opcode == 0x230f &&
+		    X86_MODRM_REG(ctxt->insn.modrm.value) == 7)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_WBINVD:
+		if (opcode == 0x90f)
+			return ES_OK;
+		break;
+
+	default:
+		break;
+	}
+
+	sev_printk(KERN_ERR "Wrong/unhandled opcode bytes: 0x%x, exit_code: 0x%lx, rIP: 0x%lx\n",
+		   opcode, exit_code, ctxt->regs->ip);
+
+	return ES_UNSUPPORTED;
+}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c6a9a9d3ff2f..ad2b3ea24dd4 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1749,7 +1749,10 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 					 struct ghcb *ghcb,
 					 unsigned long exit_code)
 {
-	enum es_result result;
+	enum es_result result = vc_check_opcode_bytes(ctxt, exit_code);
+
+	if (result != ES_OK)
+		return result;
 
 	switch (exit_code) {
 	case SVM_EXIT_READ_DR7:
-- 
2.43.0


