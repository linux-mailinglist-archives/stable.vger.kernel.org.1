Return-Path: <stable+bounces-221273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKYOKS+Uo2khHQUAu9opvQ
	(envelope-from <stable+bounces-221273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:19:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 163BA1CA32E
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D03CF303C4C7
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1DE23D2B1;
	Sun,  1 Mar 2026 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RC55bwnN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E251E2606;
	Sun,  1 Mar 2026 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327859; cv=none; b=YQ0K60RMYik6cUiRgbzXoMW2OEZ0pIWbviWMUxe+2ZzgrYoXf9/7xuwTB+aVsYQrGPA93OJXEn7e5jPKx4zbLJP9G0qUfP2GPl0S2EBNSj4/rMFFNYLznWD2otshTwgnWHXiTbTUMyMaYgn/vYRbXZmqu80HeG4KRWhGvITRc/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327859; c=relaxed/simple;
	bh=3lCuEeMZQr9sTcf42NUHlFwNLm3OFoRZh4veUzfE5BM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Al62QOW+gQrDYjbvboY8yZZQ8cNoVh1DPa+2Xbyp/QuDw1HKFXNrH6pgQZixDtQlXY4yyEQ5/P++vHaRMK5fwJlbCspLbuLjcQYHKptjpC6QkB+0qZZDZaRFgkNanL+0W6iKhvuVYEKTkmckU7QH56bKcvGkWQQo70tFig7A7rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RC55bwnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BA4C19421;
	Sun,  1 Mar 2026 01:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327858;
	bh=3lCuEeMZQr9sTcf42NUHlFwNLm3OFoRZh4veUzfE5BM=;
	h=From:To:Cc:Subject:Date:From;
	b=RC55bwnNimQIe/58adrW4wN6q8GTnXOr0R2iVK5pPB5/TRNiVegw0gez8Dt6GOSgz
	 4KsLpdFrARDvtA4PHfIoiffF2H5srHXxZM/TmIOEuKyxI1pPjevBKiv5gIOxNhOEmE
	 HIHtdF8mUCb8BUFpR3UusLIXsr8ny+f6ZpS5oEJ8dPjKNH6a/VlhIbS6ZIixoy+btJ
	 nNzNMRwwQIXsQa3KgoKDVI67P1xtJl6U9OBxb3TSQqJ8Ts63psXTIKpeZYAkl/AVZF
	 cBg3fArN0E6RnBVbjmRV9dCrKHOH00H4PwS5W6Wpuwacm34vLkeEtDAYfbfNPYNjl8
	 R1jbOjg2x+sPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev
Subject: FAILED: Patch "LoongArch: Remove some extern variables in source files" failed to apply to 6.18-stable tree
Date: Sat, 28 Feb 2026 20:17:36 -0500
Message-ID: <20260301011737.1671596-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221273-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 163BA1CA32E
X-Rspamd-Action: no action

The patch below does not apply to the 6.18-stable tree.
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





