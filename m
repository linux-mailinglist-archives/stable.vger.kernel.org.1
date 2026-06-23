Return-Path: <stable+bounces-267829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1HcsEfzVOWoqyAcAu9opvQ
	(envelope-from <stable+bounces-267829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 02:40:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7706B302D
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 02:40:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bjdBRNag;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267829-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267829-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CA653038C66
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 00:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6560A384CC8;
	Tue, 23 Jun 2026 00:40:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D174384254;
	Tue, 23 Jun 2026 00:40:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782175219; cv=none; b=idDBCjjzKTb4L8Jgws58RwD6i+jXapxPGeih6NzCda3aIpLgcqHlhRkSnsxoXVd7dnd2kGOcnDcbDw5Q4Ycv2hSlqoXAnvCCsKJq9yvuocNWWhp/HRBBYIfKNeZTSdBSrvIchcNAYrYyuYfNWfp7VOhEzSArQFlRbAu5LDiy13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782175219; c=relaxed/simple;
	bh=jR+8piwKKC18zByzQZJ8iz2QHs5Ule5av7qKhfUfMH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f6oS18P4OtEoq175FOnwJY+B+VZ1GCVbDx80tXoFrP80nlJY8cRhj3FsKIuhg3g8Uy1Op2uREgXbUKfe1n3WoBmwqbxs3Q98fgujE/krysnnP0dMBm0qs+hIAvZy8Xy8fkZmiC5j3nz9hIctm1YdrpPpcjglv/oJApPRrJuHQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjdBRNag; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6044F1F000E9;
	Tue, 23 Jun 2026 00:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782175217;
	bh=7WwV7C+/RLdDadamoZpqAbgcBr1uPP2MLzfTS8DLY5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bjdBRNaguj22PXjdacq/w3hYWxHJgbesC81IPiW8FGBjN9WHlCL0PDHIDRjpCrOZj
	 OMUiCwPqFi0UYz1sZPSX2aaGBsl0PRDJdXiymFUTLnsNfobvs6HjWcii1Y/Ghqz5QK
	 WYHlwMxHQ0Gmuh7rZr47pIsAOdoXNnZD3M5QZhVHVCsbmhax7aoPNWYv/S8lr6jL3w
	 kp0SiI+DN6xZg+Gk8mqkxbju9tzoiZgBKi5zpvv3+e9NGvOumh5/QZQ7BYc7ofsY+f
	 va56l+1DMJ655GupUq4KFdQf9lfODVQKX/pAqhLg6JxlTMK7szoY+1XxYFKAb2QdKy
	 VELpMfsq0/S0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B14393098A;
	Tue, 23 Jun 2026 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: ti: icssg: guard PA stat lookups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178217520750.1479120.9274219966916752634.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 00:40:07 +0000
References: <20260618093037.3448858-1-dev@pschenker.ch>
In-Reply-To: <20260618093037.3448858-1-dev@pschenker.ch>
To: Philippe Schenker <dev@pschenker.ch>
Cc: netdev@vger.kernel.org, philippe.schenker@impulsing.ch, horms@kernel.org,
 danishanwar@ti.com, rogerq@kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org, andrew+netdev@lunn.ch, devnexen@gmail.com,
 davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
 kuba@kernel.org, haokexin@gmail.com, m-malladi@ti.com, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,impulsing.ch,kernel.org,ti.com,lists.infradead.org,lunn.ch,gmail.com,davemloft.net,google.com,intel.com,redhat.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267829-lists,stable=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dev@pschenker.ch,m:netdev@vger.kernel.org,m:philippe.schenker@impulsing.ch,m:horms@kernel.org,m:danishanwar@ti.com,m:rogerq@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:andrew+netdev@lunn.ch,m:devnexen@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:haokexin@gmail.com,m:m-malladi@ti.com,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,impulsing.ch:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E7706B302D

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jun 2026 11:30:24 +0200 you wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> icssg_ndo_get_stats64() unconditionally calls emac_get_stat_by_name()
> with FW PA stat names regardless of whether the PA stats block is
> present on the hardware.  emac_get_stat_by_name() already guards the
> PA stats lookup with `if (emac->prueth->pa_stats)`; when that pointer
> is NULL the lookup falls through to netdev_err() and returns -EINVAL.
> Because ndo_get_stats64 is polled regularly by the networking stack
> this produces thousands of log entries of the form:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: ti: icssg: guard PA stat lookups
    https://git.kernel.org/netdev/net/c/27b9daba5060

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



