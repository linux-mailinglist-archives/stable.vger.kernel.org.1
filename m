Return-Path: <stable+bounces-7901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF868185F6
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B82D285434
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2AC15EA1;
	Tue, 19 Dec 2023 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+l5ilSD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B415E98;
	Tue, 19 Dec 2023 11:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8464C433C9;
	Tue, 19 Dec 2023 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702983623;
	bh=Ls1VSehIckeYRhZGqbGwjer6mvVnecVGtJljbb5X1uw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d+l5ilSDD7btiGPAGilXZb40KYaDOimnn1uzPDV0H8bp1hGK6Z8see3PqXNiCUM6Z
	 TWFt/koT3XmJK7Tv5ceS4EWuuMT91Ht3QIoQKM0EBI2lQhcLg9hwnUIZqNP/fkrxbw
	 xFta7xHfyqElbMBM16NxaQJVzI95C91ASv3ZvsDw8Aoctffbg6yaEiBQAKF/A923Wl
	 mqtqvtfWD3Dh4LBcOkCUpJ4wn5AaTapkmmgcIVXguZays+qKMqwjyElXJbIMYwCWoZ
	 hPHHJkOY4Wxk1TVG//lxHxFPU/N2YQTBrKJgzbShMyhKRekADZ/vEiB/y2XbU/Jz1w
	 kmbfBrOcE//4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0EA7C561EE;
	Tue, 19 Dec 2023 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ks8851: Fix TX stall caused by TX buffer overrun
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170298362378.20843.3373461129605286844.git-patchwork-notify@kernel.org>
Date: Tue, 19 Dec 2023 11:00:23 +0000
References: <20231214181112.76052-1-rwahl@gmx.de>
In-Reply-To: <20231214181112.76052-1-rwahl@gmx.de>
To: Ronald Wahl <rwahl@gmx.de>
Cc: ronald.wahl@raritan.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ben.dooks@codethink.co.uk,
 Tristram.Ha@microchip.com, netdev@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 14 Dec 2023 19:11:12 +0100 you wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> There is a bug in the ks8851 Ethernet driver that more data is written
> to the hardware TX buffer than actually available. This is caused by
> wrong accounting of the free TX buffer space.
> 
> The driver maintains a tx_space variable that represents the TX buffer
> space that is deemed to be free. The ks8851_start_xmit_spi() function
> adds an SKB to a queue if tx_space is large enough and reduces tx_space
> by the amount of buffer space it will later need in the TX buffer and
> then schedules a work item. If there is not enough space then the TX
> queue is stopped.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ks8851: Fix TX stall caused by TX buffer overrun
    https://git.kernel.org/netdev/net/c/3dc5d4454545

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



