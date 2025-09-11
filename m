Return-Path: <stable+bounces-179225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA70B52539
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 03:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4739E7A8030
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 00:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA842045AD;
	Thu, 11 Sep 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpMBew0H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FD71F91F6;
	Thu, 11 Sep 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552405; cv=none; b=JndZi2FiIn3Zly9cxC7nrccrSETAwBo08nEwydenWCVZPlwfbO8niy1bcg2YLIJlC/Bn4lm12BDRWMS1Hd1lODs2/2k0UetNZaTfCJe+HhLiAlwRJfofdnhzrrgPHyNuYMN7UlBSOFPL4+yfctSpCw9YjFziTaLxdgAWoyjoM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552405; c=relaxed/simple;
	bh=qwuXpus2HWlOop1DAknXNJAailxPHFlyyk/IHmk53HM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nRXccg2OrLz89rSRXpu/Er9gw+3m8QQl7RDl/Q6foHUVDCdgtyeh7GSKnZVxJoPenySHpCjQNTBEIe9gLSzFYGQ75xUV8hfCOhyFjBM+yov/UWEU+k2f8Zv1w2vxGoeO7h+mEM6hc9SRrX2n5Wv8U7kCwyA3LA+72en44g6fbr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpMBew0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF02C4CEEB;
	Thu, 11 Sep 2025 01:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757552404;
	bh=qwuXpus2HWlOop1DAknXNJAailxPHFlyyk/IHmk53HM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PpMBew0HCzA09m6fBendvnylpvAzecO78yo5XL3bVqbq72OO/QTDHosm4SnBPq23X
	 scPl5PcGMzDi/UcIFtrpPradMXUYela68oztOJMfNJSLPRKGwW5Oi4fcBLrxeY1fzl
	 fNB3Ldhh0NnjODu/m8FcKulBEwfpaCR0+IaXIX28H0OB46BzY/1wosfrReNNFzlREx
	 Ci5kSzODn6z/qT+yBxLGV71+Gs5hToKcfZIiftp4aS3XhD3kz/gKK1fRaidN571XBC
	 FCXvOr5HCUuIzVbip5pnhdoxqQQx7lM1o/zVHY12AZ3Aa2f7gEa1RJgW6YvpLk6DzF
	 4IROVwNLPYy0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB546383BF69;
	Thu, 11 Sep 2025 01:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to
 avoid MDIO runtime PM wakeups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175755240775.1614523.6238417350387130294.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 01:00:07 +0000
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
In-Reply-To: <20250908112619.2900723-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hubert.wisniewski.25632@gmail.com,
 stable@vger.kernel.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, lukas@wunner.de, linux@armlinux.org.uk,
 xu.yang_2@nxp.com, linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Sep 2025 13:26:19 +0200 you wrote:
> Drop phylink_{suspend,resume}() from ax88772 PM callbacks.
> 
> MDIO bus accesses have their own runtime-PM handling and will try to
> wake the device if it is suspended. Such wake attempts must not happen
> from PM callbacks while the device PM lock is held. Since phylink
> {sus|re}sume may trigger MDIO, it must not be called in PM context.
> 
> [...]

Here is the summary with links:
  - [net,v1,1/1] net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups
    https://git.kernel.org/netdev/net/c/5537a4679403

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



