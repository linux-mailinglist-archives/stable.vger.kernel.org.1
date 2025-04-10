Return-Path: <stable+bounces-132026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46560A83655
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 04:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DF04A0219
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 02:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3831C860A;
	Thu, 10 Apr 2025 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtDKrZEV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D4815624D;
	Thu, 10 Apr 2025 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251595; cv=none; b=CPK1wpuujmnb3pZMKCAcppQ2fRmerLNf/fRMVVRDaK4P8QJpMWTU6ATeqs9zhSBImUOLE6nYbVNC1i7OEcIzrd8997es7quIo4N0F2y0IEb8HQ8POxLEYC5k3fm+Mzify4Ej4tL0aPdq2/uvp9d/4rZal3Hr0mNUVwyS34OOLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251595; c=relaxed/simple;
	bh=SD+ghgUp24CKe30QbZqObPCHvc9jxW+a+P0BVX6tKsg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H1ebfgflFxJLlACQXYd2b85jg2//Qf+9MiwXTFHSpm/UgSbFir2ss0ebbgULTtPgdHgP1yHFgWGYkHLblwmKCgoFVsX8WlBQ8+0DieGkW+dKjEiDsbEo701s7M197s8ya/QBtYN6pnaGkicnlla1zXbo97hUOvU/oLhtSLWjQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtDKrZEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C34C4CEE2;
	Thu, 10 Apr 2025 02:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744251594;
	bh=SD+ghgUp24CKe30QbZqObPCHvc9jxW+a+P0BVX6tKsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jtDKrZEVBOvx5MuEyBaDBjwteABkOie1i1sFdH0F+f0MwqQAM8v/+Vqk6Q+6hglCz
	 fA6dYWgnlzj1f4EpvQE8zGjg4YFVe658EigWhhw1xfgZMzaJ9FGvbn3xlP8tkDuS25
	 hajYLWIjyi+ASy4Txa340zI9MdJJfrBdZ+so4yZ1pWLA9BribrPNyBGV8tRSEOmuqP
	 MUQmWQt/KhoJSkBuCctrL30Aa8DbOJjYmMQMU07BOthddKwJWxCwrH8aejmb5TU56T
	 1+27tOVlyVtx1HeDmeHA96KGGvwZUMFpakZX2sWQP4Y3ksP63C3ZhuuSrUvw9tT9rP
	 BfnLuVRTI7oZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E7438111DC;
	Thu, 10 Apr 2025 02:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: Fix null-ptr-deref by
 sock_lock_init_class_and_name() and rmmod.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174425163226.3117389.4180817468978308602.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 02:20:32 +0000
References: <20250407163313.22682-1-kuniyu@amazon.com>
In-Reply-To: <20250407163313.22682-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, horms@kernel.org,
 peterz@infradead.org, sfrench@samba.org, ematsumiya@suse.de,
 wangzhaolong1@huawei.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Apr 2025 09:33:11 -0700 you wrote:
> When I ran the repro [0] and waited a few seconds, I observed two
> LOCKDEP splats: a warning immediately followed by a null-ptr-deref. [1]
> 
> Reproduction Steps:
> 
>   1) Mount CIFS
>   2) Add an iptables rule to drop incoming FIN packets for CIFS
>   3) Unmount CIFS
>   4) Unload the CIFS module
>   5) Remove the iptables rule
> 
> [...]

Here is the summary with links:
  - [v3,net] net: Fix null-ptr-deref by sock_lock_init_class_and_name() and rmmod.
    https://git.kernel.org/netdev/net/c/0bb2f7a1ad1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



