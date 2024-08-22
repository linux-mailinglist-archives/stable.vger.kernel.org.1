Return-Path: <stable+bounces-69875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6796595B35F
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 13:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237A2283AA8
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 11:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53C183CB1;
	Thu, 22 Aug 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdXUALGq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B04166F3D;
	Thu, 22 Aug 2024 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324431; cv=none; b=iK/3wGyEGPZGh+UBQs2wMd4V5O4fEWSsdbr9jG4gVRp9G26hdlLv5cJU+ZosJVwdkg7LWWDfxO3fckBH25nV0EudLJtKRYWDX6/of+FTrHlL/kN7KvvFKs3hWw5CI1uqgGUnFn0p8jXqb5GLVpiYIlI+UwX00CX2tqtavRwvjao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324431; c=relaxed/simple;
	bh=b44f+n9+/KKyzs0nbQ9RHOtxwmDZrSkDmFzOIJVNffQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tAQj37QS55pH8UaJvkyM0uiQUBri26PdpgyeqcUD867QwQsrAX5KMgYVodYeDhHswmwrRghgLH0fiICthJxXbc+ceF+RJjCc7nemD+I0PWSuG7Kb55PQzRX5+fLJ2HA5zqnBLkwk7jOtfRWZImTejCLSM6SBURJrbQOZRhRd8ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdXUALGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD50BC4AF0B;
	Thu, 22 Aug 2024 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724324430;
	bh=b44f+n9+/KKyzs0nbQ9RHOtxwmDZrSkDmFzOIJVNffQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tdXUALGq4Kac2VU0m9YNORjHD7EzPdkVBrd8wV9Pls5wyKBWjmO8rzn3id2OdD89G
	 MALAzQDaEfaxxvh3wCPfhxzfkiWJY1TzMNZt2PoDX11tqwZKLX7GiAGe0OgH4NXx1n
	 xnPnZGC7vagiND4fs4C4a8jW+gJS5G8TVGxsBsU7uCoCPCpzxRQm8cC3hcfxkT0RFq
	 XUcEyOMcFc2YW+Vsu1ZARe89Pj6XrjFed4jhO83r4r1FZCkbEiPRE7Kal+N+0zuVHQ
	 VfYcy8+zYPiYeIbDu4zyZmzrLOHxISkVnfq4zYQx/AtBH1zywcbnd9NVqT1KVIiLCJ
	 Euc35KLhqMmTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFCF3809A80;
	Thu, 22 Aug 2024 11:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ngbe: Fix phy mode set to external phy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172432442951.2287138.5190663016144821900.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 11:00:29 +0000
References: <E6759CF1387CF84C+20240820030425.93003-1-mengyuanlou@net-swift.com>
In-Reply-To: <E6759CF1387CF84C+20240820030425.93003-1-mengyuanlou@net-swift.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 przemyslaw.kitszel@intel.com, andrew@lunn.ch, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 Aug 2024 11:04:25 +0800 you wrote:
> The MAC only has add the TX delay and it can not be modified.
> MAC and PHY are both set the TX delay cause transmission problems.
> So just disable TX delay in PHY, when use rgmii to attach to
> external phy, set PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
> And it is does not matter to internal phy.
> 
> Fixes: bc2426d74aa3 ("net: ngbe: convert phylib to phylink")
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> Cc: stable@vger.kernel.org # 6.3+
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ngbe: Fix phy mode set to external phy
    https://git.kernel.org/netdev/net/c/f2916c83d746

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



