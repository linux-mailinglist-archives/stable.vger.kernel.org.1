Return-Path: <stable+bounces-164762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A0DB12392
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 20:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1B4F7A958E
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 18:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2018E28C841;
	Fri, 25 Jul 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ae1j0WVI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C690148CFC;
	Fri, 25 Jul 2025 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466994; cv=none; b=KAmH2j1hvhT2GCnldtW8ZNSYz8BvcwNF+OCqHxYXD5oW/DvTa3R0JB1vpkaeXLSoHwk1FF2ro3Cp4RoT8/i3GUKIpbRcQTzzQTqzaV9vH7Gt5lGqdbaOBTnGB89U/SL5RGD64r8o7Fw1/jDd+fJ+vjqap9XLe+H8VPoRX9YrOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466994; c=relaxed/simple;
	bh=e7MudpAWJXrkZdFlUYbvujQfAE+qsmi0EVFsY4KlHg4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d69btXixIesbK9ulplbCTcfv5cumOZ/GxYV3k6cI1XesqaCNi9QzbyM+WLvA/v1PIN6h8JT1CzwJNi5peJdZARiq6lS/zQKELJtdmBq6Wzal6WVuHTXzJsrYG5k/CSgW2j14zWEKAcMXNc83fdrdhJfyVXikUFMdB7BkYDCJMIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ae1j0WVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B85C4CEE7;
	Fri, 25 Jul 2025 18:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753466994;
	bh=e7MudpAWJXrkZdFlUYbvujQfAE+qsmi0EVFsY4KlHg4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ae1j0WVIBcWGkfS442HbUwHTXINxbpCTWYHcWKGaajK7DrW/WgS5NVo4obiSw+OjM
	 Szzk/b8EBjnGasYDuXbi+X6y+I5vQQ8dz9sGRGDxpD4Dr3YlRtyFH2Op1si+bnKDpC
	 8xGR321qawnbep0Y5A22VMJYObG0XrNMd4SDrjJSBRc0W+m3WNL4kvsonSNdenumUN
	 dTPKYvytSuHTJbrpwTipqhJmYhZoKBrGN/N2m/pQXS+caxEkSHLPq4pNvkm6z2Wn6W
	 YdQgACOvcD0/vkXKh64TROkAWFeeksG9va+uPuwifUNjrC3BFpjm9ydpmpCee1e7es
	 hG9uHQsC1HKHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DD8383BF5B;
	Fri, 25 Jul 2025 18:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: usbnet: Avoid potential RCU stall on
 LINK_CHANGE
 event
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175346701201.3223523.6273511358134710495.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 18:10:12 +0000
References: <20250723102526.1305339-1-john.ernberg@actia.se>
In-Reply-To: <20250723102526.1305339-1-john.ernberg@actia.se>
To: John Ernberg <john.ernberg@actia.se>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 10:25:35 +0000 you wrote:
> The Gemalto Cinterion PLS83-W modem (cdc_ether) is emitting confusing link
> up and down events when the WWAN interface is activated on the modem-side.
> 
> Interrupt URBs will in consecutive polls grab:
> * Link Connected
> * Link Disconnected
> * Link Connected
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usbnet: Avoid potential RCU stall on LINK_CHANGE event
    https://git.kernel.org/netdev/net/c/0d9cfc9b8cb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



