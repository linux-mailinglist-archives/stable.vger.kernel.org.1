Return-Path: <stable+bounces-144636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04055ABA650
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 01:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912C01778F0
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 23:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9086A280CC9;
	Fri, 16 May 2025 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsADziPr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40643280A47;
	Fri, 16 May 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436998; cv=none; b=PfD4GbsWg4wTftqIOxk3Kao9Egp4DGQYhqFY5K68n8aH7hLzOJsvTIs3qXVVBo8tHOBSI1ojLapcNrOPKZ8Foo3WvcHyyPOR1+zouxZuV7uLeegtFNNGW4P3ExhYxr/ThastZua8T7BX8ACVsQ9REDPAXuzcgUw/VS2ENSP4twI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436998; c=relaxed/simple;
	bh=LQcQYcpKVXu3qdOg4z52i+UHXOm+D9/jjs69Cphdxzw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CGzgmr72a3V+Fq4XjS/s+l+V2vEh06edO6zDVjxz9cUCvgTs8GkXU9J4UIccMCsGSEM+06Jc2sanqsbARmXBptTCyH8fqYbRRDwhXsqt4nOVyAhOp/1Y84NjmLdHmG0Xgsj1T+f2/UcsbPV5GlVJYX0LZA0bDdKyqsdKZGv0s/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsADziPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F9CC2BCB7;
	Fri, 16 May 2025 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747436997;
	bh=LQcQYcpKVXu3qdOg4z52i+UHXOm+D9/jjs69Cphdxzw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AsADziPrtO96BKwygVPsZ5Np9vPjQ0X5Ic0DKhZ3kVlE8uJXWXVc3LH+iLeMv159e
	 cX8TREqDnaTCxP+2W1eQPVFD3Yw5aacjZ/+oP1SzKVw8ZpR988QG4gkFZN0idaIipJ
	 UTFHFSchD9I51Vma89iUhqYNbTVkXm04tSXiMYQ2kj+TiyOOTctUxfY4NpQdVP3S0V
	 zfpFrOwsQJ2tB4MdF5a7ueUnj/6+qNzxd670+PcT3av8/3fxx5GVfd2yF3bqfkNTHQ
	 pQ8vpolVDTTij8HiG8JVH8chYCxbTQbuW34GeFZKLymzDspMocD4hGB8x9/YJIsBc1
	 hL+uwNCiLp4zA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBEB3806659;
	Fri, 16 May 2025 23:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: dsa: microchip: linearize skb for tail-tagging
 switches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174743703450.4089123.12129589622253332288.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 23:10:34 +0000
References: <20250515072920.2313014-1-jakob.unterwurzacher@cherry.de>
In-Reply-To: <20250515072920.2313014-1-jakob.unterwurzacher@cherry.de>
To: Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, Tristram.Ha@microchip.com,
 marex@denx.de, f.fainelli@gmail.com, quentin.schulz@cherry.de,
 jakob.unterwurzacher@cherry.de, stable@vger.kernel.org,
 Woojung.Huh@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 May 2025 09:29:19 +0200 you wrote:
> The pointer arithmentic for accessing the tail tag only works
> for linear skbs.
> 
> For nonlinear skbs, it reads uninitialized memory inside the
> skb headroom, essentially randomizing the tag. I have observed
> it gets set to 6 most of the time.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: dsa: microchip: linearize skb for tail-tagging switches
    https://git.kernel.org/netdev/net/c/ba54bce747fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



