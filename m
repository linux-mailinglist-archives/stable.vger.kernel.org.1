Return-Path: <stable+bounces-255028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DhVEq9XGGoQjQgAu9opvQ
	(envelope-from <stable+bounces-255028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:56:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B59835F4049
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 015F33023DB5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C953F6C5E;
	Thu, 28 May 2026 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L671/92G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k7nSgBsZ"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E53F1AAC
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979715; cv=none; b=reV0PqBffhOs0rweHLnacWiBV33GtNBxONnemdDjHhhHls2xrPI0nz2amFiYhBFVCMmxE8r7BJKonOyGq11lzdnH0mlbyXJ6hzKkpkiFpYiAEGOcHZD0vO2HyTQF86vyD0vQagt5rGKEUZPjx9qT756QGb7b5azv/HuuNzuXcIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979715; c=relaxed/simple;
	bh=+2FTYxD+eYviu6ip5PUv7qpwY3o898Ar3GmLGVNoAoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDLfjZKmY+R87NMr7JA5eM9N8tq/l9hQt4yW2uzdvLt5J+xXW1BrJdcUP8D2CkY1fUgEvqlHLtaz6FTiPpLdwX7ABlIzbIWpSjub/XU9ZLmspkKEX7RfvrmK2/Rha5j7Dr5H706hl0CRulQ5phyyWsGy5R4ps273XApl8S5f2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L671/92G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k7nSgBsZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779979709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74NiQOEXvu+WNFmGfpzTr1n5vx2wxazSVj0Sal6m5EY=;
	b=L671/92GTw8j3AcfpBJYjDCRYh4ZtJzs3jMF/ojFWlwlhaPxYliEjFiORNFla0clsh6azZ
	zvSqVuz1n2i7bgdVkA8Q4Vj55e1xqLohB3pQwhi0xrmoTxzxVqPLC1zs54nacBffcAI3LI
	EhzPl99MAbYT9ZK17kGjMUPBD33KRE3Qf8WB0pJjJvF/0RlujbziACRlLsv1xSlHktI0/5
	YMh2V2RUO5oimZ8WbfU8+Sq69OmUfPVFwnB/bFy4fIQnt2a66pLKAqKH50SpXIJJRTgZIc
	buA4jxckGdWuY3uudxGf6WoOjX/DAGcYtXQwsFnc9QKs7uFfOm0HCDgZk0b2jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779979709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74NiQOEXvu+WNFmGfpzTr1n5vx2wxazSVj0Sal6m5EY=;
	b=k7nSgBsZspJOywm7F+aDnYmr3KA5iO57e7r9aZ/7boY33Xtl3/lsEXR04z127Cw9j41ABZ
	rxopXKd404poAGCA==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 02/14] arm64: debug: clean up single_step_handler logic
Date: Thu, 28 May 2026 16:48:12 +0200
Message-ID: <20260528144825.850351-3-bigeasy@linutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255028-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: B59835F4049
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

Upstream commit ad8b22648b7d0bc6f84230508436b1aafc2e2516

Remove the unnecessary boolean which always checks if the handler was found
and return early instead.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20250707114109.35672-2-ada.coupriediaz@arm.=
com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/kernel/debug-monitors.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index 024a7b245056a..b7a2155bca42b 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -241,8 +241,6 @@ static void send_user_sigtrap(int si_code)
 static int single_step_handler(unsigned long unused, unsigned long esr,
 			       struct pt_regs *regs)
 {
-	bool handler_found =3D false;
-
 	/*
 	 * If we are stepping a pending breakpoint, call the hw_breakpoint
 	 * handler first.
@@ -250,10 +248,10 @@ static int single_step_handler(unsigned long unused, =
unsigned long esr,
 	if (!reinstall_suspended_bps(regs))
 		return 0;
=20
-	if (!handler_found && call_step_hook(regs, esr) =3D=3D DBG_HOOK_HANDLED)
-		handler_found =3D true;
+	if (call_step_hook(regs, esr) =3D=3D DBG_HOOK_HANDLED)
+		return 0;
=20
-	if (!handler_found && user_mode(regs)) {
+	if (user_mode(regs)) {
 		send_user_sigtrap(TRAP_TRACE);
=20
 		/*
@@ -263,7 +261,7 @@ static int single_step_handler(unsigned long unused, un=
signed long esr,
 		 * to the active-not-pending state).
 		 */
 		user_rewind_single_step(current);
-	} else if (!handler_found) {
+	} else {
 		pr_warn("Unexpected kernel single-step exception at EL1\n");
 		/*
 		 * Re-enable stepping since we know that we will be
--=20
2.53.0


