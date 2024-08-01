Return-Path: <stable+bounces-65214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2086A94409B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 04:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9A2281D4E
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E512F19FA87;
	Thu,  1 Aug 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqrSKcoe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8BF28370;
	Thu,  1 Aug 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475244; cv=none; b=XzRHFxX7fizSBxz+hcVsZKJ4I5kkS5Wxxw4QbwE2SqN7E4maxUMtFfuhi9HELortSYEISm8+1o42yJ3Ntmc7cBcDVzBwx7dTZ+QYjoGyzVOpSiYlmTNcDjlWVoynbA84Pv4Ewu+7uKtYQQ2ZepdCHJEKZTx5jB/jYwYicO96KEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475244; c=relaxed/simple;
	bh=0Cj2CYi5Yaa/r8yTIhFd9T0uI/B1fVza5+1vkd36H74=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TeACmzD4m67epCUxh1sA4Ti8zu3g7/8nofkmWwhYqVqv5q1AW/VhgQVKrULUsc/h0D8xcvGviZOg9ZC1W1v5Iu+3uPU2VQKvBBzjkZREXsHfYlYV/sUntDKJd2KsvHEApf6R4pjw1YYGrxDEHi5mUY87lybGm2pxeOCajL8FjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqrSKcoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 496C4C4AF0E;
	Thu,  1 Aug 2024 01:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722475244;
	bh=0Cj2CYi5Yaa/r8yTIhFd9T0uI/B1fVza5+1vkd36H74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aqrSKcoerJZT5xTH7Z3RNqdF2mgkwPn9FeI/0Ffr/SK1nb3NvbO1z5beD/ujlJFBi
	 YkeAV6hjwTlfaqLj1LFiCGncqnzoS+arc8j/tK1436FGJifqGIaHdWdkl+8YsMnp1h
	 SqHNqPno+1WhXaHNPY47n0PNdK8HKFJYiq1PXgKez2JPq6igX8CVssuxRPQmB5ESEb
	 +Pvywrt/b6iAR5Mq/CvHMUSC7CPPWOjGQa0xokpFNH3x6OjPX9XrhQVexN2yrSujGb
	 SWZGYRHhpPFez2pKSVvY+tK4hEIaJQGDN3/dYmmMNKfOvkqYR7ivMPwtmHCNU6m+7u
	 rEdyAAyNLAvhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33592C43140;
	Thu,  1 Aug 2024 01:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: wan: fsl_qmc_hdlc: Discard received CRC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172247524420.27205.8731063476744531287.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 01:20:44 +0000
References: <20240730063133.179598-1-herve.codina@bootlin.com>
In-Reply-To: <20240730063133.179598-1-herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, christophe.leroy@csgroup.eu,
 andriy.shevchenko@linux.intel.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jul 2024 08:31:33 +0200 you wrote:
> Received frame from QMC contains the CRC.
> Upper layers don't need this CRC and tcpdump mentioned trailing junk
> data due to this CRC presence.
> 
> As some other HDLC driver, simply discard this CRC.
> 
> Fixes: d0f2258e79fd ("net: wan: Add support for QMC HDLC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net,v1] net: wan: fsl_qmc_hdlc: Discard received CRC
    https://git.kernel.org/netdev/net/c/e549360069b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



