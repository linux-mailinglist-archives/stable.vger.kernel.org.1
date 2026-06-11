Return-Path: <stable+bounces-262824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x2WjEeI7K2oA4wMAu9opvQ
	(envelope-from <stable+bounces-262824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 00:51:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990C7675B3F
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 00:51:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G63+Ss0v;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262824-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262824-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B1F33148D42
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 22:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D26F4BC024;
	Thu, 11 Jun 2026 22:50:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED67D38E8D0;
	Thu, 11 Jun 2026 22:50:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218235; cv=none; b=CMYh/cEm5QyYVuNWxPIZzorTwl30gVMhD4/EMW/4+zDqRooBeW88lYCtdJiJTg7XIwC37VS2aPH0ZAypFT5LDiI4BRqIRmWqNgUkBU/7cgR8iApP6XtBfDFPxpre3JEJEtuPs5aunNIYCEu82C/je/Sx1mHbUkngFW1QAw1kgUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218235; c=relaxed/simple;
	bh=TyNX+oJc/MFzFuxAGt/IUzK+asDmWADNvzEqvgAfhbQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NBsx6HpfWpKYjvj4a/qCpgjxOh3jYPGdNXnXpDe1Yyy/AwlAcwGnixdPNxGjowx8xVXq2geGyczwyLjGZvrPlhv9HVKXntBogS7GFn3iDNPbAkgNRmm/N1y1SFZEjFtRaWPA6mMwRhnPl7dzz+m6AZDoUZ9Bn+FJukCEb6fp8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G63+Ss0v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1E81F00A3A;
	Thu, 11 Jun 2026 22:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781218232;
	bh=G3sIlCr+rOPD9zI4jT1mrmwCd8/1/QyIAfXHZsN8XTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G63+Ss0vyBhAJx/JJId/1dHYeFdIa7okyK3Hx0OTR7UynO+FfYuZxVnDvUSW5h9nu
	 n0dQ9Zh3JOnBRcWewKrm4AuBQa6sEzPMf7MK0K72nugGpbfet+nu/NezzXLlpa09LT
	 wFBcGp0uYpQ70gjG75IxMmSy8P0w6UO3J42OShSAYmTHfw7kMUCEhjKefZGCRV938y
	 njnsMzQ/pZdZM8CVInqvYPuhecufwWF3Y9TGmRM4IJlJQwWQJ5ZCZ5LaxlfhMZQiFe
	 yyqLFqSKu8r6OLHsKQaPaDTS/L4D7O54+FQ1/NPR7nqSCWWuZEqv2noazo7AQb/Pc7
	 dbs6OV2XW9Ggw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B7A3930FB3;
	Thu, 11 Jun 2026 22:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: bcmgenet: convert RX path to page_pool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121822938.394849.1162071638339486124.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:50:29 +0000
References: <20260610114835.2225423-1-nb@tipi-net.de>
In-Reply-To: <20260610114835.2225423-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 justin.chen@broadcom.com, phil@raspberrypi.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,raspberrypi.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262824-lists,stable=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:justin.chen@broadcom.com,m:phil@raspberrypi.com,m:bcm-kernel-feedback-list@broadcom.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 990C7675B3F

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 13:48:35 +0200 you wrote:
> Replace the per-packet __netdev_alloc_skb() + dma_map_single() in the
> RX path with page_pool. SKBs are built from pool pages via
> napi_build_skb() with skb_mark_for_recycle() so the network stack
> returns pages to the pool, and DMA mapping happens once per page
> instead of once per packet.
> 
> Reject HW-reported lengths smaller than the RSB so a runt cannot
> underflow the SKB build path.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: bcmgenet: convert RX path to page_pool
    https://git.kernel.org/netdev/net-next/c/7bc054c2d4ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



