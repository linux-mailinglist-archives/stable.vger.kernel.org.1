Return-Path: <stable+bounces-106010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CD39FB432
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 19:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160161885AA1
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD221C549E;
	Mon, 23 Dec 2024 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6hg/C1r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AEC1BBBDC;
	Mon, 23 Dec 2024 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979813; cv=none; b=XafqVw6gsml3tXiiz75WgekF0pL3jRIXveVYu19ymP5Q0ZflfekmLA5DtEfkIWePVuHh0enla9ZP3mcRMo53B4iJUS0yMOWEkCTz4+iCQDKGT0XTz9BCsOksroBNZwdhJ8Wrb8Cbp1gAU6nQtaKD9HK5Y9JZ6U6Vqs/iO2xASzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979813; c=relaxed/simple;
	bh=NH8cm01y4TohlhDTWom0A4FVC6Z/AeDlJSvGBZtizHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GJRcvPRa16CQDyxAyNmKNcMwSiUBIsp9EHvDZZN00vde7/9nX+2BPl5dCeF+bQX1rImX6wtpWsMoLiHLz0H6XZp5hWgEXSiMeWevTblTKRpQq4pauUg/Nx2ReX1gJyKFpri70gfWr+mQ5Lsj3vRCPvKpk9LRi1mZj4lfFw/ZPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6hg/C1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835EBC4CED3;
	Mon, 23 Dec 2024 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734979812;
	bh=NH8cm01y4TohlhDTWom0A4FVC6Z/AeDlJSvGBZtizHU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O6hg/C1rQmNnnOdlQxObtBNox0FSgSDz/mczHP0yGc91C/yAFHIovtQMcMVGMKjbN
	 sCOkuPfzp6+Hr3DSKNQEvI9hpC8mp2mcQ7BOCdv+uHRkO70a2S+iQwoFeQ8obnwv9S
	 9ku0ATubmIMEussYDgadNHGOi735WT9sHqLLouMhlxzMtnSig/IvA2YEmK1mR7BYXC
	 aunRSgznwyKdMr7oF0uZBlIYr3APU8zgd5s5SIghPzAeO/sl07y6tlEKfirzOzw0wV
	 ycvCC/s+AOs+huoUBVYy7g32uDzofx5ZKjIwc9B9CJ0nfpBY8Otc8pm4OAN4ipPxi7
	 5+RvO/z1w9Egg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C973805DB2;
	Mon, 23 Dec 2024 18:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: default to round-robin for
 host port receive
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497983102.3929264.4619401793020862332.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:50:31 +0000
References: <20241220075618.228202-1-s-vadapalli@ti.com>
In-Reply-To: <20241220075618.228202-1-s-vadapalli@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rogerq@kernel.org, horms@kernel.org,
 dan.carpenter@linaro.org, c-vankar@ti.com, jpanis@baylibre.com,
 npitre@baylibre.com, stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 vigneshr@ti.com, srk@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Dec 2024 13:26:14 +0530 you wrote:
> The Host Port (i.e. CPU facing port) of CPSW receives traffic from Linux
> via TX DMA Channels which are Hardware Queues consisting of traffic
> categorized according to their priority. The Host Port is configured to
> dequeue traffic from these Hardware Queues on the basis of priority i.e.
> as long as traffic exists on a Hardware Queue of a higher priority, the
> traffic on Hardware Queues of lower priority isn't dequeued. An alternate
> operation is also supported wherein traffic can be dequeued by the Host
> Port in a Round-Robin manner.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: ti: am65-cpsw: default to round-robin for host port receive
    https://git.kernel.org/netdev/net/c/4a4d38ace1fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



