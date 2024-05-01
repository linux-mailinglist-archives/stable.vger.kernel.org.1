Return-Path: <stable+bounces-42843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45268B8411
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 03:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D3F1C2240B
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 01:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD0F4C97;
	Wed,  1 May 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBqazqKu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA064400;
	Wed,  1 May 2024 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714528230; cv=none; b=o6mYkMDsf3AkVlrs3rXeoJkUgYnuZcHNlo80p0KTCEUErh3JGfqJED5ZJJEHJ12aZFjTRPuPJXY69kpRy/SKgshKJJAvNqKMOlD9XTTT/d3qNLZZyQIqpzHcNbTC/bfaAKX8vNQw/5UIRWnIU27bywpGoQ5OM5yMgzKd0o9+CtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714528230; c=relaxed/simple;
	bh=/N2OB5CYBQQz0szE6OTThIyTkKPz3s2JADY0almy6ng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lBtqQtRKidtdGJk+K666iUOcQe+m/Ju/kxp4we/z9uh0MPko4Ai36rMRvVjZ6siZM6/5PGiL128rPjj3k9TNSgyjrL1o36b7pZ3iEyaKCpfrBvYprTmZn/7DhWtEPYJ/mhNtCBMoqAd7d39UPIs5+j84LV6/R15qwsESDxp54fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBqazqKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7454CC4AF19;
	Wed,  1 May 2024 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714528229;
	bh=/N2OB5CYBQQz0szE6OTThIyTkKPz3s2JADY0almy6ng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NBqazqKu52SsSSiD0C0hhKehmCVl3l0pH2u1IYsLRJhm2sRgObcoNBvf8GLO+NVFz
	 8fowOvQib7gM4EBSbfQKsGMA059Chzm5ON6uUqtBptb5He+3b7pNz0OzZON3vlHaBz
	 0QsGJSwp7j6kEspwo7YUflOG8bQggUg2lGPWlVnZ6cAKzUYXcrDrOI4NFROZjUTrMJ
	 TL3Pw6tjpjn9mgIm6J/G4co8Pg+g5gS0a9SmGt4Q7K9HjVMZTwKVAjDxOEPi97Hz0G
	 faeHOBq0R6GAt/15jl4OjhMff54XBN8snk5bL+ySzmr5cUUGkhU78y2s+BVr29o3yS
	 lXeFTW4Yb//PA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61F6FC433E9;
	Wed,  1 May 2024 01:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] e1000e: change usleep_range to udelay in PHY mdic access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171452822939.22205.9211617153517176455.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 01:50:29 +0000
References: <20240429171040.1152516-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240429171040.1152516-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, vitaly.lifshits@intel.com,
 regressions@leemhuis.info, stable@vger.kernel.org, cJ@zougloub.eu,
 sasha.neftin@intel.com, dima.ruinskiy@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Apr 2024 10:10:40 -0700 you wrote:
> From: Vitaly Lifshits <vitaly.lifshits@intel.com>
> 
> This is a partial revert of commit 6dbdd4de0362 ("e1000e: Workaround
> for sporadic MDI error on Meteor Lake systems"). The referenced commit
> used usleep_range inside the PHY access routines, which are sometimes
> called from an atomic context. This can lead to a kernel panic in some
> scenarios, such as cable disconnection and reconnection on vPro systems.
> 
> [...]

Here is the summary with links:
  - [net] e1000e: change usleep_range to udelay in PHY mdic access
    https://git.kernel.org/netdev/net/c/387f295cb215

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



