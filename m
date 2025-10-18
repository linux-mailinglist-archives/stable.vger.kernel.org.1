Return-Path: <stable+bounces-187733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F833BEC103
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BDC1AA7F5A
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669F2246BC5;
	Sat, 18 Oct 2025 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAj8NfQN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EFD225779;
	Sat, 18 Oct 2025 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745630; cv=none; b=hNqx+/OdgkUMn2/19iVb73U2GRAcjTg0KOMlQRXCIVeT4x2NJgiX2EhEOstw7uVY2iBqfpWERckJPRRzoLkOVSLyxvf62vPeDjwaKpqzllnXRTcx8xViXqza+jGjV74LJYTIhgBJ6UfjpU1NWnvg5xlaNVyY/Y4nCAKaisQSTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745630; c=relaxed/simple;
	bh=YW7J4Cb2xkLTCFVdkNW03zNph9tJS3+L4niLsZEK/R8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pQy6HpD4e4aV7m70ssXLPjL1gIVASti0sIUWkiGLJ3jhUBCdUGai4j6xJWM1E8HC9CkOnJmcb5f5ny1VmXIBANItqI9lzRfLjYLB2ymiX4Y8YIYkSZrvWlXlMty2ceYYqjej9ZY5zW6yeIseOJVFPZpbgNmsIWCVR44Ddc/efGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAj8NfQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE8EC4CEF9;
	Sat, 18 Oct 2025 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760745629;
	bh=YW7J4Cb2xkLTCFVdkNW03zNph9tJS3+L4niLsZEK/R8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cAj8NfQNt3hE4hn6ZrOLuy9hCm46yQnbgTrje07WI5eucNPH0xn5wRfiflJy12do/
	 muLAi5IykR56dV5RnkUM1Fi38fqwkh9ftr+p8kkwX9sqXr/aEaw87wW/u3ayyKjLNG
	 /RL8DD0HVq1DeROUS4PmXPUQRac7J1dlmN7X1Nlw9lCy8G4tEKHs5pl81smnVjQAep
	 yP3iJvu7RE4RjWauGJAWKMaRM3yRS4epra8kiN0AmHBxLbsYGRwCekF1Ymkiu+78xv
	 ICO+X/ukLTgY/muddRgJ49Y2jirLYLsjZPVWqEIEP8AGBM2Ru/8tf4xIDd2EpKxI68
	 m2xYNrWG7iiSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB239EFA61;
	Sat, 18 Oct 2025 00:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bonding: update the slave array for broadcast
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176074561324.2830883.17596939425156454668.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 00:00:13 +0000
References: <20251016125136.16568-1-tonghao@bamaicloud.com>
In-Reply-To: <20251016125136.16568-1-tonghao@bamaicloud.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, andrew+netdev@lunn.ch, razor@blackwall.org,
 liuhangbin@gmail.com, jirislaby@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Oct 2025 20:51:36 +0800 you wrote:
> This patch fixes ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad").
> Before this commit, on the broadcast mode, all devices were traversed using the
> bond_for_each_slave_rcu. This patch supports traversing devices by using all_slaves.
> Therefore, we need to update the slave array when enslave or release slave.
> 
> Fixes: ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad")
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: <stable@vger.kernel.org>
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Tested-by: Jiri Slaby <jirislaby@kernel.org>
> Link: https://lore.kernel.org/all/a97e6e1e-81bc-4a79-8352-9e4794b0d2ca@kernel.org/
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bonding: update the slave array for broadcast mode
    https://git.kernel.org/netdev/net/c/e0caeb24f538

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



