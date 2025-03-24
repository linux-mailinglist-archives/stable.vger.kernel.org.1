Return-Path: <stable+bounces-125969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CBDA6E346
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 20:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A22E1895545
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 19:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B055E19408C;
	Mon, 24 Mar 2025 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY4UkiXX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F8B9444;
	Mon, 24 Mar 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843996; cv=none; b=t+hhzl9b6rjE0ahcxE1wdert1CKg0NNH+VFIN7Tj29GLvURh5lXX+ANeU3vYioej76UfML8gU8FCV6h7bXyMrkiow8cpCTVjaP6ajEvVLx/pj17FMgmsj+0NrMvztlQiLnGccbmUs3dslIW3+7Hdmk/BZxIr565+spPHsTT0b/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843996; c=relaxed/simple;
	bh=tCQwg+ILmxSv/vZ1mMK34olzXUWqG3EfmuPCjXaXCR0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=svVjAdHqmdipcRysIdD+Qqnt21Zw0vwlRy3Ks2Yx9Ke8RLhFQ271MHKXeUdK0FeXff6dud0XEaPQ++st1A3b18ZX5va+VBknW/BkJf7kHDqQ223ybPsZsJIsMbTmek23F5WhHdMTw4G5BOfBxXMWNx6fufRZiSqEhlbZULZzb2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY4UkiXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BD0C4CEDD;
	Mon, 24 Mar 2025 19:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742843995;
	bh=tCQwg+ILmxSv/vZ1mMK34olzXUWqG3EfmuPCjXaXCR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZY4UkiXX9S/UfOKf6NcPX7pE8IfyjnVqTZArcCPhkywuts4g6UnK4rx0khYOLdAyn
	 jqNhA9bfpGgKKsWKZaL6jF6AVaiWsjo+XZbaX0S9KRWvbYPUWv0s7QJCd+TdSssMrZ
	 G6f4AfICcTvNanogU34dS2Vku51xa2jaJs1Wo3FoasppBKtyhQLYf3UI34DNAbDbpT
	 IRotqtcruDfASUZKbzid3zpLBw5OWEeEt2qeiN6f3FfQGVgyexfkoVyQcboXo0kV8O
	 mvGbWUCjS05wv/YDjin8TOCuIXBb8D0ZiKSSoKj5J/5lKTInU+gJbbOcU5jURUfd2a
	 dN5c98lxFSzKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D08380664D;
	Mon, 24 Mar 2025 19:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: unlink old napi only if page pool exists
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174284403204.4140851.713015694194753583.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 19:20:32 +0000
References: <20250317214141.286854-1-hramamurthy@google.com>
In-Reply-To: <20250317214141.286854-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 pkaligineedi@google.com, shailend@google.com, willemb@google.com,
 jacob.e.keller@intel.com, joshwash@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Mar 2025 21:41:41 +0000 you wrote:
> Commit de70981f295e ("gve: unlink old napi when stopping a queue using
> queue API") unlinks the old napi when stopping a queue. But this breaks
> QPL mode of the driver which does not use page pool. Fix this by checking
> that there's a page pool associated with the ring.
> 
> Cc: stable@vger.kernel.org
> Fixes: de70981f295e ("gve: unlink old napi when stopping a queue using queue API")
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> 
> [...]

Here is the summary with links:
  - [net] gve: unlink old napi only if page pool exists
    https://git.kernel.org/netdev/net/c/81273eb87af8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



