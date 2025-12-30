Return-Path: <stable+bounces-204197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22975CE96B0
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 11:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EDBA3034362
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 10:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874052E9748;
	Tue, 30 Dec 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOVKQNMw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9E2E8DFE;
	Tue, 30 Dec 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767090807; cv=none; b=s65C8NDvohnujepBj8OZ32obECwsyvYJfzMPVHfXhZ/rPuj1nqVzQeRME2kFJ0dAVlpxlekYxXWSSlGLUgfYxNS95mDNX1lRRSqBjcYpRUPsdP6k5IBLs/+Jl5tNg6nidUfiITcxaJk/9cfrDFTAtbFyu33yXwIYY0JBrvpCEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767090807; c=relaxed/simple;
	bh=2ANyrjuANu+qFdsCi/uswp1/kr4bYlks/T/a0CCxBJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kGybK2a0RrvQhPUvvJf/kOKtqUYG5aKL1xoYIZyeDnOH+vdvgy297SjiNtY2OwXUBg2EYEPe3j0CF0WMidF7mwg6fO2+p4HXh6NEact21Y/VcUxClA+zIS3SSYFFKZjiz4PTkCOiWi0VyrPbRisaQO6KCVQXPG/jlRvgssnQN+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOVKQNMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1434C4CEFB;
	Tue, 30 Dec 2025 10:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767090806;
	bh=2ANyrjuANu+qFdsCi/uswp1/kr4bYlks/T/a0CCxBJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KOVKQNMwdDFwqbH4SmQoIlN/hXALuhjQIc8sZMUz3iRwDP+bf89SVPshjmCUlqMPA
	 l9aidOgKIBWFx/HQyS04ma8yi2yNncaXLvKeBDkzsv93gIz/ou6TUz5RdBvKtxQg7D
	 PYLYHPzPhdOeAvE5VQDg0FkXs2D1w/Jf9iMlDZloe+XnxEtAapsmCq4su/lkQA+cXP
	 M47hch38NbhcvnOL+vx1czoJDB7VsPs4CK13zE5uunZANbCs6Zb4jOAAanBTrjK8Vw
	 piWKSrz4Cz2Ewa/X5acnhfNv97/8ylbQyK2dBPiCTcOK/T5x+M1vxGPCZqHS0ty1lR
	 fUVv7Uk6XqCSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7373808205;
	Tue, 30 Dec 2025 10:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: macb: Relocate mog_init_rings() callback from
 macb_mac_link_up() to macb_open()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176709060877.3205848.3719021860077682100.git-patchwork-notify@kernel.org>
Date: Tue, 30 Dec 2025 10:30:08 +0000
References: <20251222015624.1994551-1-xiaolei.wang@windriver.com>
In-Reply-To: <20251222015624.1994551-1-xiaolei.wang@windriver.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: pabeni@redhat.com, nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, rmk+kernel@armlinux.org.uk, Kexin.Hao@windriver.com,
 Xiaolei.Wang@windriver.com, netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 22 Dec 2025 09:56:24 +0800 you wrote:
> In the non-RT kernel, local_bh_disable() merely disables preemption,
> whereas it maps to an actual spin lock in the RT kernel. Consequently,
> when attempting to refill RX buffers via netdev_alloc_skb() in
> macb_mac_link_up(), a deadlock scenario arises as follows:
> 
>    WARNING: possible circular locking dependency detected
>    6.18.0-08691-g2061f18ad76e #39 Not tainted
> 
> [...]

Here is the summary with links:
  - [net,v3] net: macb: Relocate mog_init_rings() callback from macb_mac_link_up() to macb_open()
    https://git.kernel.org/netdev/net/c/99537d5c476c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



