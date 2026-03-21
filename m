Return-Path: <stable+bounces-227645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNBuLa/0vWlQEQMAu9opvQ
	(envelope-from <stable+bounces-227645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 02:30:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7A72E2C95
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 02:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48156302003A
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 01:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966082EC08C;
	Sat, 21 Mar 2026 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6m1S1kA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58276258EC2;
	Sat, 21 Mar 2026 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774056618; cv=none; b=aHal9EAzOcPtXTl7K1PS8UaXoVXXk7jxL0sWIYbV/B0qeYiuREzKxOhgr4sl8hCjVgA7rpq1E1zph1ajbkx20peRKtvyud9mQGVT+Ze+7M/OgSrHZk26CS+PAgoEPjAsJ/Wcc6kfPWrdzGFhwAdGcveDMP/VODCwxqChqI9xwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774056618; c=relaxed/simple;
	bh=tbbADfwDugUUyAle0siqsujkIcegPl5hAPJQz8FE9dw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ut0UuP1kzP1HassyBpsfdQ59B94ENyNNHtG85dUQRYlD9fgNRnDki3D1F/iysUw6rY1yYMxZJCbKsRncJNhOvwBHRWle6mvVCoeiyPMGxYy40XocXCd72V4Ymlw9+m8HKeRuiTu5x3ifX03+I/wxT7wIj7V0wyLPauvFAkVtPFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6m1S1kA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D49C4CEF7;
	Sat, 21 Mar 2026 01:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774056618;
	bh=tbbADfwDugUUyAle0siqsujkIcegPl5hAPJQz8FE9dw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T6m1S1kA61Ndi9veXqUrSqU0sCNUjKsZ6CHEByqEPULAMq5WkKJ6bvspbzxqd5Gs/
	 b42/AGvyOks8vNsG1z0YU9FkxNGZoxxRKWQsB62CbJIpdRuUpoJqzupYR7sp61Q3VA
	 Mjit37fJgjK81zuHiRg224wvS+86quWEdE96n0V91Y+sQ+DKgth1l65NNrcikIR+LF
	 DGMHYIeERWolzIuYGTa8nzGaTOe2awn1zT9AifY2usyffrA5NuOozf++ndzd+HD0F9
	 STyCdvwEVfkwO5Kbl21s1kMGiCnA6HfTwX3q870GoJKcaP1yHlWXX7If9tQKJn2woq
	 fbQLv8U0AIgBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE993808200;
	Sat, 21 Mar 2026 01:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: macb: Fix two lock warnings when WOL is
 used
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405660804.2716872.14224968446088280176.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 01:30:08 +0000
References: <20260318-macb-irq-v2-0-f1179768ab24@gmail.com>
In-Reply-To: <20260318-macb-irq-v2-0-f1179768ab24@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vineeth.karumanchi@amd.com, harini.katakam@amd.com, theo.lebrun@bootlin.com,
 stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-227645-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D7A72E2C95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 14:36:57 +0800 you wrote:
> Hi,
> 
> This patch series addresses two lock warnings that occur when using WOL as a
> wakeup source on my AMD ZynqMP board.
> 
> ---
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> Cc: Harini Katakam <harini.katakam@amd.com>
> Cc: Théo Lebrun <theo.lebrun@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: macb: Move devm_{free,request}_irq() out of spin lock area
    https://git.kernel.org/netdev/net/c/317e49358ebb
  - [net,v2,2/2] net: macb: Protect access to net_device::ip_ptr with RCU lock
    https://git.kernel.org/netdev/net/c/baa35a698cea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



