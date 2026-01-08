Return-Path: <stable+bounces-206389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 111A1D04B2D
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 18:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89858306EC11
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F252E7F11;
	Thu,  8 Jan 2026 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZl9RrpT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FA02DCF4C;
	Thu,  8 Jan 2026 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891224; cv=none; b=YXAb+J74RmXdHdHhYIZtSQFx4u3DwPjp7FnCrLMftgtbMijWftskoz+iXQ0ZlC8YhJ5aGWgj4nHrtDzqxM45Di+iMP/KYB77Z8lwMWqhS+94CxA4S2kpr8i00i4+iC35HOB7TjOaSdWZ/npRzEJklvDrdAAdK6o1cENwEk6HH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891224; c=relaxed/simple;
	bh=Lm0bNIIANsCc10sqZgEPoU/LxqooOlG+OUV8XDM3Clc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A7ZFgblr7+bmty5EljBzWuyyJGmJKyQHLN0Ebqq+/YydaquNiksv3zb4m2Cxk2U+LRPunPYXPRuq5MVd7zm7EyD9JWJ/mAraESXvC/nxh6ScMPhzn6nw3E54fWDRG7tJhUyij0pL7h/zx3k8TUQPe+e4TDYGGRmu8MQ+65iljII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZl9RrpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875BAC19424;
	Thu,  8 Jan 2026 16:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767891223;
	bh=Lm0bNIIANsCc10sqZgEPoU/LxqooOlG+OUV8XDM3Clc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EZl9RrpTucSK5CIN6OgVG7qF8KC+0gPHNTj7A2MNARt2oyx0A1DsLMFdiPjVT4C7s
	 34tWC8lAYlj0bR13sHwHqbQfwutBhsvlT6LE/0DNmH8Cl7l+QvNXAXI1lx0eNLmdOv
	 5b9B7LDIcN27Zk1U8t0PF3LLg44jDByu+fCwl33wdvdU4/M298Cs7WejhHP/VziF1N
	 GfIOJ8P65nOlSPepqg8DU2cEhV1BR+7FM8+Llp8miQHfX/V0d+5MBzDG82WqBf5tXD
	 ZZc36PQiNuKbPJ4hMGLL7uj678g11Fj5PVotw382B8TDJ9FZZF4O52Y3tnbFnUIBE8
	 VZtjW1YcV1EXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BB9A3A54A3D;
	Thu,  8 Jan 2026 16:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176789101978.3716059.8052841246224375399.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 16:50:19 +0000
References: <20260106-bnxt-v3-1-71f37e11446a@debian.org>
In-Reply-To: <20260106-bnxt-v3-1-71f37e11446a@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 rmk+kernel@armlinux.org.uk, vadim.fedorenko@linux.dev,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 06 Jan 2026 06:31:14 -0800 you wrote:
> When bnxt_init_one() fails during initialization (e.g.,
> bnxt_init_int_mode returns -ENODEV), the error path calls
> bnxt_free_hwrm_resources() which destroys the DMA pool and sets
> bp->hwrm_dma_pool to NULL. Subsequently, bnxt_ptp_clear() is called,
> which invokes ptp_clock_unregister().
> 
> Since commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to
> disable events"), ptp_clock_unregister() now calls
> ptp_disable_all_events(), which in turn invokes the driver's .enable()
> callback (bnxt_ptp_enable()) to disable PTP events before completing the
> unregistration.
> 
> [...]

Here is the summary with links:
  - [net,v3] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable during error cleanup
    https://git.kernel.org/netdev/net/c/3358995b1a7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



