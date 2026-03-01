Return-Path: <stable+bounces-222186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uESgA7yeo2lzIgUAu9opvQ
	(envelope-from <stable+bounces-222186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:04:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E9D1CCD3B
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 006E9303E7A7
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDB62EE5FD;
	Sun,  1 Mar 2026 01:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqGk88VE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51A12FE042;
	Sun,  1 Mar 2026 01:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330113; cv=none; b=BlppqQf36r6J1aTESRnLBYxtbdfbtpYGkRLTSCZi0fWv7hm65luCrvrmyzh7mABitNyrq91VUtVi8MADVXMAIX0jUSM48U7ScUF5TbIDqu8XBMhed4axYiCLLqeVd2PhCfJkuZBmQlK7U17TOgnx9aIb2aRFozrHn11bBMqwXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330113; c=relaxed/simple;
	bh=UXrhaS0QHJ3C6jFRxdCza1FcWs9cZJIdCZ1oWfXkMno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i5Hftl33SDxyXp2DEBJkV58P8SLlXZf3H9dB5ewiHQxVpJHBeu31r6svqPLGhSNHUP/Ugtb3jRB0zOx/FS57kMQqy6ihUriMz3wA1KO9bHqfyweoA9WDNQfahNILQM6fEjucEny7bgNewtOgqRgxt40yi5b413nL80SBWCETlvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqGk88VE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3621BC19421;
	Sun,  1 Mar 2026 01:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330113;
	bh=UXrhaS0QHJ3C6jFRxdCza1FcWs9cZJIdCZ1oWfXkMno=;
	h=From:To:Cc:Subject:Date:From;
	b=JqGk88VEY5k3h01KpLqsbMsRbzZhkBr7xomzWFkvIwivI0SD/ULX5fJ0Y7C/1r1ps
	 6UPHOQ/dWzh++paXrsTNX14CwbTHYQ5GfRwwNA0pCG1VknAyrhVoKHpedWHAxKh2D2
	 iHNxWArjGo/rosRnhWeI/Bfr+XqyR34QiVRyeikCyTkoT2tRSGYl+/hoEnJ1RB5BSs
	 rVBwWeIy6HeVCiKlFI9W/8Xn/xZYTZhJVR5kTPXNGpdB/m97gJusMUz4ox8GtMBSg1
	 EXkfrNihC9kknZqwV4eD321FNtdopto268/RwYAsBTsKZu2qf7cabe1OTWs15RGjnq
	 zeWAiG1a+HhoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev
Subject: FAILED: Patch "LoongArch: Remove some extern variables in source files" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:55:11 -0500
Message-ID: <20260301015512.1722356-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222186-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23E9D1CCD3B
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0e6f596d6ac635e80bb265d587b2287ef8fa1cd6 Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Tue, 10 Feb 2026 19:31:14 +0800
Subject: [PATCH] LoongArch: Remove some extern variables in source files

There are declarations of the variable "eentry", "pcpu_handlers[]" and
"exception_handlers[]" in asm/setup.h, the source files already include
this header file directly or indirectly, so no need to declare them in
the source files, just remove the code.

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/unwind_orc.c      | 2 --
 arch/loongarch/kernel/unwind_prologue.c | 4 ----
 arch/loongarch/mm/tlb.c                 | 1 -
 3 files changed, 7 deletions(-)

diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/unwind_orc.c
index 11ba3e4ac9eee..9cfb5bb1991f2 100644
--- a/arch/loongarch/kernel/unwind_orc.c
+++ b/arch/loongarch/kernel/unwind_orc.c
@@ -350,8 +350,6 @@ EXPORT_SYMBOL_GPL(unwind_start);
 
 static inline unsigned long bt_address(unsigned long ra)
 {
-	extern unsigned long eentry;
-
 #if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
 	int cpu;
 	int vec_sz = sizeof(exception_handlers);
diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
index ee1c29686ab05..da07acad7973a 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -23,10 +23,6 @@ extern const int unwind_hint_lasx;
 extern const int unwind_hint_lbt;
 extern const int unwind_hint_ri;
 extern const int unwind_hint_watch;
-extern unsigned long eentry;
-#ifdef CONFIG_NUMA
-extern unsigned long pcpu_handlers[NR_CPUS];
-#endif
 
 static inline bool scan_handlers(unsigned long entry_offset)
 {
diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 6a3c91b9cacdc..4014c44695878 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -262,7 +262,6 @@ static void output_pgtable_bits_defines(void)
 #ifdef CONFIG_NUMA
 unsigned long pcpu_handlers[NR_CPUS];
 #endif
-extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
 
 static void setup_tlb_handler(int cpu)
 {
-- 
2.51.0





