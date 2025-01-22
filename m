Return-Path: <stable+bounces-110187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBF4A193A8
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0C91886A03
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5070D212FA9;
	Wed, 22 Jan 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/iMZXlu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E102211A3D
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555405; cv=none; b=CUD7Jcn7zDEXEPUjkkFNTEnpqk3DmeYmp8WhmKMiBWnt9DRoXletASRb5QP8HE+zPzO4I83flktxtHniZ++QgDUnlufgrCMxDzdvtZTfSgeyyrFHXDAH9BQDv9HvJ61W5Wwj0/hxV3oiP9fNtvE2nbg9wLPjeuO6i5g86oPQANU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555405; c=relaxed/simple;
	bh=od4b9q7Br+VKyB7QT5lHfpb/+sLNMcXf/70GC3RC5D4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BYB1JCv1XnxLuv/pookNSxmAX7Yw0a/IkqZiPcM/kXhyL84urk1kr9b3qY7LgUMl5mFjYZjwbwlnG3SLflC3TmgmY1LB1qsHCOYIYMYO4Mkb0iApIpr4gWqRYMphYT7H+BNtAErT/466RotbNtgWvArvQmd15UwGg1fnUUGNgio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/iMZXlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4CCC4CED2;
	Wed, 22 Jan 2025 14:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555404;
	bh=od4b9q7Br+VKyB7QT5lHfpb/+sLNMcXf/70GC3RC5D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/iMZXlulJyWQosCRLWfd1zsUgNCc9IBDef8pOcccLMYHEnihUyOp5r2pz0CLVTp7
	 2aLLkdXThOXXnlD752m3UPPc6rKYsGx/BhLmM09drl/pDmHiFEsZYHqi3vNURUu2h3
	 qTMKzuZszUtipr7sJIfzDvJk0Qsxxpgg5XrV7SoKr4Mj6hkqsVuspOhW0nUEjqyZKZ
	 htWEU64S6spOxKgst1KupPGT7NX8UXGXUL3T9B+xnxyIQTU9bVxiU/jGOqqbBonN6d
	 NF+b9BpSCGUYU36dZiO5RP1R7MUQkmNQnaL4MRKZ3RUXQSp3gfSVGLqo5fzjgXe/D2
	 z3QBBiDlJTgFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y v2] net: fix data-races around sk->sk_forward_alloc
Date: Wed, 22 Jan 2025 09:16:42 -0500
Message-Id: <20250122083706-1913b97462cb8ee8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_CBAD5F0DF387BE24BC3518CE3A4C56833D06@qq.com>
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
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  073d89808c065 ! 1:  524df761055b8 net: fix data-races around sk->sk_forward_alloc
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
| stable/linux-6.1.y        |  Success    |  Success   |

