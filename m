Return-Path: <stable+bounces-110056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63863A185D5
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FDF1613D0
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4623A1F560C;
	Tue, 21 Jan 2025 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5zGBHdk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068301EB2F
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737489167; cv=none; b=P7zaZkICD32yI/NtxeNpfiewpyOZGvAHvYMiZ8Lb+Pm+bImqX9tcRqwCN/UlhOCOPgPYkw247IgLT0orpnPYAAfVxlRs0sNl4sZ7n8X91PmU2Q1LittVL9LUjmqImx2/Vww4ifIhX0lgeG51IpqX+qW+pgdDRHiNEYP6H/emoyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737489167; c=relaxed/simple;
	bh=5HrrEA7dmkFWYFA8BeGT0jiUMzSxqf9gzByGSU1GYhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HD8RQ2fM8cTMSsoxN7leICbYmd+MFFSKmAl7uBjHZGhHQkG4VZVWBYa4ApillOZxkXCwAJ98BIdF5+ryE7gyra6eMRVSRc/miFX9DKaaNFatFNWB9Bp6uXriVylfLEckkmBOFo9tLAdMAZhH1sLPiEU5eMKWDF/I3WuWwW45qeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5zGBHdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191F9C4CEDF;
	Tue, 21 Jan 2025 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737489166;
	bh=5HrrEA7dmkFWYFA8BeGT0jiUMzSxqf9gzByGSU1GYhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5zGBHdk5lZjULHflaSZfpHo6tHxOU4wXhibTesTrUn7aWYsjbfGPoQ+0JBs3zVC5
	 0Qi2DhBBKj/10nwx0Q1fk4sNAk3If/RdydhbjaSsDrpQeqEfCgBav6ESt/rEz5NKAi
	 6rZ5F2FE955KH1t6hn+K8Vo3n6Jv4DxGFwkegAVUqbekTpeY1qbpOJHb/T6VE3HFql
	 eJ6Vt0GUt/eSnCFUqnj+XJNzDT0KxtAc1knKfq+5vJwjU7p7ZhsJcG0xjdq5pnWWd0
	 KAZFVm7Okl9cJtjUJWkwebn43DUdCqUR7xP0hgg8QfsxYfIgZBsjVtK6bBXOeZlfAE
	 41W+HQ8f8ptqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] net: fix data-races around sk->sk_forward_alloc
Date: Tue, 21 Jan 2025 14:52:44 -0500
Message-Id: <20250121134847-fe71ea367df24cde@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_8BB43C35671F0A929BD6A938E8302B0DB808@qq.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 073d89808c065ac4c672c0a613a71b27a80691cb

WARNING: Author mismatch between patch and upstream commit:
Backport author: alvalan9@foxmail.com
Commit author: Wang Liang<wangliang74@huawei.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  073d89808c065 ! 1:  fbdaa519ebbda net: fix data-races around sk->sk_forward_alloc
    @@ Metadata
      ## Commit message ##
         net: fix data-races around sk->sk_forward_alloc
     
    +    commit 073d89808c065ac4c672c0a613a71b27a80691cb upstream.
    +
         Syzkaller reported this warning:
          ------------[ cut here ]------------
          WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x1c5/0x1e0
    @@ Commit message
         Signed-off-by: Wang Liang <wangliang74@huawei.com>
         Link: https://patch.msgid.link/20241107023405.889239-1-wangliang74@huawei.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Alva Lan <alvalan9@foxmail.com>
     
      ## net/dccp/ipv6.c ##
     @@ net/dccp/ipv6.c: static int dccp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
    @@ net/ipv6/tcp_ipv6.c: int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
     +	if (np->rxopt.all && sk->sk_state != TCP_LISTEN)
      		opt_skb = skb_clone_and_charge_r(skb, sk);
      
    - 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
    + 	reason = SKB_DROP_REASON_NOT_SPECIFIED;
     @@ net/ipv6/tcp_ipv6.c: int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
    - 				if (reason)
    - 					goto reset;
    - 			}
    + 		if (nsk != sk) {
    + 			if (tcp_child_process(sk, nsk, skb))
    + 				goto reset;
     -			if (opt_skb)
     -				__kfree_skb(opt_skb);
      			return 0;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

