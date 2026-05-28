Return-Path: <stable+bounces-255032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEMXJy1XGGoQjQgAu9opvQ
	(envelope-from <stable+bounces-255032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:54:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 242A15F3FE9
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC5C93192BB3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464353F4DC8;
	Thu, 28 May 2026 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wRHxB4Cs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s5k84aL5"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE773F6C2D
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979758; cv=none; b=qIxyL+cNOeIFYE5jyoPTLboVEtmS8YF6NrPokwRsMqhNDzs6L3GvQKhc6bqZEbjB26gyzHZrvLVAEA/j6h47ZYHKdLIRcc+02/aD/VnJa/rw+D3T2IGkaZ1JfU+KarVxVCtpbFysagba7eHyct5lqSjzTeXuSolWoYzlFJJLf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979758; c=relaxed/simple;
	bh=6qYxRMWVqd/5TiuuxmMDfzPHdb+onR51scEccS5B0pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dR/EakTO8/2AzOchpJwI87pOdmGbZAV8rLTJkil7SESCJWRx+qPewYLDlaYge33EzX1pEcxu23YI1YPZxxt+PEUf/MQTVyXKY8uR8qcroHSNU31xezHYw1lby+p4svE8wYc/p63CaKUkq13BC+FKdbPsdI9lztwOCIJNlZoIVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wRHxB4Cs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s5k84aL5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779979710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ry38U6iWji6usBlRaWxdCMhMC5X4/W7+I1lPx8VCTaM=;
	b=wRHxB4CsRbWOOuD3jTXd4wm3ld9Hw8KHkqHthFVKNKesRMB7y8Oaidw2X2H/ngXYJBZs0s
	3RCZaK77R7snxTMfdr2uqWVZNTD6W+xHpZOWMo+beDoiJNm0cfTHNtVkpzBB4Td/UN9vEj
	wwaJfhH5Ny5ty3L0gmpZH966aAoRJisb82wWmwMAsBlnoCb5LKvMrWtaZtPF1l32IAnz5j
	ZwJgShT5QMzOUPh6S3uZRR8/gJHEwMIUs1oXZG2fV64mVlxMews/WaqXoog5kkaLOWIuL/
	kUIHA+FTCYlIXpsMw2pyWSaFsRUPkgW1LMdvfVctIzum+HzNZlm3CVtBS0kDOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779979710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ry38U6iWji6usBlRaWxdCMhMC5X4/W7+I1lPx8VCTaM=;
	b=s5k84aL5Hengsx5V0U1ZrkaK0w+CS68kcqKvMNxfKk3HvQHf2LqwA+UCmfy2UfWitQruiC
	n3C59k3TAijQp2AQ==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 03/14] arm64: refactor aarch32_break_handler()
Date: Thu, 28 May 2026 16:48:13 +0200
Message-ID: <20260528144825.850351-4-bigeasy@linutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255032-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 242A15F3FE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

Upstream commit b1e2d95524e4d0f5b643394c739212869e95cf6a

`aarch32_break_handler()` is called in `do_el0_undef()` when we
are trying to handle an exception whose Exception Syndrome is unknown.
It checks if the instruction hit might be a 32-bit arm break (be it
A32 or T2), and sends a SIGTRAP to userspace if it is so that it can
be handled.

However, this is badly represented in the naming of the function, and
is not consistent with the other functions called with the same logic
in `do_el0_undef()`.

Rename it `try_handle_aarch32_break()` and change the return value to
a boolean to align with the logic of the other tentative handlers in
`do_el0_undef()`, the previous error code being ignored anyway.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20250707114109.35672-3-ada.coupriediaz@arm.=
com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/include/asm/debug-monitors.h |  2 +-
 arch/arm64/kernel/debug-monitors.c      | 10 +++++-----
 arch/arm64/kernel/traps.c               |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/a=
sm/debug-monitors.h
index 13d437bcbf58c..3eeea1c9f0666 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -115,7 +115,7 @@ static inline int reinstall_suspended_bps(struct pt_reg=
s *regs)
 }
 #endif
=20
-int aarch32_break_handler(struct pt_regs *regs);
+bool try_handle_aarch32_break(struct pt_regs *regs);
=20
 void debug_traps_init(void);
=20
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index b7a2155bca42b..8275b7f575462 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -335,7 +335,7 @@ static int brk_handler(unsigned long unused, unsigned l=
ong esr,
 }
 NOKPROBE_SYMBOL(brk_handler);
=20
-int aarch32_break_handler(struct pt_regs *regs)
+bool try_handle_aarch32_break(struct pt_regs *regs)
 {
 	u32 arm_instr;
 	u16 thumb_instr;
@@ -343,7 +343,7 @@ int aarch32_break_handler(struct pt_regs *regs)
 	void __user *pc =3D (void __user *)instruction_pointer(regs);
=20
 	if (!compat_user_mode(regs))
-		return -EFAULT;
+		return false;
=20
 	if (compat_thumb_mode(regs)) {
 		/* get 16-bit Thumb instruction */
@@ -367,12 +367,12 @@ int aarch32_break_handler(struct pt_regs *regs)
 	}
=20
 	if (!bp)
-		return -EFAULT;
+		return false;
=20
 	send_user_sigtrap(TRAP_BRKPT);
-	return 0;
+	return true;
 }
-NOKPROBE_SYMBOL(aarch32_break_handler);
+NOKPROBE_SYMBOL(try_handle_aarch32_break);
=20
 void __init debug_traps_init(void)
 {
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5e138cf5d4ade..c38ebf715be76 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -462,7 +462,7 @@ void do_el0_undef(struct pt_regs *regs, unsigned long e=
sr)
 	u32 insn;
=20
 	/* check for AArch32 breakpoint instructions */
-	if (!aarch32_break_handler(regs))
+	if (try_handle_aarch32_break(regs))
 		return;
=20
 	if (user_insn_read(regs, &insn))
--=20
2.53.0


