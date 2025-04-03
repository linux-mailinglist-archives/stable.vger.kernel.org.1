Return-Path: <stable+bounces-128157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD13EA7B1F4
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC587A76CD
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C0C1A9B32;
	Thu,  3 Apr 2025 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="al58z1ab"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E2F2E62AE;
	Thu,  3 Apr 2025 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743718795; cv=none; b=YsBRnKWv3PRs5WtrdNqmbYEZQRUFYqqq0tsd0O2aKj4Y5/A0Gn4cDkomEftQpc/mopdinEGWfmaymAXFvBxzU9fMa0AWSLNNDGRyHX21h/TtobCXKTOrZRP2eO7WQskxEuZ6BrybhmbkGl9VQmufH6xctVKzXXPLWcTFC7yRoHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743718795; c=relaxed/simple;
	bh=vthDQTx4BLw79ba0rZiFNIsVzWvtArB7nkNXXqEOkBs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o87/1BYJok4d8hk3pRtHWtOfqKCxuvVdIkNTvh0xYFDbvuiXuTfslanEN2XYeK9ywQKZqBg+CPbLtguteTKNbwjqRvw36Lyz/+CzFimnPHmld6FkmHkfGqHs87ZhfcBVf00PQe8Oi112QKs+yLyPFQkgsw2jxyrUJYubCI7p59o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=al58z1ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC64C4CEE3;
	Thu,  3 Apr 2025 22:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743718795;
	bh=vthDQTx4BLw79ba0rZiFNIsVzWvtArB7nkNXXqEOkBs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=al58z1abrMhAJgYdF32Lcujgh7VnS3EB5rFi7ERL+BAj1odHEZLAt6UKxW5OxBYM0
	 aiCceNAbnF/K7WkFe2s/NqbUiaG8ncd0gohUg1NolE24BA6ehdfrwGo/uEotcIhDPG
	 lKMSCSFc2KFZ43AWNW5YZrmUPOFRSfk9f7skTKFb69gMEB3blcQ7SNNUyXXzIUKD3i
	 AIwgB7VFk+TDBk/KkwXqXJwoAKJb845Ul+OkGGYZO31MevUaHI0he+AL6TuwsX+9l7
	 LqhaCqcTokV+I8ZMEGGfK7iEyHv6FGWM76xVO/pzML6VNF7NS+rd3K6LlNfj2BC+on
	 DBgr9Mh2+RKIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7104C380664C;
	Thu,  3 Apr 2025 22:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: handle overflow when reporting TX consumed
 descriptors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174371883225.2702664.17429369489204510984.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 22:20:32 +0000
References: <20250402001037.2717315-1-hramamurthy@google.com>
In-Reply-To: <20250402001037.2717315-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 pkaligineedi@google.com, willemb@google.com, joshwash@google.com,
 horms@kernel.org, shailend@google.com, jrkim@google.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Apr 2025 00:10:37 +0000 you wrote:
> From: Joshua Washington <joshwash@google.com>
> 
> When the tx tail is less than the head (in cases of wraparound), the TX
> consumed descriptor statistic in DQ will be reported as
> UINT32_MAX - head + tail, which is incorrect. Mask the difference of
> head and tail according to the ring size when reporting the statistic.
> 
> [...]

Here is the summary with links:
  - [net] gve: handle overflow when reporting TX consumed descriptors
    https://git.kernel.org/netdev/net/c/15970e1b23f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



