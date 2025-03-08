Return-Path: <stable+bounces-121529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0030A5781A
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 04:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2741897ACA
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 03:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA0A18BBB0;
	Sat,  8 Mar 2025 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqW+DPdf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19315687D;
	Sat,  8 Mar 2025 03:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405807; cv=none; b=EiddleOQyV0XifAFN7FGwjfpGRmxIi85ZwqJz3Fqw6x+uQXdzPShiVFDxzpRz81mY3hhzpK1guC3v0t7JY/4k8JEgzZmuUfGLsuD9GWmOBIRGVf13/iebv6gi361nrJuiMGz9F3iohpe/2XeYZiu63+d4QUqIyzn6I454rCFpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405807; c=relaxed/simple;
	bh=gMTHFRUzvjZvMCwhd15l/Ro9Q3gwPrcUmEHbWd5fiEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E4FpbXsUxgxbjg6byTIb4I/hxGKc8jwbkzwJ1BIjRFracNPoBYOgU3h8xsSvW9DpTW5n9BTpJqsLcpjLbJe5TVef99u7O5yMvB40JOU4rFKuL5or7CCIlEgB8zdBX6Q/zOqRzQN7Jo25HPZd9VeTxdh//KIPOGcuELaLRl+cosk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqW+DPdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67822C4CEE8;
	Sat,  8 Mar 2025 03:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405806;
	bh=gMTHFRUzvjZvMCwhd15l/Ro9Q3gwPrcUmEHbWd5fiEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eqW+DPdfvcU9nRph9O/Z+RsYfUjuIo6T5atEdAj5SCLJZ88pY7KDPTUa5vlUio6+F
	 1IeAhGF9Ryr0he8i62+xMPVn3P5w6079p5r38b4JSgyFD0hhd5zhOlF42WnVZ4YCwt
	 4+MoFXDEsNAeH+QtbhBIeNDN9tZjS4f3dn6CDh2e+W3OThA0qo210dOuNTaCJyM4yv
	 sC5aEDqYJIcs1pN3nJCX8VefDLVj3Tc7ePDNVzxDZNqfIAU/tpLPBk8bJ+QCOLGnmq
	 F9Jt6nVj6RMK15lDg6Tnmx4HE7dYjRK/OMbqq1yVSGLD2+Y3lM77+ainwN7veI3DXb
	 FvMqm4Caq+HEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341FA380CFFB;
	Sat,  8 Mar 2025 03:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] netmem: prevent TX of unreadable skbs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140583973.2568613.2231565890209246697.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:50:39 +0000
References: <20250306215520.1415465-1-almasrymina@google.com>
In-Reply-To: <20250306215520.1415465-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Mar 2025 21:55:20 +0000 you wrote:
> Currently on stable trees we have support for netmem/devmem RX but not
> TX. It is not safe to forward/redirect an RX unreadable netmem packet
> into the device's TX path, as the device may call dma-mapping APIs on
> dma addrs that should not be passed to it.
> 
> Fix this by preventing the xmit of unreadable skbs.
> 
> [...]

Here is the summary with links:
  - [net,v2] netmem: prevent TX of unreadable skbs
    https://git.kernel.org/netdev/net/c/f3600c867c99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



