Return-Path: <stable+bounces-119609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7279A453F1
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 04:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BDA3A9B43
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 03:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4261525487D;
	Wed, 26 Feb 2025 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evGivSet"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB047254866;
	Wed, 26 Feb 2025 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740540007; cv=none; b=XB75i4JlJpvkSh8iu56vZ3cuP9U9WBCkXQd5HIktMdbG1NQwfRrEm3tC/hB8MRFj0pUAm5Bwa1OOBaqD5L9Vej4hff845nyawYA+v3bpQwNwyGozFXFb7Ez6BqS97wrVc5YlatvG6w+0xQuOkHmq/1YWj2PHHuxnFqVvV+gtM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740540007; c=relaxed/simple;
	bh=b5k6tZ8dJznrloCjwHORdnGfkAbX6eoHM8nK7ig9ZW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZZQ/khMaYfYfUrtBv3TSbjdqrqKTT1yRfnjmhJJBD0CyZlXvkJWmp6/iEKDtrkeX95NYLPMwsw+MgsiTSv/ZQefwVNzHY3s7cQJ9Cp4useBF50Fr9px17TV2OaZv6ddsVMvwqeqwiaYkgacMcTArJwRrBODtuNKcsdzk25Fh3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evGivSet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CBBC4CEE4;
	Wed, 26 Feb 2025 03:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740540005;
	bh=b5k6tZ8dJznrloCjwHORdnGfkAbX6eoHM8nK7ig9ZW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=evGivSethRPF2BMsaDGeBD1K93cwOyjHPTjg3dQQsi4Q+Zqg20Du8/oWBOC+r2MjF
	 il8Q1MuQNUGDCJ5uihZLZ4EfAUR+fWz+p55xbOw/+EGeeT1EHkX199ntARZE4iiSMA
	 UVthK0+g0M8eZdT7/aKiwXYmW5Dc/rQvM9nibBg9+egdFiB4KBf0NSnKeTPVLTJ1pR
	 USyJPe6IE4xEXZUsm+UA+cgSH8PF4QKtds5BFP2PT4HFhihZIjp4Tx9lRRH6lujHdC
	 zr7iWgNy7S0nHmidXeFK3cnfvAjlRhRa5S5+8vL6VVGCM3FOuN+5eMj5UxbyjVcA/X
	 xkB+SUdXxyVfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BAC380CFDD;
	Wed, 26 Feb 2025 03:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mptcp: misc. fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174054003699.219541.10470016824852701686.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 03:20:36 +0000
References: <20250224-net-mptcp-misc-fixes-v1-0-f550f636b435@kernel.org>
In-Reply-To: <20250224-net-mptcp-misc-fixes-v1-0-f550f636b435@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 syzbot+cd3ce3d03a3393ae9700@syzkaller.appspotmail.com,
 chester.a.unal@xpedite-tech.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 19:11:49 +0100 you wrote:
> Here are two unrelated fixes, plus an extra patch:
> 
> - Patch 1: prevent a warning by removing an unneeded and incorrect small
>   optimisation in the path-manager. A fix for v5.10.
> 
> - Patch 2: reset a subflow when MPTCP opts have been dropped after
>   having correctly added a new path. A fix for v5.19.
> 
> [...]

Here is the summary with links:
  - [net,1/3] mptcp: always handle address removal under msk socket lock
    https://git.kernel.org/netdev/net/c/f865c24bc551
  - [net,2/3] mptcp: reset when MPTCP opts are dropped after join
    https://git.kernel.org/netdev/net/c/8668860b0ad3
  - [net,3/3] mptcp: safety check before fallback
    https://git.kernel.org/netdev/net/c/db75a16813aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



