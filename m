Return-Path: <stable+bounces-120972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A02FDA50948
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3E1175EF6
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D12E2528FD;
	Wed,  5 Mar 2025 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1EXRgxmg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB92512ED;
	Wed,  5 Mar 2025 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198510; cv=none; b=JJqmY6nabP4YEdn09L3mFfQQjCjnzjTRjVEiqe4TGn1PXLq9c4jyB4rDv2eTX9Qp3l5nBLKPFlqsy5Z6gAD+CIlHzRoROS4gACtjV9dF9x6LXogb/nJR3er4NieKV1Nf6yzn7I/EyY/WprSylFdvIne54UH4F9SFGbnikmEed94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198510; c=relaxed/simple;
	bh=6SmxRtUL6aaebadfhoZ/Z+lcgkE3SBtbM3cL1XFeaZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utulK7aRCn1I9O840IV8ch7GMTXpeF5JdVJdAdiBCnm+3A88ReBBs17H3iMLbVg1UZiuMJL2j6qLjSghD91ewLj7cFq/zKO0QTV7T0JvRtnhl4Noo34xSklrD9yPAYGUfZIaS++VfacwKDEPhL2OkEc1p/Bq4ET8H5J6J7xw5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1EXRgxmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D00C4CED1;
	Wed,  5 Mar 2025 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198510;
	bh=6SmxRtUL6aaebadfhoZ/Z+lcgkE3SBtbM3cL1XFeaZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1EXRgxmgOwZBHvmkEsnk7adcaoYuUGq/QKAde7WZzVpmZy4LBii7SOM+Q9VUmfaiY
	 wUfPFktRHXVghoNo0o58YelVaGy07iMMoB4afvtb2nmrEGFkrILnZ13kCszcqx6fga
	 YYzqyyqzr7MYdsS6fIuI7iqunmgYd1BsaxXzJIDQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wang Hai <wanghai38@huawei.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 051/157] tcp: Defer ts_recent changes until req is owned
Date: Wed,  5 Mar 2025 18:48:07 +0100
Message-ID: <20250305174507.360505621@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Hai <wanghai38@huawei.com>

[ Upstream commit 8d52da23b6c68a0f6bad83959ebb61a2cf623c4e ]

Recently a bug was discovered where the server had entered TCP_ESTABLISHED
state, but the upper layers were not notified.

The same 5-tuple packet may be processed by different CPUSs, so two
CPUs may receive different ack packets at the same time when the
state is TCP_NEW_SYN_RECV.

In that case, req->ts_recent in tcp_check_req may be changed concurrently,
which will probably cause the newsk's ts_recent to be incorrectly large.
So that tcp_validate_incoming will fail. At this point, newsk will not be
able to enter the TCP_ESTABLISHED.

cpu1                                    cpu2
tcp_check_req
                                        tcp_check_req
 req->ts_recent = rcv_tsval = t1
                                         req->ts_recent = rcv_tsval = t2

 syn_recv_sock
  tcp_sk(child)->rx_opt.ts_recent = req->ts_recent = t2 // t1 < t2
tcp_child_process
 tcp_rcv_state_process
  tcp_validate_incoming
   tcp_paws_check
    if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <= paws_win)
        // t2 - t1 > paws_win, failed
                                        tcp_v4_do_rcv
                                         tcp_rcv_state_process
                                         // TCP_ESTABLISHED

The cpu2's skb or a newly received skb will call tcp_v4_do_rcv to get
the newsk into the TCP_ESTABLISHED state, but at this point it is no
longer possible to notify the upper layer application. A notification
mechanism could be added here, but the fix is more complex, so the
current fix is used.

In tcp_check_req, req->ts_recent is used to assign a value to
tcp_sk(child)->rx_opt.ts_recent, so removing the change in req->ts_recent
and changing tcp_sk(child)->rx_opt.ts_recent directly after owning the
req fixes this bug.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_minisocks.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 7121d8573928c..789e495d3bd6a 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -810,12 +810,6 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
 	/* In sequence, PAWS is OK. */
 
-	/* TODO: We probably should defer ts_recent change once
-	 * we take ownership of @req.
-	 */
-	if (tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
-		WRITE_ONCE(req->ts_recent, tmp_opt.rcv_tsval);
-
 	if (TCP_SKB_CB(skb)->seq == tcp_rsk(req)->rcv_isn) {
 		/* Truncate SYN, it is out of window starting
 		   at tcp_rsk(req)->rcv_isn + 1. */
@@ -864,6 +858,10 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	if (!child)
 		goto listen_overflow;
 
+	if (own_req && tmp_opt.saw_tstamp &&
+	    !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
+		tcp_sk(child)->rx_opt.ts_recent = tmp_opt.rcv_tsval;
+
 	if (own_req && rsk_drop_req(req)) {
 		reqsk_queue_removed(&inet_csk(req->rsk_listener)->icsk_accept_queue, req);
 		inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
-- 
2.39.5




