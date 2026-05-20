Return-Path: <stable+bounces-252861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EM3IWkYDmp96AUAu9opvQ
	(envelope-from <stable+bounces-252861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:24:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9070599882
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBD88317CCF2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E023EDAC6;
	Wed, 20 May 2026 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DNcz0m1B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AD5368968;
	Wed, 20 May 2026 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301780; cv=none; b=h/JMinYSllzqnquqt3rQLLehFT1LK6F3ziDfdjJ3z9PDUjYjt7sTFxowrHY0ZBLbvEw/KvCp4tbn8lemzePF1NGHyek+QTHpZvn1Gj4DEEl9Hi7lSBwsVCo2eP2gNUEkVbosYxLGJDNv9bwnOjO5my8azQiYNYjbGg9U5DabHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301780; c=relaxed/simple;
	bh=lvEwEBRI4c98deRPWUBD8rcSw+hy0U0YdzT9Swe4SpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6WfI4B7eY1pwrl+1cvmFc1+ptAMJYtstBEWKyuuR3Dj5/ziFiuXhTvCK1l3ecQ7d5LVRq12sa4XkcgHufviw99BWTO6/0sAFiFrRhTE/1wKFclU9K9d/gIZe/pn33WWoDcKK4VoUn2fQK+sHUf+rujJwCO8xSMmRdrlTsyqlrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DNcz0m1B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972E81F000E9;
	Wed, 20 May 2026 18:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301779;
	bh=1DMolpPwsRD0f64bUbT46dNZHE1XMOf1kyLwiSSVR3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DNcz0m1B/Z/xR86A7cLl6tlL3E33mph9Swj5SIoTwFKNWPjaaUPDVEm0jiTXW96f7
	 MZuyxgwpG0fEzsjUkWuuLjTXN4mkPnaH9jG8+S2IAQe42CQJgw60aGwJUHIbSQMoJi
	 nPRFeR9cjRZV7ke/UQ/yd691uzt/oEOa5LBZSM+M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Clark <richard.xnu.clark@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 018/508] hrtimers: Update the return type of enqueue_hrtimer()
Date: Wed, 20 May 2026 18:17:21 +0200
Message-ID: <20260520162058.981743940@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-252861-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: A9070599882
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 03f488f93cddf..9f41327d3a6d6 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1099,11 +1099,10 @@ EXPORT_SYMBOL_GPL(hrtimer_forward);
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




