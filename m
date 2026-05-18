Return-Path: <stable+bounces-249177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOXEJlSHCmpl2wQAu9opvQ
	(envelope-from <stable+bounces-249177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 05:28:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F21F05656B1
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 05:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98CD6300FEC3
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 03:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8BD3803D8;
	Mon, 18 May 2026 03:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2bsROt6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277837F00A
	for <stable@vger.kernel.org>; Mon, 18 May 2026 03:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779074898; cv=none; b=laNfCrWuR3rFliIPFoqEL7kK+QOlvX367MnRkRzxgv2HdYaSmke1ReMKvAI2mTz4xKDh9jH8sLk2MGsM9QlYjZ090iZdBMiJIR3uFraSb4kSo3mRKbqftYdbr3zCiUWWR6d7tYVV1iHZPKNte6qj43tU0onWrw0vicBwmBuqTt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779074898; c=relaxed/simple;
	bh=+pbr7K8AS2zxZUKxbhR5PkTc1SWlVSNH7i2OpHNUGkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msXHYoC21ALk4powIuBVEz4/eAjNrQMoBQeCw+BZE7H8vKOmDRrPQGOY71h66v/UIk+ZpNZ+TV/zouoqEuaizOKZ1Y0PF5+re2LYsvAcLjPBHerMyjXScalPqompjtqK4+B88eM4upy/kNwytthMPgxhH/pidMzQOMMepeMJfb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2bsROt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00BDC2BCB3;
	Mon, 18 May 2026 03:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779074897;
	bh=+pbr7K8AS2zxZUKxbhR5PkTc1SWlVSNH7i2OpHNUGkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2bsROt6juzQZfOnMOXbrz2MNNPtGK3/1M80BakSDQ+XnV59Zu2z7xY/rE9AWpcM3
	 dZUO/cbByxOmkAI0ql5kRXlMONhp0AVzK4veI5zBfpH5TWVai0BtHNTOluPwcO+35K
	 q27Q3Sp0y3ygLlhvDHEx0Uto2vW25hKqEKhzFn+MsUYnAKA3Sqry1yseJlwEdnNKvg
	 EcBjPa+OgRtyQLMozbtA2jkpSsgGS9ZAmfO6Q02eqhTCu/6PwtFzLtrE/UAmVjrk4R
	 tru1qXL5hpW7QcsL3u4zNryf191UCokIn7PPN7IVI5Rx0yoQjdVHa7p48RCsZfEZJY
	 R9AapbVpiqaxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Lance Tuller <lance@lance0.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: fastclose msk when linger time is 0
Date: Sun, 17 May 2026 23:28:15 -0400
Message-ID: <20260518032815.587921-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051200-skewed-easing-cc4c@gregkh>
References: <2026051200-skewed-easing-cc4c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F21F05656B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249177-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 965819ddc04c9..fec40ce165101 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3154,7 +3154,8 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
-	if (mptcp_check_readable(msk)) {
+	if (mptcp_check_readable(msk) ||
+	    (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)) {
 		/* the msk has read data, do the MPTCP equivalent of TCP reset */
 		inet_sk_state_store(sk, TCP_CLOSE);
 		mptcp_do_fastclose(sk);
-- 
2.53.0


