Return-Path: <stable+bounces-45645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB4C8CD03B
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 12:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D301F233D6
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5901411C2;
	Thu, 23 May 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mfi5+rIr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447EB140387;
	Thu, 23 May 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459629; cv=none; b=Lz6txtCBosWcCfLVtimZNaOOb34jZPCavi474C5FzbGAMpd2KrKPcrG5Gekjg19eJLIwWJJDQO0NqjxhUabP/w/33AaihciYKwXaVHetLh0RPtAjKL5bbLsrfQtwBiBGfb34Y25EvWZK6bSiOJ75MPtFfHc0eBShPoRtaxwN26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459629; c=relaxed/simple;
	bh=wWjox4AoY2ZWFzxB18FF5+2OZbBxYaXqr1ceABbeUdQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mrY3mJZ00mLSFjiKpS6A53tzs+NZZcnr+yrCnfnprPK9sFvnKmZWZe+giQ2DwAV44HFzcIqdadQKjBVDUCDw/yVSv6dzxiv7FiamPdCTiiPHe5p3mmSh2tzhpQwczHhl+DTJsDaCqhBZJWWm17gpyJdzjGllJDvUsEjb6qSZOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mfi5+rIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3F39C32782;
	Thu, 23 May 2024 10:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716459628;
	bh=wWjox4AoY2ZWFzxB18FF5+2OZbBxYaXqr1ceABbeUdQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mfi5+rIrJ29bYs/NKSxoVc2DkLdoYu0qiWgF9bxDANV43hgNSGBkjvEdDX1i700D3
	 IrsFfYPGlNi8AIZBqebNsdCP3/3vORLUQ8bXvykIaE+oUV6SiJnQ99rYhFms/pDPX7
	 Q3RbxdZuIljgTkkE36XyOPgtpLTRaDhsyrkkXwn9bzQV0ydVa5AusEN1lE0YNVhd68
	 RBQBbML+A5PVgYn1B5SuvxSrOrqtDfnCSh5aIr6EinN6XGA7IeRoiXv1Inu3dbzrV9
	 KvxpQUlRd/f9QxInwNuvtD3Hn9Dx6t2zFjKBwvIv8y4ZqfDlgdUfTCgnMbDYzTzNvO
	 GhWyUwIMT/6GQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB806C54BB2;
	Thu, 23 May 2024 10:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ti: icssg_prueth: Fix NULL pointer dereference in
 prueth_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171645962876.19239.16570750086853802691.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 10:20:28 +0000
References: <20240521-icssg-prueth-fix-v1-1-b4b17b1433e9@bootlin.com>
In-Reply-To: <20240521-icssg-prueth-fix-v1-1-b4b17b1433e9@bootlin.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 May 2024 14:44:11 +0200 you wrote:
> In the prueth_probe() function, if one of the calls to emac_phy_connect()
> fails due to of_phy_connect() returning NULL, then the subsequent call to
> phy_attached_info() will dereference a NULL pointer.
> 
> Check the return code of emac_phy_connect and fail cleanly if there is an
> error.
> 
> [...]

Here is the summary with links:
  - [net] net: ti: icssg_prueth: Fix NULL pointer dereference in prueth_probe()
    https://git.kernel.org/netdev/net/c/b31c7e780861

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



