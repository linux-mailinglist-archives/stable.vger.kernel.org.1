Return-Path: <stable+bounces-54850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 502A9913151
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 03:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FFA1F23D8F
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 01:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0777C4A07;
	Sat, 22 Jun 2024 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+NvcuHi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4356A32;
	Sat, 22 Jun 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719019231; cv=none; b=TXOzobuVAbp51Wh8sJ1E/FZvRVMxvIlwlz+JEOVE7F7ORbs38Dd3whJMQR92rdV/RIyLLyBZqRCc3dZj+tHaPsDHwthvGHc6rx52IfSC5PSG1ueGuaAq9BCDlwqrQa5uDzElwCitaJf0B0mHh+Cy1iDL4fhiuT4o3r5hskza4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719019231; c=relaxed/simple;
	bh=myMQCTlzgeMQ6jiOQ7ZSjM+UrDbgE8T89P2Sms49IUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lIKLCjYAIG65p47ruquyXNHmX8tj7ZTvlqVOnLM0HIj1ZbR/0gn3mAMkxo/qa/6F7kfD2Qn1y2SGgXU+gf1wSabYEZG+7A+RQiwvdvarEV0tX3lzKJXpJhDaYA0KnNlXkN8uZZp7lzRgShMXS1QelSEpO8i+03o7OrNp0OnBBAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+NvcuHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D66CC4AF07;
	Sat, 22 Jun 2024 01:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719019231;
	bh=myMQCTlzgeMQ6jiOQ7ZSjM+UrDbgE8T89P2Sms49IUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q+NvcuHi/76nQQ6q7HRiM+b+VaeJllq9GDTOonXUjA9m6SXpwqDjGGrRAIlaf9AAy
	 hxbc9Wcj8U2p4Mkwuc4Kiv9PLXyiraXVkj/NAT1/uy2VOHt1bP4ag5XRyhn36y5Dol
	 JqAeYwQHhFr1xC5cLrsaZj/xvXzxJSaCwQFVPJuy1FMwXt5nAW80cpdImBnYiCjwep
	 uUIZjxhAfBSKculjFH/1hNaAaSZBN6TzISnlsx0slstFxPO+Ea66zy0gUi0HaP70GX
	 XOHw6FLARvygW58y+h3+bbySCVzfOM0lXwPSeZgwU1oFZjlOPGisgA3i2KuHRdiSIs
	 God6QpqYnIT/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FC22C43140;
	Sat, 22 Jun 2024 01:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] batman-adv: Don't accept TT entries for out-of-spec VIDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171901923106.1383.2164378801371432677.git-patchwork-notify@kernel.org>
Date: Sat, 22 Jun 2024 01:20:31 +0000
References: <20240621143915.49137-2-sw@simonwunderlich.de>
In-Reply-To: <20240621143915.49137-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org,
 linus.luessing@c0d3.blue

Hello:

This series was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Fri, 21 Jun 2024 16:39:14 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The internal handling of VLAN IDs in batman-adv is only specified for
> following encodings:
> 
> * VLAN is used
>   - bit 15 is 1
>   - bit 11 - bit 0 is the VLAN ID (0-4095)
>   - remaining bits are 0
> * No VLAN is used
>   - bit 15 is 0
>   - remaining bits are 0
> 
> [...]

Here is the summary with links:
  - [1/2] batman-adv: Don't accept TT entries for out-of-spec VIDs
    https://git.kernel.org/netdev/net/c/537a350d1432
  - [2/2] Revert "batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks"
    https://git.kernel.org/netdev/net/c/6bfff3582416

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



