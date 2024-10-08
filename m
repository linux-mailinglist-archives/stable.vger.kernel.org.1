Return-Path: <stable+bounces-81494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B30993BD0
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 02:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D715B1F2545C
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 00:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247CCAD24;
	Tue,  8 Oct 2024 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZCYfcPY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF375CB8;
	Tue,  8 Oct 2024 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347429; cv=none; b=CdcPcFAd/TUEAkz6V6SxAJeKbjdRtNgXFcmC0GeMhuapP9MWFaQ8CYhDKuwV2MjvrS4sKuFuIS6kI4teQ4LFBKZDd5PCJCTknZ2+6C6Y3Y/CjM09DA6cayXaQhHhMJPAnHVXHM0nrVIt4wxb4FFgzmDQG611pHsjo1/By99onrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347429; c=relaxed/simple;
	bh=LR+66PIZDCLRM9rIeo+eZuTI1N9M2wiWvawCZUyRVvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lRRTz7RIfKLGsN+1W2Q/8kEfUqqmdE5dJDl5DabUv881rvNwge1bm4usHiqrEmm5JYYgZC6C60dpKTp3X4xKiiA4z4TodChFPcjxzQDV704bP85F9UYuWqlofMutkgsZFexzeDvnZPTiRdnObhBxx3076C2dU1pGh4DfeW57svg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZCYfcPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDD6C4CEC6;
	Tue,  8 Oct 2024 00:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728347429;
	bh=LR+66PIZDCLRM9rIeo+eZuTI1N9M2wiWvawCZUyRVvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aZCYfcPYTPlav7rxbuArNx8Rs3VfcEJnQ2fum9Pt9bb4YDyiw6SSy+B7Gn516Y1H3
	 Dup/6aJvKdm66qQdt4SM+q9G7K6UtmrSH6tUv20ALAhCWYJGLpMbZOGomXcVojiX48
	 mngSfTaCRNkc1HvwK2Aobl0T6uyY3pJA83CXwoWxdRGctppAonFoWq1LAPez5NDz1d
	 eiEyJeEJCgCEYFAkOq8QDhBvciK8ZNGyinDPMlg8M9tWAIjpkqEsdnCggRztdF3unI
	 1mJUGbJQVts1QFZPy7vE8xnZZKBj+REFquzSyIGOsKvPaU8hLCFLBf/M43piqUuDHM
	 FFSMeFfPxcUPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDCC3803262;
	Tue,  8 Oct 2024 00:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] net: phy: Remove LED entry from LEDs list on
 unregister
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834743352.29256.16908590160234613489.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 00:30:33 +0000
References: <20241004182759.14032-1-ansuelsmth@gmail.com>
In-Reply-To: <20241004182759.14032-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel@makrotopia.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Oct 2024 20:27:58 +0200 you wrote:
> Commit c938ab4da0eb ("net: phy: Manual remove LEDs to ensure correct
> ordering") correctly fixed a problem with using devm_ but missed
> removing the LED entry from the LEDs list.
> 
> This cause kernel panic on specific scenario where the port for the PHY
> is torn down and up and the kmod for the PHY is removed.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: Remove LED entry from LEDs list on unregister
    https://git.kernel.org/netdev/net/c/f50b5d74c68e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



