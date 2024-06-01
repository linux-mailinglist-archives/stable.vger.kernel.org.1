Return-Path: <stable+bounces-47829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589228D72C8
	for <lists+stable@lfdr.de>; Sun,  2 Jun 2024 01:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897FD1C20AFE
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 23:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB29E4CDF9;
	Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqr40Vsu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D942D03B;
	Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717285232; cv=none; b=du3l1mcoMgcTpLfW5yCs9Jg+XHJNnaGMDnqMTioS19UqqbcssGMBWRsKk98Im7MJeG//SeRrPPmw9oLKgr1QK0gfJYkEG45H/6CVRsEClwTOmKb1pSm4Oc/Xa+cABVP8zEmEzVTDze+DLoCXHCm7bGOxvg8Wh20RUj27Wk0o4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717285232; c=relaxed/simple;
	bh=SzK6SnnCtN4uWivormsbmB5kh1qb8znJq7rVIGk3xcA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mnTkfH5hv6q9Vs8z3SprXtc9cX438uf7jvElc3RA1HfXbwWwX2S1UgUwxgLX46k9YbtWOCkykTDs0k6zsB/43EquIgsVzFmEOFeNDugItfgnFcBcBosjMgAhuK4g8d3CZkqNogZXNvpaqsDkuEhfwwCVaFDduVK3qQ8K3AG9Lco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqr40Vsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47453C32786;
	Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717285232;
	bh=SzK6SnnCtN4uWivormsbmB5kh1qb8znJq7rVIGk3xcA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lqr40Vsu3FmNJWSHy0ytDZeOQdjHpl2KEAbZl5E9Y/ifkF3BFUcVJlLw2e2aPW4r0
	 c1vJM7I5AzRPywFh9Hw5Y46YWcudX4roBcxBtF25vkv+3lvp9L1ITmWml3RN7OY0tL
	 OLVCpKhmPqk4e5k8Az0/jwXhUQV6fpitefVlR5Nh87uOtrctuE0l+ij3L00nt9zAqO
	 80ZfYeDg8H3ztwkD07ay/9j0W0H9EgCUL3djABQpCwMyfZL6wwgwLj6OqRYEP1OZAk
	 u96F0VzxTsuFte8nDmVKLRVE3KL/D8I2C8GrWo6+1bdnTSnzxYSczK3UpwQIWDIu0f
	 3N6TwZUwlk9QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37586DEA715;
	Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/tcp: Don't consider TCP_CLOSE in
 TCP_AO_ESTABLISHED
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728523222.22535.13972880486024891915.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 23:40:32 +0000
References: <20240529-tcp_ao-sk_state-v1-1-d69b5d323c52@gmail.com>
In-Reply-To: <20240529-tcp_ao-sk_state-v1-1-d69b5d323c52@gmail.com>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 0x7f454c46@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 18:29:32 +0100 you wrote:
> From: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> TCP_CLOSE may or may not have current/rnext keys and should not be
> considered "established". The fast-path for TCP_CLOSE is
> SKB_DROP_REASON_TCP_CLOSE. This is what tcp_rcv_state_process() does
> anyways. Add an early drop path to not spend any time verifying
> segment signatures for sockets in TCP_CLOSE state.
> 
> [...]

Here is the summary with links:
  - [net] net/tcp: Don't consider TCP_CLOSE in TCP_AO_ESTABLISHED
    https://git.kernel.org/netdev/net/c/33700a0c9b56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



