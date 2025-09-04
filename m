Return-Path: <stable+bounces-177739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F718B43F4F
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 16:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3F60B60354
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 14:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C5830CDB0;
	Thu,  4 Sep 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzr1AFe3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DBF30C341;
	Thu,  4 Sep 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996825; cv=none; b=aX6TnKsOr96rVY4FVuas8BIwKAhUUVh/Zk7GXreCkxHZBg2KTlXlx1KmanlutsBorAygCfERQYfnmL9Y91fPvwqJ9SK96kIY7740UaRfQMluEqL7Ex7cqqKFVgKjQNYK+xIRE7S5IY69vuIfcl6gLWXnZ3Yc7y+JvAvHoDYj4Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996825; c=relaxed/simple;
	bh=TBFRnhMRgAXSe3LCtzGepyvZUvc13K9Ht6o2DOKRDgA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jmh3x3IcAI5ojyM6D7K8xZrGHQ3KrEFA9zmHgF5TY8XDCrddaM8V2MbuMEG8B2oAjVpOJFvEyZDUGWO71YuJs5eeJ9jyQ93mogkMZi3ldXcubQDxxhFOabJqdsrbOQeAXfnOsCOLzu8bfKiK2ATaWQh7sB+Sr58m2IqF5i5PndI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzr1AFe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946EDC4CEF1;
	Thu,  4 Sep 2025 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996824;
	bh=TBFRnhMRgAXSe3LCtzGepyvZUvc13K9Ht6o2DOKRDgA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qzr1AFe309zcuwINaVjDTJpPHHWrJ/8Kaqnd+sgG09cF9Z0F4nhpTMfHqmNzrJFii
	 NombqeJZqb9agmtAM13Oczcd1VeQlhIj8SHtBLJO4p0PsDXcTsStOW0eaAwB+sucm+
	 NsPTmKAo8fnR1Apw+MWUPMy2b7WNTiwRZPRkYyAMDWj/ir9hBb8/TUqSD6enHtW0p8
	 hCT0UOyTGqeFl8A8zcb0n+N58DGifceplxRdcPzRRG22XxNEpYwZLGq3HBWxTlJl9s
	 opegY5P0mUk6HlA/UUw3Y3YYsWJxO6Bt8sDzz++pFnbALIN6x2UjPSXXuEXY6wOsWz
	 8PJUGYaOBPOOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFFB383BF69;
	Thu,  4 Sep 2025 14:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: xilinx: axienet: Add error handling for RX
 metadata pointer retrieval
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175699682925.1834386.13423794125453117971.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 14:40:29 +0000
References: <20250903025213.3120181-1-abin.joseph@amd.com>
In-Reply-To: <20250903025213.3120181-1-abin.joseph@amd.com>
To: Abin Joseph <abin.joseph@amd.com>
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, git@amd.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 3 Sep 2025 08:22:13 +0530 you wrote:
> Add proper error checking for dmaengine_desc_get_metadata_ptr() which
> can return an error pointer and lead to potential crashes or undefined
> behaviour if the pointer retrieval fails.
> 
> Properly handle the error by unmapping DMA buffer, freeing the skb and
> returning early to prevent further processing with invalid data.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: xilinx: axienet: Add error handling for RX metadata pointer retrieval
    https://git.kernel.org/netdev/net/c/8bbceba7dc50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



