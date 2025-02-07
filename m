Return-Path: <stable+bounces-114194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA687A2B7E4
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 02:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D431673AF
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 01:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59639139CFA;
	Fri,  7 Feb 2025 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4+lgdBz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131794C6E;
	Fri,  7 Feb 2025 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891805; cv=none; b=KZMbHjKk+1V4oWlEzaeUTiVXC3lgJqemYf6b8FKNQrqXdO2sImhZdkUP13pIRcajHEDx3eWyMgZpjgRX1Msij4s9Jo5OYSoVy9Cc/ZJJvxSDdc8HP1syy5rilA3p2xBRjUotavSxanEXauhPQSyDjj+nWmcVaH4mVxBNI4TVeLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891805; c=relaxed/simple;
	bh=r7URMYvSbFSh9hdd9YhFOLAKhIuXQ6O1LB4qURNctr8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pk2/7Vuulm+gfDVXeL+SUoZ03U86wMS4blu2S3O5+avW/qfWSDV1r0lS75l7QJ4vJKsD7JG+CKCLXJrFozSP1CyjpsIyhpFCWk7COlxYxDgj3UemmGB6NFuuv8TGx8kSa9pthZYVQ4iIPKcvJqrH+oFFNbH+p/v6Iew95Twnkv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4+lgdBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A4EC4CEDD;
	Fri,  7 Feb 2025 01:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738891804;
	bh=r7URMYvSbFSh9hdd9YhFOLAKhIuXQ6O1LB4qURNctr8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h4+lgdBzSVnM/xbMxLPA+/rXwj8rO5jelryqOJf/BHNt05uoaVaxOiie1szb23IYT
	 0hlwsbd+jqjIYHSlMQJgMkjFXlLpLY7kgSjY7LfGVetvwMnbBkDRLbbAZeR1Loavga
	 7ecxbRytc1v4cfgNYVBxgscvzTfab1naK+M8Nyufh8fEvi0innJ4WTOvQ5wR9qdnCc
	 k22UaVsFPsyHGE4JpzutWJOxJ0fahIScDBCvcPVJdlw0fR8N0sCsVePdJRLbcS53s1
	 09LVBZj+4/QV/5By7nPKj2n4JUx+ya41bV3UDKtkTjXPPbbtToXWKuZitZombJxlyR
	 /l9SCjjBBcCmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71515380AAE9;
	Fri,  7 Feb 2025 01:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rtnetlink: fix netns leak with rtnl_setlink()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173889183231.1726849.8036843600319862341.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 01:30:32 +0000
References: <20250205221037.2474426-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20250205221037.2474426-1-nicolas.dichtel@6wind.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, kuniyu@amazon.com, horms@kernel.org,
 razor@blackwall.org, netdev@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Feb 2025 23:10:37 +0100 you wrote:
> A call to rtnl_nets_destroy() is needed to release references taken on
> netns put in rtnl_nets.
> 
> CC: stable@vger.kernel.org
> Fixes: 636af13f213b ("rtnetlink: Register rtnl_dellink() and rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP.")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> 
> [...]

Here is the summary with links:
  - [net] rtnetlink: fix netns leak with rtnl_setlink()
    https://git.kernel.org/netdev/net/c/1438f5d07b9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



