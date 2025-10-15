Return-Path: <stable+bounces-185841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDC7BDF93D
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 18:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DED1A2097D
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CF3288C81;
	Wed, 15 Oct 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGSCRyC+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F46326D77;
	Wed, 15 Oct 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544625; cv=none; b=spks3oYwT5lIJ4V1vZCQgJJtoIeArdXIATZhxDT9CEIF5LsSk7cfOVc8yHsoFzZeQSMpHx/VUFuQhG4G2hE07exGchY447G5DAatMMnu+1Yv21H6VfveN7MiIHtV4ahSEvX1V4yv7Yozpbtjp1x9C6KMixAfvUtxiKITeEh+ElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544625; c=relaxed/simple;
	bh=dcFZNHJd7u8P5PsF+UUqJjsNe+og2T6bb+SyhmTtPE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hperUdPmOGzhLwFOjtUxWjh8HazUSWK0VTScmVg925WKWr9mQR8oNgFuDWEWJ5Kjl3PnWgzxwvP4PGYFu2fmC774wg181ODRyMcTqTfsFIK5Wkc3JLmnxUZCegd5GETusTBiAo6FOLuBsglhrAyptB+hwj5DYEm0p/IPhFqN9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGSCRyC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DCCC4CEF8;
	Wed, 15 Oct 2025 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544625;
	bh=dcFZNHJd7u8P5PsF+UUqJjsNe+og2T6bb+SyhmTtPE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UGSCRyC+Wctl2ezwDbUvTrJw7KCQLsjC1eB5uGn6ETblajcg1p0rQKWqZg7Hgqta9
	 1P35K+uKmA0KaC3QOpSVfNhQF6jFul1zCWjPNjWuHgLhrByKBGWB60o2SkLY8Hr8SB
	 9jXq4yCkuOmxONoy0s6jcZ9vilsyPEItUPfKJolkKjNNdHdLGRfbUGFNEVvL61mh3u
	 Wcy7kmmxJNaHz6QGWrWvDYee4en29vasNTO+UWwZdBp6X5FE1KG4MUVrr67MiYS4V+
	 akJSChivgxRn2btqVtWWt/tLqwDUpKjwjIvNL4nKug9FGe6kxNHrn6OOFa2etinj8c
	 k9vg/S+/tVbKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1B380CFFF;
	Wed, 15 Oct 2025 16:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: Check valid ts bit on RX descriptor before hw
 timestamping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176054461024.940684.9782106410239743246.git-patchwork-notify@kernel.org>
Date: Wed, 15 Oct 2025 16:10:10 +0000
References: <20251014004740.2775957-1-hramamurthy@google.com>
In-Reply-To: <20251014004740.2775957-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, pkaligineedi@google.com, jfraker@google.com,
 ziweixiao@google.com, thostet@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 00:47:39 +0000 you wrote:
> From: Tim Hostetler <thostet@google.com>
> 
> The device returns a valid bit in the LSB of the low timestamp byte in
> the completion descriptor that the driver should check before
> setting the SKB's hardware timestamp. If the timestamp is not valid, do not
> hardware timestamp the SKB.
> 
> [...]

Here is the summary with links:
  - [net] gve: Check valid ts bit on RX descriptor before hw timestamping
    https://git.kernel.org/netdev/net/c/bfdd74166a63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



