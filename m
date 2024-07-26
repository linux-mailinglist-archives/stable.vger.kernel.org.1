Return-Path: <stable+bounces-61860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D36693D101
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 12:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95F11F2166D
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA317838D;
	Fri, 26 Jul 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfMeHI7Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182922B9C4;
	Fri, 26 Jul 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989230; cv=none; b=RC2bTICGquIYEi6yFoTxpbmaoC0KUjYiRhgynAHdiwjD/gxQ/PV20L76rvMK3FkG3ztE1Yv73oGtNd3UWhrjH9WpvBobslAHyRbtZ1qC1MQdqz9xBYc16ugsoUV61zmQzsRe+XP8ccuus1NWtsYWmKy+3Rjv7p753vVRm8VLBiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989230; c=relaxed/simple;
	bh=dYUL+jP7MFdCrpFd9aiIGMAeKUv3+T7KQF6M/T/RLPs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W7h/dUgi/fizE4s9uqmWJDi8K8VajSp6hE50c4uwrV9Uk2zXQkaIE7VgQrey3rTAazoE67xj5VDfLTh+f0azyVH7rbQnBxVRRvp20BRIwkt25rYX2gXIhQLRi99tBQinp3ApN516VvAqMpoTURdnmNe77O/IWY0b6e5jfjDSGss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfMeHI7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 852E4C4AF07;
	Fri, 26 Jul 2024 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721989229;
	bh=dYUL+jP7MFdCrpFd9aiIGMAeKUv3+T7KQF6M/T/RLPs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sfMeHI7Z5ZVZYHRt9rTByIywy4Sn37Yk8cSWT13ExJMQCmpGPo3mc8waU/MekL3kW
	 O/shYWfzbcnyPFIN35UoUDOAyLucmIGHK5LaGgJTizEqdi4dnTsoezkdMnqOA/Tvc7
	 j+/cgpXUWmtzM/M7GFZWrfF3RYQzMqCOUTDqlaOTgs5+jUZU2L3Fgz4bn4OME3EQgt
	 bQOUreTMmYzac1RhQRz2U0yXyBemfCT1Q0UqoVlzzr3mTKeGRzlkRZeFUI2exBi+G4
	 Vegq8T+fSgRXTittBXFcMla7dgJxojMyz0Qja4+LD2XkJElTupLntdo3BMMmtmCVsS
	 EE2LEmT3sRFgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73D79C43443;
	Fri, 26 Jul 2024 10:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: usb: sr9700: fix uninitialized variable use in
 sr_mdio_read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172198922946.6762.1014602508921624498.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jul 2024 10:20:29 +0000
References: <20240725022942.1720199-1-make24@iscas.ac.cn>
In-Reply-To: <20240725022942.1720199-1-make24@iscas.ac.cn>
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, liujunliang_ljl@163.com, syoshida@redhat.com,
 andrew@lunn.ch, horms@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 25 Jul 2024 10:29:42 +0800 you wrote:
> It could lead to error happen because the variable res is not updated if
> the call to sr_share_read_word returns an error. In this particular case
> error code was returned and res stayed uninitialized. Same issue also
> applies to sr_read_reg.
> 
> This can be avoided by checking the return value of sr_share_read_word
> and sr_read_reg, and propagating the error if the read operation failed.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: usb: sr9700: fix uninitialized variable use in sr_mdio_read
    https://git.kernel.org/netdev/net/c/08f3a5c38087

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



