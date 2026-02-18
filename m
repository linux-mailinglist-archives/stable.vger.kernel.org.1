Return-Path: <stable+bounces-217203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAyMBGAWlWkELAIAu9opvQ
	(envelope-from <stable+bounces-217203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 02:31:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D2B152893
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 02:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03104304EABB
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 01:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303EE2DE6FC;
	Wed, 18 Feb 2026 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzdfUK+R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF12DC352;
	Wed, 18 Feb 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771378216; cv=none; b=uwpwDSvG0qb6HzDsTmzAfpjJuCxnXW2QVAubLeETrkg2CWHaGUMZVO/xDjC0ZOpawV98x6ejvauRM+OBQU+aIlC6O4J5uA3SmBTSFOaabk/7jh94snjpbKFCi6OX2PE7rkL3yAabUxbZaxhQQHDV/u0pSM1V8mRHkCeATALlNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771378216; c=relaxed/simple;
	bh=IrIT7XGf/L8NQo867kl4btMQvfxnNdGTOrt3hsd6FuA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SLMD5df5V48r/PUvICy6h7mzFmsrUKdl8TiQkVtcwdZMe93hST5mbtmzASKKXSiudLZWl+XLEViwKJUZEhp5WdPRbQgAprKVj9cGuqcW1ggPoIthut/OzYyBEXFVxTmWWjeSu4v4p0czyeP/UCuobYKv5a3lsGqHqwRPlX9xOEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzdfUK+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F49C4CEF7;
	Wed, 18 Feb 2026 01:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771378215;
	bh=IrIT7XGf/L8NQo867kl4btMQvfxnNdGTOrt3hsd6FuA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QzdfUK+R0NkY3M5sktn+qmJJ0ZQjAs137g8T2332DCT9wnf/9KHZ87yYtxfkhLFht
	 usxXCi5It4vagFE6EUM1BSVYQ3c8bBDSsPkRR25aJRcNwHSHkdejVUUqzUUl2IY5Jc
	 tKMDPwE3R1zsnclJ/nEmjHMkEa3yZXvEU0c0YV0G6ycEk7gpFWkbyYAU6XUoQmm/ws
	 b8Sp28NnmuJYIdjFVoLl9XzhKtZo/NOkRGW/UBdkHVkSbhwKnaNu+dY2QJRFj9mVIu
	 Qec2143ZYw11bR2BF0lK/9cZCv3hO4tI6v2DhuqWIo4+mWOnzj7J1Vsqox3Hw3Qswy
	 NzaIRQby/1AZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C24183806667;
	Wed, 18 Feb 2026 01:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: ec_bhf: Fix dma_free_coherent() dma
 handle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137820757.768688.9508706442919619950.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:30:07 +0000
References: <20260213164340.77272-2-fourier.thomas@gmail.com>
In-Reply-To: <20260213164340.77272-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, reksio@newterm.pl, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217203-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62D2B152893
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Feb 2026 17:43:39 +0100 you wrote:
> dma_free_coherent() in error path takes priv->rx_buf.alloc_len as
> the dma handle. This would lead to improper unmapping of the buffer.
> 
> Change the dma handle to priv->rx_buf.alloc_phys.
> 
> Fixes: 6af55ff52b02 ("Driver for Beckhoff CX5020 EtherCAT master module.")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: ec_bhf: Fix dma_free_coherent() dma handle
    https://git.kernel.org/netdev/net/c/ffe68c376699

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



