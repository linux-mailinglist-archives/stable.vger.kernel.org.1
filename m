Return-Path: <stable+bounces-118540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF7CA3EAAF
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 03:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57383A4D13
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 02:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A5578F52;
	Fri, 21 Feb 2025 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTV3l/Kn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0BF286298;
	Fri, 21 Feb 2025 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740104208; cv=none; b=YhZP29jVNI65QXDkqyx/tGxy4dS/AiPid+tdsxA4pyCODjggU+K9bPW+wCnTJgofOHaOnLF6BC/zi8Y0s+gTlWmgjKBHrM1oB1CKpp6vnA5z1lXSi1q9yjx04cKW19nEO/PNHICf2xO/ltC9WaNf5gikI+oWBEGfGDRahgHA79A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740104208; c=relaxed/simple;
	bh=Lmb3eiB2fyBd9+A5hO5hXqYmpD+2eXQd0NJcmWFxFrU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k8wof4+QNRbGO7royfo4QB91QQPW2UGwNZaCrrpVuvE/iJeUNrOrhh9+rQp4HJyOooHyajjuZwnWiPYiSn0tX2NEv8qXB/CQ64FxJiJpThcEgEwawWTcQpgzB4ZHm0XOjxec6fXkY42Xy/wHp2BXePoFXrXqkbpICzMjLfs1iW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTV3l/Kn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A37C4CED1;
	Fri, 21 Feb 2025 02:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740104207;
	bh=Lmb3eiB2fyBd9+A5hO5hXqYmpD+2eXQd0NJcmWFxFrU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VTV3l/KntL6NwIsUTpQbjMG0Kd36qbER3VQSsP4FTjI4NYFqCYWuYDyT0wEe3+NQi
	 fkOwxYLaLumg/xHi/7F/VXAF+IfcsJ1MiQ7jD5ITYVOyOuekjImjZCr76uyS3VNLvw
	 LcxYLyjnD0JnjOTWcCQDHuhSVg9GOR71hbM5tUodJYiI3ivO1ti0iPqQw+cAmEF5l0
	 8IfSmsJwsZvLR5VHirrCdo7QxMtfvh7eDzD1dMzbAGkk2NFlk2KRGbNXIHu4s7yeBv
	 axEHmRHqiO1kEa3xOPin4KB5V1Ob/UygmxfQZc6l2ebZHL4wTnxnc7ia2vz7fq9rCW
	 1FzwC9Pq9iIBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE693806641;
	Fri, 21 Feb 2025 02:17:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V3] net: stmmac: dwmac-loongson: Add fix_soc_reset()
 callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174010423851.1545236.8099662229327070133.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 02:17:18 +0000
References: <20250219020701.15139-1-zhaoqunqin@loongson.cn>
In-Reply-To: <20250219020701.15139-1-zhaoqunqin@loongson.cn>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, chenhuacai@kernel.org,
 si.yanteng@linux.dev, fancer.lancer@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, chenhuacai@loongson.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 10:07:01 +0800 you wrote:
> Loongson's DWMAC device may take nearly two seconds to complete DMA reset,
> however, the default waiting time for reset is 200 milliseconds.
> Therefore, the following error message may appear:
> 
> [14.427169] dwmac-loongson-pci 0000:00:03.2: Failed to reset the dma
> 
> Fixes: 803fc61df261 ("net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> 
> [...]

Here is the summary with links:
  - [net,V3] net: stmmac: dwmac-loongson: Add fix_soc_reset() callback
    https://git.kernel.org/netdev/net/c/f06e4bfd010f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



