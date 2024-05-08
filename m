Return-Path: <stable+bounces-43437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24D48BF3AD
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 02:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8266F283641
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 00:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF3A65F;
	Wed,  8 May 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSHNcXaA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1938F;
	Wed,  8 May 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715128232; cv=none; b=km6isFrY/wYrtJ+XOZwCmBufx54S38A92mXGFM29KQBijhNoYe7G2LTvEppfJe0ydP1ZQ+yUS+mX/5hhcppXsG/ApDZEQvco6dR/1/p0RJCMItGC7RWDUOfq1XZR917c8j1S872S2+Mw9NmxFC3IhqslBSD8ZyAC8z2bQYnwFHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715128232; c=relaxed/simple;
	bh=k8BXEudDpHpt0/brJcoInDKI3eTW/lQczY+pbYkA2zk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pr0reizOqhoA9cRbpZQKX/jf3Yy9Jq070C2FNCcxCZewE5eA3jIHmhK/bmuN0oMl5DXevAgcie1AKwXnHTpQSi6mtYfXESsmQ2kZPj3wzVI5lfc60SScIFkEP5zwgEeGP1LAJRYzb4kwMt8fKvhi1gnu1H4t1biWqY7UyLUjFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSHNcXaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CBF9C4DDE2;
	Wed,  8 May 2024 00:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715128232;
	bh=k8BXEudDpHpt0/brJcoInDKI3eTW/lQczY+pbYkA2zk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TSHNcXaACur+/GZluQlXnpU37/1vNA02m//LEL3qN6PZwVJ+G6qHAOvVzI+QnkSu0
	 O6CVpM3CjqCug/QPjwLHx270KlootJ5FaX79HisWEeDjyh5CVESORjdI9gnrbl4ipv
	 5BDs5+3OFpphJNOm3Ce0geLeL4hweXCkbDDbNcCHp/Jt2lwO78HiXcX7sKRhc/OXrH
	 PBkTVj9xN/4d8uTmltaOUakjQbe/ir1Dr18xk03gSD79dkCCRlTbfWwXZ+V66reLSz
	 hRKKQPCzpw7HhF/Jdcdi4K/fR6LdSWnPyV9xjwI8OX7PoD85A05iYOZ2uPVv9yi56m
	 5282eDtZID+rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20C0EC43617;
	Wed,  8 May 2024 00:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: only allow set existing scheduler for
 net.mptcp.scheduler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171512823213.17947.12733712609638814177.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 00:30:32 +0000
References: <20240506-upstream-net-20240506-mptcp-sched-exist-v1-1-2ed1529e521e@kernel.org>
In-Reply-To: <20240506-upstream-net-20240506-mptcp-sched-exist-v1-1-2ed1529e521e@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregory.detal@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 06 May 2024 17:35:28 +0200 you wrote:
> From: Gregory Detal <gregory.detal@gmail.com>
> 
> The current behavior is to accept any strings as inputs, this results in
> an inconsistent result where an unexisting scheduler can be set:
> 
>   # sysctl -w net.mptcp.scheduler=notdefault
>   net.mptcp.scheduler = notdefault
> 
> [...]

Here is the summary with links:
  - [net] mptcp: only allow set existing scheduler for net.mptcp.scheduler
    https://git.kernel.org/netdev/net/c/6963c508fd7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



