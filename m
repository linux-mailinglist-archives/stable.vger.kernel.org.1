Return-Path: <stable+bounces-195313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C8CC753FF
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E55CC2ABDB
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69B6361DCF;
	Thu, 20 Nov 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M74yrSbi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3F035E553;
	Thu, 20 Nov 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655043; cv=none; b=IYj1nSbk0mQHdbyDolWnWJQtFQ7vXDCWkFkn7HlIgr4ZkTpZ8e4Zy+ht4X12AOC7aq0UDIWYo/T/tOEZxz85O1FFKAXvQXi9LXit8eZBGV1pz1C5AsiQetF7VITmLmwBSnyLPzRQGP569LcAiUZV5UAe7/jcbmyqQMgVs0+mauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655043; c=relaxed/simple;
	bh=Eb6ynyOtXG61Ezk7YCZHzjM2XgYPekLwM/FoJGDK3oo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PYO00tYKh3NTrAUVcLezaYldmkt+UDaHdEPUrLKWd7O9nMK1t6vHAHYYXU+PpoRttryDtN6sooZjrLMDzEQe3RafESDJWP5v7g6H2VfSJzbU6vDCMvHjUWrC643FZQPhwHvkeTYpZ/wN0Y6Fx/Ai7VlyH+wlphdwWLBUo05qBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M74yrSbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13C9C116C6;
	Thu, 20 Nov 2025 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763655043;
	bh=Eb6ynyOtXG61Ezk7YCZHzjM2XgYPekLwM/FoJGDK3oo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M74yrSbiwOPk8R8LlIfXhct7HD622KPMESzjR5/kvO3QCoAHQ7YRHowHWhUcYvuzu
	 2WraB+ZKGgiaoqVN+yog0Tzki9zg/F03pVqAGAtw7PUXBc57xeD5U2XZ/6MjtidlZG
	 QZwSU6DdxEtR+EPBRAkkdqn9D0gPswUQO8e93HLkSiqfHNRrX1nOblGFvSmmFhHm8f
	 0Df1uia/4ukLeh/WeTanYj8B87ZUCnFG7XnyCNi9EboRaGXQo/i6FrhTIvvA7TkzyS
	 avBfB+qw4x8hUmyvsjWBJBPlPR+GAizOJH8kCGZtGC143uimYYt6PV2rlIeeQe/xJw
	 EpwlzUb5RMGAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F6D3A40FC2;
	Thu, 20 Nov 2025 16:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] be2net: pass wrb_params in case of OS2BMC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176365500794.1690915.6904445190938491859.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 16:10:07 +0000
References: <20251119105015.194501-1-a.vatoropin@crpt.ru>
In-Reply-To: <20251119105015.194501-1-a.vatoropin@crpt.ru>
To: =?utf-8?b?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuSA8YS52YXRvcm9waW5AY3Jw?=@codeaurora.org,
	=?utf-8?b?dC5ydT4=?=@codeaurora.org
Cc: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 VenkatKumar.Duvvuru@Emulex.Com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 10:51:12 +0000 you wrote:
> From: Andrey Vatoropin <a.vatoropin@crpt.ru>
> 
> be_insert_vlan_in_pkt() is called with the wrb_params argument being NULL
> at be_send_pkt_to_bmc() call site.  This may lead to dereferencing a NULL
> pointer when processing a workaround for specific packet, as commit
> bc0c3405abbb ("be2net: fix a Tx stall bug caused by a specific ipv6
> packet") states.
> 
> [...]

Here is the summary with links:
  - [net] be2net: pass wrb_params in case of OS2BMC
    https://git.kernel.org/netdev/net/c/7d277a7a5857

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



