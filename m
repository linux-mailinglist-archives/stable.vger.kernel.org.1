Return-Path: <stable+bounces-125962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D988A6E2AF
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 19:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B653B357F
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 18:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7925266EFF;
	Mon, 24 Mar 2025 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tibyIlAm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5563D1FCFDC;
	Mon, 24 Mar 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842196; cv=none; b=t/P6hZQPOxYFuK6kXbK7K8OpdDQ5xiRHj2Y6g7m1EOt4cZxTbs08Qvcl9NpdredaR5aKUk+R987Sb2jw6eF8DMfaesmLIC2fna9gPJgSGeuVIy5eyoF+EWGNAJWtMpiKWN4FUhIVQyiW7obXFfD3sFwBz4c5xfBtYKRbPENxX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842196; c=relaxed/simple;
	bh=5mJQMRQsVibHd/5bNNk88AKE105YGw+TZJNqXyev8w8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uqwmoor/yyzXRM2GTDTtSnwiD/ArUvzA6QxOiGwyHJyNlVeX0cqEmn3r7WyUo/fx2fhgcpuBzZQsm2iFTbqtCsmVG/hcjBAh0bdw+PgrYXMeUxQ7QMB0rx1gghBYD16Wg0zdk6DrR4h5DkGuqQfaAYoM1aD6D+pc5KhxmkL/IOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tibyIlAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A05C4CEDD;
	Mon, 24 Mar 2025 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742842195;
	bh=5mJQMRQsVibHd/5bNNk88AKE105YGw+TZJNqXyev8w8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tibyIlAmKi10TBcgbcIfgj80LnAb4flQKSfrvR1TlD9mnGZeWL4PZYsgPbx2KnR0O
	 6zd8HM5WMjab+2rO9OChcJ9P41fkPpUxwkFRTwHsECxFZGLv22XJdmJThYzAg55vPK
	 eM3zjMsh8hJ0L3rdO1jnvr0rUdjBW3w7ECFYPsRHsT4zoVRHXatIMzYGYh95WptVre
	 1oy2h/Hz518+fR09MfIC3YiKDY/uWhLnsW02dhOoWL+oY3smD1Dy9MX448t7Z7GEsf
	 gY6IzC2OFGUIyJE4ytBCzBax8rybCKIUVaT0O5k/ugiPlaqWMFyibgvrbLEnX1oEAy
	 oVeTsCjDPeszw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34660380664D;
	Mon, 24 Mar 2025 18:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: Fix accessing freed irq affinity_hint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174284223202.4131627.8031895461636997073.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 18:50:32 +0000
References: <20250318032424.112067-1-dqfext@gmail.com>
In-Reply-To: <20250318032424.112067-1-dqfext@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, boon.leong.ong@intel.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Mar 2025 11:24:23 +0800 you wrote:
> The cpumask should not be a local variable, since its pointer is saved
> to irq_desc and may be accessed from procfs.
> To fix it, use the persistent mask cpumask_of(cpu#).
> 
> Cc: stable@vger.kernel.org
> Fixes: 8deec94c6040 ("net: stmmac: set IRQ affinity hint for multi MSI vectors")
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: Fix accessing freed irq affinity_hint
    https://git.kernel.org/netdev/net/c/c60d101a226f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



