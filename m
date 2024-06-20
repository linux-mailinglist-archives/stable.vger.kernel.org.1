Return-Path: <stable+bounces-54700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A549100FC
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 12:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D790B2437B
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1D52BAE2;
	Thu, 20 Jun 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Taiu59EE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0EB7E58C;
	Thu, 20 Jun 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877629; cv=none; b=XkDcUJNjPg44wgW0bXeSo/kP3ekqcnS7G3ljBylBliMBlzq+6Z5xivw5O3IHZnFxNjgQrJsh/R46zT23v5SzFT6ISvP2rdXoJXVkxnSlRsmCeHijIVcv+xJ5Pl2Va7UXOOn1ZF/d3zU1KcGw9h0gwgEGwQ8tMWXnesw2p7gr35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877629; c=relaxed/simple;
	bh=Sn3yo7fsGwZ7f2bMch8DHKgTTPUFU1zv/B2Yp9k8OEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pUobnm/NsZTNl4qy/pPxloMG/E9ZZ9Ymq+s+pYqC8AiYQJRP/wBHu5pr5tP2jivwCgRCMMWjFUAcsSVwErHHHmah8q5juh0xNuVijaYaZzU5/OaVSa7uIoeK4SPFWJ2r4VtBbMLGde5EoQZqMQkQ2NhDXiYKDhlFU/qtgtwXX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Taiu59EE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31785C32786;
	Thu, 20 Jun 2024 10:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718877629;
	bh=Sn3yo7fsGwZ7f2bMch8DHKgTTPUFU1zv/B2Yp9k8OEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Taiu59EEl3ONkEwTdfzlu0hfKrQkRzIS/s8r4eIFXGc1Z1fLdQiAaKuL2s7jxs51k
	 8ogqBVaScc0Ob1gPjHEAiVkGSEdP40VKOUw1AGdJVjcRDWhxY8Rmalk6sGeBy+EWIk
	 fP4ldjcfNmLCkeG3kIpGpzu5s/ySJK/XBEXV/WfgRvUppGDN1alCaxtlylGoAljydv
	 xcfF3esHqBG96pkXyY2GFuJlH93UAPbEuqxolGU82/HbcHcDmuUSl6YAY2Fu3ltzkw
	 k7tdKU7a82Sm8jVwU5FeNGsmYKcGDoV54fzgItLl2Rkz8FSFY8SfHRFpGKrut/zG4/
	 trE0llIibHDUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17A4AC39563;
	Thu, 20 Jun 2024 10:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/1] net: stmmac: Assign configured channel value to
 EXTTS event
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171887762909.4048.5111003780557112091.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 10:00:29 +0000
References: <20240618073821.619751-1-o.rempel@pengutronix.de>
In-Reply-To: <20240618073821.619751-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, stable@vger.kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 richardcochran@gmail.com, tee.min.tan@intel.com,
 vee.khee.wong@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 18 Jun 2024 09:38:21 +0200 you wrote:
> Assign the configured channel value to the EXTTS event in the timestamp
> interrupt handler. Without assigning the correct channel, applications
> like ts2phc will refuse to accept the event, resulting in errors such
> as:
> ...
> ts2phc[656.834]: config item end1.ts2phc.pin_index is 0
> ts2phc[656.834]: config item end1.ts2phc.channel is 3
> ts2phc[656.834]: config item end1.ts2phc.extts_polarity is 2
> ts2phc[656.834]: config item end1.ts2phc.extts_correction is 0
> ...
> ts2phc[656.862]: extts on unexpected channel
> ts2phc[658.141]: extts on unexpected channel
> ts2phc[659.140]: extts on unexpected channel
> 
> [...]

Here is the summary with links:
  - [net,v1,1/1] net: stmmac: Assign configured channel value to EXTTS event
    https://git.kernel.org/netdev/net/c/8851346912a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



