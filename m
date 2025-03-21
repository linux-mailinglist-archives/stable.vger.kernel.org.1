Return-Path: <stable+bounces-125788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF02A6C227
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 19:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41EC07A9108
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CEA22FE0C;
	Fri, 21 Mar 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzBEiM9Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8A322FDE8;
	Fri, 21 Mar 2025 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742580599; cv=none; b=J+xwIscMS7giXQADDDz4l/WV+rj09lsbBS3XTZ1X828hQwoQkFZT92UZAqLvSbbW+2qpcgjEKryKm0rRbwWTTx9+mCOYT1blT0xVtxZ/cTCelQuebr+g1uVUPnIhHOTnksOBTUU+aMEUys3W9pXtdXMvpalu9UJpmcydNqwifRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742580599; c=relaxed/simple;
	bh=+wBfr9S9cNjj8/xFM+HmotmhdevX1l4hpYUE3G4YEOM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EsqG/a4t7B0v8xabyP15e1R5VjGIZFU8tH1e70zwfDwUEoA8hNvHktDbiU4vQ3Pj5Tuf9iQfsWkmo5Lo2oL1xPj60G67k6BcPYUvVUhHEo7kRrBHAqrUbldIY9HU9RXYhca+m9PcnUbd2BneBgJn1E0YPNKlQJtkBVvED0EqMBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzBEiM9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A85C4CEED;
	Fri, 21 Mar 2025 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742580598;
	bh=+wBfr9S9cNjj8/xFM+HmotmhdevX1l4hpYUE3G4YEOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KzBEiM9ZwGFcuvdU8Q5SycJo3tqJYbPresmAZC8RiVG/POZMUUhMRnLHk/DfzVaOJ
	 9tv6LSdry3FusqSnhQuF481sTXsSWzryzv1y0cNQ7qKNj+pkl3EcXLt3AvRYUXbchS
	 2kvvE1Xb4ccl1HYMeIP4U+DYKnkyXNnLoe3FwksjfXa8GE7PzBy/F0v6j3feuzh8vO
	 brtX3X7LP2rdoZtKVm6BXBfSndbvcabp3M2QaxaU2Y2H38cMAwUaRuaq5I6JxYEczU
	 uLTIt28raJ6hM1CLWP3e29hGQGpV6gzc/u8FDI8DjaPKWoN5fJlVg417iUlXJuX8f8
	 3J5mxQOZcphHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE163806659;
	Fri, 21 Mar 2025 18:10:35 +0000 (UTC)
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
 <174258063476.2577757.8120263638217782204.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 18:10:34 +0000
References: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
In-Reply-To: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, fw@strlen.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, amongodin@randorisec.fr, stable@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
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
    (no matching commit)
  - [net,2/3] mptcp: sockopt: fix getting IPV6_V6ONLY
    https://git.kernel.org/netdev/net-next/c/8c3963375988
  - [net,3/3] mptcp: sockopt: fix getting freebind & transparent
    https://git.kernel.org/netdev/net-next/c/e2f4ac7bab22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



