Return-Path: <stable+bounces-239941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHcdLotT5mmwuwEAu9opvQ
	(envelope-from <stable+bounces-239941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:25:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A17D42F739
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A24A53035601
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEA134D385;
	Mon, 20 Apr 2026 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5cVrNUA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70BB34CFC5;
	Mon, 20 Apr 2026 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701984; cv=none; b=k/9KHNV11n+DhhUSqSxu0SrpvSVYtyNaMqYL4ru1+tRCHGJYmlmcXzuXneks6OxyjZtwS1BxKIY0XkmXRwT6FNfrynaSykkHsw4/Q1CkJopzohXMKjrSYLVAngYgNI7wRwgev9WIID9XkJJgL+XcErzmLSpDRY8TDYI5jGPIWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701984; c=relaxed/simple;
	bh=aIjr5GMlqc804kQM52NnLjWmxeDXnoOMEN5wsbiICaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bslWdlZuO5/TsWpf02mYhnDvMwq4yQ+LMaxKqTDMAMeGWMTYJDwi94MXGQJayWZIEpLvw6bzRYsaVxG6y3PLO1qFfwfhqvecvGg4t3wkHQkgr++F6+aTnkd+D42QnxON7smRuzr7h/Wfeth00/HzGthp4otz/sGjahHmeSPAv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5cVrNUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE6EC2BCB6;
	Mon, 20 Apr 2026 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776701984;
	bh=aIjr5GMlqc804kQM52NnLjWmxeDXnoOMEN5wsbiICaI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V5cVrNUA/YNKeS9Df3/DDUCk9W21UbO1y/J86hTY5tyhJGk/FhHfNsC+Wnia0ydmD
	 RC+fuvE+SWK3Qwf8FR6HIcxKL1uu23E6s0sMGg5ApdTaw7AcQlIcVjJnAdfN8aeiat
	 o3czxxJrB0TLs/E/bubPq683viVAcWFyDpBJchqqFiaPrb65gMSlnRr7pu9tkPkebW
	 A25XVTAY6yrvbG0HFsJ3JzfFnG0II0we09W3zt7NQSAflADdUX62Wu2oE1ErMjz1pu
	 fi6cFnNTlz8XPt96hbKIcbw64HQEl21ZJGAnqHT9MrTKEA+5Who75kB0Q+IDZaadtH
	 5x261QwZ3f+0w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 Apr 2026 18:19:23 +0200
Subject: [PATCH net 1/2] mptcp: sync the msk->sndbuf at accept() time
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-net-mptcp-sync-sndbuf-accept-v1-1-e3523e3aeb44@kernel.org>
References: <20260420-net-mptcp-sync-sndbuf-accept-v1-0-e3523e3aeb44@kernel.org>
In-Reply-To: <20260420-net-mptcp-sync-sndbuf-accept-v1-0-e3523e3aeb44@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2078; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dmvyd/j6d1SRRnYk4UTrxuzw9U/IArcx0BRy1Vd9c94=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKfBUl9+nHN1SlHTVzWWfH+qjyWm3v5PqjITjd5t7nlz
 d8oX3u/jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImUFjMyrDzIX5V19HKogkj7
 3ioz592vdjYHxM/p7jjsLxZ330taipHhSWbVBdudbROqL5sIhcyVcDobu3NehPCmGVssla8JcZT
 yAAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239941-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A17D42F739
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Gang Yan <yangang@kylinos.cn>

On passive MPTCP connections, the msk sndbuf is not updated correctly.

The root cause is an order issue in the accept path:

- tcp_check_req() -> subflow_syn_recv_sock() -> mptcp_sk_clone_init()
  calls __mptcp_propagate_sndbuf() to copy the ssk sndbuf into msk

- Later, tcp_child_process() -> tcp_init_transfer() ->
  tcp_sndbuf_expand() grows the ssk sndbuf.

So __mptcp_propagate_sndbuf() runs before the ssk sndbuf has been
expanded and the msk ends up with a much smaller sndbuf than the
subflow:

  MPTCP: msk->sndbuf:20480, msk->first->sndbuf:2626560

Fix this by moving the __mptcp_propagate_sndbuf() call from
mptcp_sk_clone_init() -- the ssk sndbuf is not yet finalized there -- to
__mptcp_propagate_sndbuf() at accept() time, when the ssk sndbuf has
been fully expanded by tcp_sndbuf_expand().

Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/602
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fbffd3a43fe8..718e910ff23f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3594,7 +3594,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	 * uses the correct data
 	 */
 	mptcp_copy_inaddrs(nsk, ssk);
-	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
 	msk->rcvq_space.time = mptcp_stamp();
@@ -4252,6 +4251,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 		mptcp_graft_subflows(newsk);
 		mptcp_rps_record_subflows(msk);
+		__mptcp_propagate_sndbuf(newsk, mptcp_subflow_tcp_sock(subflow));
 
 		/* Do late cleanup for the first subflow as necessary. Also
 		 * deal with bad peers not doing a complete shutdown.

-- 
2.53.0


