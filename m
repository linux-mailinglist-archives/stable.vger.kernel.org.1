Return-Path: <stable+bounces-261051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HajTBO1EJWoEFgIAu9opvQ
	(envelope-from <stable+bounces-261051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:16:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8055064F745
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:16:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=zRdBKfpC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261051-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261051-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C7123046071
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA7C28688C;
	Sun,  7 Jun 2026 10:11:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCCF30C157;
	Sun,  7 Jun 2026 10:11:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827102; cv=none; b=H55IZsbdOoTSp3/Gcg76rw/COmrQdJNkGkf0DDY8VwTjqb55ljHpxW3aAcWLHeaiHyr9RKnARyDKO7zzjS4LUd4MNZiHlU1H5lBNZtJ2xCVdE/o7nwiBnuO6sNHGG6mozntz+laIqz5/sSg4uxqgE85vAIoluvjKR7I5+5VFSzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827102; c=relaxed/simple;
	bh=/C6QbTfVOt6we97FykUJMoTpc86I0+OskXWoPgeY01I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnCjlQ2Mx4nHTboiZwDFO5WBOUITRAO4tgb5dCcrny7+5czGV557DWZ+G/eCGpgwLhy6aUt0PU1ZwTyZwALxw5nBYTacUbUaYHWHigN3cObbnohi7zVyw0PNOXWmXkbA+sBd+0ANNbeP4lf2SWW0W4gwOwhT6k/D8XdPTVVzyss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zRdBKfpC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20781F00893;
	Sun,  7 Jun 2026 10:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827099;
	bh=F3ShjKxUdc6DIMfqucsd7BjF5hpMISwVXIsmNJrgRY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zRdBKfpC7cxPftjX3+4kiZ3AMKjRFRYMtmD7uYKWXhPZp8NbMadFRbmUaG9HaYUK3
	 2vPHRl3W0by2jFvdCyGgoUK+BFw+6pWgX+URPrvrJ1ZImXal/cf8ByghjvbnLZRC4a
	 hwbO8QnrGbkS+mkrNSYweg/1kwPcWsw+nzT9E8q8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 022/307] arm64: debug: split bkpt32 exception entry
Date: Sun,  7 Jun 2026 11:56:59 +0200
Message-ID: <20260607095728.442226076@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261051-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ada.coupriediaz@arm.com,m:lgoncalv@redhat.com,m:will@kernel.org,m:mark.rutland@arm.com,m:bigeasy@linutronix.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp,arm.com:email,linutronix.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8055064F745

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

[ Upstream commit fc5e5d0477c532054ce8692fd16fdaab2cb8946f ]

Currently all debug exceptions share common entry code and are routed
to `do_debug_exception()`, which calls dynamically-registered
handlers for each specific debug exception. This is unfortunate as
different debug exceptions have different entry handling requirements,
and it would be better to handle these distinct requirements earlier.

The BKPT32 exception can only be triggered by a BKPT instruction. Thus,
we know that the PC is a legitimate address and isn't being used to train
a branch predictor with a bogus address : we don't need to call
`arm64_apply_bp_hardening()`.

The handler for this exception only pends a signal and doesn't depend
on any per-CPU state : we don't need to inhibit preemption, nor do we
need to keep the DAIF exceptions masked, so we can unmask them earlier.

Split the BKPT32 exception entry and adjust function signatures and its
behaviour to match its relaxed constraints compared to other
debug exceptions.
We can also remove `NOKRPOBE_SYMBOL`, as this cannot lead to a kprobe
recursion.

This replaces the last usage of `el0_dbg()`, so remove it.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250707114109.35672-13-ada.coupriediaz@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/exception.h |  1 +
 arch/arm64/kernel/debug-monitors.c |  7 +++++++
 arch/arm64/kernel/entry-common.c   | 22 +++++++++-------------
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 7bc79602840fd0..9b05c6f487ccf1 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -72,6 +72,7 @@ void do_el0_softstep(unsigned long esr, struct pt_regs *regs);
 void do_el1_softstep(unsigned long esr, struct pt_regs *regs);
 void do_el0_brk64(unsigned long esr, struct pt_regs *regs);
 void do_el1_brk64(unsigned long esr, struct pt_regs *regs);
+void do_bkpt32(unsigned long esr, struct pt_regs *regs);
 void do_fpsimd_acc(unsigned long esr, struct pt_regs *regs);
 void do_sve_acc(unsigned long esr, struct pt_regs *regs);
 void do_sme_acc(unsigned long esr, struct pt_regs *regs);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 45e0dbe17c82fd..ed03270fa34375 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -270,6 +270,13 @@ void do_el1_brk64(unsigned long esr, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(do_el1_brk64);
 
+#ifdef CONFIG_COMPAT
+void do_bkpt32(unsigned long esr, struct pt_regs *regs)
+{
+	arm64_notify_die("aarch32 BKPT", regs, SIGTRAP, TRAP_BRKPT, regs->pc, esr);
+}
+#endif /* CONFIG_COMPAT */
+
 bool try_handle_aarch32_break(struct pt_regs *regs)
 {
 	u32 arm_instr;
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index ba114bfdb32b5a..9a1ea5a6e6b72a 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -834,18 +834,6 @@ static void noinstr el0_brk64(struct pt_regs *regs, unsigned long esr)
 	exit_to_user_mode(regs);
 }
 
-static void noinstr __maybe_unused
-el0_dbg(struct pt_regs *regs, unsigned long esr)
-{
-	/* Only watchpoints write FAR_EL1, otherwise its UNKNOWN */
-	unsigned long far = read_sysreg(far_el1);
-
-	enter_from_user_mode(regs);
-	do_debug_exception(far, esr, regs);
-	local_daif_restore(DAIF_PROCCTX);
-	exit_to_user_mode(regs);
-}
-
 static void noinstr el0_svc(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
@@ -1003,6 +991,14 @@ static void noinstr el0_svc_compat(struct pt_regs *regs)
 	exit_to_user_mode(regs);
 }
 
+static void noinstr el0_bkpt32(struct pt_regs *regs, unsigned long esr)
+{
+	enter_from_user_mode(regs);
+	local_daif_restore(DAIF_PROCCTX);
+	do_bkpt32(esr, regs);
+	exit_to_user_mode(regs);
+}
+
 asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
 {
 	unsigned long esr = read_sysreg(esr_el1);
@@ -1046,7 +1042,7 @@ asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
 		el0_watchpt(regs, esr);
 		break;
 	case ESR_ELx_EC_BKPT32:
-		el0_dbg(regs, esr);
+		el0_bkpt32(regs, esr);
 		break;
 	default:
 		el0_inv(regs, esr);
-- 
2.53.0




