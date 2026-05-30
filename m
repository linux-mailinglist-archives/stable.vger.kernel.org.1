Return-Path: <stable+bounces-257413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JE+JxIbG2oq/QgAu9opvQ
	(envelope-from <stable+bounces-257413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:14:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6BF60F36B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A50F30C0C0D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDE73AF643;
	Sat, 30 May 2026 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T2Oly1qF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863AA39B4A6;
	Sat, 30 May 2026 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160911; cv=none; b=sS1NnmPfac8upTR0YXajeokYOl272J5WKCrM0ei8SKSZMXOVKoAfQyIvUNIuz7CRy49PHqEg+pUZ83b8y3nmFOhtXzNSe7hAG0L1ETFDURUraj+yONtciw411bbf0VtFQW9CwF5DoLWDm32OftUivYL1kl7629SUoN9JX9SAh8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160911; c=relaxed/simple;
	bh=wu7sfyoCFtIhn0wkDampejCZP24Dkob5Y4bZgOfQL5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/ETIjKWaMs1L6VHo6Bca3lE/q++UNHQNAQEzWLNkZl5hxhbBgrlUCbLsR59tDWeWkECPhGl5PsbfdMBnafkhLHPyfqm9pMOnLHwQ4pQwGwSuyFnC0nsIHHy/C3kCqMDqUbr+OkhbUCxjcKudFDaqtqSjLlCnRaVQZg/Laoncxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T2Oly1qF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C2D1F00899;
	Sat, 30 May 2026 17:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160910;
	bh=7bh2VfIYzQxgmQ53Hsriu9vcAxvGSBjo+dkry2WMWuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2Oly1qFl8/eGoWEranHhhiaq4X/faJ/ofAazI/XjRwQS6XyhzcBT1igCOEM8GClS
	 GEox07PAzpkL9vc70s+Xi1gqXYlKkMeVUTf8M88XuRMmxr9WVE3h6kenvvZW9h4GE5
	 QrFJrV/P86Sbr95ayPMQ7NgKc3SCsqbnQma+AGVQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Clark <richard.xnu.clark@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 441/969] hrtimers: Update the return type of enqueue_hrtimer()
Date: Sat, 30 May 2026 17:59:25 +0200
Message-ID: <20260530160312.450410435@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257413-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linutronix.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0E6BF60F36B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Clark <richard.xnu.clark@gmail.com>

[ Upstream commit da7100d3bf7d6f5c49ef493ea963766898e9b069 ]

The return type should be 'bool' instead of 'int' according to the calling
context in the kernel, and its internal implementation, i.e. :

	return timerqueue_add();

which is a bool-return function.

[ tglx: Adjust function arguments ]

Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/Z2ppT7me13dtxm1a@MBC02GN1V4Q05P
Stable-dep-of: f2e388a019e4 ("hrtimer: Reduce trace noise in hrtimer_start()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/hrtimer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 002b29e566cb3..062dda96e2706 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1096,11 +1096,10 @@ EXPORT_SYMBOL_GPL(hrtimer_forward);
  * The timer is inserted in expiry order. Insertion into the
  * red black tree is O(log(n)). Must hold the base lock.
  *
- * Returns 1 when the new timer is the leftmost timer in the tree.
+ * Returns true when the new timer is the leftmost timer in the tree.
  */
-static int enqueue_hrtimer(struct hrtimer *timer,
-			   struct hrtimer_clock_base *base,
-			   enum hrtimer_mode mode)
+static bool enqueue_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base,
+			    enum hrtimer_mode mode)
 {
 	debug_activate(timer, mode);
 	WARN_ON_ONCE(!base->cpu_base->online);
-- 
2.53.0




