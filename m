Return-Path: <stable+bounces-54675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B7990FA63
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 02:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82234282B0C
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 00:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C86E1FC4;
	Thu, 20 Jun 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR3EBx0R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20AC80B;
	Thu, 20 Jun 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718844028; cv=none; b=jg5WlAvNEN8ySIio9tOwGjQCKtPTuzkJ2AQKCm+UOSpkgJNkkhtTolaHWTmY3cf83Swh3EMMTjTqjbCwlHu/NTn8+6lRuBXOkdW62hJ7ZJ3zwvvssOl1QBepH+RRIF5KHc1qocIAL3gJlKbi9mmVn7sPV4ysfiQhQQejkv/rQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718844028; c=relaxed/simple;
	bh=VGowrL8cYgVEENvmronnkfAFOEL6EiN0TiLkISUVStk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WaaVMUnV2gQd+ZoPHKG5xKMiIJJMw3H7HA8/6ydKkOjnXO4/TGQTumBRmv3NDv+JiOT7AOVQ2R2SKVlYUzE53hTW/ofIJF4yVdTGSUesgmqb3wMAKm4zm3c88FXqZWEe6ob1/MbQ5wSL/emRH+G68SsxAWF+5B4ATw/TjRnn1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR3EBx0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EE0BC4AF07;
	Thu, 20 Jun 2024 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718844027;
	bh=VGowrL8cYgVEENvmronnkfAFOEL6EiN0TiLkISUVStk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WR3EBx0RoSfo/yR0FjH7DKRfg7oZxc1JDXdkPeInpJPfvX92yTmMen+UdzQgfLBFv
	 E+m1adsgFhwf/5ZMllbmaxTsH0gCF9TshAK/VKQrK0u+UpCeVbwBETwQDMZXRJvXhu
	 /UpmQ6SNJD2MgA4ur9XI6CJEpi+SPbLgceekNszSuWi7CqADoEWCgLmnmO76GONbWn
	 gVOQunGMcyUbkSBuv37pEshFnRWXKEpDC+8FJ4mIw0I5rYQZQLT2zEvB/9dQ0WlSNp
	 jpR0jkmHzR8dDuCjSjOTE84hmCPr/OHsZsZzjXFH6IGejbVI4A5qzqml+BYP/YIAJq
	 BVxr9AuCqyUIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66BFAE7C4C5;
	Thu, 20 Jun 2024 00:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/tcp_ao: Don't leak ao_info on error-path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171884402741.27924.10755874580274732970.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 00:40:27 +0000
References: <20240619-tcp-ao-required-leak-v1-1-6408f3c94247@gmail.com>
In-Reply-To: <20240619-tcp-ao-required-leak-v1-1-6408f3c94247@gmail.com>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 0x7f454c46@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jun 2024 01:29:04 +0100 you wrote:
> From: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> It seems I introduced it together with TCP_AO_CMDF_AO_REQUIRED, on
> version 5 [1] of TCP-AO patches. Quite frustrative that having all these
> selftests that I've written, running kmemtest & kcov was always in todo.
> 
> [1]: https://lore.kernel.org/netdev/20230215183335.800122-5-dima@arista.com/
> 
> [...]

Here is the summary with links:
  - [net] net/tcp_ao: Don't leak ao_info on error-path
    https://git.kernel.org/netdev/net/c/f9ae84890428

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



