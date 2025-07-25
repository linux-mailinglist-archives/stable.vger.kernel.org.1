Return-Path: <stable+bounces-164773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7708CB126C0
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9A41CC0D8A
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 22:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAFD23F413;
	Fri, 25 Jul 2025 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acSP1X6h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3919D06B;
	Fri, 25 Jul 2025 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481826; cv=none; b=qH9amePsQ1z+xf105JvEfCfmkhNTku47o6WVb4s5PUWwp2k2CmZed/3JNsXCTt0qaYqdMuGEPjQ+sW7aVaz2odEe6SDEYueh+3Z0Kmhp3ZW72aQp4rJjvDku9aYZ72Ort9xHW0UFRBp3bPgSiuBdK9iWqU2ee5fT/K5C5vSZnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481826; c=relaxed/simple;
	bh=DBCb4FWtpyFIFm67hpEsdJ6fXyQXhExhN7ermn3t7D0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MgeH9Bnf8PLJrVDld3AS9zFHYYUS7yh/qvoyo1kKGf5+S4AOslFI5x4AuK7DEm34m5nR0ApJsjKPn1QfZqGwQly7gspeVkisk0e8dxgCk7jxL/rw22YSgltJc1wqa8rUlgk8O0h42AveUpLfvh8gWj3KneZDBSxzV1IhtMGsEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acSP1X6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39985C4CEE7;
	Fri, 25 Jul 2025 22:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753481826;
	bh=DBCb4FWtpyFIFm67hpEsdJ6fXyQXhExhN7ermn3t7D0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=acSP1X6h+7EnIL9YFvNNuCfxp2b6l++aBIIOXCev0c7qSBM5+gV9kWO0ixLlChp5k
	 g/McvzbNPVQwYFCoEL0FVNsV0T1wZFhUCNZq+rWyOBA54J2oXIdmwFyusilKpUhuwn
	 o44PJsRNEaBQh+g41RCfc20GwB37lAzFFThXPOFSIlmnh6ktaAQSoVaifFFa9zMyf4
	 UNg2FejKyXeiEoXpBEt6O8n5ytLcEvVDpNk8so36Y/GvRVBJ6kVI3eNP6Mww5f/xEI
	 J69efI/wFEX7oMZie/jZJ1traJC4MhDDdJs+NlB94EwP2qLaU0gjkgmOfNuNfpRtgn
	 ddVJiSoK4Z+vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFAD383BF5B;
	Fri, 25 Jul 2025 22:17:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: micrel: fix KSZ8081/KSZ8091 cable test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175348184349.3265195.8359629740044567911.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 22:17:23 +0000
References: <20250723222250.13960-1-fl@n621.de>
In-Reply-To: <20250723222250.13960-1-fl@n621.de>
To: Florian Larysch <fl@n621.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Divya.Koppera@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Jul 2025 00:20:42 +0200 you wrote:
> Commit 21b688dabecb ("net: phy: micrel: Cable Diag feature for lan8814
> phy") introduced cable_test support for the LAN8814 that reuses parts of
> the KSZ886x logic and introduced the cable_diag_reg and pair_mask
> parameters to account for differences between those chips.
> 
> However, it did not update the ksz8081_type struct, so those members are
> now 0, causing no pairs to be tested in ksz886x_cable_test_get_status
> and ksz886x_cable_test_wait_for_completion to poll the wrong register
> for the affected PHYs (Basic Control/Reset, which is 0 in normal
> operation) and exit immediately.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: micrel: fix KSZ8081/KSZ8091 cable test
    https://git.kernel.org/netdev/net/c/49db61c27c4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



