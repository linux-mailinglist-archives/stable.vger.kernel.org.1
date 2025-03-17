Return-Path: <stable+bounces-124708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D5A658EF
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BE71693BB
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93555209F38;
	Mon, 17 Mar 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/10O8Tq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534A6209F30
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229608; cv=none; b=Tp9E2WECl2gjxqLWowPlXs++DQ1gHQkitb35usqja727KTazYLQasMZVxDdxKwctgGH/6emZ+F1wpU1PKfZ3MhvlZtZWjtD3UMhSpYTPGFY1vyA3z8M8GA1SV2RplmFP1FkOhdrlKJzjmeMALvrlydAcOIsgMuR87xSKwapt/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229608; c=relaxed/simple;
	bh=VbNXm7byRlQ6I+ohQzUvECMhFVOsApHVH+XmSg/FBQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jniy/VRit4tn1WiW4UtBnIkNgSycwXdws73rnfh2TOUA1+Fi55nSvrqTtUkZZ7BMgjUurn/WCjCDscdpbqU0WpMwULmI3Eobb/B2AbXI/2p9nBsBDJ+HIWerbJfItzlW/vCJcU+VQTgS7gybuBl77ExuuS/a/Ew0Tws+8sgx7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/10O8Tq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8324DC4CEE3;
	Mon, 17 Mar 2025 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229608;
	bh=VbNXm7byRlQ6I+ohQzUvECMhFVOsApHVH+XmSg/FBQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/10O8TqqEs8JR57lCS1r7c4P7vydRadnUn537s4n5lbVbN+mnbvQMhtQG+Mub9nF
	 /n79syGRLoy1n9iV5bI5lEjbOUi5EOCI1bct6LhL8cgGDLM4nN8PYSAXl6lSWtqgFv
	 hemDRaXAPBr4gxi2Ls0ixuQ7ZCbcVz6Zqs/wigIYBbubfA3wWVThcSGgaS1Y8mdBfc
	 67IX4OLe5UtEApQTIuSR7q6VKAe4It9aM/Rq6A6dWWaECQ+8PMJX/0NSsHU+782NCj
	 F4XVYSU1Fdgpjoc9/khFjB1RnQSc8ZYL552VNTlPt2780RmwvI2U8hlXcx1dY8Cmkp
	 O53NvDIH1gGGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Youngmin Nam <youngmin.nam@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 stable 6.1 1/2] tcp: fix races in tcp_abort()
Date: Mon, 17 Mar 2025 12:40:05 -0400
Message-Id: <20250317093954-8565c2c1f24aa85d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317050743.2350136-1-youngmin.nam@samsung.com>
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
6.6.y | Present (different SHA1: 943f2b2b065a)

Note: The patch differs from the upstream commit:
---
1:  5ce4645c23cf5 ! 1:  0ff51ebdcc2ec tcp: fix races in tcp_abort()
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
| stable/linux-6.1.y        |  Success    |  Success   |

