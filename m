Return-Path: <stable+bounces-184119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2735BBD086F
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 19:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20CA94E3C77
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8152ECEB9;
	Sun, 12 Oct 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2vx+H1V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE72EC55C;
	Sun, 12 Oct 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760289619; cv=none; b=VvBTcmltJMT/krG17MeQms7awMJMNTG7eussTBYXXodqx2+42Ey+bONbsr4AUDQvy0a3lTDVgJxYfFuvf2MCBRTXjeDj1jEb9w+eJE+iHwV84GNGeRH04YQhAd0nGEcJcxxpV2mzPoQkoHDtE8ZsLPg7f86JQMAKF1PjT/aHVic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760289619; c=relaxed/simple;
	bh=0Yhqw/WpUTQj+vAuDvTHp3aIUOR0Gj80cWsQtkFzs3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TZnBiCyXlmJ2oLNLygdyLp+9J5QZthSfpgA3VU1RKpEBeqBajVqp9C3m8MnxIWdSnA0vooqnGlG7mrGgwEDySVfq3LTlAtQX3soCV6aLa5ITs0Ovw/4M9QFuY+x4vS4RR+qmBtZJ9vlk/JKXkxrW+z+1YrhC3ok7Ko+8iR49dNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2vx+H1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBFBC4CEE7;
	Sun, 12 Oct 2025 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760289619;
	bh=0Yhqw/WpUTQj+vAuDvTHp3aIUOR0Gj80cWsQtkFzs3M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a2vx+H1VW3lHb0/EWN4Y+UwNY060kww2kdLP3SWRi4AThtcAwW3CkS6GJCV0SE8aB
	 HgoOetpYACGBrEq1NN0zUl7SF6/hGpXxhUsiVkx7K3rULqc1Mx9Wgq062w3jyKpwfx
	 y6DhyXWdDX50WT4dN4uGXCCxRcYJMJBudHfh4FjIibK1BEKiXhzxntVjZWCxQHOo/5
	 mwS6sTY3jMeBXcNQII5+K2txf46uoeksG4sQcL3tXjNKtml5/gMxiIvB3wZrT63i6C
	 IHR8fs6vXqfM50OW2doCyDqIy264vF3OYtBwJKBauaQyaj44nltJkCuj4upMdOe/XG
	 cVBLCh/rj//Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD5A3809A1C;
	Sun, 12 Oct 2025 17:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM write timeout
 error(-ETIMEDOUT) in lan78xx_write_raw_eeprom
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176028960551.1702266.1263953075322899185.git-patchwork-notify@kernel.org>
Date: Sun, 12 Oct 2025 17:20:05 +0000
References: <20251009053009.5427-1-bhanuseshukumar@gmail.com>
In-Reply-To: <20251009053009.5427-1-bhanuseshukumar@gmail.com>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  9 Oct 2025 11:00:09 +0530 you wrote:
> The function lan78xx_write_raw_eeprom failed to properly propagate EEPROM
> write timeout errors (-ETIMEDOUT). In the timeout  fallthrough path, it first
> attempted to restore the pin configuration for LED outputs and then
> returned only the status of that restore operation, discarding the
> original timeout error saved in ret.
> 
> As a result, callers could mistakenly treat EEPROM write operation as
> successful even though the EEPROM write had actually timed out with no
> or partial data write.
> 
> [...]

Here is the summary with links:
  - net: usb: lan78xx: Fix lost EEPROM write timeout error(-ETIMEDOUT) in lan78xx_write_raw_eeprom
    https://git.kernel.org/netdev/net/c/d5d790ba1558

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



