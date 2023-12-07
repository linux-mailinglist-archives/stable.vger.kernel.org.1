Return-Path: <stable+bounces-4915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15542808556
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 11:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4CC1F2257A
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 10:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37A736B00;
	Thu,  7 Dec 2023 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0GpJwOS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533E63529F;
	Thu,  7 Dec 2023 10:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C726BC433C9;
	Thu,  7 Dec 2023 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701944423;
	bh=VN5ael7ejZIKhO7wu8DyqQP7P5tXKIv5eQOqK3DVo90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P0GpJwOSjYQJYgtunsRIXTuk45QfxZ06wCJbJkwTk33vBhWmgvdBpZNdtdcz9OhE0
	 ap6r4zWspCDP7Z0lYkESMgMRxUBT3QkP7wPaPlX5BTVgNVNSp657ThihKWmRhexS1k
	 86a/M7agO5O0Ejaw/spq+ihEBKNP91I1nwx2WufZFIMbpvPA+j3dRMM3URi3mJMewZ
	 96zcDfkeY7mH+vQy/Ox+k8FtPXOLe4kQ+IDzq7FgF/WPDyB+dhp4EDOkKLMnyxMSZo
	 rMRaGclLag12tQJXlQUwOiFSo1ABU35AmjojH0cN7hH8U64JZgNDQ5WwIId/JA8Xnu
	 KwNcpTZvapqdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A65D3C40C5E;
	Thu,  7 Dec 2023 10:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfp: flower: fix for take a mutex lock in soft irq
 context and rcu lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170194442367.4036.11698027347829180563.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 10:20:23 +0000
References: <20231205092625.18197-1-louis.peens@corigine.com>
In-Reply-To: <20231205092625.18197-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 hui.zhou@corigine.com, netdev@vger.kernel.org, stable@vger.kernel.org,
 oss-drivers@corigine.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  5 Dec 2023 11:26:25 +0200 you wrote:
> From: Hui Zhou <hui.zhou@corigine.com>
> 
> The neighbour event callback call the function nfp_tun_write_neigh,
> this function will take a mutex lock and it is in soft irq context,
> change the work queue to process the neighbour event.
> 
> Move the nfp_tun_write_neigh function out of range rcu_read_lock/unlock()
> in function nfp_tunnel_request_route_v4 and nfp_tunnel_request_route_v6.
> 
> [...]

Here is the summary with links:
  - [net] nfp: flower: fix for take a mutex lock in soft irq context and rcu lock
    https://git.kernel.org/netdev/net/c/0ad722bd9ee3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



