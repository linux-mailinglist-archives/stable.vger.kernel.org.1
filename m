Return-Path: <stable+bounces-119608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C65A453EF
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 04:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C124A3A4E6D
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 03:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB395253B65;
	Wed, 26 Feb 2025 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWZys88R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1A21C9E3;
	Wed, 26 Feb 2025 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740540004; cv=none; b=Tk1XEzpp7D9P/JXqK/mFT7qdiEs70kRriWiKmurwCf5OGysWUVMrK60Aj5zGPm27PcYFOKs55xChS6N63zwZAKpWH2MNK500cP0Izc4LuaWsd4LF2cOEhdS4080+jlvP5VBtLyV4xA/G9HvpFcwG0ZHCBcy7Qlg6SDqTTcmbpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740540004; c=relaxed/simple;
	bh=k4hCRHyENgmicRuN5VcKx1JS8isdwXRcveeCTdfunp4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jefDJn3ysVMSULFvcVWmAoNmPpalWCchizWAKtsmFTgHDhoPZV6MqRhDE1SEVFq8Hjig+xdiaf2D7zD0piqGZ+UycIBAMfOqbWmA/pdR/l4PcE94wbKyzgHtT7qgjTw8HY5PxPgrcDPgbv66wTdWlectTFpal2zLnabYoaNJQrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWZys88R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D10C4CED6;
	Wed, 26 Feb 2025 03:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740540004;
	bh=k4hCRHyENgmicRuN5VcKx1JS8isdwXRcveeCTdfunp4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HWZys88Rnvf8LelLsCvxFBcxSWg/SXuWZX/iGlQ0M6YmqvVPl28c6XwbydJq9HzJ9
	 rbg6QCYaPGvrCWRHgD45oioy7M+ZdpfNQEmf0bW/kmkICw0otc8jZFqjsBMGwYjJPo
	 OfzI+PY0JEJ5iLwlNa+3zAPr4hD7/xCelfs5bIdjWR8xnwV6vwvTS19vmftPrBhK0+
	 ulH0fbI63Wp+8cxFld9IMvAO4vZ7hQwf8eQq13GBsvh71w8xZR8YIem6G6Wq9PkcLq
	 iVuEB4ShwCrEknvl5mhyO4d0vxRzFmjEYK1roGXs4VOyYOYfWJ6ROKQZYxWBk87X33
	 v94MehxpSTUNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB194380CFDD;
	Wed, 26 Feb 2025 03:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net 0/8] net: enetc: fix some known issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174054003545.219541.12629809116438666703.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 03:20:35 +0000
References: <20250224111251.1061098-1-wei.fang@nxp.com>
In-Reply-To: <20250224111251.1061098-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
 michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 19:12:43 +0800 you wrote:
> There are some issues with the enetc driver, some of which are specific
> to the LS1028A platform, and some of which were introduced recently when
> i.MX95 ENETC support was added, so this patch set aims to clean up those
> issues.
> 
> ---
> v1 link: https://lore.kernel.org/imx/20250217093906.506214-1-wei.fang@nxp.com/
> v2 changes:
> 1. Remove the unneeded semicolon from patch 1
> 2. Modify the commit message of patch 1
> 3. Add new patch 9 to fix another off-by-one issue
> 
> [...]

Here is the summary with links:
  - [v3,net,1/8] net: enetc: fix the off-by-one issue in enetc_map_tx_buffs()
    https://git.kernel.org/netdev/net/c/39ab773e4c12
  - [v3,net,2/8] net: enetc: keep track of correct Tx BD count in enetc_map_tx_tso_buffs()
    https://git.kernel.org/netdev/net/c/da291996b16e
  - [v3,net,3/8] net: enetc: correct the xdp_tx statistics
    https://git.kernel.org/netdev/net/c/432a2cb3ee97
  - [v3,net,4/8] net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC
    https://git.kernel.org/netdev/net/c/a562d0c4a893
  - [v3,net,5/8] net: enetc: update UDP checksum when updating originTimestamp field
    https://git.kernel.org/netdev/net/c/bbcbc906ab7b
  - [v3,net,6/8] net: enetc: add missing enetc4_link_deinit()
    https://git.kernel.org/netdev/net/c/8e43decdfbb4
  - [v3,net,7/8] net: enetc: remove the mm_lock from the ENETC v4 driver
    https://git.kernel.org/netdev/net/c/119049b66b88
  - [v3,net,8/8] net: enetc: fix the off-by-one issue in enetc_map_tx_tso_buffs()
    https://git.kernel.org/netdev/net/c/249df695c3ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



