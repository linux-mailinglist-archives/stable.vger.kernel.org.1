Return-Path: <stable+bounces-93613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD219CFADF
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 00:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468DF1F231B8
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 23:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D4C191478;
	Fri, 15 Nov 2024 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwmNNnBq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD83E7346D;
	Fri, 15 Nov 2024 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712220; cv=none; b=In/Ch0Hzndtdhzyg3xGtUZijicgLqTC9s5mN1ra6A7twk8+98Fr0amJJkr4FVfN9a4IucxmExS5VXJLLfEJIwJiP2PL3CDXeZxKjAoYfkYrWqzJKfLTYvlAxlFllPK8XQa7UU8/qdJoU1xP2SBFNsXq6Jr0M0WJni435gV3r5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712220; c=relaxed/simple;
	bh=nUvU/2T1UyMMWOr6LAGSyFuqlEniOp8vxKesdl1aUbk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n8YHBcfJF8b/dz4vjmEwOg1W9lbvyfhKJiC5shlCcaHy5L8euFPB5RtZmyuclXq5BLXaO5cwvp411l+DafzX71zYfhLC/s0Ihp4uAleuh32p+8YmcXLre5U4ee3K0ACM1Mrm7sPWYb8NtX+oPOFCiRy3wnse8mD1Z4xMoMt36SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwmNNnBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E45BC4CECF;
	Fri, 15 Nov 2024 23:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731712219;
	bh=nUvU/2T1UyMMWOr6LAGSyFuqlEniOp8vxKesdl1aUbk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qwmNNnBqftIRHZ08KSrggV9SHpggIhc4vRHRzj6MAtL8K1xPeqBxeY52Swu7n3RgB
	 M3RThjYu8kagjD9FURY+wa3RGvg07v1tXGbsDC+kP3Vm1ApbpRWkXnKVfI9Jn0eEeg
	 2wnDGkl8UibXDe4nxFSLZjwyTeIEgAvVtvvd1Pe/YzftXmiwh0hbIq8skKLFTdaCy1
	 ND0u7tKxs2B3ymnONmEv+UOhTUDCIULJd8V4FSvg3rPhnEedyDqtUnbqDSBIT0jBcb
	 hYuVkuWY0U5taLRvBH0gW5oFPZ1EnuLpyBic5UpDeD9s3bOOUygEbjUBBlBVweviK3
	 kDxomrTDjBzyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C483809A80;
	Fri, 15 Nov 2024 23:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] netdev-genl: Hold rcu_read_lock in napi_get
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173171223026.2762542.16202293496452130532.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 23:10:30 +0000
References: <20241114175157.16604-1-jdamato@fastly.com>
In-Reply-To: <20241114175157.16604-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 amritha.nambiar@intel.com, sridhar.samudrala@intel.com, kuba@kernel.org,
 mkarsten@uwaterloo.ca, stable@vger.kernel.org, davem@davemloft.net,
 horms@kernel.org, almasrymina@google.com, xuanzhuo@linux.alibaba.com,
 sdf@fomichev.me, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 17:51:56 +0000 you wrote:
> Hold rcu_read_lock in netdev_nl_napi_get_doit, which calls napi_by_id
> and is required to be called under rcu_read_lock.
> 
> Cc: stable@vger.kernel.org
> Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] netdev-genl: Hold rcu_read_lock in napi_get
    https://git.kernel.org/netdev/net/c/c53bf100f686

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



