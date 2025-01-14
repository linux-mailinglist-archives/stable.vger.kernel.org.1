Return-Path: <stable+bounces-108568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09941A0FF07
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 04:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB50168542
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 03:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5212309AE;
	Tue, 14 Jan 2025 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrCRFEz/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAA3596A;
	Tue, 14 Jan 2025 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736824212; cv=none; b=euookOxi5rxRX+Mta90eQh2Ja+fcU8AkBiwg8nmVNmfmWNsQtWWoY9/nnZ15gHRKpUMSb91RNzyvmFiWr7QPqyEgYo2v4XN/20hatDFtqtk5sVyJTL5DU19GV/P0PCuKSUzeZj39rP2ytEg4BWoiBvrjtFHvqN7FenLSEoMJgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736824212; c=relaxed/simple;
	bh=fDzyCyzKCDVgpzSiEGjWrvIDGXFGqgWeQPjefwmLb+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aq8p4oCqiK3nuixc5S4/4pI0tMv855PAi0whpDl9WWToQV9OzJVxeBfoSvRGEVXplSsYLICqhLF6zDMfmcXon7kgFWKxzeLR0dlrSrzmXW1oU4EuKmGcCOmSG/zgSKq1qcp0CIDMQapdaRvKjkKrNOvKmfjI7oYz52dMyx7t+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrCRFEz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A232BC4CEDF;
	Tue, 14 Jan 2025 03:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736824210;
	bh=fDzyCyzKCDVgpzSiEGjWrvIDGXFGqgWeQPjefwmLb+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mrCRFEz/h1L1RK8fSIIq2HlY72RmFoyX+MAcbyJDfXeGS7Orit9vz3nPkQhyI7DVL
	 /92gvBO9t+KOtoUcPZmbDzh8vjacPsfsZcigkHaSbnWUpwZB8ng6kgF/rX6J3z54mN
	 F0p51KPeV7nUAUjZPlDdzKVntAxBuCqTPTjtavygzShtpmmwvSRhh6AVts+4hSyvgu
	 KY+P/+LRDMv3bUJ1eox/hJZMyomyE2znkxNfi/p+CfX2lUjoIyPul0Y3pNtxAtHoOG
	 k9wUUtE0a38JFxWKgfR2q95RaGW+GTNroczYBHmDBU4vPEHyAr8iyG+fdSoYlFtlKl
	 ++7USiKqIvz7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71F39380AA5F;
	Tue, 14 Jan 2025 03:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/ncsi: fix locking in Get MAC Address handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173682423325.3717681.7541247264915641463.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 03:10:33 +0000
References: <20250109145054.30925-1-fercerpav@gmail.com>
In-Reply-To: <20250109145054.30925-1-fercerpav@gmail.com>
To: Paul Fertser <fercerpav@gmail.com>
Cc: potin.lai@quantatw.com, sam@mendozajonas.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fr0st61te@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jan 2025 17:50:54 +0300 you wrote:
> Obtaining RTNL lock in a response handler is not allowed since it runs
> in an atomic softirq context. Postpone setting the MAC address by adding
> a dedicated step to the configuration FSM.
> 
> Fixes: 790071347a0a ("net/ncsi: change from ndo_set_mac_address to dev_set_mac_address")
> Cc: stable@vger.kernel.org
> Cc: Potin Lai <potin.lai@quantatw.com>
> Link: https://lore.kernel.org/20241129-potin-revert-ncsi-set-mac-addr-v1-1-94ea2cb596af@gmail.com
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> 
> [...]

Here is the summary with links:
  - net/ncsi: fix locking in Get MAC Address handling
    https://git.kernel.org/netdev/net/c/9e2bbab94b88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



