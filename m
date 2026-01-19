Return-Path: <stable+bounces-210359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E45F7D3ABC0
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 15:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D822F305222A
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA22B37BE7E;
	Mon, 19 Jan 2026 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAWRLsJy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC660376BF8;
	Mon, 19 Jan 2026 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832517; cv=none; b=jyYv+km1AUkhtRnyxBfvoomuDGWBtOdOFzc3IkEnpgT9ylEjkrVofvh+kO/Sd+LN4KbK6NSyrOqV51BpA9ZU+gbzecrhbRQNCJ4YMgX52aHROoYVsk0UFelavsMz8VUcGAtGOeUjEUfUEBSbZRHvcUScC9sn6Rvhyj6ragGyNAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832517; c=relaxed/simple;
	bh=FH9KnIbVrl0I++bpaeo1vmsPfMYZGtHlD9sMgyrgfz0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gOl+jux3XH0A88K9ubGzvSgXH4Cem4mee5tTHfLD/6U9syc1Av2xOnJDJCqKJQdq8EPRkCN6fBCbYVLpa1BjtakvSbxTjrzIPVHjN+Qga4yx3cHeLKm2D9A+B+CO0r266tC6bp82HsZ9rRqcGGqMQoE8Z8gDTSdv0ROrj6jiP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAWRLsJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AD0C116C6;
	Mon, 19 Jan 2026 14:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832517;
	bh=FH9KnIbVrl0I++bpaeo1vmsPfMYZGtHlD9sMgyrgfz0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pAWRLsJytl/OxqhYA6PQiHkalSYlqkrC7BlXWz4EaY0nbPKDQ+zjKA1t9YrVUARMy
	 2oMB99pae2fhpxevefig3kqJqbI6IH6VAcimdsQ/PpZwUtAlnw75AIYYql2nKwnyeg
	 cuNoEFkEwyzTK3aZIBviAyn56nxBV29ujkkK0qqLdTC4o/x+6RPDfGb1zqG3xzPDUT
	 JCIaba57TNgrMTY7cXJMJSoo/skJaL3gZ7HnYkSKSe2kK5G2/BIk9mwVEWNXBq0Lca
	 YYBvPbhn1VNdjYJdz1QsynExNPATUZB1XmunMPBe+Cv7qLP4ZgzTckFnU4EtH8rXSV
	 vd/UPi/JRCv2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BA7B3A55FAF;
	Mon, 19 Jan 2026 14:18:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] octeontx2: Fix otx2_dma_map_page() error return code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883230702.1426077.16288100888364682482.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:18:27 +0000
References: <20260114123107.42387-2-fourier.thomas@gmail.com>
In-Reply-To: <20260114123107.42387-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jan 2026 13:31:06 +0100 you wrote:
> 0 is a valid DMA address [1] so using it as the error value can lead to
> errors.  The error value of dma_map_XXX() functions is DMA_MAPPING_ERROR
> which is ~0.  The callers of otx2_dma_map_page() use dma_mapping_error()
> to test the return value of otx2_dma_map_page(). This means that they
> would not detect an error in otx2_dma_map_page().
> 
> Make otx2_dma_map_page() return the raw value of dma_map_page_attrs().
> 
> [...]

Here is the summary with links:
  - octeontx2: Fix otx2_dma_map_page() error return code
    https://git.kernel.org/netdev/net/c/d998b0e5afff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



