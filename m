Return-Path: <stable+bounces-200105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EDACA6008
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 04:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D736A31D91B4
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 03:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669E92C21D0;
	Fri,  5 Dec 2025 03:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvDcl2bN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6882C11E5;
	Fri,  5 Dec 2025 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764905002; cv=none; b=W1uDFaD0lIuRxVDleFwTblyeQ5Exn9fCfvcXbKIWkmvJuRFZyM78K3Lm5s7bo4vm9R7+kpjuexUEpMwUp7g5Guk6vVtuBcr/1F9qpmw04PzsCMZYPAuTQCDZ8dfYgtukZa5K2x87kfQRXYs1+2RkZGWjQtHY8hNiLkGw+bTd6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764905002; c=relaxed/simple;
	bh=or9yP6M1EmYLSR6Zpjjpmw84zohg9WpXWhR4V9Shztw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AOoxIKuVaOhfrMdDgZ7tw1Yl8Pmzf7BdMGW/Q+WQKkIqqFRzt010ekhB1vP9lmde+nILJiBJ8XJKvHytHYNQqM1F/TVe2Mo8qqHLFnHd9VGoMpleS+/KOCQKQ+ohSo5zVJwzNEt1DkW/qBKaWo3MS4NWxA3+3+ttlI+2xLQ476E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvDcl2bN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B79C116B1;
	Fri,  5 Dec 2025 03:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764905001;
	bh=or9yP6M1EmYLSR6Zpjjpmw84zohg9WpXWhR4V9Shztw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XvDcl2bNkuHldDNmt4I6SeqJtyGyFbLhIsLywOyGmeTC0RXJJunGsV3wUiM2ARK9V
	 Ab+lsXgkWiq4imgRTgtn15cLQM0c1jqazpI9iYmS3U+4nQJWLzO+6T0VnMekumb1J2
	 MQuYbQaSTXd5gymuiTOCT4qzBN0MqzSHyRv0G2ITmHsiDPtJr+d2msUwFYOma8TgdQ
	 6TZnR7SFa8kyM/Bu9PjIURJbzDHi7shSV1dU00xe2uUGmaATIV+T1X4DIhoyP/zXVb
	 ez0FixPox2kcZbYc0FHNNZCJw36eSJ2XFwQPhwmkTL4sxuBSlYDYTnwN75OBW6ZVYr
	 E6Nq7B5Qjagig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A2F3AA9A89;
	Fri,  5 Dec 2025 03:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: marvell-88q2xxx: Fix clamped value in
 mv88q2xxx_hwmon_write
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176490481952.1084773.3572547538634420670.git-patchwork-notify@kernel.org>
Date: Fri, 05 Dec 2025 03:20:19 +0000
References: <20251202172743.453055-3-thorsten.blum@linux.dev>
In-Reply-To: <20251202172743.453055-3-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@roeck-us.net, dima.fedrau@gmail.com, stable@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Dec 2025 18:27:44 +0100 you wrote:
> The local variable 'val' was never clamped to -75000 or 180000 because
> the return value of clamp_val() was not used. Fix this by assigning the
> clamped value back to 'val', and use clamp() instead of clamp_val().
> 
> Cc: stable@vger.kernel.org
> Fixes: a557a92e6881 ("net: phy: marvell-88q2xxx: add support for temperature sensor")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net] net: phy: marvell-88q2xxx: Fix clamped value in mv88q2xxx_hwmon_write
    https://git.kernel.org/netdev/net/c/c4cdf7376271

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



