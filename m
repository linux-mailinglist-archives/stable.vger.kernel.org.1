Return-Path: <stable+bounces-80615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E66A98E7D0
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 02:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8B81C22D7B
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 00:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0D1DDAB;
	Thu,  3 Oct 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fjwyc9+X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46805CA64;
	Thu,  3 Oct 2024 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916032; cv=none; b=jBlZN5his3qZT6XDoEPfzrz31EjMVzLX/Au3NuZuZbkS3h9kuA0cgHNvGo2s79w5l5uJj25kRZhW8jLjB5B3Skta4wn358KU+M+EsUntmlXZFbU8khHbhI8xFWTGVZf1ntorncKSP6I87h8G9n78v63p6WX1NAWnKUMczrRvOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916032; c=relaxed/simple;
	bh=a8kiDMyBZYunGqoPBmv/ughncOeGrXzaANZPU4mmKiI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MSq0f5b/GnGbCrv3PFQ2eWt/cudc46yDE3a2MOybLHUgtOCw6/GTBZLO820dh5CtcVFe/GwIfVLe7bjNxVW/7MydKZEGqLwf8Y/R0rNyvF7DeaDSb+tnRNafqjLKlUOj3oTTgmJS5LHXjR0OUlM8Eql5egFgPmjOaUFyWoGUDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fjwyc9+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0C8C4CECE;
	Thu,  3 Oct 2024 00:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727916030;
	bh=a8kiDMyBZYunGqoPBmv/ughncOeGrXzaANZPU4mmKiI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fjwyc9+XNXQ5+4Ww4lV3CHo9MYwfEolB3ocSg6zGHMFjd8EHmVCKq73v6ZLhluLTO
	 ETVBtbEF+bK2D7DTYa2qOzvnbCuWBefn8jokn3VC39QfaTf1NeXeg4B+d65aBwMvfA
	 8Uv2Pzx42/KFdOQG0/DOgHSrHaZzZkHK839zwGP1Q9wjgmRHMe1bFgl6JLb/NO9C2Q
	 qRm61YjNrmgM2fCD2R808GMg5E/t70df4Al7QJRtqylLJ2mSRSRpp0SIl3k3GVHWhd
	 2GgToWNmcF6tE8jysD6vj4k1BH6U4TIlCrLBVPC6zzAvud96T5MnPQAnBz2aaRVe9B
	 W5aO7dGxe4WkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D37380DBD1;
	Thu,  3 Oct 2024 00:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vrf: revert "vrf: Remove unnecessary RCU-bh critical
 section"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791603400.1387504.13460759411219381314.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:40:34 +0000
References: <20240929061839.1175300-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240929061839.1175300-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, stable@vger.kernel.org,
 greearb@candelatech.com, fw@strlen.de, dsahern@kernel.org, idosch@nvidia.com,
 willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Sep 2024 02:18:20 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> This reverts commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853.
> 
> dev_queue_xmit_nit is expected to be called with BH disabled.
> __dev_queue_xmit has the following:
> 
> [...]

Here is the summary with links:
  - [net] vrf: revert "vrf: Remove unnecessary RCU-bh critical section"
    https://git.kernel.org/netdev/net/c/b04c4d9eb4f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



