Return-Path: <stable+bounces-53810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 619A890E748
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA4CEB20E6D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E992C80C0C;
	Wed, 19 Jun 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1HX2Rq1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E3D54784;
	Wed, 19 Jun 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790629; cv=none; b=bRLDUvnIX+nfP84zYDKGxZgJN2lJM8Bqie/lnrkhQR7e8atsG4JXb/Y+bTFUbwi3pziWSgdY1wrJS9MOuHbjhd0MJZFrGGx1BZMMslRHSCKYLl+bHn1o5oFjYauJ6k+zfVRywakmO/x8fIOgkWR+vn73U78eYwigJsbdrC6lPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790629; c=relaxed/simple;
	bh=lVHQo/Rj8HhEKrJi1VW2exUVeazX3WH1N6budU1lWgk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BRqTtuU7QkPk8Ug/6qoTkkjqDQegVGCZh1qHrNvC1o/xDImYQLKH3PmDJxjf5SWxNUDvSilZtgv6TuJmokdQv+UF1LOL1vxGZ77DTptnVw2CnUsuIEsNRdO8eA30AdT2NNPZwOiVhsSwxc6jFW/ajc8vwjqnt/lOTkEs9CTxHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1HX2Rq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C7E9C32786;
	Wed, 19 Jun 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718790629;
	bh=lVHQo/Rj8HhEKrJi1VW2exUVeazX3WH1N6budU1lWgk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G1HX2Rq1hevKUVDD04H7sH8UWhSq15z5mx62GD1m6IICziaFlfqIA7rwTgjDJ4PZL
	 eqYlBTyLqXzgKydr7IMFwcstSBRLhLcZNxXXkMnPHQIYV4RCpgsNbaMTzfJ52R0o9P
	 W2uwNNKP4MFrERBBTE6ran9RepX/2mLsdA2J/dKAf0jT2UjePrjKFgSwiPq/CqZ5oo
	 t/SRYjIFGL1pZU/nOBQ/eXU2ytv7oisK3EiAQTxPTa5AGU6TNhYJaTSgmy/48bsHUi
	 lZ8padfEH2dVGLz3Q3MbUb4fGjRDeWp/9R3ZEyBsi+KkbkwWhVfuBG+CLkweE5LiBq
	 c9HmsNMQqNmpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05347C4361B;
	Wed, 19 Jun 2024 09:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: ax88179_178a: improve reset check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171879062901.26288.8596567430830957012.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 09:50:29 +0000
References: <20240617102839.654316-1-jtornosm@redhat.com>
In-Reply-To: <20240617102839.654316-1-jtornosm@redhat.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 yongqin.liu@linaro.org, a.miederhoefer@gmx.de, arne_f@ipfire.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jun 2024 12:28:21 +0200 you wrote:
> After ecf848eb934b ("net: usb: ax88179_178a: fix link status when link is
> set to down/up") to not reset from usbnet_open after the reset from
> usbnet_probe at initialization stage to speed up this, some issues have
> been reported.
> 
> It seems to happen that if the initialization is slower, and some time
> passes between the probe operation and the open operation, the second reset
> from open is necessary too to have the device working. The reason is that
> if there is no activity with the phy, this is "disconnected".
> 
> [...]

Here is the summary with links:
  - net: usb: ax88179_178a: improve reset check
    https://git.kernel.org/netdev/net/c/7be4cb7189f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



