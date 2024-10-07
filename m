Return-Path: <stable+bounces-81488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26877993B51
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 01:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19F31F24791
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 23:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1388B18FC7C;
	Mon,  7 Oct 2024 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/nCKZ8P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA6418B462;
	Mon,  7 Oct 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344430; cv=none; b=GW2dd21GCUmuiuYw6nTkv8Jl5MX82u2m7/1dOtJw2aheJqTdfPdmQnNh0aT4TM3MJ3gylQLBfygNqfbcCDNzh+/yQe45Bvz6tkO33S/Fvn4kNwA7/1uJTKnTCwkWh9k6U/TaTCrezHXmLOxdz4zCmWdGFtVcPKHlDG7x+7l2aMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344430; c=relaxed/simple;
	bh=x0baMJr/GgaMmqouioll1yWre4Lku0Oyf/+TT6McNi8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gUZO0Uf4RDc73ON6sHhxWrBOQ8mVDwPz58ddG5ygYqrI68X4Pbb54lBbKyQtZivaiC4bsIqWy/cc9HBvfNwDeukX1TL7QWcDJtn6EB8qimuThafA/J2wjDldhnf7blX/jPmKo3+78jiAAMYy0CyCo96kM/qZdgYuv9fXEGqRSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/nCKZ8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E78C4CED0;
	Mon,  7 Oct 2024 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728344430;
	bh=x0baMJr/GgaMmqouioll1yWre4Lku0Oyf/+TT6McNi8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R/nCKZ8P/nISOXC+3XkFcgvkcIIM9WvyKo8COPffPeLZ8+E5Oe6SGEF+dct+FdFs0
	 13I9Ha8Vgy1FjDJyV7YbrYbisWKY8rEnbOsC2zW6ZAXH8VuxIr6kIjwqctyK1t7SkI
	 N4xU+XkJiyeCNIi/EZFX+juYMY4MFD2mP0b5QG4jhgs3IjNRIxYvjxhruoWnHm0rGK
	 IZ5w5T/u2XrZcVEOz1tABK9dnWZ1Lq6PkxikwslSZize5D7g/ClAWlrf8WfvnY4tao
	 3MNK86qgIih8XWAQ/LCJPoR9AS2Me4ME9afDaULZaOzLqIZmmeazFeih541RlhzcPI
	 QLKRAIrplKBDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F7D3803262;
	Mon,  7 Oct 2024 23:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: explicitly clear the sk pointer, when pf->create fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834443426.18821.6784989888047565340.git-patchwork-notify@kernel.org>
Date: Mon, 07 Oct 2024 23:40:34 +0000
References: <20241003170151.69445-1-ignat@cloudflare.com>
In-Reply-To: <20241003170151.69445-1-ignat@cloudflare.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, kuniyu@amazon.com, alibuda@linux.alibaba.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Oct 2024 18:01:51 +0100 you wrote:
> We have recently noticed the exact same KASAN splat as in commit
> 6cd4a78d962b ("net: do not leave a dangling sk pointer, when socket
> creation fails"). The problem is that commit did not fully address the
> problem, as some pf->create implementations do not use sk_common_release
> in their error paths.
> 
> For example, we can use the same reproducer as in the above commit, but
> changing ping to arping. arping uses AF_PACKET socket and if packet_create
> fails, it will just sk_free the allocated sk object.
> 
> [...]

Here is the summary with links:
  - net: explicitly clear the sk pointer, when pf->create fails
    https://git.kernel.org/netdev/net/c/631083143315

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



