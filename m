Return-Path: <stable+bounces-78350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872DF98B7FD
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37DF81F22603
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E7119D090;
	Tue,  1 Oct 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbVok7yv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CCD19CCFC;
	Tue,  1 Oct 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773829; cv=none; b=exy5oNXXS0Z7BxAlbwaDt3OY4106ftXYgOXXRnO1EIV6kxm7qsfkUeP8MtGCI8awBPuFmzsSQSRKVuioOncZLpGmHI7Yyp+rHCaSVsHyaWtAAiWTkATbYVAnUp79KCzm0NzEGEWb891nrlP6E45QTac8Ywb5QGsA7/YbW9K+z4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773829; c=relaxed/simple;
	bh=MzP12znI3bSxnA8GdzICBeU+vZAFSci//8pQ18YeXRA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YbcwHM3uNzURfzpsi+HaoJTARFokkEsU8ZsswNxsszxeaEy/5BJ28bGckcYO9fzxK0psWmNQOo/Z94DHmoE7kGUEHiZrQQKPTXKObvfb7ds77gkEC97HpPFYumXVjoAfqFFf20mBdbpOAf8XAe68g3pW5r5XD2HBZb6ZRtzWWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbVok7yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320A0C4AF0B;
	Tue,  1 Oct 2024 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727773829;
	bh=MzP12znI3bSxnA8GdzICBeU+vZAFSci//8pQ18YeXRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cbVok7yvMsvkTtoXShSrs8yXqIcnfWM/WH/u92E2qRXeUgAWk+U5EKl5l2Opnhp2P
	 ufI7popuHNVQHQMb2Aczn2FOGa02OxtsTz7oUOTF89yI2QLRs/07KXucQlV0GEXcv9
	 hJjZ9ZtISlTtd/rn8RKGzu2Lnmy0Ih0NJDTRToVW5eZt69iXP3z8dTlpsQQDUuweaU
	 lFCSyjeUA2bsR6DkWN5JmKZDqvExiKfeQlhGGamrsiCjPMgtUZ9u0SWA4uQRuhQIZy
	 4YDIEa5t3uCHidXQbe/Ck1PiyqXiO2/kWtExQzytCS+Hp8fQufMEkJ/jBuvejAt9qL
	 ZxnMWnXlfVy1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713843822D5E;
	Tue,  1 Oct 2024 09:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pcs: xpcs: fix the wrong register that was written
 back
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172777383226.276088.13877040440597447293.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 09:10:32 +0000
References: <20240924022857.865422-1-jiawenwu@trustnetic.com>
In-Reply-To: <20240924022857.865422-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, mengyuanlou@net-swift.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 24 Sep 2024 10:28:57 +0800 you wrote:
> The value is read from the register TXGBE_RX_GEN_CTL3, and it should be
> written back to TXGBE_RX_GEN_CTL3 when it changes some fields.
> 
> Cc: stable@vger.kernel.org
> Fixes: f629acc6f210 ("net: pcs: xpcs: support to switch mode for Wangxun NICs")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [net] net: pcs: xpcs: fix the wrong register that was written back
    https://git.kernel.org/netdev/net/c/93ef6ee5c20e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



