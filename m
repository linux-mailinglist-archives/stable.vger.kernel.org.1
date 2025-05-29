Return-Path: <stable+bounces-148080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7423AC7BC3
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 12:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A732B171398
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 10:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2684628DB73;
	Thu, 29 May 2025 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIIt6U3M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28AE28D8F7;
	Thu, 29 May 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748514597; cv=none; b=SrIirtQCRVTlb4O83KqRtsbhwMT78ciJzhJEZvgHqg1bBo5mk9K1pSt7zGDlLy4rtVW+/EJDy1SA3E/sA7DqORHdJFExns2vPBohkGIBY+mfEz6/Vi7jzCu/aojfcuZJCBhWpqSa2JYgKORbICYP9wYcwB9+hlOQNpo2vaRyvj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748514597; c=relaxed/simple;
	bh=riHvhwPiH5V6qKln4d0cb8sN5WbGv/6Yin393zmcsl0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CmQ8Awyp1Dwwvuv6a623xy6Z9f0GFKWpiUn9djtCfkSrn02oG5uHaQv7lexN7VrJYCQtIBoJ/Beuda/NML1pxZPnj0fJAvLC2+H2ZJfVHkBG5d5e7wQmVCIcNkDbUiz318x0l4PNbm7vKTRambq5EZUshW8Be0LUWBpb7N4C5wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIIt6U3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF21C4CEE7;
	Thu, 29 May 2025 10:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748514597;
	bh=riHvhwPiH5V6qKln4d0cb8sN5WbGv/6Yin393zmcsl0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NIIt6U3Mz7JfYs6BhrDomKTfQW5Hs7Dk/3Y5KJAhY9nK68ageTVQLd/fkk2e1tCDP
	 Bx2ZKdJckBn5gFir9KGvk2vj/JkTJpuwjTbwTAZPqCWAyUdqWPXEJ7ZVJbte/yqr9U
	 B17xzrJCe7fzPEmBqbBhRW0S9nbi7LXDfpab432tWRHdEwyCWGcsAw9Bl3Rhv2y7/v
	 w4KVjKDUDS0Mh4GTR/ff1aXdSqPVByYhm2+zl7Lm26HxoX93zDn2PnVCPwzy9AJdfb
	 zaZ7HqjLsIXVFOMBLy2laIlUMLcHqtQBm87hmU5FnT0dm64y97dxMFAZ2uo0xzUr++
	 XUll5MCL9JSlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3685F39F1DEE;
	Thu, 29 May 2025 10:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] driver: net: ethernet: mtk_star_emac: fix suspend/resume
 issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174851463074.3219366.15490415696108954366.git-patchwork-notify@kernel.org>
Date: Thu, 29 May 2025 10:30:30 +0000
References: <20250528075351.593068-1-macpaul.lin@mediatek.com>
In-Reply-To: <20250528075351.593068-1-macpaul.lin@mediatek.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, brgl@bgdev.pl,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 bear.wang@mediatek.com, pablo.sun@mediatek.com, ramax.lo@mediatek.com,
 macpaul@gmail.com, stable@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 ot_yanqing.wang@mediatek.com, biao.huang@mediatek.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 28 May 2025 15:53:51 +0800 you wrote:
> From: Yanqing Wang <ot_yanqing.wang@mediatek.com>
> 
> Identify the cause of the suspend/resume hang: netif_carrier_off()
> is called during link state changes and becomes stuck while
> executing linkwatch_work().
> 
> To resolve this issue, call netif_device_detach() during the Ethernet
> suspend process to temporarily detach the network device from the
> kernel and prevent the suspend/resume hang.
> 
> [...]

Here is the summary with links:
  - driver: net: ethernet: mtk_star_emac: fix suspend/resume issue
    https://git.kernel.org/netdev/net/c/ba99c627aac8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



