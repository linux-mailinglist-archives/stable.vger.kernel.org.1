Return-Path: <stable+bounces-11830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EB183034D
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 11:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 545BEB217DF
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6522F14292;
	Wed, 17 Jan 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs849v/x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB6914270;
	Wed, 17 Jan 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705486225; cv=none; b=RS8kMib8CYyFKAcwTvyAjEzDSOVc5+6PYHw6V4RZ8fSbXj1ROiwPiyKG2XDTPip5GSZPLglrCYa8HTuakFXA9L9w9ogU+usLfPsVn6egNO8wEQddiw9gPK7uKNuq3eyp5ppdQtMQEKKWqZ31zfBvVHsKUjGujMkQ9Qex9evsKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705486225; c=relaxed/simple;
	bh=ltH2gx/NkmeSjFHTVwnNNG4AcsxsBQsX+VOOFImuNsE=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d0Dt0Pd3zki5LCobu5L5Wq/sz6Pz/98H3AGBXU1qcR3H9DELuKPEOqmr2FCjzCLMnuUSfmlW8GzVBDKntAK+6WAkOux3wO8dVWSZkUQ3eCWWR9tlQHh+NVwK9hsv8YxLGPevccGglSk24K4z61MN0lNVwdlCNHP/1RgfND1pWys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs849v/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FF6CC43390;
	Wed, 17 Jan 2024 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705486224;
	bh=ltH2gx/NkmeSjFHTVwnNNG4AcsxsBQsX+VOOFImuNsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gs849v/xnktV+VT6AsLGVXoOWnaF2qjI5b7TxxlXAgEHz8EaiymWV63JIZgG00veL
	 Or3IQejwT0l5fRVloJ6WcfCDwSTHHpbILxvnJtXsVxKPZVkFXGl5w5azujol/rWwr1
	 GZ6SSB3IAPRl5rEyGNE48bd3q6/e86quWKvVH1WBuMZefts88BC3N+I1B8x+xPjow2
	 7xLN4Tp2BLj1zm2kQulWhyyrxZ7U5yzonjbi1Jy5cmGvwTFQrcQahXhBaCv1n25M8n
	 Dta3p4yEKWLEwahuoPnIpoAtQqMUIdbImY+WxULLx/Mr7rz3yOeyezCuUPlPhMyAG+
	 0PmHINHf3DJrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8722BD8C971;
	Wed, 17 Jan 2024 10:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] net: stmmac: Prevent DSA tags from breaking COE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170548622454.19813.11293177026584189048.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jan 2024 10:10:24 +0000
References: <20240116-prevent_dsa_tags-v6-1-ec44ed59744b@bootlin.com>
In-Reply-To: <20240116-prevent_dsa_tags-v6-1-ec44ed59744b@bootlin.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, miquel.raynal@bootlin.com,
 maxime.chevallier@bootlin.com, sylvain.girard@se.com, pascal.eberhard@se.com,
 rtresidd@electromag.com.au, linus.walleij@linaro.org, olteanv@gmail.com,
 andrew@lunn.ch, thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 16 Jan 2024 13:19:17 +0100 you wrote:
> Some DSA tagging protocols change the EtherType field in the MAC header
> e.g.  DSA_TAG_PROTO_(DSA/EDSA/BRCM/MTK/RTL4C_A/SJA1105). On TX these tagged
> frames are ignored by the checksum offload engine and IP header checker of
> some stmmac cores.
> 
> On RX, the stmmac driver wrongly assumes that checksums have been computed
> for these tagged packets, and sets CHECKSUM_UNNECESSARY.
> 
> [...]

Here is the summary with links:
  - [net,v6] net: stmmac: Prevent DSA tags from breaking COE
    https://git.kernel.org/netdev/net/c/c2945c435c99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



