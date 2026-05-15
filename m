Return-Path: <stable+bounces-247324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGOrFyyiBmoMlgIAu9opvQ
	(envelope-from <stable+bounces-247324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:33:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF933549433
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B795130AAB54
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE383D47C4;
	Fri, 15 May 2026 04:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDlFKB+f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B63D47AC;
	Fri, 15 May 2026 04:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778819315; cv=none; b=EGrYAVPTHuaHLjcsUQmvigwU7SPcu4CsAbjJCGW2dbrCcEJTyVPm9PTcR7SqcuJ9XVfQlaxJ8/yzh6xrGf9lrnp27BhSo5+89P+2apBai2IlXdvsUaeWcf8CDOGFv2VcxOrrIsECVEqRadkm50MQTfv0E4asz8bScJMWNY14yFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778819315; c=relaxed/simple;
	bh=NXW/AKb3eThsc3uX6LdHwL0uOlXEWyIV7ySV/o1zgVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9LTZvfn3k/hfWA1IaeNBO2dcpCqdgci6U2uCeNeStjeda54OV8EaIdPWk4aqj6uQ91178TBCsDwI/hnb/wvR673OfEtAX5qaG7W2Y4jzrDfrNEjwdaiEYp5PXoHPz/qoDJhe4ZCku8i7cjj+qazqly9d5N+lM0dc/m/UV+pYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDlFKB+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73516C4AF09;
	Fri, 15 May 2026 04:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778819315;
	bh=NXW/AKb3eThsc3uX6LdHwL0uOlXEWyIV7ySV/o1zgVI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FDlFKB+fcqC3tZyLitivh9PaoUT/zP+wEWtAK1P0DNIB5FjxbYfUI1VSgkr6y1Au9
	 gtQSNCXpUHZ7FLZm0Isr/QOVZx9ZoGZAYLu382Soto/3GSW3MmN11mgI7mubutgY00
	 CzPzorq65uq125bHM4yJkOsTLxjEm5WpsYrBnCTmhU+n4RDsWn4XJZ6ziglZgc9XBm
	 dYL44Y2wNHqDvr5bklE6mVKhp5ie8mYW4XkQ843Fe6N/uWqG+k1B5Z6wQ4RMCjQ6b1
	 wyMHN8H86gGKUWoZe6UbyD2wtHSxytSblEaFFfR+cj62GZjc6aVI3slgfhwW33tQMW
	 O5aaquzwjk5cQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 May 2026 06:27:36 +0200
Subject: [PATCH net v2 5/6] mptcp: update window_clamp on subflows when
 SO_RCVBUF is set
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-5-701e96419f2f@kernel.org>
References: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
In-Reply-To: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 linux-kselftest@vger.kernel.org, Eric Dumazet <edumaze@google.com>, 
 Gang Yan <yangang@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wBO9RvR2M1zOMeuAgvLcafVSCiXxv7gQQpGdmT32xos=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqBqDL65EGUO3wJhKrsuF39HyEmiFJxRfsn9dWd
 8hQGBaeLReJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagagywAKCRD2t4JPQmmg
 cyBwD/4l7keh0K/58BUVhJQPOQNhiHmA9pgW9vkRoBQVaOHGXJdHqmSjltxAh20nw1EhLXBpSZj
 v8NINZz1B3HXVzwTUqKn04xrHFmX5d91lq8PBdtnryzvZyeCVoTkQTBAShwuwOXnzK+V9l7DWR4
 WIIyr52cLjFkpN8Vu7OhpgVYeU0ATtyNoTdcbAS69BZIIzmPrebhUdgBQcYEpM5x8njd+hsMTJS
 kdD71hECaaA9qDNu3koW4Obv9ym1NdUW7oY7ziEwjKInvi2v9UPh5fuqBPaeIru3f5D3j85K3H8
 SMWQsZiICAL1ot7L8UxVfv8tvV3Xzn4rZUmamIdex4UO1JNGJJmdlgKTv/DXtv976JWnlMs5e0y
 xFYjCg76TvtaOovfcUVVBK9TEHKrr+aawC0WKSDkCvDoZrfbppp4/pJlGE+589JjiAXvSNqqbVw
 ezYB+Bq9N2HPWR3aecmg4Igr7ASPsE5QbJH2rVz1fg/wYiZzIJx6omnCF2evLUck4dbZWEaJOOW
 OB4y1wiKo2jXWDKmPOuBKFuky9YqEGRuBcroJ4rZOKPd6qRLyiWB43EYcDXPjRailyNMNcbvnYN
 ZGDJOwrdWDb/5hJaO402i2Fuy+9VtiAPEnrAyUYH8E2lN8/cm+OzLqctjLgSY00FI7EdbGNwtzg
 NSHuw6/JHCE3VNQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: CF933549433
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247324-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Action: no action

From: Gang Yan <yangang@kylinos.cn>

Add __mptcp_subflow_set_rcvbuf() helper to write the subflow sk_rcvbuf,
but also to call the recently added tcp_set_rcvbuf() helper to update
window_clamp. This is needed because the window clap is updated when
scaling_ratio changes, in tcp_measure_rcv_mss(). Until scaling_ratio
changes, the subflow is stuck with the old window clamp which may be
based on a small initial buffer.

Use this new helper in both mptcp_sol_socket_sync_intval() (setsockopt
path) and sync_socket_options() (new subflow creation path).

Note that this patch depends on commit b025461303d8 ("tcp: update
window_clamp when SO_RCVBUF is set"): it fixes the issue on TCP side,
but the same fix is needed on MPTCP side as well.

Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/619
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: remove 'inline' keyword (NIPA) + update Fixes tag (Jakub)
---
 net/mptcp/sockopt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1cf608e7357b..87b5796d0135 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -67,6 +67,12 @@ static int mptcp_get_int_option(struct mptcp_sock *msk, sockptr_t optval,
 	return 0;
 }
 
+static void __mptcp_subflow_set_rcvbuf(struct sock *ssk, int val)
+{
+	WRITE_ONCE(ssk->sk_rcvbuf, val);
+	tcp_set_rcvbuf(ssk, val);
+}
+
 static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, int val)
 {
 	struct mptcp_subflow_context *subflow;
@@ -100,7 +106,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		case SO_RCVBUF:
 		case SO_RCVBUFFORCE:
 			ssk->sk_userlocks |= SOCK_RCVBUF_LOCK;
-			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+			__mptcp_subflow_set_rcvbuf(ssk, sk->sk_rcvbuf);
 			break;
 		case SO_MARK:
 			if (READ_ONCE(ssk->sk_mark) != sk->sk_mark) {
@@ -1560,7 +1566,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 			mptcp_subflow_ctx(ssk)->cached_sndbuf = sk->sk_sndbuf;
 		}
 		if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
-			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
+			__mptcp_subflow_set_rcvbuf(ssk, sk->sk_rcvbuf);
 	}
 
 	if (sock_flag(sk, SOCK_LINGER)) {

-- 
2.53.0


