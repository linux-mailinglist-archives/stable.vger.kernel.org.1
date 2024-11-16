Return-Path: <stable+bounces-93619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD029CFB9D
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 01:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E431F24BC7
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 00:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE46F79F6;
	Sat, 16 Nov 2024 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVqdyyxO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753F610C;
	Sat, 16 Nov 2024 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731716418; cv=none; b=XHvFDOW/1QebZPD8Z9cUIHVhJfJY7GhgKfBBoRNfjEGpIaItCw04lP6l73y/vBFJYlqsVwW0b1GQYBLBifFyOIdJcDnP8xjytdhdsZVq2kCktpXm9pKofv9hY2Ajun/2fpPo3EmqWO7BKpnOxt8otUaoqxdVtOGFPPtcO30qxMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731716418; c=relaxed/simple;
	bh=m0P9y5uzjWBx5KyJViLFUiCTpqqo0oDCzfKKh559ndc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AB65srRpajy53y9cfdmNV+KwcvYU3IUwfRJAOid5akqME9LJFFkE3c0wMq6eX3eFecamecsLbJEd8jV1v+gLR8MLdR4QXu6p1fV3y34hmrpoP/ZhVAffF/NWuBIwf5DxpvHDt5MzaCbVZt5S189kZ5OLKw2sIsdIvgyoMzF0E3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVqdyyxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD30C4CED8;
	Sat, 16 Nov 2024 00:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731716417;
	bh=m0P9y5uzjWBx5KyJViLFUiCTpqqo0oDCzfKKh559ndc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SVqdyyxOrql21t8B3oNaUItWO7RMY7E/YVO9+/xC/vfyhBcMc3vcHbSbl9d01gjXV
	 VAUsIz9pYYKWJPJNyVmyW5qFDAfX5qyOqYdb2pwLCQSSCQLxGps5IrXwj3RZXugZ7L
	 SGWy2xbauZp3m5fXsB4FV6LHLmpE6PaHNxl8Ir3hBzfuLbzR/I94ix+1Vs5BQL6Axl
	 UAh89/q7S7BAHwyQtkO+28APEg3hz52Bi8uDkCOAnr8Wy0iu6C6CS/0ratc5kVden6
	 53ItggshuQbrdmNVgl4L5jtaXRmzM9E6vVPe3HYW+7Pd7vTc3KRRh5CaAClv9AunrD
	 0LKFx4zo6visw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACD13809A80;
	Sat, 16 Nov 2024 00:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173171642849.2779297.12522283090326488509.git-patchwork-notify@kernel.org>
Date: Sat, 16 Nov 2024 00:20:28 +0000
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
In-Reply-To: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, colona@arista.com,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 borisp@nvidia.com, john.fastabend@gmail.com, dcaratti@redhat.com,
 kuniyu@amazon.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mptcp@lists.linux.dev, 0x7f454c46@gmail.com, stable@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Nov 2024 18:46:39 +0000 you wrote:
> Changes in v2:
> - Fixup for uninitilized md5sig_count stack variable
>   (Oops! Kudos to kernel test robot <lkp@intel.com>)
> - Correct space damage, add a missing Fixes tag &
>   reformat tcp_ulp_ops_size() (Kuniyuki Iwashima)
> - Take out patch for maximum attribute length, see (4) below.
>   Going to send it later with the next TCP-AO-diag part
>   (Kuniyuki Iwashima)
> - Link to v1: https://lore.kernel.org/r/20241106-tcp-md5-diag-prep-v1-0-d62debf3dded@gmail.com
> 
> [...]

Here is the summary with links:
  - [net,v2,1/5] net/diag: Do not race on dumping MD5 keys with adding new MD5 keys
    (no matching commit)
  - [net,v2,2/5] net/diag: Warn only once on EMSGSIZE
    (no matching commit)
  - [net,v2,3/5] net/diag: Pre-allocate optional info only if requested
    (no matching commit)
  - [net,v2,4/5] net/diag: Always pre-allocate tcp_ulp info
    (no matching commit)
  - [net,v2,5/5] net/netlink: Correct the comment on netlink message max cap
    https://git.kernel.org/netdev/net-next/c/e51edeaf3506

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



