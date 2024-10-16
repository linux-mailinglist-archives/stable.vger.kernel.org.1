Return-Path: <stable+bounces-86424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB10699FE48
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 03:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2CBB21324
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 01:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3D013B2A9;
	Wed, 16 Oct 2024 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KK84ZwPu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878024C81;
	Wed, 16 Oct 2024 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729042228; cv=none; b=WzcRbFT8mfsB8kQePP3hv2juHIS7U9ICvwtnxM26sTyBvsxS6TRgfAPO6+00Ln3Cc0syw8gKbN+H4C3cF2/f3IyiqGnSAF6EUeCGPL1xOlYhMM4Hf8Wt1iky6dAL/vtUS+LGlWM8DmFtyoy7fGWWgeYrtxHQWTaKMHAB9/oVp3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729042228; c=relaxed/simple;
	bh=Mb3XswMiy0p6l7SH0AA2U17JO4PZXn1SY2/vyBfRq8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uG7belY4EcRKZJXe9CDz5flIK2Xt3HCp7WxR/ZZiLG35AG2dSBuuOI48KaMFDACjelhGj2ZV4fFf5V9Bb4VP6lCYvGbwsFn3dXU3+39AndVEwpGX15c5Q+QLbCbneJ+8lzNuWWQMXMDhUPUZqMZLGwmF5Ch2uxNXJIVLx+jFNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KK84ZwPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006EEC4CEC6;
	Wed, 16 Oct 2024 01:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729042226;
	bh=Mb3XswMiy0p6l7SH0AA2U17JO4PZXn1SY2/vyBfRq8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KK84ZwPu99VO3MqIoMiGmnYdwkvjVl/G8FNBAWrXML8ozA9S1fKmBV2y6u98jy+hu
	 rI63X8sD5ahEKHyesEKr7nFB/+Jthnre3woIjvwqRTbtHLPrX/xyixjDT3+7Y1T28N
	 LrZalt3gffAkCMJyx4zckBrodWRSLBzkuLG0Eo4zmitYTONGmmdPZvw5/w6XYWPCFU
	 pX658uu5ASJyb6qgFjCr4NAw1MpVkBnSAkOEx4UUzzNfPR4p7XwZCbBio/+Y/Gq11d
	 ZHtilDgEWdLgYJ9r+ilgDycC4xO+yVuclpcR+J8RfcXIiwifo85Wtrx9edXWk8whXn
	 WrexabLupwQGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E443809A8A;
	Wed, 16 Oct 2024 01:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] udp: Compute L4 checksum as usual when not
 segmenting the skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172904223125.1350766.14271955479803742951.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 01:30:31 +0000
References: <20241011-uso-swcsum-fixup-v2-1-6e1ddc199af9@cloudflare.com>
In-Reply-To: <20241011-uso-swcsum-fixup-v2-1-6e1ddc199af9@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-team@cloudflare.com, ivan@cloudflare.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Oct 2024 14:17:30 +0200 you wrote:
> If:
> 
>   1) the user requested USO, but
>   2) there is not enough payload for GSO to kick in, and
>   3) the egress device doesn't offer checksum offload, then
> 
> we want to compute the L4 checksum in software early on.
> 
> [...]

Here is the summary with links:
  - [net,v2] udp: Compute L4 checksum as usual when not segmenting the skb
    https://git.kernel.org/netdev/net/c/d96016a764f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



