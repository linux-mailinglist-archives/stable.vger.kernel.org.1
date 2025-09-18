Return-Path: <stable+bounces-180549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CBFB85683
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 17:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E24734E32C1
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F1630DD33;
	Thu, 18 Sep 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZVbIH/j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C20930DD09;
	Thu, 18 Sep 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207615; cv=none; b=rYcqOXxlqiNJeNoDMlNvOKZw2wWD6PERerBSVGIGuF21y1tQScfvT9BlMIT/qbcBDiJ8zXE6LKVZz6wIYd6tBcMytLbFswwzLYeHAuoDPMcBFDZCqYm/HUCUedHkJxXZrQisD7vIHP/vOcQvGdrksiU8yunvyQgbeMGZQcJ2dJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207615; c=relaxed/simple;
	bh=tEvbED/VlPaXUi9Psj2owCkFik581ThEK72qNKZSLBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N+ok/G9PVRCjVAMVEZyyGxHb7W8UPabH+r6Z8yDMwW5ISEAgrNVy8Ka7ajzZMMJb+iqfdXby5KhZjvNI4yPRhDjYQulHFcMKsWjviA2mqkXsoyH2ouhcQcSeVRaECzP8kklROMLaDPD3/VVA9Vdn1ZJjLtgRjYWun/3784b5cVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZVbIH/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964D2C4CEEB;
	Thu, 18 Sep 2025 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207614;
	bh=tEvbED/VlPaXUi9Psj2owCkFik581ThEK72qNKZSLBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JZVbIH/jj+59CIATZFHYJGM4S5Nvx7J2HiSKQtcTMm4LaZObG+eF+RssvWnHIgzwb
	 ETdkYzmlZxmP/Lt850k6tICyD2N+yin4MkRJyZcSNwFQ/KkxqpNeblrQn64gmEP+dd
	 U2Hp7gz286TM6umCpTvCGEmSCO4wdDsh3XwJ7uqqCS7uY5DMP8VAaHqMXjz0gSijje
	 pQi0fUIZ8DN4+KEfMMDJ4f1wEtUfWKlaOXfIpfC56k40sESvT9y2DaK9OfbYwa2jHU
	 uMbJ/u+jGQvwHVd5HHDxpc1qfANviu1cLOoHMO8XDjBN/7bxGLPlfasUj8wJRzkAwC
	 8eRpbeuCgyMGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2F939D0C28;
	Thu, 18 Sep 2025 15:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: liquidio: fix overflow in octeon_init_instr_queue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175820761475.2450229.3279973050187198984.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 15:00:14 +0000
References: <20250917153105.562563-1-sdl@nppct.ru>
In-Reply-To: <20250917153105.562563-1-sdl@nppct.ru>
To: Alexey Nepomnyashih <sdl@nppct.ru>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 15:30:58 +0000 you wrote:
> The expression `(conf->instr_type == 64) << iq_no` can overflow because
> `iq_no` may be as high as 64 (`CN23XX_MAX_RINGS_PER_PF`). Casting the
> operand to `u64` ensures correct 64-bit arithmetic.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Cc: stable@vger.kernel.org # v4.2+
> Fixes: f21fb3ed364b ("Add support of Cavium Liquidio ethernet adapters")
> Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
> 
> [...]

Here is the summary with links:
  - net: liquidio: fix overflow in octeon_init_instr_queue()
    https://git.kernel.org/netdev/net/c/cca7b1cfd7b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



