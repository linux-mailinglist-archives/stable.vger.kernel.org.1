Return-Path: <stable+bounces-120623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3263A50789
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF8418937C6
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D3C252908;
	Wed,  5 Mar 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2eAm9nfO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD23B2528FD;
	Wed,  5 Mar 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197496; cv=none; b=T9Bq+PO+3Z32NMe3+I52EyAvNb6XkwUhHDBlE482fxqNCpelEjNRFcbuaiQPOQyOuPamPuADLY5f9Wa2cn+l4QzLGaVhrEXDaQGvga3jiuT0G/S7CvOkfVfncPXtgqL+ft/aXcVXB0wUpq78EzcIJd3aofm5dBWyvLZ0PEZQpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197496; c=relaxed/simple;
	bh=fUtP1AMJbBHI4SBFrGLj1PzhR+HxYNk8R1xiTydFhBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWenjXvmTxp06d7yeD1LN/8mc+QYfBB43Xl1ecHGI3BG3v0uS55k3rlQifD1a6B7X0W6H4w0r3rJky6je50DdqpkSOlBfwcgadR7pXlxtiJ8p2kV66wInhplx4LZ0sYj3QKoCdEKjic0izj9KwW9DIAKO2PNLBWwIFTdRQXhMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2eAm9nfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55468C4CEE9;
	Wed,  5 Mar 2025 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197496;
	bh=fUtP1AMJbBHI4SBFrGLj1PzhR+HxYNk8R1xiTydFhBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2eAm9nfOULzShMBZf3r+EzxOKVTgnV/rTlibT6TcBecdTK3o/ZyBGbh5q+Dn12nSH
	 YAEnaeh04HCcYrudT9YSYGz9GkCgS5H+gjbdKKpuybKRjIM1oS6Z4HkLPmq1TCYsf0
	 6XlH/pqZDPw9QFuC1ugVLPwtiCSk1PLGvrQiAEWc=
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
Subject: [PATCH 6.1 134/176] tcp: Defer ts_recent changes until req is owned
Date: Wed,  5 Mar 2025 18:48:23 +0100
Message-ID: <20250305174510.826100177@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index c562cb965e742..bc94df0140bfd 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -735,12 +735,6 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
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
@@ -789,6 +783,10 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
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




