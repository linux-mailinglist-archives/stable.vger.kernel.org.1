Return-Path: <stable+bounces-169484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8BFB25909
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 03:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD9287B412C
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 01:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C6219D8AC;
	Thu, 14 Aug 2025 01:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJj3AErv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AD219CCEC;
	Thu, 14 Aug 2025 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134999; cv=none; b=e+AtS77CSvt6lIC7Xb7/ttHpKySG1Yd5kLHL6tcdigdnLoazaGpHlFLT/U03/cH7EZ2jpMyDi0Yl7OxNmidshFgVxc4O/Vtj4r09EWmtQ6nKkPU2k/E/TwUR6qR2WCix4I3FUjgtEYni04ZcUfICpVOI419GqLas6e1/pYLQS1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134999; c=relaxed/simple;
	bh=J55Fs/Cz9AW+uhrMa+7Gfgx6XLg0a+dnMKDxhbeQISc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gdes+X63UBk0+K63jLhh3A8xdJBhx0J601h/T5/k6rT4QEW+rPu02HTa17K77H4Y20XJHec+L7aMC2tqFYZbNQSfx1MxYLHpul7nGQWiJmD4hmnUl2IPK3WYsio758Gvn+mpbFBqlcihu4nxHp9SD/E9CX3FK6NHayVaC1JeDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJj3AErv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DEDC4CEEB;
	Thu, 14 Aug 2025 01:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755134998;
	bh=J55Fs/Cz9AW+uhrMa+7Gfgx6XLg0a+dnMKDxhbeQISc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DJj3AErv1Y+Akl6loCWCYIuwCwIaQaA29YvuxizxIGbhpn1zbKuGDNVS691MlB7S0
	 VJU0h8368YPLBSMm8F2siER/f3YQKgepBO5Cp4LZsU6ZL3iynU8MjqbUMLq9ajqSuM
	 oEmk+x0pi6nN0kMac00LhJA0KSqZxovzDJzOTy1qjfyv4fS+Zo5j6ex+61SEdUx/hE
	 xkT03+yfzbyN4Lg3vhXW6yReDESys/snU/yMC9iQn6hO7xDRbYReWvRTERmdxqWVCW
	 APFylYXDss+aGb6AOxHVC8yGFAEkAmc15UBqsNYs3PO4CWn0V7Ty1hdrBeG7Ex7BAv
	 eSGz6KQGUI4WQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AFD39D0C38;
	Thu, 14 Aug 2025 01:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] ets: use old 'nbands' while purging unused
 classes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175513501000.3846704.9094584005828460007.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 01:30:10 +0000
References: <cover.1755016081.git.dcaratti@redhat.com>
In-Reply-To: <cover.1755016081.git.dcaratti@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, nnamrec@gmail.com, petrm@nvidia.com,
 netdev@vger.kernel.org, ivecera@redhat.com, shuali@redhat.com,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 18:40:28 +0200 you wrote:
> - patch 1/2 fixes a NULL dereference in the control path of sch_ets qdisc
> - patch 2/2 extends kselftests to verify effectiveness of the above fix
> 
> Changes since v1:
>  - added a kselftest (thanks Victor)
> 
> Davide Caratti (2):
>   net/sched: ets: use old 'nbands' while purging unused classes
>   selftests: net/forwarding: test purge of active DWRR classes
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net/sched: ets: use old 'nbands' while purging unused classes
    https://git.kernel.org/netdev/net/c/87c6efc5ce9c
  - [net,v2,2/2] selftests: net/forwarding: test purge of active DWRR classes
    https://git.kernel.org/netdev/net/c/774a2ae6617b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



