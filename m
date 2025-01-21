Return-Path: <stable+bounces-110059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD6AA185D8
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7034E162F57
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B5B1F5436;
	Tue, 21 Jan 2025 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hudbf4Qn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AAE1F5433
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737489172; cv=none; b=IS1jqSOZbim7BrNnsPkHNqzqXfxRMIW33yXnH8bbmzR+beG0OotS/DPRi42odjClkDsTrW9LCL4HiWrAcyI9bhckqMRet/yqbZAopmU+hHF9pu6DhlWWWpX6VS1NBWJRM9D+BWR6Vz9t/pdA6i+Pp8OJaz/QXegA3DBChXNwcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737489172; c=relaxed/simple;
	bh=G18Ln/qgEaFBesZVL9XEnbufq9Kz3goYOIlMO/CY5hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RdyuVXwiKH3YpV1aNaXdouAc69rRlK4/tF7QV7C5a/5GJD3346R53f92ITa4BzHuXbQq75d+dO/iI6JsDR8pxoW9Rd35CqI8LRtWyDeQD8+B2F2IHInlu+r0MoGDa5nIkxRzMDdJAKOLAivJnK6gQP+6SjFVjhFTAUu68Ck/tFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hudbf4Qn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0BBC4CEDF;
	Tue, 21 Jan 2025 19:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737489172;
	bh=G18Ln/qgEaFBesZVL9XEnbufq9Kz3goYOIlMO/CY5hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hudbf4QnpL92WytsYk0Sqvan6bYk7CvaMddE75AwJCC31xMGSYGu1RUHnXtJu0+TT
	 4MbIzSZnm7ULu6u6NK9Ay0UE547oU9IXUQHsOn51dw/3bsh5HbAeL3eGIqm/0nH5va
	 K3oLS63rhlSNphXd71FDMSLLuN9tB07wX4pdeZLaFCbAqKIeQSofvAHWkhcqEbzylF
	 NCwG7v034K6YdzwNhLelYGjDcHmvt0aKHhAfYOZDbMfSxNb9gyBS0Wihfjjt0UlgoG
	 kLOU5j5Vz0Ct/iRrni/bqXWSQVFC7wkWIbzEt6vKU4HNYO4vgMXvF3QHAcJaymcc/k
	 LfA1iIOdCVHfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net: fix data-races around sk->sk_forward_alloc
Date: Tue, 21 Jan 2025 14:52:50 -0500
Message-Id: <20250121123241-c06de38a4a82f3bc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_D660CC1BB869156A7C3EBA24B5ACF371BA09@qq.com>
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
1:  073d89808c065 ! 1:  a092fa4cc331a net: fix data-races around sk->sk_forward_alloc
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

