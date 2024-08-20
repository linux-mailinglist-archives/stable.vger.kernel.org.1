Return-Path: <stable+bounces-69763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD9B9590B0
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 00:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23457285388
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 22:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A314E1C8FAF;
	Tue, 20 Aug 2024 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2yCUJWN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9EE165EE1;
	Tue, 20 Aug 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194232; cv=none; b=VvzECqyNUKeUD2XVesMrOGlrwgA669wy4/rW/bmeOp8sqlNI28zCBpTayHT+KA56TgAXLu9zW1TM43Qb16yrSNo4mfLOwBl6FRQrFrsmBRkav40NIXEtWZ4OHn20ra5x4j9nuUmYkv3uNyeFeN2Ywa4agQi1b548Q4tW1ebaKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194232; c=relaxed/simple;
	bh=pqvKM3YsTg0DCxYSvHYm+rcDIq5rfuDj/WdG2+04eBo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a8qbHG4UG2kRMFBr4Qu0AtGaHlPzJfR4SeZhVuM8pliVqwY4vdedi7pnzVpDxoJ+pNDtscxtJaaGtTt3oSHpyGpyVervZatVX1vKuM7KiaGHurM1uW8n1NVoSOCU2kjQK5rbD2S3wdnLI6QVMwoaWbFx5YBgGKhhKkEdQjN7AbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2yCUJWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19F9C4AF13;
	Tue, 20 Aug 2024 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724194231;
	bh=pqvKM3YsTg0DCxYSvHYm+rcDIq5rfuDj/WdG2+04eBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l2yCUJWNTNwnKJShsgxrPzgMypuQ73UgxnzmNMLR7wSzo29Dga3x91TL2rQbVVf/p
	 rewu1v27VkxP6igRLb3rB9jo5LCIL8ioA47RGmDhR9HvOvQwVcXApDmoYQozqmhnSm
	 Y+aadu1zqPWfOJCLecM3HROsfFx6bqeoYpQ7Ahm8LV1VHDR6QDCTS/sD8g6GCjWMLS
	 Sbuktv4/ff/4LVEWi/dIuj+TnoKnyi1AleImOsjwPH5YIzvr5cAAXJM2pf+QB8cYFY
	 EfreGc4LC/KBrIn5BItZk8McNORajLXBFlhib6ehKGvAHXzDMM/u0T6rNtks64fs3j
	 m8bHHS9ppvB8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710323804CAE;
	Tue, 20 Aug 2024 22:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] cxgb4: add forgotten u64 ivlan cast before shift
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172419423128.1259589.15479208242990083277.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 22:50:31 +0000
References: <20240819075408.92378-1-kniv@yandex-team.ru>
In-Reply-To: <20240819075408.92378-1-kniv@yandex-team.ru>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, lvc-project@linuxtesting.org, kumaras@chelsio.com,
 bharat@chelsio.com, rahul.lakkireddy@chelsio.com, ganeshgr@chelsio.com,
 davem@davemloft.net, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Aug 2024 10:54:08 +0300 you wrote:
> It is done everywhere in cxgb4 code, e.g. in is_filter_exact_match()
> There is no reason it should not be done here
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE
> 
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> Cc: stable@vger.kernel.org
> Fixes: 12b276fbf6e0 ("cxgb4: add support to create hash filters")
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2] cxgb4: add forgotten u64 ivlan cast before shift
    https://git.kernel.org/netdev/net/c/80a1e7b83bb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



