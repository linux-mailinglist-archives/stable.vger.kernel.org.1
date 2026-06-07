Return-Path: <stable+bounces-261059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dvHdITJFJWomFgIAu9opvQ
	(envelope-from <stable+bounces-261059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:17:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EBB64F79B
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:17:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="xmsl/tEj";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261059-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261059-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6D69305817D
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B722E2DDD;
	Sun,  7 Jun 2026 10:12:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6712F1E98EF;
	Sun,  7 Jun 2026 10:12:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827124; cv=none; b=QwMIbjFoVccpjNz5SknTEzkpL8qH21T8VBtZiAo2CR0A4bgFU8pNQI2CNctp3z451ws3XTj1cSUr8hKfSy/r0y+sU76YoyYaSYvF6Gr5IRbLP8IEP7+8JEFZ1bnBaKpQM8q4pKrTURPwNWKPW5eNhdflh1hcN6QdW0g617YNFHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827124; c=relaxed/simple;
	bh=S8N+u2omnJ4nxX1BEfDRnY2Z2uvEqn0YJAz3JIQgv6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWgK8dYkyjWxYCwFiqYW+JL7QwDGFYvxFjP8KCQPbW7KSXLY8nCdM7Vpxi1P+QkpaNpCZ8w/7rjvSZCksmVGkxPpLBlznFormFTln6EbYTxBtQT/K/dWcJQ/s0UqehVdfMCjBvznPp0CeaBv4P0DxR0PBJ3w1VdYgC3cgEUzTiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xmsl/tEj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735081F00893;
	Sun,  7 Jun 2026 10:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827123;
	bh=M8Xcvhc/IipSzVeD1AatUIqgRyHDtzPN/tow19Mvo0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xmsl/tEjj/2m89Ogi+Z+7QKpoMIvYmiTwYePlcda0cWhJrxN9QHLLOVvbvcCobxlk
	 8S53ytBaGtOPBQbrIuwfdBwxa6yE1DLsGJvqlYkJYvsmbMVwJd6vfYdrE2VgwFYkyh
	 GYxm+g85WhJ/IOYLNZ6rHGtsQKYXvN7fSeg/xyYI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 024/307] arm64: debug: always unmask interrupts in el0_softstp()
Date: Sun,  7 Jun 2026 11:57:01 +0200
Message-ID: <20260607095728.518615883@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-261059-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ada.coupriediaz@arm.com,m:mark.rutland@arm.com,m:catalin.marinas@arm.com,m:bigeasy@linutronix.de,m:sashal@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linutronix.de:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04EBB64F79B

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

[ Upstream commit ea0d55ae4b3207c33691a73da3443b1fd379f1d2 ]

We intend that EL0 exception handlers unmask all DAIF exceptions
before calling exit_to_user_mode().

When completing single-step of a suspended breakpoint, we do not call
local_daif_restore(DAIF_PROCCTX) before calling exit_to_user_mode(),
leaving all DAIF exceptions masked.

When pseudo-NMIs are not in use this is benign.

When pseudo-NMIs are in use, this is unsound. At this point interrupts
are masked by both DAIF.IF and PMR_EL1, and subsequent irq flag
manipulation may not work correctly. For example, a subsequent
local_irq_enable() within exit_to_user_mode_loop() will only unmask
interrupts via PMR_EL1 (leaving those masked via DAIF.IF), and
anything depending on interrupts being unmasked (e.g. delivery of
signals) will not work correctly.

This was detected by CONFIG_ARM64_DEBUG_PRIORITY_MASKING.

Move the call to `try_step_suspended_breakpoints()` outside of the check
so that interrupts can be unmasked even if we don't call the step handler.

Fixes: 0ac7584c08ce ("arm64: debug: split single stepping exception entry")
Cc: <stable@vger.kernel.org> # 6.17
Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
[catalin.marinas@arm.com: added Mark's rewritten commit log and some whitespace]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/entry-common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index b98d6d1a1dfd63..ea3876d99c2ec5 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -796,6 +796,8 @@ static void noinstr el0_breakpt(struct pt_regs *regs, unsigned long esr)
 
 static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
 {
+	bool step_done;
+
 	if (!is_ttbr0_addr(regs->pc))
 		arm64_apply_bp_hardening();
 
@@ -806,10 +808,10 @@ static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
 	 * If we are stepping a suspended breakpoint there's nothing more to do:
 	 * the single-step is complete.
 	 */
-	if (!try_step_suspended_breakpoints(regs)) {
-		local_daif_restore(DAIF_PROCCTX);
+	step_done = try_step_suspended_breakpoints(regs);
+	local_daif_restore(DAIF_PROCCTX);
+	if (!step_done)
 		do_el0_softstep(esr, regs);
-	}
 	exit_to_user_mode(regs);
 }
 
-- 
2.53.0




