Return-Path: <stable+bounces-241643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC47FQWx8GnVXQEAu9opvQ
	(envelope-from <stable+bounces-241643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:07:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0654485830
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA2FF303060A
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421743FBEDE;
	Tue, 28 Apr 2026 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="vOJ9GqWt"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16053F20E5
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378111; cv=none; b=TM37K5wCEfEY3UUB7mPt2DLg/uMBBj9dArxnidd2ogRBkumq4he6WLIeYgMrpOtYC/rrFc3s90mcbeN/4lvLcImbm3J4zbnSEgzlc99pReRRDodlpX2OZ9vmckNh3kK6Avl2g57vvxhwjJnjmkBZHCAytjPIFwekdXXpbVvHM6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378111; c=relaxed/simple;
	bh=++gW+Y6Kw+k7IgTv28UlaLjO33VL2VEW9rK25bsNVlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LR4GD57rlAAmXWNTwQzSHm8xfFmf9yU6HQi3R/MoejhX0FavljJpDNfajoBC7d3cXLfKvWwqy2aIaVHbHu5xx0MRzRvSgfAzHuJfjJ5V6bebV34cwSU79S5Gj+DjUlXM4OTCiiGmLbjRYZb9Z8BJgZIjnIouq32k+jlwoatD5K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=vOJ9GqWt; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c00c:0:640:e0de:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 5E00080737;
	Tue, 28 Apr 2026 15:06:17 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6bf:8080:116::1:0])
	by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA id B6YlCK1L0W20-ZCt4EsAt;
	Tue, 28 Apr 2026 15:06:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1777377976;
	bh=rRsHTNYf2hE1gqz2YleAA8UnBauc+AwU/CU3LkWvxn0=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=vOJ9GqWtd6ucdEgEbq+L26PuDeyGotKAcVxpNX6K8dPuKjI5DkaRusAGulam+QPua
	 Fiml/ddKVWHUaTUqqLGe6j6FJcm7YOSzLCghDzqBzEPRAdT94V69f+lGMS5LvrDqNl
	 Z0tJgZGFfkhjJggtFybccU940zInCTcLma+Aq2L8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: stable@vger.kernel.org
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 6.6.y 1/5] x86/bugs: Add SRSO_USER_KERNEL_NO support
Date: Tue, 28 Apr 2026 15:05:41 +0300
Message-Id: <20260428120545.1970058-2-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428120545.1970058-1-d-tatianin@yandex-team.ru>
References: <20260428120545.1970058-1-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0654485830
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241643-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_NEQ_ENVFROM(0.00)[d-tatianin@yandex-team.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[yandex-team.ru:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alien8.de:email,yandex-team.ru:email,yandex-team.ru:dkim,yandex-team.ru:mid]

[ Upstream commit 877818802c3e970f67ccb53012facc78bef5f97a ]

If the machine has:

  CPUID Fn8000_0021_EAX[30] (SRSO_USER_KERNEL_NO) -- If this bit is 1,
  it indicates the CPU is not subject to the SRSO vulnerability across
  user/kernel boundaries.

have it fall back to IBPB on VMEXIT only, in the case it is going to run
VMs:

  Speculative Return Stack Overflow: Mitigation: IBPB on VMEXIT only

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20241202120416.6054-2-bp@kernel.org
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/bugs.c         | 4 ++++
 arch/x86/kernel/cpu/common.c       | 1 +
 3 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index ae4ea1f9594f7..154adb401a260 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -458,6 +458,7 @@
 #define X86_FEATURE_SBPB		(20*32+27) /* "" Selective Branch Prediction Barrier */
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
+#define X86_FEATURE_SRSO_USER_KERNEL_NO	(20*32+30) /* CPU is not affected by SRSO across user/kernel boundaries */
 
 /*
  * Extended auxiliary flags: Linux defined - for features scattered in various
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ef1d3a5024ed4..5d6f18bf4ba7c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2794,6 +2794,9 @@ static void __init srso_select_mitigation(void)
 		break;
 
 	case SRSO_CMD_SAFE_RET:
+		if (boot_cpu_has(X86_FEATURE_SRSO_USER_KERNEL_NO))
+			goto ibpb_on_vmexit;
+
 		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
 			/*
 			 * Enable the return thunk for generated code
@@ -2847,6 +2850,7 @@ static void __init srso_select_mitigation(void)
 		}
 		break;
 
+ibpb_on_vmexit:
 	case SRSO_CMD_IBPB_ON_VMEXIT:
 		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
 			if (has_microcode) {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ef73ce697ec8a..9881d1791095b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1341,6 +1341,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO | VMSCAPE),
 	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO | VMSCAPE),
 	VULNBL_AMD(0x19, SRSO | TSA | VMSCAPE),
+	VULNBL_AMD(0x1a, SRSO),
 	{}
 };
 
-- 
2.34.1


