Return-Path: <stable+bounces-115096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AC7A336B4
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 05:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDD4188CAA7
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 04:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE04207A08;
	Thu, 13 Feb 2025 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqeUku5p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00BE20767E;
	Thu, 13 Feb 2025 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419814; cv=none; b=HgQ5A1WgSzizztNEoBx2YkJr27xH8uTb5AY4dZX7zgBI0YbHyDpop8xtn6FgwwYH+6Me/3yN+w3kNsZ53z/JTEAnw3HpxkQyANHjRcRY6PY6PqCkG78Hd7apRNDo99VYuzSZsIOq9ln12EQABnCb8v4qG2Y5bkr0ZEPoLZP7TLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419814; c=relaxed/simple;
	bh=MEyXal3MsfePRCxvAxdgFK11qwUtLBoJ0dkXaaBRE6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cs3EqPKKHSfo80aCVbNE+wz7zLrHhK1+tV3vcmrLa0gC4DON8KOtLRHXl8MItqP2ukeh8sXBpAt2kLH9NhyHt4k1SWRDtOE7uDWp98zBcJccfUqQu7R7acmdY995puLvEogsrjuZg3IuaUBtBIYiLxqSzrFRZuZxw9V5tHexhqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqeUku5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D93DC4CED1;
	Thu, 13 Feb 2025 04:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739419814;
	bh=MEyXal3MsfePRCxvAxdgFK11qwUtLBoJ0dkXaaBRE6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PqeUku5pp9tSCj7sjA13n7SR887NnREqN7L+n9/vJsUsm9+7KthEB5xw3LynRRpv6
	 0SDWvjl70nDyFeGLowggSMUtanPFKX6Mie+e4Sq/ThDSl4xRYeV7oW4zHkA6d6n35S
	 w68RL1EZ2NRbkBfjlDtkIMpyZHYnXduUGQaAA9Plmx4mqdX2LIp3ekftKKp5SnMY2t
	 vt7kKBZCECuiKb/re0EGJgvcOq5vn/8V6yZOyt1a4LoqL3ngF6qEPYK0I3Pq59K1sr
	 JLOxkGHMxynDYfWXSTAfB5zc0n8g4lgdebdM7U69oMogooTNBOZZSLkiHGKJ3wyh+G
	 AyQcrb7kRHzSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5E1380CEDC;
	Thu, 13 Feb 2025 04:10:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2] net: stmmac: dwmac-loongson: Set correct
 {tx,rx}_fifo_size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173941984332.756055.4356205354524855724.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 04:10:43 +0000
References: <20250210134328.2755328-1-chenhuacai@loongson.cn>
In-Reply-To: <20250210134328.2755328-1-chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: chenhuacai@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 si.yanteng@linux.dev, chris.chenfeiyang@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, horms@kernel.org,
 qiaochong@loongson.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Feb 2025 21:43:28 +0800 you wrote:
> Now for dwmac-loongson {tx,rx}_fifo_size are uninitialised, which means
> zero. This means dwmac-loongson doesn't support changing MTU because in
> stmmac_change_mtu() it requires the fifo size be no less than MTU. Thus,
> set the correct tx_fifo_size and rx_fifo_size for it (16KB multiplied by
> queue counts).
> 
> Here {tx,rx}_fifo_size is initialised with the initial value (also the
> maximum value) of {tx,rx}_queues_to_use. So it will keep as 16KB if we
> don't change the queue count, and will be larger than 16KB if we change
> (decrease) the queue count. However stmmac_change_mtu() still work well
> with current logic (MTU cannot be larger than 16KB for stmmac).
> 
> [...]

Here is the summary with links:
  - [net,V2] net: stmmac: dwmac-loongson: Set correct {tx,rx}_fifo_size
    https://git.kernel.org/netdev/net-next/c/8dbf0c755645

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



