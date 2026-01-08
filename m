Return-Path: <stable+bounces-206387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A07BD04908
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 185D430133F6
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 16:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0192D3ECF;
	Thu,  8 Jan 2026 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWUC7Dqo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C652DA75B;
	Thu,  8 Jan 2026 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890610; cv=none; b=F/TW5CuJ+mhJUDhzUgXHaDbUIy5uNtqyVafZKyafl7dcoF3LyndGH3pFA7KY1tIt8eK5JhoxQYofGlXYphcpeZQWKJOn2gedsCGBNWH7yGNr6GR7P0AJvlmZ9HZFc6tq6KVz4cYpszJsRjL2JjqEYJdLCW8fdixJ9Wuya+dFknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890610; c=relaxed/simple;
	bh=5epKMpOb+l/EFgcm7Vcn5gz1FO+42Bit832PgR6kcHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RxmfPs3RHhI7H2SqQA0Vly0DzHvl0DO3xwEzRFevfdOHeoVHwySPaOPraHTO1kD7VIPj8wcpatdlcpBy1Ot9GT31+qTOKHwfU5NsNP/4vK5Eo7NHsVO3M9ft7z4M3y8i3czkD0xWhK8b/4nnFEBsylvkiTCj3pCfmraLwj7GV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWUC7Dqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C308C116C6;
	Thu,  8 Jan 2026 16:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767890609;
	bh=5epKMpOb+l/EFgcm7Vcn5gz1FO+42Bit832PgR6kcHw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VWUC7DqozPvifhhNrDZ2gcqXFvjjjhkQdFAuT9onLmonDcLNNU6+4G0SE/4XCB2oV
	 v/j2R8frVYPuC4dKZRmpTDlnLjufYcSENIKgErjdC6fnpbsLW8vlbtTOpiN8dRNFHo
	 i0JoIUW81jE63PRzC5l8cA55v0i81KI8S9L/a0AJcvJZgltmgWvbnTForZKdB7Xdlv
	 wuCCT0j0odn1uJ+CVqfS2VAB4IJnoK7F6cemnGHuKEyhsmQi1NfwTkrqE3QmvCQG2j
	 Cs14OQq+1D5Kj7hF89os27vnPw/LDvIvZImmq8uhZ1lsHxnxKz6yUrKVlDGtTNtBjt
	 TS4FHQWkQypOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BA7F3A54A35;
	Thu,  8 Jan 2026 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: 3com: 3c59x: fix possible null dereference in
 vortex_probe1()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176789040604.3712290.6082999624158344701.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 16:40:06 +0000
References: <20260106094731.25819-2-fourier.thomas@gmail.com>
In-Reply-To: <20260106094731.25819-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, klassert@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mingo@kernel.org, tglx@linutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Jan 2026 10:47:21 +0100 you wrote:
> pdev can be null and free_ring: can be called in 1297 with a null
> pdev.
> 
> Fixes: 55c82617c3e8 ("3c59x: convert to generic DMA API")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: 3com: 3c59x: fix possible null dereference in vortex_probe1()
    https://git.kernel.org/netdev/net/c/a4e305ed60f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



