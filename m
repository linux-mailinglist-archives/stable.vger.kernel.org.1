Return-Path: <stable+bounces-152564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3C6AD7554
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 17:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C61416701B
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E2C2980AF;
	Thu, 12 Jun 2025 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQXGFcQG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254B289369;
	Thu, 12 Jun 2025 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741010; cv=none; b=VHx9h/J0c+3MStSzmvOYv5lqH6fQA9+v2GWjVyhdqby0p/qF8aEfix70iOMB/XZrHrgSt3biDVY+f78AVPnZ/Mh1JdvyFLszBJOiVy/QxGc6nSqbnSVZ7SmgFc3l+AFhydS+fRogcfc56ACusmJ3ULrb9rL65TeJF4SgvXClyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741010; c=relaxed/simple;
	bh=XvQTsKriWbqAu8Zx+Vc1Yg+icq6iSLtma+PD/pMLNnY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cu2HpBbfHx/6FHcIy478OjcUpq03ZFFnFkl961R0xM13upW6qZ9/s7ysoqyeiXyKLlIGufqg+xPSDlB5MMoKgpg3XV41SIWeXBfKSX0wFmjy2NWLPKIa9Yv1EBO5nyOWGR99iWc8o8tMoiIIUrA92NdUkzUKE92gSxsFHKIQbS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQXGFcQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F91BC4CEEA;
	Thu, 12 Jun 2025 15:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741010;
	bh=XvQTsKriWbqAu8Zx+Vc1Yg+icq6iSLtma+PD/pMLNnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RQXGFcQGlF7Ilm2kXv3gCaTAz36u27B84AR6RX7Ekx3ig5wKokgx7d+C1qTffNA5P
	 w55VKnVslQggIf0oWrehX+7bFmKvXB9R1xbZ/PiZj3M9YUaaHO5qukhRTcdbBXnQGv
	 N0s90y7JSsT7DfRMlCPjZ4oT0iiIayEZB2AS+DffOoyrXV/YV7cpQm/sECrkhhDYtu
	 J9y/FrREhYqgXEP0XXVO8c3Nm54XAp3TpWD0qr2wPOWBHBDcIOAtm5AJCjd/7rvGdH
	 kHIL/o+2e/DGqrmMlu3tJc9gEk8V0/Pw1jKQKNG5V47MQHrKipa4Y9pmTpwvm5wKEp
	 O1WLSYkPKtNYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C3B39EFFCF;
	Thu, 12 Jun 2025 15:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net_sched: sch_sfq: reject invalid perturb period
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174974103999.4173578.3649013522414543337.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 15:10:39 +0000
References: <20250611083501.1810459-1-edumazet@google.com>
In-Reply-To: <20250611083501.1810459-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, gerrard.tai@starlabs.sg,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 08:35:01 +0000 you wrote:
> Gerrard Tai reported that SFQ perturb_period has no range check yet,
> and this can be used to trigger a race condition fixed in a separate patch.
> 
> We want to make sure ctl->perturb_period * HZ will not overflow
> and is positive.
> 
> Tested:
> 
> [...]

Here is the summary with links:
  - [net] net_sched: sch_sfq: reject invalid perturb period
    https://git.kernel.org/netdev/net/c/7ca52541c05c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



