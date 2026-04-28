Return-Path: <stable+bounces-241627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IhbGCyj8GlAWgEAu9opvQ
	(envelope-from <stable+bounces-241627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:08:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F8484946
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11ED530BF3B3
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197CE3FCB18;
	Tue, 28 Apr 2026 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKk5tgQc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE4F3F1655;
	Tue, 28 Apr 2026 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373448; cv=none; b=s75wBaf4gKQ0SlTwq/hsxtShuiyJCupst/X8iqHDLYT6Z+P1cl+UnnYGOOBSgthVIPfhnJnhnePFnfi03fkgcjdH/1WqdRg6iXvjY5uGnCblqpHQ5igWTFnkUvwKIREY9vtSqqsNCT+vBLrhgRGyNJLKcuVE9KIIrz5+3BlSVi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373448; c=relaxed/simple;
	bh=0cuZ4nY0AbQu+qq/AL+Yse47A4Z10Pa0BfVJC9kTurM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dDU/Ld/VehMDsbWKn0jFAz4Le8fxgCfADRtZn0mYPYyd7XDfOEaYn9cbeP+js2jpqA8Zw2VmO3/ownRvHcE1BiztQpP5C2pW+sbOo4aOOsoXoMVSe4uIFfMfxjNcxrHVeQ92EltFavjOBJRj3K16PwTrOec4xlYN2EZ/KGacu2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKk5tgQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B326C2BCAF;
	Tue, 28 Apr 2026 10:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777373448;
	bh=0cuZ4nY0AbQu+qq/AL+Yse47A4Z10Pa0BfVJC9kTurM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DKk5tgQcak2+Ipn1aFgnj+gK7y+qMU+mqZLdurDKXospQQm0b5lWg5kEVOCh0yFrS
	 wnHyeh3o/G4zbZ2Nmg45NX7CL1ZMKo/9AEjeF14WvsAS6XF6+NWqYqSq2D9BPpzIT0
	 Bn0yalC9+9y0a1Zqiupd590wdA0HMUTwaGAGTXthW9ErGIR1yRv/5MOJWu138jEVo2
	 5wLR5pPWwDPM6ZOHgaWY1jaG4Aizuyxpe5Q9lJJWn7qWb7vaKDaWPqlMSs6bEkKFAF
	 /YP4yhNGwwXwSqCcdRQnu4RvU/SWFHSUq9qEXPaz79u6//BKT7qcbDAb6Uilyre+ke
	 aKW+ZiL5MMiLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD903930196;
	Tue, 28 Apr 2026 10:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] net: stmmac: Prevent NULL deref when RX memory
 exhausted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177737340530.407008.57733216818450708.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 10:50:05 +0000
References: <20260422044503.5349-1-CFSworks@gmail.com>
In-Reply-To: <20260422044503.5349-1-CFSworks@gmail.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, ovidiu.panait.rb@renesas.com,
 vladimir.oltean@nxp.com, baruch@tkos.co.il, fancer.lancer@gmail.com,
 peppe.cavallaro@st.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 CFSworks@gmail.com, stable@vger.kernel.org, linux@armlinux.org.uk
X-Rspamd-Queue-Id: 584F8484946
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241627-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 Apr 2026 21:45:03 -0700 you wrote:
> The CPU receives frames from the MAC through conventional DMA: the CPU
> allocates buffers for the MAC, then the MAC fills them and returns
> ownership to the CPU. For each hardware RX queue, the CPU and MAC
> coordinate through a shared ring array of DMA descriptors: one
> descriptor per DMA buffer. Each descriptor includes the buffer's
> physical address and a status flag ("OWN") indicating which side owns
> the buffer: OWN=0 for CPU, OWN=1 for MAC. The CPU is only allowed to set
> the flag and the MAC is only allowed to clear it, and both must move
> through the ring in sequence: thus the ring is used for both
> "submissions" and "completions."
> 
> [...]

Here is the summary with links:
  - [net,v6] net: stmmac: Prevent NULL deref when RX memory exhausted
    https://git.kernel.org/netdev/net/c/0bb05e6adfa9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



