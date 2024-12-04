Return-Path: <stable+bounces-98216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFC69E31DB
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 04:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0241624A4
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20756149C53;
	Wed,  4 Dec 2024 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCFM8mZL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4514D9FB;
	Wed,  4 Dec 2024 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281819; cv=none; b=j/D4fTeU63gjUEFMo4Q6CIcDGM0O+sBBl7VMNPv33ysQAUacUHu7g5umgXE6Vpt4KAeZVyq9HSjJJ5EsOKt1g4nUVSn8ebu1H+WrbY0zVn2dT4fdPA4noqRYz+jq4+vBXRRhEH7+EzXhqfmoA2Ra1br5kVOL28wv8fvb5L67Yew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281819; c=relaxed/simple;
	bh=WmrE0DC5qwIB4Vgu/OlnByp2tC0LRSQN3RMWZUkdeFU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NSDIQDkdJYtNMb7gtBtkzSFpNM5GZce0TOj8woCV4MKVt5Wj0xkCw3c7adRdwmmruh6tPn4Uht6DWQG4EH6o5IsbZFCFBvls5CLkXNyT3aTz5gLledp/QzCHljeOAFwv/mMxbcbU0Fk0kAsKAxIafBqbLSeNm1tQLPxcyrUfbHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCFM8mZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4F7C4CEDC;
	Wed,  4 Dec 2024 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733281817;
	bh=WmrE0DC5qwIB4Vgu/OlnByp2tC0LRSQN3RMWZUkdeFU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YCFM8mZL7gome89XLNLCmtOdYb3+dKYF7EhVnEBUdxE8j8g5Gj7gM3UkgxI97Gp9K
	 lApY+e2lZ0q07l8pT/Pwu1pHT0/NuDTilkWrg5cKmrw+GVC7qM/G36E0su+Okz+EUN
	 6zcngXwkaLFjielLu4PMn57aMUB3YJO3bomF8jI3QbscSteV+CogL0rHfoypl66Q74
	 7M30Te64pIZN/GY4Cu4DtIZAxAql5meMhC0A6eukGgVx9iyYd/StaKiUVCn3MI6pkn
	 DULIM0UlaCp+4X4SicfSA0ZvAvM1kUR4gADFZ08rCAG8K71b0N3YptfSy4lkJlRbqd
	 VCx7WHOkXFJbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7217F3806656;
	Wed,  4 Dec 2024 03:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net] net: Make napi_hash_lock irq safe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173328183200.718738.18254702355170016369.git-patchwork-notify@kernel.org>
Date: Wed, 04 Dec 2024 03:10:32 +0000
References: <20241202182103.363038-1-jdamato@fastly.com>
In-Reply-To: <20241202182103.363038-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 kuba@kernel.org, mkarsten@uwaterloo.ca, stable@vger.kernel.org,
 linux@roeck-us.net, davem@davemloft.net, horms@kernel.org,
 dsahern@kernel.org, bigeasy@linutronix.de, lorenzo@kernel.org,
 aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Dec 2024 18:21:02 +0000 you wrote:
> Make napi_hash_lock IRQ safe. It is used during the control path, and is
> taken and released in napi_hash_add and napi_hash_del, which will
> typically be called by calls to napi_enable and napi_disable.
> 
> This change avoids a deadlock in pcnet32 (and other any other drivers
> which follow the same pattern):
> 
> [...]

Here is the summary with links:
  - [net] net: Make napi_hash_lock irq safe
    https://git.kernel.org/netdev/net/c/cecc1555a8c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



