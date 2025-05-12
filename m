Return-Path: <stable+bounces-143811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F4CAB41C5
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A6A3AE352
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA429A9E7;
	Mon, 12 May 2025 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBKzVLPT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C129A9DC
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073083; cv=none; b=tGffmScwFilylJoVdWTbNZzIHcA0K5ST7tIC1lkIf6CJ6vHF1tyu9Ut3x9hLTlytThYzU6tUreYVEEuFI8rAqhqgcbEcjGq2Lm3Eb/KdkYYjrMkfMKa1WbwZMA3Vhk6sLv+LRd7OYDUKvfZtU0cuR2/b6Kuu/b7olZ5k3Rp6QBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073083; c=relaxed/simple;
	bh=jIpa8khaCzD0Obxxl3ceg51ebS1GXqsHB0EH7Nq0+Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9QuuGHBlzeOKCI7c6+ajHtcbBUNCEc/S/wTtzYBZ3TYorR9L6cCSqeAeh9fh1v6b9N+mxoxqiHynQH5vY8uuwgKHXRxfIFjedFrJqP6MoYFKJcInM09p8mK6kjvXGYjl1SooYc9qbFPLWNyoVpJbSa78urZrgidskR4u3Cd8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBKzVLPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1D6C4CEE9;
	Mon, 12 May 2025 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073082;
	bh=jIpa8khaCzD0Obxxl3ceg51ebS1GXqsHB0EH7Nq0+Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBKzVLPTjWqR4lbgbOzpl9KM12C8iIld4TDk19HIFIVRIyATUXJ+5ENmZ/TJQ3RcT
	 bDFBSMc6eYPDMIiVmeY4Spppk7LHQv+swqJsqpNfvHND6ko0cvWNxRyEvHXysgHIKX
	 P4LZRxMwRLtd5SyXHIy2ze6cSu4u0Zpg/UqygNxYm+1SkPv+J3ZPtnMpKr5hCHGA2L
	 o/GnHCMojxdQIzuaNbkQ3+2B1YbX5sVBVtDk7TyfbVrcYIcD5U5drw4M/JK6gpFZHg
	 eH+MZtNT7R5AGObCMqLUdtuMHWJKoWg00fGfh0IiTzk2+UMJtnEn9kuecluF+LJymr
	 GHB6AoVo3YF9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket
Date: Mon, 12 May 2025 14:04:38 -0400
Message-Id: <20250511223602-f5027c20e6177021@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509093828.3243368-1-jianqi.ren.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 3f23f96528e8fcf8619895c4c916c52653892ec1

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Liu Jian<liujian56@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 61c0a5eac968)
6.6.y | Present (different SHA1: 0ca87e506375)

Note: The patch differs from the upstream commit:
---
1:  3f23f96528e8f ! 1:  96f83a102636d sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket
    @@ Metadata
      ## Commit message ##
         sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket
     
    +    [ Upstream commit 3f23f96528e8fcf8619895c4c916c52653892ec1 ]
    +
         BUG: KASAN: slab-use-after-free in tcp_write_timer_handler+0x156/0x3e0
         Read of size 1 at addr ffff888111f322cd by task swapper/0/0
     
    @@ Commit message
         Acked-by: Jeff Layton <jlayton@kernel.org>
         Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
    +    [Routine __netns_tracker_free() is not supported in 6.1 and so using
    +    netns_tracker_free() instead.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## net/sunrpc/svcsock.c ##
     @@ net/sunrpc/svcsock.c: static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
      	newlen = error;
      
      	if (protocol == IPPROTO_TCP) {
    -+		__netns_tracker_free(net, &sock->sk->ns_tracker, false);
    ++		netns_tracker_free(net, &sock->sk->ns_tracker);
     +		sock->sk->sk_net_refcnt = 1;
     +		get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
     +		sock_inuse_add(net, 1);
    @@ net/sunrpc/xprtsock.c: static struct socket *xs_create_sock(struct rpc_xprt *xpr
      	}
      
     +	if (protocol == IPPROTO_TCP) {
    -+		__netns_tracker_free(xprt->xprt_net, &sock->sk->ns_tracker, false);
    ++		netns_tracker_free(xprt->xprt_net, &sock->sk->ns_tracker);
     +		sock->sk->sk_net_refcnt = 1;
     +		get_net_track(xprt->xprt_net, &sock->sk->ns_tracker, GFP_KERNEL);
     +		sock_inuse_add(xprt->xprt_net, 1);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

