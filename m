Return-Path: <stable+bounces-119781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F090A4733F
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 04:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061BF3AD6A0
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 02:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F23187332;
	Thu, 27 Feb 2025 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwb65igv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BFB2B9B7;
	Thu, 27 Feb 2025 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625199; cv=none; b=r0eHmum934euOzYoL0ZzIMCYzZ9NK5tcnx2cDAUNmKnN4P++SS2Ya1QKuV+pbvd1HGVAx7r0XdIQJk9CoM8qPp9kTOceD+ituDcuj7xG3Ufg6BQwPjWZCYAgVCJjux1JKFq0cevYHUmZs+Dz0W51xw7usWikicDqru+BcXOOq1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625199; c=relaxed/simple;
	bh=FHNoUxelfTkKfhEU1o8kL2H4wpwFqMyC3TKoeJemjHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RCLqSejP5IweF2E8CElGADKf3UtBhC0Gf/7vD7GKiN0MtS3yDhQGKW2SXKlbZkY1uA5EERzGVUceKx6HanaILDngutp9R6cuiI/xOMEHzF53OnNR8Z+1ulnLLSQ0gO+p7X+pFH0VPMS+tX/eGRiouUrnIK03qbEkjR4540BgDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwb65igv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A4DC4CED6;
	Thu, 27 Feb 2025 02:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740625198;
	bh=FHNoUxelfTkKfhEU1o8kL2H4wpwFqMyC3TKoeJemjHw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bwb65igv6QkvZnS8j3ciTH6rg7swP8ae6xX1ws90OWXbd4IFvKbN5pqOECarDRCTm
	 8D6Z2ZWyCgaQL6ZuDOCWKdNp6s/3H/TUi2f2IeyaFFEli2DRNsqlucQ8Mr2pShmuV9
	 3r0trqk7DZlMjQoiZYM9Q0hgA9czqHRanT8x2SoO5lmq5ZjE4IW9XFMFQLXkE+7CMF
	 MgF33W4GKAZ9cBkUSYp2A2SsRGYh9U7T7CQPj18eL2oW1k1y9pNCMlFViQt/llv8vD
	 E/99pzhW1TfZGUePzwG4LongWsEe7R0N7ni0EbqwjpxYkHAxwH2p5f09XmBBDi5kke
	 2+eZ3aLgMYUnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDAE380CFE6;
	Thu, 27 Feb 2025 03:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: unlink old napi when stopping a queue using queue
 API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174062523052.949564.4439537852018025351.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 03:00:30 +0000
References: <20250226003526.1546854-1-hramamurthy@google.com>
In-Reply-To: <20250226003526.1546854-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 pkaligineedi@google.com, shailend@google.com, willemb@google.com,
 jacob.e.keller@intel.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Feb 2025 00:35:26 +0000 you wrote:
> When a queue is stopped using the ndo queue API, before
> destroying its page pool, the associated NAPI instance
> needs to be unlinked to avoid warnings.
> 
> Handle this by calling page_pool_disable_direct_recycling()
> when stopping a queue.
> 
> [...]

Here is the summary with links:
  - [net] gve: unlink old napi when stopping a queue using queue API
    https://git.kernel.org/netdev/net/c/de70981f295e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



