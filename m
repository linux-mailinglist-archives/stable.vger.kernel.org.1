Return-Path: <stable+bounces-3706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122DF801E58
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 20:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E76B1C20852
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 19:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821DE21106;
	Sat,  2 Dec 2023 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OByKiWl8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC821F608;
	Sat,  2 Dec 2023 19:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0B97C433C9;
	Sat,  2 Dec 2023 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701545423;
	bh=7oFK4ed8T89dSsjywyHK5bLa86wuR3jqGdVIRyazGRM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OByKiWl8mrA9qDMq2PnkK3QXm7Zf0APYeujzi39JI+0XvTsnJUMUdZV05U3GHlpfM
	 8OLPuk0nNkacJ/0eeL9vJIwugxN5Fc0Y4e6Dn6peCyAsQMWtD2uy/9haQWTzUvFep5
	 6z21zwbdifl11u4Uf81TC6iQP9NpJyKjwv2mZTeMRRoh1JVtKZsc8Uk62T6KgzNPdX
	 xSFRgJLKbwBQkHFujUTi0jaVnyBsGYxTHpEzJjAoq96Ya7VA15L0qXSaqHfM+wRSWk
	 Pg6F8qPG/DLJaL64DXarnqxoDdYx2/NkDeqFfC/MAdgnopznJGjLC4vBviWdn73B4U
	 iiGA4fR1EJsuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FD73C59A4C;
	Sat,  2 Dec 2023 19:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] r8169: fix rtl8125b PAUSE frames blasting when
 suspended
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170154542352.15478.16376698686118479482.git-patchwork-notify@kernel.org>
Date: Sat, 02 Dec 2023 19:30:23 +0000
References: <20231129155350.5843-1-hau@realtek.com>
In-Reply-To: <20231129155350.5843-1-hau@realtek.com>
To: ChunHao Lin <hau@realtek.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@chromium.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Nov 2023 23:53:50 +0800 you wrote:
> When FIFO reaches near full state, device will issue pause frame.
> If pause slot is enabled(set to 1), in this time, device will issue
> pause frame only once. But if pause slot is disabled(set to 0), device
> will keep sending pause frames until FIFO reaches near empty state.
> 
> When pause slot is disabled, if there is no one to handle receive
> packets, device FIFO will reach near full state and keep sending
> pause frames. That will impact entire local area network.
> 
> [...]

Here is the summary with links:
  - [net,v2] r8169: fix rtl8125b PAUSE frames blasting when suspended
    https://git.kernel.org/netdev/net/c/4b0768b6556a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



