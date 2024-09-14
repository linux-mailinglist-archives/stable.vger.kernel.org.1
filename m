Return-Path: <stable+bounces-76123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A88978D04
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 05:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2561C22D5B
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 03:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BE71BC3C;
	Sat, 14 Sep 2024 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzFRSt9f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEEB1AAD7;
	Sat, 14 Sep 2024 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726283434; cv=none; b=DsGSUcExzA06DYqSYp+tIwHhicw/6HPVBcx7pjOV18VwoGQNKHlbHsUogJa5yb+n3D5wlSioQVhLM7alvfr/rVoR40sdsoCef7yYiQZOWuOanq/q3Eyi+HzRiiBznKWXJjKUHdwltVuIWc7u3qE489Dvkr1paZ6fmZmFlhs6anQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726283434; c=relaxed/simple;
	bh=Fnsv2OZOlitml233jAUNjLoVR7xV+MJufffq3gpkwJQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tpZc9qtAR7gbwsKK5JSAxw1xy4t0DuCYM269wmZO/2A5JNX7tD4qRQbMWvvX4Q3FEMY0iG4EkHQndLcipOfL7nfMoDVwy3RXcLYnreOcw9hzwwYR2QcN0PK9squzNrZfmYrO3eqqUJDYN42CBlVsZHkJ38GpS8GAebLVlq34wNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzFRSt9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D964C4CEC0;
	Sat, 14 Sep 2024 03:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726283434;
	bh=Fnsv2OZOlitml233jAUNjLoVR7xV+MJufffq3gpkwJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hzFRSt9fNzBTeys28PY4Hd6vUqa+/VhmwOa49nbam4721hts4vWiyD9Cp9hUdDPSI
	 x7uLBP1PuA35DTWVIUFiWIVyZwhw4sHlgbLWhxLg3THkZupwWxgqbZf64/VJZE2CKW
	 vqy/fkunmUtqEZTjQEG+Mz0QAJHdwjdNMY13qVDODrFYAZhBXgQ0YcyoTH0MVcEkBc
	 fVEgJFFYOx/uw4V21TthjqiauafDe0l9vzmWD3hhhGeGYzV6E0K+4rXUOKmWT3RhXP
	 4+uxr4Va9/VXlJORzGzUHDTvrtbY9I3svLlhIDBsZBpL+UDt2ypnNlU1DX042bIHxZ
	 dN8v476KhAPXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD923806655;
	Sat, 14 Sep 2024 03:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] fbnic: Set napi irq value after calling netif_napi_add
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628343575.2438539.17479638997726025148.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 03:10:35 +0000
References: <20240912174922.10550-1-brett.creeley@amd.com>
In-Reply-To: <20240912174922.10550-1-brett.creeley@amd.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jdamato@fastly.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Sep 2024 10:49:22 -0700 you wrote:
> The driver calls netif_napi_set_irq() and then calls netif_napi_add(),
> which calls netif_napi_add_weight(). At the end of
> netif_napi_add_weight() is a call to netif_napi_set_irq(napi, -1), which
> clears the previously set napi->irq value. Fix this by calling
> netif_napi_set_irq() after calling netif_napi_add().
> 
> This was found when reviewing another patch and I have no way to test
> this, but the fix seemed relatively straight forward.
> 
> [...]

Here is the summary with links:
  - [net] fbnic: Set napi irq value after calling netif_napi_add
    https://git.kernel.org/netdev/net/c/9f3e7f11f21a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



