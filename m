Return-Path: <stable+bounces-186233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 105D8BE60F7
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 03:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFA594E3D8C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 01:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B922236E3;
	Fri, 17 Oct 2025 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EziOnAs4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4E01758B;
	Fri, 17 Oct 2025 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760665822; cv=none; b=DFJwPtdOBKJk2MQVTGtiigoltfQzF+inKpOFPQsQNcFZQqSgJD9ipGIW/qSbyWKftQTI8KcVM3QxqscTuPE4coIhawuXptZO99snjriP5IUtNJvgzzfA4S8lA0DYos6f2ZWO/YIXFJIHUU4GDNpWuZ7xKSkt67FmFO9MOXm9+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760665822; c=relaxed/simple;
	bh=7fPUJIEArno78HUx7DgvUxAlsXlA2hcDbpKnlfJamP8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J9LVMVax8g1KSQByc4mqpd3pYer2ssVgquWzfP9e2z6dpEI1eEGKfXSOeWdw4IwN6uwc6zYOgbIYxPeqsAs5BggEZLapH6+dSduhzDCO5iubY/tVsUhrx61h2LNOEwZMtKZxg9P0FgqUAHN+rurXocZ372UuHk684LqjRTzkoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EziOnAs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD83C4CEF1;
	Fri, 17 Oct 2025 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760665822;
	bh=7fPUJIEArno78HUx7DgvUxAlsXlA2hcDbpKnlfJamP8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EziOnAs4c/iow1Lz1fpu+9DEXk4dlcx8ugpKtI9pDV3NlEhlssRtusKVnvJMeWbER
	 t4xvA9MNawLezoDBi40CqY8T3iounKchb+wXOUdYkOjs5wzV0rlU5unzkb0c76L3d5
	 ux3BonMcgyp4mgK5pUqR8GewYuCE0VKRUPBTTYGLjvqOg1USfQ9fjYZnbfi7fGy4VJ
	 BrfBtvIYQR0SB9Ex+kBTj/RBcr7jqnU5m9jCv/B5Cx1q9xrwZu0Km8I9NC+mVhugIq
	 g8JW60Ko8TW+eREauGZvir4ANTJn8YR+emF4HIm6TojWKrTQJozI1p90fy2oAEwdvl
	 H4CzVEc7puToQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ED439D0C96;
	Fri, 17 Oct 2025 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Fix disabling
 set_clock_selection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176066580626.1978978.3015288820560591602.git-patchwork-notify@kernel.org>
Date: Fri, 17 Oct 2025 01:50:06 +0000
References: 
 <20251014-rockchip-network-clock-fix-v1-1-c257b4afdf75@collabora.com>
In-Reply-To: 
 <20251014-rockchip-network-clock-fix-v1-1-c257b4afdf75@collabora.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, david.wu@rock-chips.com,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 17:49:34 +0200 you wrote:
> On all platforms set_clock_selection() writes to a GRF register. This
> requires certain clocks running and thus should happen before the
> clocks are disabled.
> 
> This has been noticed on RK3576 Sige5, which hangs during system suspend
> when trying to suspend the second network interface. Note, that
> suspending the first interface works, because the second device ensures
> that the necessary clocks for the GRF are enabled.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: dwmac-rk: Fix disabling set_clock_selection
    https://git.kernel.org/netdev/net/c/7f864458e9a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



