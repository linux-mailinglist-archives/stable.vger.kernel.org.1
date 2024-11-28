Return-Path: <stable+bounces-95691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AAA9DB4B1
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 10:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C50B21ABC
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 09:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E87154C17;
	Thu, 28 Nov 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgbSfD9T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96E145A11;
	Thu, 28 Nov 2024 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732785617; cv=none; b=tRh6cm0B+2E1/3RYQEi92byKUBkr6hY5wa7RXloqfnFrJKwD4gfb1upPn8aJ15rCuFgSrpgHu34utZfTNpWqRtE5uq/JoS83EpdDajvTFQqG2rXsybV0yPrFJpgmVB7SXHTYaogxrgDopXIIRJs7XcMNPTVkjnB1TmcfSVzxL0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732785617; c=relaxed/simple;
	bh=GDuSm73QraAtt0oqnAK19yP+OXaRigKSiICRLGas0Dw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QSnqTiK6uuwhd/89dmW8N8I0JfkjMRZ2KudKK+3dKqn8o1VyGpMWiptjsVB9DrgGnzgWcO5GmPqCwpWhAfdtyLMJvXMYXSqPN4eAOnZD2TOKvkoMZQphVFbS0ZpboG2H0U6H1uVXdKs47HDw9coepnRPO+65mo2gvhdsD4ggTTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgbSfD9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47813C4CECE;
	Thu, 28 Nov 2024 09:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732785617;
	bh=GDuSm73QraAtt0oqnAK19yP+OXaRigKSiICRLGas0Dw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sgbSfD9T3ZO+dlsiWGuaKltfUvkvzSXlFbC2LFZLOceofrWwMNc5IZFAiA4eu3X2m
	 RoObNhczJnROLtXPUYgEyHPztKw0AzZWkPyhZ368jzEU9o1dbrFIm9kjQxCbAzZZ3v
	 LyOOWa0kNQatT1dOM9PUuKiiLo23m6XIxMU9OjmBOfkbpO1lflED4MFtfgGIMICUbM
	 Wj4E5tXj8KG1FOaZ8C9mO93onzaotHG3D75DEkaaVbzcJRNNnEHEhbuQ+PKEp2v0CW
	 L1IH3md6eH3nsBQMiIdXs+1BxvVOYGF1odcCcdHsxlVzuyh1sOsx7KhUJQu0vNJF/K
	 +lkRpMkeCBqoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD12380A944;
	Thu, 28 Nov 2024 09:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net_sched: sch_fq: don't follow the fast path if Tx is
 behind now
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173278563051.1673806.10013100672638771740.git-patchwork-notify@kernel.org>
Date: Thu, 28 Nov 2024 09:20:30 +0000
References: <20241124022148.3126719-1-kuba@kernel.org>
In-Reply-To: <20241124022148.3126719-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, netdev@vger.kernel.org, davem@davemloft.net,
 pabeni@redhat.com, stable@vger.kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 23 Nov 2024 18:21:48 -0800 you wrote:
> Recent kernels cause a lot of TCP retransmissions
> 
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  2.24 GBytes  19.2 Gbits/sec  2767    442 KBytes
> [  5]   1.00-2.00   sec  2.23 GBytes  19.1 Gbits/sec  2312    350 KBytes
>                                                       ^^^^
> 
> [...]

Here is the summary with links:
  - [net,v2] net_sched: sch_fq: don't follow the fast path if Tx is behind now
    https://git.kernel.org/netdev/net/c/122aba8c8061

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



