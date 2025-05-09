Return-Path: <stable+bounces-142960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88ADAB07EA
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 04:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BF83B3ED7
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 02:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F4224466B;
	Fri,  9 May 2025 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qriJcg6U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7303A13E02D;
	Fri,  9 May 2025 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746757789; cv=none; b=FCfKjUiAz+Bo/cYMKesBbD9TvsUk3bB/5RMshjNqtozSQlwgP21qOYmDiui7/dCMTtggs41CLArEL+IWhWNMWa72uKnen8mCG0O5OU66ihx/TQPRSlzZdkMxSIRddGQJcKfaBUoZ0z2UCw+g8RWaWeBuXmvmrqbHrnhD4vmtpyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746757789; c=relaxed/simple;
	bh=ruRY58xeWEGRGJE+Dan+m3v9azmAAyvJZ5rGtjAokdk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jNJrWDhh+4DKaKh5T9i3Tm6ycwA4Z/GfcEa1RXJ+wEGK0BbBwSHGFLDwyeNPoaOoisy8+9gvJYlBtDnk7jJBK/uZmtoY1yufDfuLgJfT/E7ByGrdjd3SmIpub9EwfUVjSvrYLEV7EdZkNoAJDL1ymMV117eEmn0JH5TLp3m/xcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qriJcg6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3EFC4CEE7;
	Fri,  9 May 2025 02:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746757788;
	bh=ruRY58xeWEGRGJE+Dan+m3v9azmAAyvJZ5rGtjAokdk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qriJcg6UBDa+DAJFcCtM3wux3JQZKRLoXWwwgzHSkjMVVhyrASw9Zr+/wQ81Hxyk2
	 La2pb0ZOpt8uE1pU4tzOZkPYtySBTHy5Oc03d8yf7ZDFDtKQYIUXxek5X8YHCT9BDK
	 Cdq3+zzrRoeQsoGQ8Ox/m9tbGajMUyHyfN6rCpC+B5O6VMmwrYeCrifUBM+Vahqw4/
	 YfgMqYx1aR5gnZhuPZTMV9vV23Y4RdLMFjmyoEzHIx150qu56ynpz+Og2zTUVGUmDz
	 4+0SE9cpt+6kjdnczbrsMFTt/fqHgF729+TLtfJ5E6ysoxNmKu6gTUoV/3L+6Idjt8
	 IS5O5rM2rGNIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBB3380AA7D;
	Fri,  9 May 2025 02:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: qede: Initialize qede_ll_ops with designated
 initializer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174675782750.3105310.13342921805980013362.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 02:30:27 +0000
References: <20250507-qede-fix-clang-randstruct-v1-1-5ccc15626fba@kernel.org>
In-Reply-To: <20250507-qede-fix-clang-randstruct-v1-1-5ccc15626fba@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kees@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 07 May 2025 21:47:45 +0100 you wrote:
> After a recent change [1] in clang's randstruct implementation to
> randomize structures that only contain function pointers, there is an
> error because qede_ll_ops get randomized but does not use a designated
> initializer for the first member:
> 
>   drivers/net/ethernet/qlogic/qede/qede_main.c:206:2: error: a randomized struct can only be initialized with a designated initializer
>     206 |         {
>         |         ^
> 
> [...]

Here is the summary with links:
  - [net] net: qede: Initialize qede_ll_ops with designated initializer
    https://git.kernel.org/netdev/net/c/6b3ab7f2cbfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



