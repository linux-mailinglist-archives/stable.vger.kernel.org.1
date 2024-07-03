Return-Path: <stable+bounces-57316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4D5925C06
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66841F2094E
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E429F176AB0;
	Wed,  3 Jul 2024 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uTwC1h1p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345F13D61B;
	Wed,  3 Jul 2024 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004512; cv=none; b=uZRGjkoMgMdaGr3yLwfZj6W+mHT4/JXJQFf4Mg17+P3r16XbOdRbyKq0aoXB7uAM1fxZa4dLrKPOdpcJfgICxGwpPAy1CpiIvgg34cL5FGomRLJ29EEu0QEg7L9PFwW/MvwFKCmfnccz1D3AWABES7IcE/KuDQyJYf25iXv3mV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004512; c=relaxed/simple;
	bh=Mp0B5Bh5SuVu4+lItSsIOsZrHLYd01EpBQ7th6MTBAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tiueu2DPqQ33+6odQIlFsW5L5kD8FSFgxGSPXExsBnLP5OmkZJSDDGoZwa1KbmSKTNTU46s6+9DPVvz80eKPP6ITiZtK1TJJMjPrjTJFTYfjJ9lw7jnc9N0dmaYDRwQBI3VrDe2ykrcxa6oWIrqwnHHhf87J/7+ZBEi3/40HLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uTwC1h1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270BFC2BD10;
	Wed,  3 Jul 2024 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004512;
	bh=Mp0B5Bh5SuVu4+lItSsIOsZrHLYd01EpBQ7th6MTBAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTwC1h1pGtstddrQxnGcNhWnH5Z3hiAc7DRnYuAfjcUbD9ZmqZpYevBnNQDq0OZ8g
	 L7wmKuf3DklVImx3iIilkHKYR5F0KZjhYimuOGSjrI+TNaUvupkhuI6JUvyE+djQ9P
	 787tBjDhVsOzBQ3PRMkOWqg8Rrn7l4v2C9q9D8ko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 067/290] tcp: fix race in tcp_v6_syn_recv_sock()
Date: Wed,  3 Jul 2024 12:37:28 +0200
Message-ID: <20240703102906.730007665@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d37fe4255abe8e7b419b90c5847e8ec2b8debb08 ]

tcp_v6_syn_recv_sock() calls ip6_dst_store() before
inet_sk(newsk)->pinet6 has been set up.

This means ip6_dst_store() writes over the parent (listener)
np->dst_cookie.

This is racy because multiple threads could share the same
parent and their final np->dst_cookie could be wrong.

Move ip6_dst_store() call after inet_sk(newsk)->pinet6
has been changed and after the copy of parent ipv6_pinfo.

Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/tcp_ipv6.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 79d6f6ea3c546..003221d6f52e9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1311,7 +1311,6 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	 */
 
 	newsk->sk_gso_type = SKB_GSO_TCPV6;
-	ip6_dst_store(newsk, dst, NULL, NULL);
 	inet6_sk_rx_dst_set(newsk, skb);
 
 	inet_sk(newsk)->pinet6 = tcp_inet6_sk(newsk);
@@ -1322,6 +1321,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 
+	ip6_dst_store(newsk, dst, NULL, NULL);
+
 	newsk->sk_v6_daddr = ireq->ir_v6_rmt_addr;
 	newnp->saddr = ireq->ir_v6_loc_addr;
 	newsk->sk_v6_rcv_saddr = ireq->ir_v6_loc_addr;
-- 
2.43.0




