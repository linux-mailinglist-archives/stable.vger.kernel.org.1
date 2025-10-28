Return-Path: <stable+bounces-191372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4025DC127DE
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 02:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EB0F354627
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 01:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F861E47C5;
	Tue, 28 Oct 2025 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnPPjTsC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDF61531C8;
	Tue, 28 Oct 2025 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761613828; cv=none; b=HHATHDHG9GDbSqcB1f9JC2X75Eq+1sn2k7ge/WZMiT+ZjBVCwAuYt/7ts4tm38MtK48tsCuX9uELJKBDwQspDI6Wg/3fppHhqwGvkdP7YC7yPo3wswguw0Q3TNnmu02ho/2brqZoUC9L9ZKv1xdq+j0HZA6Y/NuRzvYtnKPFIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761613828; c=relaxed/simple;
	bh=wVaT28yBfsup28vEdLuACMHTePkpOekM+7EufB5qAhw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e29NfJHe8ewOu1uXsyFRbpzTNEWGvgNBVMbg1oJL7JAk8o+NEFmUPVt9QqP1FtAQTMLNCKJi7MwKHD693VWKAOIsHoUTO3Zn8oOl6Ki3WoDiwR3ShV8z+yUMSw1LHZP0Wia/JdeGDDMxXKaG0SgBk3vINIyRux5E1tus5dfXIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnPPjTsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6BEC4CEF1;
	Tue, 28 Oct 2025 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761613828;
	bh=wVaT28yBfsup28vEdLuACMHTePkpOekM+7EufB5qAhw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YnPPjTsC8LYWRKb5n+0BIhpy5Turp0Eah6yM2UlDMH5nWLdcpHme2kZo5iigbfHcT
	 WjmgU1lGEwltGeCQJt2nDV/xqy04yD7ytCy18grYHw7hEgoXJ0k3AuuPGIe7AHWvOi
	 WiHqaFlgCXWXvzmElH2G8defmcsUes9b5tjjC+TqcWfdGVk3LRVOD7QpI3SN/vbNdY
	 +kHmdGW6aTT+vwcCtPhIlU9bxv9uqZTL29gCa+Cnm3d8vZ5kKcdaFnXAJJMCeGaPBa
	 JgiLfwpg5zIi7ibuL3aEnM0LiauXPPhjWkViYvNoGS5AQlzGoH/sBxZc3Qct36h8AI
	 LBmAzF36QdQGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DEA39D60B9;
	Tue, 28 Oct 2025 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] batman-adv: Release references to inactive
 interfaces
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161380600.1648894.13441398313655370264.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:10:06 +0000
References: <20251024091150.231141-2-sw@simonwunderlich.de>
In-Reply-To: <20251024091150.231141-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org,
 syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
 penguin-kernel@i-love.sakura.ne.jp

Hello:

This patch was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Fri, 24 Oct 2025 11:11:50 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> Trying to dump the originators or the neighbors via netlink for a meshif
> with an inactive primary interface is not allowed. The dump functions were
> checking this correctly but they didn't handle non-existing primary
> interfaces and existing _inactive_ interfaces differently.
> 
> [...]

Here is the summary with links:
  - [net,1/1] batman-adv: Release references to inactive interfaces
    https://git.kernel.org/netdev/net/c/f12b69d8f228

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



