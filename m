Return-Path: <stable+bounces-219900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wm9VNr0PoWlDqAQAu9opvQ
	(envelope-from <stable+bounces-219900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:30:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAA01B242B
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C803300D9C7
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 03:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBCB328B76;
	Fri, 27 Feb 2026 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNft+ry0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB8A329361;
	Fri, 27 Feb 2026 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163001; cv=none; b=h7pZOf41hJgEpnHRLQ45fpj/yJr+ZfJ8L5RO3VFNhFb6W23kkMufBHljGp+KHIr224cTf56JdkTA3JtWcQitDn6R74UNLEPXA/6ao9fdYSc4Vdh3nif/wYEa+Y4hUoN7ciUh4zixj9Ks6KNfYDHdpGaJay2lh9CT0uB/AC4MAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163001; c=relaxed/simple;
	bh=iiOwXb8uVifSZ7PySOcOmZe1Jp2tN1bt6v5sZO3UzmM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MADAPQSWEH6VLNH2m65njiSFmWSHkuHsTaxtpXofMMfkinBu++2gM1rD9Bagk2dFOzaOlDtGXUd+ebOFtTahW2K9DIk5qHStjOC3AULOMMgNe7cUAZ+dkz6nnqwAzYnfsUwudyBAmzPkretzdJokiTdzi2QOYwsRQNhQSGtoyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNft+ry0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F109EC19423;
	Fri, 27 Feb 2026 03:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772163001;
	bh=iiOwXb8uVifSZ7PySOcOmZe1Jp2tN1bt6v5sZO3UzmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bNft+ry00BO5EctoGu/4PmXQQ86TgRcDmWzuolyeWHWAhmBMewxuGH3u7cbn7Iy2j
	 LHrz9OM8PqFS2eZMNfVhLYkDTaVwatUHrYSuoU/z+xNNK36iTGavzwvQI+sUb0Jh9A
	 77JHtLwLPJO488k/5YUsBq4eMtDS0f+DS2tjBaJjMDMkT4dRpb+b35rqD0H2K5QLxc
	 Uv2jyAsB2vKScYj1VszyfeOvQJFAjmhMTLPdbT2D+ZX6S8xo9hyR1nYMX4sfu+zKvC
	 BGxsH6VzL3qa9ERcV7G6Fc4BcFVPBrKkGRuKPIIMrkCQOTBs4YyQSb6PuT1JKYwWil
	 njZyfXKeLxDsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE81393109B;
	Fri, 27 Feb 2026 03:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] batman-adv: Avoid double-rtnl_lock ELP metric
 worker
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177216300504.1958105.15758262442071363378.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 03:30:05 +0000
References: <20260225084614.229077-2-sw@simonwunderlich.de>
In-Reply-To: <20260225084614.229077-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org,
 github@grische.xyz, freifunk_nordm4nn@gmx.de
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,vger.kernel.org,lists.open-mesh.org,narfation.org,grische.xyz,gmx.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219900-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,simonwunderlich.de:email]
X-Rspamd-Queue-Id: 3AAA01B242B
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Wed, 25 Feb 2026 09:46:14 +0100 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> batadv_v_elp_get_throughput() might be called when the RTNL lock is already
> held. This could be problematic when the work queue item is cancelled via
> cancel_delayed_work_sync() in batadv_v_elp_iface_disable(). In this case,
> an rtnl_lock() would cause a deadlock.
> 
> [...]

Here is the summary with links:
  - [net,1/1] batman-adv: Avoid double-rtnl_lock ELP metric worker
    https://git.kernel.org/netdev/net/c/cfc83a3c7151

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



