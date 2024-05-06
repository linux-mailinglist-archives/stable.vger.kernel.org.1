Return-Path: <stable+bounces-43113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A008BCF55
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 15:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657381C22CFC
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BD978C75;
	Mon,  6 May 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkxSzozd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F31DA5F;
	Mon,  6 May 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002828; cv=none; b=tc7BZdngeYhF9E67gNlrGA9ppu9yfeikSZvCPWeZTm6va9JqVdS8hcim6OKf0CoCVmIt+2AT6lFCEYxZXeJsglAbbB+GA+UzrLtxoEiREqkJzKU1DPEW7KZhIBT4wvxl+Ak/cxWDvAN0sjf+OxTtoYxt6EOvDjXSaYahULniAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002828; c=relaxed/simple;
	bh=zpVI6f93CROw7wNImVnclUnK5FlwpQd0wrDB1pjdnFI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LVWX2xbiDhB6hZIHRe2fC3qqAoG4t+Sj9eGsq838bY/7VAWNEcAVBUuRK95XNwBLL3UYwQHWXtoDJknag43S0k+LKS5aREm3RYfTFPY8Wf6AE3x68InsX/tMykJcvF/tbCkldQNXGcsiOxvlFgK6NpUm6m3c/I8kMymZHchItPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkxSzozd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2CF8C3277B;
	Mon,  6 May 2024 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002828;
	bh=zpVI6f93CROw7wNImVnclUnK5FlwpQd0wrDB1pjdnFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YkxSzozdcySKrdF/nYa9PppQpxXKGKGmUSbSZF0a8k+SNY636/BaPO789loAHTYYL
	 rGtGGPUfLcqK5eJCjBcO8RK+wQRqcX0nCHe0WQ6N8ZB40p1+qASA6yJJeCxxtFcHti
	 VPAMiu0jjzupX+Zbnq7evIlvtVxc22qLIWZgjCrHfHqyZ10zqOUmN/8Uy66JrvJYFq
	 HjJbRQ6nwVAlBe3DP8j5ZT8O8lpzwzMojjiwnKs5lmtX3audXddCcdmucIH0KFiisO
	 kq+zHI3V/PknNGNupUc2hjvfz/ZsGMkb8vWETbGf8pKp2VJB7Yr3LCjU/AWKfOr+vm
	 E1IYKiPZTKCuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF8B4C54BAA;
	Mon,  6 May 2024 13:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: fix out-of-bounds access in ops_init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171500282791.18962.18107308487958353517.git-patchwork-notify@kernel.org>
Date: Mon, 06 May 2024 13:40:27 +0000
References: <20240502132006.3430840-1-cascardo@igalia.com>
In-Reply-To: <20240502132006.3430840-1-cascardo@igalia.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com, kernel-dev@igalia.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  2 May 2024 10:20:06 -0300 you wrote:
> net_alloc_generic is called by net_alloc, which is called without any
> locking. It reads max_gen_ptrs, which is changed under pernet_ops_rwsem. It
> is read twice, first to allocate an array, then to set s.len, which is
> later used to limit the bounds of the array access.
> 
> It is possible that the array is allocated and another thread is
> registering a new pernet ops, increments max_gen_ptrs, which is then used
> to set s.len with a larger than allocated length for the variable array.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: fix out-of-bounds access in ops_init
    https://git.kernel.org/netdev/net/c/a26ff37e624d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



