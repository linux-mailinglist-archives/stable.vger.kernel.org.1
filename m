Return-Path: <stable+bounces-18822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CCC8498AB
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 12:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C1D1C222BD
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3D2182A0;
	Mon,  5 Feb 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVGrrva3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4518E0C;
	Mon,  5 Feb 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132028; cv=none; b=Zz5CHDX5gJ6GdHbSJd0nRgsVnmVterB/qf95SP1HgxoG3/6BySV5N/2ASLw2y1e4AZZZwbSoMi/ihSEpvB/wGiJNc40cyf5eCOUm0LM1MfCXFSCS01sunIpWNYgHgcy8B0pV6VPZFPYq5tmQ00rokUEhU8EYdFhd2fJwa4nlH/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132028; c=relaxed/simple;
	bh=dWcWFgOnGOZr4S29PL9XvdO++kv756CTKKDhZBmJawM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z6R4OS4f8MNNe9oQRjdzrcvt/o74Cb3TntyvrmEXXbrnd6N86kcTl4DxDxbyqSSlNkc/ITAXG//31M+b8RsjsvLT8OJb+guw84faGHOBakjdBMmBg2FuxU+TiC89AqBclL4RZRh2tEah5q0G90P/YinmnRbrtXmlYqwRzjS3JGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVGrrva3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E613C43390;
	Mon,  5 Feb 2024 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707132028;
	bh=dWcWFgOnGOZr4S29PL9XvdO++kv756CTKKDhZBmJawM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SVGrrva36jrhu3EUSO3fMdKtZNcvTtlaBHEEuXAwFxUTWt74gerct1HXFlnoDRHb5
	 29kCy9WvTw+7pjmLodMJ9JGY2McjYMiHGtJqzWS7RSTG1n36MroNjeWIzutvjxoqY6
	 8WBqCUalH2xoJPxc7zS/iTwhGm8RhMe2I22fxvopfh9Eb4cVPzWriKPZvLMNTh5THn
	 0Xj5DmbpmldAloK5tIvwy8fjlEz8oikTPME2KqtV304AY9Lst+r5AcxYJqlRGfr5VC
	 BzXn9jDs0n77x/0FtYDXlRnlStjGgU3I+4jCL4xSgLPMAe9aWy6HhyaS0xnHwtwDgV
	 wjtNe9VvmrV0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05ED5E2F2ED;
	Mon,  5 Feb 2024 11:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] nfp: a few simple driver fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170713202801.23951.1708366481607486809.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 11:20:28 +0000
References: <20240202113719.16171-1-louis.peens@corigine.com>
In-Reply-To: <20240202113719.16171-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 james.hershaw@corigine.com, daniel.basilio@corigine.com,
 netdev@vger.kernel.org, stable@vger.kernel.org, oss-drivers@corigine.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Feb 2024 13:37:16 +0200 you wrote:
> This is combining a few unrelated one-liner fixes which have been
> floating around internally into a single series. I'm not sure what is
> the least amount of overhead for reviewers, this or a separate
> submission per-patch? I guess it probably depends on personal
> preference, but please let me know if there is a strong preference to
> rather split these in the future.
> 
> [...]

Here is the summary with links:
  - [net,1/3] nfp: use correct macro for LengthSelect in BAR config
    https://git.kernel.org/netdev/net/c/b3d4f7f22889
  - [net,2/3] nfp: flower: prevent re-adding mac index for bonded port
    https://git.kernel.org/netdev/net/c/1a1c13303ff6
  - [net,3/3] nfp: enable NETDEV_XDP_ACT_REDIRECT feature flag
    https://git.kernel.org/netdev/net/c/0f4d6f011bca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



