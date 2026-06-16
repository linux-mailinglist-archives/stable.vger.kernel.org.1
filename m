Return-Path: <stable+bounces-265690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hj2WKOaNMWo7mgUAu9opvQ
	(envelope-from <stable+bounces-265690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:54:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 458F46939FF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:54:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=gcje19oJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265690-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265690-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B47E83035CDA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3659F466B4B;
	Tue, 16 Jun 2026 17:54:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052DB3A9627;
	Tue, 16 Jun 2026 17:54:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632482; cv=none; b=bW9UakRlmSco4qmNDaC+Np9c0iKHbd0kx9Jflna1ka9GBLatlRe2gqpdUydUSiR586tLQFTgESP4fwfUs4DC0kxiZ8ZBaU0zXvr7heirdDJWQ2KJ8VBEkyFa9/1PVifl8jXowyHLMUDv+IGZYWwqw0uJ+lXtReyspLQ5niorJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632482; c=relaxed/simple;
	bh=MzdlHS1dw1CQknE8HSvgJ9tKgKq7zl/2ItS5bcFxTHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZ+b6vGR23f68OaqFI8WkoruBlo3fiQzwMoX5nwa0gBflsaZMU8VffMv5topnJe4se0aRHICVEqPxbN9D/45Ry00YmHgoZcwze8hmWXhbwJiU//NI2r5q3JSR0KChWh5H5hbhGS4b9Y+vKpXr9oLIEmOZ35dSwDa9f59n1UiOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gcje19oJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69A91F000E9;
	Tue, 16 Jun 2026 17:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632480;
	bh=3tl7nkCekVTLjYQ8iCmD44Z49iWXI+DbLiIh1vvgTRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gcje19oJ7hpo2FgpOflYKjQrKaC7ZoV3HC5HoYYm41JAQCdOEhMWJYY5DlGE07ohX
	 gHB/Xfhi/NOZ6Onv1zxK/8n8g3RJe7f6eQ2Ce1emhoGEMp8d2nlHN9/y1H8IMo2QXp
	 PgQUa83ZZ+wq0crqIIqQYTkvsRjSQpHZMgR2xytE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lance Tuller <lance@lance0.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 420/522] mptcp: fastclose msk when linger time is 0
Date: Tue, 16 Jun 2026 20:29:27 +0530
Message-ID: <20260616145145.648932248@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265690-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:lance@lance0.com,m:martineau@kernel.org,m:matttbe@kernel.org,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 458F46939FF

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit f14d6e9c3678a067f304abba561e0c5446c7e845 ]

The SO_LINGER socket option has been supported for a while with MPTCP
sockets [1], but it didn't cause the equivalent of a TCP reset as
expected when enabled and its time was set to 0. This was causing some
behavioural differences with TCP where some connections were not
promptly stopped as expected.

To fix that, an extra condition is checked at close() time before
sending an MP_FASTCLOSE, the MPTCP equivalent of a TCP reset.

Note that backporting up to [1] will be difficult as more changes are
needed to be able to send MP_FASTCLOSE. It seems better to stop at [2],
which was supposed to already imitate TCP.

Validated with MPTCP packetdrill tests [3].

Fixes: 268b12387460 ("mptcp: setsockopt: support SO_LINGER") [1]
Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios") [2]
Cc: stable@vger.kernel.org
Reported-by: Lance Tuller <lance@lance0.com>
Closes: https://github.com/lance0/xfr/pull/67
Link: https://github.com/multipath-tcp/packetdrill/pull/196 [3]
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260427-net-mptcp-misc-fixes-7-1-rc2-v1-3-7432b7f279fa@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ kept `mptcp_check_readable()` name and explicit `inet_sk_state_store(sk, TCP_CLOSE)` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3158,7 +3158,8 @@ bool __mptcp_close(struct sock *sk, long
 		goto cleanup;
 	}
 
-	if (mptcp_check_readable(msk)) {
+	if (mptcp_check_readable(msk) ||
+	    (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)) {
 		/* the msk has read data, do the MPTCP equivalent of TCP reset */
 		inet_sk_state_store(sk, TCP_CLOSE);
 		mptcp_do_fastclose(sk);



