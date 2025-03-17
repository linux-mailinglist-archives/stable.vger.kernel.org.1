Return-Path: <stable+bounces-124702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5577EA658F4
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708F019A29EA
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE33C209669;
	Mon, 17 Mar 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9wGRTqS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE1420899C
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229597; cv=none; b=UfUCAdTi8mmHDK5jArDa0TZv0SK6dgMHMhekv37Qxmq3nnXTGm37T9aR1nwsXG3ozO2vaqNGnM2sfYCniGQ5J+eQfgLTYWFRZowpm+s0H97+bDjYJAOijdOTOnCOGHse6KZVJ1EQf0X+W+cVhU8Z8LLC1Tr7q5nSfHcBaxENxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229597; c=relaxed/simple;
	bh=tg7J99G1kCj1emgdFrtQgDQZxE0HRwJ7z2qlDsNZLz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMHsv8jwYeae+/gMo1rCDkVbdqSI1rRyLdq9uhPGykhYaW15HSp9qGGu10Dff4VGZcA7zmlOQcER2arjaqFiZtZ/VwHcpySD2o5V0s4L26wEBbgE2Ud0pPU+XbvqmJ7A60+EvXiPL4N8a5dHatCtbpmsAwae0u0EF7V/Xk0iCeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9wGRTqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D30C4CEE3;
	Mon, 17 Mar 2025 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229596;
	bh=tg7J99G1kCj1emgdFrtQgDQZxE0HRwJ7z2qlDsNZLz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g9wGRTqS/EwjYZq597GFGDpA3MR7tgzMUBmK0FIs0PHA95AoDyIFpfJSx/FDKZV0G
	 MBj7pDAMsAqq+/OU5nybE9RsBpvKuNRpNIxm7d4Abvz6Q6DyZj8ItcLYgmzPMixzaX
	 Llbo12PFfltRh0iBxTmOvdTF56c/aaxIrj9ia7VlHPcVJNokVXw/3dOGLGItGvuCgS
	 wvllLWtu867cjRMFBGNyc3MwOScfAkwFuaYljVQo9kMIgU0MYZc2IkkhXuEu43oub/
	 +Oe0/ahadejXfbFkSxEGWjUkZJ/AT+mi/i7ZzeYlL8jG/ZLT7BbK/wPRIUAz3Cn/2U
	 ptRoOfY0mEuhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Youngmin Nam <youngmin.nam@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 stable 6.1 2/2] tcp: fix forever orphan socket caused by tcp_abort
Date: Mon, 17 Mar 2025 12:39:55 -0400
Message-Id: <20250317094405-4a6c39988d12761a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317050743.2350136-2-youngmin.nam@samsung.com>
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

The upstream commit SHA1 provided is correct: bac76cf89816bff06c4ec2f3df97dc34e150a1c4

WARNING: Author mismatch between patch and upstream commit:
Backport author: Youngmin Nam<youngmin.nam@samsung.com>
Commit author: Xueming Feng<kuro@kuroa.me>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: ad383d4732d3)

Note: The patch differs from the upstream commit:
---
1:  bac76cf89816b ! 1:  f3878294629fd tcp: fix forever orphan socket caused by tcp_abort
    @@ Metadata
      ## Commit message ##
         tcp: fix forever orphan socket caused by tcp_abort
     
    +    commit bac76cf89816bff06c4ec2f3df97dc34e150a1c4 upstream.
    +
         We have some problem closing zero-window fin-wait-1 tcp sockets in our
         environment. This patch come from the investigation.
     
    @@ Commit message
         Reviewed-by: Eric Dumazet <edumazet@google.com>
         Link: https://patch.msgid.link/20240826102327.1461482-1-kuro@kuroa.me
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Cc: <stable@vger.kernel.org>
    +    Link: https://lore.kernel.org/lkml/Z9OZS%2Fhc+v5og6%2FU@perf/
    +    [youngmin: Resolved minor conflict in net/ipv4/tcp.c]
    +    Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
     
      ## net/ipv4/tcp.c ##
     @@ net/ipv4/tcp.c: int tcp_abort(struct sock *sk, int err)
    - 		/* Don't race with userspace socket closes such as tcp_close. */
    - 		lock_sock(sk);
    + 	/* Don't race with userspace socket closes such as tcp_close. */
    + 	lock_sock(sk);
      
     +	/* Avoid closing the same socket twice. */
     +	if (sk->sk_state == TCP_CLOSE) {
    -+		if (!has_current_bpf_ctx())
    -+			release_sock(sk);
    ++		release_sock(sk);
     +		return -ENOENT;
     +	}
     +
    @@ net/ipv4/tcp.c: int tcp_abort(struct sock *sk, int err)
      
     -	if (!sock_flag(sk, SOCK_DEAD)) {
     -		if (tcp_need_reset(sk->sk_state))
    --			tcp_send_active_reset(sk, GFP_ATOMIC,
    --					      SK_RST_REASON_NOT_SPECIFIED);
    +-			tcp_send_active_reset(sk, GFP_ATOMIC);
     -		tcp_done_with_error(sk, err);
     -	}
     +	if (tcp_need_reset(sk->sk_state))
    -+		tcp_send_active_reset(sk, GFP_ATOMIC,
    -+				      SK_RST_REASON_NOT_SPECIFIED);
    ++		tcp_send_active_reset(sk, GFP_ATOMIC);
     +	tcp_done_with_error(sk, err);
      
      	bh_unlock_sock(sk);
      	local_bh_enable();
     -	tcp_write_queue_purge(sk);
    - 	if (!has_current_bpf_ctx())
    - 		release_sock(sk);
    + 	release_sock(sk);
      	return 0;
    + }
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

