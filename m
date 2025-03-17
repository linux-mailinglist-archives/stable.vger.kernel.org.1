Return-Path: <stable+bounces-124709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A75A658F0
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231A816BD38
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD013209F58;
	Mon, 17 Mar 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvwQHLsA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FA209F33
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229610; cv=none; b=tEMWCWFOoI8xDtCtW31diH7jOYWTwi3VFM8jbYegz6wT8rIQO6y4W4Purey45WqLt3eVBXhO/FOXBCGpW0muWGpd0zXAOpIjBrgcyAYRp8JNa6ftwiZiLxTGBnufpoqqt8PbJc2gw89oeoR5SVfP9DyQMuO2vRpnyQSWNSSfSDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229610; c=relaxed/simple;
	bh=62YoOW+JU05C3iCuavQx8k1IvmJh9ffkNhy1o+Y3Nac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDfpHX6TWB9ewRxqIEQKqrOJ6h8/qDyFgOZPWdlzCqQDnU8Nex75h2Xlb9tQco+v29snRzvLRdCjdhqyi5ewueuRH6TPLBx4rue7RHETN0lotoCOi+RTkzuBF35+YGIxuV3DF26sQpZoOxa2zqUPCkMLenBjW8w0e7AXOL/FC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvwQHLsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E910AC4CEF0;
	Mon, 17 Mar 2025 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229610;
	bh=62YoOW+JU05C3iCuavQx8k1IvmJh9ffkNhy1o+Y3Nac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvwQHLsA6+C2CrUUyMd75sezWH0mSNl1gYZPdgtnmyTB/pNr/JbMQvml1KyDHDYEj
	 QFdOFjMT1C9/tg7s4YLkgcqAILiPyJcpdKSebDz/NyYXIerYBbd8LqRE2qm1rmkA8+
	 fCkuWZkVn0y3vI3BOkGUZeWqoCbjAQLy60QQxFlZaTZHRPawZfejbWKtzyM7e3vufL
	 atZZZU1iRP+kmZRqDfuQGc/SYcXUnU8fMvGaujLJ8unS2UDOVgj74uu/ToAkTFxTaT
	 QIqBJKmFEVcTkfXkIYNB457xOcCthseGrb17pfdHTgamCvgfPh/LhxZF6C/qZtv1EC
	 XVsiBXYPZoaSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Youngmin Nam <youngmin.nam@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 stable 5.15 2/2] tcp: fix forever orphan socket caused by tcp_abort
Date: Mon, 17 Mar 2025 12:40:08 -0400
Message-Id: <20250317092209-2217d4aa9ea3ad7e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317050950.2351143-2-youngmin.nam@samsung.com>
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
6.6.y | Present (different SHA1: 93c4706e7dd0)
6.1.y | Present (different SHA1: 8b20f4507d48)

Note: The patch differs from the upstream commit:
---
1:  bac76cf89816b ! 1:  447939338b010 tcp: fix forever orphan socket caused by tcp_abort
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
| stable/linux-5.15.y       |  Success    |  Success   |

