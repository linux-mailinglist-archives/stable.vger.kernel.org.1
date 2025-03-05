Return-Path: <stable+bounces-120396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC2AA4F375
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 02:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87ED7189041A
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 01:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010741779AE;
	Wed,  5 Mar 2025 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="as/Shjhq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD299166F32;
	Wed,  5 Mar 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137612; cv=none; b=midnnEjnPYnBVtvTHR+b8BnZfbDW191Ca2p3/4TBx1mgTMxNN9SiXzj4/DzHATK917yRpF2O+YbhDk6WkIUa6ekcSaQ6btplqfojf/ikT3oxWe+t2I1OuVuCP/Rbhzl3Dkqtc2skkyz6Hp7jbOYclqzjvvMSGp3tdbeE8XzNhaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137612; c=relaxed/simple;
	bh=d42/iWgyP1vCc+gV3LAXpR4hIEbpvz0bwcJDNo+qYIc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gddWhI+UXBS9MqhOL9pajrwcUqfsLPXmEDQht6DcWcxrAgx4hBP1ZZXk7sFtzbl9NkBBG2vsyfEXiq0KqeUFjJZ6LEAB5MSVuFI+4cUkbQ/qyN+bcR9lCVYR4qA5xl4MB1myURxXIR22udIwn4Q6CByRn5AD+zoB3h6LzKr7suQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=as/Shjhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CCFC4CEE7;
	Wed,  5 Mar 2025 01:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741137612;
	bh=d42/iWgyP1vCc+gV3LAXpR4hIEbpvz0bwcJDNo+qYIc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=as/Shjhq1e2yBvUpF6PVJaLKyaXiJcJdmwl3uhF1WUqaw6DQt9e8Rv6iz1P0Q+vxS
	 V6bWIJvAKVzGukgupk5/Oe9PYXrvItzabOJliYg3p5XgJXD6VdHUyikkY+aU526kFg
	 pAVM9Gp4H0DCYitcp+No5tzh/UFI4SOiBsv0QIvR22nvgHorLbXkidqRPjylVALnod
	 6q6q1SM1iX2cQkWfIOxNVhcyYve6y/7uH87NwTFQUV6MJDW0oxmS8WJTk2gOPhuQb5
	 7jbzPCy8RIaXCxiGqzSrRE65IoafetJgNBme6mggyb06GBexkYEnFOAcBMvuomdONY
	 W5drORNYscs6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D99380CFEB;
	Wed,  5 Mar 2025 01:20:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] dpll: Add an assertion to check
 freq_supported_num
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174113764499.356990.5931495827775849774.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 01:20:44 +0000
References: <20250228150210.34404-1-jiashengjiangcool@gmail.com>
In-Reply-To: <20250228150210.34404-1-jiashengjiangcool@gmail.com>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: przemyslaw.kitszel@intel.com, arkadiusz.kubalewski@intel.com,
 davem@davemloft.net, jan.glaza@intel.com, jiri@resnulli.us,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
 vadim.fedorenko@linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Feb 2025 15:02:10 +0000 you wrote:
> Since the driver is broken in the case that src->freq_supported is not
> NULL but src->freq_supported_num is 0, add an assertion for it.
> 
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
> Changelog:
> 
> [...]

Here is the summary with links:
  - [v4,net-next] dpll: Add an assertion to check freq_supported_num
    https://git.kernel.org/netdev/net-next/c/39e912a959c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



