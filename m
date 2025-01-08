Return-Path: <stable+bounces-108028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69072A06534
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 20:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F501888CB8
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EF41AA782;
	Wed,  8 Jan 2025 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PusWFz89"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B986333;
	Wed,  8 Jan 2025 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364018; cv=none; b=qe9KgCKkMYtNKQnCenTlbP+T14FU55rQiGgRdtuWANSoqbJ+S8c951iY5AUpN6id+eYOs3JfBtazUtrSNfNYyzjhzTwXnpj8C9CU7IQNN+XIr0kLJsrLmOdaJ+9iIo0/L2oAetzoDj4um/BvvUfhhJ5H6CdGovlXt939GB+OjFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364018; c=relaxed/simple;
	bh=jdwOVI7CVc/SzN+r3JsnfvKoQpR6mVfdIuoM9oNJGMM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Stlb6rQxrOuCKpLAOfxN261Oy/BSaY80Gq3vcGB2GSqLdnMa6sM5NnvG2o1dirRiTdSRMsrvr+mBc8aXrGoB3pk+UZTMsjO+ADclfXG6Q4z/QzAkios7aoTOYonWIL6gPBwUvQzT02E1vpv/blUUCyDyidqTkRBjc7FtyZIRvyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PusWFz89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EA1C4CED3;
	Wed,  8 Jan 2025 19:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736364016;
	bh=jdwOVI7CVc/SzN+r3JsnfvKoQpR6mVfdIuoM9oNJGMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PusWFz89YF8yx1kttoag9M2DfqocMu0t6LjS2KzxXad1yBgMohI/DmzbBsg2eNb2S
	 HCuColKKzLERYRnAXCUFOo06F46VW3nNiBAxHa4kXQ4/i40jnHHmy+tiIjU1YYzhaA
	 U84wDSTFYPCYzH3bmqNWTQ7nckbkWR+cXmyRhWEuyWz/xuigVIQo55hGKqXC1Hrxwq
	 FAy29HApoqP1hJaVAsa0Qmy7fDnH5sTgQMol/H1ZexqHiaoTr1ByvvENfH9Kd5AqCb
	 +tqDSLtJKtecfUJhDOjXYoh0iLhjS8dW6gOjDJltDbm9ykChm1BBKqMjxjb8y3C3sV
	 L3O1xeQFaJo9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E54380A965;
	Wed,  8 Jan 2025 19:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdev: prevent accessing NAPI instances from another
 namespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173636403830.752119.6938912950899150718.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 19:20:38 +0000
References: <20250106180137.1861472-1-kuba@kernel.org>
In-Reply-To: <20250106180137.1861472-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, stable@vger.kernel.org, jdamato@fastly.com,
 almasrymina@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Jan 2025 10:01:36 -0800 you wrote:
> The NAPI IDs were not fully exposed to user space prior to the netlink
> API, so they were never namespaced. The netlink API must ensure that
> at the very least NAPI instance belongs to the same netns as the owner
> of the genl sock.
> 
> napi_by_id() can become static now, but it needs to move because of
> dev_get_by_napi_id().
> 
> [...]

Here is the summary with links:
  - [net] netdev: prevent accessing NAPI instances from another namespace
    https://git.kernel.org/netdev/net/c/d1cacd747768

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



