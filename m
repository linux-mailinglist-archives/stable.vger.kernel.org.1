Return-Path: <stable+bounces-124719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DECA65914
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC843B1BED
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B081E1E15;
	Mon, 17 Mar 2025 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzcG2xcp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B501A9B40
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229626; cv=none; b=qw1eG4vT0i1DbZsarqFOydU+k07mi2YYj6lY4/AZrHoOfzYqCn59GF9mF+xUmtBBL+B6AUNOx12EJkbVJgQSBRm6VeFyurViPjLvCAQXlUBSlRVe3929ZBcZmHhQgHgjgY+11JFgdEmRNoOlL1w5IvS4RDXIvEb4REFAF14P0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229626; c=relaxed/simple;
	bh=aCI44sxMYBsAdP1/Xi12Oy/+N4cI3HD6ZzehbpjqqbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJBRztwQgEyIKLFnOiTcp0jeY5lp67tvAAtw7hjSvJKYlPDXs+GlKS8dkcWwxZXt1w+a+eC03cVpIVJ6A+CXOqt2MffjeLDokDeGP7Lg6rU8Rmay0H9ocnKH3y3P6gzS4ycT4scbDky6yaeLPjXoU/3tbYpcVNO3pMFUMB20qrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzcG2xcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E62C4CEE3;
	Mon, 17 Mar 2025 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229625;
	bh=aCI44sxMYBsAdP1/Xi12Oy/+N4cI3HD6ZzehbpjqqbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzcG2xcp4sg1ZzyPSLt46rCzujWvx37YhwFlAlXPhIwScICEhR7mj4zI++49DEcM3
	 bHID6vIfyI8oMu/OUS56llT93o/rbyuQSn9dhjAi7WRW1bL/eEfqX3GdkuBhY6M+ZQ
	 8EpCLwLDqHPvxphAH9po9alVLmpjp388GPaZFDuMohZLcyFyP+liVmoAlP8W3SEZ+0
	 D4lkyZGHo4UhzGgND0RMuhskDWzKQAtSFpF9MQEjVlXkYV4yUReig21WUe1kHwMpkr
	 cDQARh8l9ifc6nWHN/qcrQHZ/tZRybkmXs4Ub7q51+aKEKBgYjN5EgKNRIKBjfW8iB
	 JAFjWYcBUJvCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Youngmin Nam <youngmin.nam@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 stable 5.15 1/2] tcp: fix races in tcp_abort()
Date: Mon, 17 Mar 2025 12:40:23 -0400
Message-Id: <20250317091759-d3727de93804b1ee@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317050950.2351143-1-youngmin.nam@samsung.com>
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

The upstream commit SHA1 provided is correct: 5ce4645c23cf5f048eb8e9ce49e514bababdee85

WARNING: Author mismatch between patch and upstream commit:
Backport author: Youngmin Nam<youngmin.nam@samsung.com>
Commit author: Eric Dumazet<edumazet@google.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: aa5229129a55)
6.1.y | Present (different SHA1: a1146efaea31)

Note: The patch differs from the upstream commit:
---
1:  5ce4645c23cf5 ! 1:  2295e520401c3 tcp: fix races in tcp_abort()
    @@ Commit message
         tcp_abort() has the same issue than the one fixed in the prior patch
         in tcp_write_err().
     
    +    commit 5ce4645c23cf5f048eb8e9ce49e514bababdee85 upstream.
    +
    +    To apply commit bac76cf89816bff06c4ec2f3df97dc34e150a1c4,
    +    this patch must be applied first.
    +
         In order to get consistent results from tcp_poll(), we must call
         sk_error_report() after tcp_done().
     
    @@ Commit message
         Acked-by: Neal Cardwell <ncardwell@google.com>
         Link: https://lore.kernel.org/r/20240528125253.1966136-4-edumazet@google.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Cc: <stable@vger.kernel.org>
    +    [youngmin: Resolved minor conflict in net/ipv4/tcp.c]
    +    Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
     
      ## net/ipv4/tcp.c ##
     @@ net/ipv4/tcp.c: int tcp_abort(struct sock *sk, int err)
    @@ net/ipv4/tcp.c: int tcp_abort(struct sock *sk, int err)
     -		smp_wmb();
     -		sk_error_report(sk);
      		if (tcp_need_reset(sk->sk_state))
    - 			tcp_send_active_reset(sk, GFP_ATOMIC,
    - 					      SK_RST_REASON_NOT_SPECIFIED);
    + 			tcp_send_active_reset(sk, GFP_ATOMIC);
     -		tcp_done(sk);
     +		tcp_done_with_error(sk, err);
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

