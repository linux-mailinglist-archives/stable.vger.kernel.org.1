Return-Path: <stable+bounces-255036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I41JfZVGGoQjQgAu9opvQ
	(envelope-from <stable+bounces-255036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:49:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 569F85F3F0A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FAD2300B47E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3935D3F4DC5;
	Thu, 28 May 2026 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IrExUbay";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ugAY+M1q"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5EE3F4DE5
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979762; cv=none; b=qJ40RUq9apJONiVo/kMJ7su9wMqpe3Q5w0QeJKP3rW01aos57egBzroVJ+1ojmcUPQvK649R6p7huXuyeN6qMVMdnZkEb68rzIBEFEnIOrIWWSoU8hXZBIFVEGho6D/fRAYizSyPOz4ekfx+VnOswNuZtJZfPjXLUN4acAiZtxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979762; c=relaxed/simple;
	bh=xHnv0C6Zh1qCGj4iT4/is6DyWNQjU+c+mMMgMDl5GB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnKIuAsYSNfOHg9fFgB6tO7uBQ0dAvqkrrHfaC3yM9ZJxJakly2X/qYiAirBmZcjIP+af4e0LsrasFkQ/Df04MWv4C0WPkO7pgrScysZUvrZNFRhpO2MupofJwVl+y7rnUsYAItcTrIEIfJagTycejjSe+h2o4ghSUSToPwoS2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IrExUbay; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ugAY+M1q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779979714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWdbpcu3qMsaPYWs/MbQe/phZpXOEVHM+38i66BtyWE=;
	b=IrExUbay0T9K9Jd0uj6SD2OvNwC3NVXNaFya5riQ/C389AINlQhMn7ZtdvpPR3NQRLMPEd
	8bwFGEvzcsCfTyqwNWQpukR/ACsEuqrMZDyjeps8ohWWccZC729DrnN72jwYrv9CgUVMux
	9zvrJLKwYhu4exBqy3AB2tdt9tt32QpP/1WqUvwHpx6JMLcYLvOWjtC9MURtvB/dF9DVyD
	jY4A5b3rvdyBZ/P1V4Kk5l3IiwCEBC4aTchZSKlld6y7t9K1qO+p/lLQNjLYa0XhdmcbaN
	nUxvI5LYA0QRxXrw0ZivOfNuAonPOd9sMl4SJeLmDpd17KKuoOkx6S/4oGuPCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779979714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWdbpcu3qMsaPYWs/MbQe/phZpXOEVHM+38i66BtyWE=;
	b=ugAY+M1q+dGjrWPl4dUCAUL2ruyP8fVZRNkSrwZVgG6Xy3tRsTxOCltkND3vxzbZ5BMwPs
	bdIfS7de2Xvbg3CQ==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 13/14] arm64: debug: split bkpt32 exception entry
Date: Thu, 28 May 2026 16:48:23 +0200
Message-ID: <20260528144825.850351-14-bigeasy@linutronix.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255036-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 569F85F3F0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

Upstream commit fc5e5d0477c532054ce8692fd16fdaab2cb8946f

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
Link: https://lore.kernel.org/r/20250707114109.35672-13-ada.coupriediaz@arm=
.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/include/asm/exception.h |  1 +
 arch/arm64/kernel/debug-monitors.c |  7 +++++++
 arch/arm64/kernel/entry-common.c   | 22 +++++++++-------------
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/ex=
ception.h
index 7bc79602840fd..9b05c6f487ccf 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -72,6 +72,7 @@ void do_el0_softstep(unsigned long esr, struct pt_regs *r=
egs);
 void do_el1_softstep(unsigned long esr, struct pt_regs *regs);
 void do_el0_brk64(unsigned long esr, struct pt_regs *regs);
 void do_el1_brk64(unsigned long esr, struct pt_regs *regs);
+void do_bkpt32(unsigned long esr, struct pt_regs *regs);
 void do_fpsimd_acc(unsigned long esr, struct pt_regs *regs);
 void do_sve_acc(unsigned long esr, struct pt_regs *regs);
 void do_sme_acc(unsigned long esr, struct pt_regs *regs);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index 45e0dbe17c82f..ed03270fa3437 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -270,6 +270,13 @@ void do_el1_brk64(unsigned long esr, struct pt_regs *r=
egs)
 }
 NOKPROBE_SYMBOL(do_el1_brk64);
=20
+#ifdef CONFIG_COMPAT
+void do_bkpt32(unsigned long esr, struct pt_regs *regs)
+{
+	arm64_notify_die("aarch32 BKPT", regs, SIGTRAP, TRAP_BRKPT, regs->pc, esr=
);
+}
+#endif /* CONFIG_COMPAT */
+
 bool try_handle_aarch32_break(struct pt_regs *regs)
 {
 	u32 arm_instr;
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-com=
mon.c
index ba114bfdb32b5..9a1ea5a6e6b72 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -834,18 +834,6 @@ static void noinstr el0_brk64(struct pt_regs *regs, un=
signed long esr)
 	exit_to_user_mode(regs);
 }
=20
-static void noinstr __maybe_unused
-el0_dbg(struct pt_regs *regs, unsigned long esr)
-{
-	/* Only watchpoints write FAR_EL1, otherwise its UNKNOWN */
-	unsigned long far =3D read_sysreg(far_el1);
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
@@ -1003,6 +991,14 @@ static void noinstr el0_svc_compat(struct pt_regs *re=
gs)
 	exit_to_user_mode(regs);
 }
=20
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
 	unsigned long esr =3D read_sysreg(esr_el1);
@@ -1046,7 +1042,7 @@ asmlinkage void noinstr el0t_32_sync_handler(struct p=
t_regs *regs)
 		el0_watchpt(regs, esr);
 		break;
 	case ESR_ELx_EC_BKPT32:
-		el0_dbg(regs, esr);
+		el0_bkpt32(regs, esr);
 		break;
 	default:
 		el0_inv(regs, esr);
--=20
2.53.0


