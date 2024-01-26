Return-Path: <stable+bounces-15854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCBA83D1F9
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 02:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716331F280C5
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 01:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44A1EDE;
	Fri, 26 Jan 2024 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzQU70hZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CE10EB;
	Fri, 26 Jan 2024 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232026; cv=none; b=pYUDXxtVGxUI7+VrD79sxNXPSvr+IX4NVm1uTyAeBOd5YivHk2quL+NfBxdoFWffpsNGFjfe28hnrcbQslmE8Fu5Y2HB3g4xPdwooSoNg0Zq4LeiYjRgUeGKLCmoCT7FgeIIA5MsvGZyL7xdLp/VkGk5hthK3cb2V5u9Tb+GSHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232026; c=relaxed/simple;
	bh=4iLoBqaccVX5n9tGRz8vuNGgChim58LtYaOmr57xmnU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IDDC++Oee22F9JQIfCkHJA8YXmkxrnWkT95ARl/L7ELTkDS7Z2GkQfBRWBjXBCQZ9y5oaB8Bg7YMRiEpxnqFy0fnB7tJkhLIQKWXYDxv2pWUnRMBMUg+VScYGcNtl7dCP5p/hWWxOFNkfFoneXpOBiDmcqoGsbbr4wC2CDPU444=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzQU70hZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13EC1C43390;
	Fri, 26 Jan 2024 01:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706232026;
	bh=4iLoBqaccVX5n9tGRz8vuNGgChim58LtYaOmr57xmnU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qzQU70hZl26D4Cz0F+P9dFyzDZ+2okyr+3N4FAU8o+Yvi5GFp5zzeArfJjlVID/xh
	 xiC0F+aVBSY+wpmb23rcbA0+CcpkOUG2GD+ITHUQVpEYevWoPTRkGyWp6yApwsuqww
	 z3qUwJsZh4tN6AZPd7IogdpKLRlvm7O404GbJExexVQUvrjV08nEZQ23Yc7JWJ4AL8
	 jpGsDANRIuohf7Fu7wZwtQhHOBrInS4J09cDh3r2f62T7FYUYKBYn8bDrkRyoi3Q/5
	 bY+vDnjCStmSUdkXwarqxeTqkf0ibVIQZIy3ozEWlgwY9pbSuaPKfmue5/L53UqM1L
	 tiBcX7m6UDr/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0836D8C966;
	Fri, 26 Jan 2024 01:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] nfp: flower: a few small conntrack offload fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170623202598.2360.13683555867705748519.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 01:20:25 +0000
References: <20240124151909.31603-1-louis.peens@corigine.com>
In-Reply-To: <20240124151909.31603-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 hui.zhou@corigine.com, netdev@vger.kernel.org, stable@vger.kernel.org,
 oss-drivers@corigine.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 17:19:07 +0200 you wrote:
> This small series addresses two bugs in the nfp conntrack offloading
> code.
> 
> The first patch is a check to prevent offloading for a case which is
> currently not supported by the nfp.
> 
> The second patch fixes up parsing of layer4 mangling code so it can be
> correctly offloaded. Since the masks are an inverse mask and we are
> shifting it so it can be packed together with the destination we
> effectively need to 'clear' the lower bits of the mask by setting it to
> 0xFFFF.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] nfp: flower: add hardware offload check for post ct entry
    https://git.kernel.org/netdev/net/c/cefa98e806fd
  - [net,v2,2/2] nfp: flower: fix hardware offload for the transfer layer port
    https://git.kernel.org/netdev/net/c/3a007b8009b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



