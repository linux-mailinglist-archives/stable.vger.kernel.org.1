Return-Path: <stable+bounces-190802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D37CC10C46
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0B79500BAF
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF502320A00;
	Mon, 27 Oct 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iPOGE3ei"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6EC2DAFC3;
	Mon, 27 Oct 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592234; cv=none; b=cFkAy179hG+s+SXtrniGBGN4wba94LeiWYFSIPBYpX7IhNGOFwZXzrRPO9X21//GK548HuramyjeKKqkTjRAh40Cb7bmi9r3nU29MyeiSIExXsFfN+jq6nnXpM0VSZ+ykFnWsWqvXXSlRAirXXF1Fo9YPU7JQzQp+rePvKK0MGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592234; c=relaxed/simple;
	bh=e3UtPQ1jFCUJQWAmYORGEWT4RGNDM/uhZverNE4ztYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jY09vN4a4BhM1etsno76jkmcdgJ8iVhCPRVvNA4vRYQA52x8wlPCJieGUr+H9mMT/x1bMAwkxKYbNW+zvv5E1XkaciWYOpqp92NHJYSeDPE1VVU9nPXg1FzSx2eApOhVCz8XkKqLwESwF989rSiWu4rjfPV6mIoiygR2XozXCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iPOGE3ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B674C4CEFD;
	Mon, 27 Oct 2025 19:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761592234;
	bh=e3UtPQ1jFCUJQWAmYORGEWT4RGNDM/uhZverNE4ztYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPOGE3ei/Yq93Ol8jfdVjFqMLBw0N0qOLFAdUtLIRUvojNPnCdpQKhYAl1dSbzkFZ
	 GJwD2LXDEKELWUTa+TyqxHpXx8pgcSdMKRRQnzwE5FrcUus6OU0tC8TVHObyes1L99
	 8zKS8Epztp3yijooxn6YZktCXZVMwpNgZtc6AFco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neal Cardwell <ncardwell@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 043/157] tcp: fix tcp_tso_should_defer() vs large RTT
Date: Mon, 27 Oct 2025 19:35:04 +0100
Message-ID: <20251027183502.452372246@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183501.227243846@linuxfoundation.org>
References: <20251027183501.227243846@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 295ce1eb36ae47dc862d6c8a1012618a25516208 ]

Neal reported that using neper tcp_stream with TCP_TX_DELAY
set to 50ms would often lead to flows stuck in a small cwnd mode,
regardless of the congestion control.

While tcp_stream sets TCP_TX_DELAY too late after the connect(),
it highlighted two kernel bugs.

The following heuristic in tcp_tso_should_defer() seems wrong
for large RTT:

delta = tp->tcp_clock_cache - head->tstamp;
/* If next ACK is likely to come too late (half srtt), do not defer */
if ((s64)(delta - (u64)NSEC_PER_USEC * (tp->srtt_us >> 4)) < 0)
      goto send_now;

If next ACK is expected to come in more than 1 ms, we should
not defer because we prefer a smooth ACK clocking.

While blamed commit was a step in the good direction, it was not
generic enough.

Another patch fixing TCP_TX_DELAY for established flows
will be proposed when net-next reopens.

Fixes: 50c8339e9299 ("tcp: tso: restore IW10 after TSO autosizing")
Reported-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Tested-by: Neal Cardwell <ncardwell@google.com>
Link: https://patch.msgid.link/20251011115742.1245771-1-edumazet@google.com
[pabeni@redhat.com: fixed whitespace issue]
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_output.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 40568365cdb3b..a8d8e2f294ff2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2184,7 +2184,8 @@ static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 				 u32 max_segs)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
-	u32 send_win, cong_win, limit, in_flight;
+	u32 send_win, cong_win, limit, in_flight, threshold;
+	u64 srtt_in_ns, expected_ack, how_far_is_the_ack;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct sk_buff *head;
 	int win_divisor;
@@ -2246,9 +2247,19 @@ static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 	head = tcp_rtx_queue_head(sk);
 	if (!head)
 		goto send_now;
-	delta = tp->tcp_clock_cache - head->tstamp;
-	/* If next ACK is likely to come too late (half srtt), do not defer */
-	if ((s64)(delta - (u64)NSEC_PER_USEC * (tp->srtt_us >> 4)) < 0)
+
+	srtt_in_ns = (u64)(NSEC_PER_USEC >> 3) * tp->srtt_us;
+	/* When is the ACK expected ? */
+	expected_ack = head->tstamp + srtt_in_ns;
+	/* How far from now is the ACK expected ? */
+	how_far_is_the_ack = expected_ack - tp->tcp_clock_cache;
+
+	/* If next ACK is likely to come too late,
+	 * ie in more than min(1ms, half srtt), do not defer.
+	 */
+	threshold = min(srtt_in_ns >> 1, NSEC_PER_MSEC);
+
+	if ((s64)(how_far_is_the_ack - threshold) > 0)
 		goto send_now;
 
 	/* Ok, it looks like it is advisable to defer.
-- 
2.51.0




