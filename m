Return-Path: <stable+bounces-43750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F868C49D0
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 01:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90EF283042
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 23:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4210084FC3;
	Mon, 13 May 2024 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOEaI03q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FA884DF5;
	Mon, 13 May 2024 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641230; cv=none; b=mxsJwH9MiGr55PjSTl4N005jETmfB+tgxKTEeKVqhaekjGJoRbYorDMJBQATwJB7PjindNwdSfnMmqHTn3Kz0XxNg3qu/T7YUUgNoqrYCuVoc++pD7GKS3+eV9ropb1Dvsb/bRj8oRo8dI9k8Q2nzwiOfGqJfNBOusYyLv+b2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641230; c=relaxed/simple;
	bh=QWrQMMenbKUQZ4QzgI8cJC76I4htY/Ol5+3qgfUWMtg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=odASRdCTUX2BQOLs3Qn1J6fEAle/gmsHDOvM/LetIzCf0I9LdSeGwYPdOEAEmotq21P27gh7HN58iJ0xymF+zKYhEKn05VJrkahpA4v/IEmpa05gCODI1x/JshOMjiodOlN5HIyojo5reEOeB3B4633yyAllx7fJlI8hoBwkFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOEaI03q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CC0FC4AF08;
	Mon, 13 May 2024 23:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715641229;
	bh=QWrQMMenbKUQZ4QzgI8cJC76I4htY/Ol5+3qgfUWMtg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YOEaI03qFecQxBfmfNecZiuwK11A9mZnBfo9LB+k7+i66pjQCAau16LEcmd5TKKl6
	 nJieIM1rL6Z8qGtrZfZgQWJPb+ykjkFO5TkE2ZkTVOnMRlRrb0WBg30FxWLFuPz7XL
	 zaLEY9V8jxbc4eGOJizXA8IxAeZjqhEb5rs8s5rLEczhqGMavWW4D/DV/Du3jRlLMA
	 R+6LW98J+xgktd+vVBwr5xm5pE0SdyqvhltAxfMMZ9CVjhxH/pFfE1awqsC0dGxi9S
	 pTUy3kkj7sxPgCQxbQrXNDNOES7sca2HaOQSBeQin+IhsHFK19vlBsCYUxG79oYhVf
	 ZSmu8jIEvdkGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87AF7C43443;
	Mon, 13 May 2024 23:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set to
 down/up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564122955.1634.5508968909715338167.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 23:00:29 +0000
References: <20240510090846.328201-1-jtornosm@redhat.com>
In-Reply-To: <20240510090846.328201-1-jtornosm@redhat.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 inventor500@vivaldi.net, yongqin.liu@linaro.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 May 2024 11:08:28 +0200 you wrote:
> The idea was to keep only one reset at initialization stage in order to
> reduce the total delay, or the reset from usbnet_probe or the reset from
> usbnet_open.
> 
> I have seen that restarting from usbnet_probe is necessary to avoid doing
> too complex things. But when the link is set to down/up (for example to
> configure a different mac address) the link is not correctly recovered
> unless a reset is commanded from usbnet_open.
> 
> [...]

Here is the summary with links:
  - net: usb: ax88179_178a: fix link status when link is set to down/up
    https://git.kernel.org/netdev/net/c/ecf848eb934b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



