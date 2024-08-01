Return-Path: <stable+bounces-65212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA0B943FDD
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6541C22C03
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A2713E04C;
	Thu,  1 Aug 2024 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSpq9c+7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B1B13DDC6;
	Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474637; cv=none; b=sInsHPsFtAl/qAxQ2VHsLxXc/9NKH9Q1gHvZ/7KVlptGF5Fn7DS8m5Qmj3NWJqwj7bytwHUQ8spk3ORjHs9K525ksJRvO4t6MgH7AbpTMHuQXDfpqxssOIEPmqOaUOu2fGysttVRSOrTWnmJ9BlP7sIo8DIWjvAPXsRpqfHTxu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474637; c=relaxed/simple;
	bh=iJtqiAXqX0LwxAhBTKTJEZ3kteVZpRMr4hNaCqlp3Z0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PKazESFVwcPWXJAzza418/Mw1dcoVlk1yhPrvOCsWIpYb73yeCutbCdnK/s2K6MTskEzrpFktajGqhNvHeAZAdUWY8P2UkKabpnVHZJcMaSCWktN1/O1pAD/JSOvYuLH2tIKc2YsfYwLUXlIgQ3wDmoUAtYAcx1SH+JvxhRjOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSpq9c+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44D88C4AF0C;
	Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722474637;
	bh=iJtqiAXqX0LwxAhBTKTJEZ3kteVZpRMr4hNaCqlp3Z0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hSpq9c+7ucTqqSamea53A4yOmCM0BtaeXgsKY7gCYPqzUCBIJ9xLMyUO+15GxxKf1
	 2D2Ovvzj5jTWMTuVqRZqjOsTnFjhnSAxE38s2mHeYjDsvVWBhKSLiWs0LvaAPo1//w
	 G9XWDUDl8aCqLMmKpJEbZymEEtBsk0gLMPvshv5OUhNYE08UEwIvrZZbP6TQOhUKtS
	 UlToWm1qXqQF6vCapVJp51OlMFndXIXwxDcgZ2m+7nXXKeFzO3LZiV0hnlCN5LjN1W
	 uzP7m3usl/fnk3CvIzbj8DBd5BESdeXW8ymDR5mVGVKM90kAyoKW6zk2r/PlQwACX5
	 q8eqW9dwoPqjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E43AC6E396;
	Thu,  1 Aug 2024 01:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: wan: fsl_qmc_hdlc: Convert carrier_lock spinlock
 to a mutex
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172247463718.20901.3118468784661815872.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 01:10:37 +0000
References: <20240730063104.179553-1-herve.codina@bootlin.com>
In-Reply-To: <20240730063104.179553-1-herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andriy.shevchenko@linux.intel.com,
 christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jul 2024 08:31:04 +0200 you wrote:
> The carrier_lock spinlock protects the carrier detection. While it is
> hold, framer_get_status() is called witch in turn takes a mutex.
> This is not correct and can lead to a deadlock.
> 
> A run with PROVE_LOCKING enabled detected the issue:
>   [ BUG: Invalid wait context ]
>   ...
>   c204ddbc (&framer->mutex){+.+.}-{3:3}, at: framer_get_status+0x40/0x78
>   other info that might help us debug this:
>   context-{4:4}
>   2 locks held by ifconfig/146:
>   #0: c0926a38 (rtnl_mutex){+.+.}-{3:3}, at: devinet_ioctl+0x12c/0x664
>   #1: c2006a40 (&qmc_hdlc->carrier_lock){....}-{2:2}, at: qmc_hdlc_framer_set_carrier+0x30/0x98
> 
> [...]

Here is the summary with links:
  - [net,v1] net: wan: fsl_qmc_hdlc: Convert carrier_lock spinlock to a mutex
    https://git.kernel.org/netdev/net/c/c4d6a347ba7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



