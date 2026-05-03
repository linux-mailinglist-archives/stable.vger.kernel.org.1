Return-Path: <stable+bounces-242693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK2lNOU292mpdgIAu9opvQ
	(envelope-from <stable+bounces-242693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:52:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F3A4B566E
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B126F300C92F
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 11:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E9D34EF08;
	Sun,  3 May 2026 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PajLBssG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D3309F1B
	for <stable@vger.kernel.org>; Sun,  3 May 2026 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777809108; cv=none; b=C1LTiwlTfdLl6RIZ8AsZY0u/fjBmGiUqbFXVM0TXlLfTPaetebxujsmblAykqnX02huTCG1HJ3BDhkeTbcs0wijd7H2sg7Lz9D1BoWsgs1wttzoeLjRRR7u86g8r2ZUChqn0wNfDvr/S8CR2N+I3rXGTI46q200qKTHiXqhY28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777809108; c=relaxed/simple;
	bh=piGZC1lHAh2/JpZQbeoGqqkumhulZO649PD/S1JplKs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=afsWuESa+u4gzL6Fxq0ZP75xM5EEWzp48usotFKM6DEOojYQEIV1mKndtS8ipHOVFO03hjU4CwuBryAqIg9pVX2EBUy+rKAT10hnn1je4lT9CvlRYMkB480nx2ybfFMVZxY3TyfL0FXAwStSnNlfe/XCY5XMp3tN0PC7oHkUqbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PajLBssG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CBBC2BCB8;
	Sun,  3 May 2026 11:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777809108;
	bh=piGZC1lHAh2/JpZQbeoGqqkumhulZO649PD/S1JplKs=;
	h=Subject:To:Cc:From:Date:From;
	b=PajLBssGmjjAUB8lDMEWaq2D8VU4qo+EQMfr/l4aJ3nk5oDhrBiotCYOtUKLe8zmS
	 Te819qI+ZyZx/WU1ZS46reodcVLPiFp3t3gd2nBjpKdczf9mcMJr5HwINfK0MHgb4T
	 42BQ79BOJ7orTyfg8HFJLaFeJLUYFxMaXrIcf9w4=
Subject: FAILED: patch "[PATCH] mm/damon/core: use time_in_range_open() for damos quota" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 13:51:45 +0200
Message-ID: <2026050344-stinging-carnivore-0639@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30F3A4B566E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242693-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,gregkh:email,linuxfoundation.org:dkim]


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 049a57421dd67a28c45ae7e92c36df758033e5fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050344-stinging-carnivore-0639@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 049a57421dd67a28c45ae7e92c36df758033e5fa Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sun, 29 Mar 2026 08:23:05 -0700
Subject: [PATCH] mm/damon/core: use time_in_range_open() for damos quota
 window start

damos_adjust_quota() uses time_after_eq() to show if it is time to start a
new quota charge window, comparing the current jiffies and the scheduled
next charge window start time.  If it is, the next charge window start
time is updated and the new charge window starts.

The time check and next window start time update is skipped while the
scheme is deactivated by the watermarks.  Let's suppose the deactivation
is kept more than LONG_MAX jiffies (assuming CONFIG_HZ of 250, more than
99 days in 32 bit systems and more than one billion years in 64 bit
systems), resulting in having the jiffies larger than the next charge
window start time + LONG_MAX.  Then, the time_after_eq() call can return
false until another LONG_MAX jiffies are passed.

This means the scheme can continue working after being reactivated by the
watermarks.  But, soon, the quota will be exceeded and the scheme will
again effectively stop working until the next charge window starts.
Because the current charge window is extended to up to LONG_MAX jiffies,
however, it will look like it stopped unexpectedly and indefinitely, from
the user's perspective.

Fix this by using !time_in_range_open() instead.

The issue was discovered [1] by sashiko.

Link: https://lore.kernel.org/20260329152306.45796-1-sj@kernel.org
Link: https://lore.kernel.org/20260324040722.57944-1-sj@kernel.org [1]
Fixes: ee801b7dd782 ("mm/damon/schemes: activate schemes based on a watermarks mechanism")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 19642c175568..3bc7a2bbfe7d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2449,7 +2449,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	}
 
 	/* New charge window starts */
-	if (time_after_eq(jiffies, quota->charged_from +
+	if (!time_in_range_open(jiffies, quota->charged_from,
+				quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {
 		if (damos_quota_is_set(quota) &&
 				quota->charged_sz >= quota->esz)


