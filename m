Return-Path: <stable+bounces-220046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EclO+KKommK3wQAu9opvQ
	(envelope-from <stable+bounces-220046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 07:27:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF521C0913
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 07:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F3E30474CD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 06:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3F1278779;
	Sat, 28 Feb 2026 06:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="IOQ5kHR6"
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821D280CC1
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772260062; cv=none; b=ayqTcpvVGKrgyVOgDaEHrkoWTt4S8ykNh2UuwUq7J/sfM8la/z4gTv0lWk3JU9fy+Sg+wEZvuMZ+NRK7+O8+then/zPjALUwu5i6A+VatR0YuUdKpwMT9j3+7BvcjI1bRZxglHX6hNTYEOphNgh6kmuB3yXTMxDlz0N9+4MqcT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772260062; c=relaxed/simple;
	bh=QQn8bSnAaYb313ul0m8v7naQC43ngHl7grA5hgovHnI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=p8wya9erJInALjwN/KBuH5Wde4PY69ZyaHW7ofosgqdT0s+kqETzO5bL93LXVPALuXgLvQ++iTh51T3DrpixBQF5opXcYAWV5kDj102LIkP9oNvR8SAV0i/kx20CAKFBnpmmYqmDAfGT3TDwYtsqu/RsL/yDv/YhPSRwJGV3r9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=IOQ5kHR6; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=IOQ5kHR6lolzxwwo6+E8o3JiRNx9HsqU4+tat/SSEHf2yB6ha7cmir7x1x5+KOFkV5irpdcKQSTF+
	 Wzo5DtoQwy0jELlCiljMTYPdfsoUPRG4Z5Wg2g8nOZdz6T6t3E9PghAoqxY5h3ZPzPxCkbcgcvfn7N
	 kbcXc9npoPiJMYg8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-Mobile-Kernel-Team (unknown[223.104.3.195])
	by rmsmtp-lg-appmail-24-12027 (RichMail) with SMTP id 2efb69a28acd6f8-4c19e;
	Sat, 28 Feb 2026 14:27:29 +0800 (CST)
X-RM-TRANSID:2efb69a28acd6f8-4c19e
From: Leon Chen <leonchen.oss@139.com>
To: lukas.gerlach@cispa.de,
	pjw@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] riscv: Sanitize syscall table indexing under speculation
Date: Sat, 28 Feb 2026 14:27:27 +0800
Message-Id: <20260228062728.8017-1-leonchen.oss@139.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220046-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonchen.oss@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FF521C0913
X-Rspamd-Action: no action

From: Lukas Gerlach <lukas.gerlach@cispa.de>

[ Upstream commit 25fd7ee7bf58ac3ec7be3c9f82ceff153451946c ]

The syscall number is a user-controlled value used to index into the
syscall table. Use array_index_nospec() to clamp this value after the
bounds check to prevent speculative out-of-bounds access and subsequent
data leakage via cache side channels.

Signed-off-by: Lukas Gerlach <lukas.gerlach@cispa.de>
Link: https://patch.msgid.link/20251218191332.35849-3-lukas.gerlach@cispa.de
Signed-off-by: Paul Walmsley <pjw@kernel.org>
[ Added linux/nospec.h for array_index_nospec() to make sure compile without error ]
Signed-off-by: Leon Chen <leonchen.oss@139.com>
---
 arch/riscv/kernel/traps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 53c7de4878c2..314c4d7671ca 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/kexec.h>
 #include <linux/entry-common.h>
+#include <linux/nospec.h>
 
 #include <asm/asm-prototypes.h>
 #include <asm/bug.h>
@@ -317,8 +318,10 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 
 		syscall = syscall_enter_from_user_mode(regs, syscall);
 
-		if (syscall >= 0 && syscall < NR_syscalls)
+		if (syscall >= 0 && syscall < NR_syscalls) {
+			syscall = array_index_nospec(syscall, NR_syscalls);
 			syscall_handler(regs, syscall);
+		}
 
 		syscall_exit_to_user_mode(regs);
 	} else {
-- 
2.35.3



