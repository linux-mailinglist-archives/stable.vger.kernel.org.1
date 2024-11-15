Return-Path: <stable+bounces-93614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBEC9CFB45
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 00:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F64B251E8
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 23:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA5619645C;
	Fri, 15 Nov 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVy3nEcM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6818DF8D;
	Fri, 15 Nov 2024 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731714020; cv=none; b=gA04JZDQIiqdw0s6cw/TRdcUf9SFjEDxOYLMs5F5GVFA9ckJXVhDawNsvjxC2IKqXL2Nl4I5TqFd0NvKqffwIVNjetO0mPEmNeb353EhHfrlcxOIFtS4h+hMdPkriqDot7SHi5Td9PYtqbyL3xxrh1MsuFntoUP2bu387eoRE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731714020; c=relaxed/simple;
	bh=+1oE7bt04gcniALNaCS35HwWjesqhn26LK/iHoUcAPg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q2MzNjtuS6Rg0KUijL8fZGICUvrQZSL1WaaVnRL0yeSw5EDnBxGnDLZ9P7FIKiBGVHzALAOxieZI088/BXTrtDk8sKl0WV3NlT9POSpI4NFQhoFsexsncDOM+fAgdoiN2wmIOMLzT4VerAbvSbFE5hyqjD6BEanHZjAMyAKAYQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVy3nEcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F714C4CECF;
	Fri, 15 Nov 2024 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731714018;
	bh=+1oE7bt04gcniALNaCS35HwWjesqhn26LK/iHoUcAPg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TVy3nEcMJAR4Nreys9S5RTmHJX7hBc1GlXUSJ0kNt/lPu9OdIGFAABGr6I3XevUuw
	 /gN8ALBTcr7e7ZZ4zlcGM4pCReicy6hK92C2/a6yDnvAmN4p7HCwlnzvWQ/aIpDUZN
	 yIJw4Bqa0HVlZ2PxnHQUn5xaQb1IIvsBox2GAI+QPzOTFzRLTvF/AWmRbz9FRdIMY5
	 PMMcjXWeruTt/JvlZjmjTiVUOi/DmZHHrz8oboy74Qh73ZmWVls3PWSpeXAx4qriNd
	 kQbHjEMyEf2E5OE3mglQWi7tzrnv8U180IjqHpSE21wDX82Gv4xAjHG8PEDjegWFVZ
	 BJKkoMPsp8ntQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B913809A80;
	Fri, 15 Nov 2024 23:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2] gve: Flow steering trigger reset only for timeout
 error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173171402900.2770408.15282693426483623858.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 23:40:29 +0000
References: <20241113175930.2585680-1-jeroendb@google.com>
In-Reply-To: <20241113175930.2585680-1-jeroendb@google.com>
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, stable@vger.kernel.org, pabeni@redhat.com,
 pkaligineedi@google.com, shailend@google.com, andrew+netdev@lunn.ch,
 willemb@google.com, hramamurthy@google.com, ziweixiao@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Nov 2024 09:59:30 -0800 you wrote:
> From: Ziwei Xiao <ziweixiao@google.com>
> 
> When configuring flow steering rules, the driver is currently going
> through a reset for all errors from the device. Instead, the driver
> should only reset when there's a timeout error from the device.
> 
> Fixes: 57718b60df9b ("gve: Add flow steering adminq commands")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> 
> [...]

Here is the summary with links:
  - [net,V2] gve: Flow steering trigger reset only for timeout error
    https://git.kernel.org/netdev/net/c/8ffade77b633

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



