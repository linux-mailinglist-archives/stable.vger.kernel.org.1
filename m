Return-Path: <stable+bounces-125661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF698A6A84D
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 15:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFC18868BD
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 14:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A3522258E;
	Thu, 20 Mar 2025 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hU/MsPs1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26BF21CA0E;
	Thu, 20 Mar 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480396; cv=none; b=OjcwYjYG2VDjUQHqnIpIQo0aTMc5HcORuVtXdDUtCtUej0XRN1A83Peu+ABxJ7XZYI1XhnFXkIdp6GkiOSTKyXKs1wc8AGXGFmrx6W8F5RKTTjbiSU30VdjpguSgB8/lKhBqvih5bvCkV85kpEZnaWoqrTBO32nvnRaclWYTXpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480396; c=relaxed/simple;
	bh=qyfaxEvK49XR27EAJ+fha8D6RJrKSVW9cEOBHN9smow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rDn8Y/0MC/2y2qj6J5SbNyn3wgBfMtH+hwpvLQ+vmIUOvIm8mY8M8+qw7SRQSyn2yc8k1+k703+IJCXW8zY3vY/GXyi74YbqKdJtZ8yRNcamUyCEbePSXq8jLU0dlTLBbYvDcTBFFg5g0T5xAYtgpg6JsA7PIkvvqYz9W2YagNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hU/MsPs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B62BC4CEDD;
	Thu, 20 Mar 2025 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742480396;
	bh=qyfaxEvK49XR27EAJ+fha8D6RJrKSVW9cEOBHN9smow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hU/MsPs1238cpRZqFXwzNfbraISgJ0SS/+KPvba1hyFk1p1hAus3Q3KvdFMAwDVyC
	 YrlYLOVeyvH4+pW3XGaoZ/f84UMVX5a7WZRsSi5faXjEXYKj9lzR+TFp5c4QaaIBoe
	 NxaUUB3R/YbXQ1+k7prnr9o3Oo8TNPyK34lUQJvthvt7cp934HG6T93PAq9yRQ3bgX
	 y9Bf/Q7daApE7gKdFjES+zaG+UEfVTp6mqcUHFmdWVI6ag6YD0T+p13Y9lAkWD7NhT
	 Qal7+HWP3SWxWVDsJlKYRt7tP/a2feVNHLTCgqdoc8MQ9B3j2QQKSl3mzblzBIO1KL
	 SlG66qVICCDLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0AB3806654;
	Thu, 20 Mar 2025 14:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mptcp: fix data stream corruption and missing
 sockopts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174248043234.1784312.9345758838813943465.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 14:20:32 +0000
References: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
In-Reply-To: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, fw@strlen.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, amongodin@randorisec.fr, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Mar 2025 21:11:30 +0100 you wrote:
> Here are 3 unrelated fixes for the net tree.
> 
> - Patch 1: fix data stream corruption when ending up not sending an
>   ADD_ADDR.
> 
> - Patch 2: fix missing getsockopt(IPV6_V6ONLY) support -- the set part
>   is supported.
> 
> [...]

Here is the summary with links:
  - [net,1/3] mptcp: Fix data stream corruption in the address announcement
    https://git.kernel.org/netdev/net/c/2c1f97a52cb8
  - [net,2/3] mptcp: sockopt: fix getting IPV6_V6ONLY
    (no matching commit)
  - [net,3/3] mptcp: sockopt: fix getting freebind & transparent
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



