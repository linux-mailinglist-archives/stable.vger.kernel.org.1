Return-Path: <stable+bounces-53670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B972290E10A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A554B220D0
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 01:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ED96FC1;
	Wed, 19 Jun 2024 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q28mxSu0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E05227;
	Wed, 19 Jun 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718758831; cv=none; b=NjVwMWyBU44N4fSlCRnvXgSWObplsd+JY0KbtoBia0ulZIdvMPXthD1A7VmN8dd1XyJj47pW4IlQDwM97+eBeSAQpVuwBC1Gow3dXOJUhxwlqCxQ7DS0NsOuAy4cva1gUYP9cz6qRJY+4VK/W2M9Aec7nygmXGVdPTJNkM0g/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718758831; c=relaxed/simple;
	bh=9iz1shUjtIxp8CXHC0W9frBjPasa9Dtmt+c5qjr6XYk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ePduKGNlaUx+j1KyNB28QJ43Wx2XqUZGNLjyPiR4jygjeuu/xfO+ItlabPlwGBqeGt7wFT5TiN2TEC7DszgD5OHADX23RjqSI6n76oNRY8iHZVTdcYxGNd9a4fZ1xZ0RnTJGqxrbMwFTarT/p+2OVWOjt5NtWLxIdYWaiu39w8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q28mxSu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49C47C3277B;
	Wed, 19 Jun 2024 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718758830;
	bh=9iz1shUjtIxp8CXHC0W9frBjPasa9Dtmt+c5qjr6XYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q28mxSu0v/oU3mSmKYUkVpj6rfX9/Wg/KpaEFEq+yyqyMS2XRy0wGuHWaCOnz5kGv
	 2kZspiZgbFsqk+dFCdh6FMeQ5X8BmFcW0cNFzIRUdlc20jieeR3CHoPqgtq8R/6Z4Q
	 8cpHUJvCiNwJ0tJcEf4MlP+9dErkxeCli6LvVBsX+p+CQ0xYkefNVnLN/LYzzbGBGY
	 V4Bga2oJvSXGO8TlC9tR3q9QeN/ikPhiaclj4YgR/agZXobUj2RMApolIMw+6MOpAX
	 W1XQK/UVZirOozX/Ti7jLHvShU1cPc2k0JD6RJIuVjPcA9ejM5KVGxpkEWMzchvchN
	 ZjMIXi68IzMww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 248C4C43638;
	Wed, 19 Jun 2024 01:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] net: phy: dp83tg720: wake up PHYs in managed mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171875883013.1104.15419564260123669460.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 01:00:30 +0000
References: <20240614094516.1481231-1-o.rempel@pengutronix.de>
In-Reply-To: <20240614094516.1481231-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 stable@vger.kernel.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Jun 2024 11:45:15 +0200 you wrote:
> In case this PHY is bootstrapped for managed mode, we need to manually
> wake it. Otherwise no link will be detected.
> 
> Cc: stable@vger.kernel.org
> Fixes: cb80ee2f9bee1 ("net: phy: Add support for the DP83TG720S Ethernet PHY")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: phy: dp83tg720: wake up PHYs in managed mode
    https://git.kernel.org/netdev/net/c/cd6f12e173df
  - [net,v2,2/2] net: phy: dp83tg720: get master/slave configuration in link down state
    https://git.kernel.org/netdev/net/c/40a64cc96795

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



