Return-Path: <stable+bounces-255041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJAvJJVZGGq9jQgAu9opvQ
	(envelope-from <stable+bounces-255041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:04:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DB25F41E0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 850333016258
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2A2E7362;
	Thu, 28 May 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3YtGMx20";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TpBq6Whp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C2C2E7366
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980214; cv=none; b=bBcva36D7AUMUQyu0ZiOdTdZ4Q1tEHFGZYbV3Xx/xxCN9hpI1tWfzR0zElrQn/Nr8iYKePpOjkHG7Lv8P7fCTJRtg6vnTdnhrDV3EBzqT4BfMBT2rW3xmBnK2eAvr8nSQsXgeAcDiNDjoHAZRH2NSKQWQ/lVJVpGnBllcYIPQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980214; c=relaxed/simple;
	bh=MsOjb68/5e2C/KizlkCyYfI/dBnTfbbdY+6Nus8AM0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hq5GK9EqcfiBucW+HJG3Xm2uyWDyPQO3/846toLKP1AMindisDlgQv5XZAP4F4w3QtWhdSGf9O0c2Ixu7lTc+PtPVBf3RRbUDteVdTAM3zrHu4b/JT7HGHH9i5WecRfKOv3rzAHIhK47TUppLhRlPBddGkjOFTXJt6T4kM/LtwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3YtGMx20; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TpBq6Whp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779979711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVSuhQ3jDeko8WuVxH4OJhlR2wh8JLsTgh1JdSKjjrU=;
	b=3YtGMx20oxdAUq63Peg96UcjEADuR9iQJf32Y1Q3/wnxGFI7NEr6Loot7LRuf24U+zKXCT
	lnechgFfr/Bvh9I6eeqliU/8ttiG2RS42NyJTQY6EjyEDIWw9vkVCR5fq4iJ8NVtvW9iS6
	shawuxWq2nszjVtX8geaJn4sRTNlzfjgw4YVhZ3+EDLZ0tGmIijH4H7QcxqIWPmbkn9eCR
	FcQzsK8V9jxbWkiOFIt7JjUMr0G1r4bD3IK8jeXx2Tj2MKiBF8JqbAWlJBWCf6VQzoB0bN
	3sMRb3Z8zihOJiVWxQPfjLpjJezdvGQUbhprAXmwygeifPPYBxG8Sx1NPbKtbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779979711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVSuhQ3jDeko8WuVxH4OJhlR2wh8JLsTgh1JdSKjjrU=;
	b=TpBq6Whp22R3jxUO1ymNSydP9+uM/lLjNUsmY4JbpI/Rzc9Dq9itmVGJicNpJ5RrQH+Ai6
	/fQEheEHSboBLMAw==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 07/14] arm64: entry: Add entry and exit functions for debug exceptions
Date: Thu, 28 May 2026 16:48:17 +0200
Message-ID: <20260528144825.850351-8-bigeasy@linutronix.de>
In-Reply-To: <20260528144825.850351-1-bigeasy@linutronix.de>
References: <20260528144825.850351-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255041-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:mid,linutronix.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arm.com:email]
X-Rspamd-Queue-Id: E8DB25F41E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

Upstream commit eaff68b3286116d499a3d4e513a36d772faba587

Move the `debug_exception_enter()` and `debug_exception_exit()`
functions from mm/fault.c, as they are needed to split
the debug exceptions entry paths from the current unified one.

Make them externally visible in include/asm/exception.h until
the caller in mm/fault.c is cleaned up.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250707114109.35672-7-ada.coupriediaz@arm.=
com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/include/asm/exception.h |  4 ++++
 arch/arm64/kernel/entry-common.c   | 22 ++++++++++++++++++++++
 arch/arm64/mm/fault.c              | 22 ----------------------
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/ex=
ception.h
index f296662590c7f..b1d6a65f6d225 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -77,4 +77,8 @@ void do_serror(struct pt_regs *regs, unsigned long esr);
 void do_signal(struct pt_regs *regs);
=20
 void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, u=
nsigned long far);
+
+void debug_exception_enter(struct pt_regs *regs);
+void debug_exception_exit(struct pt_regs *regs);
+
 #endif	/* __ASM_EXCEPTION_H */
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-com=
mon.c
index d23315ef7b679..2e04e04aaf2ad 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -441,6 +441,28 @@ static __always_inline void fpsimd_syscall_exit(void)
 	__this_cpu_write(fpsimd_last_state.to_save, FP_STATE_CURRENT);
 }
=20
+/*
+ * In debug exception context, we explicitly disable preemption despite
+ * having interrupts disabled.
+ * This serves two purposes: it makes it much less likely that we would
+ * accidentally schedule in exception context and it will force a warning
+ * if we somehow manage to schedule by accident.
+ */
+void debug_exception_enter(struct pt_regs *regs)
+{
+	preempt_disable();
+
+	/* This code is a bit fragile.  Test it. */
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "exception_enter didn't work");
+}
+NOKPROBE_SYMBOL(debug_exception_enter);
+
+void debug_exception_exit(struct pt_regs *regs)
+{
+	preempt_enable_no_resched();
+}
+NOKPROBE_SYMBOL(debug_exception_exit);
+
 UNHANDLED(el1t, 64, sync)
 UNHANDLED(el1t, 64, irq)
 UNHANDLED(el1t, 64, fiq)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2d1ebc0c3437f..7c87d2b3b06ea 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -939,28 +939,6 @@ void __init hook_debug_fault_code(int nr,
 	debug_fault_info[nr].name	=3D name;
 }
=20
-/*
- * In debug exception context, we explicitly disable preemption despite
- * having interrupts disabled.
- * This serves two purposes: it makes it much less likely that we would
- * accidentally schedule in exception context and it will force a warning
- * if we somehow manage to schedule by accident.
- */
-static void debug_exception_enter(struct pt_regs *regs)
-{
-	preempt_disable();
-
-	/* This code is a bit fragile.  Test it. */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "exception_enter didn't work");
-}
-NOKPROBE_SYMBOL(debug_exception_enter);
-
-static void debug_exception_exit(struct pt_regs *regs)
-{
-	preempt_enable_no_resched();
-}
-NOKPROBE_SYMBOL(debug_exception_exit);
-
 void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long es=
r,
 			struct pt_regs *regs)
 {
--=20
2.53.0


