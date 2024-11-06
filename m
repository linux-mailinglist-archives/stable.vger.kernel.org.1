Return-Path: <stable+bounces-91424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656BF9BEDE8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3E62865B8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E843D1D619E;
	Wed,  6 Nov 2024 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JSL4t/I+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA11E0480;
	Wed,  6 Nov 2024 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898695; cv=none; b=Ij0gZJLFI0XWeg8czjGTuxINnW2qDQX3r/DrXBIpcTvS3ejHJATHFPo8C2fRQ7jFAlQ5PlIMeeNEgHzTOZymyi3CaNtUNOyUdOtAdIwLucxyA1lJkl5mIirexElhPg9v4urszfYfiENFeUfd0PvMsjJ19votkApmX+iZGQEWjZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898695; c=relaxed/simple;
	bh=l9VVBZwM+jS3OiQzXVSQLHr062jsC1uwTe0a567ZfqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAnh9XmthlaDfekx7SNF3bM8OaLc8yGmuEs7DYSkQeXRG1OQiLOvWl/Z28xb4c0GU2Unhmwkko/Yls51bdkJN1wBzXAy4v3aLz1ta78G8teeWZcsoyN7tCnt4sgBmgA9GB///qnckW0/GrOT6kpGAyPKqP2qSRSZxE8BS3IUWD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JSL4t/I+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E415C4CECD;
	Wed,  6 Nov 2024 13:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898695;
	bh=l9VVBZwM+jS3OiQzXVSQLHr062jsC1uwTe0a567ZfqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JSL4t/I+0eDS7HE/QSk8sJB74zBoywN5MZtrGAAEj5v7p3EEkyZrKafVDNec09ml2
	 5N038srsNB/peaMs0gdTYd0eIZpBQNqRohKsOU65jDPeMMHnRX6pERxcVOEwSQGsl7
	 ysqbGsqbr0xbmKsFtSVLhNTWdvnrkMQVVV1BAxtU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geumhwan Yu <geumhwan.yu@samsung.com>,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 324/462] tcp: fix to allow timestamp undo if no retransmits were sent
Date: Wed,  6 Nov 2024 13:03:37 +0100
Message-ID: <20241106120339.531386951@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neal Cardwell <ncardwell@google.com>

[ Upstream commit e37ab7373696e650d3b6262a5b882aadad69bb9e ]

Fix the TCP loss recovery undo logic in tcp_packet_delayed() so that
it can trigger undo even if TSQ prevents a fast recovery episode from
reaching tcp_retransmit_skb().

Geumhwan Yu <geumhwan.yu@samsung.com> recently reported that after
this commit from 2019:

commit bc9f38c8328e ("tcp: avoid unconditional congestion window undo
on SYN retransmit")

...and before this fix we could have buggy scenarios like the
following:

+ Due to reordering, a TCP connection receives some SACKs and enters a
  spurious fast recovery.

+ TSQ prevents all invocations of tcp_retransmit_skb(), because many
  skbs are queued in lower layers of the sending machine's network
  stack; thus tp->retrans_stamp remains 0.

+ The connection receives a TCP timestamp ECR value echoing a
  timestamp before the fast recovery, indicating that the fast
  recovery was spurious.

+ The connection fails to undo the spurious fast recovery because
  tp->retrans_stamp is 0, and thus tcp_packet_delayed() returns false,
  due to the new logic in the 2019 commit: commit bc9f38c8328e ("tcp:
  avoid unconditional congestion window undo on SYN retransmit")

This fix tweaks the logic to be more similar to the
tcp_packet_delayed() logic before bc9f38c8328e, except that we take
care not to be fooled by the FLAG_SYN_ACKED code path zeroing out
tp->retrans_stamp (the bug noted and fixed by Yuchung in
bc9f38c8328e).

Note that this returns the high-level behavior of tcp_packet_delayed()
to again match the comment for the function, which says: "Nothing was
retransmitted or returned timestamp is less than timestamp of the
first retransmission." Note that this comment is in the original
2005-04-16 Linux git commit, so this is evidently long-standing
behavior.

Fixes: bc9f38c8328e ("tcp: avoid unconditional congestion window undo on SYN retransmit")
Reported-by: Geumhwan Yu <geumhwan.yu@samsung.com>
Diagnosed-by: Geumhwan Yu <geumhwan.yu@samsung.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241001200517.2756803-2-ncardwell.sw@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_input.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cf6221e9fda50..75e954590bdd5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2294,8 +2294,22 @@ static bool tcp_skb_spurious_retrans(const struct tcp_sock *tp,
  */
 static inline bool tcp_packet_delayed(const struct tcp_sock *tp)
 {
-	return tp->retrans_stamp &&
-	       tcp_tsopt_ecr_before(tp, tp->retrans_stamp);
+	const struct sock *sk = (const struct sock *)tp;
+
+	if (tp->retrans_stamp &&
+	    tcp_tsopt_ecr_before(tp, tp->retrans_stamp))
+		return true;  /* got echoed TS before first retransmission */
+
+	/* Check if nothing was retransmitted (retrans_stamp==0), which may
+	 * happen in fast recovery due to TSQ. But we ignore zero retrans_stamp
+	 * in TCP_SYN_SENT, since when we set FLAG_SYN_ACKED we also clear
+	 * retrans_stamp even if we had retransmitted the SYN.
+	 */
+	if (!tp->retrans_stamp &&	   /* no record of a retransmit/SYN? */
+	    sk->sk_state != TCP_SYN_SENT)  /* not the FLAG_SYN_ACKED case? */
+		return true;  /* nothing was retransmitted */
+
+	return false;
 }
 
 /* Undo procedures. */
-- 
2.43.0




