Return-Path: <stable+bounces-264708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tjZqCDd6MWpukQUAu9opvQ
	(envelope-from <stable+bounces-264708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:30:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFB9692275
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:30:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LKYw4RsM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264708-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264708-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DD763038F55
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5329A466B79;
	Tue, 16 Jun 2026 16:30:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CA46AF15
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 16:30:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627443; cv=none; b=JsMY133hAIJzBvp5P+eHCw3VCDkFlkrayUiAN+YZlfBzjLnVD45IHhHRq9zBHw9e1eG5kbolP4VMY4HyPy2R3kYtmTIPgNSOkCz8y7o1GAMK/LN2IuPcwoKUEYz1eW0m+a8Bp0Ww7vssbmLvNKrBbpxHTu4Up3ux56zRaLUK81Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627443; c=relaxed/simple;
	bh=GC8vyzWjH3pGnquvW4spVvJWvZCVWe192GzYHr7+5ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+oJa8jcXJQX2JBZrvFqIu8m56iQGiZ5/GFojOs5ojrjMVsScf157S6wDQuyGQOvfnQTiFcXeWBR29r02ztqsS+f0RRb7so89MGa7BGW0lHDuOoUYUuyiM6gRe4/P+N8xVQNK5/rxlw9lbLt6mS8KCPVXtDVqbFLAZsLjsmPSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKYw4RsM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702501F00A3A;
	Tue, 16 Jun 2026 16:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781627442;
	bh=/iXyDaVPf9oJak+e2RvmuhI06qdoe9dDLWD2zqYCXHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LKYw4RsM+l1Vyh10fuURBgAWvbPcuMu88ISSM/xL3oN9jT0oLrVkS5tYo4IG5vxuy
	 1S06I6l8KbHiELlEFqrhKWhNvv9br3BhmySntEqyP/yAwjKZxI0XjRQIQ/OTLYqqiT
	 RI7/2XNL6/rai4jIDC1FevSeFTwgdq02al1XaIsmsgUYqTuxBbtlvFMnA7vOiU9M08
	 eu4D7I89P/TeV4LP5JY9QedRTJxQUugKaLJzuhMhI3Q6tnz0T2CvaPGr8WiCxuuMzn
	 YBqicZEnlVkwW/cASrrA4vLg/HZrc8XGKj1mbf8SYWYWAvIFpHtY8HohiNIpFXNTHH
	 IzZIX1h3pGWdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: fix missing wakeups in edge scenarios
Date: Tue, 16 Jun 2026 12:30:39 -0400
Message-ID: <20260616163040.3345031-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061545-recall-acutely-a51c@gregkh>
References: <2026061545-recall-acutely-a51c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264708-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:pabeni@redhat.com,m:matttbe@kernel.org,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECFB9692275

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 9d8d28738f24b75616d6ca7a27cb4aed88520343 ]

The mptcp_recvmsg() can fill MPTCP socket receive queue via
mptcp_move_skbs(), but currently does not try to wakeup any listener,
because the same process is going to check the receive queue soon.

When multiple threads are reading from the same fd, the above can
cause stall. Add the missing wakeup.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-1-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2f679ad0f15b6c..7c8125a1b690fd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2103,8 +2103,10 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 		__mptcp_splice_receive_queue(sk);
 		mptcp_data_unlock(sk);
 	}
-	if (ret)
+	if (ret) {
 		mptcp_check_data_fin((struct sock *)msk);
+		sk->sk_data_ready(sk);
+	}
 	return !skb_queue_empty(&msk->receive_queue);
 }
 
-- 
2.53.0


