Return-Path: <stable+bounces-100513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC029EC258
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 03:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77ED028470E
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 02:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA371FCCE1;
	Wed, 11 Dec 2024 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAGueN2B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90388C148;
	Wed, 11 Dec 2024 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884816; cv=none; b=q1cFM0jJIS7D7kRDQzd7/a4HNoc4z4/FMrQemOeauFwwdHUFUwGxnZcHcBgrjXge4VtXD8XdGSZ/IBYMu87qCzd18m+V7BEaT1GssSWChCZ5eL8kpfvJ1zwRUAoSEcSqfaf29fRtQVRJ6bFuvO+UAtIZUoCx3K9N2Jcz0YO00p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884816; c=relaxed/simple;
	bh=KWPTezuc2CnyasfCtn0nr7jKT+1IrhtzhpPoRrDrKO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jwFlZ1nM1rMhDIs+/FRIN9jPkQWdLhSSWNjrWyTwrQczQzuRz2lW3lhJ0gsm6+m8mgOzfJBCiSmQ64MaBkqMP2v9RmekeJE84c+n6sRMt+80yN+fU1k/YpzbK9C2OBuFZQ0dOUZvMJCZXN1q2YGw8bc/oMwlk+U2H63HU0RCkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAGueN2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21240C4CED6;
	Wed, 11 Dec 2024 02:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733884816;
	bh=KWPTezuc2CnyasfCtn0nr7jKT+1IrhtzhpPoRrDrKO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bAGueN2BCe5lnWbHDF8+YApAa15WGLZIoVn/q/WG6lySc/V2KjA2zEHaKaDaDc8to
	 +P3XK2ggRziEseKWQC+EzhfL6uc1DYzn/mx5PMkgyI48aFbMj4RVTEbpkyFvK7y7ro
	 wGQlrQwDQLjgDx7epXUvtRMRJKx2nTYOr116Qb3Z42I8IUTvWXj9B5jYEfVf63LDgt
	 ZY7p7A2ryeqNgDMuH/+eE97SHPU7haIVva7GtG5fbCRSaWFBGiRSzvhpZFOZ/l6D4V
	 V7M929GbS5XdCwKzEV0L8ZTLKo2FTshabjt1sh+wN1sV08YYP2xLcyUHGTV3i7QAck
	 Om0oSIXOg4ysw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34213380A954;
	Wed, 11 Dec 2024 02:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: check space before adding MPTCP SYN options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173388483201.1093253.5330438869580330905.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 02:40:32 +0000
References: <20241209-net-mptcp-check-space-syn-v1-1-2da992bb6f74@kernel.org>
In-Reply-To: <20241209-net-mptcp-check-space-syn-v1-1-2da992bb6f74@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, cpaasch@apple.com, martineau@kernel.org, geliang@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, moyuanhao3676@163.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Dec 2024 13:28:14 +0100 you wrote:
> From: MoYuanhao <moyuanhao3676@163.com>
> 
> Ensure there is enough space before adding MPTCP options in
> tcp_syn_options().
> 
> Without this check, 'remaining' could underflow, and causes issues. If
> there is not enough space, MPTCP should not be used.
> 
> [...]

Here is the summary with links:
  - [net] tcp: check space before adding MPTCP SYN options
    https://git.kernel.org/netdev/net/c/06d64ab46f19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



