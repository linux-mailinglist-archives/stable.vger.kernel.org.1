Return-Path: <stable+bounces-65464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D675F9485F5
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 01:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142C71C21971
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 23:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A918616F847;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhAxExI9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C616D9A4;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900652; cv=none; b=mbH7d6z0X0XrFIU522KIwR+UV3Ec2rcWeFQpcX/mEQrsQB3YHrwUCCEW5oztJuzLYuqjT8aH1MkEL6LYs36Jnb7oGvxq8vk9ISNBCkbide8DP4xow8IVnbADT3lq8b2UtvgXQU0VhcAWPMwdDnig+asCd4Z8y/kvAPL0QoJKH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900652; c=relaxed/simple;
	bh=2bOiXsWKrVE2uHZy+sq7DklnFUHwG0Rbbo7m8zPxh3I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UaYnKUWVSvxvYAd+oyRdez8tEI9ICNxhK7/Rjd7OC4/Loih4a311K0NlXSH5T2U3oTH8Df8q6pfn05nbZnsF96MbBDaMfMi9RQFI5NLN29i1q1mTjDKPCmHckiSrCgxqT1Hl9XIywXbcufZOjuFbFjxOn1qjCDJI4Br06gi+CqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhAxExI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BF01C4AF1C;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900652;
	bh=2bOiXsWKrVE2uHZy+sq7DklnFUHwG0Rbbo7m8zPxh3I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jhAxExI99t5ULNkFW0f1Sir0J0nqmAoAyV74XeVWlcfauAvCcVrhd5SIb416ytXwx
	 Wg0YG403WalVA+2HhcE+TS/fsgPTnmObutdMW47MrPaqs1CNz85UMbTO3Bylp1ekaT
	 2ePCUxtOYoosMgMH0W7mNGN4GUmHqWOnM7nRjbpZLzOy0V84odAbnVpGJ00AVRlP1k
	 VWGI6ayQJgLDRCQJmmCivLjhWJo3cnG3Bdp94y/1KnWEgG/aJs8QWCmcn0C8HwWkuN
	 X2oWWeJcYIfhuUERb0za0CYOnh6YPsTby9FxyCVsvTDwNnI6Voqg6LTaQelKo5adu0
	 ax8oqNBSnOaYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 040D2D20AA6;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid potential int overflow in
 sanity_check_area_boundary()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172290065201.2803.7144786550538079483.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:52 +0000
References: <20240724175158.11928-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240724175158.11928-1-n.zhandarovich@fintech.ru>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: jaegeuk@kernel.org, chao@kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 24 Jul 2024 10:51:58 -0700 you wrote:
> While calculating the end addresses of main area and segment 0, u32
> may be not enough to hold the result without the danger of int
> overflow.
> 
> Just in case, play it safe and cast one of the operands to a
> wider type (u64).
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: avoid potential int overflow in sanity_check_area_boundary()
    https://git.kernel.org/jaegeuk/f2fs/c/50438dbc483c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



