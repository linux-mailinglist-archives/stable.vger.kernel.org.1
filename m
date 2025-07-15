Return-Path: <stable+bounces-161932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDCCB04D14
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 02:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DD17A50A2
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 00:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6971D5CE8;
	Tue, 15 Jul 2025 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMV8c9W1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E551C8616;
	Tue, 15 Jul 2025 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752540000; cv=none; b=dw67i62hBlTSnjpUID2G87iS1s0ejXq1DHVoY8O2guOi9jdgs5khIlcU385W3DVI5pnvn0o4c7fjSTH46XM0aGe1HVLOzlWGpHpSSWe9lmsIvOivSRh80AqJQ3yjF4PTEFPygp9xCLi+tJtAc0BnHvFyfDiBa2Y0aR4jibeAojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752540000; c=relaxed/simple;
	bh=TmcW3WDYSLfl58t7Xk/YEdWTjU6cisrLSFYaweL9ZZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jD121hTvZw9QFJcJqdhg8IeJ5e9ye8b9onJqpANuu/UCSKyXlG+rqyzEjws8OQHC+zJzRQ9QUyYh8z77FX8YVmF92zT4gZZiStVAAVmsrq4ID40fSzNah61kTQEW3clDW9KW05nYO+HyAvGRIeZnF4emw4dOenKk2WWdmK8RTQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMV8c9W1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08DFC4CEF4;
	Tue, 15 Jul 2025 00:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752539999;
	bh=TmcW3WDYSLfl58t7Xk/YEdWTjU6cisrLSFYaweL9ZZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mMV8c9W1t6a4ClOXNsrkFrNw6IDbiiRto3xkUxBBol/CNufaWvAG2GqQX+xOPP4W/
	 /7qn7/f3tOg4TqAwYIzLqH5QlefY1gJgFe98fu1DY/466+y+jvF+JJl4CYVw2HBKL2
	 twVCXyBzwhPf3glOGjIVeMWZHe9GlDmst/67+c81AypfbhNf5b6Mm6OubtnTmyNprx
	 2rXydQubR/9nwlB5hj3GcmImo4Vfk17XfDC+0t6y1zaDZUkRORZqPmOVKSERUVXhoL
	 dqkJcbaVkjqiQ6WXvSVBkMlYdBh8KuMaCLgolzWdW4SSKvGZp9VIpZhi8S8zBMPcYS
	 /jwfvAvaPy+kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCC9383B276;
	Tue, 15 Jul 2025 00:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] net: ipv4: fix incorrect MTU in broadcast
 routes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175254002050.4040142.7007853567795246386.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 00:40:20 +0000
References: <20250710142714.12986-1-oscmaes92@gmail.com>
In-Reply-To: <20250710142714.12986-1-oscmaes92@gmail.com>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 16:27:13 +0200 you wrote:
> Currently, __mkroute_output overrules the MTU value configured for
> broadcast routes.
> 
> This buggy behaviour can be reproduced with:
> 
> ip link set dev eth1 mtu 9000
> ip route del broadcast 192.168.0.255 dev eth1 proto kernel scope link src 192.168.0.2
> ip route add broadcast 192.168.0.255 dev eth1 proto kernel scope link src 192.168.0.2 mtu 1500
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: ipv4: fix incorrect MTU in broadcast routes
    https://git.kernel.org/netdev/net-next/c/9e30ecf23b1b
  - [net-next,v2,2/2] selftests: net: add test for variable PMTU in broadcast routes
    https://git.kernel.org/netdev/net-next/c/5777d1871bf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



