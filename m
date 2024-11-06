Return-Path: <stable+bounces-90048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AA89BDCF4
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57981C23178
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF311192D67;
	Wed,  6 Nov 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7xb8NJL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AA2192D6B;
	Wed,  6 Nov 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859628; cv=none; b=k7nqtWNr2PZA43/UzVMEzBUlPsdRqAKli45pH0FHVx2mCMpOIB3eB6tZT2K7hn/5frQWeUYj4zx5MdF+9z/Hbkt+IJMTNEw+FnWKcoA10BQW3rB9XtZ47jqalTVMdO2pyrR0+nCeRR6Mz8pdmi56tTzfb9zgbPZBsR8CGbzqO1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859628; c=relaxed/simple;
	bh=9AlKzJwn8+8UrBAcyfvybi9me5gRJsZUPK+iUtA8ItE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ps5xaZVprxMQO1CAdNNVmw51puzCtT5079NUGogUkjO5lpOOER0cLY+eRhLiSERHeIun533qcNPtafakUoVAoHbomxCgcH6lpI8soAdnC588xJZnYMS6vMJmFGkKjeEMYUsOmhH9mCGvdrkH3TtOldSoZxZRpoChy3eozg+3c8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7xb8NJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C40C4CED1;
	Wed,  6 Nov 2024 02:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859625;
	bh=9AlKzJwn8+8UrBAcyfvybi9me5gRJsZUPK+iUtA8ItE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H7xb8NJLFwmxpR0p8qcEl7r1nfNfieHkLoAJsHgEWn6kftzm0yhhURPWgNhFSICZC
	 oiZ3i8WB5HCAFibKGJlKVg3CfKWsAy8/oC7frTaklM8+N/cUP0voghLohy66iOrF66
	 2eWrvbaHOV4JggyiMPpi9NFZfzYLBh/xdwQHE1t6GDoe7Nv0SB/48qP6PzAvM/Tk4k
	 12ugpNYus5w85Guv2INhtOXUCesg3RRA9cMa37jtCFxkZutpiAw0uwDB94aEfLDYAl
	 xhRw3R6qIrkvcgfceb5rIeCs5Rbmp+JVShxc48W39GQFJVE6aYQuLTA+uTZ1SdqkrY
	 ppWiFvTHXv/oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0BB3809A80;
	Wed,  6 Nov 2024 02:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: pm: fix wrong perm and sock kfree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085963449.771890.15377735396681814695.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 02:20:34 +0000
References: <20241104-net-mptcp-misc-6-12-v1-0-c13f2ff1656f@kernel.org>
In-Reply-To: <20241104-net-mptcp-misc-6-12-v1-0-c13f2ff1656f@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, donald.hunter@gmail.com, dcaratti@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 04 Nov 2024 13:31:40 +0100 you wrote:
> Two small fixes related to the MPTCP path-manager:
> 
> - Patch 1: remove an accidental restriction to admin users to list MPTCP
>   endpoints. A regression from v6.7.
> 
> - Patch 2: correctly use sock_kfree_s() instead of kfree() in the
>   userspace PM. A fix for another fix introduced in v6.4 and
>   backportable up to v5.19.
> 
> [...]

Here is the summary with links:
  - [net,1/2] mptcp: no admin perm to list endpoints
    https://git.kernel.org/netdev/net/c/cfbbd4859882
  - [net,2/2] mptcp: use sock_kfree_s instead of kfree
    https://git.kernel.org/netdev/net/c/99635c91fb8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



