Return-Path: <stable+bounces-242503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAFfFsYA9WmZHAIAu9opvQ
	(envelope-from <stable+bounces-242503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:36:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1D04AF304
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAD18300E596
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5827A4219F2;
	Fri,  1 May 2026 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE1a4szM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1867D421880;
	Fri,  1 May 2026 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664182; cv=none; b=qDxP0oELemJjJDXd8Vqhrfvifmr8UrteqVaDK8OdcMRt6T+LyAiHbogVprQQo5HC1aZdK9+4JsYIXO/hCZsgtL9M0340OvGQtZUBX4ZoALfSK7DdqB4gylsGuqLpcTLVKC+ld1f3W+0ha4Kt7s8l/EwXehHDLzyCprxF5yNn+Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664182; c=relaxed/simple;
	bh=J14bqfzXZnJ30yanrpgQn9EjiynBYIkjHQW/i5d0tPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgjJP+8Vg1aOM36TjpgsozrSTEuTVxicudxpE5q16X8Vqsb8YrzDeHx4Lee2QFqoTwQR5RJRch7IiK0WSDLIecFqhqtKnYmVititCqQBbFoQlujNrVUDFWqUuXLEgvYDGZE++TnxrJ2ouTLmlw/4YMPekM8IT4oCSJsPQaDqeio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE1a4szM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FA5C2BCB8;
	Fri,  1 May 2026 19:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777664179;
	bh=J14bqfzXZnJ30yanrpgQn9EjiynBYIkjHQW/i5d0tPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dE1a4szMWiB4vyzz5c6e/y9Z8Rfgp7wxrTFIo4oXplFCZcvRfb+vIFHJpUzw0nViK
	 +cttGJ18gcvdw9RlFjJG4iiaRfggi7pgLhjhuze+jj4gZ9rm09wCZHUxhqFnWNbMvv
	 6EJSHgeJbS+ferzsIPmkLIegBhofoZpVH1vP24smAdFe0V0bvNC8gU51x9ly5FlcST
	 ZWUU+5d8arD79tLsObg+pPtE/MsxV78Cw28fWRio3HOLxApUOGWt1DQEr4fGGRcXkJ
	 vGLIwPv7kgBXvkJk7bNBw5rpg67DD+mZuKYOxOMlZ8zhdEG5lM5CCfIGvxmeI8CJHG
	 pw4oMSq8Ka/UQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 May 2026 21:35:36 +0200
Subject: [PATCH net 3/4] mptcp: fix rx timestamp corruption on fastopen
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-3-b70118df778e@kernel.org>
References: <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-0-b70118df778e@kernel.org>
In-Reply-To: <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-0-b70118df778e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Gang Yan <yangang@kylinos.cn>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9g8A5/blgrEWNDE8rhju+qeYNCLjAPhIOXOJ2cnbGk0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK/MiyPNnuTeezv432vKgLcxUodSoW+rjRWlL4za3mH9
 ctgjdrwjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIko2DP8s+d3Y3/EtDJgo8sz
 Y5vz4dmeb59OC5Tk6W1embzc7qvsCYb/cWsbjJW83U7ECkhY/Nbtf8N65KyB8MeTNqoZvcJrn1U
 xAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: EE1D04AF304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242503-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Paolo Abeni <pabeni@redhat.com>

The skb cb offset containing the timestamp presence flag is cleared
before loading such information. Cache such value before MPTCP CB
initialization.

Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/fastopen.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 82ec15bcfd7f..082c46c0f50e 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -12,6 +12,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	struct sock *sk, *ssk;
 	struct sk_buff *skb;
 	struct tcp_sock *tp;
+	bool has_rxtstamp;
 
 	/* on early fallback the subflow context is deleted by
 	 * subflow_syn_recv_sock()
@@ -40,12 +41,13 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	 */
 	tp->copied_seq += skb->len;
 	subflow->ssn_offset += skb->len;
+	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* Only the sequence delta is relevant */
 	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->offset = 0;
-	MPTCP_SKB_CB(skb)->has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
 	mptcp_data_lock(sk);

-- 
2.53.0


