Return-Path: <stable+bounces-249567-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGlDL+5PDGrwegUAu9opvQ
	(envelope-from <stable+bounces-249567-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:56:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5877857E228
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5491E301CCD4
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E2A352000;
	Tue, 19 May 2026 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ublEJxLs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB80233688B
	for <stable@vger.kernel.org>; Tue, 19 May 2026 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191545; cv=none; b=rErC6lcYv00WGQS2TyQvo0g3nXaUMG8jjfui+uAaVnIg7qLouS+R7pG7C+mMEN2s8h5mHUhWfEhXPkp8rOd+V1zJx9OETsvHDiqP0Oab9GLY2vR4KszEwCtQsL5zzTWjPHv54ET6C/2gx6u0+vWp1De0amdzB55Wi+1UJMSrnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191545; c=relaxed/simple;
	bh=X8Yz6p7zSFLu2Km5oW3FpugltSgmN9UGyI42w2JK8Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gX713ULDUAZf4uU+wERN+H6B0PYZ2ht3lYPxuuupru9Yy2w8BXedbGIqoNRdA4uOHNc/YqjCa1FoMd7udz//vx1IOUmEKlt0JpTdHnlSNjngAHMYVnn3GN2DeHkrI6JM61Lixi59ueBdpexyiHZoEdYGx9yo5oWJMXH/nD32EKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ublEJxLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E959FC2BCB3;
	Tue, 19 May 2026 11:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779191544;
	bh=X8Yz6p7zSFLu2Km5oW3FpugltSgmN9UGyI42w2JK8Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ublEJxLs0lAp3FpcwnpuRV3m6FK/EguYbtYVChBoU2Znh/yH7u3hZIJiar7fJ0Zbz
	 JFtk7VcLAPfQBjP3vwyH6NluobIC6Qxmu5X1/zsYiRkrDEw4sYBh3yZB1UW/eybD4N
	 AG3/rKyQVihHcVS2gQ7DApwAzApy62xMfVZRcRHTBmKvd5AxHf/ZHLRRrgrUo88jhg
	 NxZBwa08LjeatvT1Y04TKLWvpwGOfdcoMgKp0YPu2QgJZzAK0dZhGVbmIjx6DK8rBQ
	 Sq7cViPINoUhxPfwYWgH1xVIVhSm3BE6bxGOXXBIBtfnuhU8iLIqGWFaebnLnu7p9p
	 aqws63UgW3SNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
Date: Tue, 19 May 2026 07:52:22 -0400
Message-ID: <20260519115222.2240665-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051232-imbecile-jolly-52df@gregkh>
References: <2026051232-imbecile-jolly-52df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249567-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5877857E228
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 9634cb35af17019baec21ca648516ce376fa10e6 ]

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer().
It should then be released in all cases at the end.

Some (unlikely) checks were returning directly instead of calling
sock_put() to decrease the refcount. Jump to a new 'exit' label to call
__sock_put() (which will become sock_put() in the next commit) to fix
this potential leak.

While at it, drop the '!msk' check which cannot happen because it is
never reset, and explicitly mark the remaining one as "unlikely".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-4-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ reused existing `out:` label instead of introducing a new `exit:` label since stable's `out:` only does `__sock_put(sk)` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b88246b8f21c1..66bd01174c389 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -217,11 +217,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto out;
 
 	if (!entry->addr.id)
 		return;
-- 
2.53.0


