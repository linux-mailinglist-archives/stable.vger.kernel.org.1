Return-Path: <stable+bounces-136741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220EDA9D721
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 04:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50E74A3452
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8F0205AB1;
	Sat, 26 Apr 2025 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxC8ce/+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA9204C0F;
	Sat, 26 Apr 2025 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745632800; cv=none; b=nW+iOrcbFshNsGAHk3xmgLQJSZiCdIP99NSjwymlszPm3i/uvWIo26LUgkZLi/mgre0SFI3hoX6tOtCjc/khq1AD1PhjbAlrjLIQ/nWdJHozNParnXdPS1P7qFDKJW5yXjSVdtq/PUoEEavgoUb/bPxKI+xiTRJIHdlyNSh3o/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745632800; c=relaxed/simple;
	bh=RYL8C4Y5ne48VhiH6iHbk3yOFuT7Zq4jtWwMf4+QlcY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IgbT4ub1S4F805Bmq2rGk3B7AhzTwOVn/MjpCoylitTCcF981jMKDER119vFSK+6zLEvprvAiaGKfAnQjLCYS+T8hhT94vugkSBAZt5TRuy+1R6TWtFLn/LJ3ynfvpBS0yhrKvFtCK61eJMPcYTVYDY+5TPmEq12pxg3/Hch6yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxC8ce/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FF3C4CEEB;
	Sat, 26 Apr 2025 02:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745632800;
	bh=RYL8C4Y5ne48VhiH6iHbk3yOFuT7Zq4jtWwMf4+QlcY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cxC8ce/+qVwaAt6BiZsX4Kbj3dhAXHmXu+zd5AGQlmIwOcu3TfQfjoFC5ALv27noc
	 wvVc/P654otdIG2OAIN+wHlLqfYasW5IeoNDQXlJWoKIQsu8VaEPVU4Rk5sB/hp2Wq
	 zeLghLXAxPyxRXn0LHYxq2ey4TaY2C14UR8KWx9ykGkVZR4mz8iuX7ehph3cOPPCU/
	 0T8glxLXFD+3KEmQW4mKwtDmbMUcvrfR3KpeomF361YAmn3WvupnIzqphGfYowB1Zp
	 8A1a4IGVaEUJ8MEdJR7SJNvpDatSKrCLKIfYfqNa/6OY+Z5IIHJcKow5WJyHkswCUS
	 hvsncrKEPXX2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D56380CFDC;
	Sat, 26 Apr 2025 02:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "rndis_host: Flag RNDIS modems as WWAN devices"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174563283875.3899759.2142163669811028144.git-patchwork-notify@kernel.org>
Date: Sat, 26 Apr 2025 02:00:38 +0000
References: <20250424-usb-tethering-fix-v1-1-b65cf97c740e@heusel.eu>
In-Reply-To: <20250424-usb-tethering-fix-v1-1-b65cf97c740e@heusel.eu>
To: Christian Heusel <christian@heusel.eu>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, lkundrak@v3.sk

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Apr 2025 16:00:28 +0200 you wrote:
> This reverts commit 67d1a8956d2d62fe6b4c13ebabb57806098511d8. Since this
> commit has been proven to be problematic for the setup of USB-tethered
> ethernet connections and the related breakage is very noticeable for
> users it should be reverted until a fixed version of the change can be
> rolled out.
> 
> Closes: https://lore.kernel.org/all/e0df2d85-1296-4317-b717-bd757e3ab928@heusel.eu/
> Link: https://chaos.social/@gromit/114377862699921553
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220002
> Link: https://bugs.gentoo.org/953555
> Link: https://bbs.archlinux.org/viewtopic.php?id=304892
> Cc: stable@vger.kernel.org
> Acked-by: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Christian Heusel <christian@heusel.eu>
> 
> [...]

Here is the summary with links:
  - Revert "rndis_host: Flag RNDIS modems as WWAN devices"
    https://git.kernel.org/netdev/net/c/765f253e2890

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



