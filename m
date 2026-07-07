Return-Path: <stable+bounces-272401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FkujJiDTTGpxqQEAu9opvQ
	(envelope-from <stable+bounces-272401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 12:21:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3487971A44B
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 12:21:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W2UHv+lZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272401-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272401-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E687830438B7
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 10:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4C03DFC84;
	Tue,  7 Jul 2026 10:20:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884A3DEADC;
	Tue,  7 Jul 2026 10:20:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419628; cv=none; b=BN7C0KOQes0Os5NOEd4+Qlaq3xcjks2AL6MDbG11Z1a62VEi25jdoowhKCX6ew62ZGFY0OFCXFN66WHH39CjW9ElSLH09iqr+N+xqvqWxYgi4qDMUsQmz2oG2flNjSFvuxUol2CSONxSTB5brj1xZr3s7OYQ9sswyU8dRAW087k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419628; c=relaxed/simple;
	bh=BF6QHr9IERaxUJGLyi9UfdrrpYkPazFlm84hoewfZKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oIYRGAnLAN0eIFcsnmuPxiw9qDMQdl+qXyS8s8NExee0B+5IbNq3qDurk2q6eMfM/K8uz24uRR+SjNwonk5v5lKKvclCSzrxNtXAWYObMmFp5Gxac3AJj/Ivsy/b6FIsSdpZyQO0ImTb8CqRBQG5Opgl6Xx4vbI928Je93NXse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2UHv+lZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E741F00A3A;
	Tue,  7 Jul 2026 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783419625;
	bh=/1C4Wt0mf4QAVu/tAVPWfuZuAk6WIVrygpQsGGgS53U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W2UHv+lZX4WabMkk1QFfDq1bxiy1rEme1FiQ2AHaHi5cAW2znbCbCqv8eF7gINECr
	 mVNENRF7qTIxSsIugtYJoCtlc0AMfBLRArSZIk281oZ/uPvENh8ZfGd6CYen+UNd1H
	 pT2w8JJwytCAx483S/M9v913EmoTEGs4tKHbDeMTEpJvFN4dcCSirbxIF6K/5wdQoN
	 4TzxqcjwJ7qonh81QXzEfi0s95eS5EviYM3AJxtT88xh+bju2Lv4jsKGYyyw2YqyKA
	 7Z0g22E2hxz6AyooxoCSmBMHrvWAZXM0NtF11fYGOG56rW/nyIB0SppIAGIFOSR044
	 Rc3FVZD2V/C+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198883925475;
	Tue,  7 Jul 2026 10:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ipv4: igmp: remove multicast group from hash table
 on
 device destruction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178341960589.1475811.13391372946000599222.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 10:20:05 +0000
References: <20260701235014.73505-1-yuyanghuang@google.com>
In-Reply-To: <20260701235014.73505-1-yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: davem@davemloft.net, xiyou.wangcong@gmail.com, dsahern@kernel.org,
 edumazet@google.com, idosch@nvidia.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,google.com,nvidia.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272401-lists,stable=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:xiyou.wangcong@gmail.com,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3487971A44B

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  2 Jul 2026 08:50:14 +0900 you wrote:
> When a device is destroyed under RTNL, ip_mc_destroy_dev() iterates through
> the multicast list and calls ip_ma_put() on each membership, scheduling
> them for RCU reclamation. However, they are not unlinked from the device's
> multicast hash table (mc_hash).
> 
> Since the device remains published in dev->ip_ptr until after
> ip_mc_destroy_dev() completes, concurrent RCU readers traversing mc_hash
> can still locate and access the multicast group after its refcount is
> decremented. If the RCU callback runs and frees the group while a reader is
> accessing it, a use-after-free occurs.
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv4: igmp: remove multicast group from hash table on device destruction
    https://git.kernel.org/netdev/net/c/7993211bde16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



