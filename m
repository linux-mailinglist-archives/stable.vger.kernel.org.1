Return-Path: <stable+bounces-241434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EUbKHu/72mLFQEAu9opvQ
	(envelope-from <stable+bounces-241434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:56:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F70479984
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31E5F3015820
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AA942189B;
	Mon, 27 Apr 2026 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6N0iGij"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BBA42189A;
	Mon, 27 Apr 2026 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319691; cv=none; b=ecFgLGxTnvLTTnWm7eu/JfqQXMkrXT4lhYbTHGd2D+EI/+jWaiG3hJpFxi9a8xCVoCjBiUrAYiXmKbyOKHCN00YveC92XTL9Z7kYS0lB9brt0//pbMtCLOnIQl3zxi8x3oBP8fLFx7sr9HTk0cJ+G8aFGRdEggkvBETt3Lpi11U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319691; c=relaxed/simple;
	bh=RSS32AhqrYieijWsPYjck0hKZlEjdH3hTLaQgWU9920=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mu1n36LlDQ8L0neQu8XPFKIJet0QFr9aCvamfbyNJr322J3Yztq4nMi6Q7YThrmmIHmqrXJafQXb0eGTLJeaochJ4RwYvH6moVF6JUXG1Xna/bCmdRjxP6CZoRoh5D8j/69anPxMXftvZPEzOYf3TUpH5kYR4OHPoyzYvi6I20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6N0iGij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A416C19425;
	Mon, 27 Apr 2026 19:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777319691;
	bh=RSS32AhqrYieijWsPYjck0hKZlEjdH3hTLaQgWU9920=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z6N0iGij80AUMpSKSZqQMYC9qbljVvTa06qYGgIx0rnlpyXlaEoXaPIH1cRZ2b91g
	 b6BAIBEbTL+dzmAa72prJXR5Dz6Pnrmt8mgN4B0Hq+f9u9Aa1LSZeUCSl2jkkB0pt1
	 ki3cGMHfPqYL0+BDlLnZly+NHhJ6HMUobKWn40FHNW4sv0VqsWVMBU0alGGR0a7BBE
	 1EqYC+2MSYdaLjwCm2yCi86FNtMWEXWboStfixp9z9B39BMy9qzjTpfzq0bzutrhtJ
	 OEAvcxbzmIgNO+8urr2Gwbd3XVe2jfXVS28qik7+F9UhN6VY+Ux82NvMRMFU5QWzPK
	 AHOFqbFEXvJ6Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 Apr 2026 21:54:35 +0200
Subject: [PATCH net 3/4] mptcp: fastclose msk when linger time is 0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-3-7432b7f279fa@kernel.org>
References: <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-0-7432b7f279fa@kernel.org>
In-Reply-To: <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-0-7432b7f279fa@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Lance Tuller <lance@lance0.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RSS32AhqrYieijWsPYjck0hKZlEjdH3hTLaQgWU9920=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLf7/vP1uAs5vXWZfXvl3fq7u63MN/8c8mRkL+sJ7Zk5
 EyXUkpX7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIfVGG/7UTl1mWXHx/1GRH
 6v6711d2HXJrZed4dSbpmAXnesuFy28xMrwWf9yq+ayq5dLU33HyhiK7Kk4sWhPzxGwrx9v3l5T
 60pgA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: A5F70479984
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241434-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lance0.com:email]

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
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 718e910ff23f..4546a8b09884 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3302,7 +3302,8 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
-	if (mptcp_data_avail(msk) || timeout < 0) {
+	if (mptcp_data_avail(msk) || timeout < 0 ||
+	    (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)) {
 		/* If the msk has read data, or the caller explicitly ask it,
 		 * do the MPTCP equivalent of TCP reset, aka MPTCP fastclose
 		 */

-- 
2.53.0


