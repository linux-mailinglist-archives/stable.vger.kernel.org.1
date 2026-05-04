Return-Path: <stable+bounces-243732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLIoBAet+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:28:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B68984BF82E
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A8A530953F8
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124CB3DE44F;
	Mon,  4 May 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hN76q1HN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92D43DF00D;
	Mon,  4 May 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904635; cv=none; b=c/jPlSucwgq1FcrpMd1ylTUk0yYkNKUhH5Si4utvx/ElZr8htbdc30bSBIpFZgDL09tv5w9k60F1X/r72OPcV2Faue3NR5/iFCYRvcV1dfjTyK9qn0arbymN1b3y+j4RMbOr1PqsPkHJi/jN6eKZTIIzY3E6Udt9PciqmXDT5VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904635; c=relaxed/simple;
	bh=5p5Bp3K0mZu26yCHORzNpbrDccC+2zz5htvZUhXOb9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDv/AkJ45bDV2vTTzFpD/sxIHKg4p7GKT+SyLTozI5uHjHaebeAxcerQkdZCoilJfo+9xNXcdZ9wOJBu/XqkI0x4Ny6XshSPZ/Yox8mRYan7v6Yp2k6Hd19xFV73buAcItJ6J1k9rrvme2QSd4H5lqiZ4471ue79QPD9ZrccJq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hN76q1HN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5889FC2BCF4;
	Mon,  4 May 2026 14:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904635;
	bh=5p5Bp3K0mZu26yCHORzNpbrDccC+2zz5htvZUhXOb9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hN76q1HNv8bj04+xUDbMcLwQgAzBM0PzCAOcvUoWgGnh3zzu1iEDQlOc2vHQB49H9
	 8Lb3nA87FBE0ZJKryhlvObmy16LpouuXJIVaQBx6TtKUSLvNXsWsHITkIb4isIKvC6
	 ln1ZWZOxT//bpnGqiEkaAt3XBu5bpcLLptywl4nA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 116/215] mm/damon/core: use time_in_range_open() for damos quota window start
Date: Mon,  4 May 2026 15:52:15 +0200
Message-ID: <20260504135134.391381055@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: B68984BF82E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243732-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linux-foundation.org:email]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sj@kernel.org>

commit 049a57421dd67a28c45ae7e92c36df758033e5fa upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1601,7 +1601,8 @@ static void damos_adjust_quota(struct da
 		quota->charged_from = jiffies;
 
 	/* New charge window starts */
-	if (time_after_eq(jiffies, quota->charged_from +
+	if (!time_in_range_open(jiffies, quota->charged_from,
+				quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {
 		if (quota->esz && quota->charged_sz >= quota->esz)
 			s->stat.qt_exceeds++;



