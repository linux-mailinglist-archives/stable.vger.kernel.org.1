Return-Path: <stable+bounces-197065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB62C8CBBB
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 04:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBEE3A65CD
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 03:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EEA2BEC4A;
	Thu, 27 Nov 2025 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCmig7Ea"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84C78F2B;
	Thu, 27 Nov 2025 03:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213428; cv=none; b=P88GgS/Vh2eYTrPHsP1/cOtnZuSCIWyFE/wdNo0wh1KU69X0ImsmPmi0bfQ7RomvWg1W92SPOMGnM04V7xygKBf0bPjgIUMBo7YzF/wlsUJb8hvkOK96HAkItscjoSgUJqo/DHM/IfVsDVW2J8/M1BB/lDkHWoZaJuyfIj0vkrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213428; c=relaxed/simple;
	bh=s17mR4r4qZwjWaiHV5WnK9DtqfvkogbVNr3QbFEhK+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JByGk3RWmojRl6J6ZTxEXYL+pLAURgaxTfagrvv/Uc+EhmtI6gg0SHWW5rorUHrvN8Do4o3Id+FzKPHBdnSBJearaDhcqQduP3EKWGRzLtA62S/sJS5KhACfuWWeasGGB6SKPpi96BC3P/j+++C+zcV8WBsIdVfkLt2t6Kw3RMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCmig7Ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E066C4CEF8;
	Thu, 27 Nov 2025 03:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764213427;
	bh=s17mR4r4qZwjWaiHV5WnK9DtqfvkogbVNr3QbFEhK+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vCmig7EaOdWAh4gF/5/TxdGaXd047jktibg4z8Ovhs8whIbekVCx5Pewu3taHOfKx
	 k+SoUftWI6kH65TArL6DUq3qD3G9Bb2ItA/vgQK0hF3S9WyFXw5Ql2wwnQ4dfrHmv5
	 S4Grabs+EuQYMbM3MYls1cukTEPH4m2vjfnkE5ViSNUkBeNP46V2mxy80crv9M6L8v
	 bsBbT/fOQXpDb6hnAD+4fTE+3VtyO1vqttTm4fChS43us0yBDOBcWGEC3j+O/Iz9AQ
	 Iv2GtZJ0aS+CZjyYSGZcDN90mqzPB6WtmwfrSc1YruJf8uXFl2j5ryeV6fdSuhCEag
	 EfKSUdcYyuEZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BB3380CEF8;
	Thu, 27 Nov 2025 03:16:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: clear scheduled subflows on retransmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176421338900.1916399.4900950573228892148.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 03:16:29 +0000
References: <20251125-net-mptcp-clear-sched-rtx-v1-1-1cea4ad2165f@kernel.org>
In-Reply-To: <20251125-net-mptcp-clear-sched-rtx-v1-1-1cea4ad2165f@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, fpokryvk@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Nov 2025 17:59:11 +0100 you wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> When __mptcp_retrans() kicks-in, it schedules one or more subflows for
> retransmission, but such subflows could be actually left alone if there
> is no more data to retransmit and/or in case of concurrent fallback.
> 
> Scheduled subflows could be processed much later in time, i.e. when new
> data will be transmitted, leading to bad subflow selection.
> 
> [...]

Here is the summary with links:
  - [net] mptcp: clear scheduled subflows on retransmit
    https://git.kernel.org/netdev/net/c/27fd02860164

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



