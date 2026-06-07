Return-Path: <stable+bounces-261015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rpIyAmFDJWpIFQIAu9opvQ
	(envelope-from <stable+bounces-261015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:09:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB16764F5C1
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:09:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=sEufEN4W;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261015-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261015-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBAD1300A4ED
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BA32E1EFC;
	Sun,  7 Jun 2026 10:09:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38091DE8AE;
	Sun,  7 Jun 2026 10:09:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826974; cv=none; b=sTGZLEmwR4n1Ws6AsXxoZL1X8Ng+fbrFXyBemIsJqEFjPCe18yNBbfANi/XkgXK5H59WTKwPIuBOhFjXxgrZazkeTBPqSvOJNO0/HmDHxPVL4qkiD7Dvq+nyYb7xVatfgxGTLpeaz2Wrj2ZBStkf2IYrHejtWeWOptkSJ4NiRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826974; c=relaxed/simple;
	bh=wFXhYxzBWJI86gwiAKUYFE5Et48Qho5yVeeChHaZEkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nP3tcBVx5CFa+8+Rp0YY2dMkDcEMfONc5P1umqdd8eSP79PiWTXLLiZW2IhRrEKn/d89BAmYD4+xOQUlVyHJu8bwaNKrn2y/V/SfF/HvKH9dMy301lylllbJdSGz5y4owu1yZe8H8Q/8++OzuE0qS7q8UHwZN8gBxUHb52vSyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sEufEN4W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483D21F00893;
	Sun,  7 Jun 2026 10:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826973;
	bh=8w1Eo1SuDxehnGg2d8Ov2CpW6ed5O7b1PS1ftqeM4Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sEufEN4W67pGZCdH9RNqAl3JcNI4Doob4g5vvlW2xCiAMFF0Qs+6Wr/Xs9OdojlaV
	 M5emtuS7Z1w9bn8zB2AzSY8iDZVWz5B3HDH+C+1bkjk40RYYXUmiSoZqs7VkKOCjTA
	 yiev14mBp4emrAYTHBC3OHAkOVTC28YTFoav/3xk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 011/307] arm64: debug: clean up single_step_handler logic
Date: Sun,  7 Jun 2026 11:56:48 +0200
Message-ID: <20260607095728.047675023@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261015-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ada.coupriediaz@arm.com,m:lgoncalv@redhat.com,m:anshuman.khandual@arm.com,m:mark.rutland@arm.com,m:will@kernel.org,m:bigeasy@linutronix.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB16764F5C1

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

[ Upstream commit ad8b22648b7d0bc6f84230508436b1aafc2e2516 ]

Remove the unnecessary boolean which always checks if the handler was found
and return early instead.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20250707114109.35672-2-ada.coupriediaz@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/debug-monitors.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 024a7b245056a8..b7a2155bca42b1 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -241,8 +241,6 @@ static void send_user_sigtrap(int si_code)
 static int single_step_handler(unsigned long unused, unsigned long esr,
 			       struct pt_regs *regs)
 {
-	bool handler_found = false;
-
 	/*
 	 * If we are stepping a pending breakpoint, call the hw_breakpoint
 	 * handler first.
@@ -250,10 +248,10 @@ static int single_step_handler(unsigned long unused, unsigned long esr,
 	if (!reinstall_suspended_bps(regs))
 		return 0;
 
-	if (!handler_found && call_step_hook(regs, esr) == DBG_HOOK_HANDLED)
-		handler_found = true;
+	if (call_step_hook(regs, esr) == DBG_HOOK_HANDLED)
+		return 0;
 
-	if (!handler_found && user_mode(regs)) {
+	if (user_mode(regs)) {
 		send_user_sigtrap(TRAP_TRACE);
 
 		/*
@@ -263,7 +261,7 @@ static int single_step_handler(unsigned long unused, unsigned long esr,
 		 * to the active-not-pending state).
 		 */
 		user_rewind_single_step(current);
-	} else if (!handler_found) {
+	} else {
 		pr_warn("Unexpected kernel single-step exception at EL1\n");
 		/*
 		 * Re-enable stepping since we know that we will be
-- 
2.53.0




