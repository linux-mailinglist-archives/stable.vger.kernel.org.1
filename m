Return-Path: <stable+bounces-104170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA319F1C6B
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 04:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E017A0547
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 03:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF11626ACD;
	Sat, 14 Dec 2024 03:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaLAIVOw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00531B59A;
	Sat, 14 Dec 2024 03:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734147612; cv=none; b=kRBQpd1KLYfv+GCdBUYxsFuBaRI3DifsOM6n9kIGhlMP0ZpcXdDwbPXsFz+ZPaLvUrH9j9JbWHqJW6KiEe2GvISxcO7+YBukzAkIaiv5ws1EuNGANf7PupwOgutcfD8bHQTWoUYvq+6aGIgLjOxo239azz41dyZ4yQzCg8F5Yg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734147612; c=relaxed/simple;
	bh=z2nr/broosVXgQiDTmlElLkXP9jNgl2eOogiAPn9JkE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f2aGh7unPcVN/tW2pSBiN+dAqMJGG+6G6vxavfeybnFNAXuV3FLA44wTP0eZOvIEaYCKmsotYU2ysIqT/aFf+MxUNtLD7XyBWmS1V1RfwIUeSfbxkH9w/KRykSlza/3wkUC+1opR6RG7xvV5Odf0u8Lma6UevyaxKRtz6XZpWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaLAIVOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77426C4CED7;
	Sat, 14 Dec 2024 03:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734147612;
	bh=z2nr/broosVXgQiDTmlElLkXP9jNgl2eOogiAPn9JkE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IaLAIVOwQN5/PMSoVEzQh4UhkkKhq+O53DXaGhuT1NFTV1rBc/2TAMlf2KBquJDBu
	 q/bgJeKCd5CCJY4iSGh/zlMMGPti9pnzl756kiRbJl+Yeh2j+RvJcjyLVLrGYxkb2k
	 Nl6OAvA4nZA9nSOT5KgtR8LhqZrqIDERw4VBhbSXBqOB/iPZcATiYvqwYFx26szxSA
	 dD++qCb2gw8ORf0NG8Lq99MefffaiEMY5mMiPFzChgJGNm0OSVfTMCgcbpXaD3egES
	 mUnIXgrsde5CWlAGK9N8yqf66u9aqcVn4QLviiM8ucZSH2MMWzAQQu0X9GLfmzOm9Z
	 4z7rYiZlqBSdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C69380A959;
	Sat, 14 Dec 2024 03:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: tun: fix tun_napi_alloc_frags()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173414762902.3237238.14285592138612964595.git-patchwork-notify@kernel.org>
Date: Sat, 14 Dec 2024 03:40:29 +0000
References: <20241212222247.724674-1-edumazet@google.com>
In-Reply-To: <20241212222247.724674-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com,
 stable@vger.kernel.org, axboe@kernel.dk

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Dec 2024 22:22:47 +0000 you wrote:
> syzbot reported the following crash [1]
> 
> Issue came with the blamed commit. Instead of going through
> all the iov components, we keep using the first one
> and end up with a malformed skb.
> 
> [1]
> 
> [...]

Here is the summary with links:
  - [net] net: tun: fix tun_napi_alloc_frags()
    https://git.kernel.org/netdev/net/c/429fde2d81bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



