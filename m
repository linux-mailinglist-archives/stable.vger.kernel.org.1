Return-Path: <stable+bounces-252198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOM3ASkADmp+5QUAu9opvQ
	(envelope-from <stable+bounces-252198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:40:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 884DD596F92
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D4AC38E536F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E540A3F4DC0;
	Wed, 20 May 2026 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kdntewXu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB63D75C7;
	Wed, 20 May 2026 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300048; cv=none; b=RuMiMHHeRi6jXmD+NwGpDlbyHje78J2o1c6lbXkFAoknIbAjVXYvtoDxmV5U13m43M0053zlUzduSQJyn1nQ0OKjnCMTlIvhivEgj2DZxxIjtYr0bEaXA4dLDWPPORfZXdY5x+3aSrB0QVWdzWKXwmCWpQjyh2NxVsucz75SGZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300048; c=relaxed/simple;
	bh=gwSurPaYmSRFvEFv30x2vToPGJP6KS7nis+MrPZu05k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=logIvn5Z1a5RkS65OBPj89lge2eftpatvt2nN2GRyaQOmXXJdd7xOllqePMjtuFfXOATPxFJyv933l14j//Bjn8f8eaCEjHela9drtpbNcjsS8mXNDUP4yHU4KTyuCVyCtImpbcC8fhVgoWSgsJYiyZt5XGIelfwOtQBpXqtqlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kdntewXu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215A01F000E9;
	Wed, 20 May 2026 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300047;
	bh=Fp6kSsUUUr110Kgwb+asla3u9xL9qqTwNmD13stksWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kdntewXuMWtuZkNddm7hx/DZMHCVbhroBkkmk37SSc1bR3wTklYdxNxQqAct2TAuj
	 +aNCa8qoZlHSns+UZioADjeQWhHBe8Q1uCB7CxbSFi5ikDNfksRUPxZSb1mHE3KC4t
	 DEwYuSYofEHFNmSwqFeAL3D7ZKwrLeQMiJJhVE2Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Clark <richard.xnu.clark@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 027/666] hrtimers: Update the return type of enqueue_hrtimer()
Date: Wed, 20 May 2026 18:13:58 +0200
Message-ID: <20260520162111.823521575@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-252198-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linutronix.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: 884DD596F92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 640d2ea4bd1fa..6abd0d2807f5d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1091,11 +1091,10 @@ EXPORT_SYMBOL_GPL(hrtimer_forward);
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




