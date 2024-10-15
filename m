Return-Path: <stable+bounces-86375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0AA99F4A0
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 20:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245AF2847E6
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 18:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F681FC7D0;
	Tue, 15 Oct 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw152S/7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9221FAF1B;
	Tue, 15 Oct 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015228; cv=none; b=Pe9/tGroVdgPoe8p1dLVERVXCkl47KeTpNPIWxAMsbMwxckMeyvgTOxxhMgVcaVBIPPtTjBIbyiX3JTQiTmaFGtmd5g8wb4ny1TvmNn+FoNkRbNVdMFnataJxeukNCAJkQYxmITei1lpUkzadNkj8yGI1mXZNJXmpJ03jRoev/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015228; c=relaxed/simple;
	bh=mij/X30J/XczEgMH6nNnXtL6uh/rQkgw18iGPylR2kg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OoXzIQlMtmWP+Q5kA0DXSKLKShAcwo40XgFJKlzguUr938bWn9G5T8Y+bmI4xfNrrUBzD4gcRu8ygnkX/2XkbjlDrExoBwHaem3IDYhyMq9Ov+MJNoZN5t4CMKXp2PJfW/WVPF+6UCtZkb5yA6YnP+P58Xm0JdZ25Fp23J8XowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw152S/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F952C4CEC6;
	Tue, 15 Oct 2024 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729015228;
	bh=mij/X30J/XczEgMH6nNnXtL6uh/rQkgw18iGPylR2kg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zw152S/7hyFB+0SzLyd3Int0/+6KoOpkAr7Y2XRSosmL+RZX8ZMkWPyh3n4nIh2iZ
	 iI3nVPyRV08/c9Hg4Ui8yZKTuPTNMBLSbzEtV59xXR6TB0FFwa/VQ6zBP7wDy+dV+R
	 wrCL0It1QJZM40VvQRhF0kv3pLI9rh77dloldun0OUdk1fy0paIeHkQ7Y4Wk4l0HpA
	 iyGhDRylC01lBVoUbs4lFhtVLgKdPpxlxsEL7FvP4HBxQTQon5oDKN6k299xhSwYW7
	 /y7Xac3dhEJNJX4UrHZfgT9ejtRfGe8s3uirSZ6UOIgXL1AL/urXZz3SicTcnD/4+8
	 kWxo7UHcY53Cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2A03809A8A;
	Tue, 15 Oct 2024 18:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net: macb: Avoid 20s boot delay by skipping MDIO
 bus registration for fixed-link PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901523349.1243233.7852864309614579932.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 18:00:33 +0000
References: <20241013052916.3115142-1-o.rempel@pengutronix.de>
In-Reply-To: <20241013052916.3115142-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 stable@vger.kernel.org, andrew@lunn.ch, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 codrin.ciubotariu@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Oct 2024 07:29:16 +0200 you wrote:
> A boot delay was introduced by commit 79540d133ed6 ("net: macb: Fix
> handling of fixed-link node"). This delay was caused by the call to
> `mdiobus_register()` in cases where a fixed-link PHY was present. The
> MDIO bus registration triggered unnecessary PHY address scans, leading
> to a 20-second delay due to attempts to detect Clause 45 (C45)
> compatible PHYs, despite no MDIO bus being attached.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: macb: Avoid 20s boot delay by skipping MDIO bus registration for fixed-link PHY
    https://git.kernel.org/netdev/net/c/d0c3601f2c4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



