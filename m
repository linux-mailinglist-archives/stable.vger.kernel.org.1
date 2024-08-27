Return-Path: <stable+bounces-70323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB6960919
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 13:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014AF284B87
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 11:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A24C1A257B;
	Tue, 27 Aug 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/OzQzuS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546BA1A2560;
	Tue, 27 Aug 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758826; cv=none; b=KDeN57qGGP3psz2yAzlLGFVcefdajxWvQ9khtWrwBpM0aUty09HegoeQ1d+jedwSMlJg4NGp6f3nWu7TLex/1gr8r0OHWSIjTJtYmjHEvWldrfRqbFS1OYGMrI+2GLzxvIbuEPA5E1DJzcMV76uk2PILyjB9z20pOhdS8vbhWs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758826; c=relaxed/simple;
	bh=6nJGWzUE9kL2NeprMRLvGCHTLQJLeWmcrtpMJ0+KUY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iuY2DM9Lnw5Bo3y/fWXmeczg0pnENz5ZxnEE4JkoiJf/lgDXup4VrZRfV6fVP1prkV5WCKicslXAmsd7GjN//TmZSlLFB3D0g9VmRBHUnYFezyWh2Xc1khhPK10wa89cHZL/XYax953X3N/RkvjMca6OByqJP2MuBacFUijsepU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/OzQzuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B021C519AB;
	Tue, 27 Aug 2024 11:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724758826;
	bh=6nJGWzUE9kL2NeprMRLvGCHTLQJLeWmcrtpMJ0+KUY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D/OzQzuSZVq0JRk2Z1Fr7wuxBAe6x8IL6H1O6HcMf/iR2uSKzXabsbu6sChY8Zyxz
	 fktlxybQb44ipkHZ2vJ4ueGILfa9SQ5/xpo/NMJVmsMwhOGjOlk/RAd4sMgN4OlayB
	 ORaKzCqf6WGcJJcx1Tvgo24XER6DEskaV1gxZFcLWNpLc1Hjb1l4uuvq7nnVf3nzPs
	 n+uUJgOCJR2WoJR+mtko+MNHiLk+7fyRb1b7Bg6De0U0WvsbI5dBUUbPGaZRC8gRL1
	 vrNIF7UfoVDVqI+3rD7Bgkb3ImSxHHJKdCGoyOP7Uq27JG2Hb2+GOjm0VnCuPOgCmS
	 6e1p8pWviU0ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B693822D6D;
	Tue, 27 Aug 2024 11:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ionic: Prevent tx_timeout due to frequent doorbell
 ringing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172475882625.601283.14612160158137881410.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 11:40:26 +0000
References: <20240822192557.9089-1-brett.creeley@amd.com>
In-Reply-To: <20240822192557.9089-1-brett.creeley@amd.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, shannon.nelson@amd.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 22 Aug 2024 12:25:57 -0700 you wrote:
> With recent work to the doorbell workaround code a small hole was
> introduced that could cause a tx_timeout. This happens if the rx
> dbell_deadline goes beyond the netdev watchdog timeout set by the driver
> (i.e. 2 seconds). Fix this by changing the netdev watchdog timeout to 5
> seconds and reduce the max rx dbell_deadline to 4 seconds.
> 
> The test that can reproduce the issue being fixed is a multi-queue send
> test via pktgen with the "burst" setting to 1. This causes the queue's
> doorbell to be rung on every packet sent to the driver, which may result
> in the device missing doorbells due to the high doorbell rate.
> 
> [...]

Here is the summary with links:
  - [net,v2] ionic: Prevent tx_timeout due to frequent doorbell ringing
    https://git.kernel.org/netdev/net/c/4786fe29f5a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



