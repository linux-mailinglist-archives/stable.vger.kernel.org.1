Return-Path: <stable+bounces-52058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBB290756C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E08F1C226B3
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72A9145FF9;
	Thu, 13 Jun 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqwPFSf+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D770145B12;
	Thu, 13 Jun 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289631; cv=none; b=luqPIfQTjZfpKHEhrLPPDk9804SnuvLNPaMDpEaAz/UvNHBFOXhLK1Be6Z9VKiSD036D15l0r+jRA728QQmm4X2cnULkQ8H/cn8JkqENbZn29++x/VsWagaNuoy9um+XGy+KZ9lFkZb6WnpBQkpUj9dGW59Ng6cZ/F56fAnlWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289631; c=relaxed/simple;
	bh=jSu+K80o4zD8PvDW3KilUShNh/XJlo5qMMpgO2sQ1W8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NKgE6uuMpl0GdiV3x2cFurlhJyiI0SlMdu8o1+D57vhpBNzHsFWET64Wk8+MCBhQtPFEmAsmqbyOQdA+QzAr3YIsWoNMcMXXYjVEyLxrw4m0bCYlEUE6s5zRwxYXMvNQ4FB/ofE/77VYeFc5lxbN0E6BMOiT+7jtpYmMb9UKXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqwPFSf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38215C4AF49;
	Thu, 13 Jun 2024 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289631;
	bh=jSu+K80o4zD8PvDW3KilUShNh/XJlo5qMMpgO2sQ1W8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kqwPFSf+8EUfr/e5BjsNfvlZihqDHFT2p5u/B/7HinLecDqWeh2h7wvKYeiH+H5I7
	 JALu43/p5tqBahzNhVEH+XqBb/WkFGFeNQYQh4s5CmawMA0J4qeUHmxvrAXFjHY1gX
	 A0i4DocbkEbjT1vk7DxNvu0MhiBtvjn0xUsrrAGlesy3v/dFwYQlN0kKewXA12B8Ci
	 JKVJkpjL0JBNwZCeeVv1ob+lNPIfeeLpABWy0xkwdivsnsP4HWSr2tPxpiE/YLcL/r
	 loNdGoSA2PmOIXBYaOJpPrT6pft4z1yEGkIhOFFMvIzGyFnrR28RKg2CYUT4XSVnGZ
	 3e2uYjnnqOEpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29BBFC4314C;
	Thu, 13 Jun 2024 14:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: Clear napi->skb before dev_kfree_skb_any()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171828963116.5991.16090491063036449379.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 14:40:31 +0000
References: <20240612001654.923887-1-ziweixiao@google.com>
In-Reply-To: <20240612001654.923887-1-ziweixiao@google.com>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
 pkaligineedi@google.com, shailend@google.com, hramamurthy@google.com,
 willemb@google.com, rushilg@google.com, bcf@google.com, csully@google.com,
 linux-kernel@vger.kernel.org, stable@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Jun 2024 00:16:54 +0000 you wrote:
> gve_rx_free_skb incorrectly leaves napi->skb referencing an skb after it
> is freed with dev_kfree_skb_any(). This can result in a subsequent call
> to napi_get_frags returning a dangling pointer.
> 
> Fix this by clearing napi->skb before the skb is freed.
> 
> Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
> Cc: stable@vger.kernel.org
> Reported-by: Shailend Chand <shailend@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Shailend Chand <shailend@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> 
> [...]

Here is the summary with links:
  - [net] gve: Clear napi->skb before dev_kfree_skb_any()
    https://git.kernel.org/netdev/net/c/6f4d93b78ade

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



