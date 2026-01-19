Return-Path: <stable+bounces-210360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B65D3ABA4
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 15:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9BC0300A51B
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97223369992;
	Mon, 19 Jan 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZ2MzjCu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CDF37BE89;
	Mon, 19 Jan 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832523; cv=none; b=C40q6Q3zBbP8XcLEUrkZM0MB6U2ndLFGcpMOLQy7gtrC2dCNNTPa87wbQzGU39EgO92w6emR1ngom4be5BumWZhT0sUjoQC1If+oFYxtBzimePCLEWoC4NXXymOk6Wxrglj2FmtNFYMi5Ap0xQzK1N1PqGVZp+DXX2q2qK5XsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832523; c=relaxed/simple;
	bh=v84Fmgfr9ZjO0NXwZELgKfGSd+gRigtD62zD7+M1a8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uk5fMhvCzrsTUzE4GOmDfv7/JCsWrsb/pCmcOvdfW1LVKUef6fVJf+X3lVNT+hUtQg7RazITEu2bYVdBtS80zcyQqtvurmJeW2/M9PN9nWcElU37BrvYLawzh9KxNb3iKIgwOascMxj1PmO2jqWRsmIZd4a3reRRsrRBiab/nlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ2MzjCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B63C2BC87;
	Mon, 19 Jan 2026 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832523;
	bh=v84Fmgfr9ZjO0NXwZELgKfGSd+gRigtD62zD7+M1a8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TZ2MzjCuNI7Qzkwz3fRWr0AAStu9uKyLxBKh3GOiFV60PKZNFT/x19ZXmqjHccAhn
	 5aVWqRZbjb9G/OAhTy8v4v6ZIF2vIyZt2r8GRcreq0QecrJuX209NvKy7WpAhOeE1P
	 VSuprsx8GMS0Bu+DoRVmMSYZOtsmuIK1fPzmoREvEESL5iB2XBiNQ5Imm26LeOPHO0
	 HdR58nYrO94QkHSQZ4BcCinQQp1e2VgturmZtIUpjKBEtw3fhccQH39FqrZUWSJ8G2
	 ZZIIPNe+ds39/sstvMbqR5mG7xhJt1ZkCXhrzopfQ5b4fhkDRR4huMRvyC/MjIKQ7i
	 L4oINlht85nWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A373A55FAF;
	Mon, 19 Jan 2026 14:18:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sfp: add potron quirk to the H-COM SPP425H-GAB4 SFP+
 Stick
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883231252.1426077.3950303966169051883.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:18:32 +0000
References: <20260113232957.609642-1-someguy@effective-light.com>
In-Reply-To: <20260113232957.609642-1-someguy@effective-light.com>
To: Hamza Mahfooz <someguy@effective-light.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, linux@armlinux.org.uk,
 andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 18:29:57 -0500 you wrote:
> This is another one of those XGSPON ONU sticks that's using the
> X-ONU-SFPP internally, thus it also requires the potron quirk to avoid tx
> faults. So, add an entry for it in sfp_quirks[].
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> 
> [...]

Here is the summary with links:
  - net: sfp: add potron quirk to the H-COM SPP425H-GAB4 SFP+ Stick
    https://git.kernel.org/netdev/net/c/a92a6c50e35b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



