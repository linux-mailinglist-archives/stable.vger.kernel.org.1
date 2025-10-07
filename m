Return-Path: <stable+bounces-183529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12179BC1105
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 13:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BC83C7C83
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6EF2D9EE1;
	Tue,  7 Oct 2025 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoSJY2BP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D482D8DD9;
	Tue,  7 Oct 2025 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834818; cv=none; b=TX043WcImMLTA+Ff59eGRpsL9XnXS47nlptWTvGvHBv86oV8gy9xzQYFJzzfnpt4V43J4+gXZVuxcqgiGzi45I3XXZTCwzpTpC84LxAg+SJu9BBJTA4+SOLmn0fOn6d6pTaqM1H5LDQvIQDEWpr1s8qGJNHAkYNnNplcIAyAwjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834818; c=relaxed/simple;
	bh=L0EASbLxfy7UVVW6XZd46Nm7s/gz7JlIjB+KddnqWKE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ItomjVlgZcJd/NNxpi06+XU410Hmh/nn/PzJsTYvadWghxI6gaipbt55tFiITlNU+usd3NsbCiFK7UOeNajvq1HUKAhH1uuTw/+cL8ypIqMZumx1Mo1BwUVldzOTaaQ+u/i2dR8oQX1ft+e9hPtOXCWfsE/d9v0zBiJr8/rMzvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoSJY2BP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE63FC4CEF9;
	Tue,  7 Oct 2025 11:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759834818;
	bh=L0EASbLxfy7UVVW6XZd46Nm7s/gz7JlIjB+KddnqWKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JoSJY2BP4p3Y/LtAaKTXT6D8R61bKg75jJFlxV7nS08O8zKPY6VpiAj8PdtJQ4Wnq
	 nx1V2lELczNdimO7Rxs/Dx7lr9BgW/DqPG6hQfwICE3J0u64h/OvjU6ZKa5uHc4Nmm
	 l/U4oepSP3oDxb0gDY6qbroe6t516Tkx0wEg0ip9l8q6ZilzSz6BSDxjBxuqLuae4k
	 Vcfdl32nHW1CCkqsqmuGcxjxrArSdw86nD4klz+/SY2Jy96cAzcXBbZDyDciyxfhZc
	 /kn0AMT/Lk1uZKPlfTwbaXCqdZ4J/OzRua1/yoHTF+7SOBwgzFPh037wnpAFQfPUVq
	 u4y5G7a6twvyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ED739EFA5E;
	Tue,  7 Oct 2025 11:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/1] net: usb: asix: hold PM usage ref to avoid
 PM/MDIO
 + RTNL deadlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175983480727.1851569.17231630495661577078.git-patchwork-notify@kernel.org>
Date: Tue, 07 Oct 2025 11:00:07 +0000
References: <20251005081203.3067982-1-o.rempel@pengutronix.de>
In-Reply-To: <20251005081203.3067982-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hubert.wisniewski.25632@gmail.com,
 m.szyprowski@samsung.com, stable@vger.kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, lukas@wunner.de,
 linux@armlinux.org.uk, xu.yang_2@nxp.com, linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  5 Oct 2025 10:12:03 +0200 you wrote:
> Prevent USB runtime PM (autosuspend) for AX88772* in bind.
> 
> usbnet enables runtime PM (autosuspend) by default, so disabling it via
> the usb_driver flag is ineffective. On AX88772B, autosuspend shows no
> measurable power saving with current driver (no link partner, admin
> up/down). The ~0.453 W -> ~0.248 W drop on v6.1 comes from phylib powering
> the PHY off on admin-down, not from USB autosuspend.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] net: usb: asix: hold PM usage ref to avoid PM/MDIO + RTNL deadlock
    https://git.kernel.org/netdev/net/c/3d3c4cd5c62f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



