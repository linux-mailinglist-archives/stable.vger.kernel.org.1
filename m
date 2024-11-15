Return-Path: <stable+bounces-93072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0E79CD5DC
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 04:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0502EB234BC
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 03:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE1F154444;
	Fri, 15 Nov 2024 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB81Qvaj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022B33997;
	Fri, 15 Nov 2024 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731641419; cv=none; b=MQAOcwQ/FElYGZ12kZMDjUCSgSCgzvOpeB6X1QmLNbcWl1G12D/fCN8OEhHpUpuyuK2Ty9rP4V9FXBgOnb3JqyO3/W7AtxbPwVCZ2XzR6Yc0Y1I8/RBrcb6f4oty9KRA5qqjWNZVEsI37/DDutH05uoXJlzpIv5mNTQJ+jlHNns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731641419; c=relaxed/simple;
	bh=Him8nl8FyzNVEHA1o0Xazwb9egJOQ5O9TgMHjAoDCoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RnEM2hEyuyye5vUhwkk9T/GqPhxDSwQ24BN/sLIqyIv0xH+aSymC+bOfAbc2yrRemTwyWf0f0tuUeHJ8o5qNDrpldIu9oVABxZpMvMB7Hb2eLVx7W4zTMx7Dl2/LMUZDk2WxFVIcOwdxy4OY2UgtHdY3n8jbEGWEZibXRVPovvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB81Qvaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ACCC4CECD;
	Fri, 15 Nov 2024 03:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731641418;
	bh=Him8nl8FyzNVEHA1o0Xazwb9egJOQ5O9TgMHjAoDCoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RB81Qvaj5V0+kVVcbRM37PGyVbmJG5F258/uituX3OPjEmQXTPkMc69NeFD9ynAwl
	 7r2HwsSa9FjTrCtBOukCojjx4TEQJSaTVPLGe7ADIfjZDezXjNybL9KM801jh9FbyX
	 uEo6ZcnlH5+WRzQw1HClGsD6JCsxnrzK6W4euGBzetdKlpMqiiwJLsu0j8fvYJ8DTt
	 D9vDNVLmth5RdAU86P+pkt6ZN+7uzqg95cWFIvGNe9hsXxLMni/lXan2LPhW3Fz3V7
	 iXcp422k+TYSxrY0evK195nOa+RF4BOF3t8asbx1N8rEeDoy8OPzFIkxC1iWziNZDs
	 zve2dlxT/HSTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B623809A80;
	Fri, 15 Nov 2024 03:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: phy: dp83869: fix status reporting for
 1000base-x autonegotiation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173164142900.2139249.18179517007808850405.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 03:30:29 +0000
References: <20241112-dp83869-1000base-x-v3-1-36005f4ab0d9@bootlin.com>
In-Reply-To: <20241112-dp83869-1000base-x-v3-1-36005f4ab0d9@bootlin.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dmurphy@ti.com, f.fainelli@gmail.com, thomas.petazzoni@bootlin.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Nov 2024 15:06:08 +0100 you wrote:
> The DP83869 PHY transceiver supports converting from RGMII to 1000base-x.
> In this operation mode, autonegotiation can be performed, as described in
> IEEE802.3.
> 
> The DP83869 has a set of fiber-specific registers located at offset 0xc00.
> When the transceiver is configured in RGMII-to-1000base-x mode, these
> registers are mapped onto offset 0, which should make reading the
> autonegotiation status transparent.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: phy: dp83869: fix status reporting for 1000base-x autonegotiation
    https://git.kernel.org/netdev/net/c/378e8feea9a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



