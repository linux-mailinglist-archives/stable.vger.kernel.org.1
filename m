Return-Path: <stable+bounces-81340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 373EE9930C9
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24AD1F21F08
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2821D7E52;
	Mon,  7 Oct 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt9H1WNo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4881DA4C;
	Mon,  7 Oct 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313834; cv=none; b=DxoVlTdeVP1JASevKpDvArlH9aRRt66UtrRd/O4kpxY4f78lFqntUgIm3rHZ3x17jN+1NBo0SGvqeJN03Uf6pfWs3SAhIG93TBmxYhjiLAe/rMzvWkrncfs/owxjle0WDXwgYsVztqtrc7ArrAdgoSQEOni4EqEnPTGrxTdX2Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313834; c=relaxed/simple;
	bh=fhlVeKalzOR8D+/jtUoWMwTZZkvasnTCB/udMVFuV2s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fejBrjvc8HvP9t0XE4CxyTbJ9mkHVbUF9ojBBtQJaqeGFnIraNukixALE4JrYz7vIDsuRBaKm0lK9nM/ipogwKrdPFUcQC+JRtsl9svpmJT7TlSnwz8L9peNnDNOfkYw2ZaiKiIluU4CNZHTkX4whbbcCwNZXQdmRbznQ8rv4Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt9H1WNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5288C4CEC6;
	Mon,  7 Oct 2024 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728313833;
	bh=fhlVeKalzOR8D+/jtUoWMwTZZkvasnTCB/udMVFuV2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gt9H1WNoPJEORctZfSNBVGp/Ghx1X+fUsT32TC8rKHhU+bGibTzRZUby0+P3j3ZEH
	 XEuAYSTR85+xkRNOrJGpp4/PAvAq/GSMbgGxGgAi2SSu3IT/BAGCMxw0ifE0EIzYWx
	 pGocqNNaMNMM4k3paISpTl7Os75BafEqlRkQ8pe2PgTNQmhraImqvX329/plzhKrmg
	 dn3atTL0lywPOwZ8TfWKBJ/hHSxs1XGmtwKtx99Iu7ckrFeQQcz6YMHZiS81c8KH2p
	 3P591n1d2mcBmEpVZFFrN4EnTAc8nFH8sP6MhjfN9Q0D7ZlN4Lick9LYptfkw030WG
	 8Fjv9slzu6S2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C383803262;
	Mon,  7 Oct 2024 15:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Bluetooth: Fix a few module init/deinit bugs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172831383802.4060807.13860354969784625784.git-patchwork-notify@kernel.org>
Date: Mon, 07 Oct 2024 15:10:38 +0000
References: <20241004230410.299824-1-dev@aaront.org>
In-Reply-To: <20241004230410.299824-1-dev@aaront.org>
To: Aaron Thompson <dev@aaront.org>
Cc: johan.hedberg@gmail.com, luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Oct 2024 23:04:07 +0000 you wrote:
> Hi all,
> 
> These patches fix a few bugs in init and deinit for the bluetooth
> module. I ran into the first one when I started running a kernel with
> debugfs disabled on my laptop, and I ran into the next two when I was
> working on the fix for the first one.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: ISO: Fix multiple init when debugfs is disabled
    https://git.kernel.org/bluetooth/bluetooth-next/c/6259a9d4578d
  - [v2,2/3] Bluetooth: Call iso_exit() on module unload
    https://git.kernel.org/bluetooth/bluetooth-next/c/d18b99bb8795
  - [v2,3/3] Bluetooth: Remove debugfs directory on module init failure
    https://git.kernel.org/bluetooth/bluetooth-next/c/f5a04a514aa2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



