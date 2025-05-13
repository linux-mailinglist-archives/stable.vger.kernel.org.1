Return-Path: <stable+bounces-144139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58C9AB4E7F
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 10:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8667A81D8
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F3020E026;
	Tue, 13 May 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqijE3hd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4651F09AC;
	Tue, 13 May 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126196; cv=none; b=uK8fKGEUk6kaOMduG0KhTyz2zgYZBg5bgUV7KNPHyKH0gvKzHWHAaInp4dBzWtpwrHYeX7AYkx5I0dW8E0XNthunuy+F5VaAo/+DCYDFDKU9XLl98jca9aG4YXFj4xpxZgvrBtLjIArb7fB9JZjcNUsqrwyJrrz7hscCA3UfHJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126196; c=relaxed/simple;
	bh=MaH/3rHQVFeq82s47yVwfb8amcgYaRP6dl9IPVKdCoM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hGxBCYT7zcK7OzdTY/fomyWAtizgQK2LUBP24rS6pFmoYmX1Tv1DaBZQcyD99U1G8zVPEnCAB8LChQUG8iV+NTLqMsZeHD2ihIzNlaNHziairj9+tuHNe/BIVIp1Et8AJAT7B9MdqCurLLhN7OQMheVNCWhYUTsNOSLT5KkoTBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqijE3hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EB8C4CEE4;
	Tue, 13 May 2025 08:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747126196;
	bh=MaH/3rHQVFeq82s47yVwfb8amcgYaRP6dl9IPVKdCoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YqijE3hd1sczb4GR7qY8e3KcvDJkso/wd5EDv4Nb0N4MlhNxMGTVYOVuNgZYpkyRs
	 YeOb4UJLiMsVRiuVOHm8ZMVdCMGFk+AdV9x7U7YxRI8HUZ/9+r84cLGds/z4Oxu77p
	 idS301QWUq+zh2kC2Y3RD9mATXJgalkF2XgHt9yBjD5mBBa26gxF/GqCUcPvjynom9
	 3NDIEAyTowCBS60mQIiz1IMapcKfoedGGCZ5EuQ/0+eXszGTcyYacuEwt8/mAjlki3
	 tSyil0CHC9sXaMuu3L5uwvKLZyq7kjfaodlFsfkqNCi4uXgQGX/VqGTE1n5utD0Ub+
	 9d031bMpCWUQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4539D6553;
	Tue, 13 May 2025 08:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] address EEE regressions on KSZ switches since v6.9
 (v6.14+)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174712623355.1237041.4249732681101911068.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 08:50:33 +0000
References: <20250504081434.424489-1-o.rempel@pengutronix.de>
In-Reply-To: <20250504081434.424489-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  4 May 2025 10:14:32 +0200 you wrote:
> This patch series addresses a regression in Energy Efficient Ethernet
> (EEE) handling for KSZ switches with integrated PHYs, introduced in
> kernel v6.9 by commit fe0d4fd9285e ("net: phy: Keep track of EEE
> configuration").
> 
> The first patch updates the DSA driver to allow phylink to properly
> manage PHY EEE configuration. Since integrated PHYs handle LPI
> internally and ports without integrated PHYs do not document MAC-level
> LPI support, dummy MAC LPI callbacks are provided.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net: dsa: microchip: let phylink manage PHY EEE configuration on KSZ switches
    https://git.kernel.org/netdev/net/c/76ca05e0abe3
  - [net,v4,2/2] net: phy: micrel: remove KSZ9477 EEE quirks now handled by phylink
    https://git.kernel.org/netdev/net/c/8c619eb21b8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



