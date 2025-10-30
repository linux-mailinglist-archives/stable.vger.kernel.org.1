Return-Path: <stable+bounces-191685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8C3C1DF2E
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 01:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59351189C15A
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 00:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1339217736;
	Thu, 30 Oct 2025 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrmHzZXQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C831DFE22;
	Thu, 30 Oct 2025 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761785437; cv=none; b=bqgmXA9hcXnH8cRoHX4TN9hweWxArqxz2G6CkPLV5v0izghbIMqVi993ysqpXIm5G7oyTxSmmad6pxAI5JtYUN65C3BOi4rpmxT98y4RMhh8kMiXzQobWKlW+A4a16P/vD7cXs9w+m1/oc/2wbX0ZBeMWfCcVT5OpPwszsw7sPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761785437; c=relaxed/simple;
	bh=rwklOEhfhseBN3E2F6NaYZ5LgLD/6L82+Kn3SnZTv2c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BagZ0d2jE5J9qQ+mNpeYmKtzLpHejdEx8sSVt91ZsXnzMUQJDkPSdPKN4mgl0I9pF1JFGGoWlebMlELwOfTL2utg+AmvfnVrslg/OKTZkc98rJeu3ajUoNpEczL1YQtheUjDp8/GSZiKW/CqIhOYootklkdIsq1sUgRa7Axl2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrmHzZXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8C7C4CEF7;
	Thu, 30 Oct 2025 00:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761785437;
	bh=rwklOEhfhseBN3E2F6NaYZ5LgLD/6L82+Kn3SnZTv2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QrmHzZXQbsr4dhTdPGq0Bl16TuR6x8A4SB11p4iKGHUmSLQF7uKIBuf7mDl5l/ykP
	 G69J7veZIYcjxy9a3GPNyuDYeEVEl3AD5bJ5jqpl/WdxCp9uwJ5JitFtEoiKu7wVQc
	 kXSrvsNIrGWRcEeCm1RoNGZ0/xzvoQ0Tf6ZR+U3f9lBe7ba+7FPznRmS2r0ULPIT4p
	 +F1BrUG8tDsuega56VcnbId9r8OAtO+GpmjJOlzs5hIyTmVoDftasTdcF85xpP15yT
	 +bRYxXScPm8NGeWITRLQI0NML083O4muBewntkq9xdyVO8lHtvzZJ2/Y0J0FooOls6
	 2QUZjRISTJ/DQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BD63A55EC7;
	Thu, 30 Oct 2025 00:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mptcp: various rare sending issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178541400.3267234.15224717503854756848.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 00:50:14 +0000
References: <20251028-net-mptcp-send-timeout-v1-0-38ffff5a9ec8@kernel.org>
In-Reply-To: <20251028-net-mptcp-send-timeout-v1-0-38ffff5a9ec8@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, liyonglong@chinatelecom.cn, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Oct 2025 09:16:51 +0100 you wrote:
> Here are various fixes from Paolo, addressing very occasional issues on
> the sending side:
> 
> - Patch 1: drop an optimisation that could lead to timeout in case of
>   race conditions. A fix for up to v5.11.
> 
> - Patch 2: fix stream corruption under very specific conditions. A fix
>   for up to v5.13.
> 
> [...]

Here is the summary with links:
  - [net,1/4] mptcp: drop bogus optimization in __mptcp_check_push()
    https://git.kernel.org/netdev/net/c/27b0e701d387
  - [net,2/4] mptcp: fix MSG_PEEK stream corruption
    https://git.kernel.org/netdev/net/c/8e04ce45a8db
  - [net,3/4] mptcp: restore window probe
    https://git.kernel.org/netdev/net/c/a824084b98d8
  - [net,4/4] mptcp: zero window probe mib
    https://git.kernel.org/netdev/net/c/fe11dfa10919

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



