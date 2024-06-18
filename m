Return-Path: <stable+bounces-52627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC9590C110
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 03:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036BD1F2281B
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAAFD299;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNQ6Rxcl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AED4C6D;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673029; cv=none; b=le0+ccmc1t9GPYgx0ZlyMQF0nDPxic4c3Ut9f2vRzI4+ptSZ0GLGebKYsZfmvpyZ8M2G3h624ztSamvL1FHMMDVuUh/tIeULFHidSKblXDQw5qZtvne6+s8uZO3QPtxJovHmOCwBN8Bf1XvAoY4ZYKXfVOIA0g7vZv+Ubg/nYNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673029; c=relaxed/simple;
	bh=Gkrg2euPHk6tTew+ykNVlf6+kPA8M8S71wjxHLHU9Jo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lRHtLvLzTT6t6L/WsZ/Vt5XySyyPJMZBjz5fI90a1hu0Lxfd2RbDDC9jU+29KElkbbBYwbSQP10iCdmRfqMtDfMciDS4h+q0BL5O7g7kIEx7OCfPWklNIVILkMCEGifdiXnZK/+O2F9U1/PM4aSjJRNRrexzpyMv4rMDZntZw6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNQ6Rxcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28E4DC4AF48;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718673029;
	bh=Gkrg2euPHk6tTew+ykNVlf6+kPA8M8S71wjxHLHU9Jo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jNQ6Rxcl8bRsAjbcUpUGF1eJu+xEvELDqhac9ykU+V5HHzJ0fhGc33DzdlWYXZ+W4
	 YdntZRON6VpB8i0mjuFkJHISTH6ZKCtXEO1fq++8yo3nT97hN6rc8Fc+KdGEHFBKLT
	 Hm5rezp53/01yhQG8MFz2Jz5YWMFKZOiW1mAhWHYUAHNY2slX8eCc8s/LYKjaWPkTd
	 k8IiQqY+igz6SSpEcizLCXxOSigaIKm8a2+U3jWF57X6I9nIWELk23v4IxbGbWwqku
	 uTkGt4c+Ut/uiJBeZxHUcWD8bQNw3Lzjq0v1B/2QmK/0q5rn4jCCLhnDIWBYNRll4H
	 ROpTkdCloKYtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1798CD2D0FC;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: clear tp->retrans_stamp in tcp_rcv_fastopen_synack()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171867302909.10892.3043137715389304711.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 01:10:29 +0000
References: <20240614130615.396837-1-edumazet@google.com>
In-Reply-To: <20240614130615.396837-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, stable@vger.kernel.org,
 ncardwell@google.com, ycheng@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Jun 2024 13:06:15 +0000 you wrote:
> Some applications were reporting ETIMEDOUT errors on apparently
> good looking flows, according to packet dumps.
> 
> We were able to root cause the issue to an accidental setting
> of tp->retrans_stamp in the following scenario:
> 
> - client sends TFO SYN with data.
> - server has TFO disabled, ACKs only SYN but not payload.
> - client receives SYNACK covering only SYN.
> - tcp_ack() eats SYN and sets tp->retrans_stamp to 0.
> - tcp_rcv_fastopen_synack() calls tcp_xmit_retransmit_queue()
>   to retransmit TFO payload w/o SYN, sets tp->retrans_stamp to "now",
>   but we are not in any loss recovery state.
> - TFO payload is ACKed.
> - we are not in any loss recovery state, and don't see any dupacks,
>   so we don't get to any code path that clears tp->retrans_stamp.
> - tp->retrans_stamp stays non-zero for the lifetime of the connection.
> - after first RTO, tcp_clamp_rto_to_user_timeout() clamps second RTO
>   to 1 jiffy due to bogus tp->retrans_stamp.
> - on clamped RTO with non-zero icsk_retransmits, retransmits_timed_out()
>   sets start_ts from tp->retrans_stamp from TFO payload retransmit
>   hours/days ago, and computes bogus long elapsed time for loss recovery,
>   and suffers ETIMEDOUT early.
> 
> [...]

Here is the summary with links:
  - [net] tcp: clear tp->retrans_stamp in tcp_rcv_fastopen_synack()
    https://git.kernel.org/netdev/net/c/9e046bb111f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



