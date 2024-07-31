Return-Path: <stable+bounces-64746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC56D942BB0
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 12:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5700CB21BD5
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 10:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4F1AD3F2;
	Wed, 31 Jul 2024 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaeC24Gt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9C61AAE1F;
	Wed, 31 Jul 2024 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420641; cv=none; b=n2lVarZZwpj68/QGqot3otDTtJ0ITNzDeRAx1OzibD3XMWQZVYnSRUBbdBi0urd6EhjlkiIo2D6qhBd3OdF9DtLMG4FPTadn6SIm8RBaUNUnbwyPu3UdQnbu3xI8JUTHy8yyTKx2OWIiiMgmLHQgf70wNrCpExabfw4i1pJ5giQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420641; c=relaxed/simple;
	bh=mcoK9LmrP202DQiIDF28yqP/Wm3eTVzX8tzTOTUmoAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rTYvG4pew7BtsLvdfaKUEyxWJujjnL7vAZfDw7dPivBj0soGzGYFZxqeGmx3qQRermKe0a2ENEQnratChjOj3llgvZOsi9zO7TZPbE6vplEatWA7UzZc1TNTk7jWcrvq1IEBT2RXg9fummm32+ohoxAxzIthZbWIYJ31ndNHF1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaeC24Gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA592C4AF0C;
	Wed, 31 Jul 2024 10:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722420640;
	bh=mcoK9LmrP202DQiIDF28yqP/Wm3eTVzX8tzTOTUmoAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gaeC24GtLZmFaiiW6aeo7wP7A6N+qxppCwVG83UKh8Rr4zdkhY4uPiMYBEHUFLZ6k
	 KOwijVh/QE1jdLB5YXys5gWaBe6HdtS+75FRU0kQ1ILb0kLofVxsO6MnX3z3bn28pL
	 56lhn2fkDS+cfMOWsQYtKbl9l9XFkm2wrW82mhg/ldF7RWCJ44JHRDqWrjbgtDgCsQ
	 GjCl//Ssq2JmguQBbYUcHQPY7n2hGg0vsyR/Pseqdekernxs1fKT0Qc/CxDgHHW3Em
	 fzRdqVoT+rHvwHL0GRPU93YiTD0EdmB5UzcI8nh7zhhmSKgPcXIRwJ1lnOn0+9lWq1
	 LyPfSrFMvOEHQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jul 2024 12:10:15 +0200
Subject: [PATCH net 2/2] mptcp: fix duplicate data handling
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-upstream-net-20240731-mptcp-dup-data-v1-2-bde833fa628a@kernel.org>
References: <20240731-upstream-net-20240731-mptcp-dup-data-v1-0-bde833fa628a@kernel.org>
In-Reply-To: <20240731-upstream-net-20240731-mptcp-dup-data-v1-0-bde833fa628a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JqfstQqq0JRT5Fp57RkyUDj9RgOgTzdxW2LL9v2v+s8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmqg2YV5OWiY+8t9DVjxlTKa83MnV9kq+4PFviI
 t0agQiGkHOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqoNmAAKCRD2t4JPQmmg
 cyXWEADhwq48kgatRefVmpcR3KOOixaGnWRGkEgu6ShLL6BMyOxwfJDz936aqPDmP3JpZa8lf4l
 H/ZfHIYe1By2iPkmdsRxhZPxkzDtPnwzh7NV7ul+NVsapn2zAOmXTceoQzIUY59y0wT00fFua/n
 y05le07oeC/teIIs/UXCHbLhdbMxsMTpX6yMHO9EzFxjbQtzpR4guridn3uMDGKFYPn6J/R8vkF
 DsFOtcaK3W+PxI9BGZs2OEsaPxzdoEUjp+yFfNM4PyZRZCI8feiYEfsMDF/vrc6qil1T1+NGA+W
 GEWNOW+wT0SSrZQmM+qyS8qKOZ2VROmTTbY7wocgK27mJsQNZvAfndsp2psf6kU93LMddlg5tfH
 GtzHqN27vXEWYdc86gdWSWeTu1YNmn0r7UP/ZnaDx8bnmTSUU6k5M1VjBQRFpBf+icGHJ0BNWPh
 pAcpJ/nxJg6J8x43GRd6rD81rXmXSHC1AUXIitwQAvxmZjhWm9airIan2krBMVW02S6JLMpy2TP
 oK/PGtcIEhpSO0FgHAs02we/SEPlKcKcMQxNMDhUW33QiBoy2tpveuHs0AyZ0ej08yLMgYsfjVR
 9DDHpyzbL0jj+y1bAfceQuscebPMAD8f/AKabhiyfzhyFzsGMqzJz2QYxPe48BB9Wk4dxrCVwd+
 zoriRgz0kLCD5zg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

When a subflow receives and discards duplicate data, the mptcp
stack assumes that the consumed offset inside the current skb is
zero.

With multiple subflows receiving data simultaneously such assertion
does not held true. As a result the subflow-level copied_seq will
be incorrectly increased and later on the same subflow will observe
a bad mapping, leading to subflow reset.

Address the issue taking into account the skb consumed offset in
mptcp_subflow_discard_data().

Fixes: 04e4cd4f7ca4 ("mptcp: cleanup mptcp_subflow_discard_data()")
Cc: stable@vger.kernel.org
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/501
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0e4b5bfbeaa1..a21c712350c3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1230,14 +1230,22 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
-	u32 incr;
+	struct tcp_sock *tp = tcp_sk(ssk);
+	u32 offset, incr, avail_len;
 
-	incr = limit >= skb->len ? skb->len + fin : limit;
+	offset = tp->copied_seq - TCP_SKB_CB(skb)->seq;
+	if (WARN_ON_ONCE(offset > skb->len))
+		goto out;
 
-	pr_debug("discarding=%d len=%d seq=%d", incr, skb->len,
-		 subflow->map_subflow_seq);
+	avail_len = skb->len - offset;
+	incr = limit >= avail_len ? avail_len + fin : limit;
+
+	pr_debug("discarding=%d len=%d offset=%d seq=%d", incr, skb->len,
+		 offset, subflow->map_subflow_seq);
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
 	tcp_sk(ssk)->copied_seq += incr;
+
+out:
 	if (!before(tcp_sk(ssk)->copied_seq, TCP_SKB_CB(skb)->end_seq))
 		sk_eat_skb(ssk, skb);
 	if (mptcp_subflow_get_map_offset(subflow) >= subflow->map_data_len)

-- 
2.45.2


