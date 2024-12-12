Return-Path: <stable+bounces-101399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA009EEC04
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4604283C8E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E7A2210D4;
	Thu, 12 Dec 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUhKd6vX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB5D22069F;
	Thu, 12 Dec 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017418; cv=none; b=Qg+qPaV47lT5/hTUR/h4U8pLN4oBiIi5InUiC2KK8+V8iMAZpjcTboCQJmmTculu3r0ZCvAXphn7elUHNwAKAg3yoLh/sCdnqrKIbK167kLOiviji1MgAhYFptl02iHFI0Q3zxj5hZxTx64K0OumxhW0DFg2Rsf+YWOp0TC2Jhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017418; c=relaxed/simple;
	bh=fRo28MlPeN080sVHAgv+Xk8U7MBZ4lUVusodbTjE80w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lB64S+Y6ry4X9WZn1Vi6jtxcYlJTaeSEeQo8p3iFn2pgL/kvxG99TqKTnlQXLif3IuOPb+/00LjYThHJhi0oJ4bRvHQB7Y4OaMgsGPgtvUCL+oWg0ftjTPLvuxMFlmHUKiiDyS71H6NOuFv9WB29VmKt9DMafDBEt2VbUJ/m2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUhKd6vX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD27C4CECE;
	Thu, 12 Dec 2024 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734017418;
	bh=fRo28MlPeN080sVHAgv+Xk8U7MBZ4lUVusodbTjE80w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nUhKd6vXhTRRV1mEAaYPgbgz+fTSDQUcQiQT0Ixvc4mZjTU03sfQP5plE4CQoPaM9
	 3DgkydEoABMF7ysVVL5z6FsRMZ/rA0r/AIIoiiagVsjAXhTm7PUCOodlX1cNsqBXII
	 eMg9szOtARBdR2jIyIhOUJUC0pasYNdMA5gcLeecGI6BPm7FLlTHjHH0NEcPXNfanE
	 S9JcHy1UhViTVZ9WH1ODtbwNS/7URtcJ+fTNf/N4BrbKTCpvP+aGRD/3Bgl6vLfNM2
	 F8G2l2P9AWM1D2IzX7Raam+7j8WL6n9utly3MKQriAuyBCrUNpkfjS40Ta/tX3WokK
	 ppRIpCXECVxDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE943380A959;
	Thu, 12 Dec 2024 15:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: tag_ocelot_8021q: fix broken reception
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173401743449.2337313.7538670718873866823.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 15:30:34 +0000
References: <20241211144741.1415758-1-robert.hodaszi@digi.com>
In-Reply-To: <20241211144741.1415758-1-robert.hodaszi@digi.com>
To: Robert Hodaszi <robert.hodaszi@digi.com>
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Dec 2024 15:47:41 +0100 you wrote:
> The blamed commit changed the dsa_8021q_rcv() calling convention to
> accept pre-populated source_port and switch_id arguments. If those are
> not available, as in the case of tag_ocelot_8021q, the arguments must be
> pre-initialized with -1.
> 
> Due to the bug of passing uninitialized arguments in tag_ocelot_8021q,
> dsa_8021q_rcv() does not detect that it needs to populate the
> source_port and switch_id, and this makes dsa_conduit_find_user() fail,
> which leads to packet loss on reception.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: tag_ocelot_8021q: fix broken reception
    https://git.kernel.org/netdev/net/c/36ff681d2283

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



