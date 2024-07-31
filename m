Return-Path: <stable+bounces-64692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2D094245E
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 04:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C7C1F24CB6
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 02:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD40101C4;
	Wed, 31 Jul 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6kc7rf0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A8DDDA8;
	Wed, 31 Jul 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722391235; cv=none; b=Nhh9uh7GBoTgmok7DTZ9okkUEjQuz18ygcBi6yAOQVhtCABE6aVoSfm7/Zwdvbk4aCpGLZBqv2Gr712qAvsnhpJkYVfBz0Ucokr8Cq6p6fklPnzCWcX/TYT33Gg0XZ9yWKuRLjMQiLOeC8VssLziJuKXHlpRKbkKSxVSDttqTcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722391235; c=relaxed/simple;
	bh=djAntoi5ZZ/GmzgZtzM4nYNpkZA9StSwwLmpc9+Gfm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MrQmw+RSrP4n6Qec8FxypJqqyA1hG9rWKtyLzyfce+KZKaMp5RRt4Zps8Q18EiMwS5f7P/Uv0jYdXVvoQv6peY66zf29e714HZrHMTeeQN4/dXYsojZKxhfIHzsAYX/sIc3+pr67w8kmi5nTZBOykMrXHU2ngCnSsFhIfqppI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6kc7rf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95B15C4AF0E;
	Wed, 31 Jul 2024 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722391234;
	bh=djAntoi5ZZ/GmzgZtzM4nYNpkZA9StSwwLmpc9+Gfm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6kc7rf0AlL0jk4G8dPYAurZ4BI0XBlL3CSXEIakJqN5xf5zxoQEVJLrMKulr67Vy
	 isHUwyUrTLPbH/xQe4PyV5w7Bfo/b+DHcdM32P5fkk5ZgY4VbGy5Fi0AmBlCpcMzn6
	 dTapoLXK+B3xMT4Jc3LeFar5mq9IIXPoCkZrf40x093cmnH8BhEoUsxKmaBYNabjhH
	 7C1ddEc82cN73yssVMsLR+t0nQVSSAT+usQuYSgD0I7cuYPiGvIDeQh2vgiGDb+LsB
	 VtO8TVg1cEKGw/rEFpW9kTm4XjTO0Rtr8spL0M1A+PMyHNSYncbtjMcTSuQPK8MqpM
	 tWNrBOUCdvlYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8606BC6E39C;
	Wed, 31 Jul 2024 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: drop bad gso csum_start and offset in
 virtio_net_hdr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172239123454.15322.14803499177982622377.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jul 2024 02:00:34 +0000
References: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 arefev@swemel.ru, alexander.duyck@gmail.com, willemb@google.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jul 2024 16:10:12 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Tighten csum_start and csum_offset checks in virtio_net_hdr_to_skb
> for GSO packets.
> 
> The function already checks that a checksum requested with
> VIRTIO_NET_HDR_F_NEEDS_CSUM is in skb linear. But for GSO packets
> this might not hold for segs after segmentation.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: drop bad gso csum_start and offset in virtio_net_hdr
    https://git.kernel.org/netdev/net/c/89add40066f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



