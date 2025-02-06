Return-Path: <stable+bounces-114020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59753A29EAA
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 03:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563EC1888FD6
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 02:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3459126C16;
	Thu,  6 Feb 2025 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuLaYuvV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893062E62B;
	Thu,  6 Feb 2025 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808405; cv=none; b=D3ONayPf7LEcqvs9Bq9XLxjqnQj6r+3vLq/Knw+IJ2r1NUet4Hel+uf/VdQ9ew5r/Bhs7T9xQ3JW6rBJddI3nDQFiqw8KcLr3gFU1Fspi1WlS5OyWEeycQ/hGYd58uoEFUKGFaO8qiir9gG46nqVswdb7Y/qq55JdFvESisNIfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808405; c=relaxed/simple;
	bh=oHSSIC5E6hzcwmxupX44t54z1KpOd5ZqlBP1+ll/XwU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DjvfEhRImaSzWERAbBuQoMt0mpX10RhGwkftJSLViJhtm11Bb7s2kP0d+n9vseFCEfoZ8iKtgtoZEAi7YpqiU7uUzLqD5qCb0Q7oT3+ae2yeYm4LUswuXl0JcM5On/7QudJn+qLGozbJg9Cx1GdXQE12syQMwfdebF8kpvmIZ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuLaYuvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DE2C4CED1;
	Thu,  6 Feb 2025 02:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738808404;
	bh=oHSSIC5E6hzcwmxupX44t54z1KpOd5ZqlBP1+ll/XwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RuLaYuvV7nEVrtDqSIwidq4MXaSGOW12xBIIZCmJP5+141K8m5sc3iB2EwE8EMho2
	 Rx6+2RQTBW1TQ1p8hI9v3M157OeOs1BPHX1o38UguND3o4JzEYxMQ8eJf6r99lFIwM
	 216vXoTwEiUix03H2qSNECCtI9LgycOu25/U8CRclSRTswlYyzGGW6GClrq7Dn2KqQ
	 IVwP63GHMAOZ0srzpDiRtYkItx63kFyd7fJ++ytm2JGsCvWzL/CmU/fEeqXgY0oSE8
	 6+LllxtjCVo/42QqXamMd/k8aAFK6iQZ4wWEvQRSqQXtskwFgeY4GhtaQS6gjM/IIT
	 ZggF4ttW28x7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1A8380AAD0;
	Thu,  6 Feb 2025 02:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: mptcp: connect: -f: no reconnect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173880843253.974883.18192366892501704782.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 02:20:32 +0000
References: <20250204-net-mptcp-sft-conn-f-v1-1-6b470c72fffa@kernel.org>
In-Reply-To: <20250204-net-mptcp-sft-conn-f-v1-1-6b470c72fffa@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 04 Feb 2025 23:19:53 +0100 you wrote:
> The '-f' parameter is there to force the kernel to emit MPTCP FASTCLOSE
> by closing the connection with unread bytes in the receive queue.
> 
> The xdisconnect() helper was used to stop the connection, but it does
> more than that: it will shut it down, then wait before reconnecting to
> the same address. This causes the mptcp_join's "fastclose test" to fail
> all the time.
> 
> [...]

Here is the summary with links:
  - [net] selftests: mptcp: connect: -f: no reconnect
    https://git.kernel.org/netdev/net/c/5368a67307b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



