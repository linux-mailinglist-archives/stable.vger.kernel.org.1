Return-Path: <stable+bounces-64677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E759422AB
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 00:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6C1B2416D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB0F19149E;
	Tue, 30 Jul 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZL9R2I6t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF3C18E030;
	Tue, 30 Jul 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378032; cv=none; b=tqnA+cEVX9BI2Wp/yhG3gt3m3uVxKp2R7gxMmbnjvc00tP/1TKMnmE68F8P2jC48C9DMtb8ZnnoBtWjEw0Du7SQZNDrz5GCD/xbZ4aqSaUpbTRn07Z7STCxGfiK54Ya3vCu7lWC0+QqsfPhPYSw3PCRw+8ypXS1lkpsvnUK5q48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378032; c=relaxed/simple;
	bh=NC39ToIiYStV2URdg0RupoAPdagiRdTNILO7HSacAmY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tq5qioJwuSdPIEG5WMtYnbprX3JvnYG+MSq6hkdenLraJvkAsSiot9CjjmHp/1nMKHNv0tX/C5rboNMHOpHm5KBZcWJgtF6HPCB+qC/tOXuRl1YM/ycJtWft4GibWP6UDAoLDGstdNf/L7DXH3RPcr5NJtNEwtjVmFXn+YhDPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZL9R2I6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFE4CC4AF13;
	Tue, 30 Jul 2024 22:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722378031;
	bh=NC39ToIiYStV2URdg0RupoAPdagiRdTNILO7HSacAmY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZL9R2I6tTZdY24ihOhPuVMhJYRpquPlgGiA00fCFS0jlMQcqtsn+iacUB3SF0RiTE
	 2kcGigYMUIr+/3mSKa7XFytxY75wQ+rTmwRhYfwPaiyXOzbWN3yqY8uuI2pDn3XDdO
	 x3+tpvwVxtXx2QE4AaykTEGz3WGKxCV2LVp88AjW5XkuEkBTcpLUleiO8D+gKIx+DO
	 exzsdMOgIjkumR6FCIJ6zh8JWXpQwwbMxoEqJKWNKkRsJVfPhpz861ZqSe8n0Nj/Ia
	 yoZ2lhJV4etjn5VHVpAy2N2t//JL7IWOpJ5fOhgwjD523ISSW/TihWtOcZtke9pUeO
	 bAHH/ESCt9VTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1F3AC43140;
	Tue, 30 Jul 2024 22:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V1] net: phy: micrel: Fix the KSZ9131 MDI-X status issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172237803179.26065.6593267198901302690.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jul 2024 22:20:31 +0000
References: <20240725071125.13960-1-Raju.Lakkaraju@microchip.com>
In-Reply-To: <20240725071125.13960-1-Raju.Lakkaraju@microchip.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 edumazet@google.com, pabeni@redhat.com, horatiu.vultur@microchip.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jul 2024 12:41:25 +0530 you wrote:
> The MDIX status is not accurately reflecting the current state after the link
> partner has manually altered its MDIX configuration while operating in forced
> mode.
> 
> Access information about Auto mdix completion and pair selection from the
> KSZ9131's Auto/MDI/MDI-X status register
> 
> [...]

Here is the summary with links:
  - [net,V1] net: phy: micrel: Fix the KSZ9131 MDI-X status issue
    https://git.kernel.org/netdev/net/c/84383b5ef4cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



